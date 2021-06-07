Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web08.36990.1623078220101871105
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Jun 2021 08:03:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=U0ZnX55W;
 spf=pass (domain: konsulko.com, ip: 209.85.128.50, mailfrom: pbarker@konsulko.com)
Received: by mail-wm1-f50.google.com with SMTP id t4-20020a1c77040000b029019d22d84ebdso12942049wmi.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 07 Jun 2021 08:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pI0nwyXt2Avd6D/8tnOmsDC9MxZS+oQRMQW1CLQ/9qE=;
        b=U0ZnX55W1ER0UFYvSnHeO3UgAN1Rs83d+rX3DvkOFI0OkmTpSZgtnpDQP9morzDTP6
         3zW9C9RU4N91xapPBQz8s7bemFn1m4YTkJ6/AgKxS4Hwk55lTPsjG4uSpg2H58N/OeFP
         LAiQWjz5a0Vzn5Cfo1mcMszlzz+R3pKJQxOxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pI0nwyXt2Avd6D/8tnOmsDC9MxZS+oQRMQW1CLQ/9qE=;
        b=KEXCs6M2bT1CwfyuYaCYajpRXMYqZT9LwloBZEVFkGIfgLAQDGt/9WoIHzS4UWjAO3
         ca1f6nhpA9xQoqA83gSc3Ky6C2X1PfcSzmr3KWy8pkGHW66+9XEqZloYD4bXNT8LxGAh
         /3g4WVneY2RjhfFkoTRV12cFJ6slsxw/p4AM5NSsUjvTRrbk8hwMi3t5PtbBlrxtnjMA
         JGx0RE0ERWdfldI3FnfYI+dES7X5KLp1iqE0Sj0GQiVbiNKxMAYweft3oDj6pTGlx8Lt
         ScM4OgyTXiit3Nl5OnAyoKuYOW/Ndm4QiZSWjaD2UZpOoJzZgVxo4QDyo1ZH1dxLLNut
         PW2Q==
X-Gm-Message-State: AOAM533Ufx/QxTB5wupc680iZL+Bloy/QM2H/zP5ftRY/gim4CCjFnq6
	aKynTt/p9IWAyMstKHYzCnR/54Lxz6zYYg==
X-Google-Smtp-Source: ABdhPJwTNVZQVM2TMWOBTwDGGYkSlX/fZ4+yqN+K8UiESapi3hfuXA0jFl4169RWyzj/uaimJ5ymxw==
X-Received: by 2002:a7b:c3da:: with SMTP id t26mr17123876wmj.63.1623078218497;
        Mon, 07 Jun 2021 08:03:38 -0700 (PDT)
Return-Path: <pbarker@konsulko.com>
Received: from alpha.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id l2sm15995488wrp.21.2021.06.07.08.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 08:03:38 -0700 (PDT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [PATCH v2 1/4] asyncrpc: Fix bad message error in client
Date: Mon,  7 Jun 2021 16:03:32 +0100
Message-Id: <20210607150335.32326-2-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210607150335.32326-1-pbarker@konsulko.com>
References: <20210607150335.32326-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If there is an issue with the format of the reply given by the server then we
should print this reply line in the error message. Printing the message which
the client sent doesn't illuminate anything here.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 lib/bb/asyncrpc/client.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/asyncrpc/client.py b/lib/bb/asyncrpc/client.py
index 79919c5be..d917ab597 100644
--- a/lib/bb/asyncrpc/client.py
+++ b/lib/bb/asyncrpc/client.py
@@ -77,7 +77,7 @@ class AsyncClient(object):
             line = line.decode("utf-8")
 
             if not line.endswith("\n"):
-                raise ConnectionError("Bad message %r" % msg)
+                raise ConnectionError("Bad message %r" % (line))
 
             return line
 
-- 
2.26.2

