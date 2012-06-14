Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1Sf9BP-0004DC-3w
	for bitbake-devel@lists.openembedded.org;
	Thu, 14 Jun 2012 14:29:51 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 14 Jun 2012 05:19:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="156320957"
Received: from hp.sh.intel.com ([10.239.47.6])
	by azsmga001.ch.intel.com with ESMTP; 14 Jun 2012 05:19:13 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 14 Jun 2012 20:22:26 +0800
Message-Id: <931f4368cb40885bf7ccaf80c452564210a25d1d.1339676383.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <d226436d6adfb063aee2c549e7dd28620414aa9b.1339676383.git.limingx.l.an@intel.com>
References: <d226436d6adfb063aee2c549e7dd28620414aa9b.1339676383.git.limingx.l.an@intel.com>
In-Reply-To: <cover.1339676383.git.limingx.l.an@intel.com>
References: <cover.1339676383.git.limingx.l.an@intel.com>
Subject: [PATCH 2/2] Hob: fixed issue about 'select a base image' combo not sensitive
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
X-List-Received-Date: Thu, 14 Jun 2012 12:29:51 -0000

The combo view is not sensitive, after select recipes come back.
so fixed this issue.

[YOCTO #2500]

Signed-off-by: Liming An <limingx.l.an@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index ad9c0f4..123608e 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -758,7 +758,9 @@ class Builder(gtk.Window):
 
     def window_sensitive(self, sensitive):
         self.image_configuration_page.machine_combo.set_sensitive(sensitive)
+        self.image_configuration_page.machine_combo.child.set_sensitive(sensitive)
         self.image_configuration_page.image_combo.set_sensitive(sensitive)
+        self.image_configuration_page.image_combo.child.set_sensitive(sensitive)
         self.image_configuration_page.layer_button.set_sensitive(sensitive)
         self.image_configuration_page.layer_info_icon.set_sensitive(sensitive)
         self.image_configuration_page.toolbar.set_sensitive(sensitive)
-- 
1.7.5.4



