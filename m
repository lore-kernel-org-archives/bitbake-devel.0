Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web09.6538.1612524379234272963
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Feb 2021 03:26:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=mtxams1d;
 spf=pass (domain: konsulko.com, ip: 209.85.128.45, mailfrom: pbarker@konsulko.com)
Received: by mail-wm1-f45.google.com with SMTP id m1so5632249wml.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Feb 2021 03:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5dZsS/9ynqs+M+XYJnMCrUKR0M7gvq4s7UwkyuC+vUI=;
        b=mtxams1d814LTmNFZhm0oLZjn27XxkrIWPAXOkA+QAHwR/aoCa1poLv/BJ+NloIPFn
         e3sKGcSFQL2SKcb8GAnJxHpc0DRX0cwl16oAHLHms7ji+BYV8fLRIfKKuA3lJ+LrhkTF
         5EbJoZQ+oV98/7s1eY50J6/Zpl+MasOjbClDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5dZsS/9ynqs+M+XYJnMCrUKR0M7gvq4s7UwkyuC+vUI=;
        b=jI2fonTewy9hhc/WH4dx7Wbsfu2mIuSd/6rXXUdffUOKAdyldG8ummmL/U0YnftFcO
         QSp1xtDa8UN6pYYjbftxcT/9QHhkmgGflP5IgUWJHAtqkdwNVwJVWFgkGa6d+iaj6E6A
         zgrgEnPhUIFHlW5PthiQSWBkmEmZy/WJGNscQY2P5NcglrZh7PG6HNbPUYvifjiVFPC0
         ZEYHuxlcscciNwFhn0i+ZrMBiuXNVZiiqhA2r0mzpaMsuAnztDZCADDl/CE4UdVY3Rdv
         2G/Z1xQA1ZpQgOU3sugqdLxDm63F4YQbPpR0lbFb+xDY6p8vtuvvuv2xBarJFv93kR/3
         z76w==
X-Gm-Message-State: AOAM531w1VYPa6BZLqyB6xLs0z2xxehRfqbRGBDw2u4l2uja31XPhYRe
	vnLn+Zq56LEGQQrnc8KZJ0jC6xTm4lgOCt1x
X-Google-Smtp-Source: ABdhPJy7SPoB4jONudMoSPKhBGLlIc7fp4LAjeSCt22gSF6ijydkcyaJKfHJnT+onPLuXxDDaUKHgg==
X-Received: by 2002:a7b:c856:: with SMTP id c22mr3274512wml.5.1612524377417;
        Fri, 05 Feb 2021 03:26:17 -0800 (PST)
Return-Path: <pbarker@konsulko.com>
Received: from tortoise.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id y18sm11881716wrt.19.2021.02.05.03.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 03:26:16 -0800 (PST)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [PATCH v2 2/8] hashserv: client: Fix handling of null responses
Date: Fri,  5 Feb 2021 11:26:05 +0000
Message-Id: <20210205112611.17167-3-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210205112611.17167-1-pbarker@konsulko.com>
References: <20210205112611.17167-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the server returns an empty response ("null" in json), this cannot
be iterated to check for the presence of the "chunk-stream" key.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 lib/hashserv/client.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/hashserv/client.py b/lib/hashserv/client.py
index 0ffd0c2ae..0b7f4e42e 100644
--- a/lib/hashserv/client.py
+++ b/lib/hashserv/client.py
@@ -99,7 +99,7 @@ class AsyncClient(object):
             l = await get_line()
 
             m = json.loads(l)
-            if "chunk-stream" in m:
+            if m and "chunk-stream" in m:
                 lines = []
                 while True:
                     l = (await get_line()).rstrip("\n")
-- 
2.26.2

