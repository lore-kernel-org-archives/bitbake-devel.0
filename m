Return-Path: <patrick.ohly@intel.com>
Received: from mail-io0-f174.google.com (mail-io0-f174.google.com
	[209.85.223.174])
	by mail.openembedded.org (Postfix) with ESMTP id A6AA3719E7
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Nov 2016 16:48:20 +0000 (UTC)
Received: by mail-io0-f174.google.com with SMTP id m5so161513816ioe.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Nov 2016 08:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=6W/c1vkdzIiEqHX1uUrfOLDZqrvox3LjTlUgo7oU1Is=;
	b=yj10X4mK1IL65gAWJyf0ChtgoghC84HglPz/3nCV7Qn1ZtSLGKh2yCppImA4ry8hae
	hX/7HW6TnaPbhZt0AVTo5h9USdv2yOhAIHRUtQfffnPej2ReKBV4pEHDgT8dd5p4wE41
	VxdmGj6WQ6r8WM+pq8svAj91VbVEDKPTxyhPSyumu4nCJBw5WkOlId7AJBbUqqoneoAA
	EC9P9yaB/4h9GVzAv5Ldt/xyl+e+KkfwgWSAf8WPh0mvknmfZs9r9cbDyHxM7QmO2dxV
	kzdwdXzx8fuad0tf1Ym7RkKKlWmHNTVjVgbGjpAL8Gcisz5axsFzDRjAou2FGUbWAkK/
	YeVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=6W/c1vkdzIiEqHX1uUrfOLDZqrvox3LjTlUgo7oU1Is=;
	b=a2njsKqXhh2Rx/98EkpE0ldSLoyj3m7DTPvIx2UmZqU/bIYx0pqOIILQ/F26vM1jBo
	dwu/Shf2uiIIK5g2lzvJHcud1HNrpgWLMinfjUhxaEhLRqD5/7SikzO5rxD9czAN/BXj
	mOqNwZ/vNXAQLO4tEPqxGH9ALoG+h22WHiwCCo4+SP1MAEKXPve28UChUAc96bIS+y8n
	ENi56KMvsm40gpXOSZYFLGA7IRN4jPCc34wcX8mzeE2CYAFOoxwB7PHNSrfpeIr/525R
	TTMkza5g8PzRGmaab+rCM77K0MMs3Nq1N4YfmcFLlJJOsIyF4I2dlLWwITvZy+KHVL6j
	scTw==
X-Gm-Message-State: AKaTC02slLulE+rqld0axaQvSVCaij1V7VtBxe3+6i4ccHk99BILK2Gp8fYnFK8LUwgx7GOI
X-Received: by 10.36.82.85 with SMTP id d82mr24533533itb.95.1480438100923;
	Tue, 29 Nov 2016 08:48:20 -0800 (PST)
Received: from pohly-desktop.fritz.box (p5DE8EEDB.dip0.t-ipconnect.de.
	[93.232.238.219])
	by smtp.gmail.com with ESMTPSA id l79sm1119425itb.1.2016.11.29.08.48.17
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 29 Nov 2016 08:48:20 -0800 (PST)
From: Patrick Ohly <patrick.ohly@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 29 Nov 2016 17:47:45 +0100
Message-Id: <497c4a50544d1d235bc2850a76067374d9cd07e8.1480437099.git.patrick.ohly@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1480437099.git.patrick.ohly@intel.com>
References: <cover.1480437099.git.patrick.ohly@intel.com>
Subject: [PATCH V2 4/4] monitordisk: add event
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
X-List-Received-Date: Tue, 29 Nov 2016 16:48:20 -0000

The current disk usage is interesting and may be worth logging over
time as part of the build statistics. Instead of re-implementing the
code and the configuration option (BB_DISKMON_DIRS), the information
gathered by monitordisk.py is made available to buildstats.bbclass via
a new event.

This has pros and cons:
- there is already a useful default configuration for "interesting" directories
- no code duplication
- on the other hand, users cannot configure recording separately from
  monitoring (probably not that important)

Signed-off-by: Patrick Ohly <patrick.ohly@intel.com>
---
 lib/bb/event.py       | 17 +++++++++++++++++
 lib/bb/monitordisk.py |  8 ++++++++
 2 files changed, 25 insertions(+)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index cacbac8..5491914 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -451,6 +451,23 @@ class DiskFull(Event):
         self._free = freespace
         self._mountpoint = mountpoint
 
+class DiskUsageSample:
+    def __init__(self, available_bytes, free_bytes, total_bytes):
+        # Number of bytes available to non-root processes.
+        self.available_bytes = available_bytes
+        # Number of bytes available to root processes.
+        self.free_bytes = free_bytes
+        # Total capacity of the volume.
+        self.total_bytes = total_bytes
+
+class MonitorDiskEvent(Event):
+    """If BB_DISKMON_DIRS is set, then this event gets triggered each time disk space is checked.
+       Provides information about devices that are getting monitored."""
+    def __init__(self, disk_usage):
+        Event.__init__(self)
+        # hash of device root path -> DiskUsageSample
+        self.disk_usage = disk_usage
+
 class NoProvider(Event):
     """No Provider for an Event"""
 
diff --git a/lib/bb/monitordisk.py b/lib/bb/monitordisk.py
index 0f9010a..f3e8193 100644
--- a/lib/bb/monitordisk.py
+++ b/lib/bb/monitordisk.py
@@ -205,6 +205,7 @@ class diskMonitor:
         """ Take action for the monitor """
 
         if self.enableMonitor:
+            diskUsage = {}
             for k, attributes in self.devDict.items():
                 path, action = k
                 dev, minSpace, minInode = attributes
@@ -214,6 +215,11 @@ class diskMonitor:
                 # The available free space, integer number
                 freeSpace = st.f_bavail * st.f_frsize
 
+                # Send all relevant information in the event.
+                freeSpaceRoot = st.f_bfree * st.f_frsize
+                totalSpace = st.f_blocks * st.f_frsize
+                diskUsage[dev] = bb.event.DiskUsageSample(freeSpace, freeSpaceRoot, totalSpace)
+
                 if minSpace and freeSpace < minSpace:
                     # Always show warning, the self.checked would always be False if the action is WARN
                     if self.preFreeS[k] == 0 or self.preFreeS[k] - freeSpace > self.spaceInterval and not self.checked[k]:
@@ -257,4 +263,6 @@ class diskMonitor:
                         self.checked[k] = True
                         rq.finish_runqueue(True)
                         bb.event.fire(bb.event.DiskFull(dev, 'inode', freeInode, path), self.configuration)
+
+            bb.event.fire(bb.event.MonitorDiskEvent(diskUsage), self.configuration)
         return
-- 
2.1.4


