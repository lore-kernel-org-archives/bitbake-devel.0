Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RNptp-0006ho-2B for bitbake-devel@lists.openembedded.org;
	Tue, 08 Nov 2011 18:55:53 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pA8Hncil003183
	for <bitbake-devel@lists.openembedded.org>; Tue, 8 Nov 2011 17:49:38 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 02982-04 for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Nov 2011 17:49:34 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pA8HnUGr003176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>; Tue, 8 Nov 2011 17:49:31 GMT
Message-ID: <1320774572.10843.93.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 08 Nov 2011 17:49:32 +0000
X-Mailer: Evolution 3.2.1- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] utils.py: Fix lockfile retry handling
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
X-List-Received-Date: Tue, 08 Nov 2011 17:55:53 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The lockfile retry parameter is expected to return immediately after
attempting to take the lock. There was a bug in the logic which this
patch fixed to ensure it does that.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 1f55407..f905702 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -443,7 +443,7 @@ def lockfile(name, shared=False, retry=True):
                     return lf
             lf.close()
         except Exception:
-            continue
+            pass
         if not retry:
             return None
 



