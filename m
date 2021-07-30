Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web11.24082.1627652829782901450
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 Jul 2021 06:47:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ISlGEJoV;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id n12so11430016wrr.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 30 Jul 2021 06:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=T09KQk3KmYPueeZ+Qq7l48J0tH26fP2luDjcs/jJLdw=;
        b=ISlGEJoV+4DC4kUSoDAQRfXmR/yqQHG40JL/Cm6KCB1FHqlfbYh4ei2/KG/e+iMTp0
         yK7Z5P3OXDOMcQOm4q05eNkmhoAWtVgRrCFbq8BuRQpV2E9IsrX2bGkUJJh2CzfSgkn/
         ZovOflnbJ8WWqWyeWbNfz6kQeOoNEzrb9Oz70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T09KQk3KmYPueeZ+Qq7l48J0tH26fP2luDjcs/jJLdw=;
        b=KXFuR0NTpCXUdvKqgd5WhC9dECPnHid26vbEBFRpW/N8eYsR2KA3Ajhs2ch3xtKGLl
         BS84lgu4woFYE/78ZiK+PJEFHzYHL4sLJ7EyXY+s18C2VoGVY7PsdyYDaAd1jC0JmXCq
         YkmieIG1TsJOxPT4Uj94GnJnPKzb6KqisRe06+UIl3atgdaGsxFkTaRMQcWhdsqY17By
         RKxb2gcsZKOhA7q90kM3rSG8pkyyc+gB5AQycSDyjfj3ihiE3W5Kjo6C7pgVLQs7ABmD
         QlG65Ip0xbkENILZ4u8o7YTQWY+vxivr387TcV2b1DWmQw30oeZ75E4g3w0daxDumplb
         7i9g==
X-Gm-Message-State: AOAM533OaQ1Ia+8LnBk9nCUxeBb/oY6zO3Y5mGFtYM4ZRkIjFiW7zXan
	0RaY+3ssH0+QSuuMyAUS4N4KEzx/JlTAsw==
X-Google-Smtp-Source: ABdhPJw0Iy9a1cRtqDvdQXFUJPdnVTloxlwR80et3rjo2UsFiBoKoIKbLmcEYwJTA7txZXYE4P3XDg==
X-Received: by 2002:adf:ed51:: with SMTP id u17mr3144181wro.416.1627652827987;
        Fri, 30 Jul 2021 06:47:07 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:47e7:2d3d:e4c2:218b])
        by smtp.gmail.com with ESMTPSA id p3sm1965969wmp.25.2021.07.30.06.47.07
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 06:47:07 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/4] doc/lib: Update to use new override syntax containing colons
Date: Fri, 30 Jul 2021 14:47:04 +0100
Message-Id: <20210730134706.3360651-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210730134706.3360651-1-richard.purdie@linuxfoundation.org>
References: <20210730134706.3360651-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This runs the overrides conversion script in OE-Core over the bitbake code
base including the docs. A handful of things were excluded in toaster
and for the Changelog file.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 contrib/vim/plugin/newbbappend.vim            |  2 +-
 .../bitbake-user-manual-metadata.rst          | 64 +++++++++----------
 .../bitbake-user-manual-ref-variables.rst     | 14 ++--
 lib/bb/fetch2/__init__.py                     |  2 +-
 lib/bb/tests/data.py                          | 52 +++++++--------
 lib/bb/tests/parse.py                         | 16 ++---
 lib/toaster/orm/models.py                     |  2 +-
 lib/toaster/toastergui/views.py               |  6 +-
 .../management/commands/buildimport.py        |  2 +-
 9 files changed, 80 insertions(+), 80 deletions(-)

diff --git a/contrib/vim/plugin/newbbappend.vim b/contrib/vim/plugin/newbbappend.vim
index e04174cf62..3f65f79cdc 100644
--- a/contrib/vim/plugin/newbbappend.vim
+++ b/contrib/vim/plugin/newbbappend.vim
@@ -20,7 +20,7 @@ fun! NewBBAppendTemplate()
     set nopaste
 
     " New bbappend template
-    0 put ='FILESEXTRAPATHS_prepend := \"${THISDIR}/${PN}:\"'
+    0 put ='FILESEXTRAPATHS:prepend := \"${THISDIR}/${PN}:\"'
     2
 
     if paste == 1
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 3e14163ebe..db44e26fbd 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -281,11 +281,11 @@ operators in that their effects are applied at variable expansion time
 rather than being immediately applied. Here are some examples::
 
    B = "bval"
-   B_append = " additional data"
+   B:append = " additional data"
    C = "cval"
-   C_prepend = "additional data "
+   C:prepend = "additional data "
    D = "dval"
-   D_append = "additional data"
+   D:append = "additional data"
 
 The variable :term:`B`
 becomes "bval additional data" and ``C`` becomes "additional data cval".
@@ -312,10 +312,10 @@ When you use this syntax, BitBake expects one or more strings.
 Surrounding spaces and spacing are preserved. Here is an example::
 
    FOO = "123 456 789 123456 123 456 123 456"
-   FOO_remove = "123"
-   FOO_remove = "456"
+   FOO:remove = "123"
+   FOO:remove = "456"
    FOO2 = " abc def ghi abcdef abc def abc def def"
-   FOO2_remove = "\
+   FOO2:remove = "\
        def \
        abc \
        ghi \
@@ -349,15 +349,15 @@ If, on the other hand, ``foo.bbclass``
 uses the "_append" operator, then the final value of ``FOO`` will be
 "initial val", as intended::
 
-   FOO_append = " val"
+   FOO:append = " val"
 
 .. note::
 
    It is never necessary to use "+=" together with "_append". The following
    sequence of assignments appends "barbaz" to FOO::
 
-       FOO_append = "bar"
-       FOO_append = "baz"
+       FOO:append = "bar"
+       FOO:append = "baz"
 
 
    The only effect of changing the second assignment in the previous
@@ -538,12 +538,12 @@ variable.
    that value based on the architecture of the build::
 
       KBRANCH = "standard/base"
-      KBRANCH_qemuarm = "standard/arm-versatile-926ejs"
-      KBRANCH_qemumips = "standard/mti-malta32"
-      KBRANCH_qemuppc = "standard/qemuppc"
-      KBRANCH_qemux86 = "standard/common-pc/base"
-      KBRANCH_qemux86-64 = "standard/common-pc-64/base"
-      KBRANCH_qemumips64 = "standard/mti-malta64"
+      KBRANCH:qemuarm = "standard/arm-versatile-926ejs"
+      KBRANCH:qemumips = "standard/mti-malta32"
+      KBRANCH:qemuppc = "standard/qemuppc"
+      KBRANCH:qemux86 = "standard/common-pc/base"
+      KBRANCH:qemux86-64 = "standard/common-pc-64/base"
+      KBRANCH:qemumips64 = "standard/mti-malta64"
 
 -  *Appending and Prepending:* BitBake also supports append and prepend
    operations to variable values based on whether a specific item is
@@ -551,7 +551,7 @@ variable.
 
       DEPENDS = "glibc ncurses"
       OVERRIDES = "machine:local"
-      DEPENDS_append_machine = "libmad"
+      DEPENDS:append_machine = "libmad"
 
    In this example, :term:`DEPENDS` becomes "glibc ncurses libmad".
 
@@ -559,15 +559,15 @@ variable.
    example, the following lines will conditionally append to the
    ``KERNEL_FEATURES`` variable based on the architecture::
 
-      KERNEL_FEATURES_append = " ${KERNEL_EXTRA_FEATURES}"
-      KERNEL_FEATURES_append_qemux86=" cfg/sound.scc cfg/paravirt_kvm.scc"
-      KERNEL_FEATURES_append_qemux86-64=" cfg/sound.scc cfg/paravirt_kvm.scc"
+      KERNEL_FEATURES:append = " ${KERNEL_EXTRA_FEATURES}"
+      KERNEL_FEATURES:append:qemux86=" cfg/sound.scc cfg/paravirt_kvm.scc"
+      KERNEL_FEATURES:append:qemux86-64=" cfg/sound.scc cfg/paravirt_kvm.scc"
 
 -  *Setting a Variable for a Single Task:* BitBake supports setting a
    variable just for the duration of a single task. Here is an example::
 
       FOO_task-configure = "val 1"
-      FOO_task-compile = "val 2"
+      FOO:task-compile = "val 2"
 
    In the
    previous example, ``FOO`` has the value "val 1" while the
@@ -582,7 +582,7 @@ variable.
    You can also use this syntax with other combinations (e.g.
    "``_prepend``") as shown in the following example::
 
-      EXTRA_OEMAKE_prepend_task-compile = "${PARALLEL_MAKE} "
+      EXTRA_OEMAKE:prepend:task-compile = "${PARALLEL_MAKE} "
 
 Key Expansion
 -------------
@@ -618,7 +618,7 @@ example::
 
    OVERRIDES = "foo"
    A = "Z"
-   A_foo_append = "X"
+   A_foo:append = "X"
 
 For this case,
 ``A`` is unconditionally set to "Z" and "X" is unconditionally and
@@ -635,7 +635,7 @@ This next example changes the order of the override and the append::
 
    OVERRIDES = "foo"
    A = "Z"
-   A_append_foo = "X"
+   A:append_foo = "X"
 
 For this case, before
 overrides are handled, ``A`` is set to "Z" and ``A_append_foo`` is set
@@ -648,8 +648,8 @@ back as in the first example::
 
    OVERRIDES = "foo"
    A = "Y"
-   A_foo_append = "Z"
-   A_foo_append = "X"
+   A_foo:append = "Z"
+   A_foo:append = "X"
 
 For this case, before any overrides are resolved,
 ``A`` is set to "Y" using an immediate assignment. After this immediate
@@ -661,8 +661,8 @@ leaving the variable set to "ZX". Finally, applying the override for
 This final example mixes in some varying operators::
 
    A = "1"
-   A_append = "2"
-   A_append = "3"
+   A:append = "2"
+   A:append = "3"
    A += "4"
    A .= "5"
 
@@ -919,7 +919,7 @@ As an example, consider the following::
        fn
    }
 
-   fn_prepend() {
+   fn:prepend() {
        bbplain second
    }
 
@@ -927,7 +927,7 @@ As an example, consider the following::
        bbplain third
    }
 
-   do_foo_append() {
+   do_foo:append() {
        bbplain fourth
    }
 
@@ -977,7 +977,7 @@ override-style operators to BitBake-style Python functions.
 
 As an example, consider the following::
 
-   python do_foo_prepend() {
+   python do_foo:prepend() {
        bb.plain("first")
    }
 
@@ -985,7 +985,7 @@ As an example, consider the following::
        bb.plain("second")
    }
 
-   python do_foo_append() {
+   python do_foo:append() {
        bb.plain("third")
    }
 
@@ -1139,7 +1139,7 @@ before anonymous functions run. In the following example, ``FOO`` ends
 up with the value "foo from anonymous"::
 
    FOO = "foo"
-   FOO_append = " from outside"
+   FOO:append = " from outside"
 
    python () {
        d.setVar("FOO", "foo from anonymous")
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 797e2a00cc..6283c2654c 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -1118,7 +1118,7 @@ overview of their function and contents.
       attempt before any others by adding something like the following to
       your configuration::
 
-         PREMIRRORS_prepend = "\
+         PREMIRRORS:prepend = "\
          git://.*/.* http://www.yoctoproject.org/sources/ \n \
          ftp://.*/.* http://www.yoctoproject.org/sources/ \n \
          http://.*/.* http://www.yoctoproject.org/sources/ \n \
@@ -1184,7 +1184,7 @@ overview of their function and contents.
       that depends on the ``perl`` package. In this case, you would use the
       following :term:`RDEPENDS` statement::
 
-         RDEPENDS_${PN}-dev += "perl"
+         RDEPENDS:${PN}-dev += "perl"
 
       In the example, the development package depends on the ``perl`` package.
       Thus, the :term:`RDEPENDS` variable has the ``${PN}-dev`` package name as part
@@ -1195,7 +1195,7 @@ overview of their function and contents.
       differences from you. Here is the general syntax to specify versions
       with the :term:`RDEPENDS` variable::
 
-         RDEPENDS_${PN} = "package (operator version)"
+         RDEPENDS:${PN} = "package (operator version)"
 
       For ``operator``, you can specify the following::
 
@@ -1208,7 +1208,7 @@ overview of their function and contents.
       For example, the following sets up a dependency on version 1.2 or
       greater of the package ``foo``::
 
-         RDEPENDS_${PN} = "foo (>= 1.2)"
+         RDEPENDS:${PN} = "foo (>= 1.2)"
 
       For information on build-time dependencies, see the :term:`DEPENDS`
       variable.
@@ -1237,7 +1237,7 @@ overview of their function and contents.
       variable in conjunction with a package name override. Here is an
       example::
 
-         RPROVIDES_${PN} = "widget-abi-2"
+         RPROVIDES:${PN} = "widget-abi-2"
 
    :term:`RRECOMMENDS`
       A list of packages that extends the usability of a package being
@@ -1251,7 +1251,7 @@ overview of their function and contents.
       differences from you. Here is the general syntax to specify versions
       with the :term:`RRECOMMENDS` variable::
 
-         RRECOMMENDS_${PN} = "package (operator version)"
+         RRECOMMENDS:${PN} = "package (operator version)"
 
       For ``operator``, you can specify the following::
 
@@ -1264,7 +1264,7 @@ overview of their function and contents.
       For example, the following sets up a recommend on version
       1.2 or greater of the package ``foo``::
 
-         RRECOMMENDS_${PN} = "foo (>= 1.2)"
+         RRECOMMENDS:${PN} = "foo (>= 1.2)"
 
    :term:`SECTION`
       The section in which packages should be categorized.
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 0d49e1da37..60aaf3902a 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1150,7 +1150,7 @@ def srcrev_internal_helper(ud, d, name):
     if name != '':
         attempts.append("SRCREV_%s" % name)
     if pn:
-        attempts.append("SRCREV_pn-%s" % pn)
+        attempts.append("SRCREV:pn-%s" % pn)
     attempts.append("SRCREV")
 
     for a in attempts:
diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index 1d4a64b109..add1b13600 100644
--- a/lib/bb/tests/data.py
+++ b/lib/bb/tests/data.py
@@ -245,35 +245,35 @@ class TestConcatOverride(unittest.TestCase):
 
     def test_prepend(self):
         self.d.setVar("TEST", "${VAL}")
-        self.d.setVar("TEST_prepend", "${FOO}:")
+        self.d.setVar("TEST:prepend", "${FOO}:")
         self.assertEqual(self.d.getVar("TEST"), "foo:val")
 
     def test_append(self):
         self.d.setVar("TEST", "${VAL}")
-        self.d.setVar("TEST_append", ":${BAR}")
+        self.d.setVar("TEST:append", ":${BAR}")
         self.assertEqual(self.d.getVar("TEST"), "val:bar")
 
     def test_multiple_append(self):
         self.d.setVar("TEST", "${VAL}")
-        self.d.setVar("TEST_prepend", "${FOO}:")
-        self.d.setVar("TEST_append", ":val2")
-        self.d.setVar("TEST_append", ":${BAR}")
+        self.d.setVar("TEST:prepend", "${FOO}:")
+        self.d.setVar("TEST:append", ":val2")
+        self.d.setVar("TEST:append", ":${BAR}")
         self.assertEqual(self.d.getVar("TEST"), "foo:val:val2:bar")
 
     def test_append_unset(self):
-        self.d.setVar("TEST_prepend", "${FOO}:")
-        self.d.setVar("TEST_append", ":val2")
-        self.d.setVar("TEST_append", ":${BAR}")
+        self.d.setVar("TEST:prepend", "${FOO}:")
+        self.d.setVar("TEST:append", ":val2")
+        self.d.setVar("TEST:append", ":${BAR}")
         self.assertEqual(self.d.getVar("TEST"), "foo::val2:bar")
 
     def test_remove(self):
         self.d.setVar("TEST", "${VAL} ${BAR}")
-        self.d.setVar("TEST_remove", "val")
+        self.d.setVar("TEST:remove", "val")
         self.assertEqual(self.d.getVar("TEST"), " bar")
 
     def test_remove_cleared(self):
         self.d.setVar("TEST", "${VAL} ${BAR}")
-        self.d.setVar("TEST_remove", "val")
+        self.d.setVar("TEST:remove", "val")
         self.d.setVar("TEST", "${VAL} ${BAR}")
         self.assertEqual(self.d.getVar("TEST"), "val bar")
 
@@ -281,42 +281,42 @@ class TestConcatOverride(unittest.TestCase):
     # (including that whitespace is preserved)
     def test_remove_inactive_override(self):
         self.d.setVar("TEST", "${VAL} ${BAR}    123")
-        self.d.setVar("TEST_remove_inactiveoverride", "val")
+        self.d.setVar("TEST:remove_inactiveoverride", "val")
         self.assertEqual(self.d.getVar("TEST"), "val bar    123")
 
     def test_doubleref_remove(self):
         self.d.setVar("TEST", "${VAL} ${BAR}")
-        self.d.setVar("TEST_remove", "val")
+        self.d.setVar("TEST:remove", "val")
         self.d.setVar("TEST_TEST", "${TEST} ${TEST}")
         self.assertEqual(self.d.getVar("TEST_TEST"), " bar  bar")
 
     def test_empty_remove(self):
         self.d.setVar("TEST", "")
-        self.d.setVar("TEST_remove", "val")
+        self.d.setVar("TEST:remove", "val")
         self.assertEqual(self.d.getVar("TEST"), "")
 
     def test_remove_expansion(self):
         self.d.setVar("BAR", "Z")
         self.d.setVar("TEST", "${BAR}/X Y")
-        self.d.setVar("TEST_remove", "${BAR}/X")
+        self.d.setVar("TEST:remove", "${BAR}/X")
         self.assertEqual(self.d.getVar("TEST"), " Y")
 
     def test_remove_expansion_items(self):
         self.d.setVar("TEST", "A B C D")
         self.d.setVar("BAR", "B D")
-        self.d.setVar("TEST_remove", "${BAR}")
+        self.d.setVar("TEST:remove", "${BAR}")
         self.assertEqual(self.d.getVar("TEST"), "A  C ")
 
     def test_remove_preserve_whitespace(self):
         # When the removal isn't active, the original value should be preserved
         self.d.setVar("TEST", " A B")
-        self.d.setVar("TEST_remove", "C")
+        self.d.setVar("TEST:remove", "C")
         self.assertEqual(self.d.getVar("TEST"), " A B")
 
     def test_remove_preserve_whitespace2(self):
         # When the removal is active preserve the whitespace
         self.d.setVar("TEST", " A B")
-        self.d.setVar("TEST_remove", "B")
+        self.d.setVar("TEST:remove", "B")
         self.assertEqual(self.d.getVar("TEST"), " A ")
 
 class TestOverrides(unittest.TestCase):
@@ -362,10 +362,10 @@ class TestOverrides(unittest.TestCase):
         self.assertEqual(self.d.getVar("TEST"), "testvalue3")
 
     def test_rename_override(self):
-        self.d.setVar("ALTERNATIVE_ncurses-tools_class-target", "a")
+        self.d.setVar("ALTERNATIVE:ncurses-tools:class-target", "a")
         self.d.setVar("OVERRIDES", "class-target")
-        self.d.renameVar("ALTERNATIVE_ncurses-tools", "ALTERNATIVE_lib32-ncurses-tools")
-        self.assertEqual(self.d.getVar("ALTERNATIVE_lib32-ncurses-tools"), "a")
+        self.d.renameVar("ALTERNATIVE:ncurses-tools", "ALTERNATIVE:lib32-ncurses-tools")
+        self.assertEqual(self.d.getVar("ALTERNATIVE:lib32-ncurses-tools"), "a")
 
     def test_underscore_override(self):
         self.d.setVar("TEST_bar", "testvalue2")
@@ -377,22 +377,22 @@ class TestOverrides(unittest.TestCase):
     def test_remove_with_override(self):
         self.d.setVar("TEST_bar", "testvalue2")
         self.d.setVar("TEST_some_val", "testvalue3 testvalue5")
-        self.d.setVar("TEST_some_val_remove", "testvalue3")
+        self.d.setVar("TEST_some_val:remove", "testvalue3")
         self.d.setVar("TEST_foo", "testvalue4")
         self.d.setVar("OVERRIDES", "foo:bar:some_val")
         self.assertEqual(self.d.getVar("TEST"), " testvalue5")
 
     def test_append_and_override_1(self):
-        self.d.setVar("TEST_append", "testvalue2")
+        self.d.setVar("TEST:append", "testvalue2")
         self.d.setVar("TEST_bar", "testvalue3")
         self.assertEqual(self.d.getVar("TEST"), "testvalue3testvalue2")
 
     def test_append_and_override_2(self):
-        self.d.setVar("TEST_append_bar", "testvalue2")
+        self.d.setVar("TEST:append_bar", "testvalue2")
         self.assertEqual(self.d.getVar("TEST"), "testvaluetestvalue2")
 
     def test_append_and_override_3(self):
-        self.d.setVar("TEST_bar_append", "testvalue2")
+        self.d.setVar("TEST_bar:append", "testvalue2")
         self.assertEqual(self.d.getVar("TEST"), "testvalue2")
 
     # Test an override with _<numeric> in it based on a real world OE issue
@@ -400,7 +400,7 @@ class TestOverrides(unittest.TestCase):
         self.d.setVar("TARGET_ARCH", "x86_64")
         self.d.setVar("PN", "test-${TARGET_ARCH}")
         self.d.setVar("VERSION", "1")
-        self.d.setVar("VERSION_pn-test-${TARGET_ARCH}", "2")
+        self.d.setVar("VERSION:pn-test-${TARGET_ARCH}", "2")
         self.d.setVar("OVERRIDES", "pn-${PN}")
         bb.data.expandKeys(self.d)
         self.assertEqual(self.d.getVar("VERSION"), "2")
@@ -498,7 +498,7 @@ class TaskHash(unittest.TestCase):
         d.setVar("VAR", "val")
         # Adding an inactive removal shouldn't change the hash
         d.setVar("BAR", "notbar")
-        d.setVar("MYCOMMAND_remove", "${BAR}")
+        d.setVar("MYCOMMAND:remove", "${BAR}")
         nexthash = gettask_bashhash("mytask", d)
         self.assertEqual(orighash, nexthash)
 
diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
index 9e21e18425..02a5c4952a 100644
--- a/lib/bb/tests/parse.py
+++ b/lib/bb/tests/parse.py
@@ -98,8 +98,8 @@ exportD = "d"
 
 
     overridetest = """
-RRECOMMENDS_${PN} = "a"
-RRECOMMENDS_${PN}_libc = "b"
+RRECOMMENDS:${PN} = "a"
+RRECOMMENDS:${PN}_libc = "b"
 OVERRIDES = "libc:${PN}"
 PN = "gtk+"
 """
@@ -110,13 +110,13 @@ PN = "gtk+"
         self.assertEqual(d.getVar("RRECOMMENDS"), "b")
         bb.data.expandKeys(d)
         self.assertEqual(d.getVar("RRECOMMENDS"), "b")
-        d.setVar("RRECOMMENDS_gtk+", "c")
+        d.setVar("RRECOMMENDS:gtk+", "c")
         self.assertEqual(d.getVar("RRECOMMENDS"), "c")
 
     overridetest2 = """
 EXTRA_OECONF = ""
-EXTRA_OECONF_class-target = "b"
-EXTRA_OECONF_append = " c"
+EXTRA_OECONF:class-target = "b"
+EXTRA_OECONF:append = " c"
 """
 
     def test_parse_overrides(self):
@@ -128,7 +128,7 @@ EXTRA_OECONF_append = " c"
 
     overridetest3 = """
 DESCRIPTION = "A"
-DESCRIPTION_${PN}-dev = "${DESCRIPTION} B"
+DESCRIPTION:${PN}-dev = "${DESCRIPTION} B"
 PN = "bc"
 """
 
@@ -136,9 +136,9 @@ PN = "bc"
         f = self.parsehelper(self.overridetest3)
         d = bb.parse.handle(f.name, self.d)['']
         bb.data.expandKeys(d)
-        self.assertEqual(d.getVar("DESCRIPTION_bc-dev"), "A B")
+        self.assertEqual(d.getVar("DESCRIPTION:bc-dev"), "A B")
         d.setVar("DESCRIPTION", "E")
-        d.setVar("DESCRIPTION_bc-dev", "C D")
+        d.setVar("DESCRIPTION:bc-dev", "C D")
         d.setVar("OVERRIDES", "bc-dev")
         self.assertEqual(d.getVar("DESCRIPTION"), "C D")
 
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 7f7e922ade..4c94b407d7 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -1719,7 +1719,7 @@ class CustomImageRecipe(Recipe):
         """Generate the contents for the recipe file."""
         # If we have no excluded packages we only need to _append
         if self.excludes_set.count() == 0:
-            packages_conf = "IMAGE_INSTALL_append = \" "
+            packages_conf = "IMAGE_INSTALL:append = \" "
 
             for pkg in self.appends_set.all():
                 packages_conf += pkg.name+' '
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 9a5e48e3bb..04ab8bcb04 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1708,7 +1708,7 @@ if True:
             except ProjectVariable.DoesNotExist:
                 pass
             try:
-                return_data['image_install_append'] = ProjectVariable.objects.get(project = prj, name = "IMAGE_INSTALL_append").value,
+                return_data['image_install:append'] = ProjectVariable.objects.get(project = prj, name = "IMAGE_INSTALL:append").value,
             except ProjectVariable.DoesNotExist:
                 pass
             try:
@@ -1839,8 +1839,8 @@ if True:
         except ProjectVariable.DoesNotExist:
             pass
         try:
-            context['image_install_append'] =  ProjectVariable.objects.get(project = prj, name = "IMAGE_INSTALL_append").value
-            context['image_install_append_defined'] = "1"
+            context['image_install:append'] =  ProjectVariable.objects.get(project = prj, name = "IMAGE_INSTALL:append").value
+            context['image_install:append_defined'] = "1"
         except ProjectVariable.DoesNotExist:
             pass
         try:
diff --git a/lib/toaster/toastermain/management/commands/buildimport.py b/lib/toaster/toastermain/management/commands/buildimport.py
index 59da6ff7ac..e25b55e5ab 100644
--- a/lib/toaster/toastermain/management/commands/buildimport.py
+++ b/lib/toaster/toastermain/management/commands/buildimport.py
@@ -451,7 +451,7 @@ class Command(BaseCommand):
             # Catch vars relevant to Toaster (in case no Toaster section)
             self.update_project_vars(project,'DISTRO')
             self.update_project_vars(project,'MACHINE')
-            self.update_project_vars(project,'IMAGE_INSTALL_append')
+            self.update_project_vars(project,'IMAGE_INSTALL:append')
             self.update_project_vars(project,'IMAGE_FSTYPES')
             self.update_project_vars(project,'PACKAGE_CLASSES')
             # These vars are typically only assigned by Toaster
-- 
2.30.2

