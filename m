Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAA2C54F4C
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 07:20:22 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6525.1785223218707878997
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 28 Jul 2026 00:20:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=QZPv4fAe;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 80B504E40FBA
	for <bitbake-devel@lists.openembedded.org>; Tue, 28 Jul 2026 07:20:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 559E1601BF;
	Tue, 28 Jul 2026 07:20:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4944911C13DB6;
	Tue, 28 Jul 2026 09:20:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785223211; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=5JxV6ZxjZaQ41faIUi/Hd+fQb0Fs/uDDGPnuC36NOc4=;
	b=QZPv4fAeQ9n+tg/77uH5PKG0d+eyesqHPdx9ilXVTJt1k1BjE3e5QJan2+JrS82NwD78Kd
	Flrs3k0WUJAy3GrkQOmz++kDwmEIh3aYHrgSAr9wriNuXKA0XM21CM3jQT5Y69mgNi91IM
	rcVXJN9CYXvO5uaDRQYi61tUW1mJsyOaCzSEujLA1Gw7F/Q3wm0/Ksm0bTs+BLLeB1QHZx
	SayoWOdjEkj21f6MAsWr5DLFNrgzYGb+0kRxbScc1jWWyYJpdgiyJKIObliLn8qoUTzUYI
	PbJHbAmaCxuuTmuEY4wSjkqp3Bu1cCT4nIs6k/qTFnQjkdzWL9SOWzAAkcQS8g==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 28 Jul 2026 09:19:46 +0200
Subject: [PATCH] doc: bitbake-user-manual-metadata.rst: fix append example
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-fix-append-example-v1-1-b590f9e91d38@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ6CMBCE4Vche3aT0kMRX8V4WMogS7A2LRoSw
 rtT8fglM/9GGUmR6VZtlPDVrO9QUF8q8qOEJ1j7YrLGOtPYKw+6ssSI0DNWecUZLLVxtnWNDJ2
 ncowJZXVG74+/86eb4Jdfifb9AMXjwEF2AAAA
X-Change-ID: 20260728-fix-append-example-a1062967afbc
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=972;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=NBog2HwDnVfiTYt7yPVawFPG0UmqR60bFFSjsz6fM+0=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBqaFgq9HUSYcbjmV8CrVLnm20OuyGZJcwyxyJ34
 Mm0ID3HwgaJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCamhYKgAKCRDRgEFAKaOo
 NnRdEAC2rYoA1piPdXp0IC/luUCKZ4hBWF7a9vxOfBrhb1TVpTKq+St3vm8Xhv0ghk0S9Wcgpwx
 Vhce5IMB+TWf750fF7bEYcfhNnekEAjOSqMNck3RQyu8nEwdBkcFRoHSc82mTHhCapy41ixmc61
 kzKahZdIFMYPkElgB4RQ9fMR9aSckrFFjExk2sohM7oILGdbAbpCuuZ1Pb1te+5PRoDoVENDGOF
 cOVXOjhD2/RS9z6T3KXpKpee9Z5D3faV8ZoP12EeByR1pF+gg3+MmrNODzZRovNDQ0WX2ihVADw
 JrqGqvECSQSh2WjzEG5rzudtOnj2CKznKgs1XzbkID1A+KSdcROe0pEdD1tmOzWI4xJNsyjg1ND
 a/lviv4MvrJJkzbyYAZ5j9aHvTQic1MYJfUPdDQt6+/oufSfjI/x2T7p3aXGqdUveER8790PV+m
 ZxnPcW9rdskozSW4T0WszjdY0kgHPTJhfskoJW7ZoiUPLOs4k8Y+NuIcjEip1rQK/1Jdn06TFfy
 c5RiJc912z0LXitkl5i+Rt7/B1gpMSjP6S7Wn/OLV6eg1GE3psF7JJIlOeRrE2S9PoVVh91b8GU
 achXoiyKpabitybOiBJtxcxoW6bhnxjfDYIDHKYm1sF3pxGX885QL1PWW+3FJDWxoLrxdUrDqsJ
 vdluXv+xL9g+zFw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 28 Jul 2026 07:20:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19866

Add the missing whitespace in the combined override example, so it
matches the evaluation we give afterwards.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 0c7c3ff99b2..de62fc3b219 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -608,7 +608,7 @@ variable.
 
       DEPENDS = "glibc ncurses"
       OVERRIDES = "machine:local"
-      DEPENDS:append:machine = "libmad"
+      DEPENDS:append:machine = " libmad"
 
    In this example, :term:`DEPENDS` becomes "glibc ncurses libmad".
 

---
base-commit: ee6143138f1cd810669c4057df2b24efe6f46f1a
change-id: 20260728-fix-append-example-a1062967afbc


