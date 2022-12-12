Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95260C4332F
	for <webhook@archiver.kernel.org>; Mon, 12 Dec 2022 10:51:19 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web11.40152.1670842278347190038
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Dec 2022 02:51:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=HRS6nFhJ;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id DD9051BF210;
	Mon, 12 Dec 2022 10:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1670842275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nMnYtiH0XDf7ypvdRNMIJFjb13um2FdYBXjP+UghEfs=;
	b=HRS6nFhJyFkchSubcSScjPPYqszx1ffJbeqld31RTWMH/hIhZEFG1pMVeCIle3pJZEaM5B
	DueljLuhaiZD60FyDipUCYml1Laz4NZHDtPLSXQdB4T0iXTb/QxmxErIfqEgHmcESR8oSN
	jDMQ9/xL7cYtkDXBFqP2JMlNJjciVW4y+UZIPnksy9Qfu0abTEuXGGeCqHvM/3mp0SH8so
	GEUtwgr8FzPQFutppEQ8vZDwvO3t18z0aeAHj1/YyM4zdMw2SW3nrdVlzR8gm/K6uZvpmR
	bitmTLQwCj2rZDC8B54LO5ngpRS7Apk4uoWS36UqpExYyqbqG0EBkqNp2MuArg==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] bitbake-user-manual: remove "OEBasic" signature generator
Date: Mon, 12 Dec 2022 11:51:06 +0100
Message-Id: <20221212105106.65882-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 12 Dec 2022 10:51:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14179

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

Removed in BitBake through
https://git.openembedded.org/openembedded-core/commit/?id=3667e589ba16eb261cfd72c2b11429f482c239f6

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 .../bitbake-user-manual-execution.rst           | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
index 7a22e96e..f6ebf7ba 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
@@ -552,8 +552,8 @@ through dependency chains are more complex and are generally
 accomplished with a Python function. The code in
 ``meta/lib/oe/sstatesig.py`` shows two examples of this and also
 illustrates how you can insert your own policy into the system if so
-desired. This file defines the two basic signature generators
-OpenEmbedded-Core uses: "OEBasic" and "OEBasicHash". By default, there
+desired. This file defines the basic signature generator
+OpenEmbedded-Core uses: "OEBasicHash". By default, there
 is a dummy "noop" signature handler enabled in BitBake. This means that
 behavior is unchanged from previous versions. ``OE-Core`` uses the
 "OEBasicHash" signature handler by default through this setting in the
@@ -561,14 +561,13 @@ behavior is unchanged from previous versions. ``OE-Core`` uses the
 
   BB_SIGNATURE_HANDLER ?= "OEBasicHash"
 
-The "OEBasicHash" :term:`BB_SIGNATURE_HANDLER` is the same as the "OEBasic"
-version but adds the task hash to the stamp files. This results in any
-metadata change that changes the task hash, automatically causing the
-task to be run again. This removes the need to bump
-:term:`PR` values, and changes to metadata automatically
-ripple across the build.
+The main feature of the "OEBasicHash" :term:`BB_SIGNATURE_HANDLER` is that
+it adds the task hash to the stamp files. Thanks to this, any metadata
+change will change the task hash, automatically causing the task to be run
+again. This removes the need to bump :term:`PR` values, and changes to
+metadata automatically ripple across the build.
 
-It is also worth noting that the end result of these signature
+It is also worth noting that the end result of signature
 generators is to make some dependency and hash information available to
 the build. This information includes:
 
-- 
2.37.2


