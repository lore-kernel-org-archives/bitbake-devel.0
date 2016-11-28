Return-Path: <patrick.ohly@intel.com>
Received: from mail-io0-f172.google.com (mail-io0-f172.google.com
	[209.85.223.172])
	by mail.openembedded.org (Postfix) with ESMTP id 2BCA971A06
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Nov 2016 15:15:27 +0000 (UTC)
Received: by mail-io0-f172.google.com with SMTP id j65so235048709iof.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Nov 2016 07:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=6W/c1vkdzIiEqHX1uUrfOLDZqrvox3LjTlUgo7oU1Is=;
	b=C8RuUaAl9XqloU2mWdzzzVfBIyVfy0eMENqpQq/Wr2d0k/iLtzpoksci7tDD3OJEVq
	QsErCGfZkwU6EZlpUJN30q3bCqCSOSWAC4LHl09U2+qb6/GUtyjvO+KOdtKopddcIjO1
	0q+MZYIolBIp80JEGl/CZVvhB8+hySnCbT8n5mXSLnz9dqUwcP53L/HmfdqqzGJZ/N9S
	RR20wEjiXBkI4FduofBEO9hibV0OFWzVv5j3kwqr+TVSw65liX7n7Ufiwjfy33cLEWHY
	/TUP6cX8yVRqTbVIDOSNYDPtULdfjMLL1J22ht5n4L5QS5uaoz0vKWmt+7+xug6i3E1e
	SCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=6W/c1vkdzIiEqHX1uUrfOLDZqrvox3LjTlUgo7oU1Is=;
	b=XIZRv7xdELS4f9jcMsirKpj/biFGJ5jWlttgqbxgb969mnBZkSNwOSIWy9+QiWmvVD
	Sqo8jhEmOkBaRYLGaCyrw9ot+USfH0yidL6iaq0ng7nhx1RgVVLD3W5U9bFNk7Ilxhon
	2FBTrx8UAPTXERUfGV4DbJLRDEbmD1Rm5SvB6CemSxIttxYlosS+I7u9152aojwlC8lb
	J7u0aUo6RVEjrpc8ErnRiBPtRlJxFGFnm1zERi+u3tB2RUAkxi64ADRL+J1fwZVc44lg
	t8aFEqZ+f1dOouFUC/iz5Yqt/XYEVVIFNTPpgqKTLvslnZl6yfvX3T4fBLxhcDBW1ANw
	EheQ==
X-Gm-Message-State: AKaTC03UCWmDpEl8r43UPSG9osbGKtZUjV4iYiIvaE+/4GNpB4YXPE5SgSCPDrUadOm+mjBH
X-Received: by 10.107.7.27 with SMTP id 27mr16436271ioh.130.1480346128526;
	Mon, 28 Nov 2016 07:15:28 -0800 (PST)
Received: from pohly-desktop.fritz.box (p5DE8C83A.dip0.t-ipconnect.de.
	[93.232.200.58]) by smtp.gmail.com with ESMTPSA id
	i75sm9364092itf.10.2016.11.28.07.15.26
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 28 Nov 2016 07:15:27 -0800 (PST)
From: Patrick Ohly <patrick.ohly@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 28 Nov 2016 16:15:13 +0100
Message-Id: <a4c3aff7b86967c0fbf3b9b27fff7ccb342d85df.1480345719.git.patrick.ohly@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <90660fc75cc3fedceabef02ac2ade99d7c26fbb2.1480345719.git.patrick.ohly@intel.com>
References: <90660fc75cc3fedceabef02ac2ade99d7c26fbb2.1480345719.git.patrick.ohly@intel.com>
In-Reply-To: <cover.1480345719.git.patrick.ohly@intel.com>
References: <cover.1480345719.git.patrick.ohly@intel.com>
Subject: [PATCH 4/4] monitordisk: add event
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
X-List-Received-Date: Mon, 28 Nov 2016 15:15:27 -0000

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


