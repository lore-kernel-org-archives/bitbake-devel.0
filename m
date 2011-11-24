Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RTc3e-0002YB-Cz for bitbake-devel@lists.openembedded.org;
	Thu, 24 Nov 2011 17:21:54 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pAOGFLff026541
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2011 16:15:21 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 25810-09 for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2011 16:15:17 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pAOGFB9K026535
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2011 16:15:12 GMT
Message-ID: <1322151318.10928.1.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 24 Nov 2011 16:15:18 +0000
X-Mailer: Evolution 3.2.1- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] fetch2: Improve uri_replace to handle paths with no trailing '/'
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
X-List-Received-Date: Thu, 24 Nov 2011 16:21:54 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently if you specify a mirror like:

file://.* http://linux.freescale.net/yocto/sstate-cache

it won't work as you expect whilst:

file://.* http://linux.freescale.net/yocto/sstate-cache/

will since it has the trailing slash.

This patch handles both cases correctly. It also adds some debug to
the uri_replace function since its near impossible to debug it without
some kind of output.

[YOCTO #1578]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index a055faa..d3c761d 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -175,6 +175,7 @@ def uri_replace(ud, uri_find, uri_replace, d):
     uri_decoded = list(decodeurl(ud.url))
     uri_find_decoded = list(decodeurl(uri_find))
     uri_replace_decoded = list(decodeurl(uri_replace))
+    logger.debug(2, "For url %s comparing %s to %s" % (uri_decoded, uri_find_decoded, uri_replace_decoded))
     result_decoded = ['', '', '', '', '', {}]
     for i in uri_find_decoded:
         loc = uri_find_decoded.index(i)
@@ -187,12 +188,18 @@ def uri_replace(ud, uri_find, uri_replace, d):
                     result_decoded[loc] = re.sub(i, uri_replace_decoded[loc], uri_decoded[loc])
                 if uri_find_decoded.index(i) == 2:
                     if ud.mirrortarball:
-                        result_decoded[loc] = os.path.join(os.path.dirname(result_decoded[loc]), os.path.basename(ud.mirrortarball))
+                        if result_decoded[loc].endswith("/"):
+                            result_decoded[loc] = os.path.dirname(result_decoded[loc])
+                        result_decoded[loc] = os.path.join(result_decoded[loc], os.path.basename(ud.mirrortarball))
                     elif ud.localpath:
-                        result_decoded[loc] = os.path.join(os.path.dirname(result_decoded[loc]), os.path.basename(ud.localpath))
+                        if result_decoded[loc].endswith("/"):
+                            result_decoded[loc] = os.path.dirname(result_decoded[loc])
+                        result_decoded[loc] = os.path.join(result_decoded[loc], os.path.basename(ud.localpath))
             else:
                 return ud.url
-    return encodeurl(result_decoded)
+    result = encodeurl(result_decoded)
+    logger.debug(2, "For url %s returning %s" % (ud.url, result))
+    return result
 
 methods = []
 urldata_cache = {}




