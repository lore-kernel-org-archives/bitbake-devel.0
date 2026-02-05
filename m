Return-Path: <david.partain@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBE1E9127F
	for <webhook@archiver.kernel.org>; Thu,  5 Feb 2026 07:02:49 +0000 (UTC)
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14260.1770268776604894205
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Feb 2026 21:19:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fujitsu.com header.s=fj2 header.b=hfPJRPKK;
 spf=pass (domain: fujitsu.com, ip: 139.138.61.253, mailfrom: liuyd.fnst@fujitsu.com)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1770268776; x=1801804776;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B25GpftxO6zjvXJHUOfMCKNqezG9VqiUW9b7kOWCREc=;
  b=hfPJRPKKCvPfgtK+DxQM2Pmk/KaUNtML8lqqhFkQsKGFRbwEtrGrOVw+
   wPBjQYk4NfUI7gIe447PaEu5Jtz3jfBAXB9A/X8S24xGPrvin5djssv8p
   8BmWmgxErkKhh0zO56viC+j+m4IVyV8r3AaMv18YM2UwnWqfObiG+A1tg
   iEcnnYi5xP6Tg+3ylMRvD+8pgjNHPTbwRCvcUwMprdaUgwnix+sdhQ7oN
   guJ43T4NgbExPLyshK82g0MZGEXCmSrPHeAPMmj0ozvAFhcHjdTVm5F0M
   Ah2DBvqr/vCrfou/nRH4trIg496tYESvaho8TV68ACKfANee/NN/fYdnJ
   w==;
X-CSE-ConnectionGUID: fQNj59FTQA2BMO+pcbFcvw==
X-CSE-MsgGUID: e2NZ/81oTNKfYM1O9VJjhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="216544286"
X-IronPort-AV: E=Sophos;i="6.21,274,1763391600"; 
   d="scan'208";a="216544286"
Received: from unknown (HELO mail.fujitsu.com) ([51.138.80.169])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 14:19:35 +0900
Received: from az2uksmgm4.o.css.fujitsu.com (unknown [10.151.22.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgr2.fujitsu.com (Postfix) with ESMTPS id 0CF013FD7
	for <bitbake-devel@lists.openembedded.org>; Thu,  5 Feb 2026 05:19:35 +0000 (UTC)
Received: from az2uksmom4.o.css.fujitsu.com (az2uksmom4.o.css.fujitsu.com [10.151.22.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm4.o.css.fujitsu.com (Postfix) with ESMTPS id A69E5140734A
	for <bitbake-devel@lists.openembedded.org>; Thu,  5 Feb 2026 05:19:34 +0000 (UTC)
Received: from G08FNSTD190101.g08.fujitsu.local (unknown [10.193.135.3])
	by az2uksmom4.o.css.fujitsu.com (Postfix) with ESMTP id 67306404686
	for <bitbake-devel@lists.openembedded.org>; Thu,  5 Feb 2026 05:19:32 +0000 (UTC)
From: "Yiding Liu (Fujitsu)" <liuyd.fnst@fujitsu.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] bitbake-setup: Add strip to dldir
Date: Thu,  5 Feb 2026 13:19:08 +0800
Message-ID: <20260205051908.2553-1-liuyd.fnst@fujitsu.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Feb 2026 07:02:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18959

If user add "" to dl-dir as DL_DIR, it will show FetchError as following.

 raise FetchError("Unable to fetch URL from any source.", u)
bb.fetch2.FetchError: Fetcher failure for URL: 'git://git.openembedded.org/bitbake;protocol=https;rev=master;branch=master;destsuffix=bitbake'. Unable to fetch URL from any source.

But from this log, user can't locate the real reason which is that the path "/aa/bb" is invalid.

So I make this fix, even if user add "" to dl-dir, the dl-dir will be the valid path.

Signed-off-by: Liu Yiding <liuyd.fnst@fujitsu.com>
---
 bin/bitbake-setup | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index abe7614c8..2ea5a5f3b 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -41,7 +41,7 @@ def cache_dir(top_dir):
     return os.path.join(top_dir, '.bitbake-setup-cache')
 
 def init_bb_cache(top_dir, settings, args):
-    dldir = settings["default"]["dl-dir"]
+    dldir = settings["default"]["dl-dir"].strip('"')
     bb_cachedir = os.path.join(cache_dir(top_dir), 'bitbake-cache')
 
     d = bb.data.init()
-- 
2.43.0


