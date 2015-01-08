Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id EC63D7284C
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  8 Jan 2015 10:35:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t08AYscx023835
	for <bitbake-devel@lists.openembedded.org>; Thu, 8 Jan 2015 10:34:54 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id p9s6AlLnIqAP for <bitbake-devel@lists.openembedded.org>;
	Thu,  8 Jan 2015 10:34:54 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t08AYdDe023822
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 8 Jan 2015 10:34:50 GMT
Message-ID: <1420713316.25779.84.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 08 Jan 2015 10:35:16 +0000
X-Mailer: Evolution 3.12.7-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] ast: Add error when trying to use dash in sh function names
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
X-List-Received-Date: Thu, 08 Jan 2015 10:35:35 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

A dash character is illegal in function names in sh (but not bash). Since
our shell tasks run under sh and the shell parser is sh based, EXPORT_FUNCTIONS
won't work with class names containing a dash.

We can't change sh, we can ensure the user is warned about the problem 
straight away though.

[YOCTO #7006]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
index af42a0c..879c9d2 100644
--- a/bitbake/lib/bb/parse/ast.py
+++ b/bitbake/lib/bb/parse/ast.py
@@ -226,6 +226,8 @@ class ExportFuncsNode(AstNode):
             if data.getVarFlag(calledfunc, "python"):
                 data.setVar(func, "    bb.build.exec_func('" + calledfunc + "', d)\n")
             else:
+                if "-" in self.classname:
+                   bb.fatal("The classname %s contains a dash character and is calling an sh function %s using EXPORT_FUNCTIONS. Since a dash is illegal in sh function names, this cannot work, please rename the class or don't use EXPORT_FUNCTIONS." % (self.classname, calledfunc))
                 data.setVar(func, "    " + calledfunc + "\n")
             data.setVarFlag(func, 'export_func', '1')
 




