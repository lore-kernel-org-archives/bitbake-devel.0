Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05081C4332F
	for <webhook@archiver.kernel.org>; Mon, 22 Nov 2021 08:37:11 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by mx.groups.io with SMTP id smtpd.web09.3943.1637570229954568121
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Nov 2021 00:37:10 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 192.55.52.136, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10175"; a="214775774"
X-IronPort-AV: E=Sophos;i="5.87,254,1631602800";
   d="scan'208";a="214775774"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2021 00:37:00 -0800
X-IronPort-AV: E=Sophos;i="5.87,254,1631602800";
   d="scan'208";a="552191268"
Received: from amohdwah-mobl1.gar.corp.intel.com (HELO
 anmitta2-mobl3.intel.com) ([10.215.239.176])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2021 00:36:59 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.52][PATCH 1/2] utils: Handle lockfile filenames that are too long
 for filesystems
Date: Mon, 22 Nov 2021 16:36:47 +0800
Message-Id: 
 <16a68c8359a94c86a5d6f6dbf938124ce2dcfc6f.1637570097.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1637570097.git.anuj.mittal@intel.com>
References: <cover.1637570097.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Nov 2021 08:37:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13094

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
index 70634910..d890ea83 100644
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


