Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard@rpsys.net>) id 1ShLqN-0007wt-Gj
	for bitbake-devel@lists.openembedded.org;
	Wed, 20 Jun 2012 16:25:15 +0200
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2ubuntu2) with ESMTP id
	q5KEHSIa008014 for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jun 2012 15:17:35 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id jSdZKTGV9sg5 for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jun 2012 15:17:35 +0100 (BST)
Received: from ted (ted.config [192.168.1.66]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.2/Debian-2build1) with ESMTP id
	q5KEHWwn008023
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jun 2012 15:17:33 +0100
Received: from richard by ted with local (Exim 4.76)
	(envelope-from <richard@dan.rpsys.net>) id 1ShLfF-0002So-JM
	for bitbake-devel@lists.openembedded.org;
	Wed, 20 Jun 2012 15:13:45 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 20 Jun 2012 15:12:59 +0100
Message-Id: <e8b17b1317cc1908896c44125aec3a476353eb81.1340200208.git.richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1340200207.git.richard.purdie@linuxfoundation.org>
References: <cover.1340200207.git.richard.purdie@linuxfoundation.org>
In-Reply-To: <cover.1340200207.git.richard.purdie@linuxfoundation.org>
References: <cover.1340200207.git.richard.purdie@linuxfoundation.org>
Subject: [PATCH 08/14] fetch2: Simplify some looping constructs in uri_replace()
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
X-List-Received-Date: Wed, 20 Jun 2012 14:25:15 -0000

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bitbake/lib/bb/fetch2/__init__.py |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 5838436..fe0c6a7 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -191,8 +191,7 @@ def uri_replace(ud, uri_find, uri_replace, d):
     uri_replace_decoded = list(decodeurl(uri_replace))
     logger.debug(2, "For url %s comparing %s to %s" % (uri_decoded, uri_find_decoded, uri_replace_decoded))
     result_decoded = ['', '', '', '', '', {}]
-    for i in uri_find_decoded:
-        loc = uri_find_decoded.index(i)
+    for loc, i in enumerate(uri_find_decoded):
         result_decoded[loc] = uri_decoded[loc]
         if isinstance(i, basestring):
             if (re.match(i, uri_decoded[loc])):
@@ -200,7 +199,7 @@ def uri_replace(ud, uri_find, uri_replace, d):
                     result_decoded[loc] = ""    
                 else:
                     result_decoded[loc] = re.sub(i, uri_replace_decoded[loc], uri_decoded[loc])
-                if uri_find_decoded.index(i) == 2:
+                if loc == 2:
                     basename = None
                     if ud.mirrortarball:
                         basename = os.path.basename(ud.mirrortarball)
-- 
1.7.5.4



