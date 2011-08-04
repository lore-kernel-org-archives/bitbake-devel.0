Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qomj3-0000xE-7I
	for bitbake-devel@lists.openembedded.org;
	Thu, 04 Aug 2011 03:27:53 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 03 Aug 2011 18:23:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,313,1309762800"; d="scan'208";a="34155891"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.173])
	by orsmga002.jf.intel.com with ESMTP; 03 Aug 2011 18:23:28 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  3 Aug 2011 18:23:17 -0700
Message-Id: <28c71e63355ca94402a9049b8a07046e7b460026.1312420894.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1312420894.git.josh@linux.intel.com>
References: <cover.1312420894.git.josh@linux.intel.com>
In-Reply-To: <cover.1312420894.git.josh@linux.intel.com>
References: <cover.1312420894.git.josh@linux.intel.com>
Subject: [PATCH 1/6] bb/ui/hob: fix detection of whether GPLv3 is disabled
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
X-List-Received-Date: Thu, 04 Aug 2011 01:27:53 -0000

Find returns -1 if the substring isn't found, so checking for the
Truthiness of the return value is insufficient. An INCOMPATIBLE_LICENSE
value which only includes GPLv3 will cause find to return 0, for example.

Fixes [YOCTO #1320]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/hob.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index a770fc2..5998e6b 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -954,7 +954,7 @@ def main (server, eventHandler):
 
     incompatible = server.runCommand(["getVariable", "INCOMPATIBLE_LICENSE"])
     gplv3disabled = False
-    if incompatible and incompatible.lower().find("gplv3"):
+    if incompatible and incompatible.lower().find("gplv3") != -1:
         gplv3disabled = True
 
     build_toolchain = bool(server.runCommand(["getVariable", "HOB_BUILD_TOOLCHAIN"]))
-- 
1.7.6



