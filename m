Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 22D8F6AC37
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Mar 2016 16:11:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u2OGBw21021853 for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Mar 2016 16:11:58 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id F56QvVsci51X for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Mar 2016 16:11:58 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u2OGBuNi021848
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Mar 2016 16:11:57 GMT
Message-ID: <1458835916.3073.29.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 24 Mar 2016 16:11:56 +0000
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] fetch2: Handle lockfiles for file:// urls redirected to mirrors
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
X-List-Received-Date: Thu, 24 Mar 2016 16:12:00 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

We recently dropped lockfiles for file:// urls which in itself makes
sense.

If a file url redirects to something like an http:// mirror, we'd have
no lock taken for the original file and could race against others
trying to download the file. We therefore need to ensure there is a
lock taken in the mirror handling code.

This adds code to take such a lock, assuming it isn't the same lock
as the parent url.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index f86014c..d87d8e8 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -915,6 +915,10 @@ def rename_bad_checksum(ud, suffix):
 def try_mirror_url(fetch, origud, ud, ld, check = False):
     # Return of None or a value means we're finished
     # False means try another url
+
+    if ud.lockfile and ud.lockfile != origud.lockfile:
+        lf = bb.utils.lockfile(ud.lockfile)
+
     try:
         if check:
             found = ud.method.checkstatus(fetch, ud, ld)
@@ -980,6 +984,10 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
         except UnboundLocalError:
             pass
         return False
+    finally:
+        if ud.lockfile and ud.lockfile != origud.lockfile:
+            bb.utils.unlockfile(lf)
+
 
 def try_mirrors(fetch, d, origud, mirrors, check = False):
     """



