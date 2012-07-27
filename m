Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1SugEw-0007rY-Hw
	for bitbake-devel@lists.openembedded.org;
	Fri, 27 Jul 2012 10:49:42 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q6R8c8bs006850
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 27 Jul 2012 01:38:08 -0700 (PDT)
Received: from localhost.localdomain (128.224.162.164) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.1.255.0; Fri, 27 Jul 2012 01:38:08 -0700
From: Kang Kai <kai.kang@windriver.com>
To: <richard.purdie@linuxfoundation.org>
Date: Fri, 27 Jul 2012 16:38:02 +0800
Message-ID: <2ec1cda758940ef838a5d272a2418951658f50d2.1343378110.git.kai.kang@windriver.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1343378110.git.kai.kang@windriver.com>
References: <cover.1343378110.git.kai.kang@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [128.224.162.164]
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: [PATCH 1/2] monitordisk: fire event DISKFULL when terminate build
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 27 Jul 2012 08:49:43 -0000
Content-Type: text/plain

Part of [Yocto #2168]

Add a event DiskFull to descript the termination by disk monitor.

Update check() to fire the event DiskFull when terminates the build.
This could help UIs to deal this scenario and show more information to
end user.

Signed-off-by: Kang Kai <kai.kang@windriver.com>
---
 bitbake/lib/bb/event.py       |    8 ++++++++
 bitbake/lib/bb/monitordisk.py |    5 +++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index 1116c0a..20923b5 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -312,6 +312,14 @@ class BuildCompleted(BuildBase, OperationCompleted):
             OperationCompleted.__init__(self, total, "Building Failed")
         BuildBase.__init__(self, n, p, failures)
 
+class DiskFull(Event):
+    """Disk full case build aborted"""
+    def __init__(self, dev, type, freespace, mountpoint):
+        Event.__init__(self)
+        self._dev = dev
+        self._type = type
+        self._free = freespace
+        self._mountpoint = mountpoint
 
 class NoProvider(Event):
     """No Provider for an Event"""
diff --git a/bitbake/lib/bb/monitordisk.py b/bitbake/lib/bb/monitordisk.py
index 9469193..2bd4881 100644
--- a/bitbake/lib/bb/monitordisk.py
+++ b/bitbake/lib/bb/monitordisk.py
@@ -176,6 +176,7 @@ class diskMonitor:
     def __init__(self, configuration):
 
         self.enableMonitor = False
+        self.configuration = configuration
 
         BBDirs = configuration.getVar("BB_DISKMON_DIRS", True) or None
         if BBDirs:
@@ -219,10 +220,12 @@ class diskMonitor:
                         logger.error("No new tasks can be excuted since the disk space monitor action is \"STOPTASKS\"!")
                         self.checked[dev] = True
                         rq.finish_runqueue(False)
+                        bb.event.fire(bb.event.DiskFull(dev, 'disk', freeSpace, self.devDict[dev][1]), self.configuration)
                     elif self.devDict[dev][0] == "ABORT" and not self.checked[dev]:
                         logger.error("Immediately abort since the disk space monitor action is \"ABORT\"!")
                         self.checked[dev] = True
                         rq.finish_runqueue(True)
+                        bb.event.fire(bb.event.DiskFull(dev, 'disk', freeSpace, self.devDict[dev][1]), self.configuration)
 
                 # The free inodes, float point number
                 freeInode = st.f_favail
@@ -237,8 +240,10 @@ class diskMonitor:
                         logger.error("No new tasks can be excuted since the disk space monitor action is \"STOPTASKS\"!")
                         self.checked[dev] = True
                         rq.finish_runqueue(False)
+                        bb.event.fire(bb.event.DiskFull(dev, 'inode', freeSpace, self.devDict[dev][1]), self.configuration)
                     elif self.devDict[dev][0]  == "ABORT" and not self.checked[dev]:
                         logger.error("Immediately abort since the disk space monitor action is \"ABORT\"!")
                         self.checked[dev] = True
                         rq.finish_runqueue(True)
+                        bb.event.fire(bb.event.DiskFull(dev, 'inode', freeSpace, self.devDict[dev][1]), self.configuration)
         return
-- 
1.7.5.4



