Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web12.3155.1632396536884339083
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 23 Sep 2021 04:28:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=bQE9oZ0p;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id g16so16250308wrb.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 23 Sep 2021 04:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yYRlakgP5yXZXkrNBxJOrriAtMSGLuIJYJpAdtnWYGQ=;
        b=bQE9oZ0p4UILj/lzhNWiU5mkMUMzLxm/rWOq+imj8U47hDl4Ur8594ROgYvdHUR4nL
         v445ExpcmShdWlJCIA6uZNFh9pvWo0ZGs7ZpcEp1zFHQmEc7qK/Sq43jOEGe0KAwBXzB
         D6wmnLJt4bkClSJelMd9rfuj8pz4afl7jb9tA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yYRlakgP5yXZXkrNBxJOrriAtMSGLuIJYJpAdtnWYGQ=;
        b=7LVEaklqCZpx/KetygNQjVbG3wh5ljKDltPpXJNM0cnrB3QmozLkuF1ClXrAb0EK4u
         keafIijOtHFPhwNMw30rUQmauB/hkcDKgLVS2a9bZV8YxGObve1OA9TPzlY0yZuFfxi0
         UfxsyFAC4+atUo4YClS+eHZcszsOcN5JtEYys96GXgG9WwfktOL7863vdoLxxSMDj7Ys
         7fTx0IC0sAhKTK0+trSE2IofkLJBt2la28+/pfjG8C8Kh9ehV5PGH4Kr0dGMoQvwYKPG
         0wqVrlWJ5B/R1gC+F/339mh7oDdT8tt2xsTQ9L9ewpTxz3fyb6LPKvVOfMuYlZQu9oUl
         CpsQ==
X-Gm-Message-State: AOAM533ietmV6aTSVWMLwxGSsCV6c6K6qszzd6fICnVLCDuAzXHwt3jC
	HtMUcAGNjI8SETKs8fbp+5hMZvZagIMaBwGa
X-Google-Smtp-Source: ABdhPJwQbs8MB91HJdHJr0PSVsUbUA/RuKcziKM6zB/M7UxstXn4gRXx9mAsqsYrgcWORdFS6Rnumw==
X-Received: by 2002:a05:600c:3203:: with SMTP id r3mr15219346wmp.175.1632396535341;
        Thu, 23 Sep 2021 04:28:55 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:3a36:9e9a:ccb5:f067])
        by smtp.gmail.com with ESMTPSA id 5sm5177382wmb.37.2021.09.23.04.28.55
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 04:28:55 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/3] build: Make exception printing clearer
Date: Thu, 23 Sep 2021 12:28:52 +0100
Message-Id: <20210923112853.1706985-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210923112853.1706985-1-richard.purdie@linuxfoundation.org>
References: <20210923112853.1706985-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Shows:

ERROR: SystemExit(1)

instead of:

ERROR: 1

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/build.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 18586c276e..99954b0c26 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -707,7 +707,7 @@ def _exec_task(fn, task, d, quieterr):
                 # logs once already so don't duplicate
                 if verboseStdoutLogging:
                     errprinted = True
-                logger.error(str(exc))
+                logger.error(repr(exc))
                 event.fire(TaskFailed(task, fn, logfn, localdata, errprinted), localdata)
             return 1
     finally:
-- 
2.32.0

