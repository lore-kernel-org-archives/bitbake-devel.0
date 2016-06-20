Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 54C04731A3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jun 2016 11:01:52 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga103.jf.intel.com with ESMTP; 20 Jun 2016 04:01:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,498,1459839600"; d="scan'208";a="831613649"
Received: from linux.intel.com ([10.54.29.200])
	by orsmga003.jf.intel.com with ESMTP; 20 Jun 2016 04:01:53 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.68])
	by linux.intel.com (Postfix) with ESMTP id 22CAF6A4080
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jun 2016 04:01:50 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 20 Jun 2016 14:00:51 +0300
Message-Id: <7b81243a567e13fd0524a520f1a7bd6c35a87c90.1466419987.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1466419987.git.ed.bartosh@linux.intel.com>
References: <cover.1466419987.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1466419987.git.ed.bartosh@linux.intel.com>
References: <cover.1466419987.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 4/5] cooker: replace EventLogWriteHandler with namedtuple
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
X-List-Received-Date: Mon, 20 Jun 2016 11:01:52 -0000

class EventLogWriteHandler is a simple wrapper class with only one
class member. Replacing it with namedtuple makes code less nested and more
readable.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/bb/cooker.py | 86 +++++++++++++++++++++++-------------------------
 1 file changed, 41 insertions(+), 45 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index ca53ff4..3e4f8d8 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -33,7 +33,7 @@ import threading
 from io import StringIO
 from contextlib import closing
 from functools import wraps
-from collections import defaultdict
+from collections import defaultdict, namedtuple
 import bb, bb.exceptions, bb.command
 from bb import utils, data, parse, event, cache, providers, taskdata, runqueue, build
 import queue
@@ -117,58 +117,52 @@ class CookerFeatures(object):
         return next(self._features)
 
 
-class EventLogWriteHandler:
-
+class EventWriter:
     def __init__(self, cooker, eventfile):
-        # set our handler's event processor
-        self.event = self.EventWriter(cooker, eventfile)
-
-    class EventWriter:
-        def __init__(self, cooker, eventfile):
-            self.file_inited = None
-            self.cooker = cooker
-            self.eventfile = eventfile
-            self.event_queue = []
-
-        def init_file(self):
-            # write current configuration data
-            with open(eventfile, "w") as f:
-                f.write("%s\n" % json.dumps({ "allvariables" : self.cooker.getAllKeysWithFlags(["doc", "func"])}))
-
-        def write_event(self, event):
-            with open(self.eventfile, "a") as f:
-                try:
-                    str_event = codecs.encode(pickle.dumps(event), 'base64').decode('utf-8')
-                    f.write("%s\n" % json.dumps({"class": event.__module__ + "." + event.__class__.__name__,
-                                                 "vars": str_event}))
-                except Exception as e:
-                    import traceback
-                    print(e, traceback.format_exc())
+        self.file_inited = None
+        self.cooker = cooker
+        self.eventfile = eventfile
+        self.event_queue = []
 
+    def init_file(self):
+        # write current configuration data
+        with open(eventfile, "w") as f:
+            f.write("%s\n" % json.dumps({ "allvariables" : self.cooker.getAllKeysWithFlags(["doc", "func"])}))
+
+    def write_event(self, event):
+        with open(self.eventfile, "a") as f:
+            try:
+                str_event = codecs.encode(pickle.dumps(event), 'base64').decode('utf-8')
+                f.write("%s\n" % json.dumps({"class": event.__module__ + "." + event.__class__.__name__,
+                                             "vars": str_event}))
+            except Exception as e:
+                import traceback
+                print(e, traceback.format_exc())
 
-        def send(self, event):
-            event_class = event.__module__ + "." + event.__class__.__name__
 
-            # init on bb.event.BuildStarted
-            if self.file_inited is None:
-                if  event_class == "bb.event.BuildStarted":
-                    self.init_file()
-                    self.file_inited = True
+    def send(self, event):
+        event_class = event.__module__ + "." + event.__class__.__name__
 
-                    # write pending events
-                    for e in self.event_queue:
-                        self.write_event(e)
+        # init on bb.event.BuildStarted
+        if self.file_inited is None:
+            if  event_class == "bb.event.BuildStarted":
+                self.init_file()
+                self.file_inited = True
 
-                    # also write the current event
-                    self.write_event(event)
+                # write pending events
+                for e in self.event_queue:
+                    self.write_event(e)
 
-                else:
-                    # queue all events until the file is inited
-                    self.event_queue.append(event)
+                # also write the current event
+                self.write_event(event)
 
             else:
-                # we have the file, just write the event
-                self.write_event(event)
+                # queue all events until the file is inited
+                self.event_queue.append(event)
+
+        else:
+            # we have the file, just write the event
+            self.write_event(event)
 
 #============================================================================#
 # BBCooker
@@ -210,7 +204,9 @@ class BBCooker:
         # we log all events to a file if so directed
         if self.configuration.writeeventlog:
             # register the log file writer as UI Handler
-            bb.event.register_UIHhandler(EventLogWriteHandler(self, self.configuration.writeeventlog))
+            writer = EventWriter(self, self.configuration.writeeventlog)
+            EventLogWriteHandler = namedtuple('EventLogWriteHandler', ['event'])
+            bb.event.register_UIHhandler(EventLogWriteHandler(writer))
 
         self.inotify_modified_files = []
 
-- 
2.1.4


