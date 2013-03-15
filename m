Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1UGPmv-0001OL-Bs
	for bitbake-devel@lists.openembedded.org;
	Fri, 15 Mar 2013 09:15:03 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id r2F7w8BL008628
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Mar 2013 00:58:08 -0700 (PDT)
Received: from pek-usp-9.wrs.com (128.224.162.26) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.2.342.3;
	Fri, 15 Mar 2013 00:58:09 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 15 Mar 2013 15:42:48 +0800
Message-ID: <3155e730627817a772d95ddab04372ff13c33b82.1363313983.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.7
In-Reply-To: <cover.1363313983.git.liezhi.yang@windriver.com>
References: <cover.1363313983.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Cc: qingtao.cao@windriver.com
Subject: [PATCH 1/1] monitordisk.py: monitor disks based on path
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
X-List-Received-Date: Fri, 15 Mar 2013 08:15:10 -0000
Content-Type: text/plain

The previous monitor is based on the disk, and one disk only can have
one action, this limits its function, for example we set this in the
current local.conf:

BB_DISKMON_DIRS = "\
    STOPTASKS,${TMPDIR},1G,100K \
    STOPTASKS,${DL_DIR},1G,100K \
    STOPTASKS,${SSTATE_DIR},1G,100K \
    ABORT,${TMPDIR},100M,1K \
    ABORT,${DL_DIR},100M,1K \
    ABORT,${SSTATE_DIR},100GM,1K"

Before:
  * If TMPDIR, DL_DIR and SSTATE_DIR are on the same disk partition,
    only the last line "ABORT,${SSTATE_DIR},100GM,1K" works

  * If TMPDIR, DL_DIR and SSTATE_DIR are on the different disk partitions,
    only the last three lines (ABORT) work.

These are not what we expect, now:
  * We monitor the disk based on the path and action, so all the six lines
    will work no matter whether they are on the same disk partition or
    not.

  * The out put format will be:
    WARNING: The free space of /path/to/directory (device) is running low (XXGB left)

[YOCTO #3995]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/monitordisk.py |   73 +++++++++++++++++++++++------------------
 1 files changed, 41 insertions(+), 32 deletions(-)

diff --git a/bitbake/lib/bb/monitordisk.py b/bitbake/lib/bb/monitordisk.py
index 1c1e614..a71dd9f 100644
--- a/bitbake/lib/bb/monitordisk.py
+++ b/bitbake/lib/bb/monitordisk.py
@@ -107,7 +107,7 @@ def getDiskData(BBDirs, configuration):
                 printErr("Invalid disk space value in BB_DISKMON_DIRS: %s" % pathSpaceInodeRe.group(3))
                 return None
         else:
-            # 0 means that it is not specified
+            # None means that it is not specified
             minSpace = None
 
         minInode = pathSpaceInodeRe.group(4)
@@ -117,7 +117,7 @@ def getDiskData(BBDirs, configuration):
                 printErr("Invalid inode value in BB_DISKMON_DIRS: %s" % pathSpaceInodeRe.group(4))
                 return None
         else:
-            # 0 means that it is not specified
+            # None means that it is not specified
             minInode = None
 
         if minSpace is None and minInode is None:
@@ -127,8 +127,9 @@ def getDiskData(BBDirs, configuration):
         # DL_DIR may not exist at the very beginning
         if not os.path.exists(path):
             bb.utils.mkdirhier(path)
-        mountedDev = getMountedDev(path)
-        devDict[mountedDev] = [action, path, minSpace, minInode]
+        dev = getMountedDev(path)
+        # Use path/action as the key
+        devDict[os.path.join(path, action)] = [dev, minSpace, minInode]
 
     return devDict
 
@@ -192,10 +193,10 @@ class diskMonitor:
                     # This is for STOPTASKS and ABORT, to avoid print the message repeatly
                     # during waiting the tasks to finish
                     self.checked = {}
-                    for dev in self.devDict:
-                        self.preFreeS[dev] = 0
-                        self.preFreeI[dev] = 0
-                        self.checked[dev] = False
+                    for k in self.devDict:
+                        self.preFreeS[k] = 0
+                        self.preFreeI[k] = 0
+                        self.checked[k] = False
                     if self.spaceInterval is None and self.inodeInterval is None:
                         self.enableMonitor = False
 
@@ -204,53 +205,61 @@ class diskMonitor:
         """ Take action for the monitor """
 
         if self.enableMonitor:
-            for dev in self.devDict:
-                st = os.statvfs(self.devDict[dev][1])
+            for k in self.devDict:
+                path = os.path.dirname(k)
+                action = os.path.basename(k)
+                dev = self.devDict[k][0]
+                minSpace = self.devDict[k][1]
+                minInode = self.devDict[k][2]
+
+                st = os.statvfs(path)
 
                 # The free space, float point number
                 freeSpace = st.f_bavail * st.f_frsize
 
-                if self.devDict[dev][2] and freeSpace < self.devDict[dev][2]:
+                if minSpace and freeSpace < minSpace:
                     # Always show warning, the self.checked would always be False if the action is WARN
-                    if self.preFreeS[dev] == 0 or self.preFreeS[dev] - freeSpace > self.spaceInterval and not self.checked[dev]:
-                        logger.warn("The free space of %s is running low (%.3fGB left)" % (dev, freeSpace / 1024 / 1024 / 1024.0))
-                        self.preFreeS[dev] = freeSpace
+                    if self.preFreeS[k] == 0 or self.preFreeS[k] - freeSpace > self.spaceInterval and not self.checked[k]:
+                        logger.warn("The free space of %s (%s) is running low (%.3fGB left)" % \
+                                (path, dev, freeSpace / 1024 / 1024 / 1024.0))
+                        self.preFreeS[k] = freeSpace
 
-                    if self.devDict[dev][0] == "STOPTASKS" and not self.checked[dev]:
+                    if action == "STOPTASKS" and not self.checked[k]:
                         logger.error("No new tasks can be excuted since the disk space monitor action is \"STOPTASKS\"!")
-                        self.checked[dev] = True
+                        self.checked[k] = True
                         rq.finish_runqueue(False)
-                        bb.event.fire(bb.event.DiskFull(dev, 'disk', freeSpace, self.devDict[dev][1]), self.configuration)
-                    elif self.devDict[dev][0] == "ABORT" and not self.checked[dev]:
+                        bb.event.fire(bb.event.DiskFull(dev, 'disk', freeSpace, path), self.configuration)
+                    elif action == "ABORT" and not self.checked[k]:
                         logger.error("Immediately abort since the disk space monitor action is \"ABORT\"!")
-                        self.checked[dev] = True
+                        self.checked[k] = True
                         rq.finish_runqueue(True)
-                        bb.event.fire(bb.event.DiskFull(dev, 'disk', freeSpace, self.devDict[dev][1]), self.configuration)
+                        bb.event.fire(bb.event.DiskFull(dev, 'disk', freeSpace, path), self.configuration)
 
                 # The free inodes, float point number
                 freeInode = st.f_favail
 
-                if self.devDict[dev][3] and freeInode < self.devDict[dev][3]:
+                if minInode and freeInode < minInode:
                     # Some fs formats' (e.g., btrfs) statvfs.f_files (inodes) is
                     # zero, this is a feature of the fs, we disable the inode
                     # checking for such a fs.
                     if st.f_files == 0:
-                        logger.warn("Inode check for %s is unavaliable, remove it from disk monitor" % dev)
-                        self.devDict[dev][3] = None
+                        logger.warn("Inode check for %s is unavaliable, will remove it from disk monitor" % path)
+                        minInode = None
                         continue
                     # Always show warning, the self.checked would always be False if the action is WARN
-                    if self.preFreeI[dev] == 0 or self.preFreeI[dev] - freeInode > self.inodeInterval and not self.checked[dev]:
-                        logger.warn("The free inode of %s is running low (%.3fK left)" % (dev, freeInode / 1024.0))
-                        self.preFreeI[dev] = freeInode
+                    if self.preFreeI[k] == 0 or self.preFreeI[k] - freeInode > self.inodeInterval and not self.checked[k]:
+                        logger.warn("The free inode of %s (%s) is running low (%.3fK left)" % \
+                                (path, dev, freeInode / 1024.0))
+                        self.preFreeI[k] = freeInode
 
-                    if self.devDict[dev][0]  == "STOPTASKS" and not self.checked[dev]:
+                    if action  == "STOPTASKS" and not self.checked[k]:
                         logger.error("No new tasks can be excuted since the disk space monitor action is \"STOPTASKS\"!")
-                        self.checked[dev] = True
+                        self.checked[k] = True
                         rq.finish_runqueue(False)
-                        bb.event.fire(bb.event.DiskFull(dev, 'inode', freeSpace, self.devDict[dev][1]), self.configuration)
-                    elif self.devDict[dev][0]  == "ABORT" and not self.checked[dev]:
+                        bb.event.fire(bb.event.DiskFull(dev, 'inode', freeInode, path), self.configuration)
+                    elif action  == "ABORT" and not self.checked[k]:
                         logger.error("Immediately abort since the disk space monitor action is \"ABORT\"!")
-                        self.checked[dev] = True
+                        self.checked[k] = True
                         rq.finish_runqueue(True)
-                        bb.event.fire(bb.event.DiskFull(dev, 'inode', freeSpace, self.devDict[dev][1]), self.configuration)
+                        bb.event.fire(bb.event.DiskFull(dev, 'inode', freeInode, path), self.configuration)
         return
-- 
1.7.7



