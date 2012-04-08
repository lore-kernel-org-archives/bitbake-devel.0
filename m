Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SGpI2-0004su-Ry
	for bitbake-devel@lists.openembedded.org;
	Sun, 08 Apr 2012 12:24:11 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 08 Apr 2012 03:14:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="151167352"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by fmsmga002.fm.intel.com with ESMTP; 08 Apr 2012 03:14:54 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun,  8 Apr 2012 18:21:21 +0800
Message-Id: <60deafc1defbfbfc18bbdcb1a5366786f8a58e32.1333880210.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <0858ca0732e2d6a66b84e97150a750714ae806c9.1333880210.git.shane.wang@intel.com>
References: <0858ca0732e2d6a66b84e97150a750714ae806c9.1333880210.git.shane.wang@intel.com>
In-Reply-To: <cover.1333880210.git.shane.wang@intel.com>
References: <cover.1333880210.git.shane.wang@intel.com>
Subject: [PATCH 18/20] Hob: tooltip change for "Build image" button
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
X-List-Received-Date: Sun, 08 Apr 2012 10:24:11 -0000

[Yocto #2242]

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
index 8391e29..923f53b 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -131,7 +131,7 @@ class PackageSelectionPage (HobPage):
 
         self.build_image_button = HobButton('Build image')
         self.build_image_button.set_size_request(205, 49)
-        self.build_image_button.set_tooltip_text("Build image to get your target image")
+        self.build_image_button.set_tooltip_text("Build target image")
         self.build_image_button.set_flags(gtk.CAN_DEFAULT)
         self.build_image_button.grab_default()
         self.build_image_button.connect("clicked", self.build_image_clicked_cb)
-- 
1.7.6



