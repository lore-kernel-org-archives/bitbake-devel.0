Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SD3Op-0007bb-Aq
	for bitbake-devel@lists.openembedded.org;
	Thu, 29 Mar 2012 02:39:35 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 28 Mar 2012 17:30:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="126325968"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.12.73])
	by orsmga002.jf.intel.com with ESMTP; 28 Mar 2012 17:30:30 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 28 Mar 2012 17:30:24 -0700
Message-Id: <7ecd86b1a178af4293da424383cd10f1aefb9dfc.1332980606.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1332980606.git.josh@linux.intel.com>
References: <cover.1332980606.git.josh@linux.intel.com>
In-Reply-To: <cover.1332980606.git.josh@linux.intel.com>
References: <cover.1332980606.git.josh@linux.intel.com>
Subject: [PATCH 3/6] lib/bb/ui/crumbs/hobwidget: change text sizes in HobImageButton
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
X-List-Received-Date: Thu, 29 Mar 2012 00:39:35 -0000

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hobwidget.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobwidget.py b/lib/bb/ui/crumbs/hobwidget.py
index 9bc09dd..413370e 100644
--- a/lib/bb/ui/crumbs/hobwidget.py
+++ b/lib/bb/ui/crumbs/hobwidget.py
@@ -295,7 +295,7 @@ class HobImageButton(gtk.Button):
         label = gtk.Label()
         label.set_alignment(0.0, 0.5)
         colour = soften_color(label)
-        mark = "%s\n<span fgcolor='%s'><small>%s</small></span>" % (primary_text, colour, secondary_text)
+        mark = "<span size='larger'>%s</span>\n<span fgcolor='%s'>%s</span>" % (primary_text, colour, secondary_text)
         label.set_markup(mark)
         label.show()
         hbox.pack_start(label, True, True, 6)
-- 
1.7.7.6



