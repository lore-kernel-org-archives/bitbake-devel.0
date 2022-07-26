Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29E9C3F6B0
	for <webhook@archiver.kernel.org>; Tue, 26 Jul 2022 17:46:24 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web12.9930.1658857573948258064
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 26 Jul 2022 10:46:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=gKXPid8C;
 spf=pass (domain: bootlin.com, ip: 217.70.183.200,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id A1EE120003;
	Tue, 26 Jul 2022 17:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1658857572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P5xg4jE81Do0Rb4qFedfV683EGLNa5Qlhs9eUgW3Qfo=;
	b=gKXPid8C/7CvFzzQmA+LRskIc/wSec75y003PULCw3tzG76pGEDl1wJwC5/bIBRobS82E2
	BUYvZMTdqNfiGLe9fdCf92eB9LETwnhghv/n4mLWTQOss5CSIoa2suM86kaujhBiY63Yi1
	Wocp4Dc6bYd9VkThELKOkpyD6EUOMidZmE0z1ED/bmZW/hU/213y0pRS9zLMT/NidqSh7v
	/MJe4708JRIhltRve3/6EZEr/mUD+ikvkBVJ3paLqxyYmwu+DhTGpg0zkMurXM3uZNOa47
	WMF8dtEzNxXKG7LX0bQk2TNNGGKlpUa38l1QOUv2QUXb5x+Md+7+i0UOjTdfEw==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Quentin Schulz <foss@0leil.net>
Subject: [PATCH] bitbake-user-manual: npm fetcher: improve description of
 SRC_URI format
Date: Tue, 26 Jul 2022 19:45:45 +0200
Message-Id: <20220726174545.1734501-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <607a8e9c-ad17-bff5-7b65-b02dd698c891@theobroma-systems.com>
References: <607a8e9c-ad17-bff5-7b65-b02dd698c891@theobroma-systems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 26 Jul 2022 17:46:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13855

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

Using the term "Parameter" which is consistent with the
description of SRC_URI parameters in the following text.

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Reported-by: Quentin Schulz <foss@0leil.net>
---
 doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index 4dfb7889..9c269ca8 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -717,7 +717,7 @@ Javascript package registry.
 
 The format for the :term:`SRC_URI` setting must be::
 
-   SRC_URI = "npm://some.registry.url;OptionA=xxx;OptionB=xxx;..."
+   SRC_URI = "npm://some.registry.url;ParameterA=xxx;ParameterB=xxx;..."
 
 This fetcher supports the following parameters:
 
@@ -757,7 +757,7 @@ of an NPM package while locking their versions.
 
 The format for the :term:`SRC_URI` setting must be::
 
-   SRC_URI = "npmsw://some.registry.url;OptionA=xxx;OptionB=xxx;..."
+   SRC_URI = "npmsw://some.registry.url;ParameterA=xxx;ParameterB=xxx;..."
 
 This fetcher supports the following parameters:
 
-- 
2.34.1


