Return-Path: <brian.avery@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id A05A973199
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Jul 2016 22:53:55 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 12 Jul 2016 15:53:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,354,1464678000"; d="scan'208";a="1015672948"
Received: from bavery-ws-desk.jf.intel.com ([10.7.201.28])
	by orsmga002.jf.intel.com with ESMTP; 12 Jul 2016 15:53:44 -0700
From: bavery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 12 Jul 2016 15:54:45 -0700
Message-Id: <e6f02a69237ea63d82021f8a30864e855ddaf1d4.1468363530.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <4551b56f132497c055f39567946a5d3be347d770.1468363530.git.brian.avery@intel.com>
References: <4551b56f132497c055f39567946a5d3be347d770.1468363530.git.brian.avery@intel.com>
In-Reply-To: <cover.1468363530.git.brian.avery@intel.com>
References: <cover.1468363530.git.brian.avery@intel.com>
Cc: bavery <brian.avery@intel.com>
Subject: [PATCH 04/17] toaster: improve image file suffix retrieval
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
X-List-Received-Date: Tue, 12 Jul 2016 22:53:55 -0000

From: Elliot Smith <elliot.smith@intel.com>

Refactor retrieval of suffix from image file path, making it a
a method on Target_Image_File. This makes it easier to use this
in the build dashboard for individual images, plus reduces the
complexity of the code required to get all of the image file
suffixes for a build.

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: bavery <brian.avery@intel.com>
---
 lib/toaster/orm/models.py | 48 +++++++++++------------------------------------
 1 file changed, 11 insertions(+), 37 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 61737c7..40cdb9e 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -440,51 +440,21 @@ class Build(models.Model):
         """
         Get list of file name extensions for images produced by this build
         """
-        targets = Target.objects.filter(build_id = self.id)
         extensions = []
 
-        # pattern to match against file path for building extension string
-        pattern = re.compile('\.([^\.]+?)$')
-
+        targets = Target.objects.filter(build_id = self.id)
         for target in targets:
             if (not target.is_image):
                 continue
 
-            target_image_files = Target_Image_File.objects.filter(target_id = target.id)
+            target_image_files = Target_Image_File.objects.filter(
+                target_id=target.id)
 
             for target_image_file in target_image_files:
-                file_name = os.path.basename(target_image_file.file_name)
-                suffix = ''
-
-                continue_matching = True
-
-                # incrementally extract the suffix from the file path,
-                # checking it against the list of valid suffixes at each
-                # step; if the path is stripped of all potential suffix
-                # parts without matching a valid suffix, this returns all
-                # characters after the first '.' in the file name
-                while continue_matching:
-                    matches = pattern.search(file_name)
-
-                    if None == matches:
-                        continue_matching = False
-                        suffix = re.sub('^\.', '', suffix)
-                        continue
-                    else:
-                        suffix = matches.group(1) + suffix
-
-                    if suffix in Target_Image_File.SUFFIXES:
-                        continue_matching = False
-                        continue
-                    else:
-                        # reduce the file name and try to find the next
-                        # segment from the path which might be part
-                        # of the suffix
-                        file_name = re.sub('.' + matches.group(1), '', file_name)
-                        suffix = '.' + suffix
-
-                if not suffix in extensions:
-                    extensions.append(suffix)
+                extensions.append(target_image_file.suffix)
+
+        extensions = list(set(extensions))
+        extensions.sort()
 
         return ', '.join(extensions)
 
@@ -658,6 +628,10 @@ class Target_Image_File(models.Model):
 
     @property
     def suffix(self):
+        for suffix in Target_Image_File.SUFFIXES:
+            if self.file_name.endswith(suffix):
+                return suffix
+
         filename, suffix = os.path.splitext(self.file_name)
         suffix = suffix.lstrip('.')
         return suffix
-- 
1.9.1


