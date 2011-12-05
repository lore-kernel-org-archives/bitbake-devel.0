Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RXbJR-0006MX-Qm
	for bitbake-devel@lists.openembedded.org;
	Mon, 05 Dec 2011 17:22:42 +0100
Received: by opal (Postfix, from userid 111)
	id C48F71032F; Mon,  5 Dec 2011 16:19:47 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20111205161947.C48F71032F@opal>
Date: Mon,  5 Dec 2011 16:19:47 +0000 (UTC)
From: git@git.openembedded.org
Subject: Joshua Lock : fetch2: fix Exception parameters when BB_STRICT_CHECKSUM enabled
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
X-List-Received-Date: Mon, 05 Dec 2011 16:22:42 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: b8b2f4287c9125542b18a294c0a94ed89a7e73a8
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=b8b2f4287c9125542b18a294c0a94ed89a7e73a8

Author: Joshua Lock <josh@linux.intel.com>
Date:   Fri Dec  2 10:58:35 2011 -0800

fetch2: fix Exception parameters when BB_STRICT_CHECKSUM enabled

BB_STRICT_CHECKSUM caused a backtrace as the FetchError parameters are
incorrectly specified such that FetchError is being passed 8 params
when it's expecting 3. This fixes the parameters so we're passing a
formatted string and the url.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/fetch2/__init__.py |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 19a79fd..3af56e5 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -274,9 +274,9 @@ def verify_checksum(u, ud, d):
     strict = d.getVar("BB_STRICT_CHECKSUM", True) or None
     if (strict and ud.md5_expected == None and ud.sha256_expected == None):
         raise FetchError('No checksum specified for %s, please add at least one to the recipe:\n'
-                         'SRC_URI[%s] = "%s"\nSRC_URI[%s] = "%s"', u,
-                         ud.localpath, ud.md5_name, md5data,
-                         ud.sha256_name, sha256data)
+                         'SRC_URI[%s] = "%s"\nSRC_URI[%s] = "%s"' %
+                         (ud.localpath, ud.md5_name, md5data,
+                         ud.sha256_name, sha256data), u)
 
     # Log missing sums so user can more easily add them
     if ud.md5_expected == None:



