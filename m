Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qze0Y-0008Rw-LV
	for bitbake-devel@lists.openembedded.org;
	Sat, 03 Sep 2011 02:22:50 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 02 Sep 2011 17:17:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,321,1312182000"; d="scan'208";a="47755007"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.9])
	by fmsmga001.fm.intel.com with ESMTP; 02 Sep 2011 17:17:49 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  2 Sep 2011 17:17:39 -0700
Message-Id: <fb825827b875eaad828555396591ad266d1f13f8.1315008498.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1315008498.git.josh@linux.intel.com>
References: <cover.1315008498.git.josh@linux.intel.com>
In-Reply-To: <cover.1315008498.git.josh@linux.intel.com>
References: <cover.1315008498.git.josh@linux.intel.com>
Subject: [PATCH 4/6] ui/crumbs/hobprefs: disable 'build toolchain with headers'
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
X-List-Received-Date: Sat, 03 Sep 2011 00:22:50 -0000

The generic meta-toolchain-sdk we are currently building when this option
is enabled is likely unsuitable for the majority of images built with hob.
Remove this option from the Preferences UI until such a time as we can
correctly implement this feature to include the library headers for the
selected packages.

Addresses [YOCTO #1302]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hobprefs.py |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobprefs.py b/lib/bb/ui/crumbs/hobprefs.py
index 14d6bc7..8d148cd 100644
--- a/lib/bb/ui/crumbs/hobprefs.py
+++ b/lib/bb/ui/crumbs/hobprefs.py
@@ -326,9 +326,9 @@ class HobPrefs(gtk.Dialog):
         self.sdk_machine_combo.set_tooltip_text("Select the host architecture of the external machine")
         self.sdk_machine_combo.show()
         hbox.pack_start(self.sdk_machine_combo, expand=False, fill=False, padding=6)
-        headerscheck = gtk.CheckButton("Include development headers with toolchain")
-        headerscheck.show()
-        headerscheck.set_active(self.build_toolchain_headers)
-        headerscheck.connect("toggled", self.toggle_headers_cb)
-        hbox.pack_start(headerscheck, expand=False, fill=False, padding=6)
-        self.connect("response", self.prefs_response_cb)
+        # headerscheck = gtk.CheckButton("Include development headers with toolchain")
+        # headerscheck.show()
+        # headerscheck.set_active(self.build_toolchain_headers)
+        # headerscheck.connect("toggled", self.toggle_headers_cb)
+        # hbox.pack_start(headerscheck, expand=False, fill=False, padding=6)
+        # self.connect("response", self.prefs_response_cb)
-- 
1.7.6



