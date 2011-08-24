Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QwK1G-00010b-1Y
	for bitbake-devel@lists.openembedded.org;
	Wed, 24 Aug 2011 22:25:50 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 24 Aug 2011 13:21:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="41542776"
Received: from vorpal.jf.intel.com ([10.7.199.155])
	by orsmga002.jf.intel.com with ESMTP; 24 Aug 2011 13:21:01 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 24 Aug 2011 13:25:58 -0700
Message-Id: <595889b65cfd4ae74beeddd6a01ba308b786da65.1314217450.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1314217450.git.josh@linux.intel.com>
References: <cover.1314217450.git.josh@linux.intel.com>
In-Reply-To: <cover.1314217450.git.josh@linux.intel.com>
References: <cover.1314217450.git.josh@linux.intel.com>
Subject: [PATCH 1/3] hob: don't set PARALLEL_MAKE and BB_NUMBER_THREADS based on cpu count
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
X-List-Received-Date: Wed, 24 Aug 2011 20:25:50 -0000

This was actually broken with recent changes as the values were never
persisted to a file (meaning they were unset on the server at reparse
despite the UI indicating they were set).

However, I've chosen to remove the 'feature' as pegging a users CPU without
them asking to use high thread counts seems a little offensive.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hobprefs.py |    4 +---
 lib/bb/ui/hob.py             |   11 +++--------
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobprefs.py b/lib/bb/ui/crumbs/hobprefs.py
index ee42e58..3859b29 100644
--- a/lib/bb/ui/crumbs/hobprefs.py
+++ b/lib/bb/ui/crumbs/hobprefs.py
@@ -166,7 +166,7 @@ class HobPrefs(gtk.Dialog):
             self.reload_required = False
 
     def __init__(self, configurator, handler, curr_sdk_mach, curr_distro, pclass,
-                 cpu_cnt, pmake, bbthread, selected_image_types, all_image_types,
+                 pmake, bbthread, selected_image_types, all_image_types,
                  gplv3disabled, build_toolchain, build_toolchain_headers):
         """
         """
@@ -185,7 +185,6 @@ class HobPrefs(gtk.Dialog):
         self.curr_sdk_mach = curr_sdk_mach
         self.curr_distro = curr_distro
         self.curr_package_format = pclass
-        self.cpu_cnt = cpu_cnt
         self.pmake = pmake
         self.bbthread = bbthread
         self.selected_image_types = selected_image_types.split(" ")
@@ -283,7 +282,6 @@ class HobPrefs(gtk.Dialog):
         # set a high maximum as a value for upper bounds is required by the
         # gtk.Adjustment
         spin_max = 30 # seems like a high enough arbitrary number
-        #spin_max = self.cpu_cnt * 3
         hbox.pack_start(label, expand=False, fill=False, padding=6)
         bbadj = gtk.Adjustment(value=self.bbthread, lower=1, upper=spin_max, step_incr=1)
         bbspinner = gtk.SpinButton(adjustment=bbadj, climb_rate=1, digits=0)
diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index 105b0ef..7278643 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -962,9 +962,6 @@ class MainWindow (gtk.Window):
         return scroll
 
 def main (server, eventHandler):
-    import multiprocessing
-    cpu_cnt = multiprocessing.cpu_count()
-
     gobject.threads_init()
 
     taskmodel = TaskListModel()
@@ -979,14 +976,12 @@ def main (server, eventHandler):
     distro = server.runCommand(["getVariable", "DISTRO"])
     bbthread = server.runCommand(["getVariable", "BB_NUMBER_THREADS"])
     if not bbthread:
-        bbthread = cpu_cnt
-        handler.set_bbthreads(cpu_cnt)
+        bbthread = 1
     else:
         bbthread = int(bbthread)
     pmake = server.runCommand(["getVariable", "PARALLEL_MAKE"])
     if not pmake:
-        pmake = cpu_cnt
-        handler.set_pmake(cpu_cnt)
+        pmake = 1
     else:
         # The PARALLEL_MAKE variable will be of the format: "-j 3" and we only
         # want a number for the spinner, so strip everything from the variable
@@ -1012,7 +1007,7 @@ def main (server, eventHandler):
     build_headers = bool(server.runCommand(["getVariable", "HOB_BUILD_TOOLCHAIN_HEADERS"]))
     handler.toggle_toolchain_headers(build_headers)
 
-    prefs = HobPrefs(configurator, handler, sdk_mach, distro, pclass, cpu_cnt,
+    prefs = HobPrefs(configurator, handler, sdk_mach, distro, pclass,
                      pmake, bbthread, selected_image_types, all_image_types,
                      gplv3disabled, build_toolchain, build_headers)
     layers = LayerEditor(configurator, None)
-- 
1.7.6



