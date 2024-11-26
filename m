Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BFBD66B84
	for <webhook@archiver.kernel.org>; Tue, 26 Nov 2024 22:18:45 +0000 (UTC)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
 by mx.groups.io with SMTP id smtpd.web11.59011.1732659515996351174
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 26 Nov 2024 14:18:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Pd3H4d7O;
 spf=pass (domain: gmail.com, ip: 209.85.160.54, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2967fb53621so116345fac.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 26 Nov 2024 14:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732659514; x=1733264314; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRM+yEsR4E/Wo+Z6Ct09VUuEv1sq1/Kn5GeJ39UMg+s=;
        b=Pd3H4d7OwVC5rHkIcDcok6b38TDNa2bqbDgz5sOWj89Cc7nKbJAEXZuEddS8cfsQ9N
         w474vnM4Y+STA+vFwJ/7vCa+x2jHvnIt4ecczhC7mfdN08wCnNyGJLNkFbARgFvcl6yR
         mo38eeAxsrD8O/ChX7hzUuB27Y8hb1XvDMCFZvtSB1ICvvx4CxbjlsCTxkNRcKfc2jeT
         hGZjjYi13IaqtjGAmxA8RudjcAGoQhprHenusV1A+GuP+GzGZh5nueIo5r2O71q2oDPz
         ZFR2o0LK2zWKuZZ7NU/AiZDKK/Iq9X9jEssks5HfvHq3XRT9DlM+5TspH48r4EOffc+U
         zGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732659514; x=1733264314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XRM+yEsR4E/Wo+Z6Ct09VUuEv1sq1/Kn5GeJ39UMg+s=;
        b=VKjsViPdwHQnrmjjby67VgoWAFnU9Xi754p2PsUbdHwE9r60UZ193g8K+Zn7zKXx7B
         2V9W8stdB/F5g3KCNhyvd0moLbVdBdVGS1ewBmcvcNZJGbew8JiPLavzYQoKEz7T9Vc1
         7hzvH2tIR7D7CLCHy5OZUAUEIPXt3yK8ykdFXw5ZhEqXPTgdSKpCnJ/6sK8+xVBroGrq
         d7VjbPzSYx0FHL851g78lz2e1ynCACka5d9tmbJYApO0e6snQE+1nacCX9cm4YP00EsC
         sQuHMwTZta/oyQo/deRyzypR3gsu0povyGOM9BlWjP1w4jjJzurxcnF9ZhTjflULAwsa
         x6MQ==
X-Gm-Message-State: AOJu0YxUCHGXkTy9c8aoriilYNCOlTx/7ppemUbkFjITpBDsCBmXGQc1
	EzfjTFWUVUtJwM8AFajopPDl4zkM29RRvknJBJLW14Uvl8TWS+sJJKdafQ==
X-Gm-Gg: ASbGncvrmr55Yg/weScCy9o6tSe9wE19xFNco2bevw8M7CVmaOGk9/j5KVF7ZYok61I
	BbvEJl8YXxbfD4IiA4Ez9e/CyHFArtz7zb8BXn6IuaNPTZeExZF6AFLul8Gf43cuZ/x+AERcZw3
	05WdkcejWD2CKaJ0wi8UeihJkOyAoBNaOk2vJMa/EVzV3lArhgV/aHed9zWcx8zjCQJe0/wGCjl
	PoPwfZPAmlwTwnqZa7/OGrnT2Phz/V6lBompPL+bobjwuZq
X-Google-Smtp-Source: AGHT+IF/Mo/1bt/9wbJgxutI05HB+ARu+mlRG6ekx+9N/UeF6bCcjttyAq0jdDZMXECCxFvT2TmhyA==
X-Received: by 2002:a05:6870:700c:b0:297:6b3:f71c with SMTP id 586e51a60fabf-29dc22aecf2mr568092fac.5.1732659514651;
        Tue, 26 Nov 2024 14:18:34 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4300:19e0::dc1a])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71d5bdf568fsm776133a34.41.2024.11.26.14.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 14:18:33 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 1/2] exceptions: Add option to hide frame arguments in exceptions
Date: Tue, 26 Nov 2024 15:16:01 -0700
Message-ID: <20241126221829.2825101-2-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241126221829.2825101-1-JPEWhacker@gmail.com>
References: <20241126221829.2825101-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 26 Nov 2024 22:18:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16839

The exception code in bitbake prints out the arguments to functions
calls, and while this is very useful, it means that if there are secret
credentials in arguments (like the password for bitbake hashserver
client), they will be shown in the logs and potentially leaked.

To prevent this, add code that checks for the local variable
HIDE_FRAME_ARGS in the function. If present and set to True, the
exception code will not print the value of any of the function
arguments.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/exceptions.py | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/bitbake/lib/bb/exceptions.py b/bitbake/lib/bb/exceptions.py
index 60643bd6421..931140da0c6 100644
--- a/bitbake/lib/bb/exceptions.py
+++ b/bitbake/lib/bb/exceptions.py
@@ -36,26 +36,24 @@ class TracebackEntry(namedtuple.abc):
 
 def _get_frame_args(frame):
     """Get the formatted arguments and class (if available) for a frame"""
-    arginfo = inspect.getargvalues(frame)
+    args, varargs, keywords, local = inspect.getargvalues(frame)
+    if not args:
+        return '', None
 
-    if not arginfo.args:
-            return '', None
-
-    firstarg = arginfo.args[0]
+    firstarg = args[0]
     if firstarg == 'self':
-        self = arginfo.locals['self']
+        self = local['self']
         cls = self.__class__.__name__
 
-        arginfo.args.pop(0)
-        try:
-            del arginfo.locals['self']
-        except TypeError:
-            # FIXME - python 3.13 FrameLocalsProxy can't be modified
-            pass
+        args.pop(0)
+        del local['self']
     else:
         cls = None
 
-    formatted = inspect.formatargvalues(*arginfo)
+    if local.get("HIDE_FRAME_ARGS", False):
+        return '(HIDDEN)', cls
+
+    formatted = inspect.formatargvalues(args, varargs, keywords, local)
     return formatted, cls
 
 def extract_traceback(tb, context=1):
-- 
2.47.1


