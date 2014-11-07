Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id A12E1706B3
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Nov 2014 17:47:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	sA7HlEmr027862
	for <bitbake-devel@lists.openembedded.org>; Fri, 7 Nov 2014 17:47:14 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id FAzDQlGCJQXT for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Nov 2014 17:47:14 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	sA7Hl1dM027858
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 7 Nov 2014 17:47:12 GMT
Message-ID: <1415382457.2820.8.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 07 Nov 2014 17:47:37 +0000
X-Mailer: Evolution 3.12.7-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] siggen: Fix shared work checksum mismatch/rebuild issues
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
X-List-Received-Date: Fri, 07 Nov 2014 17:47:51 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Similar to the last shared work task signature bug, we've found another
one. Looking at the improved output of diffsigs in this case:

runtaskdeps changed from [
'autoconf_2.69.bb.do_populate_sysroot:virtual:native',
'gnu-config_20120814.bb.do_populate_sysroot:virtual:native',
'libgcc-initial_4.9.bb.do_patch:virtual:nativesdk'
] to [
'autoconf_2.69.bb.do_populate_sysroot:virtual:native',
'gcc-crosssdk-initial_4.9.bb.do_patch',
'gnu-config_20120814.bb.do_populate_sysroot:virtual:native'
]

so we can get a different task hash since libgcc sorts before gnu-config
and gcc sorts after it. We could do with a way of fixing this, the best
I can come up with is to include a single parent directory. Since
recipes are never at the top of any metadata trees I've seen, this
should suffice for now.

I'm planning to burn the concept of shared work within bitbake
and do something at the metadata level in the 1.8 timeframe as its just
too fragile as things stand and hard to fix well.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index e92a9c4..5103073 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -295,10 +295,9 @@ def dump_this_task(outfile, d):
     bb.parse.siggen.dump_sigtask(fn, task, outfile, "customfile")
 
 def clean_basepath(a):
+    b = a.rsplit("/", 2)[1] + a.rsplit("/", 2)[2]
     if a.startswith("virtual:"):
-        b = a.rsplit("/", 1)[1] + ":" + a.rsplit(":", 1)[0]
-    else:
-        b = a.rsplit("/", 1)[1]
+        b = b + ":" + a.rsplit(":", 1)[0]
     return b
 
 def clean_basepaths(a):



