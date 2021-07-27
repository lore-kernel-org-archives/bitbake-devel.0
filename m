Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.web10.6394.1627353488330281177
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 Jul 2021 19:38:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=CDklmmnJ;
 spf=pass (domain: konsulko.com, ip: 209.85.222.179, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f179.google.com with SMTP id c18so11019259qke.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 26 Jul 2021 19:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EM5J2hFi1dDwA4VFEqOhKH0WXtgwDnr5FqYJ0QSA0ws=;
        b=CDklmmnJS5zjK9XNoFoCFb1QVbGkpplQiITG7jXSkOh49HxyXbTgx3xPItPZO+GisG
         VFwCaEmjCUNI2Bl/oDa0gTfpc7B5iG5wLisRAjbvaiTc42jjhodak9nzih2YxvZTTR8d
         iFTvEwqXZDAuEP62SqSoUOS/TwlsYTrR0phW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EM5J2hFi1dDwA4VFEqOhKH0WXtgwDnr5FqYJ0QSA0ws=;
        b=AaFCAmM6PqfBcH7iwCPEzt5j/edxQwF4yqwZ/80rN2fTcL9gF2uvEL8a7VzFKuIpVT
         Jy8HOdU1W1gu3pdt74vlQiEIbm7sAv+RyTa4zBSpwotO+x9KLodIYTysOZwgyeOFqDX0
         GR4t4TYC4URuTIxZwekaBSZbCNL5cNSO6nHbupmKZXTikKYdUpuRtEeGT8OAwXOgQOWN
         2ERK3AiHj9hnX8aDD2B4mgie/cdpgxYM4231yMbnRvg4/IM6wWBp3bATf6Sl338JwEI5
         E4nsgV2VLfUyD8kLuxxG65beAS7Gw8ZiQ76e/nQk0WkZoASq4KC/Gt+r3MX3j4i/XSOB
         BPbw==
X-Gm-Message-State: AOAM533yKsvnvNgiQw+A0Vibx+9/gc9HdKIp6n/1SNp1RDTHZm5tAF3W
	Iao0Z/AOW5AF6fciISQm9RUxpVMjgSW7fA==
X-Google-Smtp-Source: ABdhPJy1+bkocInVpQnh4YpTbEZ1F7gD+Vwt01yfPu1oh3d3tH56qftTDhh3FSs/+ntN+LOYjeFNuQ==
X-Received: by 2002:a37:ad0a:: with SMTP id f10mr20896181qkm.284.1627353487283;
        Mon, 26 Jul 2021 19:38:07 -0700 (PDT)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (198-84-179-103.cpe.teksavvy.com. [198.84.179.103])
        by smtp.gmail.com with ESMTPSA id h10sm974887qka.83.2021.07.26.19.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 19:38:06 -0700 (PDT)
From: "Scott Murray" <scott.murray@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Subject: [PATCH v4 1/5] asyncrpc: Wait on writers to close with Python 3.7+
Date: Mon, 26 Jul 2021 22:37:52 -0400
Message-Id: <7fbe0a840ad544ec0f4e84a376bae3423da1c7a5.1627352176.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627352176.git.scott.murray@konsulko.com>
References: <cover.1627352176.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Barker <pbarker@konsulko.com>

The close() method of an asyncio stream writer is not synchronous and so
may return before the writer has finished closing. In Python 3.7 the
wait_closed() method was added which can be used to ensure that a writer
has finished closing before continuing. Sadly in Python 3.6 and earlier
there is no way to guarantee that a writer has finished closing before
moving on.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 lib/bb/asyncrpc/client.py | 3 +++
 lib/bb/asyncrpc/serv.py   | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/lib/bb/asyncrpc/client.py b/lib/bb/asyncrpc/client.py
index 3eb4fdde..82b6068a 100644
--- a/lib/bb/asyncrpc/client.py
+++ b/lib/bb/asyncrpc/client.py
@@ -7,6 +7,7 @@ import asyncio
 import json
 import os
 import socket
+import sys
 from . import chunkify, DEFAULT_MAX_CHUNK
 
 
@@ -47,6 +48,8 @@ class AsyncClient(object):
 
         if self.writer is not None:
             self.writer.close()
+            if sys.version_info >= (3, 7):
+                await self.writer.wait_closed()
             self.writer = None
 
     async def _send_wrapper(self, proc):
diff --git a/lib/bb/asyncrpc/serv.py b/lib/bb/asyncrpc/serv.py
index 4084f300..2c219c1e 100644
--- a/lib/bb/asyncrpc/serv.py
+++ b/lib/bb/asyncrpc/serv.py
@@ -75,6 +75,8 @@ class AsyncServerConnection(object):
             self.logger.error(str(e))
         finally:
             self.writer.close()
+            if sys.version_info >= (3, 7):
+                await self.writer.wait_closed()
 
     async def dispatch_message(self, msg):
         for k in self.handlers.keys():
@@ -193,6 +195,8 @@ class AsyncServer(object):
             self.logger.error('Error from client: %s' % str(e), exc_info=True)
             traceback.print_exc()
             writer.close()
+            if sys.version_info >= (3, 7):
+                await writer.wait_closed()
         self.logger.debug('Client disconnected')
 
     def run_loop_forever(self):
-- 
2.31.1

