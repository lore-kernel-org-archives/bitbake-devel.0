Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0601C433F5
	for <webhook@archiver.kernel.org>; Mon, 21 Feb 2022 16:04:00 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web09.487.1645459439151463750
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 21 Feb 2022 08:03:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=eEOMGZ9M;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.50,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f50.google.com with SMTP id o24so27937962wro.3
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 21 Feb 2022 08:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mHNPlG152gqTfTwXiWCiruOecHT9t5pjddnJ88KW3HQ=;
        b=eEOMGZ9MT78V2iqY6RAMO5HTJZATVFPOD/5GoKoyIj42r17T1z9tC1dTis3j2k+ZKc
         GrvCm28qyNnYlvjtVnmcw7io/QNdCW42Zjqhlif5ZJ5k1O8KZBblDOMwyP9fT+g9hNCk
         FySeCfOug2RSfO2c2HMd+pKTtldDCEYRBvtpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mHNPlG152gqTfTwXiWCiruOecHT9t5pjddnJ88KW3HQ=;
        b=psuxnWPjsR4Z5ocqfCdgEran+jW0NOfzEMaS6Tcty+nNF1KhFS6pMQm25LcUjoMJDH
         T+479lEv/JrYlqQbscNCFtYYUm5jD9Sty/MHPnHrPfvOH/J6R8Mhcer0lYaaoeG6HipZ
         uBnVZtZn75dKgCrJRx3T4DZlIdzL54+WAzrBdqjMx5SaW5kRb5FxW2altuSIPxHGzFQ7
         7mrdGk7CHjf8umqxyk9TzVltWh/2bXnq9aWL2YfdDrFXNy90bbW0rvm5XZ3TExeYqmfm
         M9j8IC9M4Hj6aKenr7sYEfMSsaam8pZiKC/nV+9YJJ2jwmM9IGnL8ZHoDQlzMMTePv/a
         UojA==
X-Gm-Message-State: AOAM53380uEBOaX20GpdLsKgidv2NgYbSq3Tq9M4Hnis6BfqExVeyH6L
	smn5uI8y9kCtnAq35tWI7eDJzZFf10CZAr25
X-Google-Smtp-Source: 
 ABdhPJyW2n8gqORnOMMTS1tRJigH5DveGppledbWqJmCznBHwOBwDS9jWKqRLeAzO6JMZZgFuhkqzg==
X-Received: by 2002:adf:e951:0:b0:1e6:85e6:65d9 with SMTP id
 m17-20020adfe951000000b001e685e665d9mr15805392wrn.412.1645459437395;
        Mon, 21 Feb 2022 08:03:57 -0800 (PST)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:ae50:3f11:233d:4303])
        by smtp.gmail.com with ESMTPSA id
 k11sm159444wrd.103.2022.02.21.08.03.56
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 08:03:56 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] utils: Ensure shell function failure in python logging is
 correct
Date: Mon, 21 Feb 2022 16:03:56 +0000
Message-Id: <20220221160356.3167661-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 21 Feb 2022 16:04:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13394

If a python function exec_func() calls a shell task, the logging wasn't working
correctly in all cases since the exception was turned into a BBHandledException()
and the logfile piece was lost which is handled at the top task level.

The easiest way to avoid this is to allow the ExecutionError exceptions to
be raised to a higher level, we don't need the traceback for them.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/utils.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 2c22535424..2e8256101a 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -402,7 +402,7 @@ def better_exec(code, context, text = None, realfile = "<code>", pythonexception
         code = better_compile(code, realfile, realfile)
     try:
         exec(code, get_context(), context)
-    except (bb.BBHandledException, bb.parse.SkipRecipe, bb.data_smart.ExpansionError):
+    except (bb.BBHandledException, bb.parse.SkipRecipe, bb.data_smart.ExpansionError, bb.process.ExecutionError):
         # Error already shown so passthrough, no need for traceback
         raise
     except Exception as e:
-- 
2.32.0


