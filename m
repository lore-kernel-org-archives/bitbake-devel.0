Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QreBj-0004uv-Uf
	for bitbake-devel@lists.openembedded.org;
	Fri, 12 Aug 2011 00:57:21 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 11 Aug 2011 15:52:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="36965239"
Received: from vorpal.jf.intel.com ([10.7.199.53])
	by orsmga002.jf.intel.com with ESMTP; 11 Aug 2011 15:52:43 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Aug 2011 15:57:28 -0700
Message-Id: <85318ad5e3b26225550d2ddcf7d62baa7b4a1f7a.1313103368.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1313103368.git.josh@linux.intel.com>
References: <cover.1313103368.git.josh@linux.intel.com>
In-Reply-To: <cover.1313103368.git.josh@linux.intel.com>
References: <cover.1313103368.git.josh@linux.intel.com>
Subject: [PATCH 5/8] bb/command|cooker: refactor the reparseFiles logic
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
X-List-Received-Date: Thu, 11 Aug 2011 22:57:21 -0000

Turn the reparseFiles logic into a command to reset the cooker's state
machine and a noop which triggers a cache rebuild.

The resetCooker command resets the cookers state machine such that a cache
update will be triggered by any async command which requires the cache.
The reparseFiles command remains as a noop async command that has the
needcache property set to True so that when called it ensures the cache is
built.

Patch from Richard with the addition of removing the force parameter from
the updateCache method.

CC: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/command.py |    7 +++++++
 lib/bb/cooker.py  |    9 ++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 893a6d9..41796f6 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -172,6 +172,13 @@ class CommandsSync:
         value = params[1]
         bb.data.setVar(varname, value, command.cooker.configuration.data)
 
+    def resetCooker(self, command, params):
+        """
+        Reset the cooker to its initial state, thus forcing a reparse for
+        any async command that has the needcache property set to True
+        """
+        command.cooker.reset()
+
 
 class CommandsAsync:
     """
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index a8edfe7..7641d60 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1091,8 +1091,8 @@ class BBCooker:
 
         self.server_registration_cb(buildTargetsIdle, rq)
 
-    def updateCache(self, force=False):
-        if self.state == state.running and not force:
+    def updateCache(self):
+        if self.state == state.running:
             return
 
         if self.state in (state.shutdown, state.stop):
@@ -1277,8 +1277,11 @@ class BBCooker:
         self.state = state.stop
 
     def reparseFiles(self):
+        return
+
+    def reset(self):
+        self.state = state.initial
         self.loadConfigurationData()
-        self.updateCache(force=True)
 
 def server_main(cooker, func, *args):
     cooker.pre_serve()
-- 
1.7.6



