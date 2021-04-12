Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web09.30747.1618227722221298843
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Apr 2021 04:42:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ZenHuqSU;
 spf=pass (domain: konsulko.com, ip: 209.85.128.45, mailfrom: pbarker@konsulko.com)
Received: by mail-wm1-f45.google.com with SMTP id w7-20020a1cdf070000b0290125f388fb34so6002348wmg.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 12 Apr 2021 04:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ItZvSAd5O2IYbjQ7E6a5lc01k6WOOb/gdBtxAkwunBo=;
        b=ZenHuqSUCf4I+kjZ70I1casiFkXVYF4nUOYcghLE5b0P2JyGYIZ95FheoyIQKzyDmn
         9iZ6O/23oEDGLjqW16O/9Bd4VdGAmTRuL58bsbTS0W/eAXchvjwV5+dgL+BebfFVJrW/
         pssRROHvEKRwSGSfaWSLmzt/i4buLh2RWTzXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ItZvSAd5O2IYbjQ7E6a5lc01k6WOOb/gdBtxAkwunBo=;
        b=N97YfvWjQXXFoRRaY7WDjAnMD03VKy1GJk92i5/bBsdVBbbefxi9EdpZddt+GD58Pu
         4p/k7jEqhEZrPnYdM0cmJWlpcZXfmchZey2yrAFx1t7BSstTYOK0c1dko4kksO1+o0GL
         iGtDtQwCR6jTCTDPL3OousyJYJD3D2cpS1KFx3R/X0rsu+h2ICs6xR5qJVZ0p2k+du3i
         CEBEa/eJRybTcktW9/Kc0lzYi21kV2S2Ddx5b0Sj4StXItHdYjuRIiH2862F52lCMj9P
         4I+n2Hb9HTqp3ep29tAZAGmmY1hV+DbgagegPxdXghOAwB96h9ItC0Wv7DWBrUTaLTY3
         e2OA==
X-Gm-Message-State: AOAM530D7kvU6M9ZR3Ucq6RW59re/oweuojAn9Bjj/i152WiPH+wwHj1
	oo09T+urZdDJDPOyGaC+ncszkZta/vetaw==
X-Google-Smtp-Source: ABdhPJy7N8nPGC4gqykKzEGrlNujQNoWw5tpsYg2aACniygXbVG+QblWjN2q0lJuLaE67kdGLfbFGg==
X-Received: by 2002:a05:600c:987:: with SMTP id w7mr7887015wmp.64.1618227720666;
        Mon, 12 Apr 2021 04:42:00 -0700 (PDT)
Return-Path: <pbarker@konsulko.com>
Received: from alpha.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id 3sm17931294wma.45.2021.04.12.04.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:42:00 -0700 (PDT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [RFC PATCH 05/11] asyncrpc: Add ping method
Date: Mon, 12 Apr 2021 12:41:43 +0100
Message-Id: <20210412114149.4750-6-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210412114149.4750-1-pbarker@konsulko.com>
References: <20210412114149.4750-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This method is needed to support startup of the prservice. As it is so
generic we can add it to the common asyncrpc module.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 lib/bb/asyncrpc/client.py | 7 ++++++-
 lib/bb/asyncrpc/serv.py   | 5 +++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/lib/bb/asyncrpc/client.py b/lib/bb/asyncrpc/client.py
index 4cdad9ac3..79919c5be 100644
--- a/lib/bb/asyncrpc/client.py
+++ b/lib/bb/asyncrpc/client.py
@@ -103,13 +103,18 @@ class AsyncClient(object):
 
         return await self._send_wrapper(proc)
 
+    async def ping(self):
+        return await self.send_message(
+            {'ping': {}}
+        )
+
 
 class Client(object):
     def __init__(self):
         self.client = self._get_async_client()
         self.loop = asyncio.new_event_loop()
 
-        self._add_methods('connect_tcp', 'close')
+        self._add_methods('connect_tcp', 'close', 'ping')
 
     @abc.abstractmethod
     def _get_async_client(self):
diff --git a/lib/bb/asyncrpc/serv.py b/lib/bb/asyncrpc/serv.py
index cb3384639..fd91aa71a 100644
--- a/lib/bb/asyncrpc/serv.py
+++ b/lib/bb/asyncrpc/serv.py
@@ -28,6 +28,7 @@ class AsyncServerConnection(object):
         self.max_chunk = DEFAULT_MAX_CHUNK
         self.handlers = {
             'chunk-stream': self.handle_chunk,
+            'ping': self.handle_ping,
         }
         self.logger = logger
 
@@ -123,6 +124,10 @@ class AsyncServerConnection(object):
 
         await self.dispatch_message(msg)
 
+    async def handle_ping(self, request):
+        response = {'alive': True}
+        self.write_message(response)
+
 
 class AsyncServer(object):
     def __init__(self, logger, loop=None):
-- 
2.26.2

