Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QcWtR-0007r3-22
	for bitbake-devel@lists.openembedded.org;
	Fri, 01 Jul 2011 08:07:57 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 30 Jun 2011 23:03:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,456,1304319600"; d="scan'208";a="21321701"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.13.228])
	by azsmga001.ch.intel.com with ESMTP; 30 Jun 2011 23:03:05 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 30 Jun 2011 23:02:49 -0700
Message-Id: <97327993e80e0120705f014c0c5db52ed44a06d6.1309499228.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1309499227.git.josh@linux.intel.com>
References: <cover.1309499227.git.josh@linux.intel.com>
In-Reply-To: <cover.1309499227.git.josh@linux.intel.com>
References: <cover.1309499227.git.josh@linux.intel.com>
Subject: [PATCH 03/10] command|cooker: allow generating targets tree for specified pkgs
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
X-List-Received-Date: Fri, 01 Jul 2011 06:07:57 -0000

Modify the generateTargetsTree command to allow a list of packages to be
supplied by the caller, in this case we will only generate a target tree
for user requested targets rather than building a tree for the world list.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/command.py |   12 ++++++++++--
 lib/bb/cooker.py  |    6 ++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 9841e68..d597d1d 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -224,11 +224,19 @@ class CommandsAsync:
 
     def generateTargetsTree(self, command, params):
         """
-        Generate a tree of all buildable targets.
+        Generate a tree of buildable targets.
+        If klass is provided ensure all recipes that inherit the class are
+        included in the package list.
+        If pkg_list provided use that list (plus any extras brought in by
+        klass) rather than generating a tree for all packages.
         """
         klass = params[0]
+        if len(params) > 1:
+            pkg_list = params[1]
+        else:
+            pkg_list = []
 
-        command.cooker.generateTargetsTree(klass)
+        command.cooker.generateTargetsTree(klass, pkg_list)
         command.finishAsyncCommand()
     generateTargetsTree.needcache = True
 
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 990d17b..4ad1536 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -591,12 +591,14 @@ class BBCooker:
 
         return target_tree
 
-    def generateTargetsTree(self, klass):
+    def generateTargetsTree(self, klass=None, pkgs=[]):
         """
         Generate a dependency tree of buildable targets
         Generate an event with the result
         """
-        pkgs = ['world']
+        # if the caller hasn't specified a pkgs list default to world
+        if not len(pkgs):
+            pkgs = ['world']
         # if inherited_class passed ensure all recipes which inherit the
         # specified class are included in pkgs
         if klass:
-- 
1.7.5.4



