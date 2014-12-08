Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id B914365CAF
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Dec 2014 16:37:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	sB8Gb5iu005016
	for <bitbake-devel@lists.openembedded.org>; Mon, 8 Dec 2014 16:37:05 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id sKkTpCnsIC8a for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Dec 2014 16:37:05 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	sB8GanQs005002
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 8 Dec 2014 16:37:00 GMT
Message-ID: <1418056646.22903.20.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 08 Dec 2014 16:37:26 +0000
X-Mailer: Evolution 3.12.7-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] data: Handle BASH_FUNC shellshock implication
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
X-List-Received-Date: Mon, 08 Dec 2014 16:37:48 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The shellshock patches changed the way bash functions are exported.
Unfortunately different distros used slightly different formats,
Fedora went with BASH_FUNC_XXX()=() { echo foo; } and Ubuntu went with
BASH_FUNC_foo%%=() {  echo foo; }.

The former causes errors in dealing with out output from emit_env,
the functions are not exported in either case any more.

This patch handles things so the functions work as expected in either
case.

[YOCTO #6880]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
index 91b1eb1..eb628c7 100644
--- a/bitbake/lib/bb/data.py
+++ b/bitbake/lib/bb/data.py
@@ -219,6 +219,13 @@ def emit_var(var, o=sys.__stdout__, d = init(), all=False):
 
     val = str(val)
 
+    if varExpanded.startswith("BASH_FUNC_"):
+        varExpanded = varExpanded[10:-2]
+        val = val[3:] # Strip off "() "
+        o.write("%s() %s\n" % (varExpanded, val))
+        o.write("export -f %s\n" % (varExpanded))
+        return 1
+
     if func:
         # NOTE: should probably check for unbalanced {} within the var
         o.write("%s() {\n%s\n}\n" % (varExpanded, val))



