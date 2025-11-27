Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650C7CFD2F6
	for <webhook@archiver.kernel.org>; Thu, 27 Nov 2025 16:42:18 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22682.1764261736186968786
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Nov 2025 08:42:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=WxSykctb;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C2024C16A1A
	for <bitbake-devel@lists.openembedded.org>; Thu, 27 Nov 2025 16:41:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7724E60722;
	Thu, 27 Nov 2025 16:42:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1B2E0102F2ABC;
	Thu, 27 Nov 2025 17:42:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764261732; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=dM33s4yK93Bz1WhWy7P4pVcVsftOJMjBL8EZ+E90G9o=;
	b=WxSykctbJrRVAIxRlT++h+V3tFZWfD3bJAiClOOq720WB7YGDhQhuh/NaaPsqnB+aK6IP1
	y4xx5uu3m6I4FD3OxPkeSLizwdq6fZYWehpVq+ymOoK/5t/3Dk5eY4e+BKEnYp8jLJfdeW
	migqXxvKumGgo0c2f7MMGuJFkhgU7Uk0pxgXYl0aNQxx+uTS+8SuedSOCJmR3NKMSfRgpg
	vv/Gko3kamjEFM2RahP1DswIabEneujUo9JxfymVoXO+26PDabIVdQ8olGnODBL8w8uc1G
	00c8Wyrg+PCH8xLBuBdKKxhLxs2L0YVp2UKlNrr8hqweeIVJRNL3FmwUIGgB5w==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Thu, 27 Nov 2025 17:42:08 +0100
Subject: [PATCH v2] doc/bitbake-user-manual-ref-variables.rst: update
 pressure monitoring instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251127-update-bb-pressure-instructions-v2-1-11f994dc3ff9@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAF9/KGkC/42OSw6CMBRFt0I6tsbWAtER+zAM+nnIM9qSvpZoC
 Hu34AYcnuTcz8IIIgKxa7WwCDMSBl9AHipmR+3vwNEVZvIkayFky/PkdAJuDJ8iEOVYDE8pZpt
 KlLhQ4JRqlWq0ZqWlWAO+94Vb/2PK5gE2bbWbMSKlED/7hVls3v9rs+CCn5uhuWhZOwVDZ0JIT
 /RHG16sX9f1Cxph9t/iAAAA
X-Change-ID: 20251127-update-bb-pressure-instructions-14ed447446aa
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Quentin Schulz <quentin.schulz@cherry.de>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5429;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=+rJay+NefCG3LteZdfL8tBU39gwnyVQURhA9BfsIogM=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpKH9j0/uMPNlu6P9urpPB5voIxrhaGnlkuyM4H
 8waxfOM5jiJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaSh/YwAKCRDRgEFAKaOo
 Nj1hD/0Qpju07tyQxdw8mAz+Z8+6YHXVtEauZLKBy2rhiJBE8IOR1lR5FUDcFBWHrUhfp3rhx8W
 vTqQVJHUqgu5z2QSZ9BhfUaJuL+dBUAvGxBFJhRvVMjU2A4wLxxpzYM3I6c5zkLZxy0jIMWsw3R
 Zp2ttLns4XvDz0++vhfr5ksor9GH6UcBXupAu6uQdxpwp2WkiX71lf/NI5iXWRUa0sAmRjWLjmS
 FSuldkWhAJegNEmXgHnJjpLuOIGtzRw0SknR6jWLRFcDcGzVCEM4z9vUwufPgUZ05bN8dikZ5Q2
 PPqy20qa7copgEE2b+bi8CzwNoAaEa6LESt9rQLkDYsLRjhIOE2af0ORQAGgd6OC5z9nJrNLYq/
 o7XckzHE5weK6SK7mbPSa9ibwg5Z8fJ3uZ2TypB93BxO8/pNSj3yzNrckOkeB0UunDiaFFe5kWZ
 oWSjTFsEaKUiZvuCJgfYyLSu3eb0BHqLDioxbCWi8jyMQ4zkUq+iFYqJlsg9BmJFY8ctOmY3H1n
 bj7zK3z4OmF0sZSxd5s6fRTBVQflkf3B/oRnZFTModvQWYws8xhyB2WZ/F01xEnHSvbIo7m3kOy
 2Q8CTYdripX11pit4hmDpz1q7C6AKMR4Id0nD2MuzWBsRy6SNrYqSH9X8a0g6llniX6KMoqshHV
 UuVZRGLhIUL2mpQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Nov 2025 16:42:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18504

After commit d492bbf0503d ("knotty: Integrate PSI reporting into the
UI") on BitBake, the pressure information is no longer printed on the
console by default and has moved to its own log domain.

Update the BB_PRESSURE_* variable descriptions to show how to follow
these messages.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Changes in v2:
- Suggested by Quentin (thanks!): Switch shell lexer to the console
  lexer, the output is rendered better.
- Link to v1: https://patch.msgid.link/20251127-update-bb-pressure-instructions-v1-1-36f69a25d4ef@bootlin.com
---
 .../bitbake-user-manual-ref-variables.rst          | 48 ++++++++++++++--------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 734c7858a2..c95583fa4b 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -579,14 +579,18 @@ overview of their function and contents.
 
       .. note::
 
-         You may see numerous messages printed by BitBake in case the
-         :term:`BB_PRESSURE_MAX_CPU` is too low::
+         You can track the pressure information while a build is running with:
 
-            Pressure status changed to CPU: True, IO: False, Mem: False (CPU: 1105.9/2.0, IO: 0.0/2.0, Mem: 0.0/2.0) - using 1/64 bitbake threads
+         .. code-block:: console
 
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
+         .. code-block:: console
 
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
+         .. code-block:: console
 
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


