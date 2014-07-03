Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 9E9EE609B1
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Jul 2014 10:39:52 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s63AdmpW029236 for <bitbake-devel@lists.openembedded.org>;
	Thu, 3 Jul 2014 11:39:48 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id vrBRw8rzs4Xd for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Jul 2014 11:39:48 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s63AdfN5029232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 3 Jul 2014 11:39:43 +0100
Message-ID: <1404383974.6362.79.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 03 Jul 2014 11:39:34 +0100
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] fetch2/svn: Add transportuser parameter
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
X-List-Received-Date: Thu, 03 Jul 2014 10:39:54 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

There may be a need to set the user for the transport rather than the subversion
command itself. Add a parameter to the url to allow this.

[YOCTO #6475]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/fetch2/svn.py b/bitbake/lib/bb/fetch2/svn.py
index 8847461..1733c2b 100644
--- a/bitbake/lib/bb/fetch2/svn.py
+++ b/bitbake/lib/bb/fetch2/svn.py
@@ -101,7 +101,8 @@ class Svn(FetchMethod):
                 suffix = "@%s" % (ud.revision)
 
             if command == "fetch":
-                svncmd = "%s co %s %s://%s/%s%s %s" % (ud.basecmd, " ".join(options), proto, svnroot, ud.module, suffix, ud.module)
+                transportuser = ud.parm.get("transportuser", "")
+                svncmd = "%s co %s %s://%s%s/%s%s %s" % (ud.basecmd, " ".join(options), proto, transportuser, svnroot, ud.module, suffix, ud.module)
             elif command == "update":
                 svncmd = "%s update %s" % (ud.basecmd, " ".join(options))
             else:



