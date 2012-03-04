Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S42lK-0004qw-QM for bitbake-devel@lists.openembedded.org;
	Sun, 04 Mar 2012 05:09:35 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q244128c020114
	for <bitbake-devel@lists.openembedded.org>; Sun, 4 Mar 2012 04:01:02 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 19635-10 for <bitbake-devel@lists.openembedded.org>;
	Sun,  4 Mar 2012 04:00:57 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2440ppR020108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>; Sun, 4 Mar 2012 04:00:54 GMT
Message-ID: <1330833655.3949.3.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sat, 03 Mar 2012 20:00:55 -0800
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] bitbake: Drop fetch v1, v2 provides a much better codebase to build from
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
X-List-Received-Date: Sun, 04 Mar 2012 04:09:35 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/__init__.py       |    5 +-
 lib/bb/fetch/__init__.py |  832 ----------------------------------------------
 lib/bb/fetch/bzr.py      |  148 --------
 lib/bb/fetch/cvs.py      |  172 ----------
 lib/bb/fetch/git.py      |  339 -------------------
 lib/bb/fetch/hg.py       |  180 ----------
 lib/bb/fetch/local.py    |   73 ----
 lib/bb/fetch/osc.py      |  143 --------
 lib/bb/fetch/perforce.py |  206 ------------
 lib/bb/fetch/repo.py     |   98 ------
 lib/bb/fetch/ssh.py      |  118 -------
 lib/bb/fetch/svk.py      |  104 ------
 lib/bb/fetch/svn.py      |  204 -----------
 lib/bb/fetch/wget.py     |   93 -----
 14 files changed, 2 insertions(+), 2713 deletions(-)
 delete mode 100644 lib/bb/fetch/__init__.py
 delete mode 100644 lib/bb/fetch/bzr.py
 delete mode 100644 lib/bb/fetch/cvs.py
 delete mode 100644 lib/bb/fetch/git.py
 delete mode 100644 lib/bb/fetch/hg.py
 delete mode 100644 lib/bb/fetch/local.py
 delete mode 100644 lib/bb/fetch/osc.py
 delete mode 100644 lib/bb/fetch/perforce.py
 delete mode 100644 lib/bb/fetch/repo.py
 delete mode 100644 lib/bb/fetch/ssh.py
 delete mode 100644 lib/bb/fetch/svk.py
 delete mode 100644 lib/bb/fetch/svn.py
 delete mode 100644 lib/bb/fetch/wget.py

diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index dce5610..8d579c7 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -79,9 +79,8 @@ if "BBDEBUG" in os.environ:
     if level:
         bb.msg.set_debug_level(level)
 
-if os.environ.get("BBFETCH2"):
-    from bb import fetch2 as fetch
-    sys.modules['bb.fetch'] = sys.modules['bb.fetch2']
+from bb import fetch2 as fetch
+sys.modules['bb.fetch'] = sys.modules['bb.fetch2']
 
 # Messaging convenience functions
 def plain(*args):

[Patch removes lib/bb/fetch/*]



