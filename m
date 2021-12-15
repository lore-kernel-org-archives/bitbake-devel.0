Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3782C43219
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 01:43:27 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web08.207.1639584411566344162
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Dec 2021 08:06:51 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bootlin.com, ip: 217.70.183.200, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 3C4CE20017;
	Wed, 15 Dec 2021 16:06:48 +0000 (UTC)
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] doc: bitbake-user-manual: expand BB_HASHSERVE and document
 BB_HASHSERVE_UPSTREAM
Date: Wed, 15 Dec 2021 17:06:13 +0100
Message-Id: <20211215160613.2001231-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Dec 2021 01:43:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13171

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 .../bitbake-user-manual-ref-variables.rst     | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index bb996e84..45ee9dde 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -376,10 +376,28 @@ overview of their function and contents.
       If set to ``auto``, BitBake automatically starts its own server
       over a UNIX domain socket.
 
-      If set to ``host:port``, BitBake will use a remote server on the
+      If set to ``unix://path``, BitBake will connect to an existing a
+      hash server available over a UNIX domain socket.
+
+      If set to ``host:port``, BitBake will connect to a remote server on the
       specified host. This allows multiple clients to share the same
       hash equivalence data.
 
+      This last kind of server can be started manually through
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
+         BB_HASHSERVE_UPSTREAM = "typhoon.yocto.io:8687"
+
    :term:`BB_INVALIDCONF`
       Used in combination with the ``ConfigParsed`` event to trigger
       re-parsing the base metadata (i.e. all the recipes). The
-- 
2.25.1


