Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristian.iorga@intel.com>) id 1TJ3wZ-0003u1-B5
	for bitbake-devel@lists.openembedded.org;
	Tue, 02 Oct 2012 16:59:31 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 02 Oct 2012 07:45:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,523,1344236400"; d="scan'208";a="151527627"
Received: from sentry (HELO localhost.localdomain) ([10.237.105.37])
	by AZSMGA002.ch.intel.com with ESMTP; 02 Oct 2012 07:45:26 -0700
From: Cristian Iorga <cristian.iorga@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  2 Oct 2012 17:44:55 +0300
Message-Id: <1349189095-24862-1-git-send-email-cristian.iorga@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: Improved behavior for error reporting window
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
X-List-Received-Date: Tue, 02 Oct 2012 14:59:31 -0000

Scrollbars have now an automatic behavior, depending on
the error's text size and error window size.

Fixes [YOCTO #2983]

Signed-off-by: Cristian Iorga <cristian.iorga@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hig.py |    1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index c5307df..c7a50ba 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -280,6 +280,7 @@ class CrumbsMessageDialog(CrumbsDialog):
             self.label_long.show()
             self.textWindow = gtk.ScrolledWindow()
             self.textWindow.set_shadow_type(gtk.SHADOW_IN)
+            self.textWindow.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
             self.msgView = gtk.TextView()
             self.msgView.set_editable(False)
             self.msgView.set_wrap_mode(gtk.WRAP_WORD)
-- 
1.7.9.5



