Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1Rin6T-0001ho-EA
	for bitbake-devel@lists.openembedded.org;
	Thu, 05 Jan 2012 14:11:33 +0100
Received: by opal (Postfix, from userid 111)
	id D15BB10331; Thu,  5 Jan 2012 13:11:52 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120105131152.D15BB10331@opal>
Date: Thu,  5 Jan 2012 13:11:52 +0000 (UTC)
From: git@git.openembedded.org
Subject: Richard Purdie : cooker.py: Convert a bb.data. expand refernce to the updated syntax
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
X-List-Received-Date: Thu, 05 Jan 2012 13:11:33 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 4483dc4bc4711cd8e144078090727348beb24879
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=4483dc4bc4711cd8e144078090727348beb24879

Author: Richard Purdie <richard.purdie@linuxfoundation.org>
Date:   Thu Jan  5 12:57:12 2012 +0000

cooker.py: Convert a bb.data.expand refernce to the updated syntax

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/cooker.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index cbe0d71..27abca0 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -137,7 +137,7 @@ class BBCooker:
 
         # Take a lock so only one copy of bitbake can run against a given build
         # directory at a time
-        lockfile = bb.data.expand("${TOPDIR}/bitbake.lock", self.configuration.data)
+        lockfile = self.configuration.data.expand("${TOPDIR}/bitbake.lock")
         self.lock = bb.utils.lockfile(lockfile, False, False)
         if not self.lock:
             bb.fatal("Only one copy of bitbake should be run against a build directory")



