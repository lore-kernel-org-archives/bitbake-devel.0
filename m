Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29731EB64D8
	for <webhook@archiver.kernel.org>; Tue, 20 Jun 2023 17:53:14 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web10.918.1687283587898078912
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Jun 2023 10:53:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=ZH67q1U0;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: michael.opdenacker@bootlin.com)
X-GND-Sasl: michael.opdenacker@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1687283585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3PUsAMHF/TAlj3kEiko7IHNFjeFS7knVsqTvLD99nYo=;
	b=ZH67q1U0nUt4eWi2xG6s2ZNHdIlaXgOLoZJiz7C62xb7xh4tRGCMokEAB93vPtsXhQx6QL
	9yYl2CRu8xTKTpW8eT48yY7M+Bl+4sXCbDP7dwohJFkt7tbEJbk7n6/weJSFMXReYtfDdy
	AePwFs+KFKNUmPxJrjBNeXL0fniJ+ssBLIs/jwPn80eSs2511/AsHMrCGBW5v9AWdbbNAZ
	KiblZpEQc4zbwt0HXOO2tVKTMfy08kP00Wy3ZwSMUkBT+xgdI9PG6hKLUgbKcLyLa1TEpL
	aAhbtf6Br+npolI4VKS7eLP0OoQDdowctWtaaeE2XB4ZB7P1X+wfbR7voUmLEw==
X-GND-Sasl: michael.opdenacker@bootlin.com
X-GND-Sasl: michael.opdenacker@bootlin.com
X-GND-Sasl: michael.opdenacker@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 494591C0002;
	Tue, 20 Jun 2023 17:53:04 +0000 (UTC)
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH] bitbake-user-manual: revert change about PREFERRED_PROVIDERS
Date: Tue, 20 Jun 2023 19:53:00 +0200
Message-Id: <20230620175300.1132976-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Jun 2023 17:53:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14851

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

Partially reverting https://git.openembedded.org/bitbake/commit/?id=d1779e2f7789e516efae434b3781c981d0ef4ded

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Reported-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 .../bitbake-user-manual-ref-variables.rst                   | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index ee5d7ba8..2032157f 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -1225,9 +1225,9 @@ overview of their function and contents.
          PREFERRED_PROVIDER_virtual/libgl ?= "mesa"
 
    :term:`PREFERRED_PROVIDERS`
-      A colon-separated list to determine which recipe should be given
-      preference for cases where multiple recipes provide the same item.
-      Functionally, :term:`PREFERRED_PROVIDERS` is identical to
+      Determines which recipe should be given preference for cases where
+      multiple recipes provide the same item. Functionally,
+      :term:`PREFERRED_PROVIDERS` is identical to
       :term:`PREFERRED_PROVIDER`. However, the :term:`PREFERRED_PROVIDERS` variable
       lets you define preferences for multiple situations using the following
       form::
-- 
2.34.1


