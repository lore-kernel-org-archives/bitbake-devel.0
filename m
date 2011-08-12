Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1QruRk-0007qD-5D
	for bitbake-devel@lists.openembedded.org;
	Fri, 12 Aug 2011 18:18:58 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 12 Aug 2011 09:14:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,363,1309762800"; d="scan'208";a="38827058"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.255.18.64])
	by fmsmga002.fm.intel.com with ESMTP; 12 Aug 2011 09:14:03 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Aug 2011 17:13:57 +0100
Message-Id: <db090f5e5d300cc236d806ac01ca27cfaf418508.1313165343.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1313165343.git.paul.eggleton@linux.intel.com>
References: <cover.1313165343.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1313165343.git.paul.eggleton@linux.intel.com>
References: <cover.1313165343.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/4] bitbake-layers: show help with no command specified
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
X-List-Received-Date: Fri, 12 Aug 2011 16:18:59 -0000

Instead of running show_appends when no command is specified, show the
default help text. Running show_appends by default made sense previously
when that was the only real command provided, but now we have several
useful commands implemented.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/bin/bitbake-layers |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/bitbake/bin/bitbake-layers b/bitbake/bin/bitbake-layers
index 0900d00..2845ae5 100755
--- a/bitbake/bin/bitbake-layers
+++ b/bitbake/bin/bitbake-layers
@@ -2,9 +2,7 @@
 
 # This script has subcommands which operate against your bitbake layers, either
 # displaying useful information, or acting against them.
-# Currently, it only provides a show_appends command, which shows you what
-# bbappends are in effect, and warns you if you have appends which are not being
-# utilized.
+# See the help output for details on available commands.
 
 import cmd
 import logging
@@ -23,7 +21,6 @@ from bb.cooker import state
 
 
 logger = logging.getLogger('BitBake')
-default_cmd = 'show_appends'
 
 
 def main(args):
@@ -34,7 +31,7 @@ def main(args):
     if args:
         cmds.onecmd(' '.join(args))
     else:
-        cmds.onecmd(default_cmd)
+        cmds.do_help('')
     return cmds.returncode
 
 
-- 
1.7.4.1



