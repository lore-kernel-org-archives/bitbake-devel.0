Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QuDeG-0005Bu-4D
	for bitbake-devel@lists.openembedded.org;
	Fri, 19 Aug 2011 03:13:24 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 18 Aug 2011 18:08:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,248,1312182000"; d="scan'208";a="40058942"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.250])
	by azsmga001.ch.intel.com with ESMTP; 18 Aug 2011 18:08:40 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 18 Aug 2011 18:08:22 -0700
Message-Id: <3d78e62d03cb920d1cb6fe8d666a79e6e2e2ad6a.1313715804.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1313715804.git.josh@linux.intel.com>
References: <cover.1313715804.git.josh@linux.intel.com>
In-Reply-To: <cover.1313715804.git.josh@linux.intel.com>
References: <cover.1313715804.git.josh@linux.intel.com>
Subject: [PATCH 08/11] bb/ui/hob: fix package only build
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
X-List-Received-Date: Fri, 19 Aug 2011 01:13:24 -0000

Use the models new get_selected_pn method to return a list of PN's for the
selected items and pass that for a package only build, rather than passing
a list of package names (which buildTargets can't handle).

Fixes [YOCTO #1385]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/hob.py |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index 0230dda..e02f48c 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -174,6 +174,7 @@ class MainWindow (gtk.Window):
             self.toggle_package(path, model, image=True)
             if len(userp):
                 self.model.set_selected_packages(userp)
+            self.selected_image = model[path][self.model.COL_NAME]
 
     def reload_triggered_cb(self, handler, image, packages):
         if image:
@@ -451,7 +452,7 @@ class MainWindow (gtk.Window):
 
             self.handler.build_image(image_name, self.configurator)
         else:
-            self.handler.build_packages(rep.allpkgs.split(" "))
+            self.handler.build_packages(self.model.get_selected_pn())
 
         self.nb.set_current_page(1)
 
-- 
1.7.6



