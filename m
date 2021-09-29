Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA17C433EF
	for <webhook@archiver.kernel.org>; Wed, 29 Sep 2021 14:57:27 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by mx.groups.io with SMTP id smtpd.web12.10124.1632927446831175783
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Sep 2021 07:57:27 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 192.55.52.93, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="221752900"
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200";
   d="scan'208";a="221752900"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2021 07:57:26 -0700
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200";
   d="scan'208";a="437663377"
Received: from zkeh-mobl.gar.corp.intel.com (HELO
 anmitta2-mobl1.gar.corp.intel.com) ([10.213.143.173])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2021 07:57:25 -0700
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 2/3] build: Avoid duplicating logs in verbose mode
Date: Wed, 29 Sep 2021 22:57:12 +0800
Message-Id: 
 <58a63ad099521cbb514fa53ae97840fc12ce8813.1632902709.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632902709.git.anuj.mittal@intel.com>
References: <cover.1632902709.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Sep 2021 14:57:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12715

From: Richard Purdie <richard.purdie@linuxfoundation.org>

With "bitbake -v", for task failures you'd see the log output twice. Avoid
this by using the existing "did we print info" switch.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit e2c1afda4cb8023ed4ffeb5dc5bee4f0055659a8)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/build.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 24ce327c5..39e7dba02 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -699,6 +699,10 @@ def _exec_task(fn, task, d, quieterr):
                 event.fire(TaskFailedSilent(task, fn, logfn, localdata), localdata)
             else:
                 errprinted = errchk.triggered
+                # If the output is already on stdout, we've printed the information in the
+                # logs once already so don't duplicate
+                if verboseStdoutLogging:
+                    errprinted = True
                 logger.error(str(exc))
                 event.fire(TaskFailed(task, fn, logfn, localdata, errprinted), localdata)
             return 1
-- 
2.31.1


