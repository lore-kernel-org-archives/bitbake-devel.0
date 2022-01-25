Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E98C433F5
	for <webhook@archiver.kernel.org>; Tue, 25 Jan 2022 03:41:32 +0000 (UTC)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by mx.groups.io with SMTP id smtpd.web09.2695.1643082091358209472
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Jan 2022 19:41:32 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="unable to parse pub key" header.i=@intel.com header.s=intel
 header.b=EYjOyRoh;
 spf=pass (domain: intel.com, ip: 192.55.52.151,
 mailfrom: anuj.mittal@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643082091; x=1674618091;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=HSn4Fy+v7mROEDK6Vw/Bjfr4oZV60NOtTt+FDvfAAQI=;
  b=EYjOyRohBIP3mvDj/vodBoQR4ZPHc2zarJYwlwqmJP2vy5p2k2bZDeEt
   UD9QsXH5JDXmXDtHFwdgyMKV52ZHw8TSlW1Sh9UrpRKQY9x3q4Hqxyp2w
   Y72N7POajypezZ25pg9roVxbuVvOeNRASSuwG9kpXqmgvmUEoido2/Nv9
   Rrw9FVEpDepz//G2YyfSDpDN5QNe7ifdoHjqzLQW2ABz7wxtc9/+TIcWm
   OH5vfbal4pTA0gnJG/kNXS4Tm01FeUITfYIE9fjPqGq78pAVm19yGVe/O
   vq4uvNJMizEM5boP8JH5mznVcgKcKIPHNPp501W2ncqKTldmHK9C3oMEg
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="226880304"
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600";
   d="scan'208";a="226880304"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2022 19:41:30 -0800
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600";
   d="scan'208";a="534542612"
Received: from yongyuns-mobl.gar.corp.intel.com (HELO
 anmitta2-mobl3.intel.com) ([10.213.129.99])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2022 19:41:28 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 1/1] utils: Update to use exec_module() instead of
 load_module()
Date: Tue, 25 Jan 2022 11:41:23 +0800
Message-Id: 
 <529ac608891456fc29ab68742a3bca5695e4a6fc.1643081933.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643081933.git.anuj.mittal@intel.com>
References: <cover.1643081933.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Jan 2022 03:41:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13278

From: Richard Purdie <richard.purdie@linuxfoundation.org>

This is deprecated in python 3.12 and Fedora 35 is throwing warnings so
move to the new functions.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 68a18fbcb5959e334cf307d7fa8dc63832edb942)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/utils.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 40b5006f..2a150fe9 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -16,7 +16,8 @@ import bb.msg
 import multiprocessing
 import fcntl
 import importlib
-from importlib import machinery
+import importlib.machinery
+import importlib.util
 import itertools
 import subprocess
 import glob
@@ -1620,7 +1621,9 @@ def load_plugins(logger, plugins, pluginpath):
         logger.debug('Loading plugin %s' % name)
         spec = importlib.machinery.PathFinder.find_spec(name, path=[pluginpath] )
         if spec:
-            return spec.loader.load_module()
+            mod = importlib.util.module_from_spec(spec)
+            spec.loader.exec_module(mod)
+            return mod
 
     logger.debug('Loading plugins from %s...' % pluginpath)
 
-- 
2.34.1


