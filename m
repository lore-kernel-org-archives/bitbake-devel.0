Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1TfS56-0007h4-4H
	for bitbake-devel@lists.openembedded.org;
	Mon, 03 Dec 2012 10:12:54 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 03 Dec 2012 00:57:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,205,1355126400"; d="scan'208";a="228144883"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by orsmga001.jf.intel.com with ESMTP; 03 Dec 2012 00:58:22 -0800
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  3 Dec 2012 11:01:19 +0200
Message-Id: <1354525279-13249-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: modified how the existence of a variable is checked
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
X-List-Received-Date: Mon, 03 Dec 2012 09:12:58 -0000

Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builddetailspage.py |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
index 6d8c38b..2ecd95d 100755
--- a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
@@ -227,10 +227,9 @@ class BuildDetailsPage (HobPage):
         label = gtk.Label()
         label.set_alignment(0.0, 0.5)
         # Ensure variable disk_full is defined
-        try:
-            self.builder.disk_full
-        except NameError:
+        if not hasattr(self.builder, 'disk_full'):
             self.builder.disk_full = False
+
         if self.builder.disk_full:
             markup = "<span size='medium'>There is no disk space left, so Hob cannot finish building your image. Free up some disk space\n"
             markup += "and restart the build. Check the \"Issues\" tab for more details</span>"
-- 
1.7.9.5



