Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei.adrianx.dinu@intel.com>) id 1UNMb0-0004rF-Q7
	for bitbake-devel@lists.openembedded.org;
	Wed, 03 Apr 2013 14:15:18 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 03 Apr 2013 04:58:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,401,1363158000"; d="scan'208";a="316234317"
Received: from unknown (HELO adinu-Vostro-460.rb.intel.com) ([10.237.105.45])
	by fmsmga002.fm.intel.com with ESMTP; 03 Apr 2013 04:58:05 -0700
From: Andrei Dinu <andrei.adrianx.dinu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  3 Apr 2013 14:58:47 +0300
Message-Id: <1364990327-20849-1-git-send-email-andrei.adrianx.dinu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] propertydialog adjustments for package.bbclass
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
X-List-Received-Date: Wed, 03 Apr 2013 12:15:19 -0000

After moving the code from packageinfo.bbclass to
package.bbclass, minor adjustments were made to the
parsing of the package items.

Signed-off-by: Andrei Dinu <andrei.adrianx.dinu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hig/propertydialog.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig/propertydialog.py b/bitbake/lib/bb/ui/crumbs/hig/propertydialog.py
index f4cf9a6..1e7f5c9 100644
--- a/bitbake/lib/bb/ui/crumbs/hig/propertydialog.py
+++ b/bitbake/lib/bb/ui/crumbs/hig/propertydialog.py
@@ -198,7 +198,7 @@ class PropertyDialog(CrumbsDialog):
                         col1.set_cell_data_func(self.cell1, self.regex_field)
                         self.sstatemirrors_tv.append_column(col1)
 
-                        for items in file_list.split(']]'):
+                        for items in file_list.split(']'):
                             if len(items) > 1:
                                 paths_temp = items.split(":")[0]
                                 paths_binb.append(paths_temp.strip(" ,'"))
-- 
1.7.9.5



