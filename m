Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RmN5x-00085C-U9
	for bitbake-devel@lists.openembedded.org;
	Sun, 15 Jan 2012 11:13:50 +0100
Received: by opal (Postfix, from userid 111)
	id 2EE5D10338; Sun, 15 Jan 2012 10:15:11 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120115101511.2EE5D10338@opal>
Date: Sun, 15 Jan 2012 10:15:11 +0000 (UTC)
From: git@git.openembedded.org
Subject: Paul Eggleton : bitbake/fetch2: reduce output for fetch failures
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
X-List-Received-Date: Sun, 15 Jan 2012 10:13:50 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 6bbdc7d259c0cc041b62dbdb26cfc3ec6edcb6f3
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=6bbdc7d259c0cc041b62dbdb26cfc3ec6edcb6f3

Author: Paul Eggleton <paul.eggleton@linux.intel.com>
Date:   Fri Jan 13 17:01:50 2012 +0000

bitbake/fetch2: reduce output for fetch failures

Make the warning for the initial fetch failure a single line - we don't
need the full command and output here yet, but write it into the log in
full as a debug message. However, if fetching from mirrors fails as well
then print out the full details for the first error that occurred as an
ERROR rather than a WARNING.

Since this is logged as an ERROR, combined with an earlier patch it
suppresses the full log which does make the output much more readable
for any fetch error.

Fixes [YOCTO #1832].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/fetch2/__init__.py |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 771f72e..fe4f4b1 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -965,6 +965,7 @@ class Fetch(object):
                 if premirroronly:
                     self.d.setVar("BB_NO_NETWORK", "1")
 
+                firsterr = None
                 if not localpath and m.need_update(u, ud, self.d):
                     try:
                         logger.debug(1, "Trying Upstream")
@@ -980,7 +981,9 @@ class Fetch(object):
                         raise
 
                     except BBFetchException as e:
-                        logger.warn(str(e))
+                        logger.warn('Failed to fetch URL %s' % u)
+                        logger.debug(1, str(e))
+                        firsterr = e
                         # Remove any incomplete fetch
                         if os.path.isfile(ud.localpath):
                             bb.utils.remove(ud.localpath)
@@ -989,6 +992,8 @@ class Fetch(object):
                         localpath = try_mirrors (self.d, ud, mirrors)
 
                 if not localpath or ((not os.path.exists(localpath)) and localpath.find("*") == -1):
+                    if firsterr:
+                        logger.error(str(firsterr))
                     raise FetchError("Unable to fetch URL from any source.", u)
 
                 update_stamp(u, ud, self.d)



