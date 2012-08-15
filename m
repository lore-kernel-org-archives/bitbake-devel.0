Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1T1gAM-0002bd-EJ for bitbake-devel@lists.openembedded.org;
	Wed, 15 Aug 2012 18:09:54 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7FFvwi8002904
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Aug 2012 16:57:58 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 01979-05 for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Aug 2012 16:57:54 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7FFvld7002897
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Aug 2012 16:57:48 +0100
Message-ID: <1345046267.14667.7.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 15 Aug 2012 16:57:47 +0100
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] build.py: Only execute mkdirhier if stampdir doesn't exist
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
X-List-Received-Date: Wed, 15 Aug 2012 16:09:54 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

I noticed this was showing up on profile logs as a sigificant time user
in "bitbake bash" when bash was already built. It reduces the time from
5.2 to 4.5 seconds in my test environment.

We make use of the parser's mtime cache as once a directory exists,
we can assume it continues to exist and this avoids syscalls.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index bea2926..d64077e 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -464,7 +464,9 @@ def stamp_internal(taskname, d, file_name):
 
     stamp = bb.parse.siggen.stampfile(stamp, file_name, taskname, extrainfo)
 
-    bb.utils.mkdirhier(os.path.dirname(stamp))
+    stampdir = os.path.dirname(stamp)
+    if bb.parse.cached_mtime_noerror == 0:
+        bb.utils.mkdirhier(stampdir)
 
     return stamp
 




