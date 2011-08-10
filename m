Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Qr8sA-0001lM-Fm for bitbake-devel@lists.openembedded.org;
	Wed, 10 Aug 2011 15:31:02 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7ADQXeT021802
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Aug 2011 14:26:33 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 20866-09 for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Aug 2011 14:26:29 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7ADQO5f021796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Aug 2011 14:26:24 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 10 Aug 2011 14:25:49 +0100
Message-ID: <1312982749.14274.380.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] bitbake: Fix -e when used with -b option
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
X-List-Received-Date: Wed, 10 Aug 2011 13:31:02 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

When using the -e and -b options together an expection was occuring.
This was due to incorrect initialisation and this patch adds in the
correct initialisation calls.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index b4c22f6..9f6dcd2 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -276,6 +276,12 @@ class BBCooker:
         envdata = None
 
         if buildfile:
+            # Parse the configuration here. We need to do it explicitly here since
+            # this showEnvironment() code path doesn't use the cache
+            self.parseConfiguration()
+            self.status = bb.cache.CacheData(self.caches_array)
+            self.handleCollections( bb.data.getVar("BBFILE_COLLECTIONS", self.configuration.data, 1) )
+
             fn = self.matchFile(buildfile)
         elif len(pkgs_to_build) == 1:
             self.updateCache()



