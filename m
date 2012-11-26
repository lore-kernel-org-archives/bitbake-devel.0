Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristian.iorga@intel.com>) id 1Td35G-0005MP-NM
	for bitbake-devel@lists.openembedded.org;
	Mon, 26 Nov 2012 19:07:07 +0100
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 26 Nov 2012 09:52:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.83,321,1352102400"; d="scan'208";a="172731326"
Received: from sentry (HELO localhost.localdomain) ([10.237.105.157])
	by AZSMGA002.ch.intel.com with ESMTP; 26 Nov 2012 09:52:23 -0800
From: Cristian Iorga <cristian.iorga@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 26 Nov 2012 19:52:35 +0200
Message-Id: <1353952355-18605-1-git-send-email-cristian.iorga@intel.com>
X-Mailer: git-send-email 1.7.10.4
Subject: [PATCH] bitbake: fix for mixed-up wget commands
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
X-List-Received-Date: Mon, 26 Nov 2012 18:07:08 -0000

wget commands for check and resume were
mixed-up, leading to the following issues:

1. long running "NOTE: Preparing runqueue"
reason: objects were downloaded, not spidered on the mirror
2. Failing network test in Build Appliance, because wget 1.14
(in use in BA) will fail if a file already exists.
During the network connectivity test, index.php file was
actually downloaded, not spidered (checked for existence on
yoctoproject.org website), leading to wget failure.

Signed-off-by: Cristian Iorga <cristian.iorga@intel.com>
---
 bitbake/lib/bb/fetch2/wget.py |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index ea99198..2808df6 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -69,10 +69,10 @@ class Wget(FetchMethod):
             basecmd += " -O ${DL_DIR}/" + ud.localfile
 
         if checkonly:
-            fetchcmd = d.getVar("CHECKCOMMAND_wget", True) or d.expand(basecmd + " -c -P ${DL_DIR} '${URI}'")
+            fetchcmd = d.getVar("CHECKCOMMAND_wget", True) or d.expand(basecmd + " --spider '${URI}'")
         elif os.path.exists(ud.localpath):
             # file exists, but we didnt complete it.. trying again..
-            fetchcmd = d.getVar("RESUMECOMMAND_wget", True) or d.expand(basecmd + " --spider -P ${DL_DIR} '${URI}'")
+            fetchcmd = d.getVar("RESUMECOMMAND_wget", True) or d.expand(basecmd + " -c -P ${DL_DIR} '${URI}'")
         else:
             fetchcmd = d.getVar("FETCHCOMMAND_wget", True) or d.expand(basecmd + " -P ${DL_DIR} '${URI}'")
 
-- 
1.7.10.4



