Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA702C433EF
	for <webhook@archiver.kernel.org>; Mon, 25 Oct 2021 14:16:04 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by mx.groups.io with SMTP id smtpd.web10.32590.1635171363549075253
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Oct 2021 07:16:04 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 192.55.52.136, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10147"; a="209759026"
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800";
   d="scan'208";a="209759026"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2021 07:16:03 -0700
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800";
   d="scan'208";a="634754748"
Received: from syong7-mobl1.gar.corp.intel.com (HELO
 anmitta2-mobl1.gar.corp.intel.com) ([10.249.78.45])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2021 07:16:02 -0700
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 1/9] fetch2/git: Avoid races over mirror tarball
 creation
Date: Mon, 25 Oct 2021 22:15:48 +0800
Message-Id: 
 <2bba08374f780d14a547a123ea3659ad298a425e.1635171215.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1635171215.git.anuj.mittal@intel.com>
References: <cover.1635171215.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Oct 2021 14:16:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12818

From: Richard Purdie <richard.purdie@linuxfoundation.org>

There is a potential race over the mirror tarballs where a partial git repo
could be extracted causing fetcher failures if the tarball is being rewritten
whilst another build accesses it.

Create the mirror tarball atomically to avoid this.

[YOCTO #14441]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 3250bc950c56bd7dd2114df26e5a8e13b04ceac8)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/fetch2/git.py | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index cf7424ebf..95cd971d5 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -68,6 +68,7 @@ import subprocess
 import tempfile
 import bb
 import bb.progress
+from contextlib import contextmanager
 from   bb.fetch2 import FetchMethod
 from   bb.fetch2 import runfetchcmd
 from   bb.fetch2 import logger
@@ -414,6 +415,20 @@ class Git(FetchMethod):
                 bb.utils.remove(tmpdir, recurse=True)
 
     def build_mirror_data(self, ud, d):
+
+        # Create as a temp file and move atomically into position to avoid races
+        @contextmanager
+        def create_atomic(filename, d):
+            fd, tfile = tempfile.mkstemp(dir=os.path.dirname(filename))
+            try:
+                yield tfile
+                umask = os.umask(0o666)
+                os.umask(umask)
+                os.chmod(tfile, (0o666 & ~umask))
+                runfetchcmd("mv %s %s" % (tfile, filename), d)
+            finally:
+                os.close(fd)
+
         if ud.shallow and ud.write_shallow_tarballs:
             if not os.path.exists(ud.fullshallow):
                 if os.path.islink(ud.fullshallow):
@@ -424,7 +439,8 @@ class Git(FetchMethod):
                     self.clone_shallow_local(ud, shallowclone, d)
 
                     logger.info("Creating tarball of git repository")
-                    runfetchcmd("tar -czf %s ." % ud.fullshallow, d, workdir=shallowclone)
+                    with create_atomic(ud.fullshallow, d) as tfile:
+                        runfetchcmd("tar -czf %s ." % tfile, d, workdir=shallowclone)
                     runfetchcmd("touch %s.done" % ud.fullshallow, d)
                 finally:
                     bb.utils.remove(tempdir, recurse=True)
@@ -433,7 +449,8 @@ class Git(FetchMethod):
                 os.unlink(ud.fullmirror)
 
             logger.info("Creating tarball of git repository")
-            runfetchcmd("tar -czf %s ." % ud.fullmirror, d, workdir=ud.clonedir)
+            with create_atomic(ud.fullmirror, d) as tfile:
+                runfetchcmd("tar -czf %s ." % tfile, d, workdir=ud.clonedir)
             runfetchcmd("touch %s.done" % ud.fullmirror, d)
 
     def clone_shallow_local(self, ud, dest, d):
-- 
2.31.1


