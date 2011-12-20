Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1Rczee-0002YC-2A
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Dec 2011 14:22:56 +0100
Received: by opal (Postfix, from userid 111)
	id 5DC4510335; Tue, 20 Dec 2011 13:21:28 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20111220132128.5DC4510335@opal>
Date: Tue, 20 Dec 2011 13:21:28 +0000 (UTC)
From: git@git.openembedded.org
Subject: Joshua Lock : ui/crumbs/hobprefs: trigger a reparse after changing IMAGE_FSTYPES
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
X-List-Received-Date: Tue, 20 Dec 2011 13:22:56 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 6c0babf08909307ab69a66ed06e77e8818b2a8c5
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=6c0babf08909307ab69a66ed06e77e8818b2a8c5

Author: Joshua Lock <josh@linux.intel.com>
Date:   Tue Dec 13 14:45:42 2011 -0800

ui/crumbs/hobprefs: trigger a reparse after changing IMAGE_FSTYPES

As reported on the mailing list[1] when changing IMAGE_FSTYPES through the
hob preferences a reparse is required before the changes will be picked up
by the system. This patch sets the reload_required property of the class to
true when the image types have been modified to ensure the reparse is
triggered.

1. https://lists.yoctoproject.org/pipermail/yocto/2011-December/006002.html

Signed-off-by: Joshua Lock <josh@linux.intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/ui/crumbs/hobprefs.py |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobprefs.py b/lib/bb/ui/crumbs/hobprefs.py
index 5dfb0e6..3f6f128 100644
--- a/lib/bb/ui/crumbs/hobprefs.py
+++ b/lib/bb/ui/crumbs/hobprefs.py
@@ -39,6 +39,7 @@ class HobPrefs(gtk.Dialog):
             self.selected_image_types = handler.remove_image_output_type(ot)
 
         self.configurator.setConfVar('IMAGE_FSTYPES', "%s" % " ".join(self.selected_image_types).lstrip(" "))
+        self.reload_required = True
 
     def sdk_machine_combo_changed_cb(self, combo, handler):
         sdk_mach = combo.get_active_text()



