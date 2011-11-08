Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RNpwt-0006rI-Ha for bitbake-devel@lists.openembedded.org;
	Tue, 08 Nov 2011 18:59:04 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pA8HqnH1003247
	for <bitbake-devel@lists.openembedded.org>; Tue, 8 Nov 2011 17:52:49 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 02982-05 for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Nov 2011 17:52:45 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pA8HqgpJ003241
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>; Tue, 8 Nov 2011 17:52:43 GMT
Message-ID: <1320774764.10843.96.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 08 Nov 2011 17:52:44 +0000
X-Mailer: Evolution 3.2.1- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] cooker.py: Ensure only one copy of bitbake executes at once
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
X-List-Received-Date: Tue, 08 Nov 2011 17:59:04 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The bitbake codebase makes assumptions that only one copy is active
against a given build directory at a given time. This patch adds a
lockfile in TOPDIR to ensure that is the case.

Note that no unlock is needed, that is automatically dropped when
execution terminates.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 546a92c..ee8323e 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -135,6 +135,13 @@ class BBCooker:
         self.configuration.data = None
         self.loadConfigurationData()
 
+        # Take a lock so only one copy of bitbake can run against a given build
+        # directory at a time
+        lockfile = bb.data.expand("${TOPDIR}/bitbake.lock", self.configuration.data)
+        self.lock = bb.utils.lockfile(lockfile, False, False)
+        if not self.lock:
+            bb.fatal("Only one copy of bitbake should be run against a build directory")
+
         bbpkgs = bb.data.getVar('BBPKGS', self.configuration.data, True)
         if bbpkgs and len(self.configuration.pkgs_to_build) == 0:
             self.configuration.pkgs_to_build.extend(bbpkgs.split())



