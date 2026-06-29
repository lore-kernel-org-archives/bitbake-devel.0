Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA03C43458
	for <webhook@archiver.kernel.org>; Mon, 29 Jun 2026 13:03:34 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.91645.1782738206965288990
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 29 Jun 2026 06:03:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=KIsuRWjr;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A7AF74E40B66
	for <bitbake-devel@lists.openembedded.org>; Mon, 29 Jun 2026 13:03:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 76A625FF96
	for <bitbake-devel@lists.openembedded.org>; Mon, 29 Jun 2026 13:03:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 86CD4106F1799;
	Mon, 29 Jun 2026 15:03:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782738202; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=EkxFqZrvbYZ4ngC5Cud0UE8dJ2CaG4XKugZX5wHyjzo=;
	b=KIsuRWjrCulnhp0NuifnPXmytBqIf6Or58f2TCWG35j5OaQh95xTGRTzMIgk5u9vgVyQpO
	Twv3oL6u83WgHZpRMi/Uqg/PMIuUtYu5SvhAUcGSpYtyS31+6G2AGKopEl3xdte0RmBtEh
	foGPd16EsxGyGKvblxuiLT5zLfHYrfXWFONAWt0xjM0Esh45GRjGVsSo2MPI8H6Bu4Vz+8
	G9FF9Ox0ekPGkYwcJtsbu4nMqLbVa+Sc4cMv0pFL7by1Sl5VJmz6YC6qr+AWYYWaaeEfES
	gcD98ml2fnRS8l2Lo6wIRtb/oqgRldg+ti4r4V7c03X1dJBQsEw4TDAgnT9XcA==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Mon, 29 Jun 2026 15:03:11 +0200
Subject: [PATCH] contrib/prserv/Dockerfile: remove non-existent codegen.py
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-fix-prserv-dockerfile-v1-1-7db4b32288ce@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQqDMBAAvyJ7dkFTVPQr4sEkG7ttUdlYEcS/u
 +pxYGZ2iCRMEZpkB6GVI0+jQp4m4N79OBCyVwaTmTIrTY2BN5xFqxX95L4kgX+EhQ155W1livo
 F2s5CKt7ftns4/u2H3HLN4DhO8gcqunkAAAA=
X-Change-ID: 20260629-fix-prserv-dockerfile-5bf17db72593
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=863;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=UhX4TlWouznbz9E6BnP1XmUQoH+8/BTDRM5rTynO1AI=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBqQm0YxiXubgWGTGTSHSyqUzzq3FCNos4RqahOR
 8JJhoHi+WOJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCakJtGAAKCRDRgEFAKaOo
 Nqa/D/9Kuik5ylXETjIO2Cw+IUvc+oBpPfbOI6rCPtsiU2nxOQ6vCa0yIMOB9Ts1axg2UcOWrx0
 bj7eQprh8kfxnH1KgjEi+iaqk4P+JwzGj81EajYhVb6Yso9MmFf/vsaKa5xugamxrfeZ2SJahjy
 q6FZBILYUBQBrgK85aDVzYuQeP2n7rxL5BC8ORBgc3JvojVth7Y03pXe3YvScXvKH8lc17IN26B
 i260VyJTkwjEh+GajQsDPH+xlUa4L6T3oSHNiyCGC9sQykKGYaFDrci+Q804UVnqvwu3mSoHEyA
 kunuwmI9wKtKfxD92JEnsKOMuab03HPcHxhltHQ2+Aqq4REByr4USbvSLz4MwzCKct99RFbyMGS
 KmqfVL4V1wRDHv6Pl8YjCBkRqx7U7xx243Cr+g2s2mowRSO7fu90z7Rtz0hT5mxm3AD8jB5ARCa
 BoloFiOIgto7Wv0rq6R9m5psBSt4WvVi5n2sQVdm292GNK9P8NnU/jnK0fv5iBNsEazYEowqHRB
 zYm1yDYruy3wqOiIT2U91A8VISX4S7GhV8ugdo3J/QvcghsrwNqsx5+Bm7O7MiJUcrenjugoCL9
 Kme+P8CgtGoHsIYWuiYH6lpL8+Tm0+bOHuCBt0QSQtktUhAj3HFf4AlbKTGOnw4DzvLAuRj2rF1
 kiXSYKt+J4oJcPw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 29 Jun 2026 13:03:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19806

codegen was replace by ast.unparse() with 76dd6d69c59c ("lib: Replace
codegen with ast.unparse()"). Remove this COPY instruction.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 contrib/prserv/Dockerfile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/contrib/prserv/Dockerfile b/contrib/prserv/Dockerfile
index c630ce99722..694b9b9fead 100644
--- a/contrib/prserv/Dockerfile
+++ b/contrib/prserv/Dockerfile
@@ -35,7 +35,6 @@ RUN apk add --no-cache python3
 COPY bin/bitbake-prserv /opt/bbprserv/bin/
 COPY lib/prserv /opt/bbprserv/lib/prserv/
 COPY lib/bb /opt/bbprserv/lib/bb/
-COPY lib/codegen.py /opt/bbprserv/lib/codegen.py
 COPY lib/ply /opt/bbprserv/lib/ply/
 COPY lib/bs4 /opt/bbprserv/lib/bs4/
 

---
base-commit: 7e3489ab3ec39b2dcf4e50eff54d36d42e5a7307
change-id: 20260629-fix-prserv-dockerfile-5bf17db72593


