Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1ROT59-0002R5-V7
	for bitbake-devel@lists.openembedded.org;
	Thu, 10 Nov 2011 12:46:12 +0100
Received: by opal (Postfix, from userid 111)
	id CF0C510330; Thu, 10 Nov 2011 11:40:38 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20111110114038.CF0C510330@opal>
Date: Thu, 10 Nov 2011 11:40:38 +0000 (UTC)
From: git@git.openembedded.org
Subject: Richard Purdie : cooker.py: Ensure only one copy of bitbake executes at once
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
X-List-Received-Date: Thu, 10 Nov 2011 11:46:12 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 6004cbf36c980c2574c1c9153df81a7c55317e17
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=6004cbf36c980c2574c1c9153df81a7c55317e17

Author: Richard Purdie <richard.purdie@linuxfoundation.org>
Date:   Tue Nov  8 17:52:44 2011 +0000

cooker.py: Ensure only one copy of bitbake executes at once

The bitbake codebase makes assumptions that only one copy is active
against a given build directory at a given time. This patch adds a
lockfile in TOPDIR to ensure that is the case.

Note that no unlock is needed, that is automatically dropped when
execution terminates.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/cooker.py |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 546a92c..ee8323e 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -135,6 +135,13 @@ class BBCooker:
         self.configuration.data = None
         self.loadConfigurationData()
 
+        # Take a lock so only one copy of bitbake can run against a given build
+        # directory at a time
+        lockfile = bb.data.expand("${TOPDIR}/bitbake.lock", self.configuration.data)
+        self.lock = bb.utils.lockfile(lockfile, False, False)
+        if not self.lock:
+            bb.fatal("Only one copy of bitbake should be run against a build directory")
+
         bbpkgs = bb.data.getVar('BBPKGS', self.configuration.data, True)
         if bbpkgs and len(self.configuration.pkgs_to_build) == 0:
             self.configuration.pkgs_to_build.extend(bbpkgs.split())



