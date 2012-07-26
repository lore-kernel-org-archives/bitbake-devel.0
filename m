Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1SuKiS-0004LO-VJ
	for bitbake-devel@lists.openembedded.org;
	Thu, 26 Jul 2012 11:50:45 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q6Q9dCET026046
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 26 Jul 2012 02:39:12 -0700 (PDT)
Received: from localhost.localdomain (128.224.162.164) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.1.255.0; Thu, 26 Jul 2012 02:39:10 -0700
From: Kang Kai <kai.kang@windriver.com>
To: <richard.purdie@linuxfoundation.org>
Date: Thu, 26 Jul 2012 17:39:06 +0800
Message-ID: <69b3f0cb55fb28675248e000efc543caf0df608f.1343295453.git.kai.kang@windriver.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1343295453.git.kai.kang@windriver.com>
References: <cover.1343295453.git.kai.kang@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [128.224.162.164]
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: [PATCH 1/3] monitordisk: update check() to return a dict
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
X-List-Received-Date: Thu, 26 Jul 2012 09:50:45 -0000
Content-Type: text/plain

Update function check() to return a dict to provide information about
disk monitor. This could help UIs to show more detail information to end
user.

Signed-off-by: Kang Kai <kai.kang@windriver.com>
---
 bitbake/lib/bb/monitordisk.py |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/monitordisk.py b/bitbake/lib/bb/monitordisk.py
index 9469193..971a291 100644
--- a/bitbake/lib/bb/monitordisk.py
+++ b/bitbake/lib/bb/monitordisk.py
@@ -176,6 +176,7 @@ class diskMonitor:
     def __init__(self, configuration):
 
         self.enableMonitor = False
+        self.data = {'terminate': False}
 
         BBDirs = configuration.getVar("BB_DISKMON_DIRS", True) or None
         if BBDirs:
@@ -200,7 +201,11 @@ class diskMonitor:
 
     def check(self, rq):
 
-        """ Take action for the monitor """
+        """
+        Take action for the monitor.
+        Return True to tell cooker that runqueue is terminated by disk monitor.
+        This return value is useful for UIs such as Hob.
+        """
 
         if self.enableMonitor:
             for dev in self.devDict:
@@ -219,10 +224,14 @@ class diskMonitor:
                         logger.error("No new tasks can be excuted since the disk space monitor action is \"STOPTASKS\"!")
                         self.checked[dev] = True
                         rq.finish_runqueue(False)
+                        self.setData(dev, 'disk', freeSpace, self.devDict[dev][1])
+                        return self.data
                     elif self.devDict[dev][0] == "ABORT" and not self.checked[dev]:
                         logger.error("Immediately abort since the disk space monitor action is \"ABORT\"!")
                         self.checked[dev] = True
                         rq.finish_runqueue(True)
+                        self.setData(dev, 'disk', freeSpace, self.devDict[dev][1])
+                        return self.data
 
                 # The free inodes, float point number
                 freeInode = st.f_favail
@@ -237,8 +246,20 @@ class diskMonitor:
                         logger.error("No new tasks can be excuted since the disk space monitor action is \"STOPTASKS\"!")
                         self.checked[dev] = True
                         rq.finish_runqueue(False)
+                        self.setData(dev, 'inode', freeSpace, self.devDict[dev][1])
+                        return self.data
                     elif self.devDict[dev][0]  == "ABORT" and not self.checked[dev]:
                         logger.error("Immediately abort since the disk space monitor action is \"ABORT\"!")
                         self.checked[dev] = True
                         rq.finish_runqueue(True)
-        return
+                        self.setData(dev, 'inode', freeSpace, self.devDict[dev][1])
+                        return self.data
+        return self.data
+
+    def setData(self, dev, type, free, mountPoint):
+        """ Set the class member data """
+        self.data['terminated'] = True
+        self.data['dev'] = dev
+        self.data['type'] = type
+        self.data['freespace'] = free
+        self.data['mountpoint'] = mountPoint
-- 
1.7.5.4



