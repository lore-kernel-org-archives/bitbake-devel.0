Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web12.24015.1627652829946632077
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 Jul 2021 06:47:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=MQR/Ggwm;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id b7so11412607wri.8
        for <bitbake-devel@lists.openembedded.org>; Fri, 30 Jul 2021 06:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BD6wFLySBAQ2ZmNZvWJCA6fTT3qM6c8Ez7APJsC2/yI=;
        b=MQR/GgwmubJWPIaDzmSj2PQPfsvAOhbOYG6TN5ZCCpDcjGuBdtXopsW0/EXv7AVE8G
         9wb8uyD30JRNM08zbtNqoEduPbQU0QyNYhdmaxDDyv4jP2JZXgzLH7hUo2GBbL6yYaCF
         T8Xylae3Z0RfGXXIlnKa50U54k5a4EmiUCmis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BD6wFLySBAQ2ZmNZvWJCA6fTT3qM6c8Ez7APJsC2/yI=;
        b=QdHBT9a7kE+7Q4kAMnk4TQcFM9fKwKjP+jlSWMf2i5UtD48MriIDNz5tI5Jo2aSy7E
         IU5vUUoTUpYxJp+9Ona13SAN/7SGlUyVTUlpOWfojf+047rU1zaCxMtVRHeFN8Wlk5su
         sKO7QtGuw0DU0LcgSCLk1Wiy7BL2xE1RL7wy7Jx5HePGe3sNa4urvbmQaVlFc0/KZDaA
         TVd6W8+RsuWp/fyH4FINtoeaNqhbXE6/Zb1g9ztmU6pP6XRsJFS2hqdnM1+dHMwaCdEz
         shQg+NAmr3XqGBv8Ep/KFvgWnMQOmgcv5PUoSQFiGro09uD/IbxNi4XZVZqp/tbXSU60
         hBfg==
X-Gm-Message-State: AOAM530AZrBAJ25LmnZXHeEv7Ex/Zjvnuy7PI/Ff9qP24NxaLMzkmXTw
	RWWGNoMBeLNuGlTjSOLSYjIzbG+z2Pu6uQ==
X-Google-Smtp-Source: ABdhPJywExn+n13TjM5W5E95glf+NHcXxWkrS5VRES/R+qQk7c7I6EPzpQ3cWepXaNHAUPo/QukOjQ==
X-Received: by 2002:a5d:6448:: with SMTP id d8mr3136051wrw.295.1627652828387;
        Fri, 30 Jul 2021 06:47:08 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:47e7:2d3d:e4c2:218b])
        by smtp.gmail.com with ESMTPSA id p3sm1965969wmp.25.2021.07.30.06.47.08
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 06:47:08 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/4] doc/lib: Add fixes for issues missed by the automated conversion
Date: Fri, 30 Jul 2021 14:47:05 +0100
Message-Id: <20210730134706.3360651-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210730134706.3360651-1-richard.purdie@linuxfoundation.org>
References: <20210730134706.3360651-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The examples and tests use non-standard override names, convert these to
the new syntax by hand.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../bitbake-user-manual-metadata.rst          | 24 +++++-----
 lib/bb/tests/data.py                          | 46 +++++++++----------
 lib/bb/tests/parse.py                         |  2 +-
 3 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index db44e26fbd..372926064a 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -551,7 +551,7 @@ variable.
 
       DEPENDS = "glibc ncurses"
       OVERRIDES = "machine:local"
-      DEPENDS:append_machine = "libmad"
+      DEPENDS:append:machine = "libmad"
 
    In this example, :term:`DEPENDS` becomes "glibc ncurses libmad".
 
@@ -618,27 +618,27 @@ example::
 
    OVERRIDES = "foo"
    A = "Z"
-   A_foo:append = "X"
+   A:foo:append = "X"
 
 For this case,
 ``A`` is unconditionally set to "Z" and "X" is unconditionally and
-immediately appended to the variable ``A_foo``. Because overrides have
-not been applied yet, ``A_foo`` is set to "X" due to the append and
+immediately appended to the variable ``A:foo``. Because overrides have
+not been applied yet, ``A:foo`` is set to "X" due to the append and
 ``A`` simply equals "Z".
 
 Applying overrides, however, changes things. Since "foo" is listed in
 :term:`OVERRIDES`, the conditional variable ``A`` is replaced with the "foo"
-version, which is equal to "X". So effectively, ``A_foo`` replaces
+version, which is equal to "X". So effectively, ``A:foo`` replaces
 ``A``.
 
 This next example changes the order of the override and the append::
 
    OVERRIDES = "foo"
    A = "Z"
-   A:append_foo = "X"
+   A:append:foo = "X"
 
 For this case, before
-overrides are handled, ``A`` is set to "Z" and ``A_append_foo`` is set
+overrides are handled, ``A`` is set to "Z" and ``A:append:foo`` is set
 to "X". Once the override for "foo" is applied, however, ``A`` gets
 appended with "X". Consequently, ``A`` becomes "ZX". Notice that spaces
 are not appended.
@@ -648,15 +648,15 @@ back as in the first example::
 
    OVERRIDES = "foo"
    A = "Y"
-   A_foo:append = "Z"
-   A_foo:append = "X"
+   A:foo:append = "Z"
+   A:foo:append = "X"
 
 For this case, before any overrides are resolved,
 ``A`` is set to "Y" using an immediate assignment. After this immediate
-assignment, ``A_foo`` is set to "Z", and then further appended with "X"
+assignment, ``A:foo`` is set to "Z", and then further appended with "X"
 leaving the variable set to "ZX". Finally, applying the override for
 "foo" results in the conditional variable ``A`` becoming "ZX" (i.e.
-``A`` is replaced with ``A_foo``).
+``A`` is replaced with ``A:foo``).
 
 This final example mixes in some varying operators::
 
@@ -752,7 +752,7 @@ parsed. One way to achieve a conditional inherit in this case is to use
 overrides::
 
    VARIABLE = ""
-   VARIABLE_someoverride = "myclass"
+   VARIABLE:someoverride = "myclass"
 
 Another method is by using anonymous Python. Here is an example::
 
diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index add1b13600..7f1d3ffbbc 100644
--- a/lib/bb/tests/data.py
+++ b/lib/bb/tests/data.py
@@ -281,7 +281,7 @@ class TestConcatOverride(unittest.TestCase):
     # (including that whitespace is preserved)
     def test_remove_inactive_override(self):
         self.d.setVar("TEST", "${VAL} ${BAR}    123")
-        self.d.setVar("TEST:remove_inactiveoverride", "val")
+        self.d.setVar("TEST:remove:inactiveoverride", "val")
         self.assertEqual(self.d.getVar("TEST"), "val bar    123")
 
     def test_doubleref_remove(self):
@@ -329,35 +329,35 @@ class TestOverrides(unittest.TestCase):
         self.assertEqual(self.d.getVar("TEST"), "testvalue")
 
     def test_one_override(self):
-        self.d.setVar("TEST_bar", "testvalue2")
+        self.d.setVar("TEST:bar", "testvalue2")
         self.assertEqual(self.d.getVar("TEST"), "testvalue2")
 
     def test_one_override_unset(self):
-        self.d.setVar("TEST2_bar", "testvalue2")
+        self.d.setVar("TEST2:bar", "testvalue2")
 
         self.assertEqual(self.d.getVar("TEST2"), "testvalue2")
-        self.assertCountEqual(list(self.d.keys()), ['TEST', 'TEST2', 'OVERRIDES', 'TEST2_bar'])
+        self.assertCountEqual(list(self.d.keys()), ['TEST', 'TEST2', 'OVERRIDES', 'TEST2:bar'])
 
     def test_multiple_override(self):
-        self.d.setVar("TEST_bar", "testvalue2")
-        self.d.setVar("TEST_local", "testvalue3")
-        self.d.setVar("TEST_foo", "testvalue4")
+        self.d.setVar("TEST:bar", "testvalue2")
+        self.d.setVar("TEST:local", "testvalue3")
+        self.d.setVar("TEST:foo", "testvalue4")
         self.assertEqual(self.d.getVar("TEST"), "testvalue3")
-        self.assertCountEqual(list(self.d.keys()), ['TEST', 'TEST_foo', 'OVERRIDES', 'TEST_bar', 'TEST_local'])
+        self.assertCountEqual(list(self.d.keys()), ['TEST', 'TEST:foo', 'OVERRIDES', 'TEST:bar', 'TEST:local'])
 
     def test_multiple_combined_overrides(self):
-        self.d.setVar("TEST_local_foo_bar", "testvalue3")
+        self.d.setVar("TEST:local:foo:bar", "testvalue3")
         self.assertEqual(self.d.getVar("TEST"), "testvalue3")
 
     def test_multiple_overrides_unset(self):
-        self.d.setVar("TEST2_local_foo_bar", "testvalue3")
+        self.d.setVar("TEST2:local:foo:bar", "testvalue3")
         self.assertEqual(self.d.getVar("TEST2"), "testvalue3")
 
     def test_keyexpansion_override(self):
         self.d.setVar("LOCAL", "local")
-        self.d.setVar("TEST_bar", "testvalue2")
-        self.d.setVar("TEST_${LOCAL}", "testvalue3")
-        self.d.setVar("TEST_foo", "testvalue4")
+        self.d.setVar("TEST:bar", "testvalue2")
+        self.d.setVar("TEST:${LOCAL}", "testvalue3")
+        self.d.setVar("TEST:foo", "testvalue4")
         bb.data.expandKeys(self.d)
         self.assertEqual(self.d.getVar("TEST"), "testvalue3")
 
@@ -368,31 +368,31 @@ class TestOverrides(unittest.TestCase):
         self.assertEqual(self.d.getVar("ALTERNATIVE:lib32-ncurses-tools"), "a")
 
     def test_underscore_override(self):
-        self.d.setVar("TEST_bar", "testvalue2")
-        self.d.setVar("TEST_some_val", "testvalue3")
-        self.d.setVar("TEST_foo", "testvalue4")
+        self.d.setVar("TEST:bar", "testvalue2")
+        self.d.setVar("TEST:some_val", "testvalue3")
+        self.d.setVar("TEST:foo", "testvalue4")
         self.d.setVar("OVERRIDES", "foo:bar:some_val")
         self.assertEqual(self.d.getVar("TEST"), "testvalue3")
 
     def test_remove_with_override(self):
-        self.d.setVar("TEST_bar", "testvalue2")
-        self.d.setVar("TEST_some_val", "testvalue3 testvalue5")
-        self.d.setVar("TEST_some_val:remove", "testvalue3")
-        self.d.setVar("TEST_foo", "testvalue4")
+        self.d.setVar("TEST:bar", "testvalue2")
+        self.d.setVar("TEST:some_val", "testvalue3 testvalue5")
+        self.d.setVar("TEST:some_val:remove", "testvalue3")
+        self.d.setVar("TEST:foo", "testvalue4")
         self.d.setVar("OVERRIDES", "foo:bar:some_val")
         self.assertEqual(self.d.getVar("TEST"), " testvalue5")
 
     def test_append_and_override_1(self):
         self.d.setVar("TEST:append", "testvalue2")
-        self.d.setVar("TEST_bar", "testvalue3")
+        self.d.setVar("TEST:bar", "testvalue3")
         self.assertEqual(self.d.getVar("TEST"), "testvalue3testvalue2")
 
     def test_append_and_override_2(self):
-        self.d.setVar("TEST:append_bar", "testvalue2")
+        self.d.setVar("TEST:append:bar", "testvalue2")
         self.assertEqual(self.d.getVar("TEST"), "testvaluetestvalue2")
 
     def test_append_and_override_3(self):
-        self.d.setVar("TEST_bar:append", "testvalue2")
+        self.d.setVar("TEST:bar:append", "testvalue2")
         self.assertEqual(self.d.getVar("TEST"), "testvalue2")
 
     # Test an override with _<numeric> in it based on a real world OE issue
diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
index 02a5c4952a..1b6b6d412e 100644
--- a/lib/bb/tests/parse.py
+++ b/lib/bb/tests/parse.py
@@ -144,7 +144,7 @@ PN = "bc"
 
 
     classextend = """
-VAR_var_override1 = "B"
+VAR_var:override1 = "B"
 EXTRA = ":override1"
 OVERRIDES = "nothing${EXTRA}"
 
-- 
2.30.2

