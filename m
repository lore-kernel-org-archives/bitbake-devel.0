Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1RzQ70-000581-V4
	for bitbake-devel@lists.openembedded.org;
	Mon, 20 Feb 2012 11:04:51 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q1K9uXYV008424
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Feb 2012 01:56:33 -0800 (PST)
Received: from build-PowerEdge-T100.corp.ad.wrs.com (128.224.163.66) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.1.255.0; Mon, 20 Feb 2012 01:56:32 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 20 Feb 2012 17:53:56 +0800
Message-ID: <97029eb6f87f3ff9bf7272cad7c18462ddb614fa.1329727465.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1329727465.git.liezhi.yang@windriver.com>
References: <cover.1329727465.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 2/2] V4 Add config sample for disk space monitoring
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
X-List-Received-Date: Mon, 20 Feb 2012 10:04:51 -0000
Content-Type: text/plain

Add config sample for disk space monitoring to
meta-yocto/conf/local.conf.sample

[YOCTO #1589]
Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 meta-yocto/conf/local.conf.sample |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/meta-yocto/conf/local.conf.sample b/meta-yocto/conf/local.conf.sample
index 38507e3..33e6d7a 100644
--- a/meta-yocto/conf/local.conf.sample
+++ b/meta-yocto/conf/local.conf.sample
@@ -224,3 +224,32 @@ PATCHRESOLVE = "noop"
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
+# The format are: "directory,minimum space,minimum free inode",
+# either space or inode (Or both of them) should be specified, otherwise
+# the monitor would not be enabled, the unit can be G, M, K or none,
+# but do NOT use GB, MB or KB (B is not needed).
+#BB_DISKMON_DIRS = "${TMPDIR},1G,1K ${SSTATE_DIR},500M,1K"
+#
+# Set the action when the space is running low, the action is one of:
+# ABORT: Immediately abort
+# NO_NEW_TASK: no new tasks
+# WARN: show warnings
+# The default is WARN
+#BB_DISKMON_ACTION = "WARN"
+#
+# Set disk space and inode interval, the unit can be G, M, or K, but do
+# NOT use the GB, MB or KB (B is not needed), the format is:
+# "disk space interval, disk inode interval",  the default value is
+# "10M, 50" which means that it would warn when the free space is
+# lower than the minimum space(or inode), and would repeat the action
+# when the disk space reduces 10M (or the amount of inode reduces 50)
+# again.
+#BB_DISKMON_INTERVAL = "10M,1K"
-- 
1.7.4.1



