Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA6BC5AE49
	for <webhook@archiver.kernel.org>; Fri, 20 Feb 2026 19:59:30 +0000 (UTC)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6159.1771617562717702648
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Feb 2026 11:59:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=dXaiPOy+;
 spf=pass (domain: gmail.com, ip: 209.85.167.169, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-45efd53148eso826370b6e.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 20 Feb 2026 11:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771617562; x=1772222362; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZnKLZ1bxFJ0QGiaYUsVvArhbZ6LJfmZ/T6k2pNAVsk=;
        b=dXaiPOy+LJQw+AaICpiOtQOMHrqVHf13CIoeZX06kwqR+Dp1VyuU12v1Jl3ElPLXG1
         yFiAXsd81/PSg8TXUy7ptcrrGK3yO9KgLUE6cKo9KvyaNRad04OU6fI9FcW2ZGsdbhmA
         UqYTNcYlvrKmX+kCPbwVePpkcQ1yWjX+HAb3WKpsfg+CFGfKjiFNf1Gyqig0EUeLbcUE
         SKAVLhm1SuqtsTULAIfV1E0dATjf2/HFv6VUIVrnyG0cDIRfjj8bxWY587SnhARVt69p
         M5wbT+yfiC4hcTRtC3RE0vkSWU5d7f1IZ+FXwcJy5Mee12uPqHVZ39g+K+jhAUjEqG7B
         rZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771617562; x=1772222362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lZnKLZ1bxFJ0QGiaYUsVvArhbZ6LJfmZ/T6k2pNAVsk=;
        b=CK+Rmei6P4UGMXDzL8PH89IMukX8vNBfJxiMZ/jMqudHum8mEkQhdh+sVTkZMD55/m
         EGPTgPPl80JY6VH0tSsGFeZr7cUFmd6xehVORt8N9lFOnuVBFce0vdpVZs3awNobdJ4l
         WCUfjWOOwD921fLgEZlfMRUPEJ3xT881rpZGPRIaM9Jhf364zSdNrk5wfsE+aqsaPP9q
         b38jWHnhXMlPWSdrykRusuDKFYqViGkYW9n0/m4jIcJ6uBCFVY0smN2z53AY/h40yWkh
         SmV8evwTMsHzDez0pRX+46oHLLyqkOZxkOdMD/dFbxAjgHKf0gR4P93oviP6/1wwZP8Y
         /9Dg==
X-Gm-Message-State: AOJu0Yy6jBCRhSWWKTgc7rxqJsrvOAnq99hDtiIGAw16jLzhpLcVMa1M
	1KnpAQJ1ZVVwiUwBLFlN7+zPOLhGlTRUMUEUrQiGHFAhgGbhmZfxK6BwhdY3mw==
X-Gm-Gg: AZuq6aLroAAo4atXyCHKng1fv3g3pqvG+ftohVmycJLz7mpoRLA4jWaXMqB541nVsvq
	MIIPdJLmuxlF7E/HrBSdpwpiKJMxcaM80EXwbmEFl2kzhZ7OU4wZWXW+8shrSEs8yEs8eeRZx7I
	87zPXLrsEVSHOuMnoSuRDdu8wQEBzgskVQZAarVKB8J/X34LVbxH0WQcSuo83ypT2fljGztZU5V
	kqntvWf91JWtX51YXta5JOPkbQfJocfaUn2WUa5hwhkdc2EjFkZF0rj38E/3pDWoJda76koZ2TF
	WLzskZWci9fjwaMnMUA//Ch7Xnea/dQhvIWKUc698lCd+6GdvRHMxDWD14m57lqLJSTOGViCpFE
	/Zk5lQ9kzg8o4tham9q0A4f0V4Qa1WbwwNuLN2xeeDwLyh2doCjDeA3E6MyzQSqdbrm5pR0HIDR
	pRdI2RHFV6xQGT5dWFUjVNauw3OBlRCbY=
X-Received: by 2002:a05:6808:2f18:b0:450:4782:2b0e with SMTP id 5614622812f47-46446177726mr718635b6e.15.1771617561634;
        Fri, 20 Feb 2026 11:59:21 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4200:11c0::6492])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46449fd6ebbsm99085b6e.2.2026.02.20.11.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 11:59:21 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <jpewhacker@gmail.com>,
	Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v3] cookerdata: Include "originating" recipe name when parsing
Date: Fri, 20 Feb 2026 12:58:43 -0700
Message-ID: <20260220195915.466314-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20251219223620.2222861-1-JPEWhacker@gmail.com>
References: <20251219223620.2222861-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Feb 2026 19:59:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19077

From: Joshua Watt <jpewhacker@gmail.com>

When a bbappend file is parsed, the FILE variable is set to the name of
the actual file being parsed (e.g. the name of the bbappend). Since
PN/PV etc. are derived from FILE, this means that they can be
misleading in the event that bbappend is using wildcards (e.g. PV might
have the value of "%" instead of the actual version number).

In order to allow bbappends to derived the actual information of the
recipe, capture the name of the original recipe being parsed as
__BB_RECIPE_FILE when parsing a new recipe. The value of this variable
doesn't change when parsing .bbappend or .inc file associated with the
recipe

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
V3: Rename to __BB_RECIPE_FILE, add documentation and tests


 .../bitbake-user-manual-ref-variables.rst     |   4 +
 lib/bb/cookerdata.py                          |   2 +
 lib/bb/tests/parse-tests/classes/base.bbclass |   5 +
 .../classes/recipe-file-class.bbclass         |   2 +
 lib/bb/tests/parse-tests/conf/bitbake.conf    |  15 ++
 lib/bb/tests/parse.py                         | 132 +++++++++++++++++-
 6 files changed, 159 insertions(+), 1 deletion(-)
 create mode 100644 lib/bb/tests/parse-tests/classes/base.bbclass
 create mode 100644 lib/bb/tests/parse-tests/classes/recipe-file-class.bbclass
 create mode 100644 lib/bb/tests/parse-tests/conf/bitbake.conf

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 3a01144ff..5940e6670 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -720,6 +720,10 @@ overview of their function and contents.
          pressure on the system. Monitor the varying value after ``Mem:`` above
          to set a sensible value.
 
+   :term:`__BB_RECIPE_FILE`
+      Specifies the name of the recipe file that is being parsed. This is the
+      same even if when evalated in a bbappend, include or bbclass file.
+
    :term:`BB_RUNFMT`
       Specifies the name of the executable script files (i.e. run files)
       saved into ``${``\ :term:`T`\ ``}``. By default, the
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 22ac95eac..59f808c96 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -512,6 +512,8 @@ class CookerDataBuilder(object):
         bb_data.setVar("__BBMULTICONFIG", mc)
         bb_data.setVar("FILE_LAYERNAME", layername)
 
+        bb_data.setVar("__BB_RECIPE_FILE", bbfile)
+
         bbfile_loc = os.path.abspath(os.path.dirname(bbfile))
         bb.parse.cached_mtime_noerror(bbfile_loc)
 
diff --git a/lib/bb/tests/parse-tests/classes/base.bbclass b/lib/bb/tests/parse-tests/classes/base.bbclass
new file mode 100644
index 000000000..db8898e12
--- /dev/null
+++ b/lib/bb/tests/parse-tests/classes/base.bbclass
@@ -0,0 +1,5 @@
+# At least one task is required for bitbake to parse
+do_fetch() {
+    :
+}
+addtask do_fetch
diff --git a/lib/bb/tests/parse-tests/classes/recipe-file-class.bbclass b/lib/bb/tests/parse-tests/classes/recipe-file-class.bbclass
new file mode 100644
index 000000000..4682dc6c3
--- /dev/null
+++ b/lib/bb/tests/parse-tests/classes/recipe-file-class.bbclass
@@ -0,0 +1,2 @@
+BBCLASS_RECIPE_FILE := "${@os.path.basename(d.getVar('__BB_RECIPE_FILE'))}"
+BBCLASS_FILE := "${@os.path.basename(d.getVar('FILE'))}"
diff --git a/lib/bb/tests/parse-tests/conf/bitbake.conf b/lib/bb/tests/parse-tests/conf/bitbake.conf
new file mode 100644
index 000000000..e03625061
--- /dev/null
+++ b/lib/bb/tests/parse-tests/conf/bitbake.conf
@@ -0,0 +1,15 @@
+CACHE = "${TOPDIR}/cache"
+THISDIR = "${@os.path.dirname(d.getVar('FILE'))}"
+COREBASE := "${@os.path.normpath(os.path.dirname(d.getVar('FILE')+'/../../'))}"
+EXTRA_BBFILES ?= ""
+BBFILES = "${COREBASE}/recipes/*.bb ${COREBASE}/recipes/*.bbappend ${EXTRA_BBFILES}"
+PROVIDES = "${PN}"
+PN = "${@bb.parse.vars_from_file(d.getVar('FILE', False),d)[0]}"
+PF = "${BB_CURRENT_MC}:${PN}"
+export PATH
+TMPDIR ??= "${TOPDIR}"
+STAMP = "${TMPDIR}/stamps/${PN}"
+T = "${TMPDIR}/workdir/${PN}/temp"
+BB_NUMBER_THREADS = "4"
+
+BB_BASEHASH_IGNORE_VARS = "BB_CURRENT_MC BB_HASHSERVE TMPDIR TOPDIR SLOWTASKS SSTATEVALID FILE BB_CURRENTTASK"
diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
index d3867ece9..6ac2137e0 100644
--- a/lib/bb/tests/parse.py
+++ b/lib/bb/tests/parse.py
@@ -11,6 +11,8 @@ import tempfile
 import logging
 import bb
 import os
+import subprocess
+import textwrap
 
 logger = logging.getLogger('BitBake.TestParse')
 
@@ -210,7 +212,7 @@ python () {
     #
     # Test based upon a real world data corruption issue. One
     # data store changing a variable poked through into a different data
-    # store. This test case replicates that issue where the value 'B' would 
+    # store. This test case replicates that issue where the value 'B' would
     # become unset/disappear.
     #
     def test_parse_classextend_contamination(self):
@@ -508,3 +510,131 @@ EXTRA_OECONF:append = " foobar"
             test_helper("require some3.conf", " foobar")
             test_helper("include_all some.conf", " bar foo")
             test_helper("include_all some3.conf", " foobar")
+
+    def test_file_variables(self):
+        # Tests the values of FILE and __BB_RECIPE_FILE in different
+        # combinations of bbappends, includes, and inherits
+
+        def write_file(path, data):
+            with open(path, "w") as f:
+                f.write(textwrap.dedent(data))
+
+        def run_bitbake(cmd, builddir, extraenv={}):
+            env = os.environ.copy()
+            env["BBPATH"] = os.path.realpath(os.path.join(os.path.dirname(__file__), "parse-tests"))
+            env["BB_ENV_PASSTHROUGH_ADDITIONS"] = "TOPDIR"
+            env["TOPDIR"] = builddir
+            for k, v in extraenv.items():
+                env[k] = v
+                env["BB_ENV_PASSTHROUGH_ADDITIONS"] = env["BB_ENV_PASSTHROUGH_ADDITIONS"] + " " + k
+            try:
+                return subprocess.check_output(cmd, env=env, stderr=subprocess.STDOUT, universal_newlines=True, cwd=builddir)
+            except subprocess.CalledProcessError as e:
+                self.fail("Command %s failed with %s" % (cmd, e.output))
+
+        with tempfile.TemporaryDirectory(prefix="parserecipes") as recipes, tempfile.TemporaryDirectory(prefix="parsetest") as builddir:
+            extraenv = {
+                "EXTRA_BBFILES": f"{recipes}/*.bb {recipes}/*.bbappend",
+            }
+
+            inc_path = f"{recipes}/recipe-file.inc"
+            bbappend_path = f"{recipes}/recipe-%.bbappend"
+            recipe_path = f"{recipes}/recipe-file1.bb"
+
+            # __BB_RECIPE_FILE should always be the name of .bb file, even
+            # when set in a bbappend. FILE is the name of the bbappend
+            write_file(recipe_path, "")
+            write_file(bbappend_path,
+                """\
+                BBAPPEND_RECIPE_FILE := "${@os.path.basename(d.getVar('__BB_RECIPE_FILE'))}"
+                BBAPPEND_FILE := "${@os.path.basename(d.getVar('FILE'))}"
+                """
+            )
+            output = run_bitbake(["bitbake", "-e", "recipe-file1"], builddir, extraenv).splitlines()
+            self.assertIn('BBAPPEND_FILE="recipe-%.bbappend"', output)
+            self.assertIn(f'BBAPPEND_RECIPE_FILE="recipe-file1.bb"', output)
+
+            # __BB_RECIPE_FILE should always be the name of .bb file, even when
+            # set in an include file. FILE is the name of the include
+            write_file(recipe_path,
+                """\
+                require recipe-file.inc
+                """
+            )
+            write_file(inc_path,
+                """\
+                INC_RECIPE_FILE := "${@os.path.basename(d.getVar('__BB_RECIPE_FILE'))}"
+                INC_FILE := "${@os.path.basename(d.getVar('FILE'))}"
+                """
+            )
+            output = run_bitbake(["bitbake", "-e", "recipe-file1"], builddir, extraenv).splitlines()
+            self.assertIn('INC_FILE="recipe-file.inc"', output)
+            self.assertIn(f'INC_RECIPE_FILE="recipe-file1.bb"', output)
+
+            # Test when the include file is included from a bbappend
+            write_file(recipe_path, "")
+            write_file(bbappend_path,
+                """\
+                require recipe-file.inc
+                """
+            )
+            output = run_bitbake(["bitbake", "-e", "recipe-file1"], builddir, extraenv).splitlines()
+            self.assertIn('INC_FILE="recipe-file.inc"', output)
+            self.assertIn(f'INC_RECIPE_FILE="recipe-file1.bb"', output)
+
+            # Test the variables in a bbclass when inherited directly in the
+            # recipe. Note that FILE still refers to the recipe in a bbclass
+            write_file(recipe_path,
+                """\
+                inherit recipe-file-class
+                """
+            )
+            output = run_bitbake(["bitbake", "-e", "recipe-file1"], builddir, extraenv).splitlines()
+            self.assertIn('BBCLASS_FILE="recipe-file1.bb"', output)
+            self.assertIn(f'BBCLASS_RECIPE_FILE="recipe-file1.bb"', output)
+
+            # Test the variables when the inherit is in a bbappend. In this
+            # case, FILE is the bbappend
+            write_file(recipe_path, "")
+            write_file(bbappend_path,
+                """\
+                inherit recipe-file-class
+                """
+            )
+            output = run_bitbake(["bitbake", "-e", "recipe-file1"], builddir, extraenv).splitlines()
+            self.assertIn('BBCLASS_FILE="recipe-%.bbappend"', output)
+            self.assertIn(f'BBCLASS_RECIPE_FILE="recipe-file1.bb"', output)
+
+            # Test the variables when the inherit is in a include. In this
+            # case, FILE is the include file
+            write_file(recipe_path,
+                """\
+                require recipe-file.inc
+                """
+            )
+            write_file(bbappend_path, "")
+            write_file(inc_path,
+                """\
+                inherit recipe-file-class
+                """
+            )
+            output = run_bitbake(["bitbake", "-e", "recipe-file1"], builddir, extraenv).splitlines()
+            self.assertIn('BBCLASS_FILE="recipe-file.inc"', output)
+            self.assertIn(f'BBCLASS_RECIPE_FILE="recipe-file1.bb"', output)
+
+            # Test the variables when the inherit is in a include included from
+            # a bbappend. In this case, FILE is the include file
+            write_file(recipe_path, "")
+            write_file(bbappend_path,
+                """\
+                require recipe-file.inc
+                """
+            )
+            write_file(inc_path,
+                """\
+                inherit recipe-file-class
+                """
+            )
+            output = run_bitbake(["bitbake", "-e", "recipe-file1"], builddir, extraenv).splitlines()
+            self.assertIn('BBCLASS_FILE="recipe-file.inc"', output)
+            self.assertIn(f'BBCLASS_RECIPE_FILE="recipe-file1.bb"', output)
-- 
2.53.0


