Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1R3Voa-0001jT-Ow
	for bitbake-devel@lists.openembedded.org;
	Tue, 13 Sep 2011 18:26:28 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 13 Sep 2011 09:21:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,375,1312182000"; d="scan'208";a="50818016"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.59])
	by fmsmga001.fm.intel.com with ESMTP; 13 Sep 2011 09:21:15 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 13 Sep 2011 09:21:06 -0700
Message-Id: <09f5aed2edb0b8f4a6570e1041b5db66cf2d17cc.1315927921.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1315927921.git.josh@linux.intel.com>
References: <cover.1315927921.git.josh@linux.intel.com>
In-Reply-To: <cover.1315927921.git.josh@linux.intel.com>
References: <cover.1315927921.git.josh@linux.intel.com>
Subject: [PATCH 1/4] ui/crumbs/hobeventhandler: fix test for BBFILES
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
X-List-Received-Date: Tue, 13 Sep 2011 16:26:29 -0000

It seems we have a race whereby the image_dir variable may not be set
before it's tested for, since the variable is always the same set it in the
initialiser.

Partially addresses [YOCTO #1468]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hobeventhandler.py |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index 66dffac..4ed6590 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -77,7 +77,7 @@ class HobHandler(gobject.GObject):
         self.generating = False
         self.build_queue = []
         self.current_phase = None
-        self.image_dir = None
+        self.image_dir = os.path.join(tempfile.gettempdir(), 'hob-images')
 
         self.model = taskmodel
         self.server = server
@@ -329,7 +329,6 @@ class HobHandler(gobject.GObject):
         return self.server.runCommand(["getVariable", "DEPLOY_DIR_IMAGE"])
 
     def make_temp_dir(self):
-        self.image_dir = os.path.join(tempfile.gettempdir(), 'hob-images')
         bb.utils.mkdirhier(self.image_dir)
 
     def remove_temp_dir(self):
-- 
1.7.6



