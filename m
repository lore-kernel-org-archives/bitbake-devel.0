Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641A6C433F5
	for <webhook@archiver.kernel.org>; Mon,  7 Mar 2022 16:34:24 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web08.28722.1646670862957301609
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Mar 2022 08:34:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=bybewBe3;
 spf=pass (domain: bootlin.com, ip: 217.70.183.200,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id F3DDF20004;
	Mon,  7 Mar 2022 16:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1646670861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bn6Z3ylvz9p+eCBGY9JpQml77VMgbopX5eCTy7dGoSM=;
	b=bybewBe3LaqEY0gJP1DUD3DMS5Y2MFzPSmYSGcE07Pox1c61fKso/ewQzjRKOJMKxYUDXn
	BeZBkaXLfKilM5PsQLKynF5XGO5YqjVEMzXY85lEp4x3Pw2ol5VBpPZTmY3z/RXYp7ggEj
	DXQru9TsupKLFiuJ8Q0laNjynW14ilhBmWlTWJBOAOuZwTbh220nC9cpE+eH8G4HKcQah9
	s+TVDBNtbdp02OL/ihrlQJTjrVybyi1K6UHmd20nMWOVsqKeAeB/D1R/72Ck3x7TU/znFG
	iTEgLGCgUX30TNzbnzgn1p/kMstgG/cMBHpLnLTVJXDn5nX3meNtKlUf7z+91A==
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] bitbake-user-manual: update allowed characters in overrides
Date: Mon,  7 Mar 2022 17:33:54 +0100
Message-Id: <20220307163354.531374-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <16DA1113B58DA516.28939@lists.openembedded.org>
References: <16DA1113B58DA516.28939@lists.openembedded.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Mar 2022 16:34:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13435

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---

 An open question is whether digits and/or hashes are
 allowed at the begining of an override keyword.
 Will be happy to send a V2 to explicit this if needed.

 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index b90e5cf0..104dcb6c 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -510,8 +510,8 @@ variable.
 
 .. note::
 
-   Overrides can only use lower-case characters. Additionally,
-   colons are not permitted in override names as they are used to
+   Overrides can only use lower-case characters, digits and dashes.
+   In particular, colons are not permitted in override names as they are used to
    separate overrides from each other and from the variable name.
 
 -  *Selecting a Variable:* The :term:`OVERRIDES` variable is a
-- 
2.25.1


