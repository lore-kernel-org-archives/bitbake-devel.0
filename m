Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71922C433F5
	for <webhook@archiver.kernel.org>; Wed, 29 Sep 2021 14:57:26 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by mx.groups.io with SMTP id smtpd.web09.9905.1632927445559452178
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Sep 2021 07:57:25 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 192.55.52.93, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="221752893"
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200";
   d="scan'208";a="221752893"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2021 07:57:25 -0700
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200";
   d="scan'208";a="437663374"
Received: from zkeh-mobl.gar.corp.intel.com (HELO
 anmitta2-mobl1.gar.corp.intel.com) ([10.213.143.173])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2021 07:57:23 -0700
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 1/3] process: Don't include logs in error message if
 piping them
Date: Wed, 29 Sep 2021 22:57:11 +0800
Message-Id: 
 <4799cc25a8d08d028a7898e3d97462dd7bef1fc8.1632902709.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632902709.git.anuj.mittal@intel.com>
References: <cover.1632902709.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Sep 2021 14:57:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12714

From: Richard Purdie <richard.purdie@linuxfoundation.org>

If the caller is piping the logs, they likely don't want them in the error exception
as well. This removes duplicate output from the build output allowing the UI level
controls on whether to show logs to work correctly.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit fc58ad84a9deb2620ad90611684dad65dafedb11)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/process.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/process.py b/lib/bb/process.py
index 7c3995cce..d5a1775fc 100644
--- a/lib/bb/process.py
+++ b/lib/bb/process.py
@@ -181,5 +181,8 @@ def run(cmd, input=None, log=None, extrafiles=None, **options):
             stderr = stderr.decode("utf-8")
 
     if pipe.returncode != 0:
+        if log:
+            # Don't duplicate the output in the exception if logging it
+            raise ExecutionError(cmd, pipe.returncode, None, None)
         raise ExecutionError(cmd, pipe.returncode, stdout, stderr)
     return stdout, stderr
-- 
2.31.1


