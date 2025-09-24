Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8739CAC5AE
	for <webhook@archiver.kernel.org>; Wed, 24 Sep 2025 13:48:28 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.web10.13576.1758721706017635541
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 24 Sep 2025 06:48:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=CzLMy2hV;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 45ED71A0F49
	for <bitbake-devel@lists.openembedded.org>; Wed, 24 Sep 2025 13:48:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0DB6160634
	for <bitbake-devel@lists.openembedded.org>; Wed, 24 Sep 2025 13:48:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E6C06102F16EF;
	Wed, 24 Sep 2025 15:48:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758721703; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=+LJb93sOIi8ElqHT0iBkCE2TYSH2yqKkUHYzJdtgH7E=;
	b=CzLMy2hV+wiXCA6tUou052ym1LEmtKDvwBZGc+/aRkYL7pswH+0KaMOvtZtqGktLZBwEDD
	A1OHXk+qJmXdU65ljyAvR7Hc4+HDvqMe25UMUenHS4MQoA8BdAd7k25MKw4IhrYil1cB2w
	wX35cTUh5Rfb2X/e17W7jWriXo07AMw+HODfEwSskhBMhaMC3WVu4zH7UG/E0cpljENrmJ
	w84H4LH1xBZPUVe9rWfCHfT75EVXnwyr5CgXVpJ/sxOOxwKjvOeDJNR8jJIcdPu1kyRv1Q
	XXQMVs7DQLl/lRdUfuWD+pYd+phAWPreOUI+897Gp5ze2K+7sCKmX4GWrWyoDw==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Wed, 24 Sep 2025 15:48:12 +0200
Subject: [PATCH] parse/ast: avoid AttributeError when built-in fragment
 variable isn't defined
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-fix-no-builtin-fragment-v1-1-4d7f734b6d21@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAJv202gC/yXM0Q6CMAyF4VchvbZJXZSAr2K8WKGDEi1mG8SE8
 O5MvfySc/4NkkSVBLdqgyirJp2t4HyqoBu9DYLaF4Mjd6XWXTDoB21GXvSZ1TBEP7zEMhI3zgd
 iqmuG8n5HKdNf+f74Oy08SZe/Odj3Ay2DfNZ7AAAA
X-Change-ID: 20250924-fix-no-builtin-fragment-0b82af0b066b
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1861;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=chEF2tK/SwLwApDpffTpwOzZgAvIZJ+spXmiTna7l7k=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBo0/akHBiBocvkZLef5DpPqEIDmO9DfqAJbpMm2
 87tUsnjZ2mJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaNP2pAAKCRDRgEFAKaOo
 NhpMD/46bVHnmOPjIcFOiOKq5bdRzIMNt4fd6mubVcVBbXFgE6XSE3cmDCYOtw7dwULvzn3Ai/b
 fr6f60SSjB3gmvw5k4QEqCAYqVHO5/xprl/zeuZy2qqe08GhrR9IUjTPFroszWr+/vOwvkg8ic2
 guoP+x7CKnBDA8YG+U/nXSIChpa3N7dsIsa5UdasL9GgeF24sgSc/kVl9M3Mf3pttszshZB0TJ+
 1NHWZelzbLJ51Eevukjpj3StYOm6E15uEEhZ4vhzETmUM3bFMD6nixJPMINKj/xv2qbmXJJ5Alk
 q0KZigcEb6ROHg6JF7uBGBcr5X1fyA/NK4E5xg1cMJ33Nwf7Rrk5+oJraktv3yiCf4uxAOAvrMk
 9jJzcKNWM5Jj17N1hbwPFFgSeSwFjOLV3ucVrvOJd1PKqxTsnVSSoD5r8izwLftzt1Dog34NDyr
 Cm38RvWCP2xUsmUqQbuRp08wasQ7PsGb1GJPIdaUwqI4Le12EZ1GzCBnnKYqzOs7gFkW8cTV3Ir
 jGSlZuu6NjEcz4aJO6CvYUpicDB5T0GIB8Op1snlBwRSc/YoFNYgdcHnsY16C7y8Oz6qxLfdpfN
 wwWvXX8rwEkcrGM+Yx+bMawGQZRu+VbJodW3r/mP6/JIOwLxXWOD0vOp/lMrp3jpsR/Tz+m8CaU
 n7BFPHu4wWWjm3Q==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 24 Sep 2025 13:48:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18088

When adding the following to a configuration file:

  addfragments ${FRAGMENTS_PREFIX} CUSTOM_FRAGMENTS FRAGMENTS_METADATA_VARS CUSTOM_FRAGMENTS_BUILTIN

Bitbake will fail with the following error if CUSTOM_FRAGMENTS_BUILTIN
is not defined yet:

  File ".../bitbake/lib/bb/parse/ast.py", line 374, in eval
    builtin_fragments = {f[0]:f[1] for f in [f.split(':') for f in data.getVar(self.builtin_fragments_variable).split()] }
                                                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  AttributeError: 'NoneType' object has no attribute 'split'

To be safe, check if the value returned by getVar is None.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 lib/bb/parse/ast.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 49a0788038..317f00d3bd 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -371,7 +371,10 @@ class AddFragmentsNode(AstNode):
         fragments = data.getVar(self.fragments_variable)
         layers = data.getVar('BBLAYERS')
         flagged_variables = data.getVar(self.flagged_variables_list_variable).split()
-        builtin_fragments = {f[0]:f[1] for f in [f.split(':') for f in data.getVar(self.builtin_fragments_variable).split()] }
+        builtin_fragments = {}
+        builtin_fragments_var = data.getVar(self.builtin_fragments_variable)
+        if builtin_fragments_var is not None:
+            builtin_fragments = {f[0]:f[1] for f in [f.split(':') for f in builtin_fragments_var.split()]}
 
         if not fragments:
             return

---
base-commit: 7bd36f6c6d33211bb2a6b6fc6d40bdbd83b8b7c3
change-id: 20250924-fix-no-builtin-fragment-0b82af0b066b

Best regards,
--  
Antonin Godard <antonin.godard@bootlin.com>


