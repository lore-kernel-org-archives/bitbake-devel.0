Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB9BC79F9E
	for <webhook@archiver.kernel.org>; Mon,  7 Sep 2026 13:23:12 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34608.1788787388042277535
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Sep 2026 06:23:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=B1Umn8AO;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 01EAD1A1A0C;
	Mon,  7 Sep 2026 13:23:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BFDE960383;
	Mon,  7 Sep 2026 13:23:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B237B11C79257;
	Mon,  7 Sep 2026 15:23:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788787385; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=/Rl4PYonVRFCb1GVkgFmxe/VG0rwE7tfLncwo8fl7TI=;
	b=B1Umn8AOfwtiSSRNaQxIIn5oszjF+eNOvAiiHTSVD0NRnp0W6/ilC1EIXS3m6N1PHKwTrg
	9B0uqvnH60pUopD4U+XGU5F2ueiyGaHl3HnbNZL2h58zY5ltCDpRs1c1zO+zmHo+cfGF6P
	MKhe7Kbm0G1KQCJx4pBtnCs5T/gv5stVQeBu20n/Y1Sr62kVJ3gbM5lTbhXiLSCbP/b27l
	u2EpzAMruL5Fxv2WFufc5fp1EeSQuU5iFh2dKwxGYWfhEADJZDrJK6EU+3CKucKDBTWDz3
	Z49i7UW1ZSD08M5oZqGvgM9w5mWIJCvhOgw8RW0njPz18B73G5Rwq84TQoQucQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Mon, 07 Sep 2026 15:22:41 +0200
Subject: [PATCH] doc/bitbake-user-manual-metadata: move := section before
 ??=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-move-immediation-expansion-section-v1-1-bec1783e32ea@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNSQqEMBBFryK17kAUB+yrNL2ISdmWkIGUiiDe3
 dJevscfDmDMhAzv4oCMGzHFIFC+CrCTCT9U5ISh0lWre90pHzdx3qMjs0hY4Z5MuGuK0T5mHEp
 nG2vapq5BhlLGkfbn5PP9M6/DLOl7Gc7zAuzEEMaGAAAA
X-Change-ID: 20260907-move-immediation-expansion-section-fb1dc5ca6544
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2882;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=Mw9zBNJ3LoNXugyEpMBKWpFGN7wNv/FE1AwMLhj63/c=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBqnrq2kAMx7J/sStTAkLVIp+YuQul9MrfxUYLQz
 EVvAYjiO+OJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCap66tgAKCRDRgEFAKaOo
 NrnvEACOTJsfFBtxCxkdjQfosN9k6bJb6UxoFYXvPH2h+x9iHoDFTdN4RvhxYxREd5tjgEi3om+
 tIypVsMDE6E8Dg2JUIvXtwpd0ww0/xFN+GpZl0XsrzZagcqvbuSPa19IzUQNJqfQTEu92V2Bx8W
 NuWD7DKjD1fLl13ApkPytXOZb/UcW1FGtjmZxJGUnxEjOYQWf1ctX1gXsFX0loLzXKs6hPcA5Vv
 BaszwM4nGZhePpSTvtslj6qCNK3K4mMF/1CQ3vxpFa/foGVVWJQJ7xcDPhssz8w4IHuOXFyX77G
 DZyDeXIR4Ouu84qhU0G2plH4jzIIfDBVdmQE8LPK0zc53xUJ/lZeOICgeLkrNC1y56q5plfUFFT
 euDZiwTaYlZ8vQ/bHIE+07cS3WGhC1jk4/PMsPalYc/vopwCjW+7iatMavImSz6HHty00/DrWgm
 ggIPVvSEWkGSMokLVxYufHxHP0Cn2OttVpvW1kQcCzxX7ZK0oID85PYIaciVkMFQ6115l4aGnFj
 +U4zqirIlGneKsQwRUJQtLkF57AHWi8MFoesbC2Hw5qkiRSrwP/iQwH2LadQx3Ht5aL7eEa3KXU
 2T1nSDSrCqgGz0qYM6xYN6Ck4v7eWeGS+NXTt0r0YgrVeo1eTmnMjMnxK0FgyMI+gwzXjU7QA8d
 QOSB7RuiHX/sARw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Sep 2026 13:23:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20161

Move the immediate expansion section to be after the normal expansion
section and before default value section. This improves the reading flow
for two reasons:

- the reader can compare it with normal expansion directly.
- the weak default value section's example makes use of the
  immediate expansion operator, so it makes sense to already have it
  introduced at this point.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 .../bitbake-user-manual-metadata.rst               | 40 +++++++++++-----------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index b0535b5dd45..5c49cf37e1e 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -172,6 +172,26 @@ assignment, ``BAR`` expands to the literal string "${FOO}" as long as
 
    BAR = "${FOO}"
 
+Immediate variable expansion (:=)
+---------------------------------
+
+The ":=" operator results in a variable's contents being expanded
+immediately, rather than when the variable is actually used::
+
+   T = "123"
+   A := "test ${T}"
+   T = "456"
+   B := "${T} ${C}"
+   C = "cval"
+   C := "${C}append"
+
+In this example, ``A`` contains "test 123", even though the final value
+of :term:`T` is "456". The variable :term:`B` will end up containing "456
+cvalappend". This is because references to undefined variables are
+preserved as is during (immediate)expansion. This is in contrast to GNU
+Make, where undefined variables expand to nothing. The variable ``C``
+contains "cvalappend" since ``${C}`` immediately expands to "cval".
+
 Setting a default value (?=)
 ----------------------------
 
@@ -235,26 +255,6 @@ After parsing we will have::
 
    W = "xy"
 
-Immediate variable expansion (:=)
----------------------------------
-
-The ":=" operator results in a variable's contents being expanded
-immediately, rather than when the variable is actually used::
-
-   T = "123"
-   A := "test ${T}"
-   T = "456"
-   B := "${T} ${C}"
-   C = "cval"
-   C := "${C}append"
-
-In this example, ``A`` contains "test 123", even though the final value
-of :term:`T` is "456". The variable :term:`B` will end up containing "456
-cvalappend". This is because references to undefined variables are
-preserved as is during (immediate)expansion. This is in contrast to GNU
-Make, where undefined variables expand to nothing. The variable ``C``
-contains "cvalappend" since ``${C}`` immediately expands to "cval".
-
 .. _appending-and-prepending:
 
 Appending (+=) and prepending (=+) With Spaces

---
base-commit: 18cca50ba3da5ce27bc674478957bb08e7536b9a
change-id: 20260907-move-immediation-expansion-section-fb1dc5ca6544


