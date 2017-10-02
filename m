Return-Path: <leonardo.sandoval.gonzalez@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 6397371957
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  2 Oct 2017 15:38:54 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	02 Oct 2017 08:38:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.42,470,1500966000"; d="scan'208";a="1226094808"
Received: from yctb05.ostc.intel.com ([10.54.69.59])
	by fmsmga002.fm.intel.com with ESMTP; 02 Oct 2017 08:38:54 -0700
From: leonardo.sandoval.gonzalez@linux.intel.com
To: bitbake-devel@lists.openembedded.org
Date: Mon,  2 Oct 2017 08:38:49 -0700
Message-Id: <20171002153849.24922-3-leonardo.sandoval.gonzalez@linux.intel.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20171002153849.24922-1-leonardo.sandoval.gonzalez@linux.intel.com>
References: <20171002153849.24922-1-leonardo.sandoval.gonzalez@linux.intel.com>
Subject: [PATCH 3/3] README: new readme file including main aspects of the project
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
X-List-Received-Date: Mon, 02 Oct 2017 15:38:54 -0000

From: Leonardo Sandoval <leonardo.sandoval.gonzalez@linux.intel.com>

Includes brief description of the project, pointers to website, documentation,
mailing list and source code.

Signed-off-by: Leonardo Sandoval <leonardo.sandoval.gonzalez@linux.intel.com>
---
 README | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 README

diff --git a/README b/README
new file mode 100644
index 00000000..95ad4dd3
--- /dev/null
+++ b/README
@@ -0,0 +1,31 @@
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
+but in general main guidelines apply.
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


