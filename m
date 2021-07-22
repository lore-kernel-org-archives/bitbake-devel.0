Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
 by mx.groups.io with SMTP id smtpd.web11.231.1626973825738117780
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 Jul 2021 10:10:26 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bootlin.com, ip: 217.70.183.193, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id B2363240006;
	Thu, 22 Jul 2021 17:10:23 +0000 (UTC)
From: "Michael Opdenacker" <michael.opdenacker@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] doc: bitbake-user-manual: fix syntax in example and improve description
Date: Thu, 22 Jul 2021 19:10:21 +0200
Message-Id: <20210722171021.69225-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous syntax of the example was clearly incorrect
The example and description were also ambiguous, one could think that
it was "bitbake recipe" instead of "bitbake <recipename>"

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 20c330e6..01ac4d5e 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -91,9 +91,10 @@ level changes:
       Variables that are exported to the environment are preceded by the
       string "export" in the command's output.
 
--  For recipe changes, use the following::
+-  To find changes to a given variable in a specific recipe, use the
+   following::
 
-      $ bitbake recipe -e \| grep VARIABLE="
+      $ bitbake recipename -e | grep VARIABLENAME=\"
 
    This command checks to see if the variable actually makes
    it into a specific recipe.
-- 
2.25.1

