Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342AFC4332F
	for <webhook@archiver.kernel.org>; Mon, 12 Dec 2022 12:28:50 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web10.41666.1670848124914747995
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Dec 2022 04:28:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=nnewcZYy;
 spf=pass (domain: bootlin.com, ip: 217.70.183.200, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 4C56720007;
	Mon, 12 Dec 2022 12:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1670848122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Vafd5bvdllFRvqo6qlvCBwCUT4nS4B6OHT5stMhy26o=;
	b=nnewcZYye5s1t9Ji+utDeh/MQvIUm/RDxUg4eP+e+kqWD1ydGc6JPZpokD8KbZAq52sICv
	jTX2Chotv+6/SBeJdGeTzUCnakslxGeWzCFeMQzHQeI7P7jnooxQzaCnuPa5WZvu4grgGw
	j1u/Ci7xePEk+5XRjrEbHUHvjQutFwTNo0iTEO4xy8a6AZWwCHzS7ELrAMlHzTMXmzQ+/F
	DRHfUrk76SK+l5rwq1xpMAu6wFdYr/I/1YGmz96p1brwjqEqueVy2syWpdWldaQSQzzY88
	ux3+yc2gNiVOoYX2c/OoKhhxs+2andSStc+e5GR4oWPqMh/fuuY127iwaPpOTA==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] bitbake-user-manual: double colon fix
Date: Mon, 12 Dec 2022 13:28:37 +0100
Message-Id: <20221212122837.70662-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 12 Dec 2022 12:28:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14181

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 3522d2b7..09d09a8d 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -40,8 +40,7 @@ overview of their function and contents.
       Azure Storage Shared Access Signature, when using the
       :ref:`Azure Storage fetcher <bitbake-user-manual/bitbake-user-manual-fetching:fetchers>`
       This variable can be defined to be used by the fetcher to authenticate
-      and gain access to non-public artifacts.
-      ::
+      and gain access to non-public artifacts::
 
          AZ_SAS = ""se=2021-01-01&sp=r&sv=2018-11-09&sr=c&skoid=<skoid>&sig=<signature>""
 
-- 
2.37.2


