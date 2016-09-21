Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id E772C6093E
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Sep 2016 21:32:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u8LLW1wo027785 for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Sep 2016 22:32:01 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id LE36WYP3vKz4 for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Sep 2016 22:32:01 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u8LLVvev027782
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Sep 2016 22:31:58 +0100
Message-ID: <1474493517.7207.343.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 21 Sep 2016 22:31:57 +0100
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Subject: [PATCH] cooker/providers: Only add target to world build if task exists
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
X-List-Received-Date: Wed, 21 Sep 2016 21:32:01 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

A "bitbake world -c unpack" currently breaks as not all tasks have an 
unpack task. This change allows addition of world targets only if the 
specified task exists which makes certain commands possible when otherwise
you just get errors which can't easily be avoided.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 0e78106..606b08e 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -658,7 +658,7 @@ class BBCooker:
         if task is None:
             task = self.configuration.cmd
 
-        fulltargetlist = self.checkPackages(pkgs_to_build)
+        fulltargetlist = self.checkPackages(pkgs_to_build, task)
         taskdata = {}
         localdata = {}
 
@@ -1586,7 +1586,7 @@ class BBCooker:
 
         return True
 
-    def checkPackages(self, pkgs_to_build):
+    def checkPackages(self, pkgs_to_build, task=None):
 
         # Return a copy, don't modify the original
         pkgs_to_build = pkgs_to_build[:]
@@ -1602,7 +1602,7 @@ class BBCooker:
         if 'world' in pkgs_to_build:
             pkgs_to_build.remove('world')
             for mc in self.multiconfigs:
-                bb.providers.buildWorldTargetList(self.recipecaches[mc])
+                bb.providers.buildWorldTargetList(self.recipecaches[mc], task)
                 for t in self.recipecaches[mc].world_target:
                     if mc:
                         t = "multiconfig:" + mc + ":" + t
diff --git a/bitbake/lib/bb/providers.py b/bitbake/lib/bb/providers.py
index 80701b2..db02a0b 100644
--- a/bitbake/lib/bb/providers.py
+++ b/bitbake/lib/bb/providers.py
@@ -402,7 +402,7 @@ def getRuntimeProviders(dataCache, rdepend):
     return rproviders
 
 
-def buildWorldTargetList(dataCache):
+def buildWorldTargetList(dataCache, task=None):
     """
     Build package list for "bitbake world"
     """
@@ -413,6 +413,9 @@ def buildWorldTargetList(dataCache):
     for f in dataCache.possible_world:
         terminal = True
         pn = dataCache.pkg_fn[f]
+        if task and task not in dataCache.task_deps[f]['tasks']:
+            logger.debug(2, "World build skipping %s as task %s doesn't exist", f, task)
+            terminal = False
 
         for p in dataCache.pn_provides[pn]:
             if p.startswith('virtual/'):



