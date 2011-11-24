Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RThYL-0002Aj-A8
	for bitbake-devel@lists.openembedded.org;
	Thu, 24 Nov 2011 23:13:58 +0100
Received: by opal (Postfix, from userid 111)
	id 8BC1710335; Thu, 24 Nov 2011 22:09:55 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20111124220955.8BC1710335@opal>
Date: Thu, 24 Nov 2011 22:09:55 +0000 (UTC)
From: git@git.openembedded.org
Subject: Richard Purdie : fetch2: Improve uri_replace to handle paths with no trailing '/'
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
X-List-Received-Date: Thu, 24 Nov 2011 22:13:59 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: a0246bf09c93bb657eaf6ba61d090b247ed33640
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=a0246bf09c93bb657eaf6ba61d090b247ed33640

Author: Richard Purdie <richard.purdie@linuxfoundation.org>
Date:   Thu Nov 24 16:11:26 2011 +0000

fetch2: Improve uri_replace to handle paths with no trailing '/'

Currently if you specify a mirror like:

file://.* http://linux.freescale.net/yocto/sstate-cache

it won't work as you expect whilst:

file://.* http://linux.freescale.net/yocto/sstate-cache/

will since it has the trailing slash.

This patch handles both cases correctly. It also adds some debug to
the uri_replace function since its near impossible to debug it without
some kind of output.

[YOCTO #1578]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/fetch2/__init__.py |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index a055faa..d3c761d 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -175,6 +175,7 @@ def uri_replace(ud, uri_find, uri_replace, d):
     uri_decoded = list(decodeurl(ud.url))
     uri_find_decoded = list(decodeurl(uri_find))
     uri_replace_decoded = list(decodeurl(uri_replace))
+    logger.debug(2, "For url %s comparing %s to %s" % (uri_decoded, uri_find_decoded, uri_replace_decoded))
     result_decoded = ['', '', '', '', '', {}]
     for i in uri_find_decoded:
         loc = uri_find_decoded.index(i)
@@ -187,12 +188,18 @@ def uri_replace(ud, uri_find, uri_replace, d):
                     result_decoded[loc] = re.sub(i, uri_replace_decoded[loc], uri_decoded[loc])
                 if uri_find_decoded.index(i) == 2:
                     if ud.mirrortarball:
-                        result_decoded[loc] = os.path.join(os.path.dirname(result_decoded[loc]), os.path.basename(ud.mirrortarball))
+                        if result_decoded[loc].endswith("/"):
+                            result_decoded[loc] = os.path.dirname(result_decoded[loc])
+                        result_decoded[loc] = os.path.join(result_decoded[loc], os.path.basename(ud.mirrortarball))
                     elif ud.localpath:
-                        result_decoded[loc] = os.path.join(os.path.dirname(result_decoded[loc]), os.path.basename(ud.localpath))
+                        if result_decoded[loc].endswith("/"):
+                            result_decoded[loc] = os.path.dirname(result_decoded[loc])
+                        result_decoded[loc] = os.path.join(result_decoded[loc], os.path.basename(ud.localpath))
             else:
                 return ud.url
-    return encodeurl(result_decoded)
+    result = encodeurl(result_decoded)
+    logger.debug(2, "For url %s returning %s" % (ud.url, result))
+    return result
 
 methods = []
 urldata_cache = {}



