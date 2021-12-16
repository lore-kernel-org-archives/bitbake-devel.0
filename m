Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C36C433EF
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 18:15:00 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web11.301.1639678499023264172
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Dec 2021 10:14:59 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id EE60240004;
	Thu, 16 Dec 2021 18:14:56 +0000 (UTC)
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH v3] doc: bitbake-user-manual: expand BB_HASHSERVE and document
 BB_HASHSERVE_UPSTREAM
Date: Thu, 16 Dec 2021 19:14:49 +0100
Message-Id: <20211216181449.10155-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <16C14EC6ED2F56F6.18294@lists.openembedded.org>
References: <16C14EC6ED2F56F6.18294@lists.openembedded.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Dec 2021 18:15:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13189

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 .../bitbake-user-manual-ref-variables.rst     | 24 +++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index bb996e84..3160a41a 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -374,12 +374,32 @@ overview of their function and contents.
       Specifies the Hash Equivalence server to use.
 
       If set to ``auto``, BitBake automatically starts its own server
-      over a UNIX domain socket.
+      over a UNIX domain socket. An option is to connect this server
+      to an upstream one, by setting :term:`BB_HASHSERVE_UPSTREAM`.
 
-      If set to ``host:port``, BitBake will use a remote server on the
+      If set to ``unix://path``, BitBake will connect to an existing
+      hash server available over a UNIX domain socket.
+
+      If set to ``host:port``, BitBake will connect to a remote server on the
       specified host. This allows multiple clients to share the same
       hash equivalence data.
 
+      The remote server can be started manually through
+      the ``bin/bitbake-hashserv`` script provided by BitBake,
+      which supports UNIX domain sockets too.
+
+   :term:`BB_HASHSERVE_UPSTREAM`
+      Specifies an upstream Hash Equivalence server.
+
+      This optional setting is only useful when a local Hash Equivalence
+      server is started (setting :term:`BB_HASHSERVE` to ``auto``),
+      and you wish the local server to query an upstream server for
+      Hash Equivalence data.
+
+      Example usage::
+
+         BB_HASHSERVE_UPSTREAM = "typhoon.yocto.io:8687"
+
    :term:`BB_INVALIDCONF`
       Used in combination with the ``ConfigParsed`` event to trigger
       re-parsing the base metadata (i.e. all the recipes). The
-- 
2.25.1


