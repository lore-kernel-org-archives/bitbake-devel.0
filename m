Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web11.625.1619200483132258599
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Apr 2021 10:54:43 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bootlin.com, ip: 217.70.183.200, mailfrom: michael.opdenacker@bootlin.com)
X-Originating-IP: 109.210.254.211
Received: from localhost (amontpellier-552-1-199-211.w109-210.abo.wanadoo.fr [109.210.254.211])
	(Authenticated sender: michael.opdenacker@bootlin.com)
	by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 3853D20009;
	Fri, 23 Apr 2021 17:54:40 +0000 (UTC)
From: "Michael Opdenacker" <michael.opdenacker@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH v2] README: update/fix contribution guidelines
Date: Fri, 23 Apr 2021 19:54:29 +0200
Message-Id: <20210423175429.340205-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <16788A2044914AF0.27757@lists.openembedded.org>
References: <16788A2044914AF0.27757@lists.openembedded.org>
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
index 96e6007e..64206de8 100644
--- a/README
+++ b/README
@@ -26,6 +26,11 @@ branch, type:
 
     git send-email -M -1 --to bitbake-devel@lists.openembedded.org
 
+If you're sending a patch related to the BitBake manual, make sure you copy
+the Yocto Project documentation mailing list:
+
+    git send-email -M -1 --to bitbake-devel@lists.openembedded.org --cc docs@lists.yoctoproject.org
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

