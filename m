Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id C18A160896
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Aug 2013 14:55:33 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r7NF7UxF020943 for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Aug 2013 16:07:30 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id oijxvmXHusDe for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Aug 2013 16:07:30 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r7NF7StT020939
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Aug 2013 16:07:29 +0100
Message-ID: <1377269721.6762.89.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 23 Aug 2013 15:55:21 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] event/msg: Add primitive server side UI log record filtering
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
X-List-Received-Date: Fri, 23 Aug 2013 14:55:35 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently one of the bigger bottlenecks in bitbake is passing all the 
log messages over IPC to the UI. This is worthwhile if the UI is going 
to use them, pointless otherwise. The memory resident bitbake suffers
from this performance issue particularly badly.

This patch filters the log events on the server side with the global
log levels and hence reduces the traffic. This speeds up parsing 
(18.5s down to 17s) and bitbake general command overhead is reduced 
(7.3s for a NOP to 6.2s).

What isn't added here is general event filtering or the ability to 
change the log levels once set. Provision is made for adding this
in a follow up patch though.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index ba25d38..8ffd2c3 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -63,6 +63,7 @@ def clean_class_handlers():
 # Internal
 _handlers = clean_class_handlers()
 _ui_handlers = {}
+_ui_logfilters = {}
 _ui_handler_seq = 0
 _event_handler_map = {}
 _catchall_handlers = {}
@@ -135,6 +136,8 @@ def fire_ui_handlers(event, d):
     for h in _ui_handlers:
         #print "Sending event %s" % event
         try:
+             if not _ui_logfilters[h].filter(event):
+                 continue
              # We use pickle here since it better handles object instances
              # which xmlrpc's marshaller does not. Events *must* be serializable
              # by pickle.
@@ -207,6 +210,8 @@ def remove(name, handler):
 def register_UIHhandler(handler):
     bb.event._ui_handler_seq = bb.event._ui_handler_seq + 1
     _ui_handlers[_ui_handler_seq] = handler
+    level, debug_domains = bb.msg.constructLogOptions()
+    _ui_logfilters[_ui_handler_seq] = UIEventFilter(level, debug_domains)
     return _ui_handler_seq
 
 def unregister_UIHhandler(handlerNum):
@@ -214,6 +219,26 @@ def unregister_UIHhandler(handlerNum):
         del _ui_handlers[handlerNum]
     return
 
+# Class to allow filtering of events and specific filtering of LogRecords *before* we put them over the IPC
+class UIEventFilter(object):
+    def __init__(self, level, debug_domains):
+        self.update(None, level, debug_domains)
+
+    def update(self, eventmask, level, debug_domains):
+        self.eventmask = None
+        self.stdlevel = level
+        self.debug_domains = debug_domains
+
+    def filter(self, event):
+        if isinstance(event, logging.LogRecord):
+            if event.levelno >= self.stdlevel:
+                return True
+            if event.name in self.debug_domains and event.levelno >= self.debug_domains[event.name]:
+                return True
+            return False
+        # Implement other event masking here on self.eventmask
+        return True
+
 def getName(e):
     """Returns the name of a class or class instance"""
     if getattr(e, "__name__", None) == None:
diff --git a/bitbake/lib/bb/msg.py b/bitbake/lib/bb/msg.py
index e70daee..5976970 100644
--- a/bitbake/lib/bb/msg.py
+++ b/bitbake/lib/bb/msg.py
@@ -146,8 +146,7 @@ def init_msgconfig(verbose, debug, debug_domains = []):
         bb.msg.loggerVerboseLogs = True
     bb.msg.loggerDefaultDomains = debug_domains
 
-def addDefaultlogFilter(handler):
-
+def constructLogOptions():
     debug = loggerDefaultDebugLevel
     verbose = loggerDefaultVerbose
     domains = loggerDefaultDomains
@@ -163,6 +162,10 @@ def addDefaultlogFilter(handler):
     for (domainarg, iterator) in groupby(domains):
         dlevel = len(tuple(iterator))
         debug_domains["BitBake.%s" % domainarg] = logging.DEBUG - dlevel + 1
+    return level, debug_domains
+
+def addDefaultlogFilter(handler):
+    level, debug_domains = constructLogOptions()
 
     BBLogFilter(handler, level, debug_domains)
 



