Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SD3On-0007bb-Ra
	for bitbake-devel@lists.openembedded.org;
	Thu, 29 Mar 2012 02:39:34 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 28 Mar 2012 17:30:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="126325962"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.12.73])
	by orsmga002.jf.intel.com with ESMTP; 28 Mar 2012 17:30:29 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 28 Mar 2012 17:30:22 -0700
Message-Id: <2af0347d6002014c0d910579e2856262941ce989.1332980606.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1332980606.git.josh@linux.intel.com>
References: <cover.1332980606.git.josh@linux.intel.com>
In-Reply-To: <cover.1332980606.git.josh@linux.intel.com>
References: <cover.1332980606.git.josh@linux.intel.com>
Subject: [PATCH 1/6] lib/bb/ui/crumbs/hobwidget: add padding to HobImageButton
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

Add more padding between the icon and the text

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hobwidget.py |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobwidget.py b/lib/bb/ui/crumbs/hobwidget.py
index 89ff23e..9bc09dd 100644
--- a/lib/bb/ui/crumbs/hobwidget.py
+++ b/lib/bb/ui/crumbs/hobwidget.py
@@ -281,7 +281,7 @@ class HobImageButton(gtk.Button):
         self.icon_path = icon_path
         self.hover_icon_path = hover_icon_path
 
-        hbox = gtk.HBox(False, 3)
+        hbox = gtk.HBox(False, 6)
         hbox.show()
         self.add(hbox)
         self.icon = gtk.Image()
@@ -298,7 +298,7 @@ class HobImageButton(gtk.Button):
         mark = "%s\n<span fgcolor='%s'><small>%s</small></span>" % (primary_text, colour, secondary_text)
         label.set_markup(mark)
         label.show()
-        hbox.pack_start(label, True, True, 0)
+        hbox.pack_start(label, True, True, 6)
 
     def set_hover_icon_cb(self, widget, event):
         self.icon.set_from_file(self.hover_icon_path)
-- 
1.7.7.6



