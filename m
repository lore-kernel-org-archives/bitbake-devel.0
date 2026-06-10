Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD0ACD98CC
	for <webhook@archiver.kernel.org>; Wed, 10 Jun 2026 08:29:26 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15490.1781080155781847663
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Jun 2026 01:29:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=ha1+QTvU;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A433B4E4082F
	for <bitbake-devel@lists.openembedded.org>; Wed, 10 Jun 2026 08:29:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 79BCF5FFC9;
	Wed, 10 Jun 2026 08:29:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1F94A106B9153;
	Wed, 10 Jun 2026 10:29:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781080152; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=IPK27e3KqtrzDztNyMoJ7eMH5jYJ5s0eQqVu9yM1wZI=;
	b=ha1+QTvUjbkMJQ6MBIuymvxVuLqhqcBbDf2p0GOeJRiimSI/bi2CO9mjI+uPUEYElgeiH5
	Z281n0uwkSKJrSd5vXQKoBqFGVnLaLO4Zc24smyfdk+607ec4WpT1MNi/lj/mhbqABG17I
	S/DeFaONLa6eTQ7EeMeN15zn4PuwA3j4O36QabeUZ0rJsPTDQ91UozrBaiIOeIoEKfg1yc
	3+Nh+I513ENJaUxf52x3mqWnOTo2JTx4ed9OJBhWZVzG7T5HSvi1fptufRNQ8xopl/2pA4
	4I7SfWfPZgRozLdBamVkGl47JJRJkV46Zuux5Hv5XJk88ryrthMkS2rOrbcXXQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Wed, 10 Jun 2026 10:28:51 +0200
Subject: [PATCH] doc/bitbake-user-manual-ref-variables: document
 BB_CONSOLE_LOG's persistence
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-bb-console-log-persistent-v1-1-5430d24061c3@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBBG4auUWTuQVCmtVxEXZvxbR0pSMqkIp
 Xc36vJbvLeRISuMzs1GGS81TbHCHxqSxy1OYL1XU+vaznXecQgsKVqawXOaeEE2tYJYWAYvOJ7
 82A891X7JGPX9e1+uf9sanpDyHdK+fwD0pIlPfQAAAA==
X-Change-ID: 20260610-bb-console-log-persistent-c91ce341f898
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Yoann Congal <yoann.congal@smile.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1476;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=FNXwukiNliKbSNOisBezSc314NnOUxnxeI6v3bvCLU4=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBqKSBXRlllfJNgsjSP+sfEJwdnQHAnymTVv9aOr
 lqOpHC15vOJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaikgVwAKCRDRgEFAKaOo
 Ni4ED/4/l0nlmGMiHLc8dImeTPMbRDBmueKZXJCC/Y5mCr3F6J8mXRpoYhfmRf46rr+BHecQS9u
 ztrJwTlNssSN+5OldnUTcdQjHkgwQ5JOqkX9YbXbHcpzBzUx1QT5uGNY1IvemukHMdW2ZdK9TR5
 B7CZW0lTgEnuveZeV+7E1IklyEEQz3C6yB2SWDLbFAeCT3s+8zYvnqpu3ggZ2K+6ayct51mm7rP
 eJAmR9G8St649H54z3XjkKz2F9WrOdV7xroxmOPgm8u9h6k00yN1OoY4r3FhmhxiuRmHokK6K5w
 UA53s6eGDrLEJt4mdVfb1ayFwcew41lcu//dzKBNkeRDYJXq6DXovrGWe6aCA7DIcuCznhS3mcn
 lt0s6Fqx5pdssz7ZLl/27cSXEyUsznYP83iArencbCromeK0C/QtiDHFAXJxNPUy5rIXGvLRLvQ
 zEU76gOn4CdLruV65+4zFd73rXenregYmVLnz1+FXTHlJT9q97mbEAllP/2Rc14GmR60iosiYjG
 ncTB5HxRZM4rOcB7QzXPWqfq1OHqVA2/oiBw+qVUtOJdZU738tJsfscyjpBa7ZTwtXNcTt9q0LV
 elv8WaOnE9yYZMhMeAwiQLxeaHyKOl990NDLDIECpAvC3HF1fVcwsbiepzy8Re2VNZrb1oB8jQ3
 wrcge2m8cSjyKhQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Jun 2026 08:29:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19640

Changes to this variable only take effect after a server restart.
Document this behavior.

[YOCTO #15641]

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 9824b58ef27..f3e1a3a38c9 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -135,6 +135,16 @@ overview of their function and contents.
       Specifies the path to a log file into which BitBake's user interface
       writes output during the build.
 
+      This variable's value remains persistent during the entire execution of
+      the BitBake server. Changes to this variable will only take effect
+      after a server restart, which can be accomplished with the ``bitbake
+      --kill-server`` command.
+
+      .. note::
+
+         For more details on how to make the BitBake server persistent, see the
+         :term:`BB_SERVER_TIMEOUT` variable.
+
    :term:`BB_CURRENTTASK`
       Contains the name of the currently running task. The name does not
       include the ``do_`` prefix.

---
base-commit: c687d42b81b17e7a2399099cab0f1a6aafcf6520
change-id: 20260610-bb-console-log-persistent-c91ce341f898


