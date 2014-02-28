Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 0BA576F281
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Feb 2014 17:24:01 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s1SHNvEE004653 for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Feb 2014 17:23:57 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 0kLT07FCvLwg for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Feb 2014 17:23:57 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s1SHNqPI004650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Feb 2014 17:23:54 GMT
Message-ID: <1393608225.31769.200.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 28 Feb 2014 17:23:45 +0000
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] fetch/perforce: Drop usage of old style *COMMAND variable and MKTEMPDIRCMD
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
X-List-Received-Date: Fri, 28 Feb 2014 17:24:03 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Clean up some horrible old code and drop usage of the old style *COMMAND
variable and MKTEMPDIRCMD whilst in here. This means we don't need to touch
OVERRIDES either.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/fetch2/perforce.py b/bitbake/lib/bb/fetch2/perforce.py
index 7491a53..9329d72 100644
--- a/bitbake/lib/bb/fetch2/perforce.py
+++ b/bitbake/lib/bb/fetch2/perforce.py
@@ -89,7 +89,7 @@ class Perforce(FetchMethod):
         elif p4date:
             depot += "@%s" % (p4date)
 
-        p4cmd = data.getVar('FETCHCOMMAND_p4', d, True)
+        p4cmd = data.getVar('FETCHCMD_p4', d, True)
         logger.debug(1, "Running %s%s changes -m 1 %s", p4cmd, p4opt, depot)
         p4file, errors = bb.process.run("%s%s changes -m 1 %s" % (p4cmd, p4opt, depot))
         cset = p4file.strip()
@@ -134,10 +134,6 @@ class Perforce(FetchMethod):
 
         module = parm.get('module', os.path.basename(path))
 
-        localdata = data.createCopy(d)
-        data.setVar('OVERRIDES', "p4:%s" % data.getVar('OVERRIDES', localdata), localdata)
-        data.update_data(localdata)
-
         # Get the p4 command
         p4opt = ""
         if user:
@@ -149,13 +145,13 @@ class Perforce(FetchMethod):
         if host:
             p4opt += " -p %s" % (host)
 
-        p4cmd = data.getVar('FETCHCOMMAND', localdata, True)
+        p4cmd = data.getVar('FETCHCMD_p4', d, True)
 
         # create temp directory
         logger.debug(2, "Fetch: creating temporary directory")
-        bb.utils.mkdirhier(data.expand('${WORKDIR}', localdata))
-        data.setVar('TMPBASE', data.expand('${WORKDIR}/oep4.XXXXXX', localdata), localdata)
-        tmpfile, errors = bb.process.run(data.getVar('MKTEMPDIRCMD', localdata, True) or "false")
+        bb.utils.mkdirhier(d.expand('${WORKDIR}'))
+        mktemp = d.getVar("FETCHCMD_p4mktemp", True) or d.expand("mktemp -d -q '${WORKDIR}/oep4.XXXXXX'")
+        tmpfile, errors = bb.process.run(mktemp)
         tmpfile = tmpfile.strip()
         if not tmpfile:
             raise FetchError("Fetch: unable to create temporary directory.. make sure 'mktemp' is in the PATH.", ud.url)



