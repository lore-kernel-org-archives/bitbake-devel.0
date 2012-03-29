Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SD3Oq-0007bb-17
	for bitbake-devel@lists.openembedded.org;
	Thu, 29 Mar 2012 02:39:36 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 28 Mar 2012 17:30:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="126325970"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.12.73])
	by orsmga002.jf.intel.com with ESMTP; 28 Mar 2012 17:30:30 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 28 Mar 2012 17:30:25 -0700
Message-Id: <3dc528dd4602c388b70bdf96548feb2bc60f19d0.1332980606.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1332980606.git.josh@linux.intel.com>
References: <cover.1332980606.git.josh@linux.intel.com>
In-Reply-To: <cover.1332980606.git.josh@linux.intel.com>
References: <cover.1332980606.git.josh@linux.intel.com>
Subject: [PATCH 4/6] lib/bb/ui/crumbs/builder: allow user to cancel Layer selection dialogue
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
X-List-Received-Date: Thu, 29 Mar 2012 00:39:36 -0000

Because layer changes may take some time allow the user to cancel out of
the dialogue and prevent Hob from applying any of the changes made.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/builder.py |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index 2af14dc..1d203fe 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -734,7 +734,9 @@ class Builder(gtk.Window):
                      flags = gtk.DIALOG_MODAL
                          | gtk.DIALOG_DESTROY_WITH_PARENT
                          | gtk.DIALOG_NO_SEPARATOR)
-        button = dialog.add_button("Close", gtk.RESPONSE_YES)
+        button = dialog.add_button("Cancel", gtk.RESPONSE_NO)
+        HobAltButton.style_button(button)
+        button = dialog.add_button("OK", gtk.RESPONSE_YES)
         HobButton.style_button(button)
         response = dialog.run()
         if response == gtk.RESPONSE_YES:
-- 
1.7.7.6



