Return-Path: <seebs@msp-lpggp2.wrs.com>
Received: from msp-lpggp2.wrs.com (unknown [206.144.70.9])
	by mail.openembedded.org (Postfix) with ESMTP id 45EE86CF32
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Nov 2013 00:30:19 +0000 (UTC)
Received: by msp-lpggp2.wrs.com (Postfix, from userid 508)
	id E1443A01F05; Tue, 19 Nov 2013 18:31:40 -0600 (CST)
From: Peter Seebach <peter.seebach@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 19 Nov 2013 18:31:39 -0600
Message-Id: <de01254a667f743deae8545423ec7a3220649f80.1384907121.git.peter.seebach@windriver.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <cover.1384907121.git.peter.seebach@windriver.com>
References: <cover.1384907121.git.peter.seebach@windriver.com>
In-Reply-To: <cover.1384907121.git.peter.seebach@windriver.com>
References: <cover.1384907121.git.peter.seebach@windriver.com>
Subject: [PATCH 1/2] build.py: add single-quotes around already-expanded directory name
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 20 Nov 2013 00:30:19 -0000

If the computed name of a directory contains an undefined variable
reference, bitbake dutifully creates a directory with a name that has
${...} in it. However, the actual task script created then tries to cd
to that directory, and the cd command fails, because no such directory
exists -- because the shell has helpfully removed the ${...} which did
not match any actual variables.

Since we want the name to be used exactly-as-is, add single quotes around
the name so this doesn't cause strange failures running tasks, which
allows us to progress past such failures and get to a point where they
can be diagnosed.

Signed-off-by: Peter Seebach <peter.seebach@windriver.com>
---
 lib/bb/build.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index f9aca42..92c45a3 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -288,7 +288,7 @@ set -e
         if bb.msg.loggerVerboseLogs:
             script.write("set -x\n")
         if cwd:
-            script.write("cd %s\n" % cwd)
+            script.write("cd '%s'\n" % cwd)
         script.write("%s\n" % func)
         script.write('''
 # cleanup
-- 
1.7.1


