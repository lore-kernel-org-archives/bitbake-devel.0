Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EECD12D55
	for <webhook@archiver.kernel.org>; Wed,  3 Dec 2025 12:15:56 +0000 (UTC)
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13675.1764764155845126817
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Dec 2025 04:15:56 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 185.125.25.13, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dLxSB2wdsz3jM;
	Wed,  3 Dec 2025 13:15:54 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4dLxS96wZrzblW;
	Wed,  3 Dec 2025 13:15:53 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Wed, 03 Dec 2025 13:15:43 +0100
Subject: [PATCH 3/3] bitbake-setup: put colon of prompt after suggested
 default
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-bitbake-setup-input-consistent-v1-3-3c7e6edecd57@cherry.de>
References: <20251203-bitbake-setup-input-consistent-v1-0-3c7e6edecd57@cherry.de>
In-Reply-To: <20251203-bitbake-setup-input-consistent-v1-0-3c7e6edecd57@cherry.de>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 03 Dec 2025 12:15:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18526

From: Quentin Schulz <quentin.schulz@cherry.de>

Otherwise it differs from other input prompts we have and it's not
really clear whether anything is expected from the user.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Also wondering if we shouldn't switch to () instead of [] for
surrounding the default value if no input is provided by the user
---
 bin/bitbake-setup | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 7173fec1f..ecfcd677a 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -514,7 +514,7 @@ def init_config(top_dir, settings, args):
                 setup_dir_name = config_setup_dir_name
 
         if not args.non_interactive:
-            n = input(f"Enter setup directory name: [{setup_dir_name}] ")
+            n = input(f"Enter setup directory name [{setup_dir_name}]: ")
             if n:
                 setup_dir_name = n
 

-- 
2.52.0


