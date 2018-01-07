Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id A3EA0787B0
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  7 Jan 2018 12:06:04 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	w07C621p014498
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Sun, 7 Jan 2018 12:06:03 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1eY9iE-00077C-FZ; Sun, 07 Jan 2018 12:06:02 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Sun,  7 Jan 2018 12:05:59 +0000
Message-Id: <1515326759-27305-2-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1515326759-27305-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1515326759-27305-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH 2/2] events: Drop unused cfg property
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
X-List-Received-Date: Sun, 07 Jan 2018 12:06:06 -0000

The cfg property on events doesn't add much, all code appears to access
"data" at this point. Remove it to clean up the interface.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/event.py | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index 52072b5..5d00496 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -449,12 +449,6 @@ class BuildBase(Event):
     def setName(self, name):
         self._name = name
 
-    def getCfg(self):
-        return self.data
-
-    def setCfg(self, cfg):
-        self.data = cfg
-
     def getFailures(self):
         """
         Return the number of failed packages
@@ -463,9 +457,6 @@ class BuildBase(Event):
 
     pkgs = property(getPkgs, setPkgs, None, "pkgs property")
     name = property(getName, setName, None, "name property")
-    cfg = property(getCfg, setCfg, None, "cfg property")
-
-
 
 class BuildInit(BuildBase):
     """buildFile or buildTargets was invoked"""
-- 
2.7.4


