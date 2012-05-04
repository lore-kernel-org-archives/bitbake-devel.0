Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SQMQi-0004Ij-I0 for bitbake-devel@lists.openembedded.org;
	Fri, 04 May 2012 19:36:32 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q44HQkGO016033
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 4 May 2012 18:26:46 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 15301-07 for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 May 2012 18:26:41 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q44HQas5016026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 4 May 2012 18:26:37 +0100
Message-ID: <1336152400.23777.29.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 04 May 2012 18:26:40 +0100
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] bitbake/fetch2/wget: Remove unneeded function indirection and reindent
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
X-List-Received-Date: Fri, 04 May 2012 17:36:32 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index 89bf57b..9d36115 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -53,35 +53,32 @@ class Wget(FetchMethod):
     def download(self, uri, ud, d, checkonly = False):
         """Fetch urls"""
 
-        def fetch_uri(uri, ud, d):
-            if checkonly:
-                fetchcmd = data.getVar("CHECKCOMMAND_wget", d, True)
-            elif os.path.exists(ud.localpath):
-                # file exists, but we didnt complete it.. trying again..
-                fetchcmd = data.getVar("RESUMECOMMAND_wget", d, True)
-            else:
-                fetchcmd = data.getVar("FETCHCOMMAND_wget", d, True)
+        if checkonly:
+            fetchcmd = data.getVar("CHECKCOMMAND_wget", d, True)
+        elif os.path.exists(ud.localpath):
+            # file exists, but we didnt complete it.. trying again..
+            fetchcmd = data.getVar("RESUMECOMMAND_wget", d, True)
+        else:
+            fetchcmd = data.getVar("FETCHCOMMAND_wget", d, True)
 
-            uri = uri.split(";")[0]
-            uri_decoded = list(decodeurl(uri))
-            uri_type = uri_decoded[0]
-            uri_host = uri_decoded[1]
+        uri = uri.split(";")[0]
+        uri_decoded = list(decodeurl(uri))
+        uri_type = uri_decoded[0]
+        uri_host = uri_decoded[1]
 
-            fetchcmd = fetchcmd.replace("${URI}", uri.split(";")[0])
-            fetchcmd = fetchcmd.replace("${FILE}", ud.basename)
-            if not checkonly:
-                logger.info("fetch " + uri)
-                logger.debug(2, "executing " + fetchcmd)
-            bb.fetch2.check_network_access(d, fetchcmd)
-            runfetchcmd(fetchcmd, d, quiet=checkonly)
+        fetchcmd = fetchcmd.replace("${URI}", uri.split(";")[0])
+        fetchcmd = fetchcmd.replace("${FILE}", ud.basename)
+        if not checkonly:
+            logger.info("fetch " + uri)
+            logger.debug(2, "executing " + fetchcmd)
+        bb.fetch2.check_network_access(d, fetchcmd)
+        runfetchcmd(fetchcmd, d, quiet=checkonly)
 
-            # Sanity check since wget can pretend it succeed when it didn't
-            # Also, this used to happen if sourceforge sent us to the mirror page
-            if not os.path.exists(ud.localpath) and not checkonly:
-                raise FetchError("The fetch command returned success for url %s but %s doesn't exist?!" % (uri, ud.localpath), uri)
-
-        fetch_uri(uri, ud, localdata)
-        
+        # Sanity check since wget can pretend it succeed when it didn't
+        # Also, this used to happen if sourceforge sent us to the mirror page
+        if not os.path.exists(ud.localpath) and not checkonly:
+            raise FetchError("The fetch command returned success for url %s but %s doesn't exist?!" % (uri, ud.localpath), uri)
+       
         return True
 
     def checkstatus(self, uri, ud, d):




