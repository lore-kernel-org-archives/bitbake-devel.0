Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SA9Lc-0004j2-5W
	for bitbake-devel@lists.openembedded.org;
	Wed, 21 Mar 2012 01:24:16 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 20 Mar 2012 17:15:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="119778615"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.15.207])
	by orsmga001.jf.intel.com with ESMTP; 20 Mar 2012 17:15:21 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 20 Mar 2012 17:15:16 -0700
Message-Id: <d3c6d48191d187022441b503302ceefa7e8766fa.1332288516.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1332288516.git.josh@linux.intel.com>
References: <cover.1332288516.git.josh@linux.intel.com>
In-Reply-To: <cover.1332288516.git.josh@linux.intel.com>
References: <cover.1332288516.git.josh@linux.intel.com>
Subject: [PATCH 3/5] ui/crumbs/persistenttooltip: tweak borders
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
X-List-Received-Date: Wed, 21 Mar 2012 00:24:16 -0000

Change the layout and borders so that the close button is flush with the
edge of the tooltip window yet leave the contents with a small border such
that text isn't flush with the window edge.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/persistenttooltip.py |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/crumbs/persistenttooltip.py b/lib/bb/ui/crumbs/persistenttooltip.py
index bae697e..e9cc380 100644
--- a/lib/bb/ui/crumbs/persistenttooltip.py
+++ b/lib/bb/ui/crumbs/persistenttooltip.py
@@ -64,7 +64,7 @@ class PersistentTooltip(gtk.Window):
 		# We must be modal to ensure we grab focus when presented from a gtk.Dialog
 		self.set_modal(True)
 
-		self.set_border_width(6)
+		self.set_border_width(0)
 		self.set_position(gtk.WIN_POS_MOUSE)
 		self.set_opacity(0.95)
 
@@ -91,10 +91,14 @@ class PersistentTooltip(gtk.Window):
 
 		self.set_default(self.button)
 
+		hbox = gtk.HBox(True, 6)
+		hbox.set_border_width(6)
+		hbox.show()
+		vbox.pack_end(hbox, True, True, 6)
 		self.label = gtk.Label()
 		self.label.set_markup(markup)
 		self.label.show()
-		vbox.pack_end(self.label, True, True, 6)
+		hbox.pack_end(self.label, True, True, 6)
 
 		self.connect("key-press-event", self._catch_esc_cb)
 
-- 
1.7.7.6



