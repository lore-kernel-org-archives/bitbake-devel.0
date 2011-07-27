Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QlvJg-0007hu-0Z
	for bitbake-devel@lists.openembedded.org;
	Wed, 27 Jul 2011 06:01:52 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 26 Jul 2011 20:57:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,273,1309762800"; d="scan'208";a="34904876"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.163])
	by fmsmga001.fm.intel.com with ESMTP; 26 Jul 2011 20:57:35 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 26 Jul 2011 20:57:27 -0700
Message-Id: <fb47c7452455f3f8d943b21dd61300ec55eea141.1311738866.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1311738866.git.josh@linux.intel.com>
References: <cover.1311738866.git.josh@linux.intel.com>
In-Reply-To: <cover.1311738866.git.josh@linux.intel.com>
References: <cover.1311738866.git.josh@linux.intel.com>
Subject: [PATCH 4/4] ui/crumbs/hobprefs: trigger reparse when package format changed
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
X-List-Received-Date: Wed, 27 Jul 2011 04:01:53 -0000

From: Jessica Zhang <jessica.zhang@intel.com>

reload_data after package format change to make the change take effects in
next build.

Fixes [YOCTO #1287].

Signed-off-by: Jessica Zhang <jessica.zhang@intel.com>
Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hobprefs.py |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobprefs.py b/lib/bb/ui/crumbs/hobprefs.py
index 1e6c78b..0f9bda2 100644
--- a/lib/bb/ui/crumbs/hobprefs.py
+++ b/lib/bb/ui/crumbs/hobprefs.py
@@ -93,6 +93,7 @@ class HobPrefs(gtk.Dialog):
             self.curr_package_format = package_format
             self.configurator.setLocalConfVar('PACKAGE_CLASSES', 'package_%s' % package_format)
             handler.set_package_format(package_format)
+            self.reload_required = True
 
     def update_package_formats(self, handler, formats):
         active = 0
-- 
1.7.6



