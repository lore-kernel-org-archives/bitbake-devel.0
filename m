Return-Path: <frieder.schrempf@kontron.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032F6CD37B2
	for <webhook@archiver.kernel.org>; Mon, 11 May 2026 15:37:22 +0000 (UTC)
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.53295.1778513835196746261
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 11 May 2026 08:37:16 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@fris.de header.s=mail header.b=k0tFTWTs;
 spf=pass (domain: fris.de, ip: 116.203.77.234, mailfrom: frieder@fris.de)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
	t=1778513833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4wMts2N3LaHafaDP+FtBifaC9X6smSjV05Xeoi5qc/o=;
	b=k0tFTWTsYB+TTmdVAv27TpL4Uj+uzxpLafFHnyb0kaQ28hsCMeyh1+lF/YRdijPHQHn7Qi
	LxxxuKAa5nVF/DtT9pDWB2aL0DUyTvceb3U0NlcfF4wOSHsMRcY5xSwY6W4HkkhdW1W2+T
	5lhyhDHYaxISLqd83jLjWp/T6pYG2rAy7Awk/hGjrl/1KtQ45rX6CHTg+8nqC24WJUq4aM
	gR2zGGy/EVJ8Qp9DGuRwesh68nTaOGYkDEBNbLQmBnKbQyoQ3nmvvx0QtUgoilmexpKsNW
	kP8jVI0JVVBJgFCZ5PCxyFq3+1R2Xrk6syZgd9SMY7L4xVZU9nJYIw0pDZE4pQ==
To: bitbake-devel@lists.openembedded.org
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: [PATCH 2/2] contrib: hashserv: Dockerfile: Update base image
Date: Mon, 11 May 2026 17:36:32 +0200
Message-ID: <20260511153632.299677-2-frieder@fris.de>
In-Reply-To: <20260511153632.299677-1-frieder@fris.de>
References: <20260511153632.299677-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 11 May 2026 15:37:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19493

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Alpine 3.13 is out-of-date and doesn't provide a Python version that
is comaptible with the current version of bitbake master. Fix this
by upgrading the alpine base image and installing the missing
websockets module.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 contrib/hashserv/Dockerfile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/hashserv/Dockerfile b/contrib/hashserv/Dockerfile
index fe7e091ec..5c8b8dd11 100644
--- a/contrib/hashserv/Dockerfile
+++ b/contrib/hashserv/Dockerfile
@@ -9,9 +9,9 @@
 #   docker build -f contrib/hashserv/Dockerfile .
 #
=20
-FROM alpine:3.13.1
+FROM alpine:3.23
=20
-RUN apk add --no-cache python3 libgcc
+RUN apk add --no-cache python3 py3-websockets libgcc
=20
 COPY bin/bitbake-hashserv /opt/bbhashserv/bin/
 COPY lib/hashserv /opt/bbhashserv/lib/hashserv/
--=20
2.54.0


