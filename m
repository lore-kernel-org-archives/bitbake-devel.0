Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05D7CD1299
	for <webhook@archiver.kernel.org>; Fri,  5 Apr 2024 16:41:48 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
 by mx.groups.io with SMTP id smtpd.web11.17411.1712335307028616097
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Apr 2024 09:41:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=k20Zg2ES;
 spf=pass (domain: bootlin.com, ip: 217.70.183.195, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8F6FA60004;
	Fri,  5 Apr 2024 16:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712335304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R+kV1Bo/Xe7oO6yiQwuflwCCATaD63pdjdRoybwp79I=;
	b=k20Zg2ESkkowlrgZnIpxWT3cMaXTGsXtYPH7jlmjEUkDd4hDcJiHo6x5unFVAbRHErZOHp
	mrRJ8eDz8SSxdiyP582TrQOVhB89QD8DKizA1DIRgNfYjNV1dC1o7oS7BwbqZj3+uHxGMF
	M95KMzo51EDkTwlmW5aZpGhvSQj9Yt0P/OXWagXj8gusQv9uPcK8VIxrLu2PsvgLLPrHfF
	bEj9Wk4FyFb7Y6P7seZLHZOR/amVZ40mTXf0OqSh3RaWAHfP9fSmAIdn2ztDbZ9Z9DqLye
	2k8Z8ODqmLCGbCXTT14XAaUOVvb8aMzBEbxfdbnf78SA6bTmI4kqElvrD/zHtw==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Tim Orling <ticotimo@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 11/12] prserv: remove unnecessary code
Date: Fri,  5 Apr 2024 18:41:24 +0200
Message-Id: <20240405164125.1652579-12-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405164125.1652579-1-michael.opdenacker@bootlin.com>
References: <20240405164125.1652579-1-michael.opdenacker@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Apr 2024 16:41:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16060

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

In db.py, the ifnull() statement guarantees that the SQL request will
return a value. It's therefore unnecessary to test the case when no
value is found.

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: Joshua Watt <JPEWhacker@gmail.com>
Cc: Tim Orling <ticotimo@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 lib/prserv/db.py | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/lib/prserv/db.py b/lib/prserv/db.py
index 3b0713def6..7aad6a1576 100644
--- a/lib/prserv/db.py
+++ b/lib/prserv/db.py
@@ -124,11 +124,7 @@ class PRTable(object):
             if self.read_only:
                 data = self._execute("SELECT ifnull(max(value)+1, 0) FROM %s where version=? AND pkgarch=?;" % (self.table),
                                    (version, pkgarch))
-                row = data.fetchone()
-                if row is not None:
-                    return row[0]
-                else:
-                    return 0
+                return data.fetchone()[0]
 
             try:
                 self._execute("INSERT OR REPLACE INTO %s VALUES (?, ?, ?, (select ifnull(max(value)+1, 0) from %s where version=? AND pkgarch=?));"
-- 
2.34.1


