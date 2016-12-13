Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 1D01B71B45
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Dec 2016 07:08:54 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga103.fm.intel.com with ESMTP; 12 Dec 2016 23:08:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,340,1477983600"; d="scan'208";a="201961493"
Received: from mauric9x-mobl.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.158.7])
	by fmsmga004.fm.intel.com with ESMTP; 12 Dec 2016 23:08:53 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 13 Dec 2016 20:07:10 +1300
Message-Id: <9daac7c0333e6ebf732e4ef5e1e5deef1530cb4f.1481611138.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1481611138.git.paul.eggleton@linux.intel.com>
References: <cover.1481611138.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 11/15] cooker: allow buildFile warning to be hidden programmatically
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
X-List-Received-Date: Tue, 13 Dec 2016 07:08:54 -0000

If we want to use this function/command internally, we don't want this
warning shown.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/command.py | 6 +++++-
 lib/bb/cooker.py  | 9 +++++----
 lib/bb/tinfoil.py | 4 ++--
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 352838b..3b68c1a 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -549,8 +549,12 @@ class CommandsAsync:
         """
         bfile = params[0]
         task = params[1]
+        if len(params) > 2:
+            hidewarning = params[2]
+        else:
+            hidewarning = False
 
-        command.cooker.buildFile(bfile, task)
+        command.cooker.buildFile(bfile, task, hidewarning)
     buildFile.needcache = False
 
     def buildTargets(self, command, params):
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 48904a5..a4aaac5 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1334,15 +1334,16 @@ class BBCooker:
             raise NoSpecificMatch
         return matches[0]
 
-    def buildFile(self, buildfile, task):
+    def buildFile(self, buildfile, task, hidewarning=False):
         """
         Build the file matching regexp buildfile
         """
         bb.event.fire(bb.event.BuildInit(), self.expanded_data)
 
-        # Too many people use -b because they think it's how you normally
-        # specify a target to be built, so show a warning
-        bb.warn("Buildfile specified, dependencies will not be handled. If this is not what you want, do not use -b / --buildfile.")
+        if not hidewarning:
+            # Too many people use -b because they think it's how you normally
+            # specify a target to be built, so show a warning
+            bb.warn("Buildfile specified, dependencies will not be handled. If this is not what you want, do not use -b / --buildfile.")
 
         # Parse the configuration here. We need to do it explicitly here since
         # buildFile() doesn't use the cache
diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 720bf4b..96275fd 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -366,9 +366,9 @@ class Tinfoil:
     def build_file(self, buildfile, task):
         """
         Runs the specified task for just a single recipe (i.e. no dependencies).
-        This is equivalent to bitbake -b.
+        This is equivalent to bitbake -b, except no warning will be printed.
         """
-        return self.run_command('buildFile', buildfile, task)
+        return self.run_command('buildFile', buildfile, task, True)
 
     def shutdown(self):
         if self.server_connection:
-- 
2.5.5


