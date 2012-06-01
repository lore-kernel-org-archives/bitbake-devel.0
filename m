Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1SaPPE-00063D-Hg
	for bitbake-devel@lists.openembedded.org;
	Fri, 01 Jun 2012 12:48:32 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 01 Jun 2012 03:38:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="159498972"
Received: from hp.sh.intel.com ([10.239.47.6])
	by fmsmga001.fm.intel.com with ESMTP; 01 Jun 2012 03:38:12 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  1 Jun 2012 18:40:59 +0800
Message-Id: <650dc8df232d41ca930097ce389d432d23a1bbad.1338546445.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <57f497956749ad3a4c41051cb12f7a3b97f0254e.1338546445.git.limingx.l.an@intel.com>
References: <57f497956749ad3a4c41051cb12f7a3b97f0254e.1338546445.git.limingx.l.an@intel.com>
In-Reply-To: <cover.1338546445.git.limingx.l.an@intel.com>
References: <cover.1338546445.git.limingx.l.an@intel.com>
Subject: [PATCH 3/3] Hob: fixed a definition not match issue when click choose directflb in package page
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
X-List-Received-Date: Fri, 01 Jun 2012 10:48:32 -0000

[YOCTO #2526]

Signed-off-by: Liming An <limingx.l.an@intel.com>
---
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
index d2c7325..9895835 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -215,7 +215,7 @@ class PackageSelectionPage (HobPage):
         self.refresh_selection()
         if not self.builder.customized:
             self.builder.customized = True
-            self.builder.configuration.selected_image = self.recipe_model.__dummy_image__
+            self.builder.configuration.selected_image = self.recipe_model.__custom_image__
             self.builder.rcppkglist_populated()
 
         self.builder.window_sensitive(True)
-- 
1.7.5.4



