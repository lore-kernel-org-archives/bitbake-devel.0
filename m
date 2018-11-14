Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 0FBE96C426
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Nov 2018 09:35:14 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id wAE9ZGvl016373
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Nov 2018 01:35:16 -0800 (PST)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.408.0; Wed, 14 Nov 2018 01:35:15 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 14 Nov 2018 17:46:39 +0800
Message-ID: <e60e633f668e5bb1c9fb0fa14f84577504b38d9a.1542188647.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1542188647.git.liezhi.yang@windriver.com>
References: <cover.1542188647.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 4/6] bitbake: data_smart: fix filename for compile()
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
X-List-Received-Date: Wed, 14 Nov 2018 09:35:15 -0000
Content-Type: text/plain

Fixed:
Add the following two lines to conf/local.conf:
FOO = "${@foo = 5}"
HOSTTOOLS += "${FOO}"

* Before the patch
  $ bitbake -p
  Check the first lines of bitbake bitbake-cookerdaemon.log
  [snip]
  File "/buildarea1/lyang1/poky/bitbake/lib/bb/data_smart.py", line 125, in python_sub
    codeobj = compile(code.strip(), self.varname or "<expansion>", "eval")
  File "FOO", line 1
  [snip]

  There isn't a file named 'FOO', but a variable name.

* After the patch
  $ bitbake -p
  [snip]
  File "/buildarea1/lyang1/poky/bitbake/lib/bb/data_smart.py", line 129, in python_sub
    codeobj = compile(code.strip(), varname, "eval")
  File "Var <FOO>", line 1
    foo = 5

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/data_smart.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index efa5a79..67af380 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -122,7 +122,11 @@ class VariableParse:
                 connector = self.d["_remote_data"]
                 return connector.expandPythonRef(self.varname, code, self.d)
 
-            codeobj = compile(code.strip(), self.varname or "<expansion>", "eval")
+            if self.varname:
+                varname = 'Var <%s>' % self.varname
+            else:
+                varname = '<expansion>'
+            codeobj = compile(code.strip(), varname, "eval")
 
             parser = bb.codeparser.PythonParser(self.varname, logger)
             parser.parse_python(code)
-- 
2.7.4


