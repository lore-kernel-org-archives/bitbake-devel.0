Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05CCE83EE6
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 13:45:37 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20636.1770212733154445612
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Feb 2026 05:45:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm2 header.b=i4w6woMs;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-256628-20260204134529ac586eb8f10002073b-hyy8b0@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260204134529ac586eb8f10002073b
        for <bitbake-devel@lists.openembedded.org>;
        Wed, 04 Feb 2026 14:45:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=QnTQE5exvU5zw/Ye4iQcbKJ7Fktc5mSbYap2UssMZ7s=;
 b=i4w6woMspGRf98ovipvQQ51CrbU68CYUdAwn3qVEaEamLU8VUq9E69kBFPE8z1ufgXDSju
 e0Hx1EYShelDZSvGEP0tHlWv2ywqUooWRrB8soPuzE06tTjYwsH64qlfA/KFAI64PWg2bTpu
 ApcaaFt2GJK/ktXGCpBKNQdB+NuhIroOyT+C14wH76SqUkT87cguL2q3CXSSgWsnnBB6HCmE
 56deBJYSTqoZqNkS4FwVCZL4IFG03B3XRRvI3GxN64lYhb6RyZWlLQWo4cEWJix4a2DtQxEC
 6ORcKmAzOul1i2P3u5/xyFd5B2J3VXLHV4i90cLjym1gQ9dR/fktPnCw==;
From: Peter Marko <peter.marko@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Peter Marko <peter.marko@siemens.com>
Subject: [PATCH] bitbake: also hide os.fork() deprecation warning
Date: Wed,  4 Feb 2026 14:45:21 +0100
Message-Id: <20260204134521.2578720-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 04 Feb 2026 13:45:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18956

From: Peter Marko <peter.marko@siemens.com>

Copied from bitbake-server/worker/layers.
This is seen also for bitbake command invocations.

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 bin/bitbake | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bin/bitbake b/bin/bitbake
index a995bd665..2eb5f9103 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -14,6 +14,7 @@ import os
 import sys
 import warnings
 warnings.simplefilter("default")
+warnings.filterwarnings("ignore", category=DeprecationWarning, message=".*use.of.fork.*may.lead.to.deadlocks.in.the.child.*")
 
 sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(__file__)),
                                 'lib'))

