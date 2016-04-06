Return-Path: <elliot.smith@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id BD5197017C
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 12:50:28 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 06 Apr 2016 05:50:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,447,1455004800"; d="scan'208";a="939482125"
Received: from lmcenteg-mobl4.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.21.33])
	by fmsmga001.fm.intel.com with ESMTP; 06 Apr 2016 05:50:28 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Apr 2016 13:50:23 +0100
Message-Id: <1459947023-779-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Cc: Joshua Lock <joshua.g.lock@intel.com>
Subject: [PATCH] buildinfohelper: work around unicode exceptions
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
X-List-Received-Date: Wed, 06 Apr 2016 12:50:31 -0000

From: Joshua Lock <joshua.g.lock@intel.com>

We have been seeing UnicodeDecodeErrors when handling the
ImagePkgList MetadataEvent in ORMWrapper's
save_target_file_information() if the event includes filenames
that include non-ASCII characters.

In the short term work around this by converting paths to the
unicode type when passing them to Django's ORM. This is a bit of
a hack but it's too late in the cycle to do anything more invasive.

[YOCTO #9142]

Signed-off-by: Joshua Lock <joshua.g.lock@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index ed43f4c..c211ec6 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -483,7 +483,7 @@ class ORMWrapper(object):
             parent_obj = self._cached_get(Target_File, target = target_obj, path = parent_path, inodetype = Target_File.ITYPE_DIRECTORY)
             tf_obj = Target_File.objects.create(
                         target = target_obj,
-                        path = path,
+                        path = unicode(path, 'utf-8'),
                         size = size,
                         inodetype = Target_File.ITYPE_DIRECTORY,
                         permission = permission,
@@ -508,7 +508,7 @@ class ORMWrapper(object):
 
             tf_obj = Target_File.objects.create(
                         target = target_obj,
-                        path = path,
+                        path = unicode(path, 'utf-8'),
                         size = size,
                         inodetype = inodetype,
                         permission = permission,
@@ -539,7 +539,9 @@ class ORMWrapper(object):
                 filetarget_path = "/".join(fcpl)
 
             try:
-                filetarget_obj = Target_File.objects.get(target = target_obj, path = filetarget_path)
+                filetarget_obj = Target_File.objects.get(
+                                     target = target_obj,
+                                     path = unicode(filetarget_path, 'utf-8'))
             except Target_File.DoesNotExist:
                 # we might have an invalid link; no way to detect this. just set it to None
                 filetarget_obj = None
@@ -548,7 +550,7 @@ class ORMWrapper(object):
 
             tf_obj = Target_File.objects.create(
                         target = target_obj,
-                        path = path,
+                        path = unicode(path, 'utf-8'),
                         size = size,
                         inodetype = Target_File.ITYPE_SYMLINK,
                         permission = permission,
-- 
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


