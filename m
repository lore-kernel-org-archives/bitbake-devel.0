Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id CE59860110
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jun 2016 11:02:00 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga101.fm.intel.com with ESMTP; 20 Jun 2016 04:02:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,498,1459839600"; d="scan'208";a="722189988"
Received: from linux.intel.com ([10.54.29.200])
	by FMSMGA003.fm.intel.com with ESMTP; 20 Jun 2016 04:02:01 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.68])
	by linux.intel.com (Postfix) with ESMTP id 204AD6A4080
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jun 2016 04:01:58 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 20 Jun 2016 14:00:52 +0300
Message-Id: <e322136198c42fbbfda40b61e7f932ac2f8a2203.1466419987.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1466419987.git.ed.bartosh@linux.intel.com>
References: <cover.1466419987.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1466419987.git.ed.bartosh@linux.intel.com>
References: <cover.1466419987.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 5/5] cooker: clean up EvertWriter
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
X-List-Received-Date: Mon, 20 Jun 2016 11:02:00 -0000

Restructured EventWriter code to make it more readable:
 - got rid of init_file method as it's called only once
 - renamed exception variable e -> err
 - renamed event variable e -> evt
 - simplified main 'if' structure of send method

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/bb/cooker.py | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 3e4f8d8..9bd3460 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -124,46 +124,39 @@ class EventWriter:
         self.eventfile = eventfile
         self.event_queue = []
 
-    def init_file(self):
-        # write current configuration data
-        with open(eventfile, "w") as f:
-            f.write("%s\n" % json.dumps({ "allvariables" : self.cooker.getAllKeysWithFlags(["doc", "func"])}))
-
     def write_event(self, event):
         with open(self.eventfile, "a") as f:
             try:
                 str_event = codecs.encode(pickle.dumps(event), 'base64').decode('utf-8')
                 f.write("%s\n" % json.dumps({"class": event.__module__ + "." + event.__class__.__name__,
                                              "vars": str_event}))
-            except Exception as e:
+            except Exception as err:
                 import traceback
-                print(e, traceback.format_exc())
-
+                print(err, traceback.format_exc())
 
     def send(self, event):
-        event_class = event.__module__ + "." + event.__class__.__name__
+        if self.file_inited:
+            # we have the file, just write the event
+            self.write_event(event)
+        else:
+            # init on bb.event.BuildStarted
+            name = "%s.%s" % (event.__module__, event.__class__.__name__)
+            if name == "bb.event.BuildStarted":
+                with open(self.eventfile, "w") as f:
+                    f.write("%s\n" % json.dumps({ "allvariables" : self.cooker.getAllKeysWithFlags(["doc", "func"])}))
 
-        # init on bb.event.BuildStarted
-        if self.file_inited is None:
-            if  event_class == "bb.event.BuildStarted":
-                self.init_file()
                 self.file_inited = True
 
                 # write pending events
-                for e in self.event_queue:
-                    self.write_event(e)
+                for evt in self.event_queue:
+                    self.write_event(evt)
 
                 # also write the current event
                 self.write_event(event)
-
             else:
                 # queue all events until the file is inited
                 self.event_queue.append(event)
 
-        else:
-            # we have the file, just write the event
-            self.write_event(event)
-
 #============================================================================#
 # BBCooker
 #============================================================================#
-- 
2.1.4


