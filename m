Return-Path: <anibal.limon@linux.intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by mail.openembedded.org (Postfix) with ESMTP id BE126719C3
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Oct 2016 21:14:57 +0000 (UTC)
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by fmsmga105.fm.intel.com with ESMTP; 04 Oct 2016 14:14:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,445,1473145200"; d="scan'208";a="16275346"
Received: from alimonb-mobl1.zpn.intel.com ([10.219.5.33])
	by orsmga005.jf.intel.com with ESMTP; 04 Oct 2016 14:14:57 -0700
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  4 Oct 2016 16:15:56 -0500
Message-Id: <1475615756-3556-1-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Cc: joshua.g.lock@intel.com, clarson@kergoth.com
Subject: [PATCHv2] bb/event.py: fire_ui_handlers enable threading lock support
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
X-List-Received-Date: Tue, 04 Oct 2016 21:14:57 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In some cases there is a need to fire bb events into multiple
python threads so locking is needed (writing to a fd/socket).

Adding a helper functions for disable/enable by request to avoid
overhead.

[YOCTO #10330]

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 lib/bb/event.py                     | 21 +++++++++++++++++++++
 lib/toaster/tests/functional/README |  0
 2 files changed, 21 insertions(+)
 create mode 100644 lib/toaster/tests/functional/README

diff --git a/lib/bb/event.py b/lib/bb/event.py
index 42745e2..65b7ebb 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -29,6 +29,8 @@ import logging
 import atexit
 import traceback
 import ast
+import threading
+
 import bb.utils
 import bb.compat
 import bb.exceptions
@@ -68,12 +70,22 @@ _event_handler_map = {}
 _catchall_handlers = {}
 _eventfilter = None
 _uiready = False
+_thread_lock = threading.Lock()
+_thread_lock_enabled = False
 
 if hasattr(__builtins__, '__setitem__'):
     builtins = __builtins__
 else:
     builtins = __builtins__.__dict__
 
+def enable_threadlock():
+    global _thread_lock_enabled
+    _thread_lock_enabled = True
+
+def disable_threadlock():
+    global _thread_lock_enabled
+    _thread_lock_enabled = False
+
 def execute_handler(name, handler, event, d):
     event.data = d
     addedd = False
@@ -146,11 +158,17 @@ def print_ui_queue():
                 logger.handle(event)
 
 def fire_ui_handlers(event, d):
+    global _thread_lock
+    global _thread_lock_enabled
+
     if not _uiready:
         # No UI handlers registered yet, queue up the messages
         ui_queue.append(event)
         return
 
+    if _thread_lock_enabled:
+        _thread_lock.acquire()
+
     errors = []
     for h in _ui_handlers:
         #print "Sending event %s" % event
@@ -169,6 +187,9 @@ def fire_ui_handlers(event, d):
     for h in errors:
         del _ui_handlers[h]
 
+    if _thread_lock_enabled:
+        _thread_lock.release()
+
 def fire(event, d):
     """Fire off an Event"""
 
diff --git a/lib/toaster/tests/functional/README b/lib/toaster/tests/functional/README
new file mode 100644
index 0000000..e69de29
-- 
2.1.4


