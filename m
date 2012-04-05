Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SFraJ-0001mp-IR
	for bitbake-devel@lists.openembedded.org;
	Thu, 05 Apr 2012 20:39:04 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 05 Apr 2012 11:29:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="129138839"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.12.114])
	by orsmga002.jf.intel.com with ESMTP; 05 Apr 2012 11:29:41 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  5 Apr 2012 11:29:37 -0700
Message-Id: <09a0f7d44d08daf341277ce9dd94061622104594.1333650445.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1333650445.git.josh@linux.intel.com>
References: <cover.1333650445.git.josh@linux.intel.com>
In-Reply-To: <cover.1333650445.git.josh@linux.intel.com>
References: <cover.1333650445.git.josh@linux.intel.com>
Subject: [PATCH 2/3] lib/bb/ui/crumbs/hobwidget: replace new API
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
X-List-Received-Date: Thu, 05 Apr 2012 18:39:04 -0000

The gtk.Widget.get_sensitive() convenience method is only available
in Gtk+ 2.22 or later, instead use the sensitive property of the
gobject to determine whether the widget is sensitive or not.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hobwidget.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobwidget.py b/lib/bb/ui/crumbs/hobwidget.py
index edb85db..a7e5538 100644
--- a/lib/bb/ui/crumbs/hobwidget.py
+++ b/lib/bb/ui/crumbs/hobwidget.py
@@ -241,7 +241,7 @@ class HobAltButton(gtk.Button):
     """
     @staticmethod
     def desensitise_on_state_change_cb(button, state):
-        if button.get_state() == gtk.STATE_INSENSITIVE:
+        if not button.get_property("sensitive"):
             HobAltButton.set_text(button, False)
         else:
             HobAltButton.set_text(button, True)
-- 
1.7.7.6



