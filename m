Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1ROT59-0002R3-5q
	for bitbake-devel@lists.openembedded.org;
	Thu, 10 Nov 2011 12:46:11 +0100
Received: by opal (Postfix, from userid 111)
	id B6BF31032E; Thu, 10 Nov 2011 11:40:38 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20111110114038.B6BF31032E@opal>
Date: Thu, 10 Nov 2011 11:40:38 +0000 (UTC)
From: git@git.openembedded.org
Subject: Richard Purdie : utils.py: Fix lockfile retry handling
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
X-List-Received-Date: Thu, 10 Nov 2011 11:46:11 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: f421ef819f00ac659504d9af41bcc8323422ff8c
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=f421ef819f00ac659504d9af41bcc8323422ff8c

Author: Richard Purdie <richard.purdie@linuxfoundation.org>
Date:   Tue Nov  8 17:49:32 2011 +0000

utils.py: Fix lockfile retry handling

The lockfile retry parameter is expected to return immediately after
attempting to take the lock. There was a bug in the logic which this
patch fixed to ensure it does that.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/utils.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 1f55407..f905702 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -443,7 +443,7 @@ def lockfile(name, shared=False, retry=True):
                     return lf
             lf.close()
         except Exception:
-            continue
+            pass
         if not retry:
             return None
 



