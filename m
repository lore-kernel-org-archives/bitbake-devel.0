Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
 by mx.groups.io with SMTP id smtpd.web09.1508.1622824021386678777
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 04 Jun 2021 09:27:02 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bootlin.com, ip: 217.70.178.232, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay12.mail.gandi.net (Postfix) with ESMTPSA id 00D10200002;
	Fri,  4 Jun 2021 16:26:58 +0000 (UTC)
From: "Michael Opdenacker" <michael.opdenacker@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] docs: Add BB_HASHSERVE definition to glossary
Date: Fri,  4 Jun 2021 18:26:47 +0200
Message-Id: <20210604162647.661888-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 .../bitbake-user-manual-ref-variables.rst              | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index e1b640e2..bfb74c11 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -313,6 +313,16 @@ overview of their function and contents.
       However, the more accurate the data returned, the more efficient the
       build will be.
 
+   :term:`BB_HASHSERVE`
+      Specifies the Hash Equivalence server to use.
+
+      If set to ``auto``, BitBake automatically starts its own server
+      over a UNIX domain socket.
+
+      If set to ``host:port``, BitBake will use a remote server on the
+      specified host. This allows multiple clients to share the same
+      hash equivalence data.
+
    :term:`BB_INVALIDCONF`
       Used in combination with the ``ConfigParsed`` event to trigger
       re-parsing the base metadata (i.e. all the recipes). The
-- 
2.25.1

