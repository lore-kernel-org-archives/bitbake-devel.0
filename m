Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S16gI-0007uz-PM
	for bitbake-devel@lists.openembedded.org;
	Sat, 25 Feb 2012 02:44:15 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 24 Feb 2012 17:34:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="110607563"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.15.27])
	by azsmga001.ch.intel.com with ESMTP; 24 Feb 2012 17:34:44 -0800
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 24 Feb 2012 17:34:39 -0800
Message-Id: <272afff66bd0ecabb4be6fc244773cb3d9b91aa8.1330133412.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <03fda55b89fdc2ddb45a7bc08015989fc0eccb91.1330133412.git.josh@linux.intel.com>
References: <03fda55b89fdc2ddb45a7bc08015989fc0eccb91.1330133412.git.josh@linux.intel.com>
In-Reply-To: <cover.1330133412.git.josh@linux.intel.com>
References: <cover.1330133412.git.josh@linux.intel.com>
Subject: [PATCH 2/6] crumbs/builder: use the name Hob consistently
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
X-List-Received-Date: Sat, 25 Feb 2012 01:44:15 -0000

We have mentions of HOB and Hob, the approved name is Hob.

"the name's Hob, BitBake Hob"
   - Surly BitBake GUI

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/builder.py |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index b52ba04..21e5021 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -222,7 +222,7 @@ class Builder(gtk.Window):
         self.switch_page(self.MACHINE_SELECTION)
 
     def create_visual_elements(self):
-        self.set_title("HOB -- Image Creator")
+        self.set_title("Hob - Image Creator")
         self.set_icon_name("applications-development")
         self.set_position(gtk.WIN_POS_CENTER_ALWAYS)
         self.set_resizable(True)
@@ -670,7 +670,7 @@ class Builder(gtk.Window):
                                       (gtk.STOCK_OPEN, gtk.RESPONSE_YES,
                                        gtk.STOCK_CANCEL, gtk.RESPONSE_NO))
         filter = gtk.FileFilter()
-        filter.set_name("HOB Files")
+        filter.set_name("Hob Files")
         filter.add_pattern("*.hob")
         dialog.add_filter(filter)
 
-- 
1.7.7.6



