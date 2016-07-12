Return-Path: <brian.avery@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id DCAAA731D6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Jul 2016 22:53:55 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 12 Jul 2016 15:53:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,354,1464678000"; d="scan'208";a="1015672961"
Received: from bavery-ws-desk.jf.intel.com ([10.7.201.28])
	by orsmga002.jf.intel.com with ESMTP; 12 Jul 2016 15:53:44 -0700
From: bavery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 12 Jul 2016 15:54:49 -0700
Message-Id: <81d5999408e36050023b3dc1e1619572e0416816.1468363530.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <4551b56f132497c055f39567946a5d3be347d770.1468363530.git.brian.avery@intel.com>
References: <4551b56f132497c055f39567946a5d3be347d770.1468363530.git.brian.avery@intel.com>
In-Reply-To: <cover.1468363530.git.brian.avery@intel.com>
References: <cover.1468363530.git.brian.avery@intel.com>
Cc: bavery <brian.avery@intel.com>
Subject: [PATCH 08/17] buildinfohelper: only record image files for tasks which make images
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
X-List-Received-Date: Tue, 12 Jul 2016 22:53:56 -0000

From: Elliot Smith <elliot.smith@intel.com>

If a target is built which is classified as an "image" target
(e.g. "core-image-minimal"), Toaster reads the list of files in
the image (from the files-in-image.txt file).

However, Toaster continues to do this for builds which don't
produce images, if the recipe providing the target is an
image recipe. This can result in a list of files in the image
being attached to a target which didn't produce an image (e.g.
rootfs).

When associating files with an image, ensure that only targets
with a task which produces an image have "files in the image"
associated with them.

[YOCTO #9784]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: bavery <brian.avery@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index bf032ae..52b5e12 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -875,6 +875,11 @@ class BuildInfoHelper(object):
         Keeps in memory all data that needs matching before writing it to the database
     """
 
+    # tasks which produce image files; note we include '', as we set
+    # the task for a target to '' (i.e. 'build') if no target is
+    # explicitly defined
+    IMAGE_GENERATING_TASKS = ['', 'build', 'image', 'populate_sdk_ext']
+
     # pylint: disable=protected-access
     # the code will look into the protected variables of the event; no easy way around this
     # pylint: disable=bad-continuation
@@ -1235,11 +1240,16 @@ class BuildInfoHelper(object):
                     logger.warning("KeyError in save_target_package_information"
                                    "%s ", e)
 
-                try:
-                    self.orm_wrapper.save_target_file_information(self.internal_state['build'], target, filedata)
-                except KeyError as e:
-                    logger.warning("KeyError in save_target_file_information"
-                                   "%s ", e)
+                # only try to find files in the image if the task for this
+                # target is one which produces image files; otherwise, the old
+                # list of files in the files-in-image.txt file will be
+                # appended to the target even if it didn't produce any images
+                if target.task in BuildInfoHelper.IMAGE_GENERATING_TASKS:
+                    try:
+                        self.orm_wrapper.save_target_file_information(self.internal_state['build'], target, filedata)
+                    except KeyError as e:
+                        logger.warning("KeyError in save_target_file_information"
+                                       "%s ", e)
 
 
 
-- 
1.9.1


