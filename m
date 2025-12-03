Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFC2D12D52
	for <webhook@archiver.kernel.org>; Wed,  3 Dec 2025 12:15:56 +0000 (UTC)
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13672.1764764154666369693
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Dec 2025 04:15:55 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 45.157.188.11, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dLxS867vNz5P5;
	Wed,  3 Dec 2025 13:15:52 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4dLxS80LdRzZHx;
	Wed,  3 Dec 2025 13:15:51 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Subject: [PATCH 0/3] bitbake-setup: improve consistency in prompts
Date: Wed, 03 Dec 2025 13:15:40 +0100
Message-Id: <20251203-bitbake-setup-input-consistent-v1-0-3c7e6edecd57@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3NQQqDQAxA0atI1g2YsYr0KqWLUWMNQhwmsRTEu
 zu4fJv/DzDOwgav6oDMPzHZtIAeFYxL1C+jTMUQ6tBSqBscxIe4Mhr7nlA07Y7jpibmrI5EfTd
 Hmp5tbKBEUuZZ/vfg/TnPCx6+l4BwAAAA
X-Change-ID: 20251203-bitbake-setup-input-consistent-1186fa1d45a3
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 03 Dec 2025 12:15:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18523

The prompts for integer inputs are displaying the user input after the
line while string inputs are displaying the user input next to the
prompt. This aligns the behavior to have the user input next to the
prompt in all cases, even for numbers, even for retries.

This also fixes what could be said to be a typo: the colon was added
before the default value for one prompt instead of after, confusing me a
bit as to what was expected from me.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (3):
      bitbake-setup: allow to pass a prompt to int_input
      bitbake-setup: make all callers of int_input pass their prompt
      bitbake-setup: put colon of prompt after suggested default

 bin/bitbake-setup | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)
---
base-commit: 720df1a53452983c1c832f624490e255cf389204
change-id: 20251203-bitbake-setup-input-consistent-1186fa1d45a3

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


