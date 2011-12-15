Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1Rb8v6-0001Cc-AX
	for bitbake-devel@lists.openembedded.org;
	Thu, 15 Dec 2011 11:52:12 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id pBFAjEvV002295
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Dec 2011 02:45:14 -0800 (PST)
Received: from build-PowerEdge-T100.corp.ad.wrs.com (128.224.163.66) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.1.255.0; Thu, 15 Dec 2011 02:45:13 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 15 Dec 2011 18:44:04 +0800
Message-ID: <26d4c3b28fc4d2e8ef4115f75859fb674f5789b4.1323944674.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1323944674.git.liezhi.yang@windriver.com>
References: <cover.1323944674.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/2] Disk space monitoring
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
X-List-Received-Date: Thu, 15 Dec 2011 10:52:12 -0000
Content-Type: text/plain

Monitor disk availability and warn the user when the free disk space or
amount of free inode is running low, it is enabled when BB_DISKMON_DIRS
is set.

* Variable meanings(from meta-yocto/conf/local.conf.sample):

  # Set the directories to monitor for disk usage, if more than one
  # directories are in the same device, then only one directory would be
  # warned since the monitor is based on the device.
  #
  BB_DISKMON_DIRS = "${TMPDIR} ${DL_DIR} ${SSTATE_DIR}"
  #
  # Set the minimum amount of disk space to warn, the unit can be G,
  # M or K, but do not use GB, MB or KB (B is not needed).
  # The default vaule is 1G if not set.
  #
  #BB_DISKMON_MINSPACE = "1G"
  #
  # Set the minimum amount of inodes to warn, the unit can be G, M or K.
  # The default value is 1K if not set.
  #
  #BB_DISKMON_MININODES = "1K"
  #
  # Set the monitor frequency, the unit can be h(hour), m(minute) or
  # s(second), when no unit is specified, the default unit is s(second),
  # for example, "60" means 60 seconds.
  # The default value is 60s if not set.
  #
  #BB_DISKMON_INTERVAL = "60s"

* Problems:

  1) The disk space monitor is running in a sub process of
     bin/bitbake, so it can't use the same logger as bitbake(or I don't
     know how to use it, I've tried to use the logger.warn('some
     information'), but it would print nothing in the subprocess),
     another solution maybe use an independent logger in the subprocess,
     but it seems that it doesn't worth because of the two reasons:
     a) The logger of bin/bitbake can't control the monitor's
        independent logger
     b) The monitor doesn't need print many things

     It would be great if anyone could give me more instructions.

 2) The code is placed in the new file lib/bb/monitordisk.py, since it
    seems that it is more independent.

[YOCTO #1589]
Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/bin/bitbake           |   12 +++
 bitbake/lib/bb/monitordisk.py |  153 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 165 insertions(+), 0 deletions(-)
 create mode 100644 bitbake/lib/bb/monitordisk.py

diff --git a/bitbake/bin/bitbake b/bitbake/bin/bitbake
index 9eb558b..5761376 100755
--- a/bitbake/bin/bitbake
+++ b/bitbake/bin/bitbake
@@ -39,6 +39,8 @@ import bb.msg
 from bb import cooker
 from bb import ui
 from bb import server
+from bb import monitordisk
+from multiprocessing import Process
 
 __version__ = "1.15.0"
 logger = logging.getLogger("BitBake")
@@ -217,6 +219,13 @@ Default BBFILES are the .bb files in the current directory.""")
     server.saveConnectionDetails()
     server.detach(cooker_logfile)
 
+    # For disk space monitor
+    diskMonDirs = cooker.configuration.data.getVar("BB_DISKMON_DIRS", 1)
+    if diskMonDirs:
+        monitorProcess = Process(target=monitordisk.monitorDiskSpace, \
+            args=(diskMonDirs, cooker.configuration.data))
+        monitorProcess.start()
+
     # Should no longer need to ever reference cooker
     del cooker
 
@@ -230,6 +239,9 @@ Default BBFILES are the .bb files in the current directory.""")
     finally:
         bb.event.ui_queue = []
         server_connection.terminate()
+        # Stop the disk space monitor
+        if diskMonDirs:
+            monitorProcess.terminate()
 
     return 1
 
diff --git a/bitbake/lib/bb/monitordisk.py b/bitbake/lib/bb/monitordisk.py
new file mode 100644
index 0000000..cb67bc2
--- /dev/null
+++ b/bitbake/lib/bb/monitordisk.py
@@ -0,0 +1,153 @@
+#!/usr/bin/env python
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+#
+# Copyright (C) 2011 Robert Yang
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
+import time, os, logging, re, sys
+import bb
+
+def errExit(info):
+    print("ERROR: %s" % info)
+    print("       Disk space monitor will NOT be enabled")
+    sys.exit(1)
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
+def convertHMS(unit):
+
+    """ Convert the time unit h, m, s, the unit is case-sensitive """
+
+    unitH = re.match('([1-9][0-9]*)h\s?$', unit)
+    if unitH:
+        return int(unitH.group(1)) * 60 * 60
+    unitM = re.match('([1-9][0-9]*)m\s?$', unit)
+    if unitM:
+        return int(unitM.group(1)) * 60
+    unitS = re.match('([1-9][0-9]*)s?\s?$', unit)
+    if unitS:
+        return int(unitS.group(1))
+    else:
+        return None
+
+def getMountedDevice(path):
+
+    """ Get the device mounted at the path, uses /proc/mounts """
+
+    # Get the mount point of the filesystem containing path
+    # st_dev is the ID of device containing file
+    parentDevice = os.stat(path).st_dev
+    currentDevice = parentDevice
+    # When the current directory's device is different from the
+    # parrent's, then the current directory is a mount point
+    while parentDevice == currentDevice:
+        mountPoint = path
+        # Use dirname to get the parrent's directory
+        path = os.path.dirname(path)
+        # Reach the "/"
+        if path == mountPoint:
+            break
+        parentDevice= os.stat(path).st_dev
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
+def monitorDiskSpace(BBDirs, configuration):
+
+    """Monitor disk space availability, warning when the disk space or
+       the amount of inode is running low"""
+
+    BBSpace = configuration.getVar("BB_DISKMON_MINSPACE", 1)
+    if BBSpace:
+        minSpace = convertGMK(BBSpace)
+        if not minSpace:
+            errExit("Invalid BB_DISKMON_MINSPACE: %s" % BBSpace)
+    else:
+        # The default value is 1GB
+        minSpace = 1024 ** 3
+
+    BBInodes = configuration.getVar("BB_DISKMON_MININODES", 1)
+    if BBInodes:
+        minInodes = convertGMK(BBInodes)
+        if not minInodes:
+            errExit("Invalid BB_DISKMON_MININODES : %s" % BBInodes)
+    else:
+        # The default value is 1K
+        minInodes = 1024
+
+    BBInterval = configuration.getVar("BB_DISKMON_INTERVAL", 1)
+    if BBInterval:
+        # The unit is second, the BB_DISKMON_INTERVAL could be ns or n
+        interval = convertHMS(BBInterval)
+        if not interval:
+            errExit("Invalid BB_DISKMON_INTERVAL: %s" % BBInterval)
+    else:
+        # The default value is 60s
+        interval = 60
+
+    # Save the device IDs, need the ID to be unique (the dictionary's key is
+    # unique), so that when more than one directories are located in the same
+    # device, we just monitor it once
+    deviceDict = {}
+    for path in BBDirs.split():
+        path = os.path.realpath(path)
+        # mkdir for the directory since it may not exist, for example the
+        # DL_DIR may not exist at the very beginning
+        if not os.path.exists(path):
+            bb.utils.mkdirhier(path)
+        mountedDevice = getMountedDevice(path)
+        deviceDict[mountedDevice] = path
+    while True:
+        for mountedDevice in deviceDict:
+            st = os.statvfs(deviceDict[mountedDevice])
+            # The free space, float point number
+            freeSpace = st.f_bavail * st.f_frsize
+            if freeSpace < minSpace:
+                print("WARNING: The free space of %s is running low (%.3fGB left)" % (mountedDevice, freeSpace / 1024 / 1024 / 1024.0))
+
+            # The free inodes, float point number
+            freeInodes = st.f_favail
+            if freeInodes < minInodes:
+                print("WARNING: The free inode of %s is running low (%.3fK left)" % (mountedDevice, freeInodes / 1024.0))
+        try:
+            time.sleep(interval)
+        except (KeyboardInterrupt, SystemExit):
+            sys.exit(1)
+
-- 
1.7.4.1



