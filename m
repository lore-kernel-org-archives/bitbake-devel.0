Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8D1C433F5
	for <webhook@archiver.kernel.org>; Tue, 29 Mar 2022 10:09:51 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web11.4791.1648548590917694279
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Mar 2022 03:09:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=gQCJVPFt;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id D59671BF208;
	Tue, 29 Mar 2022 10:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1648548589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=P5bl6m2sWsv2VpI4i2mHCPfISgtEmeWI/Gny5s0Ia5c=;
	b=gQCJVPFtmAKTBCicL0CNam1sG5mw55MrEwRChG8KCPo7YmIhpMaI1fPkSLeFFrJ6VC1iyp
	phyhA35qw6npXs86MuGg/yjRcv8pMApqip+n/Ryyj3/m57kL4nZ57NPyyBBw2rkp6gbg1W
	/Vo5XttNp4gqokVGb79M1O4dFZdY8G0wI9H7JOQfGOOYs84iwYm5G/kjfQiGjcE65ZS5iQ
	7+ptXmX6T+8eDUTsFEosDMxMSuegXGNZ+STL8jBoeGLfNJ1WiAhw0BP6jwe59AmUyc9nuT
	WPeXTMO6U8PzZ11Jsm4rcnFuglUK2UHGjIkc8lmOuxfWNcpBQ9a9qAx6vnvnoA==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] [bitbake 1.52] doc/conf.py: correct version
Date: Tue, 29 Mar 2022 12:09:46 +0200
Message-Id: <20220329100946.354505-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Mar 2022 10:09:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13535

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 doc/conf.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/conf.py b/doc/conf.py
index fc2ee081..17551953 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -17,7 +17,7 @@
 import sys
 import datetime
 
-current_version = "dev"
+current_version = "1.52"
 
 # String used in sidebar
 version = 'Version: ' + current_version
-- 
2.25.1


