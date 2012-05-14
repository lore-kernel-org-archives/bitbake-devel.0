Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1STusH-0002Rt-8S
	for bitbake-devel@lists.openembedded.org;
	Mon, 14 May 2012 14:59:41 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 14 May 2012 05:49:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="152687682"
Received: from hp.sh.intel.com ([10.239.47.6])
	by fmsmga001.fm.intel.com with ESMTP; 14 May 2012 05:49:30 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 14 May 2012 20:51:48 +0800
Message-Id: <24e188a8e9cf555798370b7f6151a37ed0973497.1336999687.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1336999687.git.limingx.l.an@intel.com>
References: <cover.1336999687.git.limingx.l.an@intel.com>
Subject: [PATCH 1/3] Hob: apply a line length to consistantly across 'base image' descriptions
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
X-List-Received-Date: Mon, 14 May 2012 12:59:41 -0000

[YOCTO #2310]

Signed-off-by: Liming An <limingx.l.an@intel.com>
---
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index 0463ee8..7d19912 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -201,6 +201,8 @@ class ImageConfigurationPage (HobPage):
 
         self.image_desc = gtk.Label()
         self.image_desc.set_alignment(0.0, 0.5)
+        self.image_desc.set_size_request(400, -1)
+        self.image_desc.set_justify(gtk.JUSTIFY_LEFT)
         self.image_desc.set_line_wrap(True)
 
         # button to view recipes
-- 
1.7.5.4



