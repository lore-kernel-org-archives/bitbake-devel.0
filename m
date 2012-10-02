Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <constantinx.musca@intel.com>) id 1TJ502-0005lw-9K
	for bitbake-devel@lists.openembedded.org;
	Tue, 02 Oct 2012 18:07:10 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 02 Oct 2012 08:54:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,524,1344236400"; d="scan'208";a="151553515"
Received: from costin-desktop (HELO localhost.localdomain) ([10.237.105.66])
	by AZSMGA002.ch.intel.com with ESMTP; 02 Oct 2012 08:54:09 -0700
From: Constantin Musca <constantinx.musca@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  2 Oct 2012 17:59:45 +0300
Message-Id: <1349189985-8377-1-git-send-email-constantinx.musca@intel.com>
X-Mailer: git-send-email 1.7.9.5
Cc: Constantin Musca <constantinx.musca@intel.com>
Subject: [PATCH] hob/hobpages: Generate the title label every time
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
X-List-Received-Date: Tue, 02 Oct 2012 16:07:10 -0000

- the title label is destroyed at page switching (that's why we need
to generate it every time)

[YOCTO #3195]

Signed-off-by: Constantin Musca <constantinx.musca@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobpages.py |    1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/ui/crumbs/hobpages.py b/bitbake/lib/bb/ui/crumbs/hobpages.py
index 5b49764..0fd3598 100755
--- a/bitbake/lib/bb/ui/crumbs/hobpages.py
+++ b/bitbake/lib/bb/ui/crumbs/hobpages.py
@@ -62,6 +62,7 @@ class HobPage (gtk.VBox):
 
         hbox = gtk.HBox()
 
+        self.title_label = gtk.Label()
         self.title_label.set_markup("<span size='x-large'>%s</span>" % self.title)
         hbox.pack_start(self.title_label, expand=False, fill=False, padding=20)
 
-- 
1.7.9.5



