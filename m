Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5DFC433EF
	for <webhook@archiver.kernel.org>; Fri,  3 Dec 2021 14:25:58 +0000 (UTC)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by mx.groups.io with SMTP id smtpd.web12.12280.1638541552915223576
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Dec 2021 06:25:58 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 134.134.136.31, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="297779942"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800";
   d="scan'208";a="297779942"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Dec 2021 06:25:57 -0800
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800";
   d="scan'208";a="746722975"
Received: from ffoo-mobl1.gar.corp.intel.com (HELO anmitta2-mobl3.intel.com)
 ([10.215.225.43])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Dec 2021 06:25:56 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 1/1] utils: Handle lockfile filenames that are too long
 for filesystems
Date: Fri,  3 Dec 2021 22:25:46 +0800
Message-Id: 
 <f5811b0179fc0fa5e990f52b27d46610760bfc79.1638541408.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1638541408.git.anuj.mittal@intel.com>
References: <cover.1638541408.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Dec 2021 14:25:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13126

From: Richard Purdie <richard.purdie@linuxfoundation.org>

The fetcher mirror code can go crazy creating lock filenames which exceed the
filesystem limits. When this happens, the code will loop/hang.

Handle the filename too long exception correctly but also truncate lockfile
lengths to under 256 since the worst case situation is lockfile overlap
and lack of parallelism.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 63baf3440b16e41ac6601de21ced94a94bdf1509)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/utils.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index b282d09a..40b5006f 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -451,6 +451,10 @@ def lockfile(name, shared=False, retry=True, block=False):
     consider the possibility of sending a signal to the process to break
     out - at which point you want block=True rather than retry=True.
     """
+    if len(name) > 255:
+        root, ext = os.path.splitext(name)
+        name = root[:255 - len(ext)] + ext
+
     dirname = os.path.dirname(name)
     mkdirhier(dirname)
 
@@ -487,7 +491,7 @@ def lockfile(name, shared=False, retry=True, block=False):
                     return lf
             lf.close()
         except OSError as e:
-            if e.errno == errno.EACCES:
+            if e.errno == errno.EACCES or e.errno == errno.ENAMETOOLONG:
                 logger.error("Unable to acquire lock '%s', %s",
                              e.strerror, name)
                 sys.exit(1)
-- 
2.33.1


