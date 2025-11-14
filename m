Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7D9CE7AB6
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 11:07:59 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15475.1763118471824747514
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Nov 2025 03:07:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=tBCqONOG;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B1C50C10F63
	for <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 11:07:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 820866060E
	for <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 11:07:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EF67310371C51;
	Fri, 14 Nov 2025 12:07:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763118470; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ktG8LzZzQkuSLcDW49J9baAvqhS9vzHdhMmZDeW+0qc=;
	b=tBCqONOG9ozmZuVkx4HGY4x3c8/wbdc56cMhEwAnuKeeE0yAUdF2BKq0O25+Zp8LQRPOY+
	NQ2sCCNONlMRJ3kKEXe5PPRt+n5jxB8LzDwOPeIkjc7tMD2yFD8JHz2WuH0vrpBs5NZaX7
	0xF6R7yViqoNXnUl2h2QgACISHfBY+hQ6JaNvu6/7nihlhlR72fWl0bsSi4zJKiI49UHOK
	NN3CTot6arfWcz9WliaazkvqRZNeJO/5oZPaFFKKu+C2+RtK9VoNcdscghIrgxXaSSRZjn
	zVAddLgStZvVq6M2mtKx9ZU27sbF3WD1Q0oD/UjdCIoqYGp3uOsniYjNsgAIag==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 14 Nov 2025 12:07:34 +0100
Subject: [PATCH 3/3] bitbake-setup: handle ctrl+c in init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-bitbake-setup-abort-v1-3-d2f9967df3b1@bootlin.com>
References: <20251114-bitbake-setup-abort-v1-0-d2f9967df3b1@bootlin.com>
In-Reply-To: <20251114-bitbake-setup-abort-v1-0-d2f9967df3b1@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1397;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=9u4QI/C3QLbh9l0zBYmCgrFBurncx7UgXGKUq7gVKcI=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpFw2DTEyCcPPKJMHLTR0m/8l+rCyjUI9s6nOfR
 bt4DuHAcvaJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaRcNgwAKCRDRgEFAKaOo
 NlGPD/9Y1N8wX0UekpSOl6tU1cHPgievLC/ZEwW3OnqDg5mizyHYGOcfimee6isVfeERs2c3S+X
 6miy4k+cIggD/euU8bH3sqQkveZDL+A+CmB5uSFkpobp1faYt5NFjXRoqupNgZoxr/gjMTaXex0
 UyHMsuYSz7pKzTFaN2XigkNgZGpU3SVPAn/p1tl5Q2kgOtJMHX1tj72BIMS/jW1NNCaDJewGKja
 xUi7oO/471H0M6+vas+2qHgKUS/+JHvolLaxoN+a+7fwMnIe09GknMP7IKtmIHv63qf6KuoZEFu
 BiCoZ8edn1lI/QLewyERN9c6OAYD7/6VPNFKMWgt5pZVrWfc3fT2UNYv86yeK2Ynh26l+BDj/lm
 6HhaObLTdYNDDkMb342yw/bgH+sLmuJ8r5+Mo6J+i0rVeYpQfDS1t7bCZcO7QvS6VWaZFUs9naY
 ZzE+LEcGzHIknouhPxio4kgvvAHai7Lajq/1G2aDx47UzJTA70sYFunWGuUSGPsw43cvKSfROvX
 63Y8K7hSrWIaKCiT0k3/3llOWSV+kXoXHdJpx3Yo2YsTPRnm9dxvlbaEeTGx5mOTIjYoJzVvIzy
 TuTXlO2HGb11tDHPrP46KnIH9FPWk6liQoq0fuuiBuDNKTmIFr8ihQqBrk/7x1v0VDiW8srZAj3
 b8eh4r8aBSNdOsg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 11:07:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18392

Instead of printing the stack trace, print "Shutting down..." when the
user presses Ctrl+C during the init. Mention that the top-directory's
setups might be incomplete if the topdir was already created.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 bin/bitbake-setup | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 3dc46cbbfa..151cb79cac 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -17,6 +17,8 @@ import glob
 import subprocess
 import copy
 import textwrap
+import signal
+import functools
 
 default_registry = os.path.normpath(os.path.dirname(__file__) + "/../default-registry")
 
@@ -452,7 +454,15 @@ def obtain_config(top_dir, settings, args, source_overrides, d):
     upstream_config['skip-selection'] = args.skip_selection
     return upstream_config
 
+def init_sigint_handler(sig, frame, top_dir):
+    print(f'\nShutting down...')
+    if isinstance(top_dir, str) and os.path.exists(top_dir):
+        print(f'{top_dir} may contain an incomplete setup!')
+    exit()
+
 def init_config(top_dir, settings, args):
+    _handler = functools.partial(init_sigint_handler, top_dir=top_dir)
+    signal.signal(signal.SIGINT, _handler)
     create_siteconf(top_dir, args.non_interactive, settings)
 
     d = init_bb_cache(top_dir, settings, args)

-- 
2.51.0


