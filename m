Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1R61ur-0000rF-1j
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Sep 2011 17:07:21 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 20 Sep 2011 08:02:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,411,1312182000"; d="scan'208";a="18826195"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.183])
	by AZSMGA002.ch.intel.com with ESMTP; 20 Sep 2011 08:01:59 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 20 Sep 2011 08:01:51 -0700
Message-Id: <705156e2812afb288632f01416fcbbf9add26bee.1316530820.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6.2
In-Reply-To: <cover.1316530819.git.josh@linux.intel.com>
References: <cover.1316530819.git.josh@linux.intel.com>
In-Reply-To: <cover.1316530819.git.josh@linux.intel.com>
References: <cover.1316530819.git.josh@linux.intel.com>
Subject: [PATCH 3/3] hob: enable package only builds even if an image has been built
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
X-List-Received-Date: Tue, 20 Sep 2011 15:07:21 -0000

Once an image build has been performed the selected_image variable would
prevent the package only build choice being triggered - by setting the
variable to None on reset we are able to perform package only builds after
an image build.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/hob.py |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index 0f738ce..e696314 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -322,6 +322,7 @@ class MainWindow (gtk.Window):
         if response == gtk.RESPONSE_OK:
             self.reset_build()
             self.search.set_text("")
+            self.selected_image = None
         return
 
     def reset_build(self):
-- 
1.7.6.2



