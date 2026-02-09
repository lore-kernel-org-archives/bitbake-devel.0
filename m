Return-Path: <liuyd.fnst@fujitsu.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941A0EF0702
	for <webhook@archiver.kernel.org>; Mon,  9 Feb 2026 02:17:23 +0000 (UTC)
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.38990.1770603440654433241
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 08 Feb 2026 18:17:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fujitsu.com header.s=fj2 header.b=TGEoasol;
 spf=pass (domain: fujitsu.com, ip: 68.232.139.117, mailfrom: liuyd.fnst@fujitsu.com)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1770603440; x=1802139440;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XcTh+3rkUNeD2+oaZy1oCeiPcSoIAoSS84EOH+yy1iQ=;
  b=TGEoasol9JarRNyZnw+lvJFDKm5kbW2fw6pEVC4VrdLnewytuKbyNCll
   4b3Jlpd/6gdwxjMFquU0AJlH82uvmbX5Yk2ik4bgMWwQfMVllfKpPQ8nN
   tNIjlnNMptLN4YXP0aJLTgEQyRk6EeZDTinMabZiqVPjm2j8aupIpeUfm
   MIbyncqjUvqq9xN5ruHDgQaRSjNSDlzyMS3h962Ru68TvADMbxN0/yD60
   l0iNOQ9y3v4XKxnodpFPYXcMZ5/y6tka8iiooV081IL/3XeEwGjiRVvt1
   DQ4g8kwbNXdF1AOWQ6VB2T/cWVreWdAOlML5lUGHXr4wq+FLgQ8qw7oaQ
   w==;
X-CSE-ConnectionGUID: mbF7oT9rSBqI9M1k9WJJag==
X-CSE-MsgGUID: oglUA9SlR7yTEPvOqsJRSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="229623261"
X-IronPort-AV: E=Sophos;i="6.21,281,1763391600"; 
   d="scan'208";a="229623261"
Received: from unknown (HELO mail.fujitsu.com) ([51.138.80.169])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 11:17:18 +0900
Received: from az2nlsmgm3.fujitsu.com (unknown [10.150.26.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgr4.fujitsu.com (Postfix) with ESMTPS id E52F442A33F
	for <bitbake-devel@lists.openembedded.org>; Mon,  9 Feb 2026 02:17:18 +0000 (UTC)
Received: from az2uksmom4.o.css.fujitsu.com (az2uksmom4.o.css.fujitsu.com [10.151.22.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm3.fujitsu.com (Postfix) with ESMTPS id 953901800BF3
	for <bitbake-devel@lists.openembedded.org>; Mon,  9 Feb 2026 02:17:18 +0000 (UTC)
Received: from G08FNSTD190101.g08.fujitsu.local (unknown [10.193.135.3])
	by az2uksmom4.o.css.fujitsu.com (Postfix) with ESMTP id 27FE1403B7B
	for <bitbake-devel@lists.openembedded.org>; Mon,  9 Feb 2026 02:17:15 +0000 (UTC)
From: Liu Yiding <liuyd.fnst@fujitsu.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake-devel][PATCH v3] bitbake-setup: Add strip to value from settings.conf
Date: Mon,  9 Feb 2026 10:17:12 +0800
Message-ID: <20260209021712.9724-1-liuyd.fnst@fujitsu.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Feb 2026 02:17:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18984

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
index d0d9929d3..e18b01019 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -920,6 +920,12 @@ def load_settings(settings_path):
     if os.path.exists(settings_path):
         logger.info('Loading settings from {}'.format(settings_path))
         settings.read_file(open(settings_path))
+
+        for section in settings.sections():
+            for key in settings[section]:
+                value = settings[section][key]
+                settings[section][key] = value.strip('\"\'')
+
     return settings
 
 def change_setting(top_dir, args):
-- 
2.43.0


