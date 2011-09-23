Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1R7CXT-0007fl-1w
	for bitbake-devel@lists.openembedded.org;
	Fri, 23 Sep 2011 22:40:03 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 23 Sep 2011 13:34:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,432,1312182000"; d="scan'208";a="66944249"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.15.15])
	by fmsmga001.fm.intel.com with ESMTP; 23 Sep 2011 13:34:40 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 23 Sep 2011 13:34:31 -0700
Message-Id: <109e1597671dfb7222672e268190aabc727960ca.1316809959.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6.2
In-Reply-To: <cover.1316809959.git.josh@linux.intel.com>
References: <cover.1316809959.git.josh@linux.intel.com>
In-Reply-To: <cover.1316809959.git.josh@linux.intel.com>
References: <cover.1316809959.git.josh@linux.intel.com>
Subject: [PATCH 1/3] ui/crumbs/hobeventhandler: move remaining getVariable calls to init
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
X-List-Received-Date: Fri, 23 Sep 2011 20:40:03 -0000

Instead of calling getVariable commands each time the BBPATH and BBFILES
entries need testing cache the results as a member variable at object
instantiation.

Fixes [YOCTO #1521]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hobeventhandler.py |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index 30504e1..44dc4ac 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -88,6 +88,8 @@ class HobHandler(gobject.GObject):
         deploy_dir = self.server.runCommand(["getVariable", "DEPLOY_DIR"])
         self.image_out_dir = os.path.join(deploy_dir, "images")
         self.image_output_types = self.server.runCommand(["getVariable", "IMAGE_FSTYPES"]).split(" ")
+        self.bbpath = self.server.runCommand(["getVariable", "BBPATH"])
+        self.bbfiles = self.server.runCommand(["getVariable", "BBFILES"])
 
     def run_next_command(self):
         if self.current_command and not self.generating:
@@ -263,8 +265,7 @@ class HobHandler(gobject.GObject):
         self.build_queue = targets
 
         if not self.bbpath_ok:
-            bbpath = self.server.runCommand(["getVariable", "BBPATH"])
-            if self.image_dir in bbpath.split(":"):
+            if self.image_dir in self.bbpath.split(":"):
                 self.bbpath_ok = True
             else:
                 nbbp = self.image_dir
@@ -272,8 +273,8 @@ class HobHandler(gobject.GObject):
         if not self.bbfiles_ok:
             import re
             pattern = "%s/\*.bb" % self.image_dir
-            bbfiles = self.server.runCommand(["getVariable", "BBFILES"]).split(" ")
-            for files in bbfiles:
+
+            for files in self.bbfiles.split(" "):
                 if re.match(pattern, files):
                     self.bbfiles_ok = True
 
-- 
1.7.6.2



