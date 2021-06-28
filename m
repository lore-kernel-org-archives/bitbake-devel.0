Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web12.6943.1624853643846498167
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 27 Jun 2021 21:14:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=A8XF14y3;
 spf=pass (domain: konsulko.com, ip: 209.85.221.44, mailfrom: pbarker@konsulko.com)
Received: by mail-wr1-f44.google.com with SMTP id u8so6090647wrq.8
        for <bitbake-devel@lists.openembedded.org>; Sun, 27 Jun 2021 21:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SCL+oADbi50D8rsi0eKyH9IcgMvfLxXg3YGQffJv26A=;
        b=A8XF14y3JVDtPFHuMZCVXfUo3TPAK4UK92+lcI1GA37p5JcgonHd1IeJ/zHeNcB6X9
         mkEnAGJJBsNVgoJl2Yzny2GHRAso5WAHeBbfGKXPza8+UYQz/EtI5efVmvMeYxE5cvN5
         UV9G9tH9o4/dHCEPqa7RtuGViNjZDzVzY0SzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SCL+oADbi50D8rsi0eKyH9IcgMvfLxXg3YGQffJv26A=;
        b=nqS7SRiTWhIJfQ9Zxvw9b53MQ50fXevJcbn2NDRUCIpd16O/ApPv7YJWz+/ePpoBor
         r/695kgXjEeDzobfVrbegOcmHDDwuruzYAkgSH5IHxqVprphbqcKRQEyjwixXVFH9COK
         0LPTa8e8AjtSIY86D0Ji/vbJ1Fmph8fO/c51Hukhlksc/tFz9/CtJi6sMmF7mxIMnYUE
         XK/mbzVxaDpRCp6TB5/SApthJwnUec7acUxDxgpQ6R5EADLIUz8rMxgaL2PPErt33CeC
         RmyDFKvDcblg/3bjfFOPUh8fQbgi8oshCHPcnuehx55mP9w+59beHSDERKz1R9cDMoT5
         lcNg==
X-Gm-Message-State: AOAM531QYLU5sUkVlWBF99qdBDI78PzNq6Y6DjFM22SG1OYBRa7rwyh7
	QQBGEheEdxC41keFqVuTRvdtYZUrG3EbTQ==
X-Google-Smtp-Source: ABdhPJyUBlbPNHEYNk7V73zCvpb/UatH+Yd6ug7dkMaCY44fzUoGhDMcwoqzyOpJmEYET9J98akgqw==
X-Received: by 2002:a05:6000:1c5:: with SMTP id t5mr24976204wrx.71.1624853642249;
        Sun, 27 Jun 2021 21:14:02 -0700 (PDT)
Return-Path: <pbarker@konsulko.com>
Received: from owl.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id b187sm2874590wmh.32.2021.06.27.21.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 21:14:01 -0700 (PDT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [PATCH v3 1/4] asyncrpc: Wait on writers to close with Python 3.7+
Date: Mon, 28 Jun 2021 05:13:53 +0100
Message-Id: <20210628041356.2676-2-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210628041356.2676-1-pbarker@konsulko.com>
References: <20210628041356.2676-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 3eb4fdde8..82b6068ab 100644
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
index ef20cb71d..d6e3df2c5 100644
--- a/lib/bb/asyncrpc/serv.py
+++ b/lib/bb/asyncrpc/serv.py
@@ -74,6 +74,8 @@ class AsyncServerConnection(object):
             self.logger.error(str(e))
         finally:
             self.writer.close()
+            if sys.version_info >= (3, 7):
+                await self.writer.wait_closed()
 
     async def dispatch_message(self, msg):
         for k in self.handlers.keys():
@@ -192,6 +194,8 @@ class AsyncServer(object):
             self.logger.error('Error from client: %s' % str(e), exc_info=True)
             traceback.print_exc()
             writer.close()
+            if sys.version_info >= (3, 7):
+                await writer.wait_closed()
         self.logger.debug('Client disconnected')
 
     def run_loop_forever(self):
-- 
2.26.2

