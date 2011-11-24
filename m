Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RThYL-0002Ag-AE
	for bitbake-devel@lists.openembedded.org;
	Thu, 24 Nov 2011 23:13:58 +0100
Received: by opal (Postfix, from userid 111)
	id 2C89B1032F; Thu, 24 Nov 2011 22:09:55 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20111124220955.2C89B1032F@opal>
Date: Thu, 24 Nov 2011 22:09:55 +0000 (UTC)
From: git@git.openembedded.org
Subject: Richard Purdie : fetch2/local: Don't default to files in DL_DIR for file:// urls
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
Commit: 5597a68fac0954c682b67471722c2643e2415f99
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=5597a68fac0954c682b67471722c2643e2415f99

Author: Richard Purdie <richard.purdie@linuxfoundation.org>
Date:   Thu Nov 24 13:56:52 2011 +0000

fetch2/local: Don't default to files in DL_DIR for file:// urls

Defaulting to any file in DL_DIR as the first match for a file:// url
doesn't make much sense and can lead to unexpected results.

This patch changes the logic so this is the last fallback location
instead. Whether it should be using DL_DIR at all for this is a
good question but something for another patch.

[YOCTO #1710]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/fetch2/local.py |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/local.py b/lib/bb/fetch2/local.py
index 2bf92c9..a0ed444 100644
--- a/lib/bb/fetch2/local.py
+++ b/lib/bb/fetch2/local.py
@@ -50,9 +50,6 @@ class Local(FetchMethod):
         path = url.split("://")[1]
         path = path.split(";")[0]
         newpath = path
-        dldirfile = os.path.join(data.getVar("DL_DIR", d, True), os.path.basename(path))
-        if os.path.exists(dldirfile):
-            return dldirfile
         if path[0] != "/":
             filespath = data.getVar('FILESPATH', d, True)
             if filespath:
@@ -62,6 +59,7 @@ class Local(FetchMethod):
                 if filesdir:
                     newpath = os.path.join(filesdir, path)
         if not os.path.exists(newpath) and path.find("*") == -1:
+            dldirfile = os.path.join(data.getVar("DL_DIR", d, True), os.path.basename(path))
             return dldirfile
         return newpath
 



