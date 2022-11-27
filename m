Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F3CC352A1
	for <webhook@archiver.kernel.org>; Sun, 27 Nov 2022 21:22:45 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.101709.1669584157553707200
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 27 Nov 2022 13:22:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=XSo9dwZb;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id a11-20020a05600c2d4b00b003cf6f5fd9f1so7134309wmg.2
        for <bitbake-devel@lists.openembedded.org>; Sun, 27 Nov 2022 13:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mI3jISLTK+kkR9Yv6KlZH1/2m8j8r2EVXQCk/A06LY8=;
        b=XSo9dwZbruBXFl6hzuTy9xrx751uWZiSaCJ0jmUVcF9JRDWX59xsWZ5wtoLuvd8Qfl
         1RKWqyfi9LivJ4nhRsaK4JDNnvDDtaW/08zBufc+u3Ybty+0BmUH0u8tKcEvYXkbBMCV
         T4TXe9q1GCnVw+WXg4aHng5VoG+9fXC9pJh0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mI3jISLTK+kkR9Yv6KlZH1/2m8j8r2EVXQCk/A06LY8=;
        b=W4J/STqIzfW0o4X7BzSRl3Cc0BCCU4/uSfaDv3W96WHty0xUgph+D02OGvFGFdE8PL
         UB7LrhBQCziYs/lQaMW7R0camerVIkdzgaC33+5yDmqJF+peUFw1Tc7mrj3Se/SmFXyX
         kXPKekS1H2QnTZxvQZnDBOzBUsoVmc5sqT5yNnsDfpsM7SKHMh0XSnO7EjiHpNKrM34k
         KyIiowSxhj4B7vOrfjg4byENCITVrqi4IRwff8ARQrg0je0buVJLWCjlbDold1ofOdy/
         VfoJllUUU3Ux0HtpESwP+e3qHFGS3wfb29/Kw46mErjAWYrlmAsfSery/vV1lUhwt+om
         CdVg==
X-Gm-Message-State: ANoB5plTDUi1vjsakEjk+vC/U/7sJGoE4QpTbMpknsOgQf1DRiVMNQHL
	9a6ycZ7sJPNawzT0g4UE49visY9KuNYG6g==
X-Google-Smtp-Source: AA0mqf737BBTz1DowIUJGj4oYv8bgAfK3UMH4ToOmBdQ0K7wfJkCOkEA6JBd9MUAQwP7ClQrv2wozw==
X-Received: by 2002:a1c:f616:0:b0:3cf:b1c2:c911 with SMTP id w22-20020a1cf616000000b003cfb1c2c911mr27748639wmc.16.1669584155585;
        Sun, 27 Nov 2022 13:22:35 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:aafe:fe4:d699:e1e9])
        by smtp.gmail.com with ESMTPSA id f13-20020a05600c4e8d00b003c6c182bef9sm21933787wmq.36.2022.11.27.13.22.35
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 13:22:35 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] BBHandler: Remove pointless global variable declarations
Date: Sun, 27 Nov 2022 21:22:32 +0000
Message-Id: <20221127212232.538210-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221127212232.538210-1-richard.purdie@linuxfoundation.org>
References: <20221127212232.538210-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 27 Nov 2022 21:22:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14114

These are static regex compilations which don't change or a standard module
import (bb). There is noneed to declare them as global so drop the pointless
code which doesn't do anything.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/parse/parse_py/BBHandler.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/parse/parse_py/BBHandler.py b/lib/bb/parse/parse_py/BBHandler.py
index 18e6868387..584966fea1 100644
--- a/lib/bb/parse/parse_py/BBHandler.py
+++ b/lib/bb/parse/parse_py/BBHandler.py
@@ -102,7 +102,7 @@ def get_statements(filename, absolute_filename, base_name):
         return statements
 
 def handle(fn, d, include):
-    global __func_start_regexp__, __inherit_regexp__, __export_func_regexp__, __addtask_regexp__, __addhandler_regexp__, __infunc__, __body__, __residue__, __classname__
+    global __infunc__, __body__, __residue__, __classname__
     __body__ = []
     __infunc__ = []
     __classname__ = ""
@@ -154,7 +154,7 @@ def handle(fn, d, include):
     return d
 
 def feeder(lineno, s, fn, root, statements, eof=False):
-    global __func_start_regexp__, __inherit_regexp__, __export_func_regexp__, __addtask_regexp__, __addhandler_regexp__, __def_regexp__, __python_func_regexp__, __inpython__, __infunc__, __body__, bb, __residue__, __classname__
+    global __inpython__, __infunc__, __body__, __residue__, __classname__
 
     # Check tabs in python functions:
     # - def py_funcname(): covered by __inpython__
-- 
2.34.1


