Return-Path: <kergoth@gmail.com>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
	[209.85.220.42])
	by mail.openembedded.org (Postfix) with ESMTP id 687C16E630
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 Sep 2015 21:20:57 +0000 (UTC)
Received: by pacex6 with SMTP id ex6so187387306pac.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 Sep 2015 14:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=H1LJf0KrOcU3JGofnkSzzENlzf2OR+UkTDWd022hk+I=;
	b=g6ruryWzfpZs4KklaC0KBWSwadn8MXQB2W9xd5pQQktqmhQ7vIMAcWgozg31CEBvY1
	i9xUBNsgtNAmI6V6Ro3vWVC9Cp/MbEj8JYTRNY9DHY6rSow5pcwUlzrloZstH7Q2wLOx
	4ZsjAy1DbbyBgHQdQ5Nsfn/N4pyt3K3dY0wwf7CDKf4JmjFosDQEkmUzV3HWMoeSp0sV
	6yCaJIFbBPS+8zAgECMOyL8HE6w3FoWUzgfzI3f4NqRRFD+81t1MJN2oo1vV6oulbmj5
	gAvfDt2yXvMjrbRKXuXmgpP/Og9z4KV8zKY+VyAt8tFbHgyLRA2LU6WQx7eTYNausKhT
	HNpw==
X-Received: by 10.67.15.66 with SMTP id fm2mr51604268pad.82.1442352057561;
	Tue, 15 Sep 2015 14:20:57 -0700 (PDT)
Received: from quark.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	xv12sm23893091pac.38.2015.09.15.14.20.55
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 15 Sep 2015 14:20:55 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 15 Sep 2015 14:23:01 -0700
Message-Id: <1442352181-9304-1-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 2.2.1
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCHv2] bb.fetch2.{git, hg}: remove tarball if it needs updating
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 15 Sep 2015 21:20:59 -0000

From: Christopher Larson <chris_larson@mentor.com>

We were maintaining state in the form of ud.repochanged to determine whether
we need to write the tarball in the case where the tarball already exists, but
this state is maintained only in memory. If we need to update the git repo,
set ud.repochanged to True, and then are interrupted or killed, the tarball
will then be out of date.

Rather than maintaining this state, simply remove the out of date tarball when
we update the git repo, and it will be re-created with updated content in
build_mirror_data.

[YOCTO #6366]

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 bitbake/lib/bb/fetch2/git.py | 11 +++++++----
 bitbake/lib/bb/fetch2/hg.py  | 11 +++++++----
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 40658ff..9727041 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -181,8 +181,6 @@ class Git(FetchMethod):
     def download(self, ud, d):
         """Fetch url"""
 
-        ud.repochanged = not os.path.exists(ud.fullmirror)
-
         # If the checkout doesn't exist and the mirror tarball does, extract it
         if not os.path.exists(ud.clonedir) and os.path.exists(ud.fullmirror):
             bb.utils.mkdirhier(ud.clonedir)
@@ -220,7 +218,12 @@ class Git(FetchMethod):
             runfetchcmd(fetch_cmd, d)
             runfetchcmd("%s prune-packed" % ud.basecmd, d)
             runfetchcmd("%s pack-redundant --all | xargs -r rm" % ud.basecmd, d)
-            ud.repochanged = True
+            if ud.write_tarballs:
+                try:
+                    os.unlink(ud.fullmirror)
+                except OSError as exc:
+                    if exc.errno != errno.ENOENT:
+                        raise
         os.chdir(ud.clonedir)
         for name in ud.names:
             if not self._contains_ref(ud, d, name):
@@ -228,7 +231,7 @@ class Git(FetchMethod):
 
     def build_mirror_data(self, ud, d):
         # Generate a mirror tarball if needed
-        if ud.write_tarballs and (ud.repochanged or not os.path.exists(ud.fullmirror)):
+        if ud.write_tarballs and not os.path.exists(ud.fullmirror):
             # it's possible that this symlink points to read-only filesystem with PREMIRROR
             if os.path.islink(ud.fullmirror):
                 os.unlink(ud.fullmirror)
diff --git a/bitbake/lib/bb/fetch2/hg.py b/bitbake/lib/bb/fetch2/hg.py
index d978630..c880db2 100644
--- a/bitbake/lib/bb/fetch2/hg.py
+++ b/bitbake/lib/bb/fetch2/hg.py
@@ -163,8 +163,6 @@ class Hg(FetchMethod):
     def download(self, ud, d):
         """Fetch url"""
 
-        ud.repochanged = not os.path.exists(ud.fullmirror)
-
         logger.debug(2, "Fetch: checking for module directory '" + ud.moddir + "'")
 
         # If the checkout doesn't exist and the mirror tarball does, extract it
@@ -189,7 +187,12 @@ class Hg(FetchMethod):
                 logger.debug(1, "Running %s", pullcmd)
                 bb.fetch2.check_network_access(d, pullcmd, ud.url)
                 runfetchcmd(pullcmd, d)
-                ud.repochanged = True
+                if ud.write_tarballs == "1":
+                    try:
+                        os.unlink(ud.fullmirror)
+                    except OSError as exc:
+                        if exc.errno != errno.ENOENT:
+                            raise
 
         # No source found, clone it.
         if not os.path.exists(ud.moddir):
@@ -238,7 +241,7 @@ class Hg(FetchMethod):
 
     def build_mirror_data(self, ud, d):
         # Generate a mirror tarball if needed
-        if ud.write_tarballs == "1" and (ud.repochanged or not os.path.exists(ud.fullmirror)):
+        if ud.write_tarballs == "1" and not os.path.exists(ud.fullmirror):
             # it's possible that this symlink points to read-only filesystem with PREMIRROR
             if os.path.islink(ud.fullmirror):
                 os.unlink(ud.fullmirror)
-- 
2.2.1


