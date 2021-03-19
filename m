Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
 by mx.groups.io with SMTP id smtpd.web12.289.1616172147165070184
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Mar 2021 09:42:27 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bootlin.com, ip: 217.70.183.195, mailfrom: michael.opdenacker@bootlin.com)
X-Originating-IP: 92.150.42.106
Received: from localhost (lfbn-mar-1-834-106.w92-150.abo.wanadoo.fr [92.150.42.106])
	(Authenticated sender: michael.opdenacker@bootlin.com)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 42FA660006;
	Fri, 19 Mar 2021 16:42:24 +0000 (UTC)
From: "Michael Opdenacker" <michael.opdenacker@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] doc: Update links to documentation
Date: Fri, 19 Mar 2021 17:42:21 +0100
Message-Id: <20210319164221.43246-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 README                | 2 +-
 lib/bb/tests/fetch.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/README b/README
index 479c3765..96e6007e 100644
--- a/README
+++ b/README
@@ -11,7 +11,7 @@ For information about Bitbake, see the OpenEmbedded website:
 
 Bitbake plain documentation can be found under the doc directory or its integrated
 html version at the Yocto Project website:
-    http://yoctoproject.org/documentation
+    https://docs.yoctoproject.org
 
 Contributing
 ------------
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 7b2dac7b..ddf6e974 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1345,7 +1345,7 @@ class FetchCheckStatusTest(FetcherTest):
                       "http://downloads.yoctoproject.org/releases/sato/sato-engine-0.2.tar.gz",
                       "http://downloads.yoctoproject.org/releases/sato/sato-engine-0.3.tar.gz",
                       "https://yoctoproject.org/",
-                      "https://yoctoproject.org/documentation",
+                      "https://docs.yoctoproject.org",
                       "http://downloads.yoctoproject.org/releases/opkg/opkg-0.1.7.tar.gz",
                       "http://downloads.yoctoproject.org/releases/opkg/opkg-0.3.0.tar.gz",
                       "ftp://sourceware.org/pub/libffi/libffi-1.20.tar.gz",
-- 
2.25.1

