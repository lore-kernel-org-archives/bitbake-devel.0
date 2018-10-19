Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
	[209.85.128.65])
	by mail.openembedded.org (Postfix) with ESMTP id 192F471AC1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 Oct 2018 11:27:39 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id y11-v6so3278940wma.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 Oct 2018 04:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id;
	bh=r9CA1joWI8XI7aIocDr0hPq7P7I3YSZ0PMdk1WGi24g=;
	b=DvdEt50Un9gkbvHF2yD9sl6Ry2A2Izf0UIoG0Al6PK5K9qg0PvIcmw6+aCM64UE2bV
	1Tp/C2yAf4lBthO0yyQVpIxb34FaXSGtS1KafgOtsfSU/Fbw4I+c//IrTUH+E8enu8vD
	p/lplIx7kNvXPq/5rMMBu70WDWDah5PkyZ7eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=r9CA1joWI8XI7aIocDr0hPq7P7I3YSZ0PMdk1WGi24g=;
	b=hbDlFHYEnY+ZRKroNY/eWZd7SN2IZ+xLeGs4Zy5nqxRbw26z8GmFVH5w+smXwkIAeK
	DHGqr3KA4ipfPMLInthz/zwxAD/IphGpyLjyMixvZHqcdn2jV0MGrpNddY8MokIOddo+
	smNy8gzcOi484ce44l1pDqUSpNsYmgh50oAJvNqZgNtqwUlxpSao1ko3PEcFd8U3VXUK
	x5Ihl0SXZzOCFJ/4dbbdcduO4e4ONX+CpKdIHfBk9IRYGfI9p/2rfmPcbGL4UWnOOX5a
	4y6TaESie0O5Ow4WzXEEcM7mukF18beHH6QRf+vmHYkY2yd07jWvZwDunG4W+IsZmanG
	isgg==
X-Gm-Message-State: ABuFfoiKJtpI2GaHnZ1W9sC8OvtmTUkYS/8FGR/r8bDEMWaJTNudb3tP
	mz5nxj+C5rY/TwQ48Jg8JlgFJSJ5nSA=
X-Google-Smtp-Source: ACcGV63+wIgNQQaJJdj09oEEoL79D9iIJIn++gHE4KYrxLwL3tBxV5rge+LaiTr3Av0VhPA22FAQ4w==
X-Received: by 2002:a1c:1507:: with SMTP id 7-v6mr4293612wmv.6.1539948460271; 
	Fri, 19 Oct 2018 04:27:40 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	65-v6sm2487934wmm.36.2018.10.19.04.27.38
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 19 Oct 2018 04:27:39 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 19 Oct 2018 12:27:38 +0100
Message-Id: <20181019112738.13045-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
Subject: [PATCH] data_smart: Fix removal handling interaction issue with overrides
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
X-List-Received-Date: Fri, 19 Oct 2018 11:27:40 -0000

If a variable has a _remove applied to it but that variable is in turn
'renamed' through OVERRIDES, the removal gets lost with the current code.

TEST = "foo"
TEST_someval = "bar"
TEST_someval_remove = "bar"
OVERRIDES = "someval"

currently gives "bar" for TEST but should give "".

This fixes the code to track the removal and adds a test case to ensure this
doesn't regress again.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 17 +++++++++++++----
 lib/bb/tests/data.py |  9 +++++++++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 8c4c6a9a32..6b94fc4b42 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -736,6 +736,7 @@ class DataSmart(MutableMapping):
 
         local_var, overridedata = self._findVar(var)
         value = None
+        removes = set()
         if flag == "_content" and overridedata is not None and not parsing:
             match = False
             active = {}
@@ -762,7 +763,11 @@ class DataSmart(MutableMapping):
                             match = active[a]
                             del active[a]
             if match:
-                value = self.getVar(match, False)
+                value, subparser = self.getVarFlag(match, "_content", False, retparser=True)
+                if hasattr(subparser, "removes"):
+                    # We have to carry the removes from the overridden variable to apply at the
+                    # end of processing
+                    removes = subparser.removes
 
         if local_var is not None and value is None:
             if flag in local_var:
@@ -805,7 +810,6 @@ class DataSmart(MutableMapping):
             value = parser.value
 
         if value and flag == "_content" and local_var is not None and "_remove" in local_var and not parsing:
-            removes = {}
             self.need_overrides()
             for (r, o) in local_var["_remove"]:
                 match = True
@@ -814,15 +818,20 @@ class DataSmart(MutableMapping):
                         if not o2 in self.overrides:
                             match = False                            
                 if match:
-                    removes[r] = self.expand(r).split()
+                    removes.add(r)
 
+        if value and flag == "_content" and not parsing:
             if removes and parser:
+                expanded_removes = {}
+                for r in removes:
+                    expanded_removes[r] = self.expand(r).split()
+
                 parser.removes = set()
                 val = ""
                 for v in __whitespace_split__.split(parser.value):
                     skip = False
                     for r in removes:
-                        if v in removes[r]:
+                        if v in expanded_removes[r]:
                             parser.removes.add(r)
                             skip = True
                     if skip:
diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index 9ac78e3683..db3e2010a9 100644
--- a/lib/bb/tests/data.py
+++ b/lib/bb/tests/data.py
@@ -386,6 +386,15 @@ class TestOverrides(unittest.TestCase):
         self.d.setVar("OVERRIDES", "foo:bar:some_val")
         self.assertEqual(self.d.getVar("TEST"), "testvalue3")
 
+    def test_remove_with_override(self):
+        self.d.setVar("TEST_bar", "testvalue2")
+        self.d.setVar("TEST_some_val", "testvalue3 testvalue5")
+        self.d.setVar("TEST_some_val_remove", "testvalue3")
+        self.d.setVar("TEST_foo", "testvalue4")
+        self.d.setVar("OVERRIDES", "foo:bar:some_val")
+        self.assertEqual(self.d.getVar("TEST"), " testvalue5")
+
+
 class TestKeyExpansion(unittest.TestCase):
     def setUp(self):
         self.d = bb.data.init()
-- 
2.17.1


