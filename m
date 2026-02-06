Return-Path: <liuyd.fnst@fujitsu.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6963BEB28DF
	for <webhook@archiver.kernel.org>; Fri,  6 Feb 2026 07:55:40 +0000 (UTC)
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6623.1770364530571497664
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Feb 2026 23:55:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fujitsu.com header.s=fj2 header.b=mgzU3CMl;
 spf=pass (domain: fujitsu.com, ip: 207.54.90.47, mailfrom: liuyd.fnst@fujitsu.com)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1770364531; x=1801900531;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lt0rhtH1Gdu9EZtViSExSFTU0+4YzmSlzkyDCQV4zC0=;
  b=mgzU3CMl9YevKkOSixnFCm6u8sEgJZ7yAyw5XXjdA20scgeQ+hRGizTt
   ZrbgS1NqYGNWTARufw6yJM/SHwVSeelylZWxH5D7IpRPc0RQF1iHxqphq
   Bx9I+6F4PV8G3+mJM+W4iDIeNp1KosDi9qU8RjxHp6zj0Omum5AOuQ5/U
   gNr/72xSLmGrYf0HaTXIDq5vlIQTCD4NaOX+yluExUDt4q0HcVKJmXR5g
   llokOoex706LnSo4nmUquf5CRtEvA6LulyavW9w+C29L7wU8uT967mWX9
   Kfiufr4k+Y/DIN99pn7QN1xzhTjy7BaHC5KA6umfG7IXUZIe5BmaDHnwZ
   A==;
X-CSE-ConnectionGUID: VfjEmVHBTminOCRZbGYjHw==
X-CSE-MsgGUID: nHti7YVCQTe5buTm+qC8SQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="228780519"
X-IronPort-AV: E=Sophos;i="6.21,276,1763391600"; 
   d="scan'208";a="228780519"
Received: from unknown (HELO mail.fujitsu.com) ([20.61.8.234])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 16:55:29 +0900
Received: from az2uksmgm2.o.css.fujitsu.com (unknown [10.151.22.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgr4.fujitsu.com (Postfix) with ESMTPS id BA4E64071E4
	for <bitbake-devel@lists.openembedded.org>; Fri,  6 Feb 2026 07:55:28 +0000 (UTC)
Received: from az2uksmom2.o.css.fujitsu.com (az2uksmom2.o.css.fujitsu.com [10.151.22.203])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm2.o.css.fujitsu.com (Postfix) with ESMTPS id 5A1C0180ABFA
	for <bitbake-devel@lists.openembedded.org>; Fri,  6 Feb 2026 07:55:28 +0000 (UTC)
Received: from G08FNSTD190101.g08.fujitsu.local (unknown [10.193.135.3])
	by az2uksmom2.o.css.fujitsu.com (Postfix) with ESMTP id 2E5C314000DB
	for <bitbake-devel@lists.openembedded.org>; Fri,  6 Feb 2026 07:55:25 +0000 (UTC)
From: Liu Yiding <liuyd.fnst@fujitsu.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake-devel][PATCH v2] bitbake-setup: Add strip to value from settings.conf
Date: Fri,  6 Feb 2026 15:55:22 +0800
Message-ID: <20260206075522.5620-1-liuyd.fnst@fujitsu.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 06 Feb 2026 07:55:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18976

If user add "" to dl-dir as DL_DIR, it will show FetchError as following.

 raise FetchError("Unable to fetch URL from any source.", u)
bb.fetch2.FetchError: Fetcher failure for URL: 'git://git.openembedded.org/bitbake;protocol=https;rev=master;branch=master;destsuffix=bitbake'. Unable to fetch URL from any source.

But from this log, user can't locate the real reason which is that the path "/aa/bb" is invalid.

So I make this fix, even if user add "" to dl-dir, the dl-dir will be the valid path.
Other settings value also need this fix.

Signed-off-by: Liu Yiding <liuyd.fnst@fujitsu.com>
---
 bin/bitbake-setup | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index abe7614c8..e06c40dc6 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -869,6 +869,12 @@ def load_settings(settings_path):
     if os.path.exists(settings_path):
         logger.info('Loading settings from {}'.format(settings_path))
         settings.read_file(open(settings_path))
+
+        for section in settings.sections():
+            for key in settings[section]:
+                value = settings[section][key]
+                settings[section][key] = value.strip('"')
+
     return settings
 
 def change_setting(top_dir, args):
-- 
2.43.0


