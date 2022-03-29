Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C709C433EF
	for <webhook@archiver.kernel.org>; Tue, 29 Mar 2022 10:00:46 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web08.4721.1648548044776287269
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Mar 2022 03:00:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=Tvx+RI3b;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id C164B1BF214;
	Tue, 29 Mar 2022 10:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1648548043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hqgLoSPhd7sQpHyz7SWPhrihaQUI8trP/oHt1uOkmTE=;
	b=Tvx+RI3bwB7CfmqgKFyjbMyN9UHeEWSmb7DQ3W4g1UzEd1708Qr0YpXVc+Pn+eYXcsTk/2
	A6BXI5qa8idc0EJpVOIASADa4OjqEPyDFdt+rXByaX4vWV3Y/4Mg//f6HftnVNJxtfjp1/
	t31mQUxkEwkj04WWcu09rqa0lNWVFkUjDo/PEgb+pFBAxyE1RCzdB+dNLU2/Z4fqFpzcAg
	6bAgrzcBWdrpTFckLy6bfmyjPnhdgI5YFKAwcJp3CUz/BUj+Ms+q9OSvR1Ov5+aG9OSLyf
	/cUG1AAJbpdc7CEPVX7KFDjD4Du5lt3rY/mWE0gNQC7xo/DnUHtcGPq+aGW4jw==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] [bitbake 1.46] doc/conf.py: correct version
Date: Tue, 29 Mar 2022 12:00:39 +0200
Message-Id: <20220329100039.353687-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Mar 2022 10:00:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13533

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

Otherwise the version information in generated docs is wrong
(appearing on the left bar in HTML output, for example)

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 doc/conf.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/conf.py b/doc/conf.py
index fc2ee081..718130b9 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -17,7 +17,7 @@
 import sys
 import datetime
 
-current_version = "dev"
+current_version = "1.46"
 
 # String used in sidebar
 version = 'Version: ' + current_version
-- 
2.25.1


