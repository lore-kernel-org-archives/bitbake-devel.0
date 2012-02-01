Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RsbqD-00075Y-FX
	for bitbake-devel@lists.openembedded.org;
	Wed, 01 Feb 2012 16:11:21 +0100
Received: by opal (Postfix, from userid 111)
	id 9428910339; Wed,  1 Feb 2012 15:03:46 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120201150346.9428910339@opal>
Date: Wed,  1 Feb 2012 15:03:46 +0000 (UTC)
From: git@git.openembedded.org
Subject: Lianhao Lu : prserv: Do not ping PRService if not required
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
X-List-Received-Date: Wed, 01 Feb 2012 15:11:21 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 20f24de0bdafac21f5d8a58701f977efa7041288
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=20f24de0bdafac21f5d8a58701f977efa7041288

Author: Lianhao Lu <lianhao.lu@intel.com>
Date:   Tue Jan 31 14:18:04 2012 +0800

prserv: Do not ping PRService if not required

[YOCTO #1942]
Ping the PRService only if PRSERV_HOST and PRSERV_PORT are set.

Signed-off-by: Lianhao Lu <lianhao.lu@intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/prserv/serv.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index fa437f9..5567c6f 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -268,7 +268,7 @@ def is_local_special(host, port):
 
 def auto_start(d):
     global singleton
-    if d.getVar('USE_PR_SERV', True) == '0':
+    if (not d.getVar('PRSERV_HOST', True)) or (not d.getVar('PRSERV_PORT', True)):
         return True
 
     if is_local_special(d.getVar('PRSERV_HOST', True), int(d.getVar('PRSERV_PORT', True))) and not singleton:



