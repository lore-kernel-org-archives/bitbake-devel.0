Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RinFl-0001yQ-48
	for bitbake-devel@lists.openembedded.org;
	Thu, 05 Jan 2012 14:21:09 +0100
Received: by opal (Postfix, from userid 111)
	id A245E10331; Thu,  5 Jan 2012 13:21:29 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120105132129.A245E10331@opal>
Date: Thu,  5 Jan 2012 13:21:29 +0000 (UTC)
From: git@git.openembedded.org
Subject: Richard Purdie : build.py: Only use set -x when debug is enabled
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
X-List-Received-Date: Thu, 05 Jan 2012 13:21:09 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master-poky
Commit: ebaa9dc62246635efa634b7330d97606c6c02eb4
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=ebaa9dc62246635efa634b7330d97606c6c02eb4

Author: Richard Purdie <richard.purdie@linuxfoundation.org>
Date:   Wed Jun  8 20:28:31 2011 +0100

build.py: Only use set -x when debug is enabled

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/build.py |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 1a47fc5..aabc1b6 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -222,9 +222,9 @@ def exec_func_shell(function, d, runfile, cwd=None):
 
     with open(runfile, 'w') as script:
         script.write('#!/bin/sh -e\n')
+        if bb.msg.loggerDefaultVerbose:
+            script.write("set -x\n")
         data.emit_func(function, script, d)
-
-        script.write("set -x\n")
         if cwd:
             script.write("cd %s\n" % cwd)
         script.write("%s\n" % function)



