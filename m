Return-Path: <calinx.l.dragomir@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 2BBB76A880
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Jun 2013 15:09:58 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 12 Jun 2013 08:09:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,853,1363158000"; d="scan'208";a="352306248"
Received: from calin-desktop.rb.intel.com ([10.237.105.64])
	by orsmga002.jf.intel.com with ESMTP; 12 Jun 2013 08:09:58 -0700
From: Calin Dragomir <calinx.l.dragomir@intel.com>
To: webhob@yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Date: Wed, 12 Jun 2013 18:11:45 +0300
Message-Id: <1371049906-17370-2-git-send-email-calinx.l.dragomir@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1371049906-17370-1-git-send-email-calinx.l.dragomir@intel.com>
References: <1371049906-17370-1-git-send-email-calinx.l.dragomir@intel.com>
Subject: [PATCH 2/3] Create Tasks Django model
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 12 Jun 2013 15:09:58 -0000

This will be used to store Tasks related information in the database
using Django ORM.
---
 bitbake/lib/webhob/orm/__init__.py     |  0
 bitbake/lib/webhob/orm/models.py       | 50 ++++++++++++++++++++++++++++++++++
 bitbake/lib/webhob/orm/tests.py        | 16 +++++++++++
 bitbake/lib/webhob/orm/views.py        |  1 +
 bitbake/lib/webhob/whbmain/settings.py |  1 +
 5 files changed, 68 insertions(+)
 create mode 100644 bitbake/lib/webhob/orm/__init__.py
 create mode 100644 bitbake/lib/webhob/orm/models.py
 create mode 100644 bitbake/lib/webhob/orm/tests.py
 create mode 100644 bitbake/lib/webhob/orm/views.py

diff --git a/bitbake/lib/webhob/orm/__init__.py b/bitbake/lib/webhob/orm/__init__.py
new file mode 100644
index 0000000..e69de29
diff --git a/bitbake/lib/webhob/orm/models.py b/bitbake/lib/webhob/orm/models.py
new file mode 100644
index 0000000..13eadd4
--- /dev/null
+++ b/bitbake/lib/webhob/orm/models.py
@@ -0,0 +1,50 @@
+from django.db import models
+
+class Tasks(models.Model):
+
+    SSTATE_RESULT = (
+        ('not_applicable', 'Not Applicable'), # For rest of tasks, but they still need checking.
+        ('unavailable', 'Unavailable'), # it is a miss
+        ('failed', 'Failed'), # there was a pkg, but the script failed
+        ('restored', 'Restored'), # succesfully restored
+    )
+
+    TASK_CODING = (
+        ('python', 'Python'),
+        ('shell', 'Shell'),
+    )
+
+    TASK_OUTCOME = (
+        ('succeded', 'Succeded'),
+        ('failed', 'Failed'),
+        ('existing', 'Existing'),
+        ('sstate', 'Sstate'),
+        ('covered', 'Covered'),
+    )
+
+    uuid = models.CharField(max_length=100)
+    task_id = models.IntegerField()
+    order = models.IntegerField()
+    task_executed = models.BooleanField() # True means Executed, False means Prebuilt
+    outcome = models.CharField(max_length=50, choices=TASK_OUTCOME)
+    sstate_checksum = models.CharField(max_length=100)
+    path_to_sstate_obj = models.FilePathField(max_length=500, blank=True)
+    recipe = models.CharField(max_length=100)
+    task_name = models.CharField(max_length=100)
+    source_url = models.FilePathField(max_length=200)
+    log_file = models.FilePathField(max_length=200, blank=True)
+    work_directory = models.FilePathField(max_length=200)
+    script_type = models.CharField(max_length=10, choices=TASK_CODING)
+    file_path = models.FilePathField(max_length=200)
+    line_number = models.IntegerField()
+    py_stack_trace = models.TextField()
+    disk_io = models.DecimalField(max_digits=20, decimal_places=10)
+    cpu_usage = models.IntegerField()
+    elapsed_time = models.CharField(max_length=50)
+    dependent_tasks = models.TextField() ## do we need only to show text here or insert references? how do we connect to other tasks from the same table ?
+    errors_no = models.IntegerField()
+    warnings_no = models.IntegerField()
+    error = models.TextField()
+    warning = models.TextField()
+    sstate_result = models.CharField(max_length=50, choices=SSTATE_RESULT)
+
diff --git a/bitbake/lib/webhob/orm/tests.py b/bitbake/lib/webhob/orm/tests.py
new file mode 100644
index 0000000..501deb7
--- /dev/null
+++ b/bitbake/lib/webhob/orm/tests.py
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
diff --git a/bitbake/lib/webhob/orm/views.py b/bitbake/lib/webhob/orm/views.py
new file mode 100644
index 0000000..60f00ef
--- /dev/null
+++ b/bitbake/lib/webhob/orm/views.py
@@ -0,0 +1 @@
+# Create your views here.
diff --git a/bitbake/lib/webhob/whbmain/settings.py b/bitbake/lib/webhob/whbmain/settings.py
index bc59543..6a4e67a 100644
--- a/bitbake/lib/webhob/whbmain/settings.py
+++ b/bitbake/lib/webhob/whbmain/settings.py
@@ -124,6 +124,7 @@ INSTALLED_APPS = (
     # 'django.contrib.admin',
     # Uncomment the next line to enable admin documentation:
     # 'django.contrib.admindocs',
+    'orm',
 )
 
 # A sample logging configuration. The only tangible logging
-- 
1.8.1.2


