Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB3FC8302D
	for <webhook@archiver.kernel.org>; Mon, 30 Jun 2025 12:45:19 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web11.39191.1751287510139102709
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Jun 2025 05:45:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=PXnmmiWq;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B70D34384C;
	Mon, 30 Jun 2025 12:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751287507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zalhPfJUJQVPJmFzg2p+YWqZtX2o7kY4g3f71uoEZzU=;
	b=PXnmmiWqTXJIeN+D95jcYG6EUwZNmUxGHRw61o0J11iBxnxUB1rNEVeacnxDK9foEFo1ee
	afID7QPSstEm1OsPca5Vo9Bsx5SbyMgr1z/GkKOyEnFEfJo+595InQ4Vrorbc5dWDwxf5u
	42c9CW2IFaXjFxLQMIRf6+A726sOZtjPHH0WuAlYo2shCjkPytr1OWAyv02gEneqMFLBHH
	2Jox9NAMPjDQcheI6P2nvxepB3CUcTBWoYs0lTN3MZBaVCTnZg8MSInyqpn9vmOuxKA2ZT
	IqqLB9nC9KuLtKwANTLY3l7a6B/PZxG7gwFGqz9mXYWV4OJYIsOWD3BaFgszpw==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Mon, 30 Jun 2025 14:44:59 +0200
Subject: [PATCH] doc: bitbake-user-manual-ref-variables: fixups
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-bb-pressure-doc-fixups-v1-1-d5463a3cff2f@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAMuGYmgC/yWMQQqDQAxFryJZNzCdoqJXKV3MxKhxoTLpSEG8u
 7EuH/+/t4NyElZoix0Sb6KyzAbPRwE0hnlglM4YvPOlq14OY8Q1sWpOjN1C2Msvr4q+Dj4SNaF
 uAphsH1v+4ffnZs1xYvpeNTiOE2vn9aR6AAAA
X-Change-ID: 20250630-bb-pressure-doc-fixups-27a2bcc9a79a
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Quentin Schulz <quentin.schulz@cherry.de>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4337;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=lZh/hYV8KXjxD9gDxUFlHbiO9oEZUDoOcL2SZLyH+sY=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBoYobSQnVtP8FqM2A4jRJYM8AztQzZx6tmSTyN/
 UgArgtEYhGJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaGKG0gAKCRDRgEFAKaOo
 Nnv6EACx8Ks0xqUijB/uKoyXjod+lkoNoUM/YhenDnQ0W2aDfHwINVl71uR/Vx8bWoQKRZUU2Tg
 ch/MFdFVsBCzvo5S/e9vrHzKAzQdQuZ3ths05+/3/gs9ERqKdN3CpQMDqDrs8yNd5dB45u/RXXz
 ugUb/EykOP3X3HbPeQ100s/rHeYw465hBKNnMfLFuBmZwV/HYRbgAmMyOYa5zzS/m/a3ow6Rbq9
 h+kPLN9t2ipFgfVJlEoYCt4ck5BLae5DM1ksTuDASzwKgdrpyL424j9HxokCjX1xB0t13PgPXIw
 kAncQeczm2g4lfl9iU/+sQYCucdNNMBNJkrlcCh/4G2Vi4Uk1TaJ7eLK55DcdKJMSl7tJZKhJan
 EU7kgv+G7trHOtIWP7RkfuYMYEDYCuxqDgi23pAld7hVHI5cZbJPldM34xM5wbFtFnmmakCRoNQ
 IGlkLHIFliQxqWwr7fF9k0yD5W4k5ME8y9DnkG+nn4rLBu9voogJwWafTyBj7247JdgC5JnZCC5
 EmpQT2OA90n9kx4QhfiUIYrIDHd58GcancTCHVDFXOUQ2CM8sBTruCTBOTxbiN6XW8qXZ+BUV/c
 GMpLYV7IC/ZUBNzLGhkqTxnTOOQbYeY56Y1OD+ahx5wGNgXm6pRl0DTz9vGCKhDxUmlSzRU1pgk
 jQ9YZg1ko0KuW4g==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudejfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpeetnhhtohhnihhnucfiohgurghrugcuoegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptdegteehlefgheegvddufeevheehveeijedvfeduvdefvdekueduuedvjeelteehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeftgekudemvggsrgejmedusgeksgemrgehtgelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeftgekudemvggsrgejmedusgeksgemrgehtgelpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohephedprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegsihhtsggrkhgvqdguvghvvghlsehlihhsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrg
 hdprhgtphhtthhopeguohgtsheslhhishhtshdrhihotghtohhprhhojhgvtghtrdhorhhgpdhrtghpthhtoheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhrtghpthhtohepqhhuvghnthhinhdrshgthhhulhiisegthhgvrhhrhidruggv
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 Jun 2025 12:45:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17730

Fix typos reported by Quentin here:
https://lore.kernel.org/r/cee995db-4c3d-4bf0-813d-ce3f5f8f92e3@cherry.de
https://lore.kernel.org/r/73497b5e-721e-4e5f-beb4-c56ab9178c9f@cherry.de

Cc: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 .../bitbake-user-manual-ref-variables.rst          | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 6be8dbbf63..4ff95ea7ac 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -311,9 +311,9 @@ overview of their function and contents.
       For example usage, see :term:`BB_GIT_SHALLOW`.
 
    :term:`BB_GIT_DEFAULT_DESTSUFFIX`
-      The default destination directory where the Git fetcher unpacks the
-      source code. If this variable is not set, the source code is unpacked in a
-      directory named "git".
+      The default destination directory where the :ref:`Git fetcher
+      <git-fetcher>` unpacks the source code. If this variable is not set, the
+      source code is unpacked in a directory named "git".
 
    :term:`BB_GIT_SHALLOW`
       Setting this variable to "1" enables the support for fetching, using and
@@ -547,19 +547,19 @@ overview of their function and contents.
          BB_PRESSURE_MAX_CPU = "15000"
 
       Multiple values should be tested on the build host to determine what suits
-      best, depending on the need for performances versus load average during
+      best, depending on the need for performance versus load average during
       the build.
 
       .. note::
 
-         You may see numerous messages printed by BitBake in the case the
-         :term:`BB_PRESSURE_MAX_CPU` is too low:
+         You may see numerous messages printed by BitBake in case the
+         :term:`BB_PRESSURE_MAX_CPU` is too low::
 
             Pressure status changed to CPU: True, IO: False, Mem: False (CPU: 1105.9/2.0, IO: 0.0/2.0, Mem: 0.0/2.0) - using 1/64 bitbake threads
 
          This means that the :term:`BB_PRESSURE_MAX_CPU` should be increased to
          a reasonable value for limiting the CPU pressure on the system.
-         Monitor the varying value after ``IO:`` above to set a sensible value.
+         Monitor the varying value after ``CPU:`` above to set a sensible value.
 
    :term:`BB_PRESSURE_MAX_IO`
       Specifies a maximum I/O pressure threshold, above which BitBake's
@@ -584,12 +584,12 @@ overview of their function and contents.
          BB_PRESSURE_MAX_IO = "15000"
 
       Multiple values should be tested on the build host to determine what suits
-      best, depending on the need for performances versus I/O usage during the
+      best, depending on the need for performance versus I/O usage during the
       build.
 
       .. note::
 
-         You may see numerous messages printed by BitBake in the case the
+         You may see numerous messages printed by BitBake in case the
          :term:`BB_PRESSURE_MAX_IO` is too low::
 
             Pressure status changed to CPU: None, IO: True, Mem: False (CPU: 2236.0/None, IO: 153.6/2.0, Mem: 0.0/2.0) - using 19/64 bitbake threads
@@ -623,12 +623,12 @@ overview of their function and contents.
          BB_PRESSURE_MAX_MEMORY = "15000"
 
       Multiple values should be tested on the build host to determine what suits
-      best, depending on the need for performances versus memory consumption
+      best, depending on the need for performance versus memory consumption
       during the build.
 
       .. note::
 
-         You may see numerous messages printed by BitBake in the case the
+         You may see numerous messages printed by BitBake in case the
          :term:`BB_PRESSURE_MAX_MEMORY` is too low::
 
             Pressure status changed to CPU: None, IO: False, Mem: True (CPU: 29.5/None, IO: 0.0/2.0, Mem: 2553.3/2.0) - using 17/64 bitbake threads

---
base-commit: 09baa527dafca4bdf56a9189f6b3f7512886cbfb
change-id: 20250630-bb-pressure-doc-fixups-27a2bcc9a79a

Best regards,
--  
Antonin Godard <antonin.godard@bootlin.com>


