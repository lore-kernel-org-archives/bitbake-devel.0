Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E97CD4851
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 10:58:25 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8089.1778756295379296939
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 May 2026 03:58:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=Lve6QsqR;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id F105EC5DC69
	for <bitbake-devel@lists.openembedded.org>; Thu, 14 May 2026 10:59:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E534C60495;
	Thu, 14 May 2026 10:58:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D2A6A11AF8A6C;
	Thu, 14 May 2026 12:58:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778756292; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=Cug/SUhHGWgRcWxfZE5nAsJlFKLY3ac7UFFxANRuHDs=;
	b=Lve6QsqRFxGZxpX2J6IzEeKzRi4ClGD/UCbXxe9hOI5wr5uweqSWn19r2TM6X1+YMX6DUt
	l+PY8DqhbT/Pu+3babxrOIDrhR/KRMMN2Lr/QtHxvJjUQLKQz+Mwl9AiCWPOz50+ft+OYg
	LT9YrwbafP+s6jLlD0uoJAXkGAybheYbEHsNQy3+9cofGji7v5C79ReasWkD7UKysznOSr
	OXg4KknYMVKk3Y6AzwkNSRp2LvZ5IWaNfhuSkcsEtfn1Wq5ueXlLGFlWLNMbDeo2uJjl9M
	DPXhf9CphynzKGUlSlZ9xQfecvLyfdqCRllwPlJwg3FlAFk67LI3fVpeJxjLpA==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [PATCH 0/2] doc: setversions.py fixes
Date: Thu, 14 May 2026 12:53:13 +0200
Message-Id: <20260514-set-versions-fixes-v1-0-70b1fcdda8ee@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQ5AQBAEvyJzNgmCbHxFHFiNcUB22EjE3y2Ol
 erqixROoFRFFzl4UVmXAGkckZ3aZQRLH5iyJCuTIs1ZsbOHe3fKg5xQNqaE6YvWDBYUws3hE6G
 rm5/16GbY/X2i+34AfP5S6nYAAAA=
X-Change-ID: 20260514-set-versions-fixes-886e8d5a8fce
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=444;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=WlM+JIHQeeorvk5dc3zxI40v01CVVlc+sKO03NC+0zc=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBqBaq+UcjMfXXj+SO5hT+BwV+Utwmk2w0rbrVU0
 9zFkqg1KPiJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCagWqvgAKCRDRgEFAKaOo
 NrSlD/9XKniq0KRPX5SM8+dyXTJ9O8aHwtQTh3b3lGIqY/wgbM9cbL30kRIgJ/DKai1vD155Sp1
 LCUnB5o86Us+3vof3AuGiTh0sJoJzRvlYsv8XC970qrmpuDQ61Q6+p9KRz+A1qaMPfVQcTutIRv
 JJElyEOVJH+hWNp51Drf4wiXuKVx4cpOYt9zBwbqYLcNfCkUVBrVQY8Mb2EWyTUFFcBVS8AfWNO
 Hqy3keZRN7Z2ljCSVMSx2cqFJn66h8Gh2cIojrgiCn9CIsD49Di1N3SwX2uE61BYlqND0+5bWIP
 g+to6B72AS2I1GbBPMO15Jz0Fa80iyCS+lplo1PbnIlcauQSDyiTeqai8tgQpi+Zi7AP00/A7XU
 5BmRGhi+QZJfjyXLUVpOG6saHWGiXALXz1ay7DtJNBW7/WazWrSX2IO9MfRZZ8ws9WTSCpzjrLJ
 gweerlqnYMGACIMbsG+7PL1CmldrEhcaP3fqcTOfYfkTGVr/EYvVnSLQ5ot0O/QfGVET6wteW6Q
 YaY1j20blu8TzuxtuRGIVhwe5nCI8gCHhhFq8o0KY4asfHIDjNdqQFsclTbdFFfdvC3ExGrWndV
 ld61210m8JCYyFw4GG0/Bx8YiSaDVYf60BgJryeVmdHjq7999G9P2Qkom0+/jPsmwYOvSUcudy1
 9Q7RWVqzsKbZQkw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 May 2026 10:58:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19519

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Antonin Godard (2):
      doc/setversions.py: move arg parsing to main function
      doc/setversions.py: use older lts series to check tag existence

 doc/setversions.py | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)
---
base-commit: 2b47c2fc40b753e260b63ec419edfd1f85adff90
change-id: 20260514-set-versions-fixes-886e8d5a8fce


