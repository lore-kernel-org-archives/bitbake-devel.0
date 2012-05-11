Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SStai-0002z2-5I for bitbake-devel@lists.openembedded.org;
	Fri, 11 May 2012 19:25:20 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4BHFOSW028389
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 May 2012 18:15:24 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 18550-06 for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 May 2012 18:15:18 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4BHFGNC028383
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 May 2012 18:15:17 +0100
Message-ID: <1336756516.2494.239.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 11 May 2012 18:15:16 +0100
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: bitbake/fetch2/git: Set a default for the GITDIR variable
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
X-List-Received-Date: Fri, 11 May 2012 17:25:20 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 5efdfa9..962cc0a 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -136,8 +136,9 @@ class Git(FetchMethod):
             for name in ud.names:
                 gitsrcname = gitsrcname + '_' + ud.revisions[name]
         ud.mirrortarball = 'git2_%s.tar.gz' % (gitsrcname)
-        ud.fullmirror = os.path.join(data.getVar("DL_DIR", d, True), ud.mirrortarball)
-        ud.clonedir = os.path.join(data.expand('${GITDIR}', d), gitsrcname)
+        ud.fullmirror = os.path.join(d.getVar("DL_DIR", True), ud.mirrortarball)
+        gitdir = d.getVar("GITDIR", True) or (d.getVar("DL_DIR", True) + "/git2/")
+        ud.clonedir = os.path.join(gitdir, gitsrcname)
 
         ud.localfile = ud.clonedir
 




