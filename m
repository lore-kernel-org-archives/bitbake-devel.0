Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 65CB675EE7
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Nov 2015 11:10:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	tAABAScZ007955 for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Nov 2015 11:10:28 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id LpTgnf0KVhO3 for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Nov 2015 11:10:27 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	tAABAD9d007916
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Nov 2015 11:10:25 GMT
Message-ID: <1447149411.3559.216.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 10 Nov 2015 09:56:51 +0000
Mime-Version: 1.0
X-Mailer: Evolution 3.12.11-0ubuntu3 
Subject: [PATCH] fetch2: Remove crazy code in unpack
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
X-List-Received-Date: Tue, 10 Nov 2015 11:10:28 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This looks reasonable until you realise self.localpath is a function. Data
expansion of something which isn't a string is the original value so this
code just wastes CPU cycles and makes no sense. Remove it.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bitbake/lib/bb/fetch2/__init__.py | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 288a1c8..d66a212 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1686,9 +1686,6 @@ class Fetch(object):
             ud = self.ud[u]
             ud.setup_localpath(self.d)
 
-            if self.d.expand(self.localpath) is None:
-                continue
-
             if ud.lockfile:
                 lf = bb.utils.lockfile(ud.lockfile)
 



