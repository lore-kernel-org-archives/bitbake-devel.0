Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <constantinx.musca@intel.com>) id 1TGniV-0000dm-W5
	for bitbake-devel@lists.openembedded.org;
	Wed, 26 Sep 2012 11:15:40 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 26 Sep 2012 02:02:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,489,1344236400"; d="scan'208";a="226661921"
Received: from costin-desktop (HELO localhost.localdomain) ([10.237.105.66])
	by fmsmga001.fm.intel.com with ESMTP; 26 Sep 2012 02:02:46 -0700
From: Constantin Musca <constantinx.musca@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 26 Sep 2012 11:08:15 +0300
Message-Id: <1348646895-20634-1-git-send-email-constantinx.musca@intel.com>
X-Mailer: git-send-email 1.7.9.5
Cc: Constantin Musca <constantinx.musca@intel.com>
Subject: [PATCH] hob/builder: When you stop a build, Hob should tell you stopping is happening
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
X-List-Received-Date: Wed, 26 Sep 2012 09:15:40 -0000

- use the progress bar text to indicate the stopping status
- the text should say: 'Stopping the build...'

[YOCTO #3152]

Signed-off-by: Constantin Musca <constantinx.musca@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 267fde1..4dbffd6 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -1375,6 +1375,8 @@ class Builder(gtk.Window):
         if response != gtk.RESPONSE_CANCEL:
             self.stopping = True
         if response == gtk.RESPONSE_OK:
+            self.build_details_page.progress_bar.set_title("Stopping the build...")
+            self.build_details_page.progress_bar.set_rcstyle("stop")
             self.cancel_build_sync()
         elif response == gtk.RESPONSE_YES:
             self.cancel_build_sync(True)
-- 
1.7.9.5



