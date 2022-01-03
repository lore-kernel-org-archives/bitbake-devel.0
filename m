Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE5AC433F5
	for <webhook@archiver.kernel.org>; Mon,  3 Jan 2022 14:59:30 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web10.28777.1641221969026651887
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Jan 2022 06:59:29 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id A37BB40006;
	Mon,  3 Jan 2022 14:59:20 +0000 (UTC)
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] doc: bitbake-user-manual: expand BB_HASHSERVE explanations
Date: Mon,  3 Jan 2022 15:59:05 +0100
Message-Id: <20220103145905.31608-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 03 Jan 2022 14:59:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13210

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 .../bitbake-user-manual-ref-variables.rst                    | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 3160a41a..e0f661cd 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -386,7 +386,10 @@ overview of their function and contents.
 
       The remote server can be started manually through
       the ``bin/bitbake-hashserv`` script provided by BitBake,
-      which supports UNIX domain sockets too.
+      which supports UNIX domain sockets too. This script also allows
+      to start the server in read-only mode, to avoid accepting
+      equivalences that correspond to Share State caches that are
+      only available on specific clients.
 
    :term:`BB_HASHSERVE_UPSTREAM`
       Specifies an upstream Hash Equivalence server.
-- 
2.25.1


