Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27088C61CE8
	for <webhook@archiver.kernel.org>; Mon,  9 Jun 2025 09:56:35 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web10.56056.1749462986657984931
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Jun 2025 02:56:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=LKNMwniK;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-442f4a3a4d6so22252555e9.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 09 Jun 2025 02:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1749462985; x=1750067785; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4nWaGF3ClwltPPtHrC81v+QGhShEWGyDfxk+Cr83H7M=;
        b=LKNMwniKgEEHKUJJrb8eoREjkfA6GD5VW5TzTeJPbbFQYVvTBtXCbuNn4dFDsqp4VY
         v9IXDRaQeg5VfvfEv3GkEjYgWR96jF1MTJBayX/yox6A7m2Eg5hi3f/1IOoeNphr5ZIP
         jlU+mA8JPe8rWrGws3Vv72jFEJNjJSAicnJN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749462985; x=1750067785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4nWaGF3ClwltPPtHrC81v+QGhShEWGyDfxk+Cr83H7M=;
        b=MB7X4nP06FqqVrEguyNjmTK1c+dMBZaD+rJbkeVU+5Lkn4AG34clJNacdilubroyjq
         N4tkX5Gh56YD4iqzgTk0W+OReLn1/x4Rz16/YdAaWtF0irbPXyl3+t1oQmldyfNn4bQ4
         oqEbPSVbuXNqW3tu85zMisCSDIS/MRRFnxoJZ9omP51Zx2aI9/kL2CpzDGShAYvSrMGc
         55RzAUZgnJ2G5mhTrDyG2wSFQc+Mslkr2HxwiFcplr6JCQ8BkRXL2HSxlA1DlBPjRQ36
         T7ukWepkDkdOKmHDmgaglS0lFSOBO1ltYq3NXjSEfVSPsy/Zs8QtYN60KK7qQV/CiWGw
         STaQ==
X-Gm-Message-State: AOJu0Yxq+lvwyK0J7sbYTB2XAIQwpUJoMP1Rm2zgWmgTuARZTazMnN7X
	DEns7bJomAVKyJnJmW6B7hES8fycslw0+FkzIEWOe2DEAKEWWsriqTgrW0dlAeF1VYewU/E/ynM
	MbqHKt5E=
X-Gm-Gg: ASbGncuaDiQ0ZPdrjGum1UOtfCDUJGZTCuxmhB0ZCU3zu1/AsCZPkrpN2mvWpcmWGao
	LEGEZu00x2OB/iIRhIElgP1bSpNHoBvaDZT6+BZCe40OdIVkOx6urYQhdwXHx2BiyzhsORg9eFm
	We0fDD1viH9orRxx8lkxpWlmknhKL1vNKOZ32eNcotkyf0UxiyhXBlVBRs7hlgJz5on5UcA4kKk
	mOu93XEQONvBoWbqd2Q7p4jEeYnfHGO1vNp1nlhop98gNAjWeIJ4TU3OE/eGksTCtH1V2nzVfV/
	biHU2+ydN3fqCNRTnnQhsXNwnKxAUsDJVkobKjMerWX/wsqY+D6a2lpJWvpyeNK/VHkPDnY6Wve
	srPZKV2Htxss7fJs=
X-Google-Smtp-Source: AGHT+IE8oTuTinGbQnjeQ/NbjJtB1xYxsAESruS+h44b+jaMyxENwxj69viDE6pPIrqQ2kqwOritXw==
X-Received: by 2002:a05:600c:1f90:b0:43c:f3e1:a729 with SMTP id 5b1f17b1804b1-451f88ad8c5mr146269535e9.12.1749462984673;
        Mon, 09 Jun 2025 02:56:24 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:fa9f:168d:c475:ba8f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a532435fbfsm9229759f8f.64.2025.06.09.02.56.23
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 02:56:23 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/3] ast/BBHandler: Add support for BB_DEFER_BBCLASSES
Date: Mon,  9 Jun 2025 10:56:21 +0100
Message-ID: <20250609095621.937299-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250609095621.937299-1-richard.purdie@linuxfoundation.org>
References: <20250609095621.937299-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Jun 2025 09:56:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17691

Add support for automatically promoting class inherits to deferred inherits
by listing them in the BB_DEFER_BBCLASSES variable.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/parse/ast.py                |  8 ++------
 lib/bb/parse/parse_py/BBHandler.py | 10 ++++++++++
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 5a086b4e95..ea1096f2de 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -340,9 +340,7 @@ class InheritDeferredNode(AstNode):
         self.inherit = (classes, filename, lineno)
 
     def eval(self, data):
-        inherits = data.getVar('__BBDEFINHERITS', False) or []
-        inherits.append(self.inherit)
-        data.setVar('__BBDEFINHERITS', inherits)
+        bb.parse.BBHandler.inherit_defer(*self.inherit, data)
 
 class AddFragmentsNode(AstNode):
     def __init__(self, filename, lineno, fragments_path_prefix, fragments_variable, flagged_variables_list_variable):
@@ -571,9 +569,7 @@ def multi_finalize(fn, d):
                 d.setVar("BBEXTENDVARIANT", variantmap[name])
             else:
                 d.setVar("PN", "%s-%s" % (pn, name))
-            inherits = d.getVar('__BBDEFINHERITS', False) or []
-            inherits.append((extendedmap[name], fn, 0))
-            d.setVar('__BBDEFINHERITS', inherits)
+            bb.parse.BBHandler.inherit_defer(extendedmap[name], fn, 0, d)
 
         safe_d.setVar("BBCLASSEXTEND", extended)
         _create_variants(datastores, extendedmap.keys(), extendfunc, onlyfinalise)
diff --git a/lib/bb/parse/parse_py/BBHandler.py b/lib/bb/parse/parse_py/BBHandler.py
index 4bdb11994f..008fec2308 100644
--- a/lib/bb/parse/parse_py/BBHandler.py
+++ b/lib/bb/parse/parse_py/BBHandler.py
@@ -42,12 +42,22 @@ def supports(fn, d):
     """Return True if fn has a supported extension"""
     return os.path.splitext(fn)[-1] in [".bb", ".bbclass", ".inc"]
 
+def inherit_defer(expression, fn, lineno, d):
+    inherit = (expression, fn, lineno)
+    inherits = d.getVar('__BBDEFINHERITS', False) or []
+    inherits.append(inherit)
+    d.setVar('__BBDEFINHERITS', inherits)
+
 def inherit(files, fn, lineno, d, deferred=False):
     __inherit_cache = d.getVar('__inherit_cache', False) or []
     #if "${" in files and not deferred:
     #    bb.warn("%s:%s has non deferred conditional inherit" % (fn, lineno))
     files = d.expand(files).split()
     for file in files:
+        defer = (d.getVar("BB_DEFER_BBCLASSES") or "").split()
+        if not deferred and file in defer:
+            inherit_defer(file, fn, lineno, d)
+            continue
         classtype = d.getVar("__bbclasstype", False)
         origfile = file
         for t in ["classes-" + classtype, "classes"]:

