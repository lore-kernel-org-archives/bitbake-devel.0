Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1U2J5n-00075o-Tq
	for bitbake-devel@lists.openembedded.org;
	Mon, 04 Feb 2013 11:16:06 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id r14A0F8o015556
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 4 Feb 2013 02:00:15 -0800 (PST)
Received: from pek-usp-3.wrs.com (128.224.163.124) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.318.4;
	Mon, 4 Feb 2013 02:00:14 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 4 Feb 2013 18:03:35 +0800
Message-ID: <e6410ca8b71ebd3aa0183f2036c0fcde923c0508.1359970151.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <cover.1359970151.git.liezhi.yang@windriver.com>
References: <cover.1359970151.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Cc: Zhenfeng.Zhao@windriver.com
Subject: [PATCH 1/1] monitordisk.py: disable the inode checking for some fs
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
X-List-Received-Date: Mon, 04 Feb 2013 10:16:08 -0000
Content-Type: text/plain

There is an error when use disk monitor on btrfs:
WARNING: The free inode of rootfs is running low (0.000K left)
ERROR: Immediately abort since the disk space monitor action is "ABORT"!

This is beucase some fs formats' statvfs.f_files (inodes) is zero, thus
the statvfs.f_favail (free inodes) is zero, too, this a feature of the
fs, we disable the inode checking for such a fs.

[YOCTO #3609]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/monitordisk.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/monitordisk.py b/bitbake/lib/bb/monitordisk.py
index 2bd4881..1c1e614 100644
--- a/bitbake/lib/bb/monitordisk.py
+++ b/bitbake/lib/bb/monitordisk.py
@@ -128,7 +128,7 @@ def getDiskData(BBDirs, configuration):
         if not os.path.exists(path):
             bb.utils.mkdirhier(path)
         mountedDev = getMountedDev(path)
-        devDict[mountedDev] = action, path, minSpace, minInode
+        devDict[mountedDev] = [action, path, minSpace, minInode]
 
     return devDict
 
@@ -231,6 +231,13 @@ class diskMonitor:
                 freeInode = st.f_favail
 
                 if self.devDict[dev][3] and freeInode < self.devDict[dev][3]:
+                    # Some fs formats' (e.g., btrfs) statvfs.f_files (inodes) is
+                    # zero, this is a feature of the fs, we disable the inode
+                    # checking for such a fs.
+                    if st.f_files == 0:
+                        logger.warn("Inode check for %s is unavaliable, remove it from disk monitor" % dev)
+                        self.devDict[dev][3] = None
+                        continue
                     # Always show warning, the self.checked would always be False if the action is WARN
                     if self.preFreeI[dev] == 0 or self.preFreeI[dev] - freeInode > self.inodeInterval and not self.checked[dev]:
                         logger.warn("The free inode of %s is running low (%.3fK left)" % (dev, freeInode / 1024.0))
-- 
1.7.11.2



