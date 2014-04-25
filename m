Return-Path: <otavio.salvador@gmail.com>
Received: from mail-yk0-f172.google.com (mail-yk0-f172.google.com
	[209.85.160.172])
	by mail.openembedded.org (Postfix) with ESMTP id F225E65E00
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Apr 2014 21:21:29 +0000 (UTC)
Received: by mail-yk0-f172.google.com with SMTP id q9so3078216ykb.31
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Apr 2014 14:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
	:organization; bh=cSsD3Od4ysIvPe7QcfoO6fxWTP7nCGc947qn91MdPcw=;
	b=zki6jeKORPaxDsaew1l0DNgVlt/W6muvi27oo9oSOS1DLxZE/lkyHS/vI5Hr28ACbf
	z+MrVcNniU4BjLlxiOYOgkhIiVS4P/lzHEi5y9VzUMhLuHazizRb5hSBvtf549RD96jb
	kHPfuNjAIwIwoKU8sPMpYH0jwQ5cSnFjuyI6/UT1toB+sn3H+ZWd0mcxwyrf2i8jFPYk
	dE3JsX0yRzyd7MA1ox63AYMJiGmfARTg/Gdh+Y6wrEkmlLQpLKWbjxpqpusFHE76671u
	01DMdP/sYAQECOhgxKLUGPNqiO3j2lHS+DndGF8sY7Hl9+2q6Egp+3kaVHyUR/GgUxwj
	zEjA==
X-Received: by 10.236.88.116 with SMTP id z80mr6426720yhe.112.1398460890291;
	Fri, 25 Apr 2014 14:21:30 -0700 (PDT)
Received: from nano.lab.ossystems.com.br ([177.194.208.225])
	by mx.google.com with ESMTPSA id l4sm15645212yhj.24.2014.04.25.14.21.27
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 25 Apr 2014 14:21:28 -0700 (PDT)
Sender: Otavio Salvador <otavio.salvador@gmail.com>
Received: by nano.lab.ossystems.com.br (Postfix, from userid 1000)
	id 1C27C1A5BA21D; Fri, 25 Apr 2014 18:21:25 -0300 (BRT)
From: Otavio Salvador <otavio@ossystems.com.br>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 25 Apr 2014 18:21:24 -0300
Message-Id: <1398460884-26033-2-git-send-email-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.0.0.rc0
In-Reply-To: <1398460884-26033-1-git-send-email-otavio@ossystems.com.br>
References: <1398460884-26033-1-git-send-email-otavio@ossystems.com.br>
Organization: O.S. Systems Software LTDA.
Cc: Otavio Salvador <otavio@ossystems.com.br>
Subject: [PATCH 2/2] bb.utils, bb.codeparser: Add bb.utils.contains_any
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
X-List-Received-Date: Fri, 25 Apr 2014 21:21:33 -0000

This includes contains_any in the special handling code for sstate. It
does not take into account the equivalence of the values. In current
code, considering 'bb.utils.contains_any("A", "foo bar", ...)':

A = "foo"
A = "bar"
A = "foo bar"

All those will get different signatures.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---
 lib/bb/codeparser.py |  3 ++-
 lib/bb/utils.py      | 13 +++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index b4b1013..58e0016 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -103,7 +103,8 @@ class BufferedLogger(Logger):
 
 class PythonParser():
     getvars = ("d.getVar", "bb.data.getVar", "data.getVar", "d.appendVar", "d.prependVar")
-    containsfuncs = ("bb.utils.contains", "base_contains")
+    containsfuncs = ("bb.utils.contains", "base_contains",
+                     "bb.utils.contains_any", "base_contains_any")
     execfuncs = ("bb.build.exec_func", "bb.build.exec_task")
 
     def warn(self, func, arg):
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 0be45e1..1be1874 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -845,6 +845,19 @@ def contains(variable, checkvalues, truevalue, falsevalue, d):
         return truevalue
     return falsevalue
 
+def contains_any(variable, checkvalues, truevalue, falsevalue, d):
+    val = d.getVar(variable, True)
+    if not val:
+        return falsevalue
+    val = set(val.split())
+    if isinstance(checkvalues, basestring):
+        checkvalues = set(checkvalues.split())
+    else:
+        checkvalues = set(checkvalues)
+    if checkvalues in val:
+        return truevalue
+    return falsevalue
+
 def cpu_count():
     return multiprocessing.cpu_count()
 
-- 
2.0.0.rc0


