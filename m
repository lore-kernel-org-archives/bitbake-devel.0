Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
	[209.85.212.173])
	by mail.openembedded.org (Postfix) with ESMTP id EECDA6FAB5
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jun 2014 13:52:03 +0000 (UTC)
Received: by mail-wi0-f173.google.com with SMTP id cc10so5707255wib.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jun 2014 06:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=WUjl+NQQvQrhQyLLqnINCkg/+sTYy+tq7iG1hkkH1wU=;
	b=VzR5iumSh4jbYIW6QEfiRfjPA+s8SgVx1p8ow3IntwVvGL/jYQHFx4kWQ6lErIvLOH
	BJ74nFRBm7ogip4OdZkb2Z6/YYbSizvh3m//lQ7JvCRRou1rjeOWlO1H9R3w7dxhg66D
	RZ/NtIvkB3frVgpqxZUhDeHVnp8n8mAkRlRUx+KJrOHpVx9ApRyF3JWmLnKmB/IxoREd
	5xGh+Xeu5IuK452HuxOuHTypBN0ik8Vrn8P/M/QKKdanJw5hdNDwkkInpzUMuVtjdr/u
	Q9bgU4VLAEjReQdF9mtg5ACivHOc5IQ1UeVihAYLxYvegGv1XIpl8RHOqzjgE/N68/xt
	xT3Q==
X-Gm-Message-State: ALoCoQnz2OkljdRpaViU95T9HRtIesdH6wRN7rd8sei0QD1GlbifIFSLH9EUWH4EJGJtJdCAt/7Z
X-Received: by 10.180.106.1 with SMTP id gq1mr6709648wib.45.1402581120762;
	Thu, 12 Jun 2014 06:52:00 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id gr6sm4212465wib.10.2014.06.12.06.51.58
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 12 Jun 2014 06:51:58 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id A36CC5606C5; Thu, 12 Jun 2014 14:52:03 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@yoctoproject.org
Date: Thu, 12 Jun 2014 14:51:57 +0100
Message-Id: <08556b79b7b2af08aaeedf8733b1b8996f387c4e.1402580802.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1402580802.git.alexandru.damian@intel.com>
References: <cover.1402580802.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 1/6] toaster: initial bldcontrol application
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 12 Jun 2014 13:52:04 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

The build features of Toaster will be contained into
a separate application, as to modularize the Toaster
project and provide multiple options for deployment.

This patch adds the application as a barebone Django
application in the Toaster project.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/bldcontrol/__init__.py |  0
 lib/toaster/bldcontrol/models.py   |  3 +++
 lib/toaster/bldcontrol/tests.py    | 16 ++++++++++++++++
 lib/toaster/bldcontrol/views.py    |  1 +
 4 files changed, 20 insertions(+)
 create mode 100644 lib/toaster/bldcontrol/__init__.py
 create mode 100644 lib/toaster/bldcontrol/models.py
 create mode 100644 lib/toaster/bldcontrol/tests.py
 create mode 100644 lib/toaster/bldcontrol/views.py

diff --git a/lib/toaster/bldcontrol/__init__.py b/lib/toaster/bldcontrol/__init__.py
new file mode 100644
index 0000000..e69de29
diff --git a/lib/toaster/bldcontrol/models.py b/lib/toaster/bldcontrol/models.py
new file mode 100644
index 0000000..71a8362
--- /dev/null
+++ b/lib/toaster/bldcontrol/models.py
@@ -0,0 +1,3 @@
+from django.db import models
+
+# Create your models here.
diff --git a/lib/toaster/bldcontrol/tests.py b/lib/toaster/bldcontrol/tests.py
new file mode 100644
index 0000000..501deb7
--- /dev/null
+++ b/lib/toaster/bldcontrol/tests.py
@@ -0,0 +1,16 @@
+"""
+This file demonstrates writing tests using the unittest module. These will pass
+when you run "manage.py test".
+
+Replace this with more appropriate tests for your application.
+"""
+
+from django.test import TestCase
+
+
+class SimpleTest(TestCase):
+    def test_basic_addition(self):
+        """
+        Tests that 1 + 1 always equals 2.
+        """
+        self.assertEqual(1 + 1, 2)
diff --git a/lib/toaster/bldcontrol/views.py b/lib/toaster/bldcontrol/views.py
new file mode 100644
index 0000000..60f00ef
--- /dev/null
+++ b/lib/toaster/bldcontrol/views.py
@@ -0,0 +1 @@
+# Create your views here.
-- 
1.9.1


