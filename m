Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDABC433FE
	for <webhook@archiver.kernel.org>; Thu,  9 Dec 2021 02:02:35 +0000 (UTC)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by mx.groups.io with SMTP id smtpd.web09.6063.1639015353970368926
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Dec 2021 18:02:34 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 192.55.52.115, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="238222369"
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600";
   d="scan'208";a="238222369"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2021 18:02:34 -0800
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600";
   d="scan'208";a="750125200"
Received: from chuenong-mobl.gar.corp.intel.com (HELO
 anmitta2-mobl3.intel.com) ([10.215.229.15])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2021 18:02:33 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.52][PATCH 1/1] data_smart.py: Skip old override syntax checking
 for anonymous functions
Date: Thu,  9 Dec 2021 10:02:28 +0800
Message-Id: 
 <04929e5f6cc9090e74e910d03889aed40d971d4b.1639015193.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1639015193.git.anuj.mittal@intel.com>
References: <cover.1639015193.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Dec 2021 02:02:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13146

From: Robert Yang <liezhi.yang@windriver.com>

Fixed when oe-core's path contians append/prepend/remove, e.g.:

/path/to/append_test/oe-core/

Initial a build in any build dirs:
$ bitbake -p
ERROR: Variable __anon_32__buildarea2_xhou_builds_append_test_layers_oe_core_meta_classes_patch_bbclass
contains an operation using the old override syntax. Please convert this
layer/metadata before attempting to use with a newer bitbake.

The anonymous fuctions has no names, so skip checking for it to fix the issue.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit ebd00330c41c75797529ff38d6a0955b93f05d1b)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/data_smart.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 8d235da1..5ffedebc 100644
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
2.33.1


