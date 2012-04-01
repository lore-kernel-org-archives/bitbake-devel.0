Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SELNR-0005yk-G0
	for bitbake-devel@lists.openembedded.org;
	Sun, 01 Apr 2012 16:03:29 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 01 Apr 2012 06:54:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="125796057"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by azsmga001.ch.intel.com with ESMTP; 01 Apr 2012 06:54:20 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun,  1 Apr 2012 22:21:41 +0800
Message-Id: <b5bd8a01e7cdc03219fd8cabc62010283bc18fc2.1333289684.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <0c8981e042d26a7b381f85256d918a059c866fed.1333289684.git.shane.wang@intel.com>
References: <0c8981e042d26a7b381f85256d918a059c866fed.1333289684.git.shane.wang@intel.com>
In-Reply-To: <cover.1333289684.git.shane.wang@intel.com>
References: <cover.1333289684.git.shane.wang@intel.com>
Subject: [PATCH 5/7] meta-yocto/local.conf.sample: change = to ?= for BB_NUMBER_THREADS and PARALLEL_MAKE
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
X-List-Received-Date: Sun, 01 Apr 2012 14:03:29 -0000

In the current local.conf, BB_NUMBER_THREADS and PARALLEL_MAKE are assigned
by '=', which overwrites the values set from the Hob. To avoid that, use '?='
instead.

[Yocto #2210]

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 meta-yocto/conf/local.conf.sample |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/meta-yocto/conf/local.conf.sample b/meta-yocto/conf/local.conf.sample
index 38507e3..a4a8192 100644
--- a/meta-yocto/conf/local.conf.sample
+++ b/meta-yocto/conf/local.conf.sample
@@ -17,12 +17,12 @@
 # These two options control how much parallelism BitBake should use. The first 
 # option determines how many tasks bitbake should run in parallel:
 #
-#BB_NUMBER_THREADS = "4"
+#BB_NUMBER_THREADS ?= "4"
 # 
 # The second option controls how many processes make should run in parallel when
 # running compile tasks:
 #
-#PARALLEL_MAKE = "-j 4"
+#PARALLEL_MAKE ?= "-j 4"
 #
 # For a quad-core machine, BB_NUMBER_THREADS = "4", PARALLEL_MAKE = "-j 4" would
 # be appropriate for example.
-- 
1.7.6



