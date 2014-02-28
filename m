Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 6C0DA6F2FE
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Feb 2014 17:38:30 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s1SHcQDw005320 for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Feb 2014 17:38:26 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id XJl_egtrTECf for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Feb 2014 17:38:25 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s1SHcMjn005317
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Feb 2014 17:38:23 GMT
Message-ID: <1393609095.31769.204.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 28 Feb 2014 17:38:15 +0000
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] codeparser: Fix var_execs to append to execs, not references
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
X-List-Received-Date: Fri, 28 Feb 2014 17:38:34 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

When using the "execs" information in new code, it became clear that
the returned data was incorrect and there were missing exec'd functions.
This corrects the error and changes one of the test results to match
the correct behaviour.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/codeparser.py b/bitbake/lib/bb/codeparser.py
index 62b6cf9..a50b9f2 100644
--- a/bitbake/lib/bb/codeparser.py
+++ b/bitbake/lib/bb/codeparser.py
@@ -186,7 +186,7 @@ class PythonParser():
             if n.__class__.__name__ == "Call":
                 self.visit_Call(n)
 
-        self.references.update(self.var_execs)
+        self.execs.update(self.var_execs)
 
         codeparsercache.pythoncacheextras[h] = {}
         codeparsercache.pythoncacheextras[h]["refs"] = self.references
diff --git a/bitbake/lib/bb/tests/codeparser.py b/bitbake/lib/bb/tests/codeparser.py
index 938b04b..4454bc5 100644
--- a/bitbake/lib/bb/tests/codeparser.py
+++ b/bitbake/lib/bb/tests/codeparser.py
@@ -236,7 +236,8 @@ be. These unit tests are testing snippets."""
             self.d.setVar("do_something", "echo 'hi mom! ${FOO}'")
             self.d.setVarFlag("do_something", etype, True)
             self.parseExpression("bb.build.exec_func('do_something', d)")
-            self.assertReferences(set(["do_something"]))
+            self.assertReferences(set([]))
+            self.assertExecs(set(["do_something"]))
 
     def test_function_reference(self):
         self.context["testfunc"] = lambda msg: bb.msg.note(1, None, msg)



