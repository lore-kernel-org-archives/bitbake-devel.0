Return-Path: <ddalex@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id BF7F96CB75
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:13 +0000 (UTC)
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 24 Sep 2013 09:53:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="298814600"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by AZSMGA002.ch.intel.com with ESMTP; 24 Sep 2013 09:53:11 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 0E5A556248B; Tue, 24 Sep 2013 17:53:05 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:24 +0100
Message-Id: <be86be2995118cf9ca524d3d6f3d2f953ef722b7.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 55/94] bitbake: dsi: store log information
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:15 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Adding database model for storing Log Information

Adding code to store log information for errors
and warnings coming through the build system.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py | 41 +++++++++++++++++++++++++++++++++---
 bitbake/lib/bb/ui/dsi.py             |  9 ++++++--
 bitbake/lib/webhob/orm/models.py     | 15 +++++++++++++
 3 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index bfd7fef..d435f19 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -8,9 +8,9 @@ import re
 os.environ.setdefault("DJANGO_SETTINGS_MODULE", "webhob.whbmain.settings")
 
 import webhob.whbmain.settings as whb_django_settings
-from webhob.orm.models import Machine, Build, Task, Recipe, Layer_Version, Layer, Package, Package_Dependency
-from webhob.orm.models import Task_Dependency
-
+from webhob.orm.models import Machine, Build, Task, Recipe, Layer_Version, Layer, Package, LogMessage
+from webhob.orm.models import Task_Dependency, Package_Dependency
+from bb.msg import BBLogFormatter as format
 
 class ORMWrapper(object):
     """ This class creates the dictionaries needed to store information in the database
@@ -134,6 +134,18 @@ class ORMWrapper(object):
                                         depends_on = packagedict[px]['object'] );
 
 
+    def create_logmessage(self, log_information):
+        log_object = LogMessage.objects.create(
+                        build = log_information['build'],
+                        level = log_information['level'],
+                        message = log_information['message'])
+
+        for v in vars(log_object):
+            if v in log_information.keys():
+                vars(log_object)[v] = log_information[v]
+
+        return log_object.save()
+
 class BuildInfoHelper(object):
     """ This class gathers the build information from the server and sends it
         towards the ORM wrapper for storing in the database
@@ -513,3 +525,26 @@ class BuildInfoHelper(object):
                 dep = _save_a_task(taskdesc1)
                 Task_Dependency.objects.get_or_create( task = target, depends_on = dep )
 
+    def store_log_information(self, level, text):
+        log_information = {}
+        log_information['build'] = self.internal_state['build']
+        log_information['level'] = level
+        log_information['message'] = text
+        self.orm_wrapper.create_logmessage(log_information)
+
+    def store_log_event(self, event):
+        if event.levelno < format.WARNING:
+            return
+        if not 'build' in self.internal_state:
+            return
+        log_information = {}
+        log_information['build'] = self.internal_state['build']
+        if event.levelno >= format.ERROR:
+            log_information['level'] = LogMessage.ERROR
+        elif event.levelno == format.WARNING:
+            log_information['level'] = LogMessage.WARNING
+        log_information['message'] = event.msg
+        log_information['pathname'] = event.pathname
+        log_information['lineno'] = event.lineno
+        self.orm_wrapper.create_logmessage(log_information)
+
diff --git a/bitbake/lib/bb/ui/dsi.py b/bitbake/lib/bb/ui/dsi.py
index 0305121..78982f2 100644
--- a/bitbake/lib/bb/ui/dsi.py
+++ b/bitbake/lib/bb/ui/dsi.py
@@ -332,6 +332,8 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 # include verbose/debug messages
                 if event.taskpid != 0 and event.levelno <= format.NOTE:
                     continue
+
+                buildinfohelper.store_log_event(event)
                 logger.handle(event)
                 continue
 
@@ -406,9 +408,12 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                     r = ""
 
                 if event._dependees:
-                    logger.error("Nothing %sPROVIDES '%s' (but %s %sDEPENDS on or otherwise requires it)", r, event._item, ", ".join(event._dependees), r)
+                    text = "Nothing %sPROVIDES '%s' (but %s %sDEPENDS on or otherwise requires it)" % (r, event._item, ", ".join(event._dependees), r)
                 else:
-                    logger.error("Nothing %sPROVIDES '%s'", r, event._item)
+                    text = "Nothing %sPROVIDES '%s'" % (r, event._item)
+
+                logger.error(text)
+                buildinfohelper.store_log_information(2, text)  # don't judge me
                 if event._reasons:
                     for reason in event._reasons:
                         logger.error("%s", reason)
diff --git a/bitbake/lib/webhob/orm/models.py b/bitbake/lib/webhob/orm/models.py
index f2cc7d9..91a51ff 100644
--- a/bitbake/lib/webhob/orm/models.py
+++ b/bitbake/lib/webhob/orm/models.py
@@ -174,3 +174,18 @@ class Machine(models.Model):
     name = models.CharField(max_length=100)
     description = models.TextField()
 
+
+class LogMessage(models.Model):
+    INFO = 0
+    WARNING = 1
+    ERROR = 2
+
+    LOG_LEVEL = ( (INFO, "info"),
+            (WARNING, "warn"),
+            (ERROR, "error") )
+
+    build = models.ForeignKey(Build)
+    level = models.IntegerField(choices=LOG_LEVEL, default=INFO)
+    message=models.CharField(max_length=240)
+    pathname = models.FilePathField(max_length=255, null=True)
+    lineno = models.IntegerField(null=True)
-- 
1.8.1.2


