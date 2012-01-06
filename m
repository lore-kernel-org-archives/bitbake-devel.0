Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RjCFS-0001Io-Fs
	for bitbake-devel@lists.openembedded.org;
	Fri, 06 Jan 2012 17:02:30 +0100
Received: by opal (Postfix, from userid 111)
	id 20DB810333; Fri,  6 Jan 2012 16:02:57 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120106160257.20DB810333@opal>
Date: Fri,  6 Jan 2012 16:02:57 +0000 (UTC)
From: git@git.openembedded.org
Subject: Dongxiao Xu : command.py: add initCooker API
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
X-List-Received-Date: Fri, 06 Jan 2012 16:02:30 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 8ee9c6cc47938604268242d90bd3007218f9a36e
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=8ee9c6cc47938604268242d90bd3007218f9a36e

Author: Dongxiao Xu <dongxiao.xu@intel.com>
Date:   Fri Jan  6 17:02:22 2012 +0800

command.py: add initCooker API

initCooker is to set the cooker to the initial state with nothing
parsed.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/command.py |    6 ++++++
 lib/bb/cooker.py  |   13 +++++++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 5dec6a9..701b286 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -157,6 +157,12 @@ class CommandsSync:
         value = params[1]
         command.cooker.configuration.data.setVar(varname, value)
 
+    def initCooker(self, command, params):
+        """
+        Init the cooker to initial state with nothing parsed
+        """
+        command.cooker.initialize()
+
     def resetCooker(self, command, params):
         """
         Reset the cooker to its initial state, thus forcing a reparse for
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 6473839..1faf821 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -167,6 +167,15 @@ class BBCooker:
 
         self.parser = None
 
+    def initConfigurationData(self):
+        self.configuration.data = bb.data.init()
+
+        if not self.server_registration_cb:
+            bb.data.setVar("BB_WORKERCONTEXT", "1", self.configuration.data)
+
+        filtered_keys = bb.utils.approved_variables()
+        bb.data.inheritFromOS(self.configuration.data, self.savedenv, filtered_keys)
+
     def loadConfigurationData(self):
         self.configuration.data = bb.data.init()
 
@@ -1304,6 +1313,10 @@ class BBCooker:
     def reparseFiles(self):
         return
 
+    def initialize(self):
+        self.state = state.initial
+        self.initConfigurationData()
+
     def reset(self):
         self.state = state.initial
         self.loadConfigurationData()



