Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289BCC282C5
	for <webhook@archiver.kernel.org>; Mon,  3 Mar 2025 13:06:45 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.52731.1741007195795726878
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Mar 2025 05:06:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=CROr27qG;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43995b907cfso27733065e9.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 03 Mar 2025 05:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741007194; x=1741611994; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XhUbSsFhiQIZ2dHbNRUwrvl29VtI7f1iyDPnmh5/Mow=;
        b=CROr27qG+h+esh5DqMIHA7m3IhSGHGbsmte83oAquXuzeGkOTBoF/516/4VP9OJ35W
         wrv4PEBS2gzsjFghZuRp8pRHcPTZKH68iWqPhDv15qZ/2ynx1sSosZavpnZLWarEEA2P
         kj6NaPFUNBfRuUfyZkmqyovOeCx78+8OLrFgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741007194; x=1741611994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XhUbSsFhiQIZ2dHbNRUwrvl29VtI7f1iyDPnmh5/Mow=;
        b=cZSYo85ZakLfPOOzKFkKFGRQ2NpTnWj5gyafenDqYgbS6jJtkpG15V9LeZxL1B+Pjx
         bff+Oe6rBXgy7htpVSIP1rlVmynubfUYkNypdjU7qbxZNRuxon84+/vVX8tYn41OhycY
         zTo/mprEHNF9ywFC/UOpydtYRHQMUcGOqkX/qtUA0y9xA/DoBg1RvD9Bv60e3ZKUL5gb
         bWczZz35Eh9M5zXzv7Y18WtETmq4NUkOgSUiNO7Fz0syox9UTTSazxt6W52q+jiDeLFl
         l/7ObF7mEuO0PCOp/FyNRLOkCAMxkgzw7GnkLspBYygv9imMgU3M8EjSKUQCxV5ioQ56
         DyLA==
X-Gm-Message-State: AOJu0YzdYKnfS+p6zNfCxkS/WCdp+uS5WBynfYA5fh+xljf5b51proAU
	1RG2K3zbYHY8LVdqzfq+CV1eShXroualobCamfmliLgEIUpenT/F9FzulDKVQprflWzqmr+CwWl
	t
X-Gm-Gg: ASbGncuTKL4n6y/i2B62NBk56HNFNfnzL2TTDAO7kdKOGqrJ1lepyHX6XCgY81RiZnC
	OpRP9wuYclhK+xmFX9yHrPRS6IsmnUB5bTMp7dxxWTRj8UNQFuslZikAazZpaRgAheIEI2KBG2i
	9UrmWHerYy9FJ9CeeINlmt8MPao6dT0BfmZ4MKEZGcviijdRYLqUK2ePm0Q+nRUHKnaNvTvJBnf
	dGuluz1b7HBqqxIRsznI9NxCyQwo2bnqvvYOA2Sc1B8X0B/ZUfOjEHi/h2Y/QrpdTQepMhXTPPM
	fY4Os5L4hxIAqY0mv4SSxbDW6XqVh5cPE2R2Ur3xbVYe559tj3+VK1R18A1+ns/j7Hl9JRvV
X-Google-Smtp-Source: AGHT+IFpYE46bf++hfJeGIgPVUko/Ri5HbaTldGJIZH+o0jyLrjzyTyuHgGacriD1mrvsXlzqybJRw==
X-Received: by 2002:a05:600c:5488:b0:43b:c825:f0de with SMTP id 5b1f17b1804b1-43bc825f236mr13868905e9.12.1741007193743;
        Mon, 03 Mar 2025 05:06:33 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:c70:3037:60d2:90d7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7a27af83sm160667145e9.30.2025.03.03.05.06.32
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:06:32 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 4/4] event/utils: Avoid deadlock from lock_timeout() and recursive events
Date: Mon,  3 Mar 2025 13:06:28 +0000
Message-ID: <20250303130628.1656131-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250303130628.1656131-1-richard.purdie@linuxfoundation.org>
References: <20250303130628.1656131-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 03 Mar 2025 13:06:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17372

We've been seeing intermittent failures on Ubuntu 22.04 in oe-selftest which
were problematic to debug. The failure was inside lock_timeout and once that was
identified and the backtrace obtained, the problem becomes clearer:

  File "X/bitbake/lib/bb/server/process.py", line 466, in idle_thread_internal
    retval = function(self, data, False)
  File "X/bitbake/lib/bb/command.py", line 123, in runAsyncCommand
    self.cooker.updateCache()
  File "X/bitbake/lib/bb/cooker.py", line 1629, in updateCache
    self.parser = CookerParser(self, mcfilelist, total_masked)
  File "X/bitbake/lib/bb/cooker.py", line 2141, in __init__
    self.bb_caches = bb.cache.MulticonfigCache(self.cfgbuilder, self.cfghash, cooker.caches_array)
  File "X/bitbake/lib/bb/cache.py", line 772, in __init__
    loaded += c.prepare_cache(progress)
  File "X/bitbake/lib/bb/cache.py", line 435, in prepare_cache
    loaded = self.load_cachefile(progress)
  File "X/bitbake/lib/bb/cache.py", line 516, in load_cachefile
    progress(cachefile.tell() + previous_progress)
  File "X/bitbake/lib/bb/cache.py", line 751, in progress
    bb.event.fire(bb.event.CacheLoadProgress(current_progress, cachesize),
  File "X/bitbake/lib/bb/event.py", line 234, in fire
    fire_ui_handlers(event, d)
  File "X/bitbake/lib/bb/event.py", line 210, in fire_ui_handlers
    _ui_handlers[h].event.send(event)
  File "X/bitbake/lib/bb/cooker.py", line 117, in send
    str_event = codecs.encode(pickle.dumps(event), \'base64\').decode(\'utf-8\')
  File "/usr/lib/python3.10/asyncio/sslproto.py", line 320, in __del__
    _warn(f"unclosed transport {self!r}", ResourceWarning, source=self)
  File "/usr/lib/python3.10/warnings.py", line 109, in _showwarnmsg
    sw(msg.message, msg.category, msg.filename, msg.lineno,
  File "X/bitbake/lib/bb/main.py", line 113, in _showwarning
    warnlog.warning(s)
  File "/usr/lib/python3.10/logging/__init__.py", line 1489, in warning
    self._log(WARNING, msg, args, **kwargs)
  File "/usr/lib/python3.10/logging/__init__.py", line 1624, in _log
    self.handle(record)
  File "/usr/lib/python3.10/logging/__init__.py", line 1634, in handle
    self.callHandlers(record)
  File "/usr/lib/python3.10/logging/__init__.py", line 1696, in callHandlers
    hdlr.handle(record)
  File "/usr/lib/python3.10/logging/__init__.py", line 968, in handle
    self.emit(record)
  File "X/bitbake/lib/bb/event.py", line 778, in emit
    fire(record, None)
  File "X/bitbake/lib/bb/event.py", line 234, in fire
    fire_ui_handlers(event, d)
  File "X/bitbake/lib/bb/event.py", line 197, in fire_ui_handlers
    with bb.utils.lock_timeout(_thread_lock):
  File "/usr/lib/python3.10/contextlib.py", line 135, in __enter__
    return next(self.gen)
  File "X/bitbake/lib/bb/utils.py", line 1888, in lock_timeout
    bb.server.process.serverlog("Couldn\'t get the lock for 5 mins, timed out, exiting. %s" % traceback.format_stack())

or put in simpler terms, whilst sending an event(), an unrelated warning
message happens to be triggered from asyncio:

/usr/lib/python3.10/asyncio/sslproto.py:320: ResourceWarning: unclosed transport <asyncio.sslproto._SSLProtocolTransport object at 0x7f0e797d3100>

which triggers a second event() which can't be sent as we're already
in the critcal section and already hold the lock.

That warning is due to the version of asyncio used on Ubuntu 22.04 with
python 3.10 and that comined with timing issues explains why we don't
see it on other python versions or distros.

We can't handle the second event as the lock is there to serialise the
events. Instead, we queue the event and then process the queue later.

Add a new version of lock_timeout which allows us to handle the situation
more gracefully.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/event.py | 10 +++++++++-
 lib/bb/utils.py | 15 +++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index e9834d01c7..da07a1dd64 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -194,7 +194,12 @@ def fire_ui_handlers(event, d):
         ui_queue.append(event)
         return
 
-    with bb.utils.lock_timeout(_thread_lock):
+    with bb.utils.lock_timeout_nocheck(_thread_lock) as lock:
+        if not lock:
+            # If we can't get the lock, we may be recursively called, queue and return
+            ui_queue.append(event)
+            return
+
         errors = []
         for h in _ui_handlers:
             #print "Sending event %s" % event
@@ -213,6 +218,9 @@ def fire_ui_handlers(event, d):
         for h in errors:
             del _ui_handlers[h]
 
+    while ui_queue:
+        fire_ui_handlers(ui_queue.pop(), d)
+
 def fire(event, d):
     """Fire off an Event"""
 
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 3a4b29181e..5486f9599d 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1879,6 +1879,9 @@ def path_is_descendant(descendant, ancestor):
 # If we don't have a timeout of some kind and a process/thread exits badly (for example
 # OOM killed) and held a lock, we'd just hang in the lock futex forever. It is better
 # we exit at some point than hang. 5 minutes with no progress means we're probably deadlocked.
+# This function can still deadlock python since it can't signal the other threads to exit
+# (signals are handled in the main thread) and even os._exit() will wait on non-daemon threads
+# to exit.
 @contextmanager
 def lock_timeout(lock):
     try:
@@ -1891,3 +1894,15 @@ def lock_timeout(lock):
     finally:
         lock.release()
         signal.pthread_sigmask(signal.SIG_SETMASK, s)
+
+# A version of lock_timeout without the check that the lock was locked and a shorter timeout
+@contextmanager
+def lock_timeout_nocheck(lock):
+    try:
+        s = signal.pthread_sigmask(signal.SIG_BLOCK, signal.valid_signals())
+        l = lock.acquire(timeout=10)
+        yield l
+    finally:
+        if l:
+            lock.release()
+        signal.pthread_sigmask(signal.SIG_SETMASK, s)

