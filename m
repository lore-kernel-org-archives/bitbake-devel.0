Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 30BD7731D0
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  4 Jan 2016 17:32:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u04HVdcc011502
	for <bitbake-devel@lists.openembedded.org>; Mon, 4 Jan 2016 17:32:02 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id zK_gu3jqaD-c for <bitbake-devel@lists.openembedded.org>;
	Mon,  4 Jan 2016 17:32:02 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u04HVwC1011516
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 4 Jan 2016 17:31:59 GMT
Message-ID: <1451928718.7598.13.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 04 Jan 2016 17:31:58 +0000
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] data: Pass lineno/filename data from build_dependencies
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
X-List-Received-Date: Mon, 04 Jan 2016 17:32:02 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If parse_python() fails, the output is confusing. Passing in the extra
file/line data isn't expensive and improves readability significantly.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
index f6415a4..dc8d02e 100644
--- a/bitbake/lib/bb/data.py
+++ b/bitbake/lib/bb/data.py
@@ -338,7 +338,7 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, d):
             deps |= parser.references
             deps = deps | (keys & parser.execs)
             return deps, value
-        varflags = d.getVarFlags(key, ["vardeps", "vardepvalue", "vardepsexclude", "vardepvalueexclude", "postfuncs", "prefuncs"]) or {}
+        varflags = d.getVarFlags(key, ["vardeps", "vardepvalue", "vardepsexclude", "vardepvalueexclude", "postfuncs", "prefuncs", "lineno", "filename"]) or {}
         vardeps = varflags.get("vardeps")
         value = d.getVar(key, False)
 
@@ -365,7 +365,7 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, d):
                 parser = bb.codeparser.PythonParser(key, logger)
                 if parsedvar.value and "\t" in parsedvar.value:
                     logger.warn("Variable %s contains tabs, please remove these (%s)" % (key, d.getVar("FILE", True)))
-                parser.parse_python(parsedvar.value)
+                parser.parse_python(parsedvar.value, filename=varflags.get("filename"), lineno=varflags.get("lineno"))
                 deps = deps | parser.references
                 value = handle_contains(value, parser.contains, d)
             else:



