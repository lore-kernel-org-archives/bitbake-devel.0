Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA7DD11183
	for <webhook@archiver.kernel.org>; Thu, 27 Nov 2025 09:42:25 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15149.1764236538385066519
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Nov 2025 01:42:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=mOXdd8On;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 52B031A1DBE;
	Thu, 27 Nov 2025 09:42:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 269E56068C;
	Thu, 27 Nov 2025 09:42:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 90CA2102F2328;
	Thu, 27 Nov 2025 10:42:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764236535; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=m0Fm8L8Y1IQ2V0pFqdMQNh4aplc0FRQFpFppeYLzspY=;
	b=mOXdd8Onfo3NCytC9704qKKMoutF9vNkjuRrfEigUpIxZe1JIxqv+vSQ206/uVrw4QE522
	rFZL4heQ7qg9p3AjS1oGyArdKbPL8B3FmAIsHkNjWqN7vsAB/HVzygjidkyWd8e2KDYb11
	A1lpjpA2i0NE5s4gAdtWKAttqtStZRhRPTrxTz79LZ+NoQT21COFHZf+EqRp4+C+aq/KI8
	ExeINl/exdnvB5zA+RKegWpRMRA3QZmwIe3TnxqgFhZjZvXfjiNUnp8dI6p3Tz1WGV+z1v
	0AghH1okcWOy+1UMceJgIdV9O33TXCqxD5tx1mqC4nQP7D3EYKHJ6qPGqE14KA==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Thu, 27 Nov 2025 10:42:03 +0100
Subject: [PATCH] doc/bitbake-user-manual-ref-variables.rst: update pressure
 monitoring instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251127-update-bb-pressure-instructions-v1-1-36f69a25d4ef@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAOocKGkC/yWNSwoCQQwFrzJkbcBuogNeRVz0J2pctEPSLcIwd
 zfqsqBevRWMVdjgNK2g/BKTZ3MIuwnKPbUbo1RniPt4CCHOOJaaOmPOuCibDXWjWddRuk8NA3E
 lmomOKYFX3LrK+/dwvvzZRn5w6d8sbNsHOkhztYMAAAA=
X-Change-ID: 20251127-update-bb-pressure-instructions-14ed447446aa
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5125;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=ru7+nnQaYBVX6wceVB9/vTgHxCgnHL3sScVDNsKbpBs=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpKBz29/Zfi/fJBoPoGYmg7xsphV77OxJNi9td1
 zlMop6pZTiJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaSgc9gAKCRDRgEFAKaOo
 NmA5EACUoDf2Sv2NkyUR17ekTKvCNBAUG5MuUw6sY/VdEghyaxRIYBzB9NX5HbywYUWTOZ2wLP6
 kCteKTIc5bvm8Wf4tr3v5nfxW6/HbljmotTti5Pav+rtGH7MqcwSXX0s5bXwOeW2lZcVgfC/sl2
 WUoy62w4W5+tNwEVueuFRE8hgl2r2HRyoOah2H/R/LIjy53crgPqxwVUUsR2LtnZe9DF1g4yO7C
 3niAO8fFR7M2GXAIY+Jdp5MXabI8uZKZunvT1Z21aDXdg3L5TLXpQ6olx9pVeXNO0uYzI5psyTa
 siHMsM1pY2zE/nLqp0VaO0Twu90n7HfjaYOYOizB1pXIWf5LpCM2vCrjYVwS4uT2cJmdkEoO1PE
 pRjQ2Qj+DMt2gBh10CzvKb39SdkP/LQan78XhJ3eJ6ROZ1FclOtrVSb9if2E854iWgzXIrid6J+
 pJypJRqsQ8u8nlgv5NJ1Ua0qYmfg22DqSXDxjfsE2L3+Zsz00zmt2N4lDOS7aQNF3kd3wxDI6sT
 suCkXfh+v8PCkIEG7lzmK7V0w/CSBmN/6dF2iUwxF/WM0KhheGggv2hLO6CiTM6pjEbOjFSF858
 Z2RfOEZV++La7wf6U8OB40P1+BgFyRcarCgTIYWFLf3N3Dx5LriS6XmbsrUrDdCKk6OApSmKkHd
 HHdd7XCBbk5bYpg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Nov 2025 09:42:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18499

After commit d492bbf0503d ("knotty: Integrate PSI reporting into the
UI") on BitBake, the pressure information is no longer printed on the
console by default and has moved to its own log domain.

Update the BB_PRESSURE_* variable descriptions to show how to follow
these messages.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 .../bitbake-user-manual-ref-variables.rst          | 48 ++++++++++++++--------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 734c7858a2..339143d4ea 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -579,14 +579,18 @@ overview of their function and contents.
 
       .. note::
 
-         You may see numerous messages printed by BitBake in case the
-         :term:`BB_PRESSURE_MAX_CPU` is too low::
+         You can track the pressure information while a build is running with:
 
-            Pressure status changed to CPU: True, IO: False, Mem: False (CPU: 1105.9/2.0, IO: 0.0/2.0, Mem: 0.0/2.0) - using 1/64 bitbake threads
+         .. code-block:: shell
 
-         This means that the :term:`BB_PRESSURE_MAX_CPU` should be increased to
-         a reasonable value for limiting the CPU pressure on the system.
-         Monitor the varying value after ``CPU:`` above to set a sensible value.
+            $ tail -F tmp/log/cooker/<machine>/console-latest.log | grep "Pressure status changed"
+            NOTE: Pressure status changed to CPU: True, IO: False, Mem: False (CPU: 1105.9/2.0, IO: 0.0/2.0, Mem: 0.0/2.0) - using 1/64 bitbake threads
+            ...
+
+         If these messages are printed a lot, it means that the :term:`BB_PRESSURE_MAX_CPU`
+         should be increased to a reasonable value for limiting the CPU pressure
+         on the system. Monitor the varying value after ``CPU:`` above to set a
+         sensible value.
 
    :term:`BB_PRESSURE_MAX_IO`
       Specifies a maximum I/O pressure threshold, above which BitBake's
@@ -616,14 +620,18 @@ overview of their function and contents.
 
       .. note::
 
-         You may see numerous messages printed by BitBake in case the
-         :term:`BB_PRESSURE_MAX_IO` is too low::
+         You can track the pressure information while a build is running with:
+
+         .. code-block:: shell
 
-            Pressure status changed to CPU: None, IO: True, Mem: False (CPU: 2236.0/None, IO: 153.6/2.0, Mem: 0.0/2.0) - using 19/64 bitbake threads
+            $ tail -F tmp/log/cooker/<machine>/console-latest.log | grep "Pressure status changed"
+            NOTE: Pressure status changed to CPU: None, IO: True, Mem: False (CPU: 2236.0/None, IO: 153.6/2.0, Mem: 0.0/2.0) - using 19/64 bitbake threads
+            ...
 
-         This means that the :term:`BB_PRESSURE_MAX_IO` should be increased to
-         a reasonable value for limiting the I/O pressure on the system.
-         Monitor the varying value after ``IO:`` above to set a sensible value.
+         If these messages are printed a lot, it means that the :term:`BB_PRESSURE_MAX_IO` 
+         should be increased to a reasonable value for limiting the I/O pressure
+         on the system. Monitor the varying value after ``IO:`` above to set a
+         sensible value.
 
    :term:`BB_PRESSURE_MAX_MEMORY`
       Specifies a maximum memory pressure threshold, above which BitBake's
@@ -655,14 +663,18 @@ overview of their function and contents.
 
       .. note::
 
-         You may see numerous messages printed by BitBake in case the
-         :term:`BB_PRESSURE_MAX_MEMORY` is too low::
+         You can track the pressure information while a build is running with:
+
+         .. code-block:: shell
 
-            Pressure status changed to CPU: None, IO: False, Mem: True (CPU: 29.5/None, IO: 0.0/2.0, Mem: 2553.3/2.0) - using 17/64 bitbake threads
+            $ tail -F tmp/log/cooker/<machine>/console-latest.log | grep "Pressure status changed"
+            NOTE: Pressure status changed to CPU: None, IO: False, Mem: True (CPU: 29.5/None, IO: 0.0/2.0, Mem: 2553.3/2.0) - using 17/64 bitbake threads
+            ...
 
-         This means that the :term:`BB_PRESSURE_MAX_MEMORY` should be increased to
-         a reasonable value for limiting the memory pressure on the system.
-         Monitor the varying value after ``Mem:`` above to set a sensible value.
+         If these messages are printed a lot, it means that the :term:`BB_PRESSURE_MAX_MEMORY`
+         should be increased to a reasonable value for limiting the memory
+         pressure on the system. Monitor the varying value after ``Mem:`` above
+         to set a sensible value.
 
    :term:`BB_RUNFMT`
       Specifies the name of the executable script files (i.e. run files)

---
base-commit: 6ee4df8ab58e0175b43106d8a6cbac1f6ab8d022
change-id: 20251127-update-bb-pressure-instructions-14ed447446aa


