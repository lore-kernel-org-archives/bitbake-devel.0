Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 4865E77492
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Dec 2016 17:06:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uBLH6Yus001644; Wed, 21 Dec 2016 17:06:34 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id bXXywj52qH3l; Wed, 21 Dec 2016 17:06:34 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uBLH6TMN001587
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 21 Dec 2016 17:06:30 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1cJkLV-0006u8-D6; Wed, 21 Dec 2016 17:06:29 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Dec 2016 17:06:19 +0000
Message-Id: <1482339985-26495-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH 1/7] runqueue: Ensure pseudo executes from the correct place (use the right datastore with multiconfig)
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
X-List-Received-Date: Wed, 21 Dec 2016 17:06:37 -0000

The location of the fakeroot command and the various environmental values need
to be taken from the right multiconfig datastore, not the shared one. This
patch ensures the right one is used for cases like a split TMPDIR.

[YOCTO #10344]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 1e1bdf4..25a2684 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1004,8 +1004,9 @@ class RunQueue:
             magic = "decafbadbad"
         if fakeroot:
             magic = magic + "beef"
-            fakerootcmd = self.cfgData.getVar("FAKEROOTCMD")
-            fakerootenv = (self.cfgData.getVar("FAKEROOTBASEENV") or "").split()
+            mcdata = self.cooker.databuilder.mcdata[mc]
+            fakerootcmd = mcdata.getVar("FAKEROOTCMD")
+            fakerootenv = (mcdata.getVar("FAKEROOTBASEENV") or "").split()
             env = os.environ.copy()
             for key, value in (var.split('=') for var in fakerootenv):
                 env[key] = value
-- 
2.7.4


