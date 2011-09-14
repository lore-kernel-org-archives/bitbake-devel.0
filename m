Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1R3z4S-00061P-0Q
	for bitbake-devel@lists.openembedded.org;
	Thu, 15 Sep 2011 01:40:48 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 14 Sep 2011 16:35:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="48529305"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.158])
	by orsmga002.jf.intel.com with ESMTP; 14 Sep 2011 16:35:34 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Sep 2011 16:35:28 -0700
Message-Id: <997402e91dd285fb22ca65bbc4e2dac31947272f.1316043111.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1316043111.git.josh@linux.intel.com>
References: <cover.1316043111.git.josh@linux.intel.com>
In-Reply-To: <cover.1316043111.git.josh@linux.intel.com>
References: <cover.1316043111.git.josh@linux.intel.com>
Subject: [PATCH 1/1] ui/crumbs/hobprefs: re-enable reloading of data after prefs changes
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
X-List-Received-Date: Wed, 14 Sep 2011 23:40:48 -0000

When disabling the toolchain w/ headers checkbox in an early commit I
accidentally disabled too much code. This re-enables adding the custom
response handler to the Preferences dialog which triggeres a reparse of
the metadata when appropriate preference changes are made.

Fixes [YOCTO #1479]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hobprefs.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobprefs.py b/lib/bb/ui/crumbs/hobprefs.py
index 8d148cd..5dfb0e6 100644
--- a/lib/bb/ui/crumbs/hobprefs.py
+++ b/lib/bb/ui/crumbs/hobprefs.py
@@ -331,4 +331,4 @@ class HobPrefs(gtk.Dialog):
         # headerscheck.set_active(self.build_toolchain_headers)
         # headerscheck.connect("toggled", self.toggle_headers_cb)
         # hbox.pack_start(headerscheck, expand=False, fill=False, padding=6)
-        # self.connect("response", self.prefs_response_cb)
+        self.connect("response", self.prefs_response_cb)
-- 
1.7.6



