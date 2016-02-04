Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 96CDD606D1
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  4 Feb 2016 23:29:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u14NTGOT003161
	for <bitbake-devel@lists.openembedded.org>; Thu, 4 Feb 2016 23:29:54 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 6Z6WETnlDxbp for <bitbake-devel@lists.openembedded.org>;
	Thu,  4 Feb 2016 23:29:54 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u14NTpGa003219
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 4 Feb 2016 23:29:52 GMT
Message-ID: <1454628591.27087.249.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 04 Feb 2016 23:29:51 +0000
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] fetch2/osc: Clean up old variable syntax
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
X-List-Received-Date: Thu, 04 Feb 2016 23:29:56 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Since people do copy and paste these things, clean up old syntax styles.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/fetch2/osc.py b/bitbake/lib/bb/fetch2/osc.py
index 3dfa2a7..d051dfd 100644
--- a/bitbake/lib/bb/fetch2/osc.py
+++ b/bitbake/lib/bb/fetch2/osc.py
@@ -34,13 +34,13 @@ class Osc(FetchMethod):
 
         # Create paths to osc checkouts
         relpath = self._strip_leading_slashes(ud.path)
-        ud.pkgdir = os.path.join(data.expand('${OSCDIR}', d), ud.host)
+        ud.pkgdir = os.path.join(d.getVar('OSCDIR', True), ud.host)
         ud.moddir = os.path.join(ud.pkgdir, relpath, ud.module)
 
         if 'rev' in ud.parm:
             ud.revision = ud.parm['rev']
         else:
-            pv = data.getVar("PV", d, 0)
+            pv = d.getVar("PV", False)
             rev = bb.fetch2.srcrev_internal_helper(ud, d)
             if rev and rev != True:
                 ud.revision = rev
@@ -84,7 +84,7 @@ class Osc(FetchMethod):
 
         logger.debug(2, "Fetch: checking for module directory '" + ud.moddir + "'")
 
-        if os.access(os.path.join(data.expand('${OSCDIR}', d), ud.path, ud.module), os.R_OK):
+        if os.access(os.path.join(d.getVar('OSCDIR', True), ud.path, ud.module), os.R_OK):
             oscupdatecmd = self._buildosccommand(ud, d, "update")
             logger.info("Update "+ ud.url)
             # update sources there
@@ -114,7 +114,7 @@ class Osc(FetchMethod):
         Generate a .oscrc to be used for this run.
         """
 
-        config_path = os.path.join(data.expand('${OSCDIR}', d), "oscrc")
+        config_path = os.path.join(d.getVar('OSCDIR', True), "oscrc")
         if (os.path.exists(config_path)):
             os.remove(config_path)
 
@@ -123,7 +123,7 @@ class Osc(FetchMethod):
         f.write("apisrv = %s\n" % ud.host)
         f.write("scheme = http\n")
         f.write("su-wrapper = su -c\n")
-        f.write("build-root = %s\n" % data.expand('${WORKDIR}', d))
+        f.write("build-root = %s\n" % d.getVar('WORKDIR', True))
         f.write("urllist = %s\n" % d.getVar("OSCURLLIST", True))
         f.write("extra-pkgs = gzip\n")
         f.write("\n")



