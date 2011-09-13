Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1R3Voc-0001jT-8A
	for bitbake-devel@lists.openembedded.org;
	Tue, 13 Sep 2011 18:26:31 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 13 Sep 2011 09:21:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,375,1312182000"; d="scan'208";a="50818019"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.59])
	by fmsmga001.fm.intel.com with ESMTP; 13 Sep 2011 09:21:16 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 13 Sep 2011 09:21:08 -0700
Message-Id: <4394e38b038e1bc9845adf01d73363157d98c96d.1315927921.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1315927921.git.josh@linux.intel.com>
References: <cover.1315927921.git.josh@linux.intel.com>
In-Reply-To: <cover.1315927921.git.josh@linux.intel.com>
References: <cover.1315927921.git.josh@linux.intel.com>
Subject: [PATCH 3/4] hob: correctly handle an exception
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
X-List-Received-Date: Tue, 13 Sep 2011 16:26:32 -0000

It doesn't matter if we can't remove the temprorary file, for some reason,
so catch the exception and ignore it.

Partially addresses [YOCTO #1468]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/hob.py |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index 84df37d..8d2d1bd 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -495,7 +495,11 @@ class MainWindow (gtk.Window):
         self.back.set_sensitive(True)
         self.cancel.set_sensitive(False)
         for f in self.files_to_clean:
-            os.remove(f)
+            try:
+                os.remove(f)
+            except OSError:
+                pass
+            self.files_to_clean.remove(f)
         self.files_to_clean = []
 
         lbl = "<b>Build completed</b>\n\nClick 'Edit Image' to start another build or 'View Messages' to view the messages output during the build."
-- 
1.7.6



