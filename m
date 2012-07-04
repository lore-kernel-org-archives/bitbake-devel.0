Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SmS15-00011H-Go for bitbake-devel@lists.openembedded.org;
	Wed, 04 Jul 2012 18:01:23 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q64FoKei024953
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 4 Jul 2012 16:50:20 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 24103-06 for <bitbake-devel@lists.openembedded.org>;
	Wed,  4 Jul 2012 16:50:16 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q64FoB5s024947
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 4 Jul 2012 16:50:12 +0100
Message-ID: <1341417011.3906.34.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 04 Jul 2012 16:50:11 +0100
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] data_smart: Fix multiple override interaction with append and prepend operators
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
X-List-Received-Date: Wed, 04 Jul 2012 16:01:23 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Variables which used multiple overrides and the append/prepend operators were
not functioning correctly. This change fixes that.

This fixes the testcase:

OVERRIDES = "linux:x86"
TESTVAR = "original"
TESTVAR_append_x86 = " x86"
TESTVAR_append_x86_linux = " x86+linux"
TESTVAR_append_linux_x86 = " linux+x86"

[YOCTO #2672]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index 2c02cde..730deaa 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -198,7 +198,12 @@ class DataSmart(MutableMapping):
                 for append in appends:
                     keep = []
                     for (a, o) in self.getVarFlag(append, op) or []:
-                        if o and not o in overrides:
+                        match = True
+                        if o:
+                            for o2 in o.split("_"):
+                                if not o2 in overrides:
+                                    match = False
+                        if not match:
                             keep.append((a ,o))
                             continue
 




