Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 4D99A773DC
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 Jun 2016 12:37:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u51Cb48P007485; Wed, 1 Jun 2016 13:37:07 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id BERQlf55EYp9; Wed,  1 Jun 2016 13:37:07 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u51CaxLS007464
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 1 Jun 2016 13:37:00 +0100
Received: from richard by hex with local (Exim 4.86)
	(envelope-from <richard@rpsys.net>)
	id 1b85ON-0000p5-HB; Wed, 01 Jun 2016 13:36:59 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  1 Jun 2016 13:36:41 +0100
Message-Id: <1464784607-2985-22-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1464784607-2985-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1464784607-2985-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [PATCH 22/28] toaster: use knotty when working with bitbake server
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 01 Jun 2016 12:37:14 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Using empty BITBAKE_UI environment variable causes bitbake server
to fail with the error:
    FATAL: Unable to import extension module "" from bb.ui
           Valid extension modules: knotty or toasterui\n'

Used BITBAKE_UI="knotty" when starting and stoping bitbake
server to solve above issue.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 3da8be4..9364900 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -287,7 +287,7 @@ class LocalhostBEController(BuildEnvironmentController):
 
         # run bitbake server from the clone
         bitbake = os.path.join(self.pokydirname, 'bitbake', 'bin', 'bitbake')
-        self._shellcmd('bash -c \"source %s %s; BITBAKE_UI="" %s --read %s '
+        self._shellcmd('bash -c \"source %s %s; BITBAKE_UI="knotty" %s --read %s '
                        '--server-only -t xmlrpc -B 0.0.0.0:0\"' % (oe_init,
                        builddir, bitbake, confpath), self.be.sourcedir)
 
@@ -324,7 +324,7 @@ class LocalhostBEController(BuildEnvironmentController):
                                      'bitbake')
         self._shellcmd(['bash -c \"(TOASTER_BRBE="%s" BBSERVER="0.0.0.0:-1" '
                         '%s %s -u toasterui --token="" >>%s 2>&1;'
-                        'BITBAKE_UI="" BBSERVER=0.0.0.0:-1 %s -m)&\"' \
+                        'BITBAKE_UI="knotty" BBSERVER=0.0.0.0:-1 %s -m)&\"' \
                         % (brbe, local_bitbake, bbtargets, log, bitbake)],
                         builddir, nowait=True)
 
-- 
2.5.0


