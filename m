Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <constantinx.musca@intel.com>) id 1TJeq5-0005Kq-NU
	for bitbake-devel@lists.openembedded.org;
	Thu, 04 Oct 2012 08:23:17 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 03 Oct 2012 23:10:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,532,1344236400"; d="scan'208";a="229762464"
Received: from costin-desktop (HELO localhost.localdomain) ([10.237.105.66])
	by fmsmga001.fm.intel.com with ESMTP; 03 Oct 2012 23:10:14 -0700
From: Constantin Musca <constantinx.musca@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  4 Oct 2012 08:15:52 +0300
Message-Id: <1349327752-25155-1-git-send-email-constantinx.musca@intel.com>
X-Mailer: git-send-email 1.7.9.5
Cc: Constantin Musca <constantinx.musca@intel.com>
Subject: [PATCH] hob/hobeventhandler: Throw an exception if runCommand fails
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
X-List-Received-Date: Thu, 04 Oct 2012 06:23:17 -0000

- throw a Hob exception if runCommand returns 'Busy' or
'No such command'

[YOCTO #1245]

Signed-off-by: Constantin Musca <constantinx.musca@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index e8d7dc2..2ce5b66 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -101,7 +101,12 @@ class HobHandler(gobject.GObject):
 
     def runCommand(self, commandline):
         try:
-            return self.server.runCommand(commandline)
+            result = self.server.runCommand(commandline)
+            result_str = str(result)
+            if (result_str.startswith("Busy (") or
+                    result_str == "No such command"):
+                raise Exception(result_str)
+            return result
         except Exception as e:
             self.commands_async = []
             self.clear_busy()
-- 
1.7.9.5



