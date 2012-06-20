Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard@rpsys.net>) id 1ShLqQ-0007wt-T2
	for bitbake-devel@lists.openembedded.org;
	Wed, 20 Jun 2012 16:25:19 +0200
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2ubuntu2) with ESMTP id
	q5KEHJNo007991 for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jun 2012 15:17:38 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id cQRnljSTWdBv for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jun 2012 15:17:38 +0100 (BST)
Received: from ted (ted.config [192.168.1.66]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.2/Debian-2build1) with ESMTP id
	q5KEHZOL008034
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jun 2012 15:17:36 +0100
Received: from richard by ted with local (Exim 4.76)
	(envelope-from <richard@dan.rpsys.net>) id 1ShLfJ-0002Sr-A5
	for bitbake-devel@lists.openembedded.org;
	Wed, 20 Jun 2012 15:13:49 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 20 Jun 2012 15:13:00 +0100
Message-Id: <131dd58bcea697f67768d02a7af8e89010f82b1f.1340200208.git.richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1340200207.git.richard.purdie@linuxfoundation.org>
References: <cover.1340200207.git.richard.purdie@linuxfoundation.org>
In-Reply-To: <cover.1340200207.git.richard.purdie@linuxfoundation.org>
References: <cover.1340200207.git.richard.purdie@linuxfoundation.org>
Subject: [PATCH 09/14] fetch2: Remove basestring test and simplify uri_replace
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
X-List-Received-Date: Wed, 20 Jun 2012 14:27:57 -0000

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bitbake/lib/bb/fetch2/__init__.py |   35 ++++++++++++++++++-----------------
 1 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index fe0c6a7..7045e1b 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -193,24 +193,25 @@ def uri_replace(ud, uri_find, uri_replace, d):
     result_decoded = ['', '', '', '', '', {}]
     for loc, i in enumerate(uri_find_decoded):
         result_decoded[loc] = uri_decoded[loc]
-        if isinstance(i, basestring):
-            if (re.match(i, uri_decoded[loc])):
-                if not uri_replace_decoded[loc]:
-                    result_decoded[loc] = ""    
-                else:
-                    result_decoded[loc] = re.sub(i, uri_replace_decoded[loc], uri_decoded[loc])
-                if loc == 2:
-                    basename = None
-                    if ud.mirrortarball:
-                        basename = os.path.basename(ud.mirrortarball)
-                    elif ud.localpath:
-                        basename = os.path.basename(ud.localpath)
-                    if basename and result_decoded[loc].endswith("/"):
-                        result_decoded[loc] = os.path.dirname(result_decoded[loc])
-                    if basename and not result_decoded[loc].endswith(basename):
-                        result_decoded[loc] = os.path.join(result_decoded[loc], basename)
+        if loc == 5:
+            continue
+        elif (re.match(i, uri_decoded[loc])):
+            if not uri_replace_decoded[loc]:
+                result_decoded[loc] = ""    
             else:
-                return None
+                result_decoded[loc] = re.sub(i, uri_replace_decoded[loc], uri_decoded[loc])
+            if loc == 2:
+                basename = None
+                if ud.mirrortarball:
+                    basename = os.path.basename(ud.mirrortarball)
+                elif ud.localpath:
+                    basename = os.path.basename(ud.localpath)
+                if basename and result_decoded[loc].endswith("/"):
+                    result_decoded[loc] = os.path.dirname(result_decoded[loc])
+                if basename and not result_decoded[loc].endswith(basename):
+                    result_decoded[loc] = os.path.join(result_decoded[loc], basename)
+        else:
+            return None
     result = encodeurl(result_decoded)
     if result == ud.url:
         return None
-- 
1.7.5.4



