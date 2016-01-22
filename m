Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 8601F731F1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jan 2016 13:01:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u0MD1X0d019874 for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jan 2016 13:01:33 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id zAB84JbJlISm for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jan 2016 13:01:33 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u0MD1Sag019871
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jan 2016 13:01:29 GMT
Message-ID: <1453467688.27999.201.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 22 Jan 2016 13:01:28 +0000
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] fetch2: Don't show checksum warnings if a single checksum was supplied
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
X-List-Received-Date: Fri, 22 Jan 2016 13:01:34 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If one checksum is supplied to a SRC_URI, we really don't want to show 
warnings about the other type which isn't present as one checksum
is really good enough for most cases.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 0f9c643..5b416ab 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -585,12 +585,10 @@ def verify_checksum(ud, d, precomputed={}):
             raise NoChecksumError('Missing SRC_URI checksum', ud.url)
 
         # Log missing sums so user can more easily add them
-        if not ud.md5_expected:
+        if not ud.md5_expected and not ud.sha256_expected:
             logger.warn('Missing md5 SRC_URI checksum for %s, consider adding to the recipe:\n'
                         'SRC_URI[%s] = "%s"',
                         ud.localpath, ud.md5_name, md5data)
-
-        if not ud.sha256_expected:
             logger.warn('Missing sha256 SRC_URI checksum for %s, consider adding to the recipe:\n'
                         'SRC_URI[%s] = "%s"',
                         ud.localpath, ud.sha256_name, sha256data)



