Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1R61up-0000rF-0Y
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Sep 2011 17:07:19 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 20 Sep 2011 08:01:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,411,1312182000"; d="scan'208";a="18826190"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.183])
	by AZSMGA002.ch.intel.com with ESMTP; 20 Sep 2011 08:01:59 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 20 Sep 2011 08:01:49 -0700
Message-Id: <bdbd724e806c9ca69cc1508bac7ec0a2dce95543.1316530819.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6.2
In-Reply-To: <cover.1316530819.git.josh@linux.intel.com>
References: <cover.1316530819.git.josh@linux.intel.com>
In-Reply-To: <cover.1316530819.git.josh@linux.intel.com>
References: <cover.1316530819.git.josh@linux.intel.com>
Subject: [PATCH 1/3] ui/crumbs/hobprefs: re-enable reloading of data after prefs changes
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
X-List-Received-Date: Tue, 20 Sep 2011 15:07:19 -0000

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
1.7.6.2



