Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC29D12D56
	for <webhook@archiver.kernel.org>; Wed,  3 Dec 2025 12:15:56 +0000 (UTC)
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13673.1764764154957456209
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Dec 2025 04:15:55 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 45.157.188.13, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dLxS92YTZz3YC;
	Wed,  3 Dec 2025 13:15:53 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4dLxS86lJnzZJ0;
	Wed,  3 Dec 2025 13:15:52 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Wed, 03 Dec 2025 13:15:41 +0100
Subject: [PATCH 1/3] bitbake-setup: allow to pass a prompt to int_input
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-bitbake-setup-input-consistent-v1-1-3c7e6edecd57@cherry.de>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18524

From: Quentin Schulz <quentin.schulz@cherry.de>

This will allow us to have consistency between expected user inputs by
having them all doing something along the lines of:

Type number: 2

instead of

Type number:
2

This migrates the retry prompts to use that new mechanism.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 bin/bitbake-setup | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 75be90940..54faa7e30 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -330,16 +330,16 @@ def update_build(config, confdir, setupdir, layerdir, d, update_bb_conf="prompt"
     setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_conf)
     write_sources_fixed_revisions(confdir, sources_fixed_revisions)
 
-def int_input(allowed_values):
+def int_input(allowed_values, prompt=''):
     n = None
     while n is None:
         try:
-            n = int(input())
+            n = int(input(prompt))
         except ValueError:
-            print('Not a valid number, please try again:')
+            prompt = 'Not a valid number, please try again: '
             continue
         if n not in allowed_values:
-            print('Number {} not one of {}, please try again:'.format(n, allowed_values))
+            prompt = 'Number {} not one of {}, please try again: '.format(n, allowed_values)
             n = None
     return n
 

-- 
2.52.0


