Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RoHeB-0003vs-Dz
	for bitbake-devel@lists.openembedded.org;
	Fri, 20 Jan 2012 17:49:03 +0100
Received: by opal (Postfix, from userid 111)
	id B0C6B10339; Fri, 20 Jan 2012 16:50:58 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120120165058.B0C6B10339@opal>
Date: Fri, 20 Jan 2012 16:50:58 +0000 (UTC)
From: git@git.openembedded.org
Subject: Paul Eggleton : bitbake/fetch2: allow resuming interrupted fetch
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
X-List-Received-Date: Fri, 20 Jan 2012 16:49:03 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 721e986624529aedef96dd06c9fe6243f2897b10
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=721e986624529aedef96dd06c9fe6243f2897b10

Author: Paul Eggleton <paul.eggleton@linux.intel.com>
Date:   Mon Jan 16 15:01:08 2012 +0000

bitbake/fetch2: allow resuming interrupted fetch

A lot of our checks in the fetcher code assume that if the downloaded
file exists, the download finished successfully; this meant that if
BitBake was interrupted in the middle of a fetch then it would not
resume the fetch the next time, but instead attempt to use the
half-fetched file and usually fail as a result.

Since we're already writing a ".done" stamp file when a fetch completes,
just check for its existence and assume the download didn't complete
successfully if it isn't present.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/fetch2/__init__.py |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index fe4f4b1..07aac4c 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -479,7 +479,7 @@ def try_mirrors(d, origud, mirrors, check = False):
                     return found
                 continue
 
-            if ud.method.need_update(newuri, ud, ld):
+            if not os.path.exists(ud.donestamp) or ud.method.need_update(newuri, ud, ld):
                 ud.method.download(newuri, ud, ld)
                 if hasattr(ud.method,"build_mirror_data"):
                     ud.method.build_mirror_data(newuri, ud, ld)
@@ -955,7 +955,7 @@ class Fetch(object):
             try:
                 self.d.setVar("BB_NO_NETWORK", network)
  
-                if not m.need_update(u, ud, self.d):
+                if os.path.exists(ud.donestamp) and not m.need_update(u, ud, self.d):
                     localpath = ud.localpath
                 elif m.try_premirror(u, ud, self.d):
                     logger.debug(1, "Trying PREMIRRORS")
@@ -966,7 +966,7 @@ class Fetch(object):
                     self.d.setVar("BB_NO_NETWORK", "1")
 
                 firsterr = None
-                if not localpath and m.need_update(u, ud, self.d):
+                if not localpath and ((not os.path.exists(ud.donestamp)) or m.need_update(u, ud, self.d)):
                     try:
                         logger.debug(1, "Trying Upstream")
                         m.download(u, ud, self.d)



