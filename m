Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1TL9Oh-0001XT-SQ
	for bitbake-devel@lists.openembedded.org;
	Mon, 08 Oct 2012 11:13:12 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 08 Oct 2012 02:00:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,551,1344236400"; d="scan'208";a="231162690"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by fmsmga001.fm.intel.com with ESMTP; 08 Oct 2012 02:00:03 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  8 Oct 2012 12:01:19 +0300
Message-Id: <1349686879-25765-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob/imageconfigurationpage: a 'hob-image' appears listed in the base image combo box
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
X-List-Received-Date: Mon, 08 Oct 2012 09:13:12 -0000

-remove this image from image combo box

[YOCTO #3230]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index e1c7a67..32e5c45 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -368,6 +368,7 @@ class ImageConfigurationPage (HobPage):
         if self.builder.parameters.image_black_pattern:
             for i in self.builder.parameters.image_black_pattern.split():
                 black_pattern.append(re.compile(i))
+        black_pattern.append("hob-image")
 
         it = image_model.get_iter_first()
         self._image_combo_disconnect_signal()
@@ -386,13 +387,13 @@ class ImageConfigurationPage (HobPage):
             if black_pattern:
                 allow = True
                 for pattern in black_pattern:
-                    if pattern.search(image_name):
+                    if image_name in pattern:
                         allow = False
                         break
             elif white_pattern:
                 allow = False
                 for pattern in white_pattern:
-                    if pattern.search(image_name):
+                    if image_name in pattern:
                         allow = True
                         break
             else:
-- 
1.7.9.5



