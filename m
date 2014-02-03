Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id ECCE56E949
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  3 Feb 2014 16:18:05 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s13GI0bb015393
	for <bitbake-devel@lists.openembedded.org>; Mon, 3 Feb 2014 16:18:00 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 8F2HnbLlqIkC for <bitbake-devel@lists.openembedded.org>;
	Mon,  3 Feb 2014 16:18:00 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s13GHr9S015332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 3 Feb 2014 16:17:55 GMT
Message-ID: <1391444267.3330.3.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 03 Feb 2014 16:17:47 +0000
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] data: Account for pre/postfunc functions when calculating dependencies
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
X-List-Received-Date: Mon, 03 Feb 2014 16:18:08 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

pre/postfuncs were not being added to checksums. This meant that when reconfiguration
occurred, tasks were not always being rerun when they should. This include
sstate functions as well as systemd's do_install function in the OE metadata.

With the addition of postfuncs, its possible a shell task can have a python
pre/postfunc so we have to guard against this when generating shell output
in emit_func.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
index 5840803..a56b79c 100644
--- a/bitbake/lib/bb/data.py
+++ b/bitbake/lib/bb/data.py
@@ -275,7 +275,7 @@ def emit_func(func, o=sys.__stdout__, d = init()):
         seen |= deps
         newdeps = set()
         for dep in deps:
-            if d.getVarFlag(dep, "func"):
+            if d.getVarFlag(dep, "func") and not d.getVarFlag(dep, "python"):
                emit_var(dep, o, d, False) and o.write('\n')
                newdeps |=  bb.codeparser.ShellParser(dep, logger).parse_shell(d.getVar(dep, True))
                newdeps |= set((d.getVarFlag(dep, "vardeps", True) or "").split())
@@ -295,7 +295,7 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, d):
             deps |= parser.references
             deps = deps | (keys & parser.execs)
             return deps, value
-        varflags = d.getVarFlags(key, ["vardeps", "vardepvalue", "vardepsexclude"]) or {}
+        varflags = d.getVarFlags(key, ["vardeps", "vardepvalue", "vardepsexclude", "postfuncs", "prefuncs"]) or {}
         vardeps = varflags.get("vardeps")
         value = d.getVar(key, False)
 
@@ -332,6 +332,10 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, d):
                 deps = deps | shelldeps
             if vardeps is None:
                 parser.log.flush()
+            if "prefuncs" in varflags:
+                deps = deps | set(varflags["prefuncs"].split())
+            if "postfuncs" in varflags:
+                deps = deps | set(varflags["postfuncs"].split())
             deps = deps | parsedvar.references
             deps = deps | (keys & parser.execs) | (keys & parsedvar.execs)
             value = handle_contains(value, parsedvar.contains, d)



