Return-Path: <jamestiotio@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F546C6FD19
	for <webhook@archiver.kernel.org>; Thu, 16 Mar 2023 16:57:27 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web11.161.1678985845923347052
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Mar 2023 09:57:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=NBPg8hpi;
 spf=pass (domain: gmail.com, ip: 209.85.214.170, mailfrom: jamestiotio@gmail.com)
Received: by mail-pl1-f170.google.com with SMTP id le6so2407322plb.12
        for <bitbake-devel@lists.openembedded.org>; Thu, 16 Mar 2023 09:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678985845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vMhDOqY5p0ZG9zQalQRF82Rb4B12Cfkh0EzRcLOJV0Y=;
        b=NBPg8hpiv4yUj4o+H9yuVhS6jTgQU7lqV8Y2l5llg1g++qq6r0bxiCHFw+SAdnf8mT
         BbN2Mnk/1PYgyVFRI9fapUyRCmZncOe6inE0ZKIWYdJWq5dCXFtzwiMDRmiv2S08NTAB
         cQy5ydWd6hvz6dCxBjuqLICIFs0b2FqrvbYeUWitR6fXY4NC5LgZPdmDgXvC7n4sUcgy
         o0aieuAZkW/AXe7rNSllDaWOrz3Sjlund0EzV7UB8zoVempDitPA+cePMFxPusD6H1NP
         Muz9FdtF3KIAoxMnREz31LL875QbFHjEVqdGNVCXll84r8G+kpDsjBfNU3O3FuhjI+hq
         ZL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678985845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vMhDOqY5p0ZG9zQalQRF82Rb4B12Cfkh0EzRcLOJV0Y=;
        b=7LfU1mpqyOCk8GyV6fL0LCF6VrkJmetAbgquJfC9eoL/3tQmTI4CPVSkVp62n1JtFh
         t1OYRdWHKhcXmGbLU0a3hZ6qddUK+Bqw5uSQiXscyaztU65ELgYKZ3pZ72qNrqfyhGjn
         6U+Uif0NDqO2sJKM1DWCNoPcqFleZjsgmkjyY5AZhHkKpoArJFHXPMAGon6yKmehW7Ye
         PRh6EK8QOAiL465O3w3ukWLEzN7gmI7aFmeE6Q87WFRv0kxz6jMpea0VlAsFdM/8eBJF
         8PcFcGaE9QI6EGuZy7r7uLguLOeSvdIHv9uCCNDgAUXwHb3/HUwZJNuIUYB7hZv+ASen
         uTmQ==
X-Gm-Message-State: AO0yUKWdHXOcn5TULff6+r24XPlJ+OC8FJihhGgNgM2TqlRUh8k+Kfqg
	halbkKLkl9y3ckip/vFSXfXN4j5Kjo2JHQ==
X-Google-Smtp-Source: AK7set9/4NYo1ec/rbyOLdFt8Q/He0NjPgaz0XDTUcNJ5vTKCogpDF8D7NKyX1YP3b7xvXCkb9ujcw==
X-Received: by 2002:a17:90b:1d06:b0:230:af67:b847 with SMTP id on6-20020a17090b1d0600b00230af67b847mr4817616pjb.31.1678985844716;
        Thu, 16 Mar 2023 09:57:24 -0700 (PDT)
Received: from JRT-PC.lan ([103.252.200.22])
        by smtp.gmail.com with ESMTPSA id a19-20020a17090aa51300b00233db0db3dfsm3524504pjq.7.2023.03.16.09.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 09:57:24 -0700 (PDT)
From: James Raphael Tiovalen <jamestiotio@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: James Raphael Tiovalen <jamestiotio@gmail.com>
Subject: [PATCH v3] ConfHandler: Allow the '@' character in variable flag names
Date: Fri, 17 Mar 2023 00:57:05 +0800
Message-Id: <20230316165705.58445-1-jamestiotio@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Mar 2023 16:57:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14592

This patch enables the usage of the '@' character in variable flag
names.

One use case of variable flags is to assign the network namespaces of
some systemd services/targets to configure other parts of the build
process of some system. The filenames of systemd services/targets might
contain the '@' character if they are template unit files that can take
in a single parameter/argument and be instanced multiple times, as
indicated by systemd's official manual page.

This patch is successfully verified by creating a custom BitBake recipe
that sets and unsets the value of a variable flag with the '@' character
in its name and ensuring that no ParseError is being thrown. A
regression test has also been added to `bb.parse`.

`bin/bitbake-selftest` has also been successfully executed and all tests
passed.

Signed-off-by: James Raphael Tiovalen <jamestiotio@gmail.com>
---
v3:
Improve commit message to better convey the intent of this patch.

v2:
Add regression test.
---
 lib/bb/parse/parse_py/ConfHandler.py |  4 ++--
 lib/bb/tests/parse.py                | 15 +++++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
index 30760672..f2b8a2c9 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -21,7 +21,7 @@ __config_regexp__  = re.compile( r"""
     ^
     (?P<exp>export\s+)?
     (?P<var>[a-zA-Z0-9\-_+.${}/~:]+?)
-    (\[(?P<flag>[a-zA-Z0-9\-_+.]+)\])?
+    (\[(?P<flag>[a-zA-Z0-9\-_+.@]+)\])?
 
     \s* (
         (?P<colon>:=) |
@@ -45,7 +45,7 @@ __include_regexp__ = re.compile( r"include\s+(.+)" )
 __require_regexp__ = re.compile( r"require\s+(.+)" )
 __export_regexp__ = re.compile( r"export\s+([a-zA-Z0-9\-_+.${}/~]+)$" )
 __unset_regexp__ = re.compile( r"unset\s+([a-zA-Z0-9\-_+.${}/~]+)$" )
-__unset_flag_regexp__ = re.compile( r"unset\s+([a-zA-Z0-9\-_+.${}/~]+)\[([a-zA-Z0-9\-_+.]+)\]$" )
+__unset_flag_regexp__ = re.compile( r"unset\s+([a-zA-Z0-9\-_+.${}/~]+)\[([a-zA-Z0-9\-_+.@]+)\]$" )
 __addpylib_regexp__      = re.compile(r"addpylib\s+(.+)\s+(.+)" )
 
 def init(data):
diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
index ee7f2534..dba77292 100644
--- a/lib/bb/tests/parse.py
+++ b/lib/bb/tests/parse.py
@@ -218,3 +218,18 @@ VAR = " \\
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
-- 
2.39.2


