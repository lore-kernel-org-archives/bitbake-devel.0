Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1SRj1G-0005t4-I7
	for bitbake-devel@lists.openembedded.org;
	Tue, 08 May 2012 13:55:57 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 08 May 2012 04:46:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="150484323"
Received: from hp.sh.intel.com ([10.239.47.6])
	by fmsmga001.fm.intel.com with ESMTP; 08 May 2012 04:46:01 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  8 May 2012 19:48:06 +0800
Message-Id: <60a5d9dd3330307d428d8d6ce3779ad70d6c1ea7.1336477313.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <97b813663dd741e20295a0c19a2d4b46086e5afe.1336477313.git.limingx.l.an@intel.com>
References: <97b813663dd741e20295a0c19a2d4b46086e5afe.1336477313.git.limingx.l.an@intel.com>
In-Reply-To: <cover.1336477313.git.limingx.l.an@intel.com>
References: <cover.1336477313.git.limingx.l.an@intel.com>
Subject: [PATCH 2/4] Hob: add original url show function with the tooltip hyperlink for user
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
X-List-Received-Date: Tue, 08 May 2012 11:56:03 -0000

When case about No browser, such as running in 'Build Appliance', user can't open
the hyper link, so add this work around for user. (Checking the browser is avaiable
or not is hard by different system and browser type)

[CTO #2340]

Signed-off-by: Liming An <limingx.l.an@intel.com>
---
 bitbake/lib/bb/ui/crumbs/persistenttooltip.py |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/persistenttooltip.py b/bitbake/lib/bb/ui/crumbs/persistenttooltip.py
index b43d297..927c194 100644
--- a/bitbake/lib/bb/ui/crumbs/persistenttooltip.py
+++ b/bitbake/lib/bb/ui/crumbs/persistenttooltip.py
@@ -125,11 +125,17 @@ class PersistentTooltip(gtk.Window):
                 style.fg[gtk.STATE_NORMAL] = gtk.gdk.color_parse(val)
                 self.label.set_style(style)
                 break # we only care for the tooltip_fg_color
+
         self.label.set_markup(markup)
         self.label.show()
         bin.add(self.label)
         hbox.pack_end(bin, True, True, 6)
 
+        # add the original URL display for user reference
+        if 'a href' in markup:
+            hbox.set_tooltip_text(self.get_markup_url(markup))
+        hbox.show()
+
         self.connect("key-press-event", self._catch_esc_cb)
 
     """
@@ -165,3 +171,16 @@ class PersistentTooltip(gtk.Window):
     def hide(self):
         self.shown = False
         gtk.Window.hide(self)
+
+    """
+    Called to get the hyperlink URL from markup text.
+    """
+    def get_markup_url(self, markup):
+        url = "http:"
+        if markup and type(markup) == str:
+            s = markup
+            if 'http:' in s:
+                import re
+                url = re.search('(http:[^,\\ "]+)', s).group(0)
+
+        return url
-- 
1.7.5.4



