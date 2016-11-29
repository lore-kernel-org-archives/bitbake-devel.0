Return-Path: <patrick.ohly@intel.com>
Received: from mail-io0-f171.google.com (mail-io0-f171.google.com
	[209.85.223.171])
	by mail.openembedded.org (Postfix) with ESMTP id EFD1B719F2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Nov 2016 16:48:06 +0000 (UTC)
Received: by mail-io0-f171.google.com with SMTP id j65so299683463iof.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Nov 2016 08:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=s7vAYDHJQjMzqBTnMXKUzfkuekff6dm7OwW84AG8JQ8=;
	b=z1fJZQDwHfMuRYC2NQqsWK4fdQC0ozPp+haj+B/0gOFrczU5CCVSWfgkH1oMrt39CC
	AuGFmiliH5cHhg5Ymk0Il/ZTFHlZ7XtO5uBXLtoZHCXWHF+4Qt1y4ie1w5CWKAJjYOZR
	vf3UbTNi2fPlaWNKMCQIlRkjtv7nGscCRylXksQZJa2Mb9D9USd+FWlmZERJNmekU5H9
	GDNyJ2D8ErhjTMT/5uSP9N1zt54OqfJqM/aUNjzH4sc76d54KHp3e9CUQLVSVx5LDFPD
	8keat8tQdw6hM7r6efAz3wOdgrpqwmePYl5nhBGaTuLmr/rzIIj/guQMq5ikg8UjGI/G
	ZW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=s7vAYDHJQjMzqBTnMXKUzfkuekff6dm7OwW84AG8JQ8=;
	b=In7tF4urMIcHp6VvhjcydAbMKZzNPvf5MwUer4O+hVs2u0qRdTTrDGzjStYLVvo0nY
	D5ZdSc+Lf6Z3R4cWi2n11r3cULPe4zOVTyyaHIs0AbKuei/Y54f9TIcY1sWVZ6ZTMlbI
	eNZsVsmBxdQKJbSMPEEHVhYeKVCCo/ZzCcoPCeDVXTEL/hqsHE5jW8eLzscCpvWlrtvb
	+jLvPlFf7ch0UGcilYASLkAqgmJlyiOhlVdO102mkgPng3GcA9Zqgp87EFs8ohR3Eo+D
	niVvdECJMRQg6h3a7+xrXI8dYWhKI71W8MQqB/O7PEdBLULPOzxSzicTEOpgHUs4W1vl
	1Rag==
X-Gm-Message-State: AKaTC02eJu2RbMM07ltIFBPCsblmyHrNMLdSElCMyShg2XGGaJ0FNnmnQ/kA7JFxUjnknNi2
X-Received: by 10.107.145.69 with SMTP id t66mr24404112iod.203.1480438087681; 
	Tue, 29 Nov 2016 08:48:07 -0800 (PST)
Received: from pohly-desktop.fritz.box (p5DE8EEDB.dip0.t-ipconnect.de.
	[93.232.238.219])
	by smtp.gmail.com with ESMTPSA id l79sm1119425itb.1.2016.11.29.08.48.06
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 29 Nov 2016 08:48:06 -0800 (PST)
From: Patrick Ohly <patrick.ohly@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 29 Nov 2016 17:47:42 +0100
Message-Id: <90660fc75cc3fedceabef02ac2ade99d7c26fbb2.1480437099.git.patrick.ohly@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1480437099.git.patrick.ohly@intel.com>
References: <cover.1480437099.git.patrick.ohly@intel.com>
Subject: [PATCH V2 1/4] cooker process: fire heartbeat event at regular time intervals
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
X-List-Received-Date: Tue, 29 Nov 2016 16:48:08 -0000

The intended usage is for recording current system statistics from
/proc in buildstats.bbclass during a build and for improving the
BB_DISKMON_DIRS implementation.

All other existing hooks are less suitable because they trigger at
unpredictable rates: too often can be handled by doing rate-limiting
in the event handler, but not often enough (for example, when there is
only one long-running task) cannot because the handler does not get
called at all.

The implementation of the new heartbeat event hooks into the cooker
process event queue. The process already wakes up every 0.1s, which is
often enough for the intentionally coarse 1s delay between
heartbeats. That value was chosen to keep the overhead low while still
being frequent enough for the intended usage.

If necessary, BB_HEARTBEAT_EVENT can be set to a float specifying
the delay in seconds between these heartbeat events.

Signed-off-by: Patrick Ohly <patrick.ohly@intel.com>
---
 lib/bb/event.py          | 10 ++++++++++
 lib/bb/server/process.py | 25 +++++++++++++++++++++++++
 lib/bb/ui/knotty.py      |  1 +
 lib/bb/ui/toasterui.py   |  3 +++
 4 files changed, 39 insertions(+)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index 6f1cb10..cacbac8 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -48,6 +48,16 @@ class Event(object):
     def __init__(self):
         self.pid = worker_pid
 
+
+class HeartbeatEvent(Event):
+    """Triggered at regular time intervals of 10 seconds. Other events can fire much more often
+       (runQueueTaskStarted when there are many short tasks) or not at all for long periods
+       of time (again runQueueTaskStarted, when there is just one long-running task), so this
+       event is more suitable for doing some task-independent work occassionally."""
+    def __init__(self, time):
+        Event.__init__(self)
+        self.time = time
+
 Registered        = 10
 AlreadyRegistered = 14
 
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 982fcf7..1654faf 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -92,6 +92,8 @@ class ProcessServer(Process, BaseImplServer):
         self.event = EventAdapter(event_queue)
         self.featurelist = featurelist
         self.quit = False
+        self.heartbeat_seconds = 1 # default, BB_HEARTBEAT_EVENT will be checked once we have a datastore.
+        self.next_heartbeat = time.time()
 
         self.quitin, self.quitout = Pipe()
         self.event_handle = multiprocessing.Value("i")
@@ -101,6 +103,14 @@ class ProcessServer(Process, BaseImplServer):
             self.event_queue.put(event)
         self.event_handle.value = bb.event.register_UIHhandler(self, True)
 
+        heartbeat_event = self.cooker.data.getVar('BB_HEARTBEAT_EVENT', True)
+        if heartbeat_event:
+            try:
+                self.heartbeat_seconds = float(heartbeat_event)
+            except:
+                # Throwing an exception here causes bitbake to hang.
+                # Just warn about the invalid setting and continue
+                bb.warn('Ignoring invalid BB_HEARTBEAT_EVENT=%s, must be a float specifying seconds.' % heartbeat_event)
         bb.cooker.server_main(self.cooker, self.main)
 
     def main(self):
@@ -160,6 +170,21 @@ class ProcessServer(Process, BaseImplServer):
                 del self._idlefuns[function]
                 self.quit = True
 
+        # Create new heartbeat event?
+        now = time.time()
+        if now >= self.next_heartbeat:
+            # We might have missed heartbeats. Just trigger once in
+            # that case and continue after the usual delay.
+            self.next_heartbeat += self.heartbeat_seconds
+            if self.next_heartbeat <= now:
+                self.next_heartbeat = now + self.heartbeat_seconds
+            heartbeat = bb.event.HeartbeatEvent(now)
+            bb.event.fire(heartbeat, self.cooker.data)
+        if nextsleep and now + nextsleep > self.next_heartbeat:
+            # Shorten timeout so that we we wake up in time for
+            # the heartbeat.
+            nextsleep = self.next_heartbeat - now
+
         if nextsleep is not None:
             select.select(fds,[],[],nextsleep)
 
diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 948f527..48e1223 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -647,6 +647,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                                   bb.event.OperationCompleted,
                                   bb.event.OperationProgress,
                                   bb.event.DiskFull,
+                                  bb.event.HeartbeatEvent,
                                   bb.build.TaskProgress)):
                 continue
 
diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index b1b3684..1729902 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -236,6 +236,9 @@ def main(server, eventHandler, params):
             # pylint: disable=protected-access
             # the code will look into the protected variables of the event; no easy way around this
 
+            if isinstance(event, bb.event.HeartbeatEvent):
+                continue
+
             if isinstance(event, bb.event.ParseStarted):
                 if not (build_log and build_log_file_path):
                     build_log, build_log_file_path = _open_build_log(log_dir)
-- 
2.1.4


