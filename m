Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1SWTv2-0000R9-7o
	for bitbake-devel@lists.openembedded.org;
	Mon, 21 May 2012 16:49:08 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 21 May 2012 07:39:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="146430786"
Received: from hp.sh.intel.com ([10.239.47.6])
	by orsmga002.jf.intel.com with ESMTP; 21 May 2012 07:38:59 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 21 May 2012 22:41:23 +0800
Message-Id: <6ed77a670f30fcf7aa99922d80a581dbb33c49f1.1337610738.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <be9df903825ec31825cd12c0d5d20d0ca0e8d88a.1337610738.git.limingx.l.an@intel.com>
References: <be9df903825ec31825cd12c0d5d20d0ca0e8d88a.1337610738.git.limingx.l.an@intel.com>
In-Reply-To: <cover.1337610738.git.limingx.l.an@intel.com>
References: <cover.1337610738.git.limingx.l.an@intel.com>
Subject: [PATCH 4/5] Hob: fixed the line width of base image description view
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
X-List-Received-Date: Mon, 21 May 2012 14:49:08 -0000

As ui design, adjusted the line width for each base image description

[YOCTO 2310]

Signed-off-by: Liming An <limingx.l.an@intel.com>
---
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index d17ea8f..391cdc2 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -202,7 +202,7 @@ class ImageConfigurationPage (HobPage):
 
         self.image_desc = gtk.Label()
         self.image_desc.set_alignment(0.0, 0.5)
-        self.image_desc.set_size_request(400, -1)
+        self.image_desc.set_size_request(360, -1)
         self.image_desc.set_justify(gtk.JUSTIFY_LEFT)
         self.image_desc.set_line_wrap(True)
 
-- 
1.7.5.4



