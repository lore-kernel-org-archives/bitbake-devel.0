Return-Path: <kergoth@gmail.com>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
	[209.85.192.193])
	by mail.openembedded.org (Postfix) with ESMTP id E8D2C7300D
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Mar 2017 18:41:12 +0000 (UTC)
Received: by mail-pf0-f193.google.com with SMTP id o126so23313368pfb.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Mar 2017 11:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=EhyjMc4FVldVAfBQHrHK/28mK8g/s+wDj5O2RntL7hs=;
	b=SH49CD2kHlbHi05Lk90wJkWkVU1UBfvPtkkH3mw7rDOSST5cX2r6VYqnwLOJww7wqX
	3+xfO5ggegOV7z2B6JRmXvgNCnHN905g+jOJs0beHO4KXqskaQ9inNb24oh54i3V5c0Z
	ogU0+1J4vhN8GK3QJ3HwoQtOorD++f35AgfCahPSvPekHT5a0IVudJgHdfZDuiGBhyl4
	w+R9avTOe2zDrPye4fwu7Oyr3//FcqNo3yWPSOQr4qcbcTxvnKmY1/GUqKjDyQnlcZ26
	CAVMHIviFsQrBwiiJV0QXNsRglhElHu3nSwu+xAPu0cqf55U7kPKHcgd4hQCrIrer15C
	UU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=EhyjMc4FVldVAfBQHrHK/28mK8g/s+wDj5O2RntL7hs=;
	b=X6RZ2mFwWHV+qZA5a2Ak9IR2nmBKac0tGH4k/IPAm/vIFgwImxe4sqQ6EVXPG5eVtD
	4M4Xzk4UmGuJR2OUxUMy92piqfKMgbAK0X0NGKgawyPoeupm1s5vnzA3sqM8KTuOpVwQ
	LeUI5sUOVytr0i8g6dUpD1GFVjo2W2gOAZK7te7S7cTdfUqZQAeYLU35KSNanTBI45m3
	PotD7Ytha0vNpIAf+tUd/sYJg3nbWUZHGXT5wdIkjo8yERUAh9Z4LcAWONIDjV7BgfR6
	Yn16awuLyhpTlrADIMLhXoZVyDHnwi5kgpslYeHgIB8gtC7HYxbY4aiY1gQNcHYstiob
	kOfA==
X-Gm-Message-State: AFeK/H2DOZMaf1ClOsfRFJbgPvcFMOKMeqAAaHYEblWEHmQK3/nLgHymKdjcZOA4qXyb6A==
X-Received: by 10.84.241.69 with SMTP id u5mr49773335plm.107.1490121674110;
	Tue, 21 Mar 2017 11:41:14 -0700 (PDT)
Received: from quark.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	z19sm25324304pfd.81.2017.03.21.11.41.12
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 21 Mar 2017 11:41:13 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 21 Mar 2017 11:41:02 -0700
Message-Id: <831da718a130c7900786659a8791b6d32311d046.1490121529.git.chris_larson@mentor.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <cover.1490121529.git.chris_larson@mentor.com>
References: <cover.1490121529.git.chris_larson@mentor.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH 2/4] fetch/git: kill pointless quotes around single % args
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
X-List-Received-Date: Tue, 21 Mar 2017 18:41:13 -0000

From: Christopher Larson <chris_larson@mentor.com>

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/fetch2/git.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index bbd302e..e1e8765 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -205,7 +205,7 @@ class Git(FetchMethod):
         if ud.rebaseable:
             for name in ud.names:
                 gitsrcname = gitsrcname + '_' + ud.revisions[name]
-        ud.mirrortarball = 'git2_%s.tar.gz' % (gitsrcname)
+        ud.mirrortarball = 'git2_%s.tar.gz' % gitsrcname
         ud.fullmirror = os.path.join(d.getVar("DL_DIR"), ud.mirrortarball)
         gitdir = d.getVar("GITDIR") or (d.getVar("DL_DIR") + "/git2/")
         ud.clonedir = os.path.join(gitdir, gitsrcname)
@@ -240,7 +240,7 @@ class Git(FetchMethod):
         # If the checkout doesn't exist and the mirror tarball does, extract it
         if not os.path.exists(ud.clonedir) and os.path.exists(ud.fullmirror):
             bb.utils.mkdirhier(ud.clonedir)
-            runfetchcmd("tar -xzf %s" % (ud.fullmirror), d, workdir=ud.clonedir)
+            runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=ud.clonedir)
 
         repourl = self._get_repo_url(ud)
 
@@ -292,14 +292,14 @@ class Git(FetchMethod):
 
             logger.info("Creating tarball of git repository")
             runfetchcmd("tar -czf %s %s" % (ud.fullmirror, os.path.join(".") ), d, workdir=ud.clonedir)
-            runfetchcmd("touch %s.done" % (ud.fullmirror), d, workdir=ud.clonedir)
+            runfetchcmd("touch %s.done" % ud.fullmirror, d, workdir=ud.clonedir)
 
     def unpack(self, ud, destdir, d):
         """ unpack the downloaded src to destdir"""
 
         subdir = ud.parm.get("subpath", "")
         if subdir != "":
-            readpathspec = ":%s" % (subdir)
+            readpathspec = ":%s" % subdir
             def_destsuffix = "%s/" % os.path.basename(subdir.rstrip('/'))
         else:
             readpathspec = ""
@@ -469,7 +469,7 @@ class Git(FetchMethod):
             if not os.path.exists(rev_file) or not os.path.getsize(rev_file):
                 from pipes import quote
                 commits = bb.fetch2.runfetchcmd(
-                        "git rev-list %s -- | wc -l" % (quote(rev)),
+                        "git rev-list %s -- | wc -l" % quote(rev),
                         d, quiet=True).strip().lstrip('0')
                 if commits:
                     open(rev_file, "w").write("%d\n" % int(commits))
-- 
2.8.0


