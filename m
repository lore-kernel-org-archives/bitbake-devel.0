Return-Path: <jamestiotio@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD08AC6FD1D
	for <webhook@archiver.kernel.org>; Fri, 17 Mar 2023 06:37:46 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web11.13407.1679035061491870949
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Mar 2023 23:37:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=n6G93rov;
 spf=pass (domain: gmail.com, ip: 209.85.216.42, mailfrom: jamestiotio@gmail.com)
Received: by mail-pj1-f42.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso4153040pjb.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 16 Mar 2023 23:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679035060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0KOcq6U69x0Llxga7Z+wPdhy0gpQZjxSx0gpaj/w7A=;
        b=n6G93rovqQgavCPKZ1xh3PjFLQRi98Tkhas64IJ+v++kNhe1L5PqVN5r/19jlz9XY6
         fMEGMnyXH5HO+jbeycp/JaMNVCtU/Saut5UzQ1+qZM6MHW4eg9g0CDlIHt6SdcqVDy7/
         zwkGZmMAg/YaZA+hISc8x7W8a2H/RsrJ8b0z9LV7LxlG62H+FR/lC16+NHM4VWl5tdXc
         Bfw0steXRTzXZJgGp2hQll7Wo2JGIfdXGSvDBSSaIlAJJUaX2hdgQy7V8O0uV1jRUPnL
         BS+6yJgC8YjndON/6W79D6egY5Se1FnK2pWR+g9Xr3kA+Oi9Synj54ImEsGCKk22OMXo
         3pQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679035060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y0KOcq6U69x0Llxga7Z+wPdhy0gpQZjxSx0gpaj/w7A=;
        b=2lxtSGwCuPX/o5QQ62Yf7jVDYnhrFAQ7K+0WDFKdrDmhVfMi36gzWbtZIf17pnJLNW
         rvmUxYCUXfvC7TvOnMb+8AaeF0vPzKYXMdYb3AJgJBrkPWHiffsGpdr3myf9MPRMPThl
         QN0WphvZiUd1LFniH5njPMEGO3e/8qRpqdavYxEe5UDdd2aM2UGydzGcdBrWdwSfbkLb
         659HJHZ1mzMxEi/uxXLGwnGTKzh3Gm/O++2ZJvtN+66+2AlEtm1ZjK+wXChQ1ERO8ure
         Rlh9B7Cl50Np7NykCR7zO0Q+19lS8MW2A7VT7XwlOctoeoliE1lsv4XJlN/XkCn5QjOF
         aAtA==
X-Gm-Message-State: AO0yUKXOGKY0k3/2fuii2dKRFYmYOrIxFMahik6dtcQ85WzcAozioL96
	voDbTLwSOILdlhgoyP1urOtR/q5DVkHTaRheQx8=
X-Google-Smtp-Source: AK7set9gOrK5T43lpDH/qwzu7cQs45cbbg1FDW4BjlN1bFSlURyZTidD7aYrsHV6zvxsHAJajtoV0w==
X-Received: by 2002:a17:902:face:b0:19a:b427:230a with SMTP id ld14-20020a170902face00b0019ab427230amr5173398plb.63.1679035060351;
        Thu, 16 Mar 2023 23:37:40 -0700 (PDT)
Received: from JRT-PC.lan ([103.252.200.22])
        by smtp.gmail.com with ESMTPSA id a13-20020a170902ee8d00b0019f11a68c42sm728109pld.297.2023.03.16.23.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 23:37:39 -0700 (PDT)
From: James Raphael Tiovalen <jamestiotio@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: James Raphael Tiovalen <jamestiotio@gmail.com>
Subject: [PATCH v4] ConfHandler: Allow the '@' character in variable flag names
Date: Fri, 17 Mar 2023 14:37:25 +0800
Message-Id: <20230317063725.122410-1-jamestiotio@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Mar 2023 06:37:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14599

This patch enables the usage of the '@' character in variable flag
names.

One use case of variable flags is to assign the network namespaces of
some systemd services/targets to configure other parts of the build
process of some system. The filenames of systemd services/targets might
contain the '@' character if they are template unit files that can take
in a single parameter/argument and be instanced multiple times, as
indicated by systemd's official manual page.

The '@' character is disallowed as the first character in a variable
flag name. Imposing more restrictions on the first character is a
compromise to make parsing easier and to allow for more options in the
future to extend the syntax.

This patch is successfully verified by creating a custom BitBake recipe
that sets and unsets the value of a variable flag with the '@' character
in its name and ensuring that no ParseError is being thrown. Regression
tests have also been added to `bb.parse`.

`bin/bitbake-selftest` has also been successfully executed and all tests
passed.

Signed-off-by: James Raphael Tiovalen <jamestiotio@gmail.com>
---
v4:
Disallow the '@' character as the first character in a variable flag
name.

v3:
Improve commit message to better convey the intent of this patch.

v2:
Add regression test.
---
 lib/bb/parse/parse_py/ConfHandler.py |  4 ++--
 lib/bb/tests/parse.py                | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
index 30760672..05c627ec 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -21,7 +21,7 @@ __config_regexp__  = re.compile( r"""
     ^
     (?P<exp>export\s+)?
     (?P<var>[a-zA-Z0-9\-_+.${}/~:]+?)
-    (\[(?P<flag>[a-zA-Z0-9\-_+.]+)\])?
+    (\[(?P<flag>[a-zA-Z0-9\-_+.][a-zA-Z0-9\-_+.@]+)\])?
 
     \s* (
         (?P<colon>:=) |
@@ -45,7 +45,7 @@ __include_regexp__ = re.compile( r"include\s+(.+)" )
 __require_regexp__ = re.compile( r"require\s+(.+)" )
 __export_regexp__ = re.compile( r"export\s+([a-zA-Z0-9\-_+.${}/~]+)$" )
 __unset_regexp__ = re.compile( r"unset\s+([a-zA-Z0-9\-_+.${}/~]+)$" )
-__unset_flag_regexp__ = re.compile( r"unset\s+([a-zA-Z0-9\-_+.${}/~]+)\[([a-zA-Z0-9\-_+.]+)\]$" )
+__unset_flag_regexp__ = re.compile( r"unset\s+([a-zA-Z0-9\-_+.${}/~]+)\[([a-zA-Z0-9\-_+.][a-zA-Z0-9\-_+.@]+)\]$" )
 __addpylib_regexp__      = re.compile(r"addpylib\s+(.+)\s+(.+)" )
 
 def init(data):
diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
index ee7f2534..d27c7c6f 100644
--- a/lib/bb/tests/parse.py
+++ b/lib/bb/tests/parse.py
@@ -218,3 +218,24 @@ VAR = " \\
         with self.assertRaises(bb.BBHandledException):
             d = bb.parse.handle(f.name, self.d)['']
 
+
+    at_sign_in_var_flag = """
+A[flag@.service] = "nonet"
+B[flag@.target] = "ntb"
+
+unset A[flag@.service]
+"""
+    def test_parse_at_sign_in_var_flag(self):
+        f = self.parsehelper(self.at_sign_in_var_flag)
+        d = bb.parse.handle(f.name, self.d)['']
+        self.assertEqual(d.getVar("A"), None)
+        self.assertEqual(d.getVar("B"), None)
+        self.assertEqual(d.getVarFlag("A","flag@.service"), None)
+        self.assertEqual(d.getVarFlag("B","flag@.target"), "ntb")
+
+    def test_parse_invalid_at_sign_in_var_flag(self):
+        invalid_at_sign = self.at_sign_in_var_flag.replace("B[f", "B[@f")
+        f = self.parsehelper(invalid_at_sign)
+        with self.assertRaises(bb.parse.ParseError):
+            d = bb.parse.handle(f.name, self.d)['']
+
-- 
2.40.0


