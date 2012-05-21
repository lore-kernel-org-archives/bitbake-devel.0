Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1SWTv3-0000R9-0t
	for bitbake-devel@lists.openembedded.org;
	Mon, 21 May 2012 16:49:09 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 21 May 2012 07:39:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="146430796"
Received: from hp.sh.intel.com ([10.239.47.6])
	by orsmga002.jf.intel.com with ESMTP; 21 May 2012 07:39:01 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 21 May 2012 22:41:24 +0800
Message-Id: <b57883e090aaf1ecc3b792f7deceb01c2a802177.1337610738.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <be9df903825ec31825cd12c0d5d20d0ca0e8d88a.1337610738.git.limingx.l.an@intel.com>
References: <be9df903825ec31825cd12c0d5d20d0ca0e8d88a.1337610738.git.limingx.l.an@intel.com>
In-Reply-To: <cover.1337610738.git.limingx.l.an@intel.com>
References: <cover.1337610738.git.limingx.l.an@intel.com>
Subject: [PATCH 5/5] Hob: fixed the issue about the 'run image' page should have the primary bug
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
X-List-Received-Date: Mon, 21 May 2012 14:49:09 -0000

issues: when build a image for atom-pc, the output does not include live
image, and 'Save as template' should become the primary action on the screen

[YOCTO 2326]

Signed-off-by: Liming An <limingx.l.an@intel.com>
---
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index f517544..1538376 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -202,7 +202,7 @@ class ImageDetailsPage (HobPage):
 
         # Name
         self.image_store.clear()
-        default_toggled = False
+        default_toggled = ""
         default_image_size = 0
         num_toggled = 0
         i = 0
@@ -212,18 +212,20 @@ class ImageDetailsPage (HobPage):
                 or self.test_deployable(image_name)
 
             if not default_toggled:
-                default_toggled = is_toggled
                 if i == (len(image_names) - 1):
-                    default_toggled = True
-                self.image_store.set(self.image_store.append(), 0, image_name, 1, image_size, 2, default_toggled)
-                if default_toggled:
+                    is_toggled = True
+                self.image_store.set(self.image_store.append(), 0, image_name, 1, image_size, 2, is_toggled)
+                if is_toggled:
                     default_image_size = image_size
-                    self.create_bottom_buttons(self.buttonlist, image_name)
+                    default_toggled = image_name
+
             else:
                 self.image_store.set(self.image_store.append(), 0, image_name, 1, image_size, 2, False)
             i = i + 1
             num_toggled += is_toggled
 
+        self.create_bottom_buttons(self.buttonlist, default_toggled)
+
         if build_succeeded and (num_toggled < 2):
             varlist = ["Name: ", "Directory: "]
             vallist = []
-- 
1.7.5.4



