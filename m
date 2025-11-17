Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55621CEBF61
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 08:16:11 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5029.1763367367788618264
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Nov 2025 00:16:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=UNqKVsuF;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 5C87CC1264F
	for <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 08:15:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E03C3606B9
	for <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 08:16:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5E92A103716CF;
	Mon, 17 Nov 2025 09:16:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763367364; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=KvgJxUBBMW/OEHlHIQ2kVdyBkFIEE7OHI2wxEQEVnjM=;
	b=UNqKVsuFv/CgCuP5yQzGh4RYQbrfXOjijv6clbMtocAw1TIBSx3bQULeg1oHmwaCviOMqA
	r30xncWeuPrSaPck5wvD4Divc9wzFEVhKcpX866fS/fnvTa+jePxoG3laZSMofs8xQbv6/
	432810bxlfJxR+/CG+4N15XNA47LtfbLdzo+yh9RAtGXjT1HhckG5mrf6HyX8znuMgrqkn
	1aw6cmHD3WipFKdclKccrqc3vDD/629jI8JGBr+SbTyqpgrlRs5sRVVbpVc1y2Z9tHXQ+8
	8TWxVU3YPrqxlFLEkKNEnpO42GO6s3DqZpG3Qys3JRtj8iUV/ZPwzgts2LxdPA==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [PATCH v2 0/3] bitbake-setup init improvements
Date: Mon, 17 Nov 2025 09:15:36 +0100
Message-Id: <20251117-bitbake-setup-abort-v2-0-a73f44e83bc0@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKnZGmkC/32Nyw6CMBBFf4XM2jG0BRVX/odh0ZZBxkdL2kI0h
 H8XcO/yJOeeO0GkwBThnE0QaOTI3i0gdxnYTrsbITcLg8xlKYQo0HAy+kEYKQ09auNDwpMulVI
 2LyrSsCz7QC2/t+q1/nEczJ1sWlOr0XFMPny221Gs3v+HUWCOjWyr6nBsWmXExXifnuz21r+gn
 uf5C+Sw8hrKAAAA
X-Change-ID: 20251114-bitbake-setup-abort-8a5333c049ea
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=980;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=Nb8wRUjRmcHkpleZydmPkFWYLu9UtL1grsp74mBcbhI=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpGtnCxXnh0shSC5sftsGhm5/GNKgJ5B+WlXahF
 dAjekoqtJmJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaRrZwgAKCRDRgEFAKaOo
 NhzqEACf272NaYmKuc7K/yZ5BlQnsAnoG+zKUs/qPaDGclyBkHQJZCnBKQtsrdrtbvTAUO+C82F
 dN/0RDmlqE5KzBsZFMLIJ2FJrY3R3txmauAgYvVU1FTtqNCsAN1v45ZLCvlrPmf2NU/7IPyj9dE
 2kzl6HiSuSowsL6H0XbQm88/do9uPaMYNheW4mx+m+RSRt7uAtSUCLC15RakFNGipShYGjQ75es
 AEvDsWT9dd9zX/nx/q9LaiE3Jzg1f1w3VstmpBrX0vyfsU5ZYkPDQAEEXBee2ZqKZi2Tq3AOmpk
 gSrul6K7EArUhA+UMhel2kgGR1jHxYdbVsXpGMh2jLF+OZ7o5d7L389+Ejf3WZDfpi+Ucbj33Jp
 LEcPJYtjQpfyM3EBfrnXke+WVcbLZQJ2EzVFfhIiTpsR9zXYpoOj/dnGZPSvhHx57OSKxw5IBG9
 jwVfWbEkjybVWTmJF69xoDEgv3ycOCuoK8256J8FCIztcFi+wbpaN47K+VhBzqn+fP5W/vdyeLL
 sIzsbkwaQdTtQxGugwuGIDoNL1KNsI/TTy7T6kR1V+Vynv2rhOyLSXnlD+39SfHl9/teZjH22y6
 bnFiVr/7xIVfXeyIyFzG/5y3lsft6ToopytLH6AtXLt/+6T19MjK12zKppeIljsUJPHqPmWmqRI
 99hBlHE+ScL4prg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 08:16:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18415

Improve the init user experience by:

- Creating the top directory only when we need it (and avoid leaving
  empty directories behind)
- Print a message when a user sends Ctrl+C

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Changes in v2:
- In the first patch mention that the top dir was created by chance.
- Add if..else so save_bb_cache() is still called after init.
- Make the sigint handler global, print message based on called
  function.
- Link to v1: https://lore.kernel.org/r/20251114-bitbake-setup-abort-v1-0-d2f9967df3b1@bootlin.com

---
Antonin Godard (3):
      bitbake-setup: fix top_dir creation in create_siteconf
      bitbake-setup: create top-dir later in init
      bitbake-setup: handle ctrl+c

 bin/bitbake-setup | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)
---
base-commit: fff23f8ce8f60aba6b89512a734623067661816e
change-id: 20251114-bitbake-setup-abort-8a5333c049ea


