Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1R75B7-0006DY-9w
	for bitbake-devel@lists.openembedded.org;
	Fri, 23 Sep 2011 14:48:30 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 23 Sep 2011 05:43:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,430,1312182000"; d="scan'208";a="19954427"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.120.136])
	by AZSMGA002.ch.intel.com with ESMTP; 23 Sep 2011 05:43:06 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 23 Sep 2011 13:43:02 +0100
Message-Id: <e93b8449659b02b0abbf5f39b40488e9ba05c142.1316781566.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1316781566.git.paul.eggleton@linux.intel.com>
References: <cover.1316781566.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1316781566.git.paul.eggleton@linux.intel.com>
References: <cover.1316781566.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] bitbake/lib/bb/msg.py: fix setting debug and verbosity levels
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
X-List-Received-Date: Fri, 23 Sep 2011 12:48:30 -0000

The debug and verbosity levels (as set by the -D and -v command line
options respectively)  were not being passed through within msg.py since
bitbake revision 45aad2f9647df14bcfa5e755b57e1ddab377939a due to setting
incorrect variable names.

Fixes [YOCTO #1513].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/msg.py |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/msg.py b/bitbake/lib/bb/msg.py
index b7ae761..20d9bdd 100644
--- a/bitbake/lib/bb/msg.py
+++ b/bitbake/lib/bb/msg.py
@@ -106,8 +106,8 @@ def init_msgconfig(verbose, debug, debug_domains = []):
     """
     Set default verbosity and debug levels config the logger
     """
-    bb.msg.loggerDebugLevel = debug
-    bb.msg.loggerVerbose = verbose
+    bb.msg.loggerDefaultDebugLevel = debug
+    bb.msg.loggerDefaultVerbose = verbose
     bb.msg.loggerDefaultDomains = debug_domains
 
 def addDefaultlogFilter(handler):
-- 
1.7.4.1



