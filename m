Return-Path: <leonardo.sandoval.gonzalez@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 30D7778260
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  6 Oct 2017 15:11:08 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	06 Oct 2017 08:10:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.42,484,1500966000"; d="scan'208";a="1203024178"
Received: from yctb05.ostc.intel.com ([10.54.69.59])
	by fmsmga001.fm.intel.com with ESMTP; 06 Oct 2017 08:10:48 -0700
From: leonardo.sandoval.gonzalez@linux.intel.com
To: bitbake-devel@lists.openembedded.org
Date: Fri,  6 Oct 2017 08:10:43 -0700
Message-Id: <20171006151043.55075-3-leonardo.sandoval.gonzalez@linux.intel.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20171006151043.55075-1-leonardo.sandoval.gonzalez@linux.intel.com>
References: <20171006151043.55075-1-leonardo.sandoval.gonzalez@linux.intel.com>
Subject: [PATCH v2 3/3] README: new readme file including main aspects of the project
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 06 Oct 2017 15:11:08 -0000

From: Leonardo Sandoval <leonardo.sandoval.gonzalez@linux.intel.com>

Includes brief description of the project, pointers to website, documentation,
mailing list and source code.

Signed-off-by: Leonardo Sandoval <leonardo.sandoval.gonzalez@linux.intel.com>
---
 README | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 README

diff --git a/README b/README
new file mode 100644
index 00000000..479c3765
--- /dev/null
+++ b/README
@@ -0,0 +1,35 @@
+Bitbake
+=======
+
+BitBake is a generic task execution engine that allows shell and Python tasks to be run
+efficiently and in parallel while working within complex inter-task dependency constraints.
+One of BitBake's main users, OpenEmbedded, takes this core and builds embedded Linux software
+stacks using a task-oriented approach.
+
+For information about Bitbake, see the OpenEmbedded website:
+    http://www.openembedded.org/
+
+Bitbake plain documentation can be found under the doc directory or its integrated
+html version at the Yocto Project website:
+    http://yoctoproject.org/documentation
+
+Contributing
+------------
+
+Please refer to
+http://www.openembedded.org/wiki/How_to_submit_a_patch_to_OpenEmbedded
+for guidelines on how to submit patches, just note that the latter documentation is intended
+for OpenEmbedded (and its core) not bitbake patches (bitbake-devel@lists.openembedded.org)
+but in general main guidelines apply. Once the commit(s) have been created, the way to send
+the patch is through git-send-email. For example, to send the last commit (HEAD) on current
+branch, type:
+
+    git send-email -M -1 --to bitbake-devel@lists.openembedded.org
+
+Mailing list:
+
+    http://lists.openembedded.org/mailman/listinfo/bitbake-devel
+
+Source code:
+
+    http://git.openembedded.org/bitbake/
-- 
2.12.3


