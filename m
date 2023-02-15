Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F390FC636D4
	for <webhook@archiver.kernel.org>; Wed, 15 Feb 2023 15:35:38 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web10.18098.1676475329433951975
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Feb 2023 07:35:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=YlttegWL;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id az4-20020a05600c600400b003dff767a1f1so1837322wmb.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 15 Feb 2023 07:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIbp1YQnlbNGPedfqLaeFnxarumsQdP02Bxz7sWcOhg=;
        b=YlttegWLkmp78ZxrZoaiji9758GjLTzMdz6IOKkpQUyup52sillcLiQ6IH/1dZXqZY
         mrMReOfexj1FIgpPz5LekPzwu0n+EszY8OzL6u++GlLiSwDYMFy32SR3ly7NaM0ryHqK
         YO+HpV+DNuY3QFndzQJ5KKYIZMpoiYMDqfDxqsHwlX063kQ8Lgu+Pjq6h0i2cGhSRNF9
         odz687qyLX7oFmyjL0ftKvjywQwL9Ehd+4iuR9inClx0bTT1gfdK3i7CRpj3hohEhDli
         UZmIQssLfBBiSwu+3Fdus/CC+OEMxjmSJgHK0KR8zSHJlATci8gypIXC0OgfDSrM1AbY
         fbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tIbp1YQnlbNGPedfqLaeFnxarumsQdP02Bxz7sWcOhg=;
        b=xGtVD7ZLiv77I4T/oW9xcMEm8yXWpk7v4XNV6UcAZKs5LnNrlDRLVUkaOMwI+ahRTs
         34tTpEt4hJcbl9xHSRKOPgVR74AdmVerU679T+VdcWKB18gva/cO5ejt1mAGIedP62Hr
         wxiUIk60VfDEWKojiJZ1d9Ixlpr/o5fVC5UxvCKb6EA5tD38V54RIaeWmlxLS5Y3U7lQ
         EJu0sAJVfdkHajuXniHYSBpYsOnY/3g1zs3yKvPU5I8w21+vLTONWFCkbsEjdJCOVNIp
         D6j7CVqy7riF06g7cjhmQpyEioTlFPyxkHT3bVLi/5hev1GdAYHw9oBIc1xxijwISa7Z
         1LEA==
X-Gm-Message-State: AO0yUKWX4EvxNjD4+xBI8QCUqLKJHLPFrzqYJLOlbtk9jJM+4PbDIlBZ
	ILgr2tnJ24bghWO5wfCu0rS3V+doN5M=
X-Google-Smtp-Source: AK7set/k7cjTEqAfN8CG6R9CpOQQvzMtFTBiSDjacsO9e7C0nuvWA7d8vYi2Cyk5mqnypHMh18+f/A==
X-Received: by 2002:a05:600c:3d9a:b0:3df:9858:c03f with SMTP id bi26-20020a05600c3d9a00b003df9858c03fmr3562581wmb.20.1676475327843;
        Wed, 15 Feb 2023 07:35:27 -0800 (PST)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id f21-20020a05600c44d500b003db12112fcfsm2400512wmo.4.2023.02.15.07.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 07:35:27 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Martin Jansa <Martin.Jansa@gmail.com>
Subject: [RFC][PATCH] ast.py: catch SyntaxError from imported modules as well
Date: Wed, 15 Feb 2023 16:35:23 +0100
Message-Id: <20230215153523.2099173-1-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <1744089666E6B90B.5898@lists.openembedded.org>
References: <1744089666E6B90B.5898@lists.openembedded.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Feb 2023 15:35:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14435

* before addpylib directive possible syntax error resulted in output like this:
  $ echo "def foo()" >> oe-core/meta/lib/oe/qa.py
  $ bitbake -k zlib-native
  ERROR: Unable to parse Var <OE_IMPORTED[:=]>
  Traceback (most recent call last):
    File "Var <OE_IMPORTED[:=]>", line 1, in <module>
    File "oe-core/meta/classes-global/base.bbclass", line 35, in oe_import(d=<bb.data_smart.DataSmart object at 0x7fa09b142790>):
                   # Make a python object accessible from the metadata
      >            bb.utils._context[toimport.split(".", 1)[0]] = __import__(toimport)
               except AttributeError as e:
  bb.data_smart.ExpansionError: Failure expanding variable OE_IMPORTED[:=], expression was ${@oe_import(d)} which triggered exception SyntaxError: expected ':' (qa.py, line 222)
  The variable dependency chain for the failure is: OE_IMPORTED[:=]

* now it wasn't showing any output at all when there was syntax error
* show error and name of the module which failed to be imported
  $ bitbake -k zlib-native
  ERROR: Error importing OE module qa: invalid syntax (qa.py, line 229)

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 lib/bb/parse/ast.py | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 375ba3cb..efdb9000 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -285,10 +285,10 @@ class PyLibNode(AstNode):
         libdir = data.expand(self.libdir)
         if libdir not in sys.path:
             sys.path.append(libdir)
-        try:
-            bb.utils._context[self.namespace] = __import__(self.namespace)
-            toimport = getattr(bb.utils._context[self.namespace], "BBIMPORTS", [])
-            for i in toimport:
+        bb.utils._context[self.namespace] = __import__(self.namespace)
+        toimport = getattr(bb.utils._context[self.namespace], "BBIMPORTS", [])
+        for i in toimport:
+            try:
                 bb.utils._context[self.namespace] = __import__(self.namespace + "." + i)
                 mod = getattr(bb.utils._context[self.namespace], i)
                 fn = getattr(mod, "__file__")
@@ -301,9 +301,10 @@ class PyLibNode(AstNode):
                         continue
                     funcs[f] = fcall
                 bb.codeparser.add_module_functions(fn, funcs, "%s.%s" % (self.namespace, i))
+            except (AttributeError, SyntaxError) as e:
+                bb.error("Error importing OE module %s: %s" % (i, str(e)))
+                raise
 
-        except AttributeError as e:
-            bb.error("Error importing OE modules: %s" % str(e))
 
 class InheritNode(AstNode):
     def __init__(self, filename, lineno, classes):
-- 
2.39.1


