Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1S1ZuP-0000Jl-W9
	for bitbake-devel@lists.openembedded.org;
	Sun, 26 Feb 2012 09:56:46 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q1Q8mL5K010722
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 26 Feb 2012 00:48:21 -0800 (PST)
Received: from build-PowerEdge-T100.corp.ad.wrs.com (128.224.163.66) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.1.255.0; Sun, 26 Feb 2012 00:48:20 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 26 Feb 2012 16:48:15 +0800
Message-ID: <4dcfea9e72dfb22f3768bdd56bde1e2791b74845.1330245845.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1330245845.git.liezhi.yang@windriver.com>
References: <cover.1330245845.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 2/3] V5 Disk space monitoring
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
X-List-Received-Date: Sun, 26 Feb 2012 08:56:46 -0000
Content-Type: text/plain

Monitor disk availability and take action when the free disk space or
amount of free inode is running low, it is enabled when BB_DISKMON_DIRS
is set.

* Variable meanings(from meta-yocto/conf/local.conf.sample):

  # Set the directories to monitor for disk usage, if more than one
  # directories are mounted in the same device, then only one directory
  # would be monitored since the monitor is based on the device.
  # The format is:
  # "action,directory,minimum_space,minimum_free_inode"
  #
  # The "action" must be set and should be one of:
  # ABORT: Immediately abort
  # STOPTASKS: The new tasks can't be executed any more, will stop the build
  #           when the running tasks have been done.
  # WARN: show warnings (see BB_DISKMON_WARNINTERVAL for more information)
  #
  # The "directory" must be set, any directory is OK.
  #
  # Either "minimum_space" or "minimum_free_inode" (or both of them)
  # should be set, otherwise the monitor would not be enabled,
  # the unit can be G, M, K or none, but do NOT use GB, MB or KB
  # (B is not needed).
  #BB_DISKMON_DIRS = "STOPTASKS,${TMPDIR},1G,100K WARN,${SSTATE_DIR},1G,100K"
  #
  # Set disk space and inode interval (only works when the action is "WARN",
  # the unit can be G, M, or K, but do NOT use the GB, MB or KB
  # (B is not needed), the format is:
  # "disk_space_interval, disk_inode_interval",  the default value is
  # "50M,5K" which means that it would warn when the free space is
  # lower than the minimum space(or inode), and would repeat the action
  # when the disk space reduces 50M (or the amount of inode reduces 5k)
  # again.
  #BB_DISKMON_WARNINTERVAL = "50M,5K"

[YOCTO #1589]
Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/monitordisk.py |  237 +++++++++++++++++++++++++++++++++++++++++
 bitbake/lib/bb/runqueue.py    |    7 ++
 2 files changed, 244 insertions(+), 0 deletions(-)
 create mode 100644 bitbake/lib/bb/monitordisk.py

diff --git a/bitbake/lib/bb/monitordisk.py b/bitbake/lib/bb/monitordisk.py
new file mode 100644
index 0000000..04f090c
--- /dev/null
+++ b/bitbake/lib/bb/monitordisk.py
@@ -0,0 +1,237 @@
+#!/usr/bin/env python
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+#
+# Copyright (C) 2012 Robert Yang
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+import os, logging, re, sys
+import bb
+logger = logging.getLogger("BitBake.Monitor")
+
+def printErr(info):
+    logger.error("%s\n       Disk space monitor will NOT be enabled" % info)
+
+def convertGMK(unit):
+
+    """ Convert the space unit G, M, K, the unit is case-insensitive """
+
+    unitG = re.match('([1-9][0-9]*)[gG]\s?$', unit)
+    if unitG:
+        return int(unitG.group(1)) * (1024 ** 3)
+    unitM = re.match('([1-9][0-9]*)[mM]\s?$', unit)
+    if unitM:
+        return int(unitM.group(1)) * (1024 ** 2)
+    unitK = re.match('([1-9][0-9]*)[kK]\s?$', unit)
+    if unitK:
+        return int(unitK.group(1)) * 1024
+    unitN = re.match('([1-9][0-9]*)\s?$', unit)
+    if unitN:
+        return int(unitN.group(1))
+    else:
+        return None
+
+def getMountedDev(path):
+
+    """ Get the device mounted at the path, uses /proc/mounts """
+
+    # Get the mount point of the filesystem containing path
+    # st_dev is the ID of device containing file
+    parentDev = os.stat(path).st_dev
+    currentDev = parentDev
+    # When the current directory's device is different from the
+    # parrent's, then the current directory is a mount point
+    while parentDev == currentDev:
+        mountPoint = path
+        # Use dirname to get the parrent's directory
+        path = os.path.dirname(path)
+        # Reach the "/"
+        if path == mountPoint:
+            break
+        parentDev= os.stat(path).st_dev
+
+    try:
+        with open("/proc/mounts", "r") as ifp:
+            for line in ifp:
+                procLines = line.rstrip('\n').split()
+                if procLines[1] == mountPoint:
+                    return procLines[0]
+    except EnvironmentError:
+        pass
+    return None
+
+def getDiskData(BBDirs, configuration):
+
+    """Prepare disk data for disk space monitor"""
+
+    # Save the device IDs, need the ID to be unique (the dictionary's key is
+    # unique), so that when more than one directories are located in the same
+    # device, we just monitor it once
+    devDict = {}
+    for pathSpaceInode in BBDirs.split():
+        # The input format is: "dir,space,inode", dir is a must, space
+        # and inode are optional
+        pathSpaceInodeRe = re.match('([^,]*),([^,]*),([^,]*),?(.*)', pathSpaceInode)
+        if not pathSpaceInodeRe:
+            printErr("Invalid value in BB_DISKMON_DIRS: %s" % pathSpaceInode)
+            return None
+
+        action = pathSpaceInodeRe.group(1)
+        if action not in ("ABORT", "STOPTASKS", "WARN"):
+            printErr("Unknown disk space monitor action: %s" % action)
+            return None
+
+        path = os.path.realpath(pathSpaceInodeRe.group(2))
+        if not path:
+            printErr("Invalid path value in BB_DISKMON_DIRS: %s" % pathSpaceInode)
+            return None
+
+        # The disk space or inode is optional, but it should have a correct
+        # value once it is specified
+        minSpace = pathSpaceInodeRe.group(3)
+        if minSpace:
+            minSpace = convertGMK(minSpace)
+            if not minSpace:
+                printErr("Invalid disk space value in BB_DISKMON_DIRS: %s" % pathSpaceInodeRe.group(3))
+                return None
+        else:
+            # 0 means that it is not specified
+            minSpace = None
+
+        minInode = pathSpaceInodeRe.group(4)
+        if minInode:
+            minInode = convertGMK(minInode)
+            if not minInode:
+                printErr("Invalid inode value in BB_DISKMON_DIRS: %s" % pathSpaceInodeRe.group(4))
+                return None
+        else:
+            # 0 means that it is not specified
+            minInode = None
+
+        if minSpace is None and minInode is None:
+            printErr("No disk space or inode value in found BB_DISKMON_DIRS: %s" % pathSpaceInode)
+            return None
+        # mkdir for the directory since it may not exist, for example the
+        # DL_DIR may not exist at the very beginning
+        if not os.path.exists(path):
+            bb.utils.mkdirhier(path)
+        mountedDev = getMountedDev(path)
+        devDict[mountedDev] = action, path, minSpace, minInode
+
+    return devDict
+
+def getInterval(configuration):
+
+    """ Get the disk space interval """
+
+    interval = configuration.getVar("BB_DISKMON_WARNINTERVAL", 1)
+    if not interval:
+        # The default value is 50M and 5K.
+        return 50 * 1024 * 1024, 5 * 1024
+    else:
+        # The disk space or inode interval is optional, but it should
+        # have a correct value once it is specified
+        intervalRe = re.match('([^,]*),?\s*(.*)', interval)
+        if intervalRe:
+            intervalSpace = intervalRe.group(1)
+            if intervalSpace:
+                intervalSpace = convertGMK(intervalSpace)
+                if not intervalSpace:
+                    printErr("Invalid disk space interval value in BB_DISKMON_WARNINTERVAL: %s" % intervalRe.group(1))
+                    return None, None
+            intervalInode = intervalRe.group(2)
+            if intervalInode:
+                intervalInode = convertGMK(intervalInode)
+                if not intervalInode:
+                    printErr("Invalid disk inode interval value in BB_DISKMON_WARNINTERVAL: %s" % intervalRe.group(2))
+                    return None, None
+            return intervalSpace, intervalInode
+        else:
+            printErr("Invalid interval value in BB_DISKMON_WARNINTERVAL: %s" % interval)
+            return None, None
+
+class diskMonitor:
+
+    """Prepare the disk space monitor data"""
+
+    def __init__(self, configuration):
+
+        self.enableMonitor = False
+
+        BBDirs = configuration.getVar("BB_DISKMON_DIRS", 1) or None
+        if BBDirs:
+            self.devDict = getDiskData(BBDirs, configuration)
+            if self.devDict:
+                self.spaceInterval, self.inodeInterval = getInterval(configuration)
+                if self.spaceInterval and self.inodeInterval:
+                    self.enableMonitor = True
+                    # These are for saving the previous disk free space and inode, we
+                    # use them to avoid print too many warning messages
+                    self.preFreeS = {}
+                    self.preFreeI = {}
+                    # This is for STOPTASKS and ABORT, to avoid print the message repeatly
+                    # during waiting the tasks to finish
+                    self.checked = {}
+                    for dev in self.devDict:
+                        self.preFreeS[dev] = 0
+                        self.preFreeI[dev] = 0
+                        self.checked[dev] = False
+                    if self.spaceInterval is None and self.inodeInterval is None:
+                        self.enableMonitor = False
+
+    def check(self, rq):
+
+        """ Take action for the monitor """
+
+        if self.enableMonitor:
+            for dev in self.devDict:
+                st = os.statvfs(self.devDict[dev][1])
+
+                # The free space, float point number
+                freeSpace = st.f_bavail * st.f_frsize
+
+                if self.devDict[dev][2] and freeSpace < self.devDict[dev][2]:
+                    # Always show warning, the self.checked would always be False if the action is WARN
+                    if self.preFreeS[dev] == 0 or self.preFreeS[dev] - freeSpace > self.spaceInterval and not self.checked[dev]:
+                        logger.warn("The free space of %s is running low (%.3fGB left)" % (dev, freeSpace / 1024 / 1024 / 1024.0))
+                        self.preFreeS[dev] = freeSpace
+
+                    if self.devDict[dev][0] == "STOPTASKS" and not self.checked[dev]:
+                        logger.error("No new tasks can be excuted since the disk space monitor action is \"STOPTASKS\"!")
+                        self.checked[dev] = True
+                        rq.finish_runqueue(False)
+                    elif self.devDict[dev][0] == "ABORT" and not self.checked[dev]:
+                        logger.error("Immediately abort since the disk space monitor action is \"ABORT\"!")
+                        self.checked[dev] = True
+                        rq.finish_runqueue(True)
+
+                # The free inodes, float point number
+                freeInode = st.f_favail
+
+                if self.devDict[dev][3] and freeInode < self.devDict[dev][3]:
+                    # Always show warning, the self.checked would always be False if the action is WARN
+                    if self.preFreeI[dev] == 0 or self.preFreeI[dev] - freeInode > self.inodeInterval and not self.checked[dev]:
+                        logger.warn("The free inode of %s is running low (%.3fK left)" % (dev, freeInode / 1024.0))
+                        self.preFreeI[dev] = freeInode
+
+                    if self.devDict[dev][0]  == "STOPTASKS" and not self.checked[dev]:
+                        logger.error("No new tasks can be excuted since the disk space monitor action is \"STOPTASKS\"!")
+                        self.checked[dev] = True
+                        rq.finish_runqueue(False)
+                    elif self.devDict[dev][0]  == "ABORT" and not self.checked[dev]:
+                        logger.error("Immediately abort since the disk space monitor action is \"ABORT\"!")
+                        self.checked[dev] = True
+                        rq.finish_runqueue(True)
+        return
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 1c3187d..f08f93a 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -31,6 +31,7 @@ import fcntl
 import logging
 import bb
 from bb import msg, data, event
+from bb import monitordisk
 
 bblogger = logging.getLogger("BitBake")
 logger = logging.getLogger("BitBake.RunQueue")
@@ -775,6 +776,9 @@ class RunQueue:
 
         self.state = runQueuePrepare
 
+        # For disk space monitor
+        self.dm = monitordisk.diskMonitor(cfgData)
+
     def check_stamps(self):
         unchecked = {}
         current = []
@@ -949,6 +953,9 @@ class RunQueue:
             else:
                 self.rqexe = RunQueueExecuteScenequeue(self)
 
+        if self.state in [runQueueSceneRun, runQueueRunning, runQueueCleanUp]:
+            self.dm.check(self)
+
         if self.state is runQueueSceneRun:
             retval = self.rqexe.execute()
 
-- 
1.7.4.1



