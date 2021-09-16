Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web11.3408.1631823774326927764
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Sep 2021 13:22:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=c15XX9hB;
 spf=pass (domain: gmail.com, ip: 209.85.221.52, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f52.google.com with SMTP id g16so11447191wrb.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 16 Sep 2021 13:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zN0AE8TTHSF5wZToEKvs4jApfce8kfzRnFThtYAmSmI=;
        b=c15XX9hBgJOTTN/OrV/5dY16+LTyJUXiOpBIErRn+ywESeiHevF4hj3K8pnZwZQCb+
         pfrhxW/+1Iz2UiJYlR0vbrr5rKVOVyvHsWw5enl1RYRH8AFvz+d2U70hiTaBlozlsx9e
         2EWCQeJJScTCgQedcg3myaxJiP56SnOCRjqTooRe4r7BKfjZ7vXOpo7vm160piw9Hh7s
         XT6U76N+lTW4yoNRJ/luJB0gpXGlRcUX7G+zWn2AKIR1SrSDikLjo+iIeeKp6tGPRvdq
         CdBzsVDYaT/fl7OmKmYPHqJGl3yqJRA4vipOCY2nMT2c8TvQazP2x8aEWyrBOH+EYQD/
         LvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zN0AE8TTHSF5wZToEKvs4jApfce8kfzRnFThtYAmSmI=;
        b=bWB4i0sCAfll424olezJFhgir/CevayTtnXcYARxAVJp78sj+P3Z7NNFecYhJebX7p
         rC7XyBxlvj/k91tr2lAnKQG7kI03pR7kBUECVr6YoGC8WGEuo2xYGt+VlfgY2iV0loU0
         Q5IlIU0i+uzx+gNqfX4IulNd5kweN4S8Fl3sc3a9C7AQ4VJeJkAm1KE9DUi+H3H1z3BY
         Qb/koYu55KAnARVrhBO/mkD8AFGLJ8t719VKApN+5F/zSz+9dqeKR846NBfmXy0qQZO+
         3At8ukQp9XVbSJwdNBLCgJCju5E9OdadG5U1XYw/fvQFXIF2/nobNYr2HCdvg5q7UHeB
         5Qdw==
X-Gm-Message-State: AOAM532kTOMJAEPJPBH2P6BpZu/DxmB8izUfAL2HJJlTd13dVeJnO6b4
	GlRcFs3AklkCRtUyytitiQHZpW1CK1w=
X-Google-Smtp-Source: ABdhPJyLsK6YOimMXsf0ZpQUyqO5JapNwaa6D4WZVdflvMtM6kjVpeTSai9Dp8UUjojqb08WmIQ1rA==
X-Received: by 2002:a5d:49ce:: with SMTP id t14mr8050445wrs.183.1631823772701;
        Thu, 16 Sep 2021 13:22:52 -0700 (PDT)
Return-Path: <alex.kanavin@gmail.com>
Received: from nereus.lab.linutronix.de. (b2b-109-90-143-203.unitymedia.biz. [109.90.143.203])
        by smtp.gmail.com with ESMTPSA id q11sm8644586wmc.41.2021.09.16.13.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 13:22:52 -0700 (PDT)
From: "Alexander Kanavin" <alex.kanavin@gmail.com>
X-Google-Original-From: Alexander Kanavin <alex@linutronix.de>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 6/7] bitbake: adjust parser error check for python 3.10 compatibility
Date: Thu, 16 Sep 2021 22:22:36 +0200
Message-Id: <20210916202237.1929584-6-alex@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210916202237.1929584-1-alex@linutronix.de>
References: <20210916202237.1929584-1-alex@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The change was introduced in
https://github.com/python/cpython/commit/a698d52c3975c80b45b139b2f08402ec514dce75

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bitbake/lib/bb/data_smart.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index 73e33ee10ec..ec7bb561ccd 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -409,7 +409,7 @@ class DataSmart(MutableMapping):
                     s = __expand_python_regexp__.sub(varparse.python_sub, s)
                 except SyntaxError as e:
                     # Likely unmatched brackets, just don't expand the expression
-                    if e.msg != "EOL while scanning string literal":
+                    if e.msg != "EOL while scanning string literal" and not e.msg.startswith("unterminated string literal"):
                         raise
                 if s == olds:
                     break
-- 
2.20.1

