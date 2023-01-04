Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13019C46467
	for <webhook@archiver.kernel.org>; Wed,  4 Jan 2023 12:42:43 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web10.11022.1672836159393664633
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Jan 2023 04:42:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=A8X180ps;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id g10so11656759wmo.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 04 Jan 2023 04:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TnNHCr4NWfn1vg3g6TSru/48pQT0FwKHQcS+5G6X+ic=;
        b=A8X180psnGFJoD5XZN4BTOsvkwsVCMUVP61fqPNtlZdy3j6eNG/aqN9zR3t5hhN9O0
         8FA7qsEikUOLWytOg80bhcRT1DGdSezoeuGcZqMKbRLZ9jX4kNK7mWCd/C55oCVVWltH
         mgoM6pILD0F9kizwsBzKOY8+w9zcBKtTbLEmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TnNHCr4NWfn1vg3g6TSru/48pQT0FwKHQcS+5G6X+ic=;
        b=pM47tn3RBDtPa3KodPOHeWVMfOvB1RFOmqczrf61Ps05WAPsVn2ON/9BZ0QTp8o3Na
         P72ELnYV8TucfDmzxYKPHfp79Of6UPGxj3MEwvTMJcQB3OoqwIkAfgBl+1eJQ+NrVNKc
         9G2b+H0lHyLcE5EqAIDX0Jui3w3YC42VFSzeWslm7tekXO/p5dECTHCyvfuEEU3SMCCv
         xkwAiD771wFy+x2H+S4gA1W+sEVVnjiOt/AyKXUl413AroJjrX/XZiQBACsYQundpYwj
         Y1AQtu5EuG9srGKcU/gY61dFXX9j3TUdZao12ctngHBN7il77YLp/efDUXf8BOxgwuY7
         eZ2g==
X-Gm-Message-State: AFqh2kowqLQclz0ToMcRRpUv6/OUVoFSgD2dzzA5hwybu/c9jVABRb3o
	MZ4L/IdV1+j54GDFRyPVIV0BKoV4ZuoqUC+I
X-Google-Smtp-Source: AMrXdXsjkn/1z25HCCyKmQABRDRACtT2SMxzwxp9WPGGUJEOAJOOz60+YxTwQa8XQmSjXSihHLVl1Q==
X-Received: by 2002:a05:600c:5554:b0:3cf:8e5d:7184 with SMTP id iz20-20020a05600c555400b003cf8e5d7184mr34176409wmb.28.1672836157519;
        Wed, 04 Jan 2023 04:42:37 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:fcc2:4e85:26d2:6527])
        by smtp.gmail.com with ESMTPSA id b9-20020adff909000000b00267bcb1bbe5sm33635894wrr.56.2023.01.04.04.42.37
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 04:42:37 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] lib/bb: Update thread/process locks to use a timeout
Date: Wed,  4 Jan 2023 12:42:35 +0000
Message-Id: <20230104124235.1160557-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 04 Jan 2023 12:42:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14287

The thread/process locks we use translate to futexes in Linux. If a
process dies holding the lock, anything else trying to take the lock
will hang indefinitely. An example would be the OOM killer taking out
a parser process.

To avoid bitbake processes just hanging indefinitely, add a timeout to
our lock calls using a context manager. If we can't obtain the lock
after waiting 5 minutes, hard exit out using os._exit(1). Use _exit()
to avoid locking in any other places trying to write error messages to
event handler queues (which also need locks).

Whilst a bit harsh, this should mean we stop having lots of long running
processes in cases where things are never going to work out and also
avoids hanging builds on the autobuilder.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-worker       |  9 ++++-----
 lib/bb/cooker.py         |  4 ++--
 lib/bb/event.py          |  6 +++---
 lib/bb/server/process.py | 16 ++++++++--------
 lib/bb/ui/uievent.py     | 28 ++++++++++------------------
 lib/bb/utils.py          | 13 +++++++++++++
 6 files changed, 40 insertions(+), 36 deletions(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index ed266f0ac2..a3ea5d9618 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -121,11 +121,10 @@ def worker_child_fire(event, d):
 
     data = b"<event>" + pickle.dumps(event) + b"</event>"
     try:
-        worker_pipe_lock.acquire()
-        while(len(data)):
-            written = worker_pipe.write(data)
-            data = data[written:]
-        worker_pipe_lock.release()
+        with bb.utils.lock_timeout(worker_pipe_lock):
+            while(len(data)):
+                written = worker_pipe.write(data)
+                data = data[written:]
     except IOError:
         sigterm_handler(None, None)
         raise
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index a5a635858c..738849d189 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -251,14 +251,14 @@ class BBCooker:
         self.notifier = pyinotify.Notifier(self.watcher, self.notifications)
 
     def process_inotify_updates(self):
-        with self.inotify_threadlock:
+        with bb.utils.lock_timeout(self.inotify_threadlock):
             for n in [self.confignotifier, self.notifier]:
                 if n and n.check_events(timeout=0):
                     # read notified events and enqueue them
                     n.read_events()
 
     def process_inotify_updates_apply(self):
-        with self.inotify_threadlock:
+        with bb.utils.lock_timeout(self.inotify_threadlock):
             for n in [self.confignotifier, self.notifier]:
                 if n and n.check_events(timeout=0):
                     n.read_events()
diff --git a/lib/bb/event.py b/lib/bb/event.py
index 7826541a64..8b05f93e2f 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -184,7 +184,7 @@ def fire_ui_handlers(event, d):
         ui_queue.append(event)
         return
 
-    with _thread_lock:
+    with bb.utils.lock_timeout(_thread_lock):
         errors = []
         for h in _ui_handlers:
             #print "Sending event %s" % event
@@ -315,7 +315,7 @@ def set_eventfilter(func):
     _eventfilter = func
 
 def register_UIHhandler(handler, mainui=False):
-    with _thread_lock:
+    with bb.utils.lock_timeout(_thread_lock):
         bb.event._ui_handler_seq = bb.event._ui_handler_seq + 1
         _ui_handlers[_ui_handler_seq] = handler
         level, debug_domains = bb.msg.constructLogOptions()
@@ -329,7 +329,7 @@ def unregister_UIHhandler(handlerNum, mainui=False):
     if mainui:
         global _uiready
         _uiready = False
-    with _thread_lock:
+    with bb.utils.lock_timeout(_thread_lock):
         if handlerNum in _ui_handlers:
             del _ui_handlers[handlerNum]
     return
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index b35c74ca40..78fdc6cf71 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -113,7 +113,7 @@ class ProcessServer():
     def register_idle_function(self, function, data):
         """Register a function to be called while the server is idle"""
         assert hasattr(function, '__call__')
-        with self._idlefuncsLock:
+        with bb.utils.lock_timeout(self._idlefuncsLock):
             self._idlefuns[function] = data
             handlers = len(self._idlefuns)
         serverlog("Registering idle function %s (%s handlers)" % (str(function), str(handlers)))
@@ -380,7 +380,7 @@ class ProcessServer():
 
     def idle_thread(self):
         def remove_idle_func(function):
-            with self._idlefuncsLock:
+            with bb.utils.lock_timeout(self._idlefuncsLock):
                 del self._idlefuns[function]
                 self.idle_cond.notify_all()
 
@@ -389,7 +389,7 @@ class ProcessServer():
             nextsleep = 0.1
             fds = []
 
-            with self._idlefuncsLock:
+            with bb.utils.lock_timeout(self._idlefuncsLock):
                 items = list(self._idlefuns.items())
 
             for function, data in items:
@@ -751,7 +751,7 @@ class BBUIEventQueue:
         self.t.start()
 
     def getEvent(self):
-        with self.eventQueueLock:
+        with bb.utils.lock_timeout(self.eventQueueLock):
             if len(self.eventQueue) == 0:
                 return None
 
@@ -766,7 +766,7 @@ class BBUIEventQueue:
         return self.getEvent()
 
     def queue_event(self, event):
-        with self.eventQueueLock:
+        with bb.utils.lock_timeout(self.eventQueueLock):
             self.eventQueue.append(event)
             self.eventQueueNotify.set()
 
@@ -802,7 +802,7 @@ class ConnectionReader(object):
         return self.reader.poll(timeout)
 
     def get(self):
-        with self.rlock:
+        with bb.utils.lock_timeout(self.rlock):
             res = self.reader.recv_bytes()
         return multiprocessing.reduction.ForkingPickler.loads(res)
 
@@ -823,7 +823,7 @@ class ConnectionWriter(object):
 
     def _send(self, obj):
         gc.disable()
-        with self.wlock:
+        with bb.utils.lock_timeout(self.wlock):
             self.writer.send_bytes(obj)
         gc.enable()
 
@@ -836,7 +836,7 @@ class ConnectionWriter(object):
         # pthread_sigmask block/unblock would be nice but doesn't work, https://bugs.python.org/issue47139
         process = multiprocessing.current_process()
         if process and hasattr(process, "queue_signals"):
-            with process.signal_threadlock:
+            with bb.utils.lock_timeout(process.signal_threadlock):
                 process.queue_signals = True
                 self._send(obj)
                 process.queue_signals = False
diff --git a/lib/bb/ui/uievent.py b/lib/bb/ui/uievent.py
index d595f172ac..adbe698939 100644
--- a/lib/bb/ui/uievent.py
+++ b/lib/bb/ui/uievent.py
@@ -70,30 +70,22 @@ class BBUIEventQueue:
         self.t.start()
 
     def getEvent(self):
-
-        self.eventQueueLock.acquire()
-
-        if not self.eventQueue:
-            self.eventQueueLock.release()
-            return None
-
-        item = self.eventQueue.pop(0)
-
-        if not self.eventQueue:
-            self.eventQueueNotify.clear()
-
-        self.eventQueueLock.release()
-        return item
+        with bb.utils.lock_timeout(self.eventQueueLock):
+            if not self.eventQueue:
+                return None
+            item = self.eventQueue.pop(0)
+            if not self.eventQueue:
+                self.eventQueueNotify.clear()
+            return item
 
     def waitEvent(self, delay):
         self.eventQueueNotify.wait(delay)
         return self.getEvent()
 
     def queue_event(self, event):
-        self.eventQueueLock.acquire()
-        self.eventQueue.append(event)
-        self.eventQueueNotify.set()
-        self.eventQueueLock.release()
+        with bb.utils.lock_timeout(self.eventQueueLock):
+            self.eventQueue.append(event)
+            self.eventQueueNotify.set()
 
     def send_event(self, event):
         self.queue_event(pickle.loads(event))
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 0df522b372..8c79159573 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1841,3 +1841,16 @@ def mkstemp(suffix=None, prefix=None, dir=None, text=False):
     else:
         prefix = tempfile.gettempprefix() + entropy
     return tempfile.mkstemp(suffix=suffix, prefix=prefix, dir=dir, text=text)
+
+# If we don't have a timeout of some kind and a process/thread exits badly (for example
+# OOM killed) and held a lock, we'd just hang in the lock futex forever. It is better
+# we exit at some point than hang. 5 minutes with no progress means we're probably deadlocked.
+@contextmanager
+def lock_timeout(lock):
+    held = lock.acquire(timeout=5*60)
+    try:
+        if not held:
+            os._exit(1)
+        yield held
+    finally:
+        lock.release()
-- 
2.37.2


