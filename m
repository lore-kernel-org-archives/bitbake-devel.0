Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1TLAOQ-0004xl-PH
	for bitbake-devel@lists.openembedded.org;
	Mon, 08 Oct 2012 12:16:59 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 08 Oct 2012 03:03:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,551,1344236400"; d="scan'208";a="153640623"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by AZSMGA002.ch.intel.com with ESMTP; 08 Oct 2012 03:03:49 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  8 Oct 2012 13:05:06 +0300
Message-Id: <1349690706-26574-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH v2] hob/imageconfigurationpage: a 'hob-image' appears listed in the base image combo box
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
X-List-Received-Date: Mon, 08 Oct 2012 10:16:59 -0000

-remove this image from image combo box

[YOCTO #3230]

Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index e1c7a67..8988df0 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -368,6 +368,7 @@ class ImageConfigurationPage (HobPage):
         if self.builder.parameters.image_black_pattern:
             for i in self.builder.parameters.image_black_pattern.split():
                 black_pattern.append(re.compile(i))
+        black_pattern.append(re.compile("hob-image"))
 
         it = image_model.get_iter_first()
         self._image_combo_disconnect_signal()
-- 
1.7.9.5



