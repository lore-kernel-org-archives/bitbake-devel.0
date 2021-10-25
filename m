Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED83AC433EF
	for <webhook@archiver.kernel.org>; Mon, 25 Oct 2021 14:16:07 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by mx.groups.io with SMTP id smtpd.web10.32590.1635171363549075253
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Oct 2021 07:16:07 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 192.55.52.136, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10147"; a="209759042"
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800";
   d="scan'208";a="209759042"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2021 07:16:05 -0700
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800";
   d="scan'208";a="634754752"
Received: from syong7-mobl1.gar.corp.intel.com (HELO
 anmitta2-mobl1.gar.corp.intel.com) ([10.249.78.45])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2021 07:16:03 -0700
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 2/9] fetch2/git: Use os.rename instead of mv
Date: Mon, 25 Oct 2021 22:15:49 +0800
Message-Id: 
 <b48f21d3773adbcad8ee4d66ef6e345d99906f74.1635171215.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1635171215.git.anuj.mittal@intel.com>
References: <cover.1635171215.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Oct 2021 14:16:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12819

From: Richard Purdie <richard.purdie@linuxfoundation.org>

os.rename will overwrite the destination file if present so we can use this
instead of the process call overhead.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit b3cccaa6a896c41d8c9be5eebc327f726542d16b)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/fetch2/git.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 95cd971d5..00105183b 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -418,14 +418,14 @@ class Git(FetchMethod):
 
         # Create as a temp file and move atomically into position to avoid races
         @contextmanager
-        def create_atomic(filename, d):
+        def create_atomic(filename):
             fd, tfile = tempfile.mkstemp(dir=os.path.dirname(filename))
             try:
                 yield tfile
                 umask = os.umask(0o666)
                 os.umask(umask)
                 os.chmod(tfile, (0o666 & ~umask))
-                runfetchcmd("mv %s %s" % (tfile, filename), d)
+                os.rename(tfile, filename)
             finally:
                 os.close(fd)
 
@@ -439,7 +439,7 @@ class Git(FetchMethod):
                     self.clone_shallow_local(ud, shallowclone, d)
 
                     logger.info("Creating tarball of git repository")
-                    with create_atomic(ud.fullshallow, d) as tfile:
+                    with create_atomic(ud.fullshallow) as tfile:
                         runfetchcmd("tar -czf %s ." % tfile, d, workdir=shallowclone)
                     runfetchcmd("touch %s.done" % ud.fullshallow, d)
                 finally:
@@ -449,7 +449,7 @@ class Git(FetchMethod):
                 os.unlink(ud.fullmirror)
 
             logger.info("Creating tarball of git repository")
-            with create_atomic(ud.fullmirror, d) as tfile:
+            with create_atomic(ud.fullmirror) as tfile:
                 runfetchcmd("tar -czf %s ." % tfile, d, workdir=ud.clonedir)
             runfetchcmd("touch %s.done" % ud.fullmirror, d)
 
-- 
2.31.1


