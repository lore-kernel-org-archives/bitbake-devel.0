Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1S9akh-0005Xh-Ux
	for bitbake-devel@lists.openembedded.org;
	Mon, 19 Mar 2012 12:27:52 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 19 Mar 2012 04:18:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="130481771"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.123.198])
	by fmsmga001.fm.intel.com with ESMTP; 19 Mar 2012 04:18:59 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 19 Mar 2012 11:18:58 +0000
Message-Id: <1332155938-5552-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
Subject: [PATCH] bitbake-layers: fix traceback in show-overlayed with nothing overlayed
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
X-List-Received-Date: Mon, 19 Mar 2012 11:27:52 -0000

There is no logger.note, use logger.plain instead (which is what we
really want here anyway.)

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake-layers |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index c85e26e..bbd56fe 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -213,7 +213,7 @@ Options:
             items_listed = True;
 
         if not items_listed:
-            logger.note('No overlayed files found')
+            logger.plain('No overlayed files found.')
 
 
     def do_show_recipes(self, args):
-- 
1.7.5.4



