Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF41DC433FE
	for <webhook@archiver.kernel.org>; Fri, 31 Dec 2021 00:22:02 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by mx.groups.io with SMTP id smtpd.web11.5667.1640910121693805729
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Dec 2021 16:22:02 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="unable to parse pub key" header.i=@intel.com header.s=intel
 header.b=m8D53jZD;
 spf=pass (domain: intel.com, ip: 134.134.136.100,
 mailfrom: anuj.mittal@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640910122; x=1672446122;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=WWt+vurzh0qbuwwTn3qMSSGQ8hl+cl5/Y60uIGXghEM=;
  b=m8D53jZDb0AItyQq9mxqqrUmVb5xoNAHWshekBdxjNoTlAd9XC6P9TmD
   35DzZUSdznm00YVJ179Mqm+CWjtF4nU1IfLcQnJDyJcKRAAvIVlCU3+HH
   XvrYirNu5aWC3tKyS0gZuU/Lda5alB4SOISOM666Qgjy0qu27s41pmaYP
   q1M8+OW5OSodd3GKwdVzynm0Skp5/JMGRScd7TngeuegkSSdoJ0xWJoN+
   E3jkxOMttYuLAZVB0FKOtWbIHe2DR+Hj+XH8lM9nHW6fGuWUh+StuNLJ/
   VelFS+XxRkB64ij/jDcm176bOvWlesmmvofXjKMKJPKPVy5mEil9RDUL+
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="305110472"
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600";
   d="scan'208";a="305110472"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Dec 2021 16:22:02 -0800
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600";
   d="scan'208";a="468943764"
Received: from jiayingk-mobl2.gar.corp.intel.com (HELO
 anmitta2-mobl3.intel.com) ([10.215.231.141])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Dec 2021 16:22:01 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.52][PATCH 1/4] process: Do not mix stderr with stdout
Date: Fri, 31 Dec 2021 08:21:52 +0800
Message-Id: 
 <eef2355331e7e03b2c7615695694c5ba9877fb36.1640910042.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640910042.git.anuj.mittal@intel.com>
References: <cover.1640910042.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 31 Dec 2021 00:22:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13205

From: Anton Mikanovich <amikan@ilbers.de>

We should not redirect stderr to stdout if we need to get separated
stdout and stderr contents from Popen.communicate() later.

Signed-off-by: Anton Mikanovich <amikan@ilbers.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 1ecc1d9424877df89fcda2f23c306998998a65ff)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/process.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/process.py b/lib/bb/process.py
index d5a1775f..af5d804a 100644
--- a/lib/bb/process.py
+++ b/lib/bb/process.py
@@ -60,7 +60,7 @@ class Popen(subprocess.Popen):
         "close_fds": True,
         "preexec_fn": subprocess_setup,
         "stdout": subprocess.PIPE,
-        "stderr": subprocess.STDOUT,
+        "stderr": subprocess.PIPE,
         "stdin": subprocess.PIPE,
         "shell": False,
     }
-- 
2.33.1


