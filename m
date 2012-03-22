Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SArc9-0001ys-SD
	for bitbake-devel@lists.openembedded.org;
	Fri, 23 Mar 2012 00:40:18 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 22 Mar 2012 16:31:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="124076811"
Received: from unknown (HELO shamshir.jf.intel.com) ([10.7.198.147])
	by orsmga002.jf.intel.com with ESMTP; 22 Mar 2012 16:31:16 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 22 Mar 2012 16:31:12 -0700
Message-Id: <132d0f52c83344c7ebb2fb972ff814038db3ff75.1332458487.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1332458487.git.josh@linux.intel.com>
References: <cover.1332458487.git.josh@linux.intel.com>
In-Reply-To: <cover.1332458487.git.josh@linux.intel.com>
References: <cover.1332458487.git.josh@linux.intel.com>
Subject: [PATCH 7/9] lib/bb/ui/crumbs/hobwidget: add HobButton widget for the primary action
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
X-List-Received-Date: Thu, 22 Mar 2012 23:40:18 -0000

The design uses a big, bold labelled, orange button for the primary action
on each dialogue. The HobButton implements this design as a reusable widget.

HobButton makes use of Pango Markup to use a relative size, x-large, for
the button text to ensure it's relative to the system configured font
sizes.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hobwidget.py |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobwidget.py b/lib/bb/ui/crumbs/hobwidget.py
index b93e9d4..9d144c9 100644
--- a/lib/bb/ui/crumbs/hobwidget.py
+++ b/lib/bb/ui/crumbs/hobwidget.py
@@ -196,6 +196,26 @@ def soften_color(widget, state=gtk.STATE_NORMAL):
     color.blue = color.blue * blend + style.base[state].blue * (1.0 - blend)
     return color.to_string()
 
+class HobButton(gtk.Button):
+    """
+    A gtk.Button subclass which follows the visual design of Hob for primary
+    action buttons
+
+    label: the text to display as the button's label
+    """
+    def __init__(self, label):
+        gtk.Button.__init__(self, "<span size='x-large'><b>%s</b></span>" % gobject.markup_escape_text(label))
+        self.child.set_use_markup(True)
+
+        style = self.get_style()
+        button_color = gtk.gdk.Color(HobColors.ORANGE)
+        self.modify_bg(gtk.STATE_NORMAL, button_color)
+        self.modify_bg(gtk.STATE_PRELIGHT, button_color)
+        self.modify_bg(gtk.STATE_SELECTED, button_color)
+
+        self.set_flags(gtk.CAN_DEFAULT)
+        self.grab_default()
+
 class HobAltButton(gtk.Button):
     """
     A gtk.Button subclass which has no relief, and so is more discrete
-- 
1.7.7.6



