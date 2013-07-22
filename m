Return-Path: <cristiana.voicu@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id F14FF6065F
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Jul 2013 10:51:49 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 22 Jul 2013 03:49:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,718,1367996400"; d="scan'208";a="349542083"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by orsmga001.jf.intel.com with ESMTP; 22 Jul 2013 03:51:49 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 22 Jul 2013 13:54:10 +0300
Message-Id: <1374490451-8079-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH 1/2] hob: changed the split of SSTATE_MIRRORS variable
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 22 Jul 2013 10:51:50 -0000

Until now the split made searching the string "file://", but
this is not ok when SSTATE_VARIABLE has the following form:
SSTATE_MIRRORS ?= "\
     file://.* http://someserver.tld/share/sstate/PATH \n \
     file://.* file:///some/local/dir/sstate/PATH"

In the documentation I've found that \n is the list separator.

[YOCTO #4857]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 .../lib/bb/ui/crumbs/hig/simplesettingsdialog.py   |   13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py b/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py
index c1bd45f..e43080a 100644
--- a/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py
+++ b/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py
@@ -310,7 +310,6 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
 
         sub_vbox = gtk.VBox(False)
         advanced_vbox.pack_start(sub_vbox, gtk.TRUE, gtk.TRUE, 0)
-        searched_string = "file://"
 
         if self.sstatemirrors_changed == 0:
             self.sstatemirrors_changed = 1
@@ -319,16 +318,10 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
                 sm_list = ["Standard", "", "file://(.*)"]
                 self.sstatemirrors_list.append(sm_list)
             else:
-                while sstatemirrors.find(searched_string) != -1:
-                    if sstatemirrors.find(searched_string,1) != -1:
-                        sstatemirror = sstatemirrors[:sstatemirrors.find(searched_string,1)]
-                        sstatemirrors = sstatemirrors[sstatemirrors.find(searched_string,1):]
-                    else:
-                        sstatemirror = sstatemirrors
-                        sstatemirrors = sstatemirrors[1:]
-
+                sstatemirrors = [x for x in sstatemirrors.split('\\n')]
+                for sstatemirror in sstatemirrors:
                     sstatemirror_fields = [x for x in sstatemirror.split(' ') if x.strip()]
-                    if len(sstatemirror_fields):
+                    if len(sstatemirror_fields) == 2:
                         if sstatemirror_fields[0] == "file://(.*)":
                             sm_list = ["Standard", sstatemirror_fields[1], "file://(.*)"]
                         else:
-- 
1.7.9.5


