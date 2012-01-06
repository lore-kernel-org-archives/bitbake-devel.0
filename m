Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RjCFT-0001Im-IZ
	for bitbake-devel@lists.openembedded.org;
	Fri, 06 Jan 2012 17:02:32 +0100
Received: by opal (Postfix, from userid 111)
	id CCFF51032F; Fri,  6 Jan 2012 16:02:56 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120106160256.CCFF51032F@opal>
Date: Fri,  6 Jan 2012 16:02:56 +0000 (UTC)
From: git@git.openembedded.org
Subject: Dongxiao Xu : command.py: Modify needcache value for certain functions
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
X-List-Received-Date: Fri, 06 Jan 2012 16:02:34 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 3ef73dee8b08ccfd15a4901cce315a99b22e71d7
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=3ef73dee8b08ccfd15a4901cce315a99b22e71d7

Author: Dongxiao Xu <dongxiao.xu@intel.com>
Date:   Fri Jan  6 17:02:19 2012 +0800

command.py: Modify needcache value for certain functions

for findConfigFiels() and findFilesMatchingInDir() functions, they
don't need to parse all the bb files, thus setting the needcache
value to be False.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/command.py |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 83907f6..5dec6a9 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -241,7 +241,7 @@ class CommandsAsync:
 
         command.cooker.findConfigFiles(varname)
         command.finishAsyncCommand()
-    findConfigFiles.needcache = True
+    findConfigFiles.needcache = False
 
     def findFilesMatchingInDir(self, command, params):
         """
@@ -253,7 +253,7 @@ class CommandsAsync:
 
         command.cooker.findFilesMatchingInDir(pattern, directory)
         command.finishAsyncCommand()
-    findFilesMatchingInDir.needcache = True
+    findFilesMatchingInDir.needcache = False
 
     def findConfigFilePath(self, command, params):
         """



