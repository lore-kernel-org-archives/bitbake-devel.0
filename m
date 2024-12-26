Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9677E77188
	for <webhook@archiver.kernel.org>; Thu, 26 Dec 2024 16:12:12 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
 by mx.groups.io with SMTP id smtpd.web10.23536.1735229523281909964
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Dec 2024 08:12:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=py2dFlV/;
 spf=pass (domain: bootlin.com, ip: 217.70.183.195, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 21A4C60002;
	Thu, 26 Dec 2024 16:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735229521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F5IC+Oh7L1dvwioR1zsd1TUayJR+Ck4MaKFQbXmDWIs=;
	b=py2dFlV/xM/5rtXYmjY2rqeUOhkY6OwqINepTHtFvRkgU+40DdIfi31S2vSFAnrNUOvX9R
	gzhTXykZz6gNG49gWpT2wFlMTFFC+vxOJVC1BXSryDav5QZCqqmYYjZX/fTHh9fvFFiDIl
	vdb0XW3AZB1oLo3403lhTw5IXwArae43Xr5GF7g2jAtw7Q5kbsKtPnqVKw3sEKjRHSnIvb
	BGmzHHSSRJQi9NK1lOHVI356j9lFhoIT04OhJjX6RnXTvawSpE7n+3I/Usko/TJ+KdPyzs
	9kc5bv07IQOGKM7/kb/XKl8zlp22iUUU+hneejCMQ+Y9+F+PVRpvvVeTYqFDgg==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Thu, 26 Dec 2024 17:11:56 +0100
Subject: [PATCH] doc/bitbake-user-manual-metadata: fix unindent warnings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241226-fix-unindent-warnings-v1-1-a43febf7714a@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAEuAbWcC/x2MSwqAMAwFryJZG9CgIl5FXFQbNZsorT+Q3t3gb
 gbmvRciB+EIXfZC4EuibGpS5hlMq9OFUbw5UEFVSdTgLA+eKupZD7xdMFwiTqNvuSqoqakF2+6
 BLfx/+yGlD6ovBTRnAAAA
X-Change-ID: 20241226-fix-unindent-warnings-cbd8e4026528
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1800;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=iUz+aVcv0jTUjhag+R8LnScuA+4bpKZb21CHaG+iBys=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBnbYBQE8V8IorE6h90JmLbh0PIfHE74y7QR4HyI
 Wv5IRyMd1yJAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCZ22AUAAKCRDRgEFAKaOo
 Nhb7D/9uGhvJtT/3K9ls5J9vSOgOYFW4hsSQNGxI9dn6YTTQ2DUJi5O7SpIMRgL4BrfYUMXqMyZ
 b90uRsOSKqB0+E+QaHclBUWUY9S+Gh/fbNC9TkNUqCca947JrXjAxj+zVk9RXcrp76eRLDHBeET
 8ozEMDHGnv/oXRuBoLqa2h6VX2ZVs2hkJgCzdoEw0yC8s8QBhpuY0qF0XR8NPOvjCmOtRuhe8NY
 O+J+q2Mp6upWfl2hkhz2Aqkoqi+yn0S86J4/bNGSfRTFyej+67MDME8W04rlWAIgekGXzF9habo
 /hPh6zkucttRlorYYQ39v1tY9KQTeOqIIcKBIko/BTUUmnBMvtFi2dgNj4V9MRkaVa4T3T7g6F9
 78GBtu8FQqJL7HiLUm3iWwVAlP9VndffE1lUujWT87hmumhLcymzgQPRFOVBfZ1vYXXGxq710Na
 cIrELCQU+KDM+EE4cQycJukYmEcwsOMF9K87lKtpcrLDzbRqSaCVIFnY7cdWWlr9d+TWL+KgZaQ
 bI9AmKQMCUp+/lrl1zQ9FTHW07mOk/u6H9gLw61seD2FSTK4QdZO5EfFKjZuA3LK5iyUCThXaz5
 sXC8zB5DapmIa+FM3+7o1CYneOFq+E3jki7r4C3YAsjUtv6YL4R5U1QlU5jgQ5V365WzPO0R6rG
 Zh4E4ios9/ysifA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Dec 2024 16:12:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16949

Fix Sphinx warnings (treated as errors on local builds):

  bitbake-user-manual-metadata.rst:979: WARNING: Bullet list ends without a blank line; unexpected unindent.
  bitbake-user-manual-metadata.rst:982: WARNING: Bullet list ends without a blank line; unexpected unindent.
  bitbake-user-manual-metadata.rst:985: WARNING: Bullet list ends without a blank line; unexpected unindent.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 75930fef8294b21965d4b25dcb5837bfdca2b096..2680c6ac2c5686c7407329f762189c8ba1a9f33f 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -976,13 +976,13 @@ go into ``bitbake.conf``, for example::
 ``addfragments`` takes three parameters:
 
 -  path prefix for fragment files inside the layer file tree that bitbake
-uses to construct full paths to the fragment files
+   uses to construct full paths to the fragment files
 
 -  name of variable that holds the list of enabled fragments in an
-active build
+   active build
 
 -  name of variable that contains a list of variable names containing
-fragment-specific metadata (such as descriptions)
+   fragment-specific metadata (such as descriptions)
 
 This allows listing enabled configuration fragments in ``OE_FRAGMENTS``
 variable like this::

---
base-commit: c9906bb289dcfd9ae41f10bd5399ccc17a4cc437
change-id: 20241226-fix-unindent-warnings-cbd8e4026528

Best regards,
-- 
Antonin Godard <antonin.godard@bootlin.com>


