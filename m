Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id B7183706B3
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Nov 2014 17:46:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	sA7Hji4N027767
	for <bitbake-devel@lists.openembedded.org>; Fri, 7 Nov 2014 17:45:44 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 0R1GVZyR3ygq for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Nov 2014 17:45:44 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	sA7HjTuQ027697
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 7 Nov 2014 17:45:40 GMT
Message-ID: <1415382365.2820.6.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 07 Nov 2014 17:46:05 +0000
X-Mailer: Evolution 3.12.7-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] siggen: Add computed hash code to verify hash computation to dumpsig
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
X-List-Received-Date: Fri, 07 Nov 2014 17:46:21 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This is useful code to double check the computed checksum value if nothing 
else. Might as well have it in tree.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 1033785..e92a9c4 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -499,4 +499,17 @@ def dump_sigfile(a):
     if 'taint' in a_data:
         output.append("Tainted (by forced/invalidated task): %s" % a_data['taint'])
 
+    data = a_data['basehash']
+    for dep in a_data['runtaskdeps']:
+        data = data + a_data['runtaskhashes'][dep]
+
+    for c in a_data['file_checksum_values']:
+        data = data + c[1]
+
+    if 'taint' in a_data:
+        data = data + a_data['taint']
+
+    h = hashlib.md5(data).hexdigest()
+    output.append("Computed Hash is %s" % h)
+
     return output



