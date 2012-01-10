Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1Rkfjf-0005OV-8Q
	for bitbake-devel@lists.openembedded.org;
	Tue, 10 Jan 2012 18:43:47 +0100
Received: by opal (Postfix, from userid 111)
	id 4EE501032F; Tue, 10 Jan 2012 17:44:36 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120110174436.4EE501032F@opal>
Date: Tue, 10 Jan 2012 17:44:36 +0000 (UTC)
From: git@git.openembedded.org
Subject: Dongxiao Xu : command.py: add parseConfigurationFiles API
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
X-List-Received-Date: Tue, 10 Jan 2012 17:43:47 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 96c307b9874131ad8c7d9caea6f6dfbd09aab9d4
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=96c307b9874131ad8c7d9caea6f6dfbd09aab9d4

Author: Dongxiao Xu <dongxiao.xu@intel.com>
Date:   Fri Jan  6 17:02:23 2012 +0800

command.py: add parseConfigurationFiles API

The parseConfigurationFiles API calls the related function in
cooker.py to parse config files.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/command.py |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index bd41f54..f236dac 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -337,3 +337,13 @@ class CommandsAsync:
         else:
             command.finishAsyncCommand()
     compareRevisions.needcache = True
+
+    def parseConfigurationFiles(self, command, params):
+        """
+        Parse the configuration files
+        """
+        prefiles = params[0]
+        postfiles = params[1]
+        command.cooker.parseConfigurationFiles(prefiles, postfiles)
+        command.finishAsyncCommand()
+    parseConfigurationFiles.needcache = False



