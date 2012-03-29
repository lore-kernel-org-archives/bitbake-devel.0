Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SD3Oo-0007bb-Jf
	for bitbake-devel@lists.openembedded.org;
	Thu, 29 Mar 2012 02:39:34 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 28 Mar 2012 17:30:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="126325964"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.12.73])
	by orsmga002.jf.intel.com with ESMTP; 28 Mar 2012 17:30:29 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 28 Mar 2012 17:30:23 -0700
Message-Id: <89c6156bc28beee2df9d04165f46b743462987af.1332980606.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1332980606.git.josh@linux.intel.com>
References: <cover.1332980606.git.josh@linux.intel.com>
In-Reply-To: <cover.1332980606.git.josh@linux.intel.com>
References: <cover.1332980606.git.josh@linux.intel.com>
Subject: [PATCH 2/6] lib/bb/ui/crumbs/imageconfigurationpage: add extra space between widgets
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
X-List-Received-Date: Thu, 29 Mar 2012 00:39:34 -0000

Add space between the target machine combo and the 'Layers' button.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/imageconfigurationpage.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/crumbs/imageconfigurationpage.py b/lib/bb/ui/crumbs/imageconfigurationpage.py
index d7437a9..f66bcd6 100644
--- a/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -171,7 +171,7 @@ class ImageConfigurationPage (HobPage):
         self.gtable.attach(self.machine_title, 0, 40, 0, 4)
         self.gtable.attach(self.machine_title_desc, 0, 40, 4, 6)
         self.gtable.attach(self.machine_combo, 0, 12, 6, 9)
-        self.gtable.attach(self.layer_button, 12, 36, 6, 11)
+        self.gtable.attach(self.layer_button, 15, 36, 6, 11)
         self.gtable.attach(self.layer_info_icon, 36, 40, 6, 10)
         if show_progress_bar:
             self.gtable.attach(self.progress_box, 0, 40, 13, 17)
-- 
1.7.7.6



