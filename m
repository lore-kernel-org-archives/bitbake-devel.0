Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3272.1794508277095258290
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Nov 2026 10:31:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=u5d1fYyQ;
 spf=pass (domain: gmail.com, ip: 209.85.208.173, mailfrom: damianfalkowski9@gmail.com)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3ab3b29a1d4so449631fa.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 12 Nov 2026 10:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794508275; x=1795113075; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qhz2GWlJ98deD96fUoB0o+F9M3ddS6pZ0/UmahXXvUE=;
        b=u5d1fYyQJdP2V5N0KIzYFpNSZCcO1VN+mii5jfHlIOVaSFgKX8WBrU1+cc59ux9u00
         BhzFLd72KBlSobofH4soLeAXE2VYjskZI1ywM6N7ewNu8+FjHyYqREJwNxk/e5pX1/hu
         eeIttuvE3TP3YsuJm/v/JBdBCRI3zLBhOLcJdwKP6QNeaA4Ui8b0Tg9KDOG/NN5jnV2s
         Rbq6I3Uc1mWRxMKBqvMncgVP8tk0p6ZmHNnhnYJPybnXSFPMOcjqQKQcuQ1MVPmkxwD1
         icC7Vz95oFe5KG19mwaPLb65vG9qCcvHosAs4rnPbwy/aVRpENWMljQR8iAh6LVBulfc
         XKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794508275; x=1795113075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Qhz2GWlJ98deD96fUoB0o+F9M3ddS6pZ0/UmahXXvUE=;
        b=feZ8+VT9yoL1Xg58goDQ8qymcDJPQOfCRkkhHZ1/TKqflg2l4UHNTLFsk75Pgz94s1
         cdI8Y5hf+sjiMzkvqOiZ6bqOC8maIY1X6ocnU0WKgKOlrOp9FZHvpNlKmI6jqb1NojTu
         7M+ZUDmZZB/uDrpKmPE7x7PQmaYiDuulLFIluggrfqTBWVV9jAG9NFo8Z5crNPXCy4+d
         TdINEPf8yas3eWtPgWhPUXbg+i0dXfcqF7dCzAr/ffOhneJMKAz89VXWV7wdUpbn2F9z
         l9u/FFSc893LdspxB4QMwHJgLNUlaUQxEoAujAGD5KdfzAtcs/EWxGXZaNKOKBOvQMA+
         p1jA==
X-Gm-Message-State: APuU4Z/ec7u+oNar/cbkfqeVQ3eNCrz8LHmdfE43pOpDk1YsvTQwnF90
	knWKGEBlkrbe29t/B+CTL1IZ8fv8+0PQwZilC0JOrgjUDelSLniENC+EdUN8ZQYQqIXqEQ==
X-Gm-Gg: AYBFou3EnBBkKmeb3JjdPa9lIpljiMXNEShtLxae/jTey+/JZuINP2Q1qyAGxdyUt1G
	dhJ2QSjv5RHY8OZAvil7NpCTMWvJzqVCBYaZQLRrrgH/rhBH4evavRAZjSPzGDMfBfktlwxRcRc
	XtnRAa7KxFKJWVOQcT/lBhS/IgjGyxXb1wfPDceswMFgZYz+6GFhrTt+HrGJ+LoUdCQZdkTUAHa
	hmgJNbu16K5hp02bjMbods/2U0lEetQk3KR2C5pjI6puGSKQI0UtGp42i3RvTJTHKQsV+HLcQhM
	dmJGDFjlXGLc5cGGe641ziVJ7QKIrXWDFh6Z9FRex7eMgTlU2qTMVkjKKQ11XD77ASxIAw53Vco
	vx+ByhYKQoSarvnvaHgdorx5ZEejA7+kv/wt2mfr1CfpY62XJo51dMvRXQjfkwkX+fLNzLlwUkQ
	dFTR7aenLl/+CMii/LvYqeGqPLHKLzs8eQUpjKr/qlI40h9pkP4KyH8VOcHmDlrBKK4KN6k9Qlc
	aeMePrtO4QyUojz6vvsQIhIjwh7lznrxZ64Z8OAu5qWDx/tD3zotPg4bSFlaOsl5ve32+qk46Kw
	sfkL0oNr77kkrbVFr73ylzAAd2G+/BsMS3lvQyP/SOAuQqfVoZSjwI13K7EeWmVG8A6omvgtvgx
	w0iyeyaQM6CCUMTt9BMJgknpnEKxKJ7G5kTvovXC9elgo9wEOHxf3qOd59tOvU3DCxZg6dEc0lX
	UPOyEvrqbbgC3s+Q==
X-Received: by 2002:a05:651c:a328:b0:3ab:540b:f49f with SMTP id 38308e7fff4ca-3ae2b531484mr1164361fa.26.1794508274413;
        Thu, 12 Nov 2026 10:31:14 -0800 (PST)
Return-Path: <damianfalkowski9@gmail.com>
Received: from wrlinb202.emea.nsn-net.net ([131.228.2.15])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae2b7aebd1sm932001fa.29.2026.11.12.10.31.12
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 10:31:13 -0800 (PST)
From: Damian Falkowski <damianfalkowski9@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch/git: Remove the LFS worktree when git lfs fetch fails
Date: Thu, 12 Nov 2026 19:31:11 +0100
Message-Id: <20261112183111.3425042-1-damianfalkowski9@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Thu, 12 Nov 2026 18:31:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20427
Content-Type: text/plain; charset="utf-8"

Since commit d369bfd8e5b4 ("fetch2: Raise on git lfs fetch failures"), a
failing "git lfs fetch" raises before the temporary "wt" worktree is
removed. The worktree stays in the clone directory in DL_DIR, and every
later fetch of the same repository fails at "git worktree add" with
"fatal: 'wt' already exists" until someone deletes it by hand. A single
temporary error from the LFS server, such as a short outage of its
backing storage, thus breaks the download directory for good.

Remove the worktree also when "git lfs fetch" fails, and add a test
that fetches again after a failed LFS fetch.

AI-Generated: Cursor, Claude Opus 5.5
Signed-off-by: Damian Falkowski <damianfalkowski9@gmail.com>
---
 lib/bb/fetch/git.py   |  6 ++++--
 lib/bb/tests/fetch.py | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch/git.py b/lib/bb/fetch/git.py
index dc1b31b58..75ce1eda0 100644
--- a/lib/bb/fetch/git.py
+++ b/lib/bb/fetch/git.py
@@ -509,9 +509,11 @@ class Git(FetchMethod):
             lfs_fetch_cmd = ud.basecmd + ['lfs', 'fetch']
             if fetchall:
                 lfs_fetch_cmd.append('--all')
-            runfetchcmd(lfs_fetch_cmd, d, log=progresshandler, workdir=(clonedir + "/wt"))
             worktree_rem_cmd = ud.basecmd + ['worktree', 'remove', '-f', 'wt']
-            runfetchcmd(worktree_rem_cmd, d, log=progresshandler, workdir=clonedir)
+            try:
+                runfetchcmd(lfs_fetch_cmd, d, log=progresshandler, workdir=(clonedir + "/wt"))
+            finally:
+                runfetchcmd(worktree_rem_cmd, d, log=progresshandler, workdir=clonedir)
 
 
     @contextmanager
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 0f29cdf11..7c93a6cbe 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2872,6 +2872,27 @@ class GitLfsTest(FetcherTest):
         with self.assertRaises(bb.fetch.FetchError):
             self.fetch()
 
+    @skipIfNoGitLFS()
+    def test_lfs_fetch_retry_after_failure(self):
+        """Test that a failed LFS fetch does not break later fetches of the same repository"""
+        self.git(["lfs", "install", "--local"], cwd=self.srcdir)
+        self.commit_file("a.mp3", "version 1")
+
+        uri = 'git://%s;protocol=file;lfs=1;branch=master' % self.srcdir
+        self.d.setVar('SRC_URI', uri)
+
+        lfs_objects = os.path.join(self.srcdir, ".git", "lfs", "objects")
+        with hide_directory(lfs_objects):
+            with self.assertRaises(bb.fetch.FetchError):
+                self.fetch()
+
+        fetcher, ud = self.fetch()
+        with hide_directory(self.srcdir):
+            workdir = self.d.getVar('WORKDIR')
+            fetcher.unpack(workdir)
+            with open(os.path.join(workdir, "git", "a.mp3")) as f:
+                self.assertEqual(f.read(), "version 1")
+
 class GitURLWithSpacesTest(FetcherTest):
     test_git_urls = {
         "git://tfs-example.org:22/tfs/example%20path/example.git;branch=master" : {

