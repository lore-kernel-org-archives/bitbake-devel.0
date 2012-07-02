Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SlnJu-00043p-6k for bitbake-devel@lists.openembedded.org;
	Mon, 02 Jul 2012 22:34:06 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q62KN5NJ006286
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 2 Jul 2012 21:23:05 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 06197-01 for <bitbake-devel@lists.openembedded.org>;
	Mon,  2 Jul 2012 21:23:00 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q62KMwTQ006250
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 2 Jul 2012 21:22:59 +0100
Message-ID: <1341260584.23146.265.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 02 Jul 2012 21:23:04 +0100
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] fetch2/svn: Enhance to cope with subversion 1.7 upgrade
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
X-List-Received-Date: Mon, 02 Jul 2012 20:34:06 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

svn changed working checkout formats between 1.6 and 1.7. Its convoluted to
detect what format a given working copy is in so the simplest solution is simply
to run "svn upgrade" within the working copy.

The base svn command variable is relocated slightly to enable this new code to
work effectively.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/fetch2/svn.py b/bitbake/lib/bb/fetch2/svn.py
index 59d7ccb..bc5b96b 100644
--- a/bitbake/lib/bb/fetch2/svn.py
+++ b/bitbake/lib/bb/fetch2/svn.py
@@ -49,6 +49,8 @@ class Svn(FetchMethod):
         if not "module" in ud.parm:
             raise MissingParameterError('module', ud.url)
 
+        ud.basecmd = d.getVar('FETCHCMD_svn', True)
+
         ud.module = ud.parm["module"]
 
         # Create paths to svn checkouts
@@ -69,8 +71,6 @@ class Svn(FetchMethod):
         command is "fetch", "update", "info"
         """
 
-        basecmd = data.expand('${FETCHCMD_svn}', d)
-
         proto = ud.parm.get('proto', 'svn')
 
         svn_rsh = None
@@ -88,7 +88,7 @@ class Svn(FetchMethod):
             options.append("--password %s" % ud.pswd)
 
         if command == "info":
-            svncmd = "%s info %s %s://%s/%s/" % (basecmd, " ".join(options), proto, svnroot, ud.module)
+            svncmd = "%s info %s %s://%s/%s/" % (ud.basecmd, " ".join(options), proto, svnroot, ud.module)
         else:
             suffix = ""
             if ud.revision:
@@ -96,9 +96,9 @@ class Svn(FetchMethod):
                 suffix = "@%s" % (ud.revision)
 
             if command == "fetch":
-                svncmd = "%s co %s %s://%s/%s%s %s" % (basecmd, " ".join(options), proto, svnroot, ud.module, suffix, ud.module)
+                svncmd = "%s co %s %s://%s/%s%s %s" % (ud.basecmd, " ".join(options), proto, svnroot, ud.module, suffix, ud.module)
             elif command == "update":
-                svncmd = "%s update %s" % (basecmd, " ".join(options))
+                svncmd = "%s update %s" % (ud.basecmd, " ".join(options))
             else:
                 raise FetchError("Invalid svn command %s" % command, ud.url)
 
@@ -117,6 +117,11 @@ class Svn(FetchMethod):
             logger.info("Update " + loc)
             # update sources there
             os.chdir(ud.moddir)
+            # We need to attempt to run svn upgrade first in case its an older working format
+            try:
+                runfetchcmd(ud.basecmd + " upgrade", d)
+            except FetchError:
+                pass
             logger.debug(1, "Running %s", svnupdatecmd)
             bb.fetch2.check_network_access(d, svnupdatecmd, ud.url)
             runfetchcmd(svnupdatecmd, d)




