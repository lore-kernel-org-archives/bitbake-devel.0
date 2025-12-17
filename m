Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6D2D64096
	for <webhook@archiver.kernel.org>; Wed, 17 Dec 2025 08:48:54 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10000.1765961324881215595
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 17 Dec 2025 00:48:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=btv4TEBz;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4E2574E41C53
	for <bitbake-devel@lists.openembedded.org>; Wed, 17 Dec 2025 08:48:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1E7E46072F
	for <bitbake-devel@lists.openembedded.org>; Wed, 17 Dec 2025 08:48:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A9D3F1195033D;
	Wed, 17 Dec 2025 09:48:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1765961318; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=65P0we9a3JL6JrQpbMK0I92aG7VOqmWwMLYLHgLDEoE=;
	b=btv4TEBzzq85nnu3Al5WbFwy421G719f17mQNPu4jQWmwx2ZpDQRAk0e08c6JQuWZbiSki
	/q7WnJN/rvPGU7+3r7EZVsxe6VgFmNQlfwaT5vKF2pEsu3O889H4ZrIHo7y3kQpQGsOzkI
	zJSgURTo9OYS7M21z+VrB17PYG8J50IfZjPyZmzG2yF7Y+7IEyarhhl/9eGvjGEVhfavwD
	LcesKsCsKaCcArteE8CYSDJnHvzcgIHygJwVxiGOrf2CXO9jaj9RKgS9mj+d1RPDME6T8t
	BQSF8TCDP6MCkucyk0r88LXU7qY09q99MOsP/bJrLdmIRuaD24bUhwyojHCQPA==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Wed, 17 Dec 2025 09:48:26 +0100
Subject: [PATCH 1/2] bitbake-setup: remove logging stream configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-bbsetup-logger-v1-1-6bc7d02c11c6@bootlin.com>
References: <20251217-bbsetup-logger-v1-0-6bc7d02c11c6@bootlin.com>
In-Reply-To: <20251217-bbsetup-logger-v1-0-6bc7d02c11c6@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=977;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=F/4vQbxrFH1Oq+QW2iBOek5LrRFdkbwOkTxzlT3ifuo=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpQm5h3wf8spmWv46hZxC6/06l3kZmUHB73WdFq
 bwtKa+ayUOJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaUJuYQAKCRDRgEFAKaOo
 Nq99D/4z+0Hufs0+5HzNfOhxwq4syY/W+KrepHnUpicdI0HWC/UtRJK2tNzKfGYplWredSgXI3H
 Rp+9IzX9RzUJo1feyru8IFK9FG5oH4oU7AbWn00TAtC2zABKiVLE4vl4l9twtZK4dIB3iHTNS0x
 OaOsKClsJJIz8eeIGZK/Btd00Uy/2jhTmI3DgvtxCgx6zYHtrtsczmZC9GN16xUBHAavt4ZUcyp
 vdiMYlr4Hgaattqz41USoY1VtWwyceHMmr9UW8KFInLCVTBZH6q2XLYeodXZx75jrjd4cI3V1/M
 7g8HODtsLpky6e8HMi5pV2ByJ3HQp9/KAdujZEpdOTOvtUwerwfFytvfitd0GEMGeqfOdMcYx1n
 agbnNfpwUgH3Rax0e1ySD/moxFqEcxcXAxn+IAMoH/Pig0GVeX0LhKXJtCx4we11zoODFBf1jTh
 yd4pg3Cm8nEdp7delH56YRhAMgwm1Rr+QG5mB+JlNHPslpNDC5ofMD1/YvUXNhQD44wHstQhw0G
 4vCe+nYbExthcCBPLD0UDbawQRjjl3MwDCmfdOo9N8MaHdurJRwcFgcyAqh2eaiqvTBKb80v8Fq
 reFLJc5HwCLOa9KaVrwH+GKd3MDRpCKI9fAbaH6U2/jC9I1jS9WhSJqOQixsur3hWL1i1VudTqV
 Gc2StpY0UQtfK+g==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 17 Dec 2025 08:48:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18604

Right now if we leave this and use the existing logger (redefined below
with bb.msg.logger_create), we get all of the outputs twice. Example
with an existing print call converted to logger.error():

  $ bitbake-setup status --setup-dir whatever
  ERROR: Not a valid setup directory: build/init-build-env does not exist in whatever
  ERROR:bitbake-setup:Not a valid setup directory: build/init-build-env does not exist in whatever

Remove the call to logging.basicConfig to avoid this.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 bin/bitbake-setup | 1 -
 1 file changed, 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index b1d7518994..1d93ed05c1 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -935,7 +935,6 @@ def main():
 
     args = parser.parse_args()
 
-    logging.basicConfig(stream=sys.stdout)
     if args.debug:
         logger.setLevel(logging.DEBUG)
     elif args.quiet:

-- 
2.51.0


