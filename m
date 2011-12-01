Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RW5SV-00041D-SL for bitbake-devel@lists.openembedded.org;
	Thu, 01 Dec 2011 13:09:48 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pB1C36Wf014422
	for <bitbake-devel@lists.openembedded.org>; Thu, 1 Dec 2011 12:03:06 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 14034-04 for <bitbake-devel@lists.openembedded.org>;
	Thu,  1 Dec 2011 12:03:02 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pB1C2v1c014416
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>; Thu, 1 Dec 2011 12:02:59 GMT
Message-ID: <1322740987.17484.112.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 01 Dec 2011 12:03:07 +0000
X-Mailer: Evolution 3.2.1- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] build.py: Be determistic about a function's cwd
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
X-List-Received-Date: Thu, 01 Dec 2011 12:09:48 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

There is a subtle but nasty problem that a function's cwd can vary
depending on whether ${B} (often ${S}) exists before the funciton is
called or not. Most functions in the system can cope with this but
its bad practise and I've just witnessed build failures resulting
from this during image generation from bootimg.bbclass. I also
suspect this could explain some odd fetcher behaviour witnessed in
the past.

This change ensures we always call funcitons with a specific build
directory making things deterministic.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index ae4a962..9ad1e50 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -149,8 +149,7 @@ def exec_func(func, d, dirs = None):
         adir = dirs[-1]
     else:
         adir = data.getVar('B', d, 1)
-        if not os.path.exists(adir):
-            adir = None
+        bb.utils.mkdirhier(adir)
 
     ispython = flags.get('python')
     if flags.get('fakeroot') and not flags.get('task'):




