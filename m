Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web11.6122.1622798821237652127
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 04 Jun 2021 02:27:02 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bootlin.com, ip: 217.70.183.196, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 39C94E0007;
	Fri,  4 Jun 2021 09:26:58 +0000 (UTC)
From: "Michael Opdenacker" <michael.opdenacker@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] doc: bitbake-user-manual: fix erroneous statement in glossary intro
Date: Fri,  4 Jun 2021 11:26:39 +0200
Message-Id: <20210604092640.655084-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the BitBake glossary.
Remove an erroneous statement probably coming from the introduction
to the YP/OE glossary.

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index e1b640e2..430394e8 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -23,10 +23,6 @@ overview of their function and contents.
       systems extend the functionality of the variable as it is
       described here in this glossary.
 
-   -  Finally, there are variables mentioned in this glossary that do
-      not appear in the BitBake glossary. These other variables are
-      variables used in systems that use BitBake.
-
 .. glossary::
 
    :term:`ASSUME_PROVIDED`
-- 
2.25.1

