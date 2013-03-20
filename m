Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1UIFPA-0001mf-Fj
	for bitbake-devel@lists.openembedded.org;
	Wed, 20 Mar 2013 10:33:57 +0100
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 20 Mar 2013 02:17:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,876,1355126400"; d="scan'208";a="216842712"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.151])
	by AZSMGA002.ch.intel.com with ESMTP; 20 Mar 2013 02:16:36 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 20 Mar 2013 11:21:39 +0200
Message-Id: <1363771299-17447-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: Hob custom image build error
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
X-List-Received-Date: Wed, 20 Mar 2013 09:33:59 -0000

For a custom image from scratch, the image version is not set and
it gives an error.

[YOCTO #4065]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index f6adabe..edff58c 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -1023,10 +1023,12 @@ class Builder(gtk.Window):
             fraction = 0.9
         elif self.current_step == self.IMAGE_GENERATING:
             fraction = 1.0
+            version = ""
             self.parameters.image_names = []
             selected_image = self.recipe_model.get_selected_image()
             if selected_image == self.recipe_model.__custom_image__:
-                version = self.recipe_model.get_custom_image_version()
+                if self.configuration.initial_selected_image != selected_image:
+                    version = self.recipe_model.get_custom_image_version()
                 linkname = 'hob-image' + version+ "-" + self.configuration.curr_mach
             else:
                 linkname = selected_image + '-' + self.configuration.curr_mach
-- 
1.7.9.5



