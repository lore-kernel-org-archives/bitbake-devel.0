Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TJOI6-00005L-Cb for bitbake-devel@lists.openembedded.org;
	Wed, 03 Oct 2012 14:43:06 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q93CU7xQ027256
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 3 Oct 2012 13:30:07 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 26503-03 for <bitbake-devel@lists.openembedded.org>;
	Wed,  3 Oct 2012 13:30:02 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q93CTuLN027236
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 3 Oct 2012 13:29:58 +0100
Message-ID: <1349267399.18301.30.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 03 Oct 2012 13:29:59 +0100
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] providers.py: Fix PREFERRED_VERSION containing epochs
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
X-List-Received-Date: Wed, 03 Oct 2012 12:43:06 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

For some reason the code calls int() on the epoch component of any
PREFERRED_VERSION. Since this is compared against strings, the comparison
would always fail. This removes the stray cast and allows epochs
in preferred_version to work correctly.

[YOCTO #3187]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/providers.py b/bitbake/lib/bb/providers.py
index 24cb217..fcee6dc 100644
--- a/bitbake/lib/bb/providers.py
+++ b/bitbake/lib/bb/providers.py
@@ -130,7 +130,7 @@ def findPreferredProvider(pn, cfgData, dataCache, pkg_pn = None, item = None):
         m = re.match('(\d+:)*(.*)(_.*)*', preferred_v)
         if m:
             if m.group(1):
-                preferred_e = int(m.group(1)[:-1])
+                preferred_e = m.group(1)[:-1]
             else:
                 preferred_e = None
             preferred_v = m.group(2)




