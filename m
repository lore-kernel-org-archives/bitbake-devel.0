Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613C6C433FE
	for <webhook@archiver.kernel.org>; Thu, 25 Nov 2021 08:39:15 +0000 (UTC)
Received: from mail1.wrs.com (mail1.wrs.com [147.11.3.146])
 by mx.groups.io with SMTP id smtpd.web08.9835.1637829554525826149
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 Nov 2021 00:39:14 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=fail (domain: windriver.com, ip: 147.11.3.146, mailfrom: liezhi.yang@windriver.com)
Received: from mail.windriver.com (mail.wrs.com [147.11.1.11])
	by mail1.wrs.com (8.15.2/8.15.2) with ESMTPS id 1AP8dCh8026827
	(version=TLSv1.1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>; Thu, 25 Nov 2021 00:39:13 -0800
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com
 [147.11.82.252])
	by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 1AP8dC4N023778
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 Nov 2021 00:39:12 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 25 Nov 2021 00:39:12 -0800
Received: from ala-lpggp3.wrs.com (147.11.105.124) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.12 via Frontend Transport; Thu, 25 Nov 2021 00:39:12 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 1/1] data_smart.py: Skip old override syntax checking for
 anonymous functions
Date: Thu, 25 Nov 2021 00:39:12 -0800
Message-ID: 
 <89a1ec400c7487a283107b0cb3715eb73294b130.1637829491.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1637829491.git.liezhi.yang@windriver.com>
References: <cover.1637829491.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 25 Nov 2021 08:39:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13105

Fixed when oe-core's path contians append/prepend/remove, e.g.:

/path/to/append_test/oe-core/

Initial a build in any build dirs:
$ bitbake -p
ERROR: Variable __anon_32__buildarea2_xhou_builds_append_test_layers_oe_core_meta_classes_patch_bbclass
contains an operation using the old override syntax. Please convert this
layer/metadata before attempting to use with a newer bitbake.

The anonymous fuctions has no names, so skip checking for it to fix the issue.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 lib/bb/data_smart.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 7ed7112bdc..543372d153 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -492,7 +492,7 @@ class DataSmart(MutableMapping):
     def setVar(self, var, value, **loginfo):
         #print("var=" + str(var) + "  val=" + str(value))
 
-        if "_append" in var or "_prepend" in var or "_remove" in var:
+        if not var.startswith("__anon_") and ("_append" in var or "_prepend" in var or "_remove" in var):
             info = "%s" % var
             if "filename" in loginfo:
                 info += " file: %s" % loginfo[filename]
-- 
2.31.1


