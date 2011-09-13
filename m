Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1R3Vod-0001je-9W
	for bitbake-devel@lists.openembedded.org;
	Tue, 13 Sep 2011 18:26:31 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 13 Sep 2011 09:21:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,375,1312182000"; d="scan'208";a="50818020"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.59])
	by fmsmga001.fm.intel.com with ESMTP; 13 Sep 2011 09:21:16 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 13 Sep 2011 09:21:09 -0700
Message-Id: <f4be83aae77a713e2b5a2d094651639b6e641031.1315927921.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1315927921.git.josh@linux.intel.com>
References: <cover.1315927921.git.josh@linux.intel.com>
In-Reply-To: <cover.1315927921.git.josh@linux.intel.com>
References: <cover.1315927921.git.josh@linux.intel.com>
Subject: [PATCH 4/4] hob: correctly set the selected image when loading a recipe
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

When the user saves their recipe based on an existing image type, loads it
in a newly run hob instance and clicks bake they should not be asked about
building packages vs an empty image up.

Partially addresses [YOCTO #1468]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/hob.py |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index 8d2d1bd..51a995e 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -144,6 +144,7 @@ class MainWindow (gtk.Window):
         self.build_succeeded = False
 
     def image_changed_string_cb(self, model, new_image):
+        self.selected_image = new_image
         # disconnect the image combo's signal handler
         if self.image_combo_id:
             self.image_combo.disconnect(self.image_combo_id)
-- 
1.7.6



