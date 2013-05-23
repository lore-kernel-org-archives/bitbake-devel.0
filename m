Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 9067A6086B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 May 2013 09:50:42 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r4N9s0fK017530 for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 May 2013 10:54:24 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id wcMce1q1LuYM for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 May 2013 10:54:23 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r4N9sLlO017544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 May 2013 10:54:23 +0100
Message-ID: <1369302630.14887.30.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 23 May 2013 10:50:30 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] cooker/cookerdata/event: Improve class handlers management
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
X-List-Received-Date: Thu, 23 May 2013 09:50:43 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Similarly to the execution context changes, establish better lifetime
management API of the class event handlers.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index e868647..4c0b569 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1455,7 +1455,7 @@ class Parser(multiprocessing.Process):
         self.init = init
         multiprocessing.Process.__init__(self)
         self.context = bb.utils.get_context().copy()
-        self.handlers = bb.event._handlers.copy()
+        self.handlers = bb.event.get_class_handlers().copy()
 
     def run(self):
         if self.init:
@@ -1492,7 +1492,7 @@ class Parser(multiprocessing.Process):
         try:
             # Reset our environment and handlers to the original settings
             bb.utils.set_context(self.context.copy())
-            bb.event._handlers = self.handlers.copy()
+            bb.event.set_class_handlers(self.handlers.copy())
             return True, bb.cache.Cache.parse(filename, appends, self.cfg, caches_array)
         except Exception as exc:
             tb = sys.exc_info()[2]
diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
index efcc765..ccaeab0 100644
--- a/bitbake/lib/bb/cookerdata.py
+++ b/bitbake/lib/bb/cookerdata.py
@@ -174,6 +174,7 @@ class CookerDataBuilder(object):
         self.tracking = params.tracking
 
         bb.utils.set_context(bb.utils.clean_context())
+        bb.event.set_class_handlers(bb.event.clean_class_handlers())
         self.data = bb.data.init()
         if self.tracking:
             self.data.enableTracking()
diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index 11c063f..2826e35 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -50,8 +50,17 @@ class Event(object):
 Registered        = 10
 AlreadyRegistered = 14
 
+def get_class_handlers():
+    return _handlers
+
+def set_class_handlers(h):
+    _handlers = h
+
+def clean_class_handlers():
+    return bb.compat.OrderedDict()
+
 # Internal
-_handlers = bb.compat.OrderedDict()
+_handlers = clean_class_handlers()
 _ui_handlers = {}
 _ui_handler_seq = 0
 



