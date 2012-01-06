Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RjCFS-0001In-Fs
	for bitbake-devel@lists.openembedded.org;
	Fri, 06 Jan 2012 17:02:30 +0100
Received: by opal (Postfix, from userid 111)
	id EB46B10331; Fri,  6 Jan 2012 16:02:56 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120106160256.EB46B10331@opal>
Date: Fri,  6 Jan 2012 16:02:56 +0000 (UTC)
From: git@git.openembedded.org
Subject: Dongxiao Xu : cooker: user bb.configuration.data to inject events
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
X-List-Received-Date: Fri, 06 Jan 2012 16:02:30 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 487a124942fd5cd9de71413b79a4049a6d26f1e8
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=487a124942fd5cd9de71413b79a4049a6d26f1e8

Author: Dongxiao Xu <dongxiao.xu@intel.com>
Date:   Fri Jan  6 17:02:21 2012 +0800

cooker: user bb.configuration.data to inject events

For buildTargets function, we use bb.configuration.data as parameter
to inject events, since in hob environment, some variables are
modified dynamically and bb.configuration.event_data may out of date.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/cooker.py |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 15243f2..6473839 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1088,7 +1088,7 @@ class BBCooker:
                 return False
 
             if not retval:
-                bb.event.fire(bb.event.BuildCompleted(buildname, targets, failures), self.configuration.event_data)
+                bb.event.fire(bb.event.BuildCompleted(buildname, targets, failures), self.configuration.data)
                 self.command.finishAsyncCommand()
                 return False
             if retval is True:
@@ -1098,7 +1098,7 @@ class BBCooker:
         self.buildSetVars()
 
         buildname = self.configuration.data.getVar("BUILDNAME")
-        bb.event.fire(bb.event.BuildStarted(buildname, targets), self.configuration.event_data)
+        bb.event.fire(bb.event.BuildStarted(buildname, targets), self.configuration.data)
 
         localdata = data.createCopy(self.configuration.data)
         bb.data.update_data(localdata)



