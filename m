Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id AB63F71633
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 16:07:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t0LG7a1u000670 for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 16:07:36 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 6ZpDUx4oI7oa for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 16:07:36 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t0LG7JO0000640
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 16:07:31 GMT
Message-ID: <1421856439.19798.0.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 21 Jan 2015 16:07:19 +0000
X-Mailer: Evolution 3.12.7-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] cooker: Rename event_data -> expanded_data
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
X-List-Received-Date: Wed, 21 Jan 2015 16:07:45 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

event_data would be better named expanded_data, then we can widen its scope
to other places in cooker where we need to access an expanded data store.
We certainly don't want multiple expanded data stores.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index 29b0a53..24ff341 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -123,11 +123,11 @@ class Command:
 
     def finishAsyncCommand(self, msg=None, code=None):
         if msg or msg == "":
-            bb.event.fire(CommandFailed(msg), self.cooker.event_data)
+            bb.event.fire(CommandFailed(msg), self.cooker.expanded_data)
         elif code:
-            bb.event.fire(CommandExit(code), self.cooker.event_data)
+            bb.event.fire(CommandExit(code), self.cooker.expanded_data)
         else:
-            bb.event.fire(CommandCompleted(), self.cooker.event_data)
+            bb.event.fire(CommandCompleted(), self.cooker.expanded_data)
         self.currentAsyncCommand = None
         self.cooker.finishcommand()
 
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index d9b200e..a7560a1 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -324,11 +324,12 @@ class BBCooker:
 
 
         #
-        # Special updated configuration we use for firing events
+        # Copy of the data store which has been expanded.
+        # Used for firing events and accessing variables where expansion needs to be accounted for
         #
-        self.event_data = bb.data.createCopy(self.data)
-        bb.data.update_data(self.event_data)
-        bb.parse.init_parser(self.event_data)
+        self.expanded_data = bb.data.createCopy(self.data)
+        bb.data.update_data(self.expanded_data)
+        bb.parse.init_parser(self.expanded_data)
 
         if CookerFeatures.BASEDATASTORE_TRACKING in self.featureset:
             self.disableDataTracking()
@@ -1182,7 +1183,7 @@ class BBCooker:
             bf = os.path.abspath(bf)
 
         self.collection = CookerCollectFiles(self.recipecache.bbfile_config_priorities)
-        filelist, masked = self.collection.collect_bbfiles(self.data, self.event_data)
+        filelist, masked = self.collection.collect_bbfiles(self.data, self.expanded_data)
         try:
             os.stat(bf)
             bf = os.path.abspath(bf)
@@ -1272,7 +1273,7 @@ class BBCooker:
         taskdata.add_provider(self.data, self.recipecache, item)
 
         buildname = self.data.getVar("BUILDNAME")
-        bb.event.fire(bb.event.BuildStarted(buildname, [item]), self.event_data)
+        bb.event.fire(bb.event.BuildStarted(buildname, [item]), self.expanded_data)
 
         # Execute the runqueue
         runlist = [[item, "do_%s" % task]]
@@ -1299,7 +1300,7 @@ class BBCooker:
                 return False
 
             if not retval:
-                bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runq_fnid), buildname, item, failures), self.event_data)
+                bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runq_fnid), buildname, item, failures), self.expanded_data)
                 self.command.finishAsyncCommand(msg)
                 return False
             if retval is True:
@@ -1446,14 +1447,14 @@ class BBCooker:
             if CookerFeatures.SEND_SANITYEVENTS in self.featureset:
                 bb.event.fire(bb.event.SanityCheck(False), self.data)
 
-            ignore = self.data.getVar("ASSUME_PROVIDED", True) or ""
+            ignore = self.expanded_data.getVar("ASSUME_PROVIDED", True) or ""
             self.recipecache.ignored_dependencies = set(ignore.split())
 
             for dep in self.configuration.extra_assume_provided:
                 self.recipecache.ignored_dependencies.add(dep)
 
             self.collection = CookerCollectFiles(self.recipecache.bbfile_config_priorities)
-            (filelist, masked) = self.collection.collect_bbfiles(self.data, self.event_data)
+            (filelist, masked) = self.collection.collect_bbfiles(self.data, self.expanded_data)
 
             self.data.renameVar("__depends", "__base_depends")
             self.add_filewatch(self.data.getVar("__base_depends"), self.configwatcher)
@@ -1513,13 +1514,13 @@ class BBCooker:
         try:
             self.prhost = prserv.serv.auto_start(self.data)
         except prserv.serv.PRServiceConfigError:
-            bb.event.fire(CookerExit(), self.event_data)
+            bb.event.fire(CookerExit(), self.expanded_data)
             self.state = state.error
         return
 
     def post_serve(self):
         prserv.serv.auto_shutdown(self.data)
-        bb.event.fire(CookerExit(), self.event_data)
+        bb.event.fire(CookerExit(), self.expanded_data)
 
     def shutdown(self, force = False):
         if force:



