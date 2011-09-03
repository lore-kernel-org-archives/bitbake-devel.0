Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qze0Y-0008Rq-Ci
	for bitbake-devel@lists.openembedded.org;
	Sat, 03 Sep 2011 02:22:50 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 02 Sep 2011 17:17:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,321,1312182000"; d="scan'208";a="47755006"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.9])
	by fmsmga001.fm.intel.com with ESMTP; 02 Sep 2011 17:17:49 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  2 Sep 2011 17:17:38 -0700
Message-Id: <9d48cd66c494b045c2207c9989fa1002737c1af6.1315008498.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1315008498.git.josh@linux.intel.com>
References: <cover.1315008498.git.josh@linux.intel.com>
In-Reply-To: <cover.1315008498.git.josh@linux.intel.com>
References: <cover.1315008498.git.josh@linux.intel.com>
Subject: [PATCH 3/6] hob: add a test to ensure hob is run with the required pre and post files
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
X-List-Received-Date: Sat, 03 Sep 2011 00:22:50 -0000

hob requires pre and post configuration files to store configuration values
in, whilst this should (and will) be fixed long-term for so long as we
require these files we should alert the user should they run without them.

Fixes [YOCTO #1383]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/hob.py |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index 022d1b6..3b0cacc 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -982,6 +982,27 @@ class MainWindow (gtk.Window):
 def main (server, eventHandler):
     gobject.threads_init()
 
+    # NOTE: For now we require that the user run with pre and post files to
+    # read and store configuration set in the GUI.
+    # We hope to adjust this long term as tracked in Yocto Bugzilla #1441
+    # http://bugzilla.pokylinux.org/show_bug.cgi?id=1441
+    reqfiles = 0
+    dep_files = server.runCommand(["getVariable", "__depends"]) or set()
+    dep_files.union(server.runCommand(["getVariable", "__base_depends"]) or set())
+    for f in dep_files:
+        if f[0].endswith("hob-pre.conf"):
+            reqfiles = reqfiles + 1
+        elif f[0].endswith("hob-post.conf"):
+            reqfiles = reqfiles + 1
+        if reqfiles == 2:
+            break
+    if reqfiles < 2:
+        print("""The hob UI requires a pre file named hob-pre.conf and a post
+file named hob-post.conf to store and read its configuration from. Please run
+hob with these files, i.e.\n
+\bitbake -u hob -r conf/hob-pre.conf -R conf/hob-post.conf""")
+        return
+
     taskmodel = TaskListModel()
     configurator = Configurator()
     handler = HobHandler(taskmodel, server)
-- 
1.7.6



