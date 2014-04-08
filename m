Return-Path: <irina.patru@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id DA7FB65D89
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Apr 2014 11:55:09 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 08 Apr 2014 04:50:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,817,1389772800"; d="scan'208";a="489210922"
Received: from irina-vostro-460.rb.intel.com ([10.237.105.165])
	by orsmga001.jf.intel.com with ESMTP; 08 Apr 2014 04:55:09 -0700
From: Irina Patru <irina.patru@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  8 Apr 2014 14:59:30 +0300
Message-Id: <1396958370-23653-1-git-send-email-irina.patru@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: add "recipes/images/" to BBFILES when Hob is launched
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
X-List-Received-Date: Tue, 08 Apr 2014 11:55:10 -0000

The path for "recipes/images/" was not added in BBFILES when Hob had
to search for an image recipe. Therefore, it could not find it and an
error occurred.
This path needs to be added when Hob is launched.

[HOB #6086]

Signed-off-by: Irina Patru <irina.patru@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py         |    1 +
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 3033e77..455af32 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -447,6 +447,7 @@ class Builder(gtk.Window):
         self.handler.connect("package-populated",        self.handler_package_populated_cb)
 
         self.handler.append_to_bbfiles("${TOPDIR}/recipes/images/custom/*.bb")
+        self.handler.append_to_bbfiles("${TOPDIR}/recipes/images/*.bb")
         self.initiate_new_build_async()
 
         signal.signal(signal.SIGINT, self.event_handle_SIGINT)
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 62c4704..43edb70 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -461,7 +461,6 @@ class HobHandler(gobject.GObject):
         recipe_name = hob_image + ".bb"
         self.ensure_dir(image_dir)
         self.generate_new_image(image_dir + recipe_name, None, [], "")
-        self.append_to_bbfiles(image_dir + "*.bb")
 
     def ensure_dir(self, directory):
         self.runCommand(["ensureDir", directory])
-- 
1.7.9.5


