Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2C7C433EF
	for <webhook@archiver.kernel.org>; Tue, 29 Mar 2022 10:09:43 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web12.4859.1648548582341015022
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Mar 2022 03:09:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=jhQp6CmK;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 57CA24000C;
	Tue, 29 Mar 2022 10:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1648548580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3b/AuONIHCq9xk2WCjKL39LSapaUlBInKdzSdGdsoLg=;
	b=jhQp6CmK/2ojO8tS9VcEdVqNXPQjz04F/kfpLReMloESAHal3Ww41yYNNZJZK+ZQ3/hnUN
	wde6LBENuE8QcZ5YbHtKis1xjlTCuqATZAoz4mq7H7+j2KoP+HZkMvbsNC1SBtbtLTnb9+
	MFjzvIxb9JlEUBxm4ek+BSBDs4R51ehG5J6/eu4rVADhWwNX4st18q5c96eVTUTAM2qfmh
	t6YtO5a7Eg07SfTxWVM7EyVUZerHlbzoT6FXGnBqSLhQ4LZFXQyVqPemHw2x+0Ip27NKi9
	mdrCGsLgM/VLm2bU6lpHEHR5yhzvwnN+UCAlgt8KtfZoYDrYOhs2YlS1BXLW/Q==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] [bitbake 1.50] doc/conf.py: correct version
Date: Tue, 29 Mar 2022 12:09:34 +0200
Message-Id: <20220329100934.354437-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Mar 2022 10:09:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13534

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 doc/conf.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/conf.py b/doc/conf.py
index fc2ee081..9105f015 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -17,7 +17,7 @@
 import sys
 import datetime
 
-current_version = "dev"
+current_version = "1.50"
 
 # String used in sidebar
 version = 'Version: ' + current_version
-- 
2.25.1


