Return-Path: <frieder.schrempf@kontron.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D34DCD484A
	for <webhook@archiver.kernel.org>; Mon, 11 May 2026 15:37:22 +0000 (UTC)
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.52924.1778513832876118088
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 11 May 2026 08:37:13 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@fris.de header.s=mail header.b=YgRoH3KG;
 spf=pass (domain: fris.de, ip: 116.203.77.234, mailfrom: frieder@fris.de)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
	t=1778513829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+ipR22YTAStoOb68YukHm73kYrGw3WBRF6H88UfjlcE=;
	b=YgRoH3KGL6Sk3sih8NvAfIYIBwac2LrHt5fo2Jtx2hhEt3DimwhOaG04zFRSaUl5/CgaVP
	vG/O/aI7cLhovffFumRoA1Zr0V03kvQhP48n98yGSToK78UAz9aLLGFBXvSiafxXmhUqYf
	4RO+9Gobz2tDjP0T9swQEifMt22nzl80ssc7zigu7XkmHNXUcPNWZyt5ygA2A+0JrEn5BD
	4UdHhzj3WiuSdBszS3kcXuQ3HwC34cxivlBnZZqOPcLJiKAoXnFaCjTYn/FMfDP2uABKvd
	sNhPNypaLTJe6bIpWo0rlyLnmhn2Fk3rvC8sjaCATejjEJu/7llXV9L/CmAQUQ==
To: bitbake-devel@lists.openembedded.org
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: [PATCH 1/2] contrib: hashserv: Dockerfile: Remove non-existent lib/codegen.py
Date: Mon, 11 May 2026 17:36:31 +0200
Message-ID: <20260511153632.299677-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 11 May 2026 15:37:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19492

From: Frieder Schrempf <frieder.schrempf@kontron.de>

This file has been removed and is not required anymore.
Fix the Docker image build accordingly.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 contrib/hashserv/Dockerfile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/contrib/hashserv/Dockerfile b/contrib/hashserv/Dockerfile
index aec1f86fc..fe7e091ec 100644
--- a/contrib/hashserv/Dockerfile
+++ b/contrib/hashserv/Dockerfile
@@ -16,7 +16,6 @@ RUN apk add --no-cache python3 libgcc
 COPY bin/bitbake-hashserv /opt/bbhashserv/bin/
 COPY lib/hashserv /opt/bbhashserv/lib/hashserv/
 COPY lib/bb /opt/bbhashserv/lib/bb/
-COPY lib/codegen.py /opt/bbhashserv/lib/codegen.py
 COPY lib/ply /opt/bbhashserv/lib/ply/
 COPY lib/bs4 /opt/bbhashserv/lib/bs4/
=20
--=20
2.54.0


