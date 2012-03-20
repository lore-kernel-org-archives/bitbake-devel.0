Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S9mvm-000820-5C
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Mar 2012 01:28:06 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 19 Mar 2012 17:18:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="141535436"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.15.181])
	by fmsmga002.fm.intel.com with ESMTP; 19 Mar 2012 17:18:08 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 19 Mar 2012 17:18:01 -0700
Message-Id: <bad78ebcdbf59381ce93021afbc005b3f50438a4.1332202341.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1332202341.git.josh@linux.intel.com>
References: <cover.1332202341.git.josh@linux.intel.com>
In-Reply-To: <cover.1332202341.git.josh@linux.intel.com>
References: <cover.1332202341.git.josh@linux.intel.com>
Subject: [PATCH 1/6] ui/crumbs/hig: use close rather than OK for dismis button
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
X-List-Received-Date: Tue, 20 Mar 2012 00:28:06 -0000

Dialogue buttons should have descriptive names

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hig.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
index 67cc94e..849d7c9 100644
--- a/lib/bb/ui/crumbs/hig.py
+++ b/lib/bb/ui/crumbs/hig.py
@@ -838,7 +838,7 @@ class LayerSelectionDialog (CrumbsDialog):
                 layer_store.append([path])
                 return
             dialog = CrumbsMessageDialog(parent, lbl)
-            dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
+            dialog.add_button(gtk.STOCK_CLOSE, gtk.RESPONSE_OK)
             response = dialog.run()
             dialog.destroy()
 
-- 
1.7.7.6



