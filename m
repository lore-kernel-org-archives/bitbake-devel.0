Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SEini-0005fz-D7
	for bitbake-devel@lists.openembedded.org;
	Mon, 02 Apr 2012 17:04:10 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 02 Apr 2012 07:55:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="136617150"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2012 07:55:02 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  2 Apr 2012 23:22:39 +0800
Message-Id: <9139433c0ccc1c574c96ba6060398fb7343c0f20.1333379931.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <7ef65b5d1a00fe42d39be41ddd93fc75ade17308.1333379931.git.shane.wang@intel.com>
References: <7ef65b5d1a00fe42d39be41ddd93fc75ade17308.1333379931.git.shane.wang@intel.com>
In-Reply-To: <cover.1333379931.git.shane.wang@intel.com>
References: <cover.1333379931.git.shane.wang@intel.com>
Subject: [PATCH 3/4] Hob: remove grab_default() for deploy button
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
X-List-Received-Date: Mon, 02 Apr 2012 15:04:10 -0000

When the deploy button is disabled since there is no deployable image,
the console will show the warning message:

WARNING: /home/yocto-build5/poky-contrib/bitbake/lib/bb/ui/crumbs/imagedetailspage.py:333:
GtkWarning: /build/buildd/gtk+2.0-2.22.0/gtk/gtkwidget.c:5684: widget not within a GtkWindow
  self.deploy_button.grab_default()

This patch is to remove the warning message.

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index 39ccfdc..1cac6b2 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -330,7 +330,6 @@ class ImageDetailsPage (HobPage):
             self.deploy_button.set_size_request(205, 49)
             self.deploy_button.set_tooltip_text("Deploy image to get your target board")
             self.deploy_button.set_flags(gtk.CAN_DEFAULT)
-            self.deploy_button.grab_default()
             self.deploy_button.connect("clicked", self.deploy_button_clicked_cb)
             bottom_buttons.pack_end(self.deploy_button, expand=False, fill=False)
             created = True
-- 
1.7.6



