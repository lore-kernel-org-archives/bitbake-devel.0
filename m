Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFB8C433F5
	for <webhook@archiver.kernel.org>; Mon, 25 Oct 2021 14:16:13 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by mx.groups.io with SMTP id smtpd.web11.32667.1635171372763946604
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Oct 2021 07:16:12 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 192.55.52.136, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10147"; a="209759075"
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800";
   d="scan'208";a="209759075"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2021 07:16:12 -0700
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800";
   d="scan'208";a="634754781"
Received: from syong7-mobl1.gar.corp.intel.com (HELO
 anmitta2-mobl1.gar.corp.intel.com) ([10.249.78.45])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2021 07:16:11 -0700
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 7/9] fetch2: clarify the command-no-found error message
Date: Mon, 25 Oct 2021 22:15:54 +0800
Message-Id: 
 <72e4631c84ee259426d8bfe233f56226595cf38c.1635171215.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1635171215.git.anuj.mittal@intel.com>
References: <cover.1635171215.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Oct 2021 14:16:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12824

From: Ross Burton <ross@burtonini.com>

If runfetchcmd() fails with bb.process.NotFoundError, the message output
is simply "Fetch command" which doesn't really explain what the problem
is.

Add "not found" to clarify what happened.

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 8de9dc02ed6a73b47f2ab10be30d1aed7954bc72)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index c8e91262a..dbf8b50e6 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -871,7 +871,7 @@ def runfetchcmd(cmd, d, quiet=False, cleanup=None, log=None, workdir=None):
         (output, errors) = bb.process.run(cmd, log=log, shell=True, stderr=subprocess.PIPE, cwd=workdir)
         success = True
     except bb.process.NotFoundError as e:
-        error_message = "Fetch command %s" % (e.command)
+        error_message = "Fetch command %s not found" % (e.command)
     except bb.process.ExecutionError as e:
         if e.stdout:
             output = "output:\n%s\n%s" % (e.stdout, e.stderr)
-- 
2.31.1


