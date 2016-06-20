Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 6018F62132
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jun 2016 11:01:32 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga104.fm.intel.com with ESMTP; 20 Jun 2016 04:01:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,498,1459839600"; d="scan'208";a="125227129"
Received: from linux.intel.com ([10.54.29.200])
	by fmsmga004.fm.intel.com with ESMTP; 20 Jun 2016 04:01:34 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.68])
	by linux.intel.com (Postfix) with ESMTP id B7D346A4080
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jun 2016 04:01:30 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 20 Jun 2016 14:00:48 +0300
Message-Id: <d9491b91d0b4dcd840c0f533d1fbdf6dc0abd3f1.1466419987.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1466419987.git.ed.bartosh@linux.intel.com>
References: <cover.1466419987.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1466419987.git.ed.bartosh@linux.intel.com>
References: <cover.1466419987.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 1/5] cooker: move EventLogWriteHandler to the top module level
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
X-List-Received-Date: Mon, 20 Jun 2016 11:01:32 -0000

EventLogWriteHandler object was created and used in
BBCooker.initConfigurationData.
This causes creation of multiple EventLogWriteHandler objects
and results in duplicated entries in the output event file
as BBCooker.initConfigurationData is called multiple times.

Added eventlogfile parameter to EventLogWriteHandler to avoid using
global variable DEFAULT_EVENTFILE.
Moved EventLogWriteHandler to the module level.
Created EventLogWriteHandler object in BBCooker.__init__ to ensure that only
one handler object is created.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/bb/cooker.py | 126 ++++++++++++++++++++++++-----------------------
 1 file changed, 64 insertions(+), 62 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 60ee5d7..b2cf0cd 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -42,6 +42,8 @@ import subprocess
 import errno
 import prserv.serv
 import pyinotify
+import json
+import pickle
 
 logger      = logging.getLogger("BitBake")
 collectlog  = logging.getLogger("BitBake.Collection")
@@ -114,6 +116,63 @@ class CookerFeatures(object):
         return next(self._features)
 
 
+class EventLogWriteHandler:
+
+    def __init__(self, cooker, eventfile):
+        # set our handler's event processor
+        self.event = self.EventWriter(cooker, eventfile)
+
+    class EventWriter:
+        def __init__(self, cooker, eventfile):
+            self.file_inited = None
+            self.cooker = cooker
+            self.eventfile = eventfile
+            self.event_queue = []
+
+        def init_file(self):
+            try:
+                # delete the old log
+                os.remove(self.eventfile)
+            except:
+                pass
+
+            # write current configuration data
+            with open(eventfile, "w") as f:
+                f.write("%s\n" % json.dumps({ "allvariables" : self.cooker.getAllKeysWithFlags(["doc", "func"])}))
+
+        def write_event(self, event):
+            with open(self.eventfile, "a") as f:
+                try:
+                    f.write("%s\n" % json.dumps({"class":event.__module__ + "." + event.__class__.__name__, "vars":json.dumps(pickle.dumps(event)) }))
+                except Exception as e:
+                    import traceback
+                    print(e, traceback.format_exc())
+
+
+        def send(self, event):
+            event_class = event.__module__ + "." + event.__class__.__name__
+
+            # init on bb.event.BuildStarted
+            if self.file_inited is None:
+                if  event_class == "bb.event.BuildStarted":
+                    self.init_file()
+                    self.file_inited = True
+
+                    # write pending events
+                    for e in self.event_queue:
+                        self.write_event(e)
+
+                    # also write the current event
+                    self.write_event(event)
+
+                else:
+                    # queue all events until the file is inited
+                    self.event_queue.append(event)
+
+            else:
+                # we have the file, just write the event
+                self.write_event(event)
+
 #============================================================================#
 # BBCooker
 #============================================================================#
@@ -151,6 +210,11 @@ class BBCooker:
 
         self.initConfigurationData()
 
+        # we log all events to a file if so directed
+        if self.configuration.writeeventlog:
+            # register the log file writer as UI Handler
+            bb.event.register_UIHhandler(EventLogWriteHandler(self, self.configuration.writeeventlog))
+
         self.inotify_modified_files = []
 
         def _process_inotify_updates(server, notifier_list, abort):
@@ -301,68 +365,6 @@ class BBCooker:
         if consolelog:
             self.data.setVar("BB_CONSOLELOG", consolelog)
 
-        # we log all events to a file if so directed
-        if self.configuration.writeeventlog:
-            import json, pickle
-            DEFAULT_EVENTFILE = self.configuration.writeeventlog
-            class EventLogWriteHandler():
-
-                class EventWriter():
-                    def __init__(self, cooker):
-                        self.file_inited = None
-                        self.cooker = cooker
-                        self.event_queue = []
-
-                    def init_file(self):
-                        try:
-                            # delete the old log
-                            os.remove(DEFAULT_EVENTFILE)
-                        except:
-                            pass
-
-                        # write current configuration data
-                        with open(DEFAULT_EVENTFILE, "w") as f:
-                            f.write("%s\n" % json.dumps({ "allvariables" : self.cooker.getAllKeysWithFlags(["doc", "func"])}))
-
-                    def write_event(self, event):
-                        with open(DEFAULT_EVENTFILE, "a") as f:
-                            try:
-                                f.write("%s\n" % json.dumps({"class":event.__module__ + "." + event.__class__.__name__, "vars":json.dumps(pickle.dumps(event)) }))
-                            except Exception as e:
-                                import traceback
-                                print(e, traceback.format_exc())
-
-
-                    def send(self, event):
-                        event_class = event.__module__ + "." + event.__class__.__name__
-
-                        # init on bb.event.BuildStarted
-                        if self.file_inited is None:
-                            if  event_class == "bb.event.BuildStarted":
-                                self.init_file()
-                                self.file_inited = True
-
-                                # write pending events
-                                for e in self.event_queue:
-                                    self.write_event(e)
-
-                                # also write the current event
-                                self.write_event(event)
-
-                            else:
-                                # queue all events until the file is inited
-                                self.event_queue.append(event)
-
-                        else:
-                            # we have the file, just write the event
-                            self.write_event(event)
-
-                # set our handler's event processor
-                event = EventWriter(self)       # self is the cooker here
-
-            # register the log file writer as UI Handler
-            bb.event.register_UIHhandler(EventLogWriteHandler())
-
         #
         # Copy of the data store which has been expanded.
         # Used for firing events and accessing variables where expansion needs to be accounted for
-- 
2.1.4


