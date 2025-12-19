Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B11D74961
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 08:12:17 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12788.1766131934956684701
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Dec 2025 00:12:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=k+1kzgkI;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D1B584E41CA5
	for <bitbake-devel@lists.openembedded.org>; Fri, 19 Dec 2025 08:12:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A8C226071D;
	Fri, 19 Dec 2025 08:12:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 65988102F0B4D;
	Fri, 19 Dec 2025 09:12:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1766131927; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=TkPxtHjA+EvlB9QVwWaefG1hcX2z3sOYWAzX4xVBJCQ=;
	b=k+1kzgkIH0sIjX9s7+TAZI1zIreZqWRUxfoV7WEvjHmIpqhe4812a4hmJgxvYFTN5947o/
	sh5wUImPEmK0IiRNSnv8PMeIQtc//uG6W4JNnFhBZ9FcQDMFbPlssSs7wb53BtmmhqSQbb
	1LlsXKNxv3ZOLZGQLDXvu/GNYQ/Xb3hidJH9cIYy4zPoDyTWVDlSzUC10fU4m/LxW6okx0
	1sRPWodi4/BHrHxQCUbb25fL3ESyvvNrKu3HIWxbAReQTEZWpUk/N6DHy6B+cGlnStavbU
	Hgzkxj83pG/2d9GMinjhXMpexE5Z/GE48cYzz4D+CfyM10JvFp5Dt4CP8wpNLg==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Fri, 19 Dec 2025 09:11:42 +0100
Subject: [PATCH] bin: Hide os.fork() deprecation warning in all bitbake
 scripts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-mathieu-fork-warning2-v1-1-31144864ea85@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAL0IRWkC/x3MSQqAMAxA0atI1gZswaFeRVyUmmoQq6ROIN7d4
 vIt/n8gkjBFaLMHhE6OvIYElWfgJhtGQh6SQRe6VFoZXOw+MR3oV5nxshI4jBpVXVnTDMZ5X0B
 qNyHP9//t+vf9APJp2EpnAAAA
X-Change-ID: 20251219-mathieu-fork-warning2-176a98d9cff0
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steve Sakoman <steve@sakoman.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766131926; l=2156;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=KteHkZjCz7f9IQiNmnrAvfJwGThLjWx4wkmHcXalLQo=;
 b=f4yVsd06UXMjOH0QV17of2h0AtpaDn/vk9TXstee3pduUaQjOcOK5jTCy/Ig+MpfXdQg0AAmL
 bgSIVMTXKx6DThSoGVfOgMbSwrRTvMOBp7fNMXWLMSihQDNpZLSeluF
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 19 Dec 2025 08:12:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18612

As the previous patch [1] was missing some occurrences, make sure to
mask the deprecation warning in all scripts that might fork, i.e. all
scripts using a BitBakeServer instance at some point.

Justification is still the same, we are being fairly careful here
and believe this code is safe.

Fixes [YOCTO #16080]

[1] https://git.openembedded.org/bitbake/commit/?id=8b02d65a6439b21d8bd5590dc0009f2cf29c1de8

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 bin/bitbake          | 1 +
 bin/bitbake-diffsigs | 1 +
 bin/bitbake-getvar   | 1 +
 3 files changed, 3 insertions(+)

diff --git a/bin/bitbake b/bin/bitbake
index a995bd665352..2eb5f9103d31 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -14,6 +14,7 @@ import os
 import sys
 import warnings
 warnings.simplefilter("default")
+warnings.filterwarnings("ignore", category=DeprecationWarning, message=".*use.of.fork.*may.lead.to.deadlocks.in.the.child.*")
 
 sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(__file__)),
                                 'lib'))
diff --git a/bin/bitbake-diffsigs b/bin/bitbake-diffsigs
index 9d6cb8c944bc..0974e8d4aed0 100755
--- a/bin/bitbake-diffsigs
+++ b/bin/bitbake-diffsigs
@@ -13,6 +13,7 @@ import sys
 import warnings
 
 warnings.simplefilter("default")
+warnings.filterwarnings("ignore", category=DeprecationWarning, message=".*use.of.fork.*may.lead.to.deadlocks.in.the.child.*")
 import argparse
 import logging
 import pickle
diff --git a/bin/bitbake-getvar b/bin/bitbake-getvar
index 378fb1357247..1c4283779e88 100755
--- a/bin/bitbake-getvar
+++ b/bin/bitbake-getvar
@@ -12,6 +12,7 @@ import sys
 import warnings
 import logging
 warnings.simplefilter("default")
+warnings.filterwarnings("ignore", category=DeprecationWarning, message=".*use.of.fork.*may.lead.to.deadlocks.in.the.child.*")
 
 bindir = os.path.dirname(__file__)
 topdir = os.path.dirname(bindir)

---
base-commit: 6e511d035a3d1e4129dab7b0dfbf216bd8e99b47
change-id: 20251219-mathieu-fork-warning2-176a98d9cff0

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


