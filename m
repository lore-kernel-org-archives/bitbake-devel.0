Return-Path: <patrick.ohly@intel.com>
Received: from mail-io0-f181.google.com (mail-io0-f181.google.com
	[209.85.223.181])
	by mail.openembedded.org (Postfix) with ESMTP id CDDF371B17
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Nov 2016 15:15:19 +0000 (UTC)
Received: by mail-io0-f181.google.com with SMTP id m5so96715183ioe.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Nov 2016 07:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=s7vAYDHJQjMzqBTnMXKUzfkuekff6dm7OwW84AG8JQ8=;
	b=qE42GhYwJ7yc18FkA0xr8f4i+Wi7iVZHcfbNz+XQs7ZBxURluL1SapBCMznWSCC6vN
	1DdLDYu5lffJiHpRyHrAgukK8U3Z7UB0n/5SdMBu/Ux+g4Byf+gyDH+feE4J+XcCHpdP
	bzmz4UKYvcrUj/f7YNM3ru2LtOFKOGMyVrfkjdKK87wHRmn7m6Roa7DfKoGNAwRQH6A+
	Ok3hwxD/wGJmUMM+HBpRkncZcZCIGP/XPf1BFEb25SKGAh7Sua2WJt3DIcadR28McMyQ
	8QeytB6k+JXpCPz4zOu7tFIMOZcT7Uet0Dar2mTJQHSXGW3qFJ4/ZjWDG5VHRnE06iTy
	jiyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=s7vAYDHJQjMzqBTnMXKUzfkuekff6dm7OwW84AG8JQ8=;
	b=OP06VWZtC21WoyAn6JYpED6nRj+/6+m7hrGYZEqwzEvjwb6BChm5DoBUb/eJVxBCJD
	NF9tferTaDJNrdxrzvENHaUx18HmOYxm9V7Ii7RANjgU0jhgw00z2SgJ+Jr5hOwKmXWw
	ljehPmOUuiIZnElqwDHBLYtlPOn+Od92S0/vFrgd2mBS7UxHaIBne2oMYuz9k8ir0LBr
	WgGoBUFdFWUaWz+3iUQC9wOXVWkTdzFghICexc/8ImGjeQm0EGq6sGneh4Qx9lCOnDeq
	iSPgUZRYWKklbYLHgCbHzuftTprKSD7oCaRzI0+WiTI77RPRHPhTFg0dI01mVuF8sfty
	PODw==
X-Gm-Message-State: AKaTC02t40ZIhX9giodCHSXuWWwX0o69DJ4Xct2FCYOGV/zRq9CNDgzKNKBEQdqbSU/eMbcl
X-Received: by 10.36.228.194 with SMTP id o185mr18746617ith.112.1480346119891; 
	Mon, 28 Nov 2016 07:15:19 -0800 (PST)
Received: from pohly-desktop.fritz.box (p5DE8C83A.dip0.t-ipconnect.de.
	[93.232.200.58]) by smtp.gmail.com with ESMTPSA id
	i75sm9364092itf.10.2016.11.28.07.15.18
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 28 Nov 2016 07:15:18 -0800 (PST)
From: Patrick Ohly <patrick.ohly@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 28 Nov 2016 16:15:10 +0100
Message-Id: <90660fc75cc3fedceabef02ac2ade99d7c26fbb2.1480345719.git.patrick.ohly@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1480345719.git.patrick.ohly@intel.com>
References: <cover.1480345719.git.patrick.ohly@intel.com>
Subject: [PATCH 1/4] cooker process: fire heartbeat event at regular time intervals
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
X-List-Received-Date: Mon, 28 Nov 2016 15:15:20 -0000

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


