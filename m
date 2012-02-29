Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S2k7w-00056u-4h
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Feb 2012 15:03:32 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 29 Feb 2012 05:55:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="112764320"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by azsmga001.ch.intel.com with ESMTP; 29 Feb 2012 05:55:02 -0800
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 29 Feb 2012 22:14:59 +0800
Message-Id: <1f142038e9be9490df21a5cd4c14c579ca63a896.1330523904.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
In-Reply-To: <cover.1330523904.git.shane.wang@intel.com>
References: <cover.1330523904.git.shane.wang@intel.com>
Subject: [PATCH 02/32] Hob: avoid the image selection dialog to walk through all directories and its sub-directories, when users click "My images".
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
X-List-Received-Date: Wed, 29 Feb 2012 14:03:32 -0000

The current implementation of the image selection dialog walks through all directories and its sub-directories, when users click "My images" to choose a directory. If the directory is /, the system becomes slow. This patch is to avoid walking through all directories but the child directories only, given a directory.

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hig.py |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index 8f4f7cd..9aa6fdf 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -582,6 +582,7 @@ class ImageSelectionDialog (gtk.Dialog):
 
         self.image_folder = image_folder
         self.image_types  = image_types
+        self.image_list = []
         self.image_names = []
 
         # create visual elements on the dialog
@@ -645,13 +646,17 @@ class ImageSelectionDialog (gtk.Dialog):
         dialog.destroy()
 
     def fill_image_store(self):
+        self.image_list = []
         self.image_store.clear()
         imageset = set()
         for root, dirs, files in os.walk(self.image_folder):
+            # ignore the sub directories
+            dirs[:] = []
             for f in files:
                 for image_type in self.image_types:
                     if f.endswith('.' + image_type):
                         imageset.add(f.rsplit('.' + image_type)[0])
+                        self.image_list.append(f)
         
         for image in imageset:
             self.image_store.set(self.image_store.append(), 0, image, 1, False)
@@ -665,9 +670,8 @@ class ImageSelectionDialog (gtk.Dialog):
             while iter:
                 path = self.image_store.get_path(iter)
                 if self.image_store[path][1]:
-                    for root, dirs, files in os.walk(self.image_folder):
-                        for f in files:
-                            if f.startswith(self.image_store[path][0] + '.'):
-                                self.image_names.append(f)
+                    for f in self.image_list:
+                        if f.startswith(self.image_store[path][0] + '.'):
+                            self.image_names.append(f)
                     break            
                 iter = self.image_store.iter_next(iter)
-- 
1.7.6



