Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1SFmRO-0003oX-Vo
	for bitbake-devel@lists.openembedded.org;
	Thu, 05 Apr 2012 15:09:31 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q35D0IEa018211
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 5 Apr 2012 06:00:18 -0700 (PDT)
Received: from usp-ub10.corp.ad.wrs.com (128.224.163.69) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.1.255.0; Thu, 5 Apr 2012 06:00:18 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 5 Apr 2012 20:58:57 +0800
Message-ID: <65fa6134831ad83875028334074664a86aaf7ea0.1333630624.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <cover.1333630624.git.liezhi.yang@windriver.com>
References: <cover.1333630624.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] diskspace monitor: assign a default value when only of the interval is set
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
X-List-Received-Date: Thu, 05 Apr 2012 13:09:31 -0000
Content-Type: text/plain

Assign a default value to the other one when either disk space interval
or amount of inodes interval value is set for example:

BB_DISKMON_WARNINTERVAL = "50M,"
or
BB_DISKMON_WARNINTERVAL = ",5K"

The diskspace monitor would not enable in the past, that seemed
unreasonable, assign a default value to the other one currently, so the
monitor will be enabled, and will warn both of diskspace and free
amount of inode if they have been set in BB_DISKMON_DIRS.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/monitordisk.py |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/monitordisk.py b/bitbake/lib/bb/monitordisk.py
index 9baba5e..9469193 100644
--- a/bitbake/lib/bb/monitordisk.py
+++ b/bitbake/lib/bb/monitordisk.py
@@ -136,10 +136,13 @@ def getInterval(configuration):
 
     """ Get the disk space interval """
 
+    # The default value is 50M and 5K.
+    spaceDefault = 50 * 1024 * 1024
+    inodeDefault = 5 * 1024
+
     interval = configuration.getVar("BB_DISKMON_WARNINTERVAL", True)
     if not interval:
-        # The default value is 50M and 5K.
-        return 50 * 1024 * 1024, 5 * 1024
+        return spaceDefault, inodeDefault
     else:
         # The disk space or inode interval is optional, but it should
         # have a correct value once it is specified
@@ -151,12 +154,16 @@ def getInterval(configuration):
                 if not intervalSpace:
                     printErr("Invalid disk space interval value in BB_DISKMON_WARNINTERVAL: %s" % intervalRe.group(1))
                     return None, None
+            else:
+                intervalSpace = spaceDefault
             intervalInode = intervalRe.group(2)
             if intervalInode:
                 intervalInode = convertGMK(intervalInode)
                 if not intervalInode:
                     printErr("Invalid disk inode interval value in BB_DISKMON_WARNINTERVAL: %s" % intervalRe.group(2))
                     return None, None
+            else:
+                intervalInode = inodeDefault
             return intervalSpace, intervalInode
         else:
             printErr("Invalid interval value in BB_DISKMON_WARNINTERVAL: %s" % interval)
-- 
1.7.1



