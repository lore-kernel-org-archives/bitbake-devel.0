Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id F0BC46018C
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Feb 2016 13:58:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u12DwNXl003809
	for <bitbake-devel@lists.openembedded.org>; Tue, 2 Feb 2016 13:58:23 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id qH8-Wk9ssF4g for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Feb 2016 13:58:23 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u12DwHg3003806
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 2 Feb 2016 13:58:18 GMT
Message-ID: <1454421497.27087.66.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 02 Feb 2016 13:58:17 +0000
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] data: Don't expand python functions for variable dependencies
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
X-List-Received-Date: Tue, 02 Feb 2016 13:58:23 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Expanding python functions for variable dependencies doesn't really make sense, 
not least since this causes execution of any inline python, it also makes it
impossible to write expressions like d.expand("${X}") of d.setVar("X", "${Y}")
which may have the wrong values if expanded now.

This starts to standardise the approach across bitbake for handling python code.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
index 70ba56b..1f1f0d2 100644
--- a/bitbake/lib/bb/data.py
+++ b/bitbake/lib/bb/data.py
@@ -362,11 +362,10 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, d):
            value = varflags.get("vardepvalue")
         elif varflags.get("func"):
             if varflags.get("python"):
-                parsedvar = d.expandWithRefs(value, key)
                 parser = bb.codeparser.PythonParser(key, logger)
-                if parsedvar.value and "\t" in parsedvar.value:
+                if value and "\t" in value:
                     logger.warn("Variable %s contains tabs, please remove these (%s)" % (key, d.getVar("FILE", True)))
-                parser.parse_python(parsedvar.value, filename=varflags.get("filename"), lineno=varflags.get("lineno"))
+                parser.parse_python(value, filename=varflags.get("filename"), lineno=varflags.get("lineno"))
                 deps = deps | parser.references
                 value = handle_contains(value, parser.contains, d)
             else:
@@ -374,15 +373,15 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, d):
                 parser = bb.codeparser.ShellParser(key, logger)
                 parser.parse_shell(parsedvar.value)
                 deps = deps | shelldeps
+                deps = deps | parsedvar.references
+                deps = deps | (keys & parser.execs) | (keys & parsedvar.execs)
+                value = handle_contains(value, parsedvar.contains, d)
             if vardeps is None:
                 parser.log.flush()
             if "prefuncs" in varflags:
                 deps = deps | set(varflags["prefuncs"].split())
             if "postfuncs" in varflags:
                 deps = deps | set(varflags["postfuncs"].split())
-            deps = deps | parsedvar.references
-            deps = deps | (keys & parser.execs) | (keys & parsedvar.execs)
-            value = handle_contains(value, parsedvar.contains, d)
         else:
             parser = d.expandWithRefs(value, key)
             deps |= parser.references



