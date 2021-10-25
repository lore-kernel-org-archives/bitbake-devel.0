Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA32C433FE
	for <webhook@archiver.kernel.org>; Mon, 25 Oct 2021 14:16:14 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by mx.groups.io with SMTP id smtpd.web08.33093.1635171373653950227
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Oct 2021 07:16:13 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 192.55.52.136, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10147"; a="209759078"
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800";
   d="scan'208";a="209759078"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2021 07:16:13 -0700
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800";
   d="scan'208";a="634754791"
Received: from syong7-mobl1.gar.corp.intel.com (HELO
 anmitta2-mobl1.gar.corp.intel.com) ([10.249.78.45])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2021 07:16:12 -0700
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 8/9] build: Make exception printing clearer
Date: Mon, 25 Oct 2021 22:15:55 +0800
Message-Id: 
 <c6da76d425b5f5c9e069b283d7bd48670a0efae7.1635171215.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1635171215.git.anuj.mittal@intel.com>
References: <cover.1635171215.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Oct 2021 14:16:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12825

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Shows:

ERROR: SystemExit(1)

instead of:

ERROR: 1

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit df89e37c33e4398a5f8ece9a8b973be3fe2ff361)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/build.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index ad031cc70..85ffd5361 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -703,7 +703,7 @@ def _exec_task(fn, task, d, quieterr):
                 # logs once already so don't duplicate
                 if verboseStdoutLogging:
                     errprinted = True
-                logger.error(str(exc))
+                logger.error(repr(exc))
                 event.fire(TaskFailed(task, fn, logfn, localdata, errprinted), localdata)
             return 1
     finally:
-- 
2.31.1


