Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5335CC433F5
	for <webhook@archiver.kernel.org>; Mon, 14 Mar 2022 02:14:15 +0000 (UTC)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by mx.groups.io with SMTP id smtpd.web08.21884.1647224044035250454
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 13 Mar 2022 19:14:09 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="unable to parse pub key" header.i=@intel.com header.s=intel
 header.b=C72msWJ3;
 spf=pass (domain: intel.com, ip: 192.55.52.43,
 mailfrom: anuj.mittal@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647224049; x=1678760049;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=U6UuWrV2BMQv5zqZgsfjo3SBDMzmLczOzl4ZMeb1y8g=;
  b=C72msWJ3aWWU6/qn9QkCpnK96AwJu/hh+j+WKs5qyuF0bsstEJaONmpJ
   q4kn0OWn6D1DW7FxX8o9Ix3/lSdv+nwCmefduMqa+hkQl25HIk2H3Y6Qz
   dpPGBuzm9cq5WIq5mOvxANcaIbFmkoKwva6d9mvFYx5Z3wr0lGt3IIVtA
   A1zc8O5EjOoYbFSP+rJ76ngmfN1b8D+CfJOkOfEVuNetHVb4YlOIsK3s/
   IQEANQohvtYM7XU2I1Kbmz1XzwIH/6o/9BPlqj3T1rPx0EgjRJTnkuN8K
   BeKLXPb60D+FLFRbKg98ya68ca2ZFzarylA50YuD3yZ46NE8WaaaOwhAf
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="342344752"
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400";
   d="scan'208";a="342344752"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2022 19:14:08 -0700
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400";
   d="scan'208";a="818562604"
Received: from lsim7-mobl1.gar.corp.intel.com (HELO anmitta2-mobl3.intel.com)
 ([10.215.229.232])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2022 19:14:07 -0700
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.52][PATCH 4/5] utils: Ensure shell function failure in python
 logging is correct
Date: Mon, 14 Mar 2022 10:13:56 +0800
Message-Id: 
 <910ced8c16f982722ce9fe06c561a7a71eca9e58.1647223687.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647223687.git.anuj.mittal@intel.com>
References: <cover.1647223687.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Mar 2022 02:14:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13480

From: Richard Purdie <richard.purdie@linuxfoundation.org>

If a python function exec_func() calls a shell task, the logging wasn't working
correctly in all cases since the exception was turned into a BBHandledException()
and the logfile piece was lost which is handled at the top task level.

The easiest way to avoid this is to allow the ExecutionError exceptions to
be raised to a higher level, we don't need the traceback for them.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 7cae11f558f9ff5fd05ef23b789aaef92fb5a327)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/utils.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 1a515897..cd442dcd 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -401,7 +401,7 @@ def better_exec(code, context, text = None, realfile = "<code>", pythonexception
         code = better_compile(code, realfile, realfile)
     try:
         exec(code, get_context(), context)
-    except (bb.BBHandledException, bb.parse.SkipRecipe, bb.data_smart.ExpansionError):
+    except (bb.BBHandledException, bb.parse.SkipRecipe, bb.data_smart.ExpansionError, bb.process.ExecutionError):
         # Error already shown so passthrough, no need for traceback
         raise
     except Exception as e:
-- 
2.35.1


