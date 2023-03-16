Return-Path: <jamestiotio@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502B1C7618A
	for <webhook@archiver.kernel.org>; Thu, 16 Mar 2023 05:36:35 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web10.5904.1678944986620926840
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Mar 2023 22:36:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=WFOR5t3o;
 spf=pass (domain: gmail.com, ip: 209.85.216.46, mailfrom: jamestiotio@gmail.com)
Received: by mail-pj1-f46.google.com with SMTP id j3-20020a17090adc8300b0023d09aea4a6so4187588pjv.5
        for <bitbake-devel@lists.openembedded.org>; Wed, 15 Mar 2023 22:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678944985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IukSZo5LddHRgnKnMLIJWKmad/ijYgNrEQsIn2/BOiY=;
        b=WFOR5t3oQ5F1t2HWHln2BTyXocQZIQIln3RQN1EdEaS8etXVu8jveja3cyolSpXRh3
         eBg0zZ+9T5zSL7R8EflvuHNcStTwiTYwKdrS71uQcdyMO11pFOR6IWPMqhkJBdBkZ57Q
         hshyUWqYeEIiMWmsZNN36RTTv4Lpmrd2+1aa5k5VxUbAp0i07R12N0WPgGdR2ORATe1d
         5TJj/j8tS/r8tmERtylGseR/DDQjLp798IFp8su2T6z+O1d1L+T9RUHpi9y+2ymGhIOR
         6EtF2AqwboS29dqzTAjgKiGfAP6RPvH60Ao+DzEt9l4nTQltLqrO6cI0pioKIRh33hKN
         e61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678944985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IukSZo5LddHRgnKnMLIJWKmad/ijYgNrEQsIn2/BOiY=;
        b=1VVi1D7NcuvORww1G5uPOLwfom2KYQwxuerc2H3uZpoCHDhAD8AanX/ZnsbjjsdTPu
         gmooAK/RlSvSO87OAj2SMdBSDsK7RYY8BrjPqaVFFkENHPp2qQsXVqcTFtC4zwuKZ8Mp
         H4jMbWMHEwetq1mxFxghRMMnIqzM8iiK9FKj+ziCApLX+kUooI8wqWm+th//wVAQvIpC
         W/OsPM24ZX+p4NY9z+mXfMKLvzWE2zZAnk8TLSQONzIUGmsV4Gf/wEBZHJKdmW3exGCm
         B1zOih2zJoQfW8mue/KToGPgmLHTBeMcdys5dDLkiEr+AxkoLkJNDFGZGCfq2GKC3MuC
         xjNw==
X-Gm-Message-State: AO0yUKUsuiPxaviVswHh0NkpyCFmMdrS6KbrNqgCz7uql6RM+unesugs
	MmNf9JbAcyN/A405M8VTm90S1+0+LoVJuA==
X-Google-Smtp-Source: AK7set+2Flb8V9mMfAwg0SH+7tMCcw4W8j4QY/FjCRlLL+h7DwFcdlNa8cbFixT1AXh0G+Cbl/2Q2Q==
X-Received: by 2002:a05:6a20:c102:b0:cc:f214:2f33 with SMTP id bh2-20020a056a20c10200b000ccf2142f33mr1990719pzb.24.1678944985326;
        Wed, 15 Mar 2023 22:36:25 -0700 (PDT)
Received: from JRT-PC.lan ([103.252.200.22])
        by smtp.gmail.com with ESMTPSA id t14-20020a62ea0e000000b006222a261188sm2251817pfh.62.2023.03.15.22.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 22:36:24 -0700 (PDT)
From: James Raphael Tiovalen <jamestiotio@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: James Raphael Tiovalen <jamestiotio@gmail.com>
Subject: [PATCH v2] ConfHandler: Allow the '@' character in variable flag names
Date: Thu, 16 Mar 2023 13:35:57 +0800
Message-Id: <20230316053557.183694-1-jamestiotio@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Mar 2023 05:36:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14576

This patch enables the usage of the '@' character in variable flag
names.

One use case of variable flags is to indicate and set the namespace of
some systemd services/targets. The filenames of systemd services/targets
might contain the '@' character if they are template unit files that can
take in a single parameter/argument and be instanced multiple times, as
indicated by systemd's official manual page.

This patch is successfully verified by creating a custom BitBake recipe
that sets and unsets the value of a variable flag with the '@' character
in its name and ensuring that no ParseError is being thrown. A
regression test has also been added to `bb.parse`.

`bin/bitbake-selftest` has also been successfully executed and all tests
passed.

Signed-off-by: James Raphael Tiovalen <jamestiotio@gmail.com>
---
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


