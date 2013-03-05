Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei.adrianx.dinu@intel.com>) id 1UCuBo-0003ft-6I
	for bitbake-devel@lists.openembedded.org;
	Tue, 05 Mar 2013 16:54:05 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 05 Mar 2013 07:34:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,787,1355126400"; d="scan'208";a="271343714"
Received: from adinu-vostro-460 (HELO localhost.localdomain) ([10.237.105.45])
	by orsmga001.jf.intel.com with ESMTP; 05 Mar 2013 07:36:25 -0800
From: Andrei Dinu <andrei.adrianx.dinu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  5 Mar 2013 17:36:29 +0200
Message-Id: <1362497791-30020-10-git-send-email-andrei.adrianx.dinu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1362497791-30020-1-git-send-email-andrei.adrianx.dinu@intel.com>
References: <1362497791-30020-1-git-send-email-andrei.adrianx.dinu@intel.com>
Subject: [PATCH 09/11] added information so that it displays correctly
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
X-List-Received-Date: Tue, 05 Mar 2013 15:54:07 -0000

in the information dialogs.

Signed-off-by: Andrei Dinu <andrei.adrianx.dinu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index 615b544..c018d70 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -198,8 +198,7 @@ class ImageConfigurationPage (HobPage):
         markup += "For more on layers, check the <a href=\""
         markup += "http://www.yoctoproject.org/docs/current/dev-manual/"
         markup += "dev-manual.html#understanding-and-using-layers\">reference manual</a>."
-        self.layer_info_icon = HobInfoButton(markup, self.get_parent())
-
+        self.layer_info_icon = HobInfoButton("<b>Layers</b>" + "*" + markup, self.get_parent())
 #        self.progress_box = gtk.HBox(False, 6)
         self.progress_bar = HobProgressBar()
 #        self.progress_box.pack_start(self.progress_bar, expand=True, fill=True)
-- 
1.7.9.5



