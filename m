Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SJ0cx-0008TT-Fs
	for bitbake-devel@lists.openembedded.org;
	Sat, 14 Apr 2012 12:54:47 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 14 Apr 2012 03:45:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="89010134"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by AZSMGA002.ch.intel.com with ESMTP; 14 Apr 2012 03:45:23 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 14 Apr 2012 18:42:27 +0800
Message-Id: <4180883975816336cf8bdbb5a70768cffa543dbb.1334400003.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1334400003.git.dongxiao.xu@intel.com>
References: <cover.1334400003.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1334400003.git.dongxiao.xu@intel.com>
References: <cover.1334400003.git.dongxiao.xu@intel.com>
Subject: [PATCH 1/4] Hob: A minor fix on tooltip
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
X-List-Received-Date: Sat, 14 Apr 2012 10:54:47 -0000

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/hig.py |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
index 5cc8a59..322efc6 100644
--- a/lib/bb/ui/crumbs/hig.py
+++ b/lib/bb/ui/crumbs/hig.py
@@ -392,7 +392,10 @@ class AdvancedSettingDialog (CrumbsDialog):
         j = 1
         for image_type in self.image_types:
             self.image_types_checkbuttons[image_type] = gtk.CheckButton(image_type)
-            self.image_types_checkbuttons[image_type].set_tooltip_text("Build an %s image" % image_type)
+            article = ""
+            if image_type.startswith(("a", "e", "i", "o", "u")):
+                article = "n"
+            self.image_types_checkbuttons[image_type].set_tooltip_text("Build a%s %s image" % (article, image_type))
             table.attach(self.image_types_checkbuttons[image_type], j, j + 4, i, i + 1)
             if image_type in self.configuration.image_fstypes.split():
                 self.image_types_checkbuttons[image_type].set_active(True)
-- 
1.7.4.1



