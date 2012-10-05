Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <constantinx.musca@intel.com>) id 1TK87g-0000Sl-G9
	for bitbake-devel@lists.openembedded.org;
	Fri, 05 Oct 2012 15:39:24 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 05 Oct 2012 06:26:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,541,1344236400"; d="scan'208";a="202052925"
Received: from costin-desktop (HELO localhost.localdomain) ([10.237.105.66])
	by orsmga001.jf.intel.com with ESMTP; 05 Oct 2012 06:26:20 -0700
From: Constantin Musca <constantinx.musca@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  5 Oct 2012 15:31:59 +0300
Message-Id: <1349440319-23916-1-git-send-email-constantinx.musca@intel.com>
X-Mailer: git-send-email 1.7.9.5
Cc: Constantin Musca <constantinx.musca@intel.com>
Subject: [PATCH] hob/hobeventhandler: Describe the runCommand failure exception
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
X-List-Received-Date: Fri, 05 Oct 2012 13:39:24 -0000

[YOCTO #1245]

Signed-off-by: Constantin Musca <constantinx.musca@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 2ce5b66..5d038f4 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -105,7 +105,9 @@ class HobHandler(gobject.GObject):
             result_str = str(result)
             if (result_str.startswith("Busy (") or
                     result_str == "No such command"):
-                raise Exception(result_str)
+                raise Exception('%s has failed with output "%s". ' %
+                        (str(commandline), result_str) +
+                        "We recommend that you restart Hob.")
             return result
         except Exception as e:
             self.commands_async = []
-- 
1.7.9.5



