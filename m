Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1T7N6b-0004Pr-RC
	for bitbake-devel@lists.openembedded.org;
	Fri, 31 Aug 2012 11:01:34 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 31 Aug 2012 01:48:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,346,1344236400"; d="scan'208";a="140051163"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by AZSMGA002.ch.intel.com with ESMTP; 31 Aug 2012 01:48:10 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 31 Aug 2012 11:48:23 +0300
Message-Id: <1346402903-32172-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob/packageselectionpage: Add tooltips to 'Included' and 'All packages' tab and 'Search' field
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
X-List-Received-Date: Fri, 31 Aug 2012 09:01:34 -0000

For the 'Included' tab: "The packages currently included for your image"
For the 'All packages' tab: "All packages that have been built"
For the 'Search' field: "Enter a package name to find it"

[YOCTO #2322]

Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
index 3576ed5..e014e4e 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -35,6 +35,7 @@ class PackageSelectionPage (HobPage):
     pages = [
         {
          'name'    : 'Included',
+         'tooltip' : 'The packages currently included for your image',
          'filter'  : { PackageListModel.COL_INC : [True] },
          'columns' : [{
                        'col_name' : 'Package name',
@@ -71,6 +72,7 @@ class PackageSelectionPage (HobPage):
                      }]
         }, {
          'name'    : 'All packages',
+         'tooltip' : 'All packages that have been built',
          'filter'  : {},
          'columns' : [{
                        'col_name' : 'Package name',
@@ -135,12 +137,15 @@ class PackageSelectionPage (HobPage):
             if page['name'] == "Included":
                 tab.connect("button-release-event", self.button_click_cb)
                 tab.connect("cell-fadeinout-stopped", self.after_fadeout_checkin_include)
-            self.ins.append_page(tab, page['name'])
+            self.ins.append_page(tab, page['name'], page['tooltip'])
             self.tables.append(tab)
 
         self.ins.set_entry("Search packages:")
         # set the search entry for each table
         for tab in self.tables:
+            search_tip = "Enter a package name to find it"
+            self.ins.search.set_tooltip_text(search_tip)
+            self.ins.search.props.has_tooltip = True
             tab.set_search_entry(0, self.ins.search)
 
         # add all into the dialog
-- 
1.7.9.5



