Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1R0YOc-0002f2-S8
	for bitbake-devel@lists.openembedded.org;
	Mon, 05 Sep 2011 14:35:27 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 05 Sep 2011 05:30:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="45362401"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.120.53])
	by orsmga001.jf.intel.com with ESMTP; 05 Sep 2011 05:30:17 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  5 Sep 2011 13:30:10 +0100
Message-Id: <dec09dbc681527fc7cd67f9c3db1f5090fe2a8d4.1315225427.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1315225427.git.paul.eggleton@linux.intel.com>
References: <cover.1315225427.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1315225427.git.paul.eggleton@linux.intel.com>
References: <cover.1315225427.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/2] hob: clear out temporary file list after deleting
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
X-List-Received-Date: Mon, 05 Sep 2011 12:35:27 -0000

If you don't clear out files_to_clean after the files get deleted and
then you run a second build, it will try to delete the files from the
first build and you will get a "No such file or directory" error.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/ui/hob.py |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/bitbake/lib/bb/ui/hob.py b/bitbake/lib/bb/ui/hob.py
index c2acada..f2a9ee5 100644
--- a/bitbake/lib/bb/ui/hob.py
+++ b/bitbake/lib/bb/ui/hob.py
@@ -496,6 +496,7 @@ class MainWindow (gtk.Window):
         self.cancel.set_sensitive(False)
         for f in self.files_to_clean:
             os.remove(f)
+        self.files_to_clean = []
 
         lbl = "<b>Build completed</b>\n\nClick 'Edit Image' to start another build or 'View Messages' to view the messages output during the build."
         if self.handler.building == "image" and self.build_succeeded:
-- 
1.7.4.1



