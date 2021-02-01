Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web11.32769.1612180417826927554
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Feb 2021 03:53:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=GnSL5FII;
 spf=pass (domain: konsulko.com, ip: 209.85.221.46, mailfrom: pbarker@konsulko.com)
Received: by mail-wr1-f46.google.com with SMTP id 6so16243333wri.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Feb 2021 03:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5dZsS/9ynqs+M+XYJnMCrUKR0M7gvq4s7UwkyuC+vUI=;
        b=GnSL5FIIaq8+yH0BNVHletCZrGE/UkqQ3gJ9bIjpqz2Pt8tzHq2aE6XAsKGlF/Lyic
         UCawfbxYsA9D/K4VfwQpOTOd4urMLB08pma+HnE4ZYlIePEasWetHS3tS5ItqivYqlXV
         pkqDuxSuXHKR6Fxw9LpqCy3WIAy21P/Qjqd5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5dZsS/9ynqs+M+XYJnMCrUKR0M7gvq4s7UwkyuC+vUI=;
        b=DVdtd1nce8VZ3403/X5Cia9ZJSMaWcslgnjC5FX3bq1WfqM6a/R8bYe61CicOZLfOX
         RCcnV6pcxZPJV3+N+gKqa8hkJirTI6hVMVnFvfnkNpkCXUGEIO6w4nvye1mUa+Fjkjyx
         TydDK4Bf0rgf/f4jdt+Tquss/5ndHcYy1efYVyzbjPc1IJWKs4jPF3i461VBO35NdCNP
         /GqCpkXXt3DasfkFjmwlvwCNckL8AKLBc8vfS+GLiYnh3J2+mJcGurA13WegR/S1+4n/
         1TLy55Z5N5NeLUVatETMrapEYf88+Ix08mhU1xlCxd8qSCP1WHHfy7O2qK7Ns/hexmjf
         jQWg==
X-Gm-Message-State: AOAM530z9ib8YFThL4zOYv51lW/RHCQML9P10OahFKMr7A3g/SpwPMNl
	i+hFNribrg10DNMPBzxPSDco3vDYZeVsrUhT
X-Google-Smtp-Source: ABdhPJxayq8so1G9V7okLSKCkR5xBKrdyI8JEi7iKGkZJpzO63OGy5dF6ldIqp4KPBJ2cp32O4xsBQ==
X-Received: by 2002:adf:f40d:: with SMTP id g13mr17735539wro.142.1612180416211;
        Mon, 01 Feb 2021 03:53:36 -0800 (PST)
Return-Path: <pbarker@konsulko.com>
Received: from tortoise.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id u6sm28120514wro.75.2021.02.01.03.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 03:53:35 -0800 (PST)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [RFC PATCH 2/8] hashserv: client: Fix handling of null responses
Date: Mon,  1 Feb 2021 11:53:25 +0000
Message-Id: <20210201115331.13510-3-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210201115331.13510-1-pbarker@konsulko.com>
References: <20210201115331.13510-1-pbarker@konsulko.com>
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

