Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1ROT59-0002R4-6q
	for bitbake-devel@lists.openembedded.org;
	Thu, 10 Nov 2011 12:46:11 +0100
Received: by opal (Postfix, from userid 111)
	id 0C8A710334; Thu, 10 Nov 2011 11:40:39 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20111110114039.0C8A710334@opal>
Date: Thu, 10 Nov 2011 11:40:39 +0000 (UTC)
From: git@git.openembedded.org
Subject: Richard Purdie : data_smart: Add appendVar/prependVar functions
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
X-List-Received-Date: Thu, 10 Nov 2011 11:46:11 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 4a4046268f84b85559eea2c4b6a6004ad8cccb77
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=4a4046268f84b85559eea2c4b6a6004ad8cccb77

Author: Richard Purdie <richard.purdie@linuxfoundation.org>
Date:   Tue Nov  8 18:02:15 2011 +0000

data_smart: Add appendVar/prependVar functions

This patch adds appendVar and prependVar functions to the data store
meaning python code would no longer have to do the getVar, append and
the setVar dance that much of the current python code does.

It also adds corresponding variants for flags.

Currently there is no spacing added by these functions. That could be
added as a parameter if desired.

If these functions turn out to be hotspots in the code, there are tricks
that could potentially be used to increase the speed of these specific
operations within the datastore.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/data_smart.py |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 072f403..ec4e921 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -304,6 +304,14 @@ class DataSmart(MutableMapping):
 
         self.delVar(key)
 
+    def appendVar(self, key, value):
+        value = (self.getVar(key, False) or "") + value
+        self.setVar(key, value)
+
+    def prependVar(self, key, value):
+        value = value + (self.getVar(key, False) or "")
+        self.setVar(key, value)
+
     def delVar(self, var):
         self.expand_cache = {}
         self.dict[var] = {}
@@ -339,6 +347,14 @@ class DataSmart(MutableMapping):
         if var in self.dict and flag in self.dict[var]:
             del self.dict[var][flag]
 
+    def appendVarFlag(self, key, flag, value):
+        value = (self.getVarFlag(key, flag, False) or "") + value
+        self.setVarFlag(key, flag, value)
+
+    def prependVarFlag(self, key, flag, value):
+        value = value + (self.getVarFlag(key, flag, False) or "")
+        self.setVarFlag(key, flag, value)
+
     def setVarFlags(self, var, flags):
         if not var in self.dict:
             self._makeShadowCopy(var)



