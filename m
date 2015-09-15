Return-Path: <kergoth@gmail.com>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
	[209.85.220.44])
	by mail.openembedded.org (Postfix) with ESMTP id 07F016E630
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 Sep 2015 20:54:13 +0000 (UTC)
Received: by padhy16 with SMTP id hy16so186462791pad.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 Sep 2015 13:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=FLEP2smSz18Lec5mb5jFso1CoCG5sY5P3xxxTGW/j8s=;
	b=tyqkpNRxPbLLs5fy00IcwFDB6rjw++m+VCGO88XryWht8yZFUl0xAaevzQPy32kYGN
	fKxQop/+5+20FB4RSni7LuM7/48CjpoG4+9AqqukuZWchBH0mulwL0bWYtDiYNyP2h/0
	uuUAsSzH9Awr7pikPxWMgvdl/4UJxZcTqeK/tnqlonllIj+Dwj4Xj1HDvaNqCtJrEBBW
	WkdKGScXynUBdkYNqdUjxCMGcbxlwh7cm08UrNXhGvq/QoCFphTzQxs63Bni6ENxexeT
	t4wDSNm8T9Iv7GRa5VSFwdP+7l2qaPc510f+C3/pQodcUYVr/7Os9ZCcVkbRVWMURpvD
	7FEA==
X-Received: by 10.69.0.166 with SMTP id az6mr50644073pbd.168.1442350453366;
	Tue, 15 Sep 2015 13:54:13 -0700 (PDT)
Received: from quark.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	la4sm23698254pbc.76.2015.09.15.13.54.10
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 15 Sep 2015 13:54:11 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 15 Sep 2015 13:56:06 -0700
Message-Id: <1442350566-5583-1-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 2.2.1
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH] bb.fetch2.{git, hg}: remove tarball if it needs updating
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
X-List-Received-Date: Tue, 15 Sep 2015 20:54:14 -0000

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
 bitbake/lib/bb/fetch2/git.py | 10 ++++++----
 bitbake/lib/bb/fetch2/hg.py  | 10 ++++++----
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 40658ff..4a32a31 100644
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
@@ -220,7 +218,11 @@ class Git(FetchMethod):
             runfetchcmd(fetch_cmd, d)
             runfetchcmd("%s prune-packed" % ud.basecmd, d)
             runfetchcmd("%s pack-redundant --all | xargs -r rm" % ud.basecmd, d)
-            ud.repochanged = True
+            try:
+                os.unlink(ud.fullmirror)
+            except OSError as exc:
+                if exc.errno != errno.ENOENT:
+                    raise
         os.chdir(ud.clonedir)
         for name in ud.names:
             if not self._contains_ref(ud, d, name):
@@ -228,7 +230,7 @@ class Git(FetchMethod):
 
     def build_mirror_data(self, ud, d):
         # Generate a mirror tarball if needed
-        if ud.write_tarballs and (ud.repochanged or not os.path.exists(ud.fullmirror)):
+        if ud.write_tarballs and not os.path.exists(ud.fullmirror):
             # it's possible that this symlink points to read-only filesystem with PREMIRROR
             if os.path.islink(ud.fullmirror):
                 os.unlink(ud.fullmirror)
diff --git a/bitbake/lib/bb/fetch2/hg.py b/bitbake/lib/bb/fetch2/hg.py
index d978630..bbb4ed9 100644
--- a/bitbake/lib/bb/fetch2/hg.py
+++ b/bitbake/lib/bb/fetch2/hg.py
@@ -163,8 +163,6 @@ class Hg(FetchMethod):
     def download(self, ud, d):
         """Fetch url"""
 
-        ud.repochanged = not os.path.exists(ud.fullmirror)
-
         logger.debug(2, "Fetch: checking for module directory '" + ud.moddir + "'")
 
         # If the checkout doesn't exist and the mirror tarball does, extract it
@@ -189,7 +187,11 @@ class Hg(FetchMethod):
                 logger.debug(1, "Running %s", pullcmd)
                 bb.fetch2.check_network_access(d, pullcmd, ud.url)
                 runfetchcmd(pullcmd, d)
-                ud.repochanged = True
+                try:
+                    os.unlink(ud.fullmirror)
+                except OSError as exc:
+                    if exc.errno != errno.ENOENT:
+                        raise
 
         # No source found, clone it.
         if not os.path.exists(ud.moddir):
@@ -238,7 +240,7 @@ class Hg(FetchMethod):
 
     def build_mirror_data(self, ud, d):
         # Generate a mirror tarball if needed
-        if ud.write_tarballs == "1" and (ud.repochanged or not os.path.exists(ud.fullmirror)):
+        if ud.write_tarballs == "1" and not os.path.exists(ud.fullmirror):
             # it's possible that this symlink points to read-only filesystem with PREMIRROR
             if os.path.islink(ud.fullmirror):
                 os.unlink(ud.fullmirror)
-- 
2.2.1


