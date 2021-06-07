Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web11.37037.1623078221262868111
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Jun 2021 08:03:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=kvCfNgQt;
 spf=pass (domain: konsulko.com, ip: 209.85.221.43, mailfrom: pbarker@konsulko.com)
Received: by mail-wr1-f43.google.com with SMTP id h8so18002092wrz.8
        for <bitbake-devel@lists.openembedded.org>; Mon, 07 Jun 2021 08:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EO1WreIsfUpYAxXffgvLppQQ8E109sIR5nGLZE3/4Qs=;
        b=kvCfNgQtsVbnVBKLSGhRegBxpuiQnWC4DadAAr4Kyg/GHNu+1U3r0Tc3IBo7zXFikY
         3oSerZCllXp80WFMZizw1LeuP51sUl2TB4AsDsjL+ta2tuk0c/wIGwqnaK8A/Vuad4w6
         aHP8QoqAlfWVzN8ZFNypLXSLrXLC2Kko8cK1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EO1WreIsfUpYAxXffgvLppQQ8E109sIR5nGLZE3/4Qs=;
        b=glXy5tM+1b9NrgbLY/siwovFKVRpl//+DaQGldQnwJembYtlmcfJt/CShZc10RfWSI
         4AcF6YNx0U9quz90Y+ZUqgmM1YTcYaPU4M3HZjS6olZ41+8xn3hgRnTVQ2/5EPWzW2au
         W9/zebh5dgiI0hIJTByhXBy08mWqB5GLhXAYht1LaLYsWzTfoIbnJt1EcKveNF94CrD0
         UaX/ngtjb56ILfqjp9DSSxHFifuNXoZnkoIAYcCO5+RTcZB6n++dSL1+o+BDal37noUc
         E2E0xLLzUmcwiRL2x3lnW8KkBwRngL/R8k5RxPIny39aZjGD/p2h5xrpToThQoVe4wEM
         +g8w==
X-Gm-Message-State: AOAM5336gl5EQidJUZOx3hAxeq1fsOGYPetfEHfZqzputs7n4Z1pqMAI
	kJO40C2Z/q9BKlFlfxu+e9tJxkyb5QP6iQ==
X-Google-Smtp-Source: ABdhPJzcNBp1GRiu0BX1GjnFwem53KX8cuoQGelVNzb61cCdPgEM2dz2frU/X62QqGxh9aqVoFR+yw==
X-Received: by 2002:a5d:4f12:: with SMTP id c18mr18106110wru.242.1623078219415;
        Mon, 07 Jun 2021 08:03:39 -0700 (PDT)
Return-Path: <pbarker@konsulko.com>
Received: from alpha.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id l2sm15995488wrp.21.2021.06.07.08.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 08:03:38 -0700 (PDT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [PATCH v2 2/4] asyncrpc: Set timeout when waiting for reply from server
Date: Mon,  7 Jun 2021 16:03:33 +0100
Message-Id: <20210607150335.32326-3-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210607150335.32326-1-pbarker@konsulko.com>
References: <20210607150335.32326-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 lib/bb/asyncrpc/client.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/bb/asyncrpc/client.py b/lib/bb/asyncrpc/client.py
index d917ab597..3eb4fdde8 100644
--- a/lib/bb/asyncrpc/client.py
+++ b/lib/bb/asyncrpc/client.py
@@ -11,13 +11,14 @@ from . import chunkify, DEFAULT_MAX_CHUNK
 
 
 class AsyncClient(object):
-    def __init__(self, proto_name, proto_version, logger):
+    def __init__(self, proto_name, proto_version, logger, timeout=30):
         self.reader = None
         self.writer = None
         self.max_chunk = DEFAULT_MAX_CHUNK
         self.proto_name = proto_name
         self.proto_version = proto_version
         self.logger = logger
+        self.timeout = timeout
 
     async def connect_tcp(self, address, port):
         async def connect_sock():
@@ -70,7 +71,11 @@ class AsyncClient(object):
 
     async def send_message(self, msg):
         async def get_line():
-            line = await self.reader.readline()
+            try:
+                line = await asyncio.wait_for(self.reader.readline(), self.timeout)
+            except asyncio.TimeoutError:
+                raise ConnectionError("Timed out waiting for server")
+
             if not line:
                 raise ConnectionError("Connection closed")
 
-- 
2.26.2

