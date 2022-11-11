Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B9AC433FE
	for <webhook@archiver.kernel.org>; Fri, 11 Nov 2022 18:59:25 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web08.628.1668193160981396440
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 11 Nov 2022 10:59:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=ofER2KNI;
 spf=pass (domain: gmail.com, ip: 209.85.221.51, mailfrom: quaresma.jose@gmail.com)
Received: by mail-wr1-f51.google.com with SMTP id z14so7588075wrn.7
        for <bitbake-devel@lists.openembedded.org>; Fri, 11 Nov 2022 10:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mx3/iRohRSf16KviV2J8KUCCAELR5JwJwXKHnmjSQ7Y=;
        b=ofER2KNIZ9yO42/g/wyjKark9Ee4mspqQGooyoIvbxihHAMfWrkglhrLIFnpyDZwz2
         NlJ+KavNQWMQ1TG7jjWrnqUiabFqMhL4BTbXEU4OKrmJPwuLocaNtomzS1ZvPqah1exW
         HF8e+srOY8QHdZqO9jgIftvFfoY3enkuN8xlAR6aSuEahSRyYZS+uRzsoBUGO/yObn+5
         YKOrf+lv6kn1v55lEWU4ucoKB/NGmDUXKoMhNP7iOMpmBg1w9bc/R3W/GYC2NhRGc3YS
         ZpUJfE2heMVT4wFg8R6LmHNwPckl915hChX5HQRUZx5mxz7krJ6ASVSPoLHoK1Cx2CPS
         xnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mx3/iRohRSf16KviV2J8KUCCAELR5JwJwXKHnmjSQ7Y=;
        b=tf64oHtVzh+pGdupgjwjAkk+vRjv6mJyRzH1cq9pWrhYTng780R0h39+ZCj11ku771
         MrLMkbmNLW/kc9FPhKKZWYHCpFbHo/7gnX8hWbgY5/om1gUtRt/s2OTDhWZonbgNLt/g
         M6bz+8jyY4a6yFeomhQcOdDU4fqmbj3e0gb3IXTt+Pp0y8t+HsaHdjbAz47vJcabDKc+
         cxDJLzq/WKAZc+qc6inFj9PgDPRHCHk5dueMs/rMoCRJ5AKi55D96l5VQx5zcw3Jm2Nd
         AmmAobn1O4Xq5lnBVbJmm2Dyj3uhswVxMJoz5Oev7sfTPz4fNvfA7bBSUMdw+NW2Lzhe
         THLg==
X-Gm-Message-State: ANoB5pmBJhKY2+amdTH+TxV50nhRcCu+uMu3Fc4WOLbL9MNf6C2a4+Tw
	0U7GPT02OmlUwYenpMeByFLxCtlbRofNdwX7
X-Google-Smtp-Source: AA0mqf5xhGDjC0zzFeIbock7yHqZmHiZ5MZ3nFd3XkFG3oLSJAYlZeCARtmmmV/gnBOHkm6z/dw6kA==
X-Received: by 2002:adf:f309:0:b0:231:355b:211c with SMTP id i9-20020adff309000000b00231355b211cmr1972525wro.509.1668193159217;
        Fri, 11 Nov 2022 10:59:19 -0800 (PST)
Received: from og-worker-dev-01.infra.foundries.io.net (51-159-19-113.rev.poneytelecom.eu. [51.159.19.113])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c024300b003c6b874a0dfsm4265034wmj.14.2022.11.11.10.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 10:59:18 -0800 (PST)
From: Jose Quaresma <quaresma.jose@gmail.com>
X-Google-Original-From: Jose Quaresma <jose.quaresma@foundries.io>
To: bitbake-devel@lists.openembedded.org
Cc: ricardo@foundries.io,
	daiane.angolini@foundries.io,
	Jose Quaresma <jose.quaresma@foundries.io>
Subject: [bitbake-devel][PATCH 2/2] build: log when the task is locked
Date: Fri, 11 Nov 2022 18:58:49 +0000
Message-Id: <20221111185849.2458457-2-jose.quaresma@foundries.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221111185849.2458457-1-jose.quaresma@foundries.io>
References: <20221111185849.2458457-1-jose.quaresma@foundries.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 11 Nov 2022 18:59:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14073

This improve the bitbake UI when there are tasks with
lockfiles waiting to run.

In such cases one or more tasks are waiting because
there is another one with the lock acquired.
The bitbake UI shows that all the tasks is running
which is not true and can confuse the user.

This patch will shows what are the task that have the lock
acquired.

Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
---
 lib/bb/build.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index ae781c8c..6c0b07a1 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -253,6 +253,9 @@ def exec_func(func, d, dirs = None):
                 pass
 
     with bb.utils.fileslocked(lockfiles):
+        if lockfiles:
+            bb.verbnote("Task locked with lockfiles")
+
         if ispython:
             exec_func_python(func, d, runfile, cwd=adir)
         else:
-- 
2.34.1


