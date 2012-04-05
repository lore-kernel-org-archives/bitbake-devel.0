Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SFraI-0001mp-F6
	for bitbake-devel@lists.openembedded.org;
	Thu, 05 Apr 2012 20:39:03 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 05 Apr 2012 11:29:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="129138837"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.12.114])
	by orsmga002.jf.intel.com with ESMTP; 05 Apr 2012 11:29:40 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  5 Apr 2012 11:29:36 -0700
Message-Id: <b089f5f450d0a89b68795584debe2fbee5dc8fc9.1333650445.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1333650445.git.josh@linux.intel.com>
References: <cover.1333650445.git.josh@linux.intel.com>
In-Reply-To: <cover.1333650445.git.josh@linux.intel.com>
References: <cover.1333650445.git.josh@linux.intel.com>
Subject: [PATCH 1/3] lib/bb/ui/crumbs/persistenttooltip: replace 2.22 API
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
X-List-Received-Date: Thu, 05 Apr 2012 18:39:03 -0000

CentOS 6.x doesn't ship with new enough pygtk for this API.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/persistenttooltip.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/crumbs/persistenttooltip.py b/lib/bb/ui/crumbs/persistenttooltip.py
index 69e059b..4db3018 100644
--- a/lib/bb/ui/crumbs/persistenttooltip.py
+++ b/lib/bb/ui/crumbs/persistenttooltip.py
@@ -87,7 +87,7 @@ class PersistentTooltip(gtk.Window):
         self.button = gtk.Button()
         self.button.set_image(img)
         self.button.connect("clicked", self._dismiss_cb)
-        self.button.set_can_default(True)
+        self.button.set_flags(gtk.CAN_DEFAULT)
         self.button.grab_focus()
         self.button.show()
         vbox = gtk.VBox(False, 0)
-- 
1.7.7.6



