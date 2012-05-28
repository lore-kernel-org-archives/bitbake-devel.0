Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1SZ3ev-0004Yb-LT
	for bitbake-devel@lists.openembedded.org;
	Mon, 28 May 2012 19:23:09 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 28 May 2012 10:11:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="172031880"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.120.22])
	by fmsmga002.fm.intel.com with ESMTP; 28 May 2012 10:10:47 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 28 May 2012 18:10:39 +0100
Message-Id: <cd821b9cc293cda1c0f2684413fa3d5f6167c637.1338224913.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1338224913.git.paul.eggleton@linux.intel.com>
References: <cover.1338224913.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1338224913.git.paul.eggleton@linux.intel.com>
References: <cover.1338224913.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] hob: handle sanity check failures as a separate event
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 28 May 2012 17:23:09 -0000

In order to show a friendlier error message that does not bury the
actual sanity error in our typical preamble about disabling sanity
checks, use a separate event to indicate that sanity checks failed.

This change is intended to work together with the related change to
sanity.bbclass in OE-Core.

Fixes [YOCTO #2336].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/event.py                     |    8 ++++++++
 bitbake/lib/bb/ui/crumbs/builder.py         |    7 ++++++-
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    6 ++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index f3fb521..1116c0a 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -527,3 +527,11 @@ class SanityCheckPassed(Event):
     """
     Event to indicate sanity check is passed
     """
+
+class SanityCheckFailed(Event):
+    """
+    Event to indicate sanity check has failed
+    """
+    def __init__(self, msg):
+        Event.__init__(self)
+        self._msg = msg
diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 80a8d01..8d35ea9 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -424,6 +424,7 @@ class Builder(gtk.Window):
         self.handler.connect("data-generated",           self.handler_data_generated_cb)
         self.handler.connect("command-succeeded",        self.handler_command_succeeded_cb)
         self.handler.connect("command-failed",           self.handler_command_failed_cb)
+        self.handler.connect("sanity-failed",            self.handler_sanity_failed_cb)
         self.handler.connect("recipe-populated",         self.handler_recipe_populated_cb)
         self.handler.connect("package-populated",        self.handler_package_populated_cb)
 
@@ -727,10 +728,14 @@ class Builder(gtk.Window):
 
     def handler_command_failed_cb(self, handler, msg):
         if msg:
-            msg = msg.replace("your local.conf", "Settings")
             self.show_error_dialog(msg)
         self.reset()
 
+    def handler_sanity_failed_cb(self, handler, msg):
+        msg = msg.replace("your local.conf", "Settings")
+        self.show_error_dialog(msg)
+        self.reset()
+
     def window_sensitive(self, sensitive):
         self.image_configuration_page.machine_combo.set_sensitive(sensitive)
         self.image_configuration_page.image_combo.set_sensitive(sensitive)
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index b34bdbe..1db9c44 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -42,6 +42,9 @@ class HobHandler(gobject.GObject):
          "command-failed"          : (gobject.SIGNAL_RUN_LAST,
                                       gobject.TYPE_NONE,
                                      (gobject.TYPE_STRING,)),
+         "sanity-failed"           : (gobject.SIGNAL_RUN_LAST,
+                                      gobject.TYPE_NONE,
+                                     (gobject.TYPE_STRING,)),
          "generating-data"         : (gobject.SIGNAL_RUN_LAST,
                                       gobject.TYPE_NONE,
                                      ()),
@@ -170,6 +173,9 @@ class HobHandler(gobject.GObject):
         elif isinstance(event, bb.event.SanityCheckPassed):
             self.run_next_command()
 
+        elif isinstance(event, bb.event.SanityCheckFailed):
+            self.emit("sanity-failed", event._msg)
+
         elif isinstance(event, logging.LogRecord):
             if event.levelno >= logging.ERROR:
                 self.error_msg += event.msg + '\n'
-- 
1.7.9.5



