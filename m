Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1Rin6T-0001hn-DC
	for bitbake-devel@lists.openembedded.org;
	Thu, 05 Jan 2012 14:11:33 +0100
Received: by opal (Postfix, from userid 111)
	id 0FFD610335; Thu,  5 Jan 2012 13:11:53 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120105131153.0FFD610335@opal>
Date: Thu,  5 Jan 2012 13:11:53 +0000 (UTC)
From: git@git.openembedded.org
Subject: Richard Purdie : cooker.py: Add missing BB_WORKERCONTEXT conditionals
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
Commit: bc954f74620959703a0e921fcac3a6892675fe0d
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=bc954f74620959703a0e921fcac3a6892675fe0d

Author: Richard Purdie <richard.purdie@linuxfoundation.org>
Date:   Thu Jan  5 13:01:36 2012 +0000

cooker.py: Add missing BB_WORKERCONTEXT conditionals

Its desireable to run be able to execute bitbake tasks directly, only
loading as much of the cooker is as necessary to do this. This use case
can be identified by the BB_WORKERCONTEXT variable. There were a couple
of places cooker code needed to be conditional on this but wasn't. This
brings in the missing conditionals from poky where those code paths
are used more heavily completing the support in master.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/cooker.py |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 27abca0..15243f2 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -170,6 +170,9 @@ class BBCooker:
     def loadConfigurationData(self):
         self.configuration.data = bb.data.init()
 
+        if not self.server_registration_cb:
+            self.configuration.data.setVar("BB_WORKERCONTEXT", "1")
+
         filtered_keys = bb.utils.approved_variables()
         bb.data.inheritFromOS(self.configuration.data, self.savedenv, filtered_keys)
 
@@ -827,7 +830,8 @@ class BBCooker:
         for var in data.getVar('__BBHANDLERS') or []:
             bb.event.register(var, data.getVar(var))
 
-        bb.fetch.fetcher_init(data)
+        if data.getVar("BB_WORKERCONTEXT", False) is None:
+            bb.fetch.fetcher_init(data)
         bb.codeparser.parser_cache_init(data)
         bb.parse.init_parser(data)
         bb.event.fire(bb.event.ConfigParsed(), data)



