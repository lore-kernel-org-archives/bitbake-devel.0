Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1RkbDY-0002tC-Er
	for bitbake-devel@lists.openembedded.org;
	Tue, 10 Jan 2012 13:54:20 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q0ACkpxU028151
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Jan 2012 04:46:51 -0800 (PST)
Received: from build-PowerEdge-T100.corp.ad.wrs.com (128.224.163.66) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.1.255.0; Tue, 10 Jan 2012 04:46:51 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 10 Jan 2012 20:45:08 +0800
Message-ID: <e2c0c2e9c1dd5eac7eb4757cb6b3f0adae8e9d5f.1326199289.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1326199289.git.liezhi.yang@windriver.com>
References: <cover.1326199289.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 2/2] V2 Add config sample for disk space monitoring
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
X-List-Received-Date: Tue, 10 Jan 2012 12:54:20 -0000
Content-Type: text/plain

Add config sample for disk space monitoring to
meta-yocto/conf/local.conf.sample

[YOCTO #1589]
Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 meta-yocto/conf/local.conf.sample |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/meta-yocto/conf/local.conf.sample b/meta-yocto/conf/local.conf.sample
index 38507e3..c82cb7e 100644
--- a/meta-yocto/conf/local.conf.sample
+++ b/meta-yocto/conf/local.conf.sample
@@ -224,3 +224,31 @@ PATCHRESOLVE = "noop"
 # track the version of this file when it was generated. This can safely be ignored if
 # this doesn't mean anything to you.
 CONF_VERSION = "1"
+
+#
+# Disk space monitor, warning when the disk space or the amount of inode
+# is running low, it is enabled when BB_DISKMON_DIRS is set.
+#
+# Set the directories to monitor for disk usage, if more than one
+# directories are in the same device, then only one directory would be
+# warned since the monitor is based on the device.
+#
+BB_DISKMON_DIRS = "${TMPDIR} ${DL_DIR} ${SSTATE_DIR}"
+#
+# Set the minimum amount of disk space to warn, the unit can be G,
+# M or K, but do not use GB, MB or KB (B is not needed).
+# The default vaule is 1G if not set.
+#
+#BB_DISKMON_MINSPACE = "1G"
+#
+# Set the minimum amount of inodes to warn, the unit can be G, M or K.
+# The default value is 1K if not set.
+#
+#BB_DISKMON_MININODES = "1K"
+#
+# Set the monitor frequency, the unit can be h(hour), m(minute) or
+# s(second), when no unit is specified, the default unit is s(second),
+# for example, "60" means 60 seconds.
+# The default value is 60s if not set.
+#
+#BB_DISKMON_INTERVAL = "60s"
-- 
1.7.4.1



