Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 7B5A976FDE
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Oct 2015 12:48:45 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga103.fm.intel.com with ESMTP; 15 Oct 2015 05:48:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,685,1437462000"; d="scan'208";a="827342138"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga002.jf.intel.com with ESMTP; 15 Oct 2015 05:48:23 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 7EB316A4083
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Oct 2015 05:47:24 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 15 Oct 2015 15:45:13 +0300
Message-Id: <cb124eb264acb01510c7c410f949b421e8f49cdd.1444910218.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1444910218.git.ed.bartosh@linux.intel.com>
References: <cover.1444910218.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1444910218.git.ed.bartosh@linux.intel.com>
References: <cover.1444910218.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 1/4] toaster: Record critical errors
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
X-List-Received-Date: Thu, 15 Oct 2015 12:48:48 -0000

From: Elliot Smith <elliot.smith@intel.com>

Critical errors (where a build failed for reasons of
misconfiguration, such as a machine being specified which is not
in a project's layers) were being ignored (only log records
up to ERROR level were being logged to Toaster's db). This meant that
the build would fail but would not correctly report why.

Add support for CRITICAL error levels to the LogMessage model,
include errors at this level in the errors property for a build,
and show errors at this level in the build dashboard.

[YOCTO #8320]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/bb/ui/buildinfohelper.py                         |  5 ++++-
 lib/bb/ui/toasterui.py                               |  2 ++
 lib/toaster/orm/models.py                            | 20 +++++++++++++-------
 lib/toaster/toastergui/templates/builddashboard.html | 11 ++++++-----
 4 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index a8c884d..286fb6a 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -1394,7 +1394,9 @@ class BuildInfoHelper(object):
 
         log_information = {}
         log_information['build'] = self.internal_state['build']
-        if event.levelno == formatter.ERROR:
+        if event.levelno == formatter.CRITICAL:
+            log_information['level'] = LogMessage.CRITICAL
+        elif event.levelno == formatter.ERROR:
             log_information['level'] = LogMessage.ERROR
         elif event.levelno == formatter.WARNING:
             log_information['level'] = LogMessage.WARNING
@@ -1407,6 +1409,7 @@ class BuildInfoHelper(object):
         log_information['pathname'] = event.pathname
         log_information['lineno'] = event.lineno
         logger.info("Logging error 2: %s", log_information)
+
         self.orm_wrapper.create_logmessage(log_information)
 
     def close(self, errorcode):
diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index dbe0d09..0ed774e 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -145,10 +145,12 @@ def main(server, eventHandler, params ):
                     event.levelno = formatter.ERROR
 
                 buildinfohelper.store_log_event(event)
+
                 if event.levelno >= formatter.ERROR:
                     errors = errors + 1
                 elif event.levelno == formatter.WARNING:
                     warnings = warnings + 1
+
                 # For "normal" logging conditions, don't show note logs from tasks
                 # but do show them if the user has changed the default log level to
                 # include verbose/debug messages
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 44a453a..6ca45e0 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -353,7 +353,9 @@ class Build(models.Model):
 
     @property
     def errors(self):
-        return (self.logmessage_set.filter(level=LogMessage.ERROR)|self.logmessage_set.filter(level=LogMessage.EXCEPTION))
+        return (self.logmessage_set.filter(level=LogMessage.ERROR) |
+                self.logmessage_set.filter(level=LogMessage.EXCEPTION) |
+                self.logmessage_set.filter(level=LogMessage.CRITICAL))
 
     @property
     def warnings(self):
@@ -1285,16 +1287,20 @@ class LogMessage(models.Model):
     INFO = 0
     WARNING = 1
     ERROR = 2
-
-    LOG_LEVEL = ( (INFO, "info"),
-            (WARNING, "warn"),
-            (ERROR, "error"),
-            (EXCEPTION, "toaster exception"))
+    CRITICAL = 3
+
+    LOG_LEVEL = (
+        (INFO, "info"),
+        (WARNING, "warn"),
+        (ERROR, "error"),
+        (CRITICAL, "critical"),
+        (EXCEPTION, "toaster exception")
+    )
 
     build = models.ForeignKey(Build)
     task  = models.ForeignKey(Task, blank = True, null=True)
     level = models.IntegerField(choices=LOG_LEVEL, default=INFO)
-    message=models.CharField(max_length=240)
+    message = models.CharField(max_length=240)
     pathname = models.FilePathField(max_length=255, blank=True)
     lineno = models.IntegerField(null=True)
 
diff --git a/lib/toaster/toastergui/templates/builddashboard.html b/lib/toaster/toastergui/templates/builddashboard.html
index aa99134..fc6cae6 100644
--- a/lib/toaster/toastergui/templates/builddashboard.html
+++ b/lib/toaster/toastergui/templates/builddashboard.html
@@ -69,11 +69,12 @@
     <div class="accordion-body collapse in" id="collapse-errors">
       <div class="accordion-inner">
         <div class="span10">
-          {% for error in logmessages %}{% if error.level == 2 %}
-            <div class="alert alert-error">
-              <pre>{{error.message}}</pre>
-            </div>
-          {% endif %}
+          {% for error in logmessages %}
+            {% if error.level == 2 or error.level == 3 %}
+              <div class="alert alert-error">
+                <pre>{{error.message}}</pre>
+              </div>
+            {% endif %}
           {% endfor %}
         </div>
       </div>
-- 
2.1.4


