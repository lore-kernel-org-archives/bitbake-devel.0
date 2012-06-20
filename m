Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard@rpsys.net>) id 1ShLqL-0007wt-9V
	for bitbake-devel@lists.openembedded.org;
	Wed, 20 Jun 2012 16:25:13 +0200
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2ubuntu2) with ESMTP id
	q5KEH8cR007963 for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jun 2012 15:17:09 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id kbMaIs-mTm3A for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jun 2012 15:17:08 +0100 (BST)
Received: from ted (ted.config [192.168.1.66]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.2/Debian-2build1) with ESMTP id
	q5KEH6iJ007957
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jun 2012 15:17:08 +0100
Received: from richard by ted with local (Exim 4.76)
	(envelope-from <richard@dan.rpsys.net>) id 1ShLeq-0002SQ-3R
	for bitbake-devel@lists.openembedded.org;
	Wed, 20 Jun 2012 15:13:20 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 20 Jun 2012 15:12:52 +0100
Message-Id: <dc9976331c5cbb0983adb54f6deb97b9203bacbc.1340200207.git.richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1340200207.git.richard.purdie@linuxfoundation.org>
References: <cover.1340200207.git.richard.purdie@linuxfoundation.org>
In-Reply-To: <cover.1340200207.git.richard.purdie@linuxfoundation.org>
References: <cover.1340200207.git.richard.purdie@linuxfoundation.org>
Subject: [PATCH 01/14] fetch2/__init__: Make it clearer when uri_replace doesn't return a match
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
X-List-Received-Date: Wed, 20 Jun 2012 14:25:13 -0000

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bitbake/lib/bb/fetch2/__init__.py |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 324eef2..73ac73a 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -210,8 +210,10 @@ def uri_replace(ud, uri_find, uri_replace, d):
                     if basename and not result_decoded[loc].endswith(basename):
                         result_decoded[loc] = os.path.join(result_decoded[loc], basename)
             else:
-                return ud.url
+                return None
     result = encodeurl(result_decoded)
+    if result == ud.url:
+        return None
     logger.debug(2, "For url %s returning %s" % (ud.url, result))
     return result
 
@@ -477,7 +479,7 @@ def try_mirrors(d, origud, mirrors, check = False):
         except ValueError:
             continue
         newuri = uri_replace(origud, find, replace, ld)
-        if newuri == origud.url:
+        if not newuri:
             continue
         try:
             ud = FetchData(newuri, ld)
-- 
1.7.5.4



