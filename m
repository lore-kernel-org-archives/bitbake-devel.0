Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f66.google.com (mail-pa0-f66.google.com
	[209.85.220.66])
	by mail.openembedded.org (Postfix) with ESMTP id 3AB46731E7
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Mar 2016 05:20:41 +0000 (UTC)
Received: by mail-pa0-f66.google.com with SMTP id fl4so677535pad.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Mar 2016 21:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=ECBA6+oMXp9HvLhLqB8vIDfvBZKTlIo209gGre/ZcQI=;
	b=IehqtNWS0Spmxd5kxH9mCcnCdqKIACvFVh+j+Bg7JvCNTfgWa3DsxdQYxMAp+WKPHy
	XMV2hxcKD4kiz/5YG5/mSzZedtZNjzxQ2y1LbDdoFlEmcPTFU2MNNJ1azhclePtzJlw3
	Ny5rXnhI8FuXIf0NimOqPRLFLt1Yj+oNWzeo63vqYz3q59ytoSxOYKp4KHLxZxE0Kr4T
	BoZ4H3q3pqbmU0eLHwPooq63pchQNALe4bSZk0JVZtuPrWMxMhOiiHJAKNkDVAlGh1pL
	YVb2e+n0QE7GM0tuLR3ec0Embx2KMovtGiCUEIKcaBDBe0ktad2btbua3tJtx/gP4Y9N
	QLEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=ECBA6+oMXp9HvLhLqB8vIDfvBZKTlIo209gGre/ZcQI=;
	b=WwjmOHsmj/yZuX5/uc9tZIhBEMad6iPC7elVvnch0f8zf0mu2G61koZggDTRaFVime
	mltPwGLwNdKsQeECcv3Gjfbp2Gl4zOWzcOgpaSRdc6rYOR+uX00hIjCObPPWpOyxIl7q
	7sVrMbkSywwpaFSEWyrO1wbdSxmCAuKeskbilW/89L5rIFL5XKLxWVISm86ArNCN2cfp
	ZbtganqwrUUwH1T2U+tXeCot7KPH27UgcQj1E8iNyqTZlV5QTSaijnFkCtZ0o0f4RH9R
	guN+PGVtKLu3qfsTyY3h7qprLqYES8VDAHO4pxaKUsNaeWb0OaXo5zf3bGrbFCHZdxc/
	P7mg==
X-Gm-Message-State: AD7BkJIls/09SnxGxPvAwFtFEyfhorzSZSe97tl8qOKrP4H41qIjL69weCeBmfeCUj33sQ==
X-Received: by 10.66.66.198 with SMTP id h6mr1056215pat.112.1456982442696;
	Wed, 02 Mar 2016 21:20:42 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	z5sm25544986par.21.2016.03.02.21.20.41
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Mar 2016 21:20:41 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Mar 2016 21:26:55 -0800
Message-Id: <049ebe99cbaf6d9a610a5482e3e9d4abacb6fe78.1456982682.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <df618a1a82ca72c39f9334c7b6ce1104553cf7da.1456982682.git.avery.brian@gmail.com>
References: <df618a1a82ca72c39f9334c7b6ce1104553cf7da.1456982682.git.avery.brian@gmail.com>
In-Reply-To: <cover.1456982682.git.avery.brian@gmail.com>
References: <cover.1456982682.git.avery.brian@gmail.com>
Subject: [PATCH 2/3] toaster: don't use sshbecontroller
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
X-List-Received-Date: Thu, 03 Mar 2016 05:20:42 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Removed usage of sshbecontroller from bbcontroller, models, tests
and database schema.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/bldcontrol/bbcontroller.py             |  6 ------
 .../migrations/0002_auto_20160120_1250.py          | 19 +++++++++++++++++
 lib/toaster/bldcontrol/models.py                   |  2 --
 lib/toaster/bldcontrol/tests.py                    | 24 ----------------------
 4 files changed, 19 insertions(+), 32 deletions(-)
 create mode 100644 bitbake/lib/toaster/bldcontrol/migrations/0002_auto_20160120_1250.py

diff --git a/lib/toaster/bldcontrol/bbcontroller.py b/lib/toaster/bldcontrol/bbcontroller.py
index f228d37..f40103c 100644
--- a/lib/toaster/bldcontrol/bbcontroller.py
+++ b/lib/toaster/bldcontrol/bbcontroller.py
@@ -76,13 +76,10 @@ def getBuildEnvironmentController(**kwargs):
     """
 
     from localhostbecontroller import LocalhostBEController
-    from sshbecontroller    import SSHBEController
 
     be = BuildEnvironment.objects.filter(Q(**kwargs))[0]
     if be.betype == BuildEnvironment.TYPE_LOCAL:
         return LocalhostBEController(be)
-    elif be.betype == BuildEnvironment.TYPE_SSH:
-        return SSHBEController(be)
     else:
         raise Exception("FIXME: Implement BEC for type %s" % str(be.betype))
 
@@ -105,9 +102,6 @@ class BuildEnvironmentController(object):
         on the local machine, with the "build/" directory under the "poky/" source checkout directory.
         Bash is expected to be available.
 
-            * SSH controller will run the Toaster BE on a remote machine, where the current user
-        can connect without raise Exception("FIXME: implement")word (set up with either ssh-agent or raise Exception("FIXME: implement")phrase-less key authentication)
-
     """
     def __init__(self, be):
         """ Takes a BuildEnvironment object as parameter that points to the settings of the BE.
diff --git a/lib/toaster/bldcontrol/migrations/0002_auto_20160120_1250.py b/lib/toaster/bldcontrol/migrations/0002_auto_20160120_1250.py
new file mode 100644
index 0000000..0c2475a
--- /dev/null
+++ b/lib/toaster/bldcontrol/migrations/0002_auto_20160120_1250.py
@@ -0,0 +1,19 @@
+# -*- coding: utf-8 -*-
+from __future__ import unicode_literals
+
+from django.db import migrations, models
+
+
+class Migration(migrations.Migration):
+
+    dependencies = [
+        ('bldcontrol', '0001_initial'),
+    ]
+
+    operations = [
+        migrations.AlterField(
+            model_name='buildenvironment',
+            name='betype',
+            field=models.IntegerField(choices=[(0, b'local')]),
+        ),
+    ]
diff --git a/lib/toaster/bldcontrol/models.py b/lib/toaster/bldcontrol/models.py
index bb613c6..9244ed1 100644
--- a/lib/toaster/bldcontrol/models.py
+++ b/lib/toaster/bldcontrol/models.py
@@ -12,10 +12,8 @@ class BuildEnvironment(models.Model):
     )
 
     TYPE_LOCAL = 0
-    TYPE_SSH   = 1
     TYPE = (
         (TYPE_LOCAL, "local"),
-        (TYPE_SSH, "ssh"),
     )
 
     LOCK_FREE = 0
diff --git a/lib/toaster/bldcontrol/tests.py b/lib/toaster/bldcontrol/tests.py
index e808991..f20cc7d 100644
--- a/lib/toaster/bldcontrol/tests.py
+++ b/lib/toaster/bldcontrol/tests.py
@@ -9,7 +9,6 @@ from django.test import TestCase
 
 from bldcontrol.bbcontroller import BitbakeController, BuildSetupException
 from bldcontrol.localhostbecontroller import LocalhostBEController
-from bldcontrol.sshbecontroller import SSHBEController
 from bldcontrol.models import BuildEnvironment, BuildRequest
 from bldcontrol.management.commands.runbuilds import Command
 
@@ -110,29 +109,6 @@ class LocalhostBEControllerTests(TestCase, BEControllerTests):
     def _getBEController(self, obe):
         return LocalhostBEController(obe)
 
-class SSHBEControllerTests(TestCase, BEControllerTests):
-    def __init__(self, *args):
-        super(SSHBEControllerTests, self).__init__(*args)
-
-    def _getBuildEnvironment(self):
-        return BuildEnvironment.objects.create(
-                lock = BuildEnvironment.LOCK_FREE,
-                betype = BuildEnvironment.TYPE_SSH,
-                address = test_address,
-                sourcedir = test_sourcedir,
-                builddir = test_builddir )
-
-    def _getBEController(self, obe):
-        return SSHBEController(obe)
-
-    def test_pathExists(self):
-        obe = BuildEnvironment.objects.create(betype = BuildEnvironment.TYPE_SSH, address= test_address)
-        sbc = SSHBEController(obe)
-        self.assertTrue(sbc._pathexists("/"))
-        self.assertFalse(sbc._pathexists("/.deadbeef"))
-        self.assertTrue(sbc._pathexists(sbc._shellcmd("pwd")))
-
-
 class RunBuildsCommandTests(TestCase):
     def test_bec_select(self):
         """
-- 
1.9.1


