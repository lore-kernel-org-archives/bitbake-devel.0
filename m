Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1RDg6G-0007C3-8J
	for bitbake-devel@lists.openembedded.org;
	Tue, 11 Oct 2011 19:26:45 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 11 Oct 2011 10:20:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,524,1312182000"; d="scan'208";a="72439801"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.15.64])
	by fmsmga001.fm.intel.com with ESMTP; 11 Oct 2011 10:20:56 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 11 Oct 2011 10:20:50 -0700
Message-Id: <db59297aa1861614ffaea4295b9b054baa8a12b9.1318353511.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6.4
In-Reply-To: <cover.1318353511.git.josh@linux.intel.com>
References: <cover.1318353511.git.josh@linux.intel.com>
In-Reply-To: <cover.1318353511.git.josh@linux.intel.com>
References: <cover.1318353511.git.josh@linux.intel.com>
Subject: [PATCH 1/1] hob: fix backtrace when dismissing open dialog
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
X-List-Received-Date: Tue, 11 Oct 2011 17:26:46 -0000

Clearly a logic/indentation error - we should only try and load the recipe
should the file-chooser return OK.

Fixes [YOCTO #1668]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/hob.py |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index 71ea88a..0fcaad5 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -400,9 +400,9 @@ class MainWindow (gtk.Window):
         if response == gtk.RESPONSE_OK:
             rep.loadRecipe(recipe)
             self.save_path = recipe
+            self.model.load_image_rep(rep)
+            self.dirty = False
         chooser.destroy()
-        self.model.load_image_rep(rep)
-        self.dirty = False
 
     def bake_clicked_cb(self, button):
         build_image = True
-- 
1.7.6.4



