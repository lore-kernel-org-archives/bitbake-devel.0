Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SDahI-00034H-Rg
	for bitbake-devel@lists.openembedded.org;
	Fri, 30 Mar 2012 14:12:53 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 30 Mar 2012 05:03:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="125215029"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by azsmga001.ch.intel.com with ESMTP; 30 Mar 2012 05:03:48 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 30 Mar 2012 20:01:17 +0800
Message-Id: <f59dd76d23a5542e261f6a8eb45fa74706e99bf6.1333108781.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1333108781.git.dongxiao.xu@intel.com>
References: <cover.1333108781.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1333108781.git.dongxiao.xu@intel.com>
References: <cover.1333108781.git.dongxiao.xu@intel.com>
Subject: [PATCH 5/7] Hob: Remove some calling of initiate_new_build()
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
X-List-Received-Date: Fri, 30 Mar 2012 12:12:53 -0000

initiate_new_build() function is in async mode and could not be called
before another async function.

Also we could not initialize the build if user simply change a setting,
therefore remove this function.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/imagedetailspage.py |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/crumbs/imagedetailspage.py b/lib/bb/ui/crumbs/imagedetailspage.py
index b70440d..b12014a 100755
--- a/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/lib/bb/ui/crumbs/imagedetailspage.py
@@ -403,7 +403,6 @@ class ImageDetailsPage (HobPage):
         response, path = self.builder.show_load_template_dialog()
         if not response:
             return
-        self.builder.initiate_new_build()
         if path:
             self.builder.load_template(path)
 
@@ -415,6 +414,5 @@ class ImageDetailsPage (HobPage):
         response, settings_changed = self.builder.show_adv_settings_dialog()
         if not response:
             return
-        self.builder.initiate_new_build()
         if settings_changed:
             self.builder.reparse_post_adv_settings()
-- 
1.7.4.1



