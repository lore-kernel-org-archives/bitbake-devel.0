Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id E68A6731F7
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Aug 2016 11:18:48 +0000 (UTC)
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by orsmga102.jf.intel.com with ESMTP; 23 Aug 2016 04:18:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,565,1464678000"; 
   d="scan'208";a="841404"
Received: from linux.intel.com ([10.54.29.200])
	by fmsmga005.fm.intel.com with ESMTP; 23 Aug 2016 04:18:48 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.68])
	by linux.intel.com (Postfix) with ESMTP id E75CB6A4006;
	Tue, 23 Aug 2016 04:18:29 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 23 Aug 2016 14:18:26 +0300
Message-Id: <1471951106-1316-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH] buildinfohelper: discover kernel artifacts correctly
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
X-List-Received-Date: Tue, 23 Aug 2016 11:18:49 -0000

From: Elliot Smith <elliot.smith@intel.com>

Because some image_license.manifest files contain multiple
FILES lines, and because those lines can sometimes not contain
a list of files (i.e. they look like "FILES:\n"), we were
resetting the list of kernel artifacts when we hit the second
"empty" line.

Fix by ignoring any FILES line which doesn't list files, and by
appending any files found in a valid FILES line, rather than
overwriting the existing list.

[YOCTO #10107]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index 7a16ec6..0f09b5c 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -1616,7 +1616,10 @@ class BuildInfoHelper(object):
                 if line.startswith('FILES'):
                     files_str = line.split(':')[1].strip()
                     files_str = re.sub(r' {2,}', ' ', files_str)
-                    files = files_str.split(' ')
+
+                    # ignore lines like "FILES:" with no filenames
+                    if files_str:
+                        files += files_str.split(' ')
         return files
 
     def _endswith(self, str_to_test, endings):
@@ -1734,9 +1737,9 @@ class BuildInfoHelper(object):
                 real_image_name,
                 'image_license.manifest')
 
-            # if image_license.manifest exists, we can read the names of bzImage
-            # and modules files for this build from it, then look for them
-            # in the DEPLOY_DIR_IMAGE; note that this file is only produced
+            # if image_license.manifest exists, we can read the names of
+            # bzImage, modules etc. files for this build from it, then look for
+            # them in the DEPLOY_DIR_IMAGE; note that this file is only produced
             # if an image file was produced
             if os.path.isfile(image_license_manifest_path):
                 has_files = True
-- 
2.1.4


