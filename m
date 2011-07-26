Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qlmiq-0003hd-HK
	for bitbake-devel@lists.openembedded.org;
	Tue, 26 Jul 2011 20:51:16 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 26 Jul 2011 11:46:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,270,1309762800"; d="scan'208";a="30353977"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.155])
	by orsmga002.jf.intel.com with ESMTP; 26 Jul 2011 11:46:53 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 26 Jul 2011 11:46:39 -0700
Message-Id: <105bfe3562235fb586be4b4179bb34b2e94ef234.1311705833.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1311705833.git.josh@linux.intel.com>
References: <cover.1311705833.git.josh@linux.intel.com>
In-Reply-To: <cover.1311705833.git.josh@linux.intel.com>
References: <cover.1311705833.git.josh@linux.intel.com>
Subject: [PATCH 05/10] ui/hob: change wording in build complete dialog
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
X-List-Received-Date: Tue, 26 Jul 2011 18:51:18 -0000

The 'View Log' button is potentially confusing to existing users of the
system who may be expecting to be shown the on disk logs of the build.
Instead use 'View Messages'.

Addresses [YOCTO #1222]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/hob.py |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index e0380dd..df0ebe2 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -411,13 +411,13 @@ class MainWindow (gtk.Window):
         for f in self.files_to_clean:
             os.remove(f)
 
-        lbl = "<b>Build completed</b>\n\nClick 'Edit Image' to start another build or 'View Log' to view the build log."
+        lbl = "<b>Build completed</b>\n\nClick 'Edit Image' to start another build or 'View Messages' to view the messages output during the build."
         if self.handler.building == "image" and self.build_succeeded:
             deploy = self.handler.get_image_deploy_dir()
             lbl = lbl + "\n<a href=\"file://%s\" title=\"%s\">Browse folder of built images</a>." % (deploy, deploy)
 
         dialog = CrumbsDialog(self, lbl)
-        dialog.add_button("View Log", gtk.RESPONSE_CANCEL)
+        dialog.add_button("View Messages", gtk.RESPONSE_CANCEL)
         dialog.add_button("Edit Image", gtk.RESPONSE_OK)
         response = dialog.run()
         dialog.destroy()
-- 
1.7.6



