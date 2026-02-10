Return-Path: <liuyd.fnst@fujitsu.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6394E94627
	for <webhook@archiver.kernel.org>; Tue, 10 Feb 2026 02:30:50 +0000 (UTC)
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11440.1770690646434173811
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Feb 2026 18:30:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fujitsu.com header.s=fj2 header.b=i6eCOxMU;
 spf=pass (domain: fujitsu.com, ip: 139.138.61.253, mailfrom: liuyd.fnst@fujitsu.com)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1770690646; x=1802226646;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hldPdeJj05qawNyMqmg+DtDTbExQnlLR4B2ZFWzOVKk=;
  b=i6eCOxMUnNOHeuiilazn4625OMdRJaFu8jQ2beAnz4SbgkoP/9U3txmA
   wHmmablK4Abod2MZJ7qVvuI4TKAfc+8q8EuYKEhS2Cc+LXsBZtAL9p1yC
   +uJ+T5iznZVH/SXg3mN2x2thaUO60usOzNBTxkcSXr0Kbq/pxhOXmh4fE
   QKfCLAtXEmTZQ+U0BBys/33ujTTHPvJuUl5w9b4Gr1pY4sjtimCNNKQzn
   AIW4x/QybaS72raDsI1XaTd5MDXL8zsIKdtok9r6PZ4FTTE/6kOpwfexB
   3Cw3NJorYWep+wFitwTzs0EBzGzD1K3iRbN7JctCBv2DxS5c3HlU+eAAy
   w==;
X-CSE-ConnectionGUID: 5ow2mWK0TsSO2TgKtZlJug==
X-CSE-MsgGUID: gfsYmZ8WQhe1vYywbnNv/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="217046742"
X-IronPort-AV: E=Sophos;i="6.21,283,1763391600"; 
   d="scan'208";a="217046742"
Received: from az2uksmgm4.o.css.fujitsu.com (unknown [10.151.22.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgr1.fujitsu.com (Postfix) with ESMTPS id A1CFB1C00090
	for <bitbake-devel@lists.openembedded.org>; Tue, 10 Feb 2026 02:30:44 +0000 (UTC)
Received: from az2uksmom1.o.css.fujitsu.com (az2uksmom1.o.css.fujitsu.com [10.151.22.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm4.o.css.fujitsu.com (Postfix) with ESMTPS id 48A5F140036D
	for <bitbake-devel@lists.openembedded.org>; Tue, 10 Feb 2026 02:30:44 +0000 (UTC)
Received: from G08FNSTD190101.g08.fujitsu.local (unknown [10.193.135.3])
	by az2uksmom1.o.css.fujitsu.com (Postfix) with ESMTP id 04E92180190C
	for <bitbake-devel@lists.openembedded.org>; Tue, 10 Feb 2026 02:30:41 +0000 (UTC)
From: Liu Yiding <liuyd.fnst@fujitsu.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake-devel][PATCH v4] bitbake-setup: Add strip to value  from settings.conf
Date: Tue, 10 Feb 2026 10:30:35 +0800
Message-ID: <20260210023036.11651-1-liuyd.fnst@fujitsu.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 Feb 2026 02:30:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18995

If user add "" to dl-dir as DL_DIR, it will show FetchError as following.

 raise FetchError("Unable to fetch URL from any source.", u)
bb.fetch2.FetchError: Fetcher failure for URL: 'git://git.openembedded.org/bitbake;protocol=https;rev=master;branch=master;destsuffix=bitbake'. Unable to fetch URL from any source.

But from this log, user can't locate the real reason which is that the path "/aa/bb" is invalid.

So I make this fix, even if user add "" to dl-dir, the dl-dir will be the valid path.
Other settings value also need this fix.

Signed-off-by: Liu Yiding <liuyd.fnst@fujitsu.com>
---
 bin/bitbake-setup | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index d0d9929d3..927c03a10 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -920,6 +920,11 @@ def load_settings(settings_path):
     if os.path.exists(settings_path):
         logger.info('Loading settings from {}'.format(settings_path))
         settings.read_file(open(settings_path))
+
+        for section in settings.sections():
+            for key, value in settings[section].items():
+                settings[section][key] = value.strip('\"\'')
+
     return settings
 
 def change_setting(top_dir, args):
-- 
2.43.0


