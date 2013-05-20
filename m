Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1UeSBe-0006Ia-HN
	for bitbake-devel@lists.openembedded.org;
	Mon, 20 May 2013 17:39:54 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 20 May 2013 08:20:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,707,1363158000"; d="scan'208";a="244169580"
Received: from unknown (HELO helios.amr.corp.intel.com) ([10.255.12.168])
	by AZSMGA002.ch.intel.com with ESMTP; 20 May 2013 08:20:19 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 20 May 2013 16:20:14 +0100
Message-Id: <8ad4975c3bd80f7b1e9050f42241ad7ac5960d3f.1369063091.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1369063091.git.paul.eggleton@linux.intel.com>
References: <cover.1369063091.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1369063091.git.paul.eggleton@linux.intel.com>
References: <cover.1369063091.git.paul.eggleton@linux.intel.com>
Subject: [1.18][PATCH 1/3] goggle: fix invalid error check
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
X-List-Received-Date: Mon, 20 May 2013 15:40:07 -0000

From: Martin Donnelly <martin.donnelly@ge.com>

runCommand was returning 'error' but checking for 'err'
resulting in an exception.

(Bitbake master rev: 263aa44ed47e0cb03e1a97e7ed4a50bd9f828c78)

Signed-off-by: Martin Donnelly <martin.donnelly@ge.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bitbake/lib/bb/ui/goggle.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/goggle.py b/bitbake/lib/bb/ui/goggle.py
index c0785b7..e8a54ab 100644
--- a/bitbake/lib/bb/ui/goggle.py
+++ b/bitbake/lib/bb/ui/goggle.py
@@ -81,7 +81,7 @@ def main (server, eventHandler):
 
     try:
         cmdline, error = server.runCommand(["getCmdLineAction"])
-        if err:
+        if error:
             print("Error getting bitbake commandline: %s" % error)
             return 1
         elif not cmdline:
-- 
1.8.1.2



