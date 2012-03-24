Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SBPeW-0003YO-GT
	for bitbake-devel@lists.openembedded.org;
	Sat, 24 Mar 2012 13:01:00 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 24 Mar 2012 04:51:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="144723769"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by fmsmga002.fm.intel.com with ESMTP; 24 Mar 2012 04:51:51 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 24 Mar 2012 19:49:27 +0800
Message-Id: <f8e0929d3af0994bf481f02405ac7481d23a59b6.1332589589.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1332589589.git.dongxiao.xu@intel.com>
References: <cover.1332589589.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1332589589.git.dongxiao.xu@intel.com>
References: <cover.1332589589.git.dongxiao.xu@intel.com>
Subject: [PATCH 9/9] Hob: Avoid getting TMPDIR in hardcode
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
X-List-Received-Date: Sat, 24 Mar 2012 12:01:00 -0000

We should get TMPDIR from bitbake server instead of hardcode.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/builder.py         |    3 ++-
 lib/bb/ui/crumbs/hobeventhandler.py |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index 2984490..7b6c116 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -138,6 +138,7 @@ class Parameters:
         self.runnable_image_types = params["runnable_image_types"].split()
         self.runnable_machine_patterns = params["runnable_machine_patterns"].split()
         self.deployable_image_types = params["deployable_image_types"].split()
+        self.tmpdir = params["tmpdir"]
 
 class Builder(gtk.Window):
 
@@ -813,7 +814,7 @@ class Builder(gtk.Window):
 
         if response == gtk.RESPONSE_YES:
             source_env_path = os.path.join(self.parameters.core_base, "oe-init-build-env")
-            tmp_path = os.path.join(os.getcwd(), "tmp")
+            tmp_path = self.parameters.tmpdir
             if os.path.exists(image_path) and os.path.exists(kernel_path) \
                and os.path.exists(source_env_path) and os.path.exists(tmp_path):
                 cmdline = "/usr/bin/xterm -e "
diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index e342811..8042fbd 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -439,4 +439,5 @@ class HobHandler(gobject.GObject):
         params["runnable_image_types"] = self.server.runCommand(["getVariable", "RUNNABLE_IMAGE_TYPES"]) or ""
         params["runnable_machine_patterns"] = self.server.runCommand(["getVariable", "RUNNABLE_MACHINE_PATTERNS"]) or ""
         params["deployable_image_types"] = self.server.runCommand(["getVariable", "DEPLOYABLE_IMAGE_TYPES"]) or ""
+        params["tmpdir"] = self.server.runCommand(["getVariable", "TMPDIR"]) or ""
         return params
-- 
1.7.4.1



