Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.5640.1622191337655867250
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 May 2021 01:42:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=DBvnofDS;
 spf=pass (domain: konsulko.com, ip: 209.85.128.50, mailfrom: pbarker@konsulko.com)
Received: by mail-wm1-f50.google.com with SMTP id n5-20020a1c72050000b0290192e1f9a7e1so1932996wmc.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 28 May 2021 01:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ItZvSAd5O2IYbjQ7E6a5lc01k6WOOb/gdBtxAkwunBo=;
        b=DBvnofDSKtW6TR1mmij35un3d60OYTFgVlK7NGFdMNE9qhalPPlYmP9ehmPWpsXOB8
         zu9RRwZ5LKBgJM+59XXY6FOXMQK2OKiReLDs11jJON8/BNaZFVYeSPLAKCxBPqEOKt//
         BR3Af3z/Kqdd6fhkVU/MbrdvX+EdCCAZNDlZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ItZvSAd5O2IYbjQ7E6a5lc01k6WOOb/gdBtxAkwunBo=;
        b=NUUDou0CF2D5cKUT+PS4T2Q243y1h0GAZ+IzKnJxcWcJXDNg9Q7Kd4MAmGTLxiK2J9
         vlOxHhmNj+KO62p81dTWErF9kCnK2gUceaH3t2xYjaeP0LGXgfMRD7xjv5nXKEvVoaSv
         p6CqaVJGRRLvmG6HlE5KGEzGkMC6wupgOrz+LEt3Fe2gBJN7xhFyXiAjVA48mx3M48pt
         SPfYGGbMSTcXT+E9RPoY5TGpBQjyy1WTHpWcVUgabFhy3kRlBJfIDAHg7w8Tlu6BkCzW
         cxOLgeCM5+U2Vkq5+n1EAseyvc9GmPB0MfvNAMz6cSE/khDFLeBJRlL8Ez+BPGjMAYL7
         1ueg==
X-Gm-Message-State: AOAM530Y2IolqSUeKiuA1fdjPtER02/EAaM8IozZRPlDJVNTYAy/KYqL
	NV3eSmuH96KivHva3pVZB6yY55ETTe45ig==
X-Google-Smtp-Source: ABdhPJwkBATeacsxENMvHQ7MS4owZQ+C6O31HFo+isrXFx083baF+yjiY1GLz/AiVc7yKyDkQ/QvgA==
X-Received: by 2002:a1c:4e11:: with SMTP id g17mr12471999wmh.185.1622191335595;
        Fri, 28 May 2021 01:42:15 -0700 (PDT)
Return-Path: <pbarker@konsulko.com>
Received: from alpha.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id o17sm4596385wrp.47.2021.05.28.01.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 01:42:15 -0700 (PDT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [PATCH 1/4] asyncrpc: Add ping method
Date: Fri, 28 May 2021 09:42:06 +0100
Message-Id: <20210528084209.8408-2-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210528084209.8408-1-pbarker@konsulko.com>
References: <20210528084209.8408-1-pbarker@konsulko.com>
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

