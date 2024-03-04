Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D57C48BF6
	for <webhook@archiver.kernel.org>; Mon,  4 Mar 2024 14:01:39 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web10.99109.1709560889620869774
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 04 Mar 2024 06:01:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=QKkOqFxJ;
 spf=pass (domain: bootlin.com, ip: 217.70.183.199, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B97DDFF808;
	Mon,  4 Mar 2024 14:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709560887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HTg9sYar1iDeH66RNjUwy742B8QJGr+1qi45YcpHYrA=;
	b=QKkOqFxJHhbHGJok2JWMaQM5mG4pqzkSMq/N8BIBbkHztcS5N8YYTI2XMR/2jtq1mMKp9I
	YGhOpWZRbBC/i2i+vZMTkl3nr5ub/cZ2gpnX+nd9qD4dm95aHsD2S9o3L2MLFqEJVM0FUL
	KPC+wNrJVGxXsE4NjdEEUcPXCSbLDz8tamM+NcEgd7JnU5Ac5tVKg5KMx/lbe9DW1veBoy
	060rVHX2gmq1v05HPjUyvMw6c1YdRAeQFyJ0UnA0Nu5TIOVu2A3DxjZGluGQ7sUmU1oqbt
	QCzQjjiJpH/IuUT+sOZ6Qb/2b65fbGGTwL0xy0MIeDw7eJgKkbISRbhQR92FgA==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	"Robert P . J . Day" <rpjday@crashcourse.ca>
Subject: [PATCH] utils: remove BB_ENV_PASSTHROUGH from preserved_envvars()
Date: Mon,  4 Mar 2024 15:01:25 +0100
Message-Id: <20240304140125.131052-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 04 Mar 2024 14:01:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15984

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

preserved_envvars() is used when the BB_ENV_PASSTHROUGH
environment variable is not set. Therefore, its code shouldn't
return this variable.

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
Tested-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 lib/bb/utils.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 068b631c9..ad13d0433 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -604,7 +604,6 @@ def preserved_envvars():
     v = [
         'BBPATH',
         'BB_PRESERVE_ENV',
-        'BB_ENV_PASSTHROUGH',
         'BB_ENV_PASSTHROUGH_ADDITIONS',
     ]
     return v + preserved_envvars_exported()
-- 
2.34.1


