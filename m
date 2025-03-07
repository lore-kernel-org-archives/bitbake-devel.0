Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F30C28B25
	for <webhook@archiver.kernel.org>; Fri,  7 Mar 2025 13:55:09 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web10.11471.1741355706824741783
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Mar 2025 05:55:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=2nRS/+eu;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.52, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ff797f8f1bso1926837a91.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 07 Mar 2025 05:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1741355706; x=1741960506; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GHg/XudC2kuB2xyXmHx8aKBZitT91K0qL8GvAR/4uFE=;
        b=2nRS/+euMSwphTSjWFE2x2RXHNJ6M7rT6alzNSUQIh8fIQuitgS/mr/aNacVCaazjt
         RoPFPeemV1PpEIqeMtbAXtVgZI0easPpghtYDe4IHN6umGOo0r2UdBCp1RZmPrJGoRm6
         uAjPoa3xC9U9gw2ScviEEdWNtKiWAVsv8VXX3KiSLKiXBHHYE8jiHeA9Zkb+oE/uq6Cc
         mUxEdnYGDezHP16r9q2Dp6mtweYCPsxm4/xBFyePGjV4L55XRvCU3riuArBgNxzcWFA+
         PPPL1kquFuCPw7reybiakGtJm/uPA50u81Oj90PIjqxOsNWyhDGQMTsvZ19I0+eMQh2q
         owfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741355706; x=1741960506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GHg/XudC2kuB2xyXmHx8aKBZitT91K0qL8GvAR/4uFE=;
        b=Eu02odmBn5hm4cI7sG1QbSAXEPrm0nRqJ9iAH2lQmI+DH/SWA5DVPahFU84CnFgbFQ
         09MK3XmUxt0XbzpEjyiTDLJnnuCqHm/OEGlGuO3wpjPi2NTdXIfuBvb6NuWklWcjY6tc
         FXpKnVZSxDy5IG9QtODK1/3T/lEUO4jQY+/oPu5PCotzB5uk94VFuw1N11E1RW+Z956c
         fzAQfsLZZbTL3L6sq++/3JfFJTj+zKAltd4OHoa1iFJdtnO78hItvSkyVdg3KQ5IwqBe
         Ft/j/gSRNYHDCfuKe6K3LS+V4Uwmqn94JdBx3DB6KWutQpSA4Hoz7rJJFzjod5WmJz95
         6GBw==
X-Gm-Message-State: AOJu0Yy1TnDwc79qb2O2QfpCHQTZdQOv8HwY3zDvzZlzooFNdf0KSWPp
	JihaJgHKvADaWGKIhrcuqqUb/f/yUmMoocuSFKcnS52HAx8LNg2tlXovTR+UzypR1evUCmGqpW5
	6
X-Gm-Gg: ASbGnctbLra0FqA2dPvnC3ROmh0inCg3LrZsPCN434+LGI6dcYdXm0SkJ+QBh9Okk4W
	CygHfJN1sIzd3ru2YVlk4YptHMutywPSAxgZjHmkTE2kjqhDC3N2PpBeTXNEalyMZffahoaef+h
	S7CB9Xn4WcZHCAaewQv/Gh8KLj+bjy36rHJxLQ6Yh1WJgLP5L66KciJlkPkaHI+f+1TbLBrTctC
	RPfkBS3N4OLQFhRqJH3prEH3lCDL2wzG2Cz5L4tEDQJKHFvohy8euNeN9yF+pgJFtP9P5/23qlU
	y1DwHjmNjbyoWGNP/8+jy329Ycf4Ai2x+NcK
X-Google-Smtp-Source: AGHT+IEZyierXhk2stsDw4z43A+2BN0Ffzxv9jbMl1NovM0go4jHyinusd5M6/uRpIqB03zG07iGag==
X-Received: by 2002:a17:90b:2883:b0:2ff:6788:cc67 with SMTP id 98e67ed59e1d1-2ff7cf31b55mr4412708a91.34.1741355705884;
        Fri, 07 Mar 2025 05:55:05 -0800 (PST)
Received: from hexa.. ([2602:feb4:3b:2100:cfcd:40b4:f918:b895])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e75edc9sm5488032a91.10.2025.03.07.05.55.05
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 05:55:05 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][styhead][2.10][PATCH 4/4] event/utils: Avoid deadlock from lock_timeout() and recursive events
Date: Fri,  7 Mar 2025 05:54:54 -0800
Message-ID: <82b9f42126983579da03bdbb4e3ebf07346118a7.1741355508.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741355508.git.steve@sakoman.com>
References: <cover.1741355508.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Mar 2025 13:55:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17411

From: Richard Purdie <richard.purdie@linuxfoundation.org>

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
(cherry picked from commit 2c590ff1aff89d23b25ce808650f200013a1e6af)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/event.py | 10 +++++++++-
 lib/bb/utils.py | 15 +++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index 952c85c0b..a12adbc93 100644
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
index da026fe5b..67e22f438 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1857,6 +1857,9 @@ def path_is_descendant(descendant, ancestor):
 # If we don't have a timeout of some kind and a process/thread exits badly (for example
 # OOM killed) and held a lock, we'd just hang in the lock futex forever. It is better
 # we exit at some point than hang. 5 minutes with no progress means we're probably deadlocked.
+# This function can still deadlock python since it can't signal the other threads to exit
+# (signals are handled in the main thread) and even os._exit() will wait on non-daemon threads
+# to exit.
 @contextmanager
 def lock_timeout(lock):
     try:
@@ -1869,3 +1872,15 @@ def lock_timeout(lock):
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
-- 
2.43.0


