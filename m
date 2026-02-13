Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B125EDF166
	for <webhook@archiver.kernel.org>; Fri, 13 Feb 2026 13:50:53 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.71817.1770990651266242328
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 13 Feb 2026 05:50:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=J+wT8FE/;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D296DC1EC8E
	for <bitbake-devel@lists.openembedded.org>; Fri, 13 Feb 2026 13:50:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 35E11606BE
	for <bitbake-devel@lists.openembedded.org>; Fri, 13 Feb 2026 13:50:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9A7D410368E88;
	Fri, 13 Feb 2026 14:50:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770990647; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=PTnsl14yspt8fVIn1EXRW61TzYwX3yaqJwwrAJu+aM8=;
	b=J+wT8FE/E1OylzuSVq7Sug7l7qmJrx2u2XnSMAdowfhFJZXxAvRAXXKSrswXgon0DWbeeM
	lrgpjJq6lCdqR1ya1F927rRjKkW+FU3vGMxlxbYk4E9i5A3tSAIhduy9VFphGP7oo9FiHY
	lnb6SZU2Gk74OkvOAZgjNStAxLi/aRvMUjM1tKKFZnn0FYz1HcHeDSDeFzolhSiyi1MZSe
	r4HQBwF3gwxU6J4LnScbSil2AptiT1I/H5pXOMFrEuanmh5dzFQQRcVbn2QfxMXNb5GsBU
	bgUkM8jhGhgPSymEYa2uxvaNsjnX9jZvqkpUs2pPeVFWXzX7c36n66HuWDKOqA==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 13 Feb 2026 14:50:39 +0100
Subject: [PATCH 1/4] bitbake-setup: define a global for the color choice
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260213-improve-bbsetup-readability-v1-1-41cec3b06992@bootlin.com>
References: <20260213-improve-bbsetup-readability-v1-0-41cec3b06992@bootlin.com>
In-Reply-To: <20260213-improve-bbsetup-readability-v1-0-41cec3b06992@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1268;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=94QnDwJqeX6PvffO5FiWeVy+RmyBQHflyehjuFy+VxA=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpjyw1dgjS3TuD87nmCXcUPrckWjbAOtrVvgJVW
 9vlk2FPfCqJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaY8sNQAKCRDRgEFAKaOo
 Nn2nD/9a/rH2yemA5k8MVqaeZ2P8r9/MzgxKpqr6IAWqLI9I9bnOmd6Bt0/g6vH9x7GC7dWeED7
 YVd1zGbFL8YRmmZMJOy7/osqFcZxzmwIiW5OKqS5Sn73SamGjr7Tgd/VQZ0TycZi5hmaxug+qNC
 G4o6dnfbCt8vUJTAUCVXApmKjQl/PU1jnm3b7r1Y1NytCoawh7MmKpV82r5/PoUBa3/JHWIEx0n
 oJsMZO0T5EEPKlydbcCVWenJRv+JAC9bjrxXaSDWyC7enS1gw9czgzyApdh4iT+l5+rIvMA821i
 rTbvxa12MM9fy+/YOncgOBushDcUtTruYHdHY81zpbI/D3yOelBPJd/6YnRSRUWh1MJmBst4GcO
 Ctwyh7TMqg+Oa1SuKscZSvkgxEnF4ZQADfApJy3JstjMQPBK59Bw2dUPFT/2yb4QdlrD68oI63F
 dXygPrOm9v9wBGDOd1LE5p6KM/oGatcXB1DeJXBQiHoTARzKFF8hOf4vjfWW5QFpuPabudOJCqx
 Y5Bh+dGJ74iR/D4tVgHhNi+4Zgh3YBMtAc/TNpJ83m+5204h+ouAVVnsBxHNoScGZALAhBo0nds
 ZMH3JPnoo+MSS1BvNgbaJZad5/hsFuHHzJQgq/zYuo5+rF7jKDy0LmzL9kMa5OXSs/tdPUSYgt0
 JWM1D9wNO/AM5qA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 13 Feb 2026 13:50:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19023

Define a BBSETUP_COLOR global variable that holds the color choice
optionally passed from the command-line. This will be re-used in the
next commits to force subprocess commands to color their outputs, as
passing --color=auto in them always render without coloring.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 bin/bitbake-setup | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 927c03a1033..547d3f36bff 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -29,6 +29,8 @@ import bb.process
 
 logger = bb.msg.logger_create('bitbake-setup', sys.stdout)
 
+BBSETUP_COLOR = False
+
 # These settings can only be set in the global context
 GLOBAL_ONLY_SETTINGS = (
     "top-dir-prefix",
@@ -1095,6 +1097,10 @@ def main():
     elif args.quiet:
         logger.setLevel(logging.ERROR)
 
+    global BBSETUP_COLOR
+    if args.color == 'always' or (args.color == 'auto' and sys.stdout.isatty() and os.environ.get('NO_COLOR', '') == ''):
+        BBSETUP_COLOR = True
+
     # Need to re-run logger_create with color argument
     # (will be the same logger since it has the same name)
     bb.msg.logger_create('bitbake-setup', output=sys.stdout,

-- 
2.52.0


