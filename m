Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RW5V3-0004AJ-MG
	for bitbake-devel@lists.openembedded.org;
	Thu, 01 Dec 2011 13:12:26 +0100
Received: by opal (Postfix, from userid 111)
	id 9EA8D1032F; Thu,  1 Dec 2011 12:09:04 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20111201120904.9EA8D1032F@opal>
Date: Thu,  1 Dec 2011 12:09:04 +0000 (UTC)
From: git@git.openembedded.org
Subject: Richard Purdie : build.py: Be determistic about a function's cwd
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
X-List-Received-Date: Thu, 01 Dec 2011 12:12:26 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: ef0888f83fa4408eb768257d7e03700202faad18
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=ef0888f83fa4408eb768257d7e03700202faad18

Author: Richard Purdie <richard.purdie@linuxfoundation.org>
Date:   Thu Dec  1 11:58:41 2011 +0000

build.py: Be determistic about a function's cwd

There is a subtle but nasty problem that a function's cwd can vary
depending on whether ${B} (often ${S}) exists before the funciton is
called or not. Most functions in the system can cope with this but
its bad practise and I've just witnessed build failures resulting
from this during image generation from bootimg.bbclass. I also
suspect this could explain some odd fetcher behaviour witnessed in
the past.

This change ensures we always call funcitons with a specific build
directory making things deterministic.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/build.py |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 6982a0a..a9ce14f 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -149,8 +149,7 @@ def exec_func(func, d, dirs = None):
         adir = dirs[-1]
     else:
         adir = data.getVar('B', d, 1)
-        if not os.path.exists(adir):
-            adir = None
+        bb.utils.mkdirhier(adir)
 
     ispython = flags.get('python')
 



