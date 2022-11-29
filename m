Return-Path: <kasper@krinvent.dk>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236DCC4321E
	for <webhook@archiver.kernel.org>; Tue, 29 Nov 2022 13:23:08 +0000 (UTC)
Received: from mailrelay4-3.pub.mailoutpod2-cph3.one.com (mailrelay4-3.pub.mailoutpod2-cph3.one.com [46.30.212.35])
 by mx.groups.io with SMTP id smtpd.web10.149006.1669728177770084503
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Nov 2022 05:22:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@krinvent.dk header.s=rsa1 header.b=SdVRuk+z;
 spf=none, err=permanent DNS error (domain: krinvent.dk, ip: 46.30.212.35, mailfrom: kasper@krinvent.dk)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=krinvent.dk; s=rsa1;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=AIBUn52Im1YJZ0Nssjo7xu0PO9XOkBAb2F+5iY4ifuE=;
	b=SdVRuk+z11a+/bOEgHVJ92eOoP4vooqBgTko+sNO6qeZseEPLaYg2Ux/5cOmqPDPAlxX0c/jy2D4Q
	 BgemcNe2Dm1IifsF6uy1IQep9jEzEKL4rxxzqH9gOpXn2iiyfQxFxAVksed3blWyjWi1g7u5a7GD0N
	 ds+zVwD4fPnM1rEEyGOpeZekq45xS8b91CJklvBMeJyu9/+2RWTwM+T3d0l0tpHg0WqwI4J+tZnOZb
	 AhDA0Yy1c/KYoCYNUThy3C7O/n4nBYlzxi1vQKdV92rbP/lZMWm/5vpRLQFuxmp2doFYdge5TE3FRG
	 YL7tAoHjPK002ssXwkvrwrf8pv7mQYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=krinvent.dk; s=ed1;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=AIBUn52Im1YJZ0Nssjo7xu0PO9XOkBAb2F+5iY4ifuE=;
	b=it30JpSgH8AAFuGbFYpHBvAGDiJ+WwIGqyRg3/rmUWtPXlQ9bUrQFqSuEkhrQHW/kC8c8EOnpRrJM
	 k0xckCqBw==
X-HalOne-ID: ee58a215-6fe8-11ed-99dd-45c065e8efb0
Received: from ubuntu.localdomain (unknown [87.104.84.103])
	by mailrelay4 (Halon) with ESMTPSA
	id ee58a215-6fe8-11ed-99dd-45c065e8efb0;
	Tue, 29 Nov 2022 13:22:55 +0000 (UTC)
From: kasper@krinvent.dk
To: bitbake-devel@lists.openembedded.org
Cc: Kasper Revsbech <kasper.revsbech.ext@siemensgamesa.com>
Subject: [PATCH] fetch2/wget: handle username/password in uri
Date: Tue, 29 Nov 2022 14:22:46 +0100
Message-Id: <20221129132246.436271-1-kasper@krinvent.dk>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Nov 2022 13:23:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14125

From: Kasper Revsbech <kasper.revsbech.ext@siemensgamesa.com>

In checkstatus() opener.open() is used to check if an artifact is available.
The check fails if the uri contains username password in the format:
"username:password@hostname..". Moreover, the checkstatus function already uses
the username from the "ud" object to craft a header, is username and password is
provided.

This fix ensure the uri in the Requests object used does not contain username as
password.

Signed-off-by: Kasper Revsbech <kasper.revsbech.ext@siemensgamesa.com>
---
 lib/bb/fetch2/wget.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 821afa5b..d9aaad6b 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -341,7 +341,8 @@ class Wget(FetchMethod):
             opener = urllib.request.build_opener(*handlers)
 
             try:
-                uri = ud.url.split(";")[0]
+                uri_base = ud.url.split(";")[0]
+                uri = "{}://{}{}".format(urllib.parse.urlparse(uri_base).scheme, ud.host, ud.path)
                 r = urllib.request.Request(uri)
                 r.get_method = lambda: "HEAD"
                 # Some servers (FusionForge, as used on Alioth) require that the
-- 
2.34.1


