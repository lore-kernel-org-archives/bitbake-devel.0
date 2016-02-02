Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 44731731F9
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Feb 2016 13:54:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u12DshmJ003673
	for <bitbake-devel@lists.openembedded.org>; Tue, 2 Feb 2016 13:54:43 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id f0qJ5uS1j473 for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Feb 2016 13:54:43 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u12Dsbmj003670
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 2 Feb 2016 13:54:38 GMT
Message-ID: <1454421277.27087.62.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 02 Feb 2016 13:54:37 +0000
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] parse/ast: Mark anonymous functions as python functions
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
X-List-Received-Date: Tue, 02 Feb 2016 13:54:43 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Anonymous functions are python functions, set the variable
flags as such so we can detect them and avoid expansion where
needed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
index cff0d2b..1c5b9d1 100644
--- a/bitbake/lib/bb/parse/ast.py
+++ b/bitbake/lib/bb/parse/ast.py
@@ -156,8 +156,8 @@ class MethodNode(AstNode):
             anonfuncs = data.getVar('__BBANONFUNCS', False) or []
             anonfuncs.append(funcname)
             data.setVar('__BBANONFUNCS', anonfuncs)
-        else:
-            data.setVarFlag(self.func_name, "func", 1)
+            data.setVarFlag(funcname, "python", 1)
+        data.setVarFlag(funcname, "func", 1)
         data.setVar(funcname, text, parsing=True)
         data.setVarFlag(funcname, 'filename', self.filename)
         data.setVarFlag(funcname, 'lineno', str(self.lineno - len(self.body)))



