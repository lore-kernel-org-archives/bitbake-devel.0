Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 1D68776DF8
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Sep 2015 20:44:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t8GKiWwY010862 for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Sep 2015 21:44:32 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id l9Skz0e0yUpJ for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Sep 2015 21:44:32 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t8GKiKth010858
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Sep 2015 21:44:32 +0100
Message-ID: <1442436260.26666.164.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 16 Sep 2015 21:44:20 +0100
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Subject: [PATCH] cache: Handle spaces and colons in directory names for file-checksums
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
X-List-Received-Date: Wed, 16 Sep 2015 20:44:39 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If there is a space in a directory name containing a file in file-checksums
(e.g. from a file:// url), you currently get tracebacks from bitbake. This
improves the code to handle colons and spaces in the file-checksums names
since it possible to figure out the correct names.

[YOCTO #8267]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index ef4d660..ab09b08 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -528,7 +528,20 @@ class Cache(object):
 
         if hasattr(info_array[0], 'file_checksums'):
             for _, fl in info_array[0].file_checksums.items():
-                for f in fl.split():
+                fl = fl.strip()
+                while fl:
+                    # A .split() would be simpler but means spaces or colons in filenames would break
+                    a = fl.find(":True")
+                    b = fl.find(":False")
+                    if ((a < 0) and b) or ((b > 0) and (b < a)):
+                       f = fl[:b+6]
+                       fl = fl[b+7:]
+                    elif ((b < 0) and a) or ((a > 0) and (a < b)):
+                       f = fl[:a+5]
+                       fl = fl[a+6:]
+                    else:
+                       break
+                    fl = fl.strip()
                     if "*" in f:
                         continue
                     f, exist = f.split(":")



