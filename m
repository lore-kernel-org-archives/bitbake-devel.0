Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1S1ZuR-0000Jm-2Z
	for bitbake-devel@lists.openembedded.org;
	Sun, 26 Feb 2012 09:56:47 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q1Q8mL5s019944
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 26 Feb 2012 00:48:21 -0800 (PST)
Received: from build-PowerEdge-T100.corp.ad.wrs.com (128.224.163.66) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.1.255.0; Sun, 26 Feb 2012 00:48:21 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 26 Feb 2012 16:48:16 +0800
Message-ID: <aed084c0ebea65b764831e4eed15ae4cee08da62.1330245845.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1330245845.git.liezhi.yang@windriver.com>
References: <cover.1330245845.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 3/3] V5 Add config sample for disk space monitoring
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
X-List-Received-Date: Sun, 26 Feb 2012 08:56:47 -0000
Content-Type: text/plain

Add config sample for disk space monitoring to
meta-yocto/conf/local.conf.sample

[YOCTO #1589]
Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 meta-yocto/conf/local.conf.sample |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/meta-yocto/conf/local.conf.sample b/meta-yocto/conf/local.conf.sample
index 38507e3..9c3bfd5 100644
--- a/meta-yocto/conf/local.conf.sample
+++ b/meta-yocto/conf/local.conf.sample
@@ -224,3 +224,36 @@ PATCHRESOLVE = "noop"
 # track the version of this file when it was generated. This can safely be ignored if
 # this doesn't mean anything to you.
 CONF_VERSION = "1"
+
+#
+# Disk space monitor, take action when the disk space or the amount of
+# inode is running low, it is enabled when BB_DISKMON_DIRS is set.
+#
+# Set the directories to monitor for disk usage, if more than one
+# directories are mounted in the same device, then only one directory
+# would be monitored since the monitor is based on the device.
+# The format is:
+# "action,directory,minimum_space,minimum_free_inode"
+#
+# The "action" must be set and should be one of:
+# ABORT: Immediately abort
+# STOPTASKS: The new tasks can't be executed any more, will stop the build
+#           when the running tasks have been done.
+# WARN: show warnings (see BB_DISKMON_WARNINTERVAL for more information)
+#
+# The "directory" must be set, any directory is OK.
+#
+# Either "minimum_space" or "minimum_free_inode" (or both of them)
+# should be set, otherwise the monitor would not be enabled,
+# the unit can be G, M, K or none, but do NOT use GB, MB or KB
+# (B is not needed).
+#BB_DISKMON_DIRS = "STOPTASKS,${TMPDIR},1G,100K WARN,${SSTATE_DIR},1G,100K"
+#
+# Set disk space and inode interval (only works when the action is "WARN",
+# the unit can be G, M, or K, but do NOT use the GB, MB or KB
+# (B is not needed), the format is:
+# "disk_space_interval,disk_inode_interval", the default value is
+# "50M,5K" which means that it would warn when the free space is
+# lower than the minimum space(or inode), and would repeat the warning
+# when the disk space reduces 50M (or the amount of inode reduces 5k).
+#BB_DISKMON_WARNINTERVAL = "50M,5K"
-- 
1.7.4.1



