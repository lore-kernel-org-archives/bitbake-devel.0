Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qqb2W-0003xC-0y
	for bitbake-devel@lists.openembedded.org;
	Tue, 09 Aug 2011 03:23:28 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 08 Aug 2011 18:18:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,340,1309762800"; d="scan'208";a="36498565"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.247])
	by azsmga001.ch.intel.com with ESMTP; 08 Aug 2011 18:18:42 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  8 Aug 2011 18:18:31 -0700
Message-Id: <8a2ba309cf990ecb239a188f0e059dac8e55661f.1312852599.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1312852599.git.josh@linux.intel.com>
References: <cover.1312852599.git.josh@linux.intel.com>
In-Reply-To: <cover.1312852599.git.josh@linux.intel.com>
References: <cover.1312852599.git.josh@linux.intel.com>
Subject: [PATCH 4/4] bb/ui/hob: Restore toolchain relevant preference settings for build
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
X-List-Received-Date: Tue, 09 Aug 2011 01:23:28 -0000

From: Jessica Zhang <jessica.zhang@intel.com>

Fixes [#YOCTO 1354]

Signed-off-by: Jessica Zhang <jessica.zhang@intel.com>
Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/hob.py |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index e042765..b0a98cb 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -980,7 +980,9 @@ def main (server, eventHandler):
         gplv3disabled = True
 
     build_toolchain = bool(server.runCommand(["getVariable", "HOB_BUILD_TOOLCHAIN"]))
+    handler.toggle_toolchain(build_toolchain)
     build_headers = bool(server.runCommand(["getVariable", "HOB_BUILD_TOOLCHAIN_HEADERS"]))
+    handler.toggle_toolchain_headers(build_headers)
 
     prefs = HobPrefs(configurator, handler, sdk_mach, distro, pclass, cpu_cnt,
                      pmake, bbthread, selected_image_types, all_image_types,
-- 
1.7.6



