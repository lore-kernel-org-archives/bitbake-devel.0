Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51615C433EF
	for <webhook@archiver.kernel.org>; Mon, 14 Mar 2022 02:14:07 +0000 (UTC)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by mx.groups.io with SMTP id smtpd.web08.21884.1647224044035250454
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 13 Mar 2022 19:14:06 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="unable to parse pub key" header.i=@intel.com header.s=intel
 header.b=GfRbIc1B;
 spf=pass (domain: intel.com, ip: 192.55.52.43,
 mailfrom: anuj.mittal@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647224046; x=1678760046;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=k5DqUzTF/zzUx+a+tqIskFxonu16L0MDgRkz7JmFzJU=;
  b=GfRbIc1BHGFkkGlOwnvFKWES4L7P9CtCeutWzHVIayxO/EGgbxqd6DbM
   cuyMwUzTD5dFJifXSfLoxpu7QCykuQuN6vHN8aLtwf8ucT8b0aKtTkzm0
   UgagwBqdz1w93yCiicq/QWYw2LMrr5uuzU1VGT4Qoq7Dp7UueHa67Hw0z
   qfisbogxThQSsSA+kwSuExQJLtQPS77a9klQ0biyCxg599Wbebgx/bN3l
   kzyiLimvQjHm2izLgIorCCpO7BotXK9pX9oTZIFmp5Y/BTF5tspEjmWyy
   3gpyoLoIW8XXp+QZoAk25V5+OoeNlmgKBR9NvHoglVgHGkv6KAOAPwd9V
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="342344741"
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400";
   d="scan'208";a="342344741"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2022 19:14:06 -0700
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400";
   d="scan'208";a="818562578"
Received: from lsim7-mobl1.gar.corp.intel.com (HELO anmitta2-mobl3.intel.com)
 ([10.215.229.232])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2022 19:14:05 -0700
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.52][PATCH 2/5] data_smart: Fix overrides file/line message
 additions
Date: Mon, 14 Mar 2022 10:13:54 +0800
Message-Id: 
 <2d7c63fd2626e55a17076befae33cfdca3ceedcc.1647223687.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647223687.git.anuj.mittal@intel.com>
References: <cover.1647223687.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Mar 2022 02:14:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13478

From: Richard Purdie <richard.purdie@linuxfoundation.org>

The overrides warning message is meant to show filename and line
numbers but the variable names are incorrect and this wasn't working.
Fix it.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 551c1cb20fc9b9d0dab5d830182c2bf626e72845)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/data_smart.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 5ffedebc..e9603278 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -494,10 +494,10 @@ class DataSmart(MutableMapping):
 
         if not var.startswith("__anon_") and ("_append" in var or "_prepend" in var or "_remove" in var):
             info = "%s" % var
-            if "filename" in loginfo:
-                info += " file: %s" % loginfo[filename]
-            if "lineno" in loginfo:
-                info += " line: %s" % loginfo[lineno]
+            if "file" in loginfo:
+                info += " file: %s" % loginfo["file"]
+            if "line" in loginfo:
+                info += " line: %s" % loginfo["line"]
             bb.fatal("Variable %s contains an operation using the old override syntax. Please convert this layer/metadata before attempting to use with a newer bitbake." % info)
 
         self.expand_cache = {}
-- 
2.35.1


