Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id EE7DF6F281
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Feb 2014 17:24:38 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s1SHOY8e004676 for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Feb 2014 17:24:34 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id vCqSy0G9aVVL for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Feb 2014 17:24:34 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s1SHOVbV004668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Feb 2014 17:24:33 GMT
Message-ID: <1393608264.31769.201.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 28 Feb 2014 17:24:24 +0000
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] fetch/svk: Drop usage of old style *COMMAND variable and MKTEMPDIRCMD
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
X-List-Received-Date: Fri, 28 Feb 2014 17:24:39 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Clean up some horrible old code and drop usage of the old style *COMMAND
variable and MKTEMPDIRCMD whilst in here. This means we don't need to touch
OVERRIDES either.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/fetch2/svk.py b/bitbake/lib/bb/fetch2/svk.py
index 23631b4..6f70a3b 100644
--- a/bitbake/lib/bb/fetch2/svk.py
+++ b/bitbake/lib/bb/fetch2/svk.py
@@ -72,12 +72,10 @@ class Svk(FetchMethod):
             svkcmd = "svk co -r %s %s/%s" % (ud.revision, svkroot, ud.module)
 
         # create temp directory
-        localdata = data.createCopy(d)
-        data.update_data(localdata)
         logger.debug(2, "Fetch: creating temporary directory")
-        bb.utils.mkdirhier(data.expand('${WORKDIR}', localdata))
-        data.setVar('TMPBASE', data.expand('${WORKDIR}/oesvk.XXXXXX', localdata), localdata)
-        tmpfile, errors = bb.process.run(data.getVar('MKTEMPDIRCMD', localdata, True) or "false")
+        bb.utils.mkdirhier(d.expand('${WORKDIR}'))
+        mktemp = d.getVar("FETCHCMD_svkmktemp", True) or d.expand("mktemp -d -q '${WORKDIR}/oesvk.XXXXXX'")
+        tmpfile, errors = bb.process.run(mktemp)
         tmpfile = tmpfile.strip()
         if not tmpfile:
             logger.error()



