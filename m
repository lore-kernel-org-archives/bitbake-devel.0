Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web12.2032.1619195478332972699
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Apr 2021 09:31:18 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bootlin.com, ip: 217.70.183.196, mailfrom: michael.opdenacker@bootlin.com)
X-Originating-IP: 92.150.42.106
Received: from localhost (lfbn-mar-1-834-106.w92-150.abo.wanadoo.fr [92.150.42.106])
	(Authenticated sender: michael.opdenacker@bootlin.com)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 509E7E0009;
	Fri, 23 Apr 2021 16:31:15 +0000 (UTC)
From: "Michael Opdenacker" <michael.opdenacker@bootlin.com>
To: bitbake-devel@lists.openembedded.org,
	docs@lists.yoctoproject.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] README: update/fix contribution guidelines
Date: Fri, 23 Apr 2021 18:31:08 +0200
Message-Id: <20210423163108.338904-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Ask to CC the docs@lists.yoctoproject.org mailing list
- doc/README: fix the command to generate the manual

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 README     | 5 +++++
 doc/README | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/README b/README
index 96e6007e..5034a9bf 100644
--- a/README
+++ b/README
@@ -26,6 +26,11 @@ branch, type:
 
     git send-email -M -1 --to bitbake-devel@lists.openembedded.org
 
+If you're sending a patch related to the BitBake manual, make sure you copy
+the Yocto Project documentation mailing list:
+
+    git send-email -M -1 --to bitbake-devel@lists.openembedded.org --to docs@lists.yoctoproject.org
+
 Mailing list:
 
     http://lists.openembedded.org/mailman/listinfo/bitbake-devel
diff --git a/doc/README b/doc/README
index cbb5215d..1f8e0f6e 100644
--- a/doc/README
+++ b/doc/README
@@ -47,7 +47,7 @@ To install all required packages run:
 
 To build the documentation locally, run:
 
- $ cd documentation
+ $ cd doc
  $ make html
 
 The resulting HTML index page will be _build/html/index.html, and you
-- 
2.25.1

