Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web12.32701.1612180418809286622
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Feb 2021 03:53:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ZINNALm6;
 spf=pass (domain: konsulko.com, ip: 209.85.221.42, mailfrom: pbarker@konsulko.com)
Received: by mail-wr1-f42.google.com with SMTP id q7so16218278wre.13
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Feb 2021 03:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8ZNEVG3XAYcpRUs49lMzB51nuCUi/WGWP+Mua8EDfC4=;
        b=ZINNALm6huCMIWv2Oa5L7U8meZo4zw4v0iLrtwsPP2hr3q9sTE2LBHFmnibIYHWVoQ
         13IOpF/Ut2BBQsW4bjUaiNTmywGeiYxkArpKQAi6FIgh/83UyLDA67AWaju/qq4J3+ds
         U5AGd+8+dkqPPG3TH5IHEjNELUv/e9L9i+tqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8ZNEVG3XAYcpRUs49lMzB51nuCUi/WGWP+Mua8EDfC4=;
        b=QAvzMAMm7Qa1fqWPirwoSojHuvgBWonZWtwQiCUq7/9KeZaosIl28ATwZX673Ldrtf
         DQskQ4AwYP1yV24k3Jn/NkVPAfv/d/Znv0cvaKwXCm92ST4K+vPIFfuyMtZNvJevH4u7
         /eM795QhwPB73nmk6JCUUPBrjOfh/VhvpKzKq/EE4xYQvy9t3xTmFQN83Z2pk51/TADT
         xVBW8o62plL8DCMpQRF0qLBOgY2MYU0b6Z4maRTbdn3SC/X0GbX5ebvfKBHpLsCAINcU
         X4TgTcnYC7fJtjTsSToqPuM4K9F3BhV1e3ptgWfYSay6ZX95rxwgyYJrfMV5taeK7FfF
         HwlA==
X-Gm-Message-State: AOAM532GyvrXCIWKPO77K+PwLg57WQUbsCmlDG4XIR1UngydkpsBnehH
	rSwOzCUpdEltGyfYMnCsLR9aTtVVatdCzWEA
X-Google-Smtp-Source: ABdhPJxdAlXN3CLZ1EGpWfZ9z8Xh5WlhB06qciA9oD6Hyss/9fFNueCYTfTR0gBkYBAf+hMqECs74w==
X-Received: by 2002:adf:ed02:: with SMTP id a2mr6563491wro.197.1612180417221;
        Mon, 01 Feb 2021 03:53:37 -0800 (PST)
Return-Path: <pbarker@konsulko.com>
Received: from tortoise.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id u6sm28120514wro.75.2021.02.01.03.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 03:53:36 -0800 (PST)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [RFC PATCH 3/8] hashserv: server: Fix logger.debug calls
Date: Mon,  1 Feb 2021 11:53:26 +0000
Message-Id: <20210201115331.13510-4-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210201115331.13510-1-pbarker@konsulko.com>
References: <20210201115331.13510-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first argument to debug calls in bitbake should be a debug level.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 lib/hashserv/server.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index 3ff4c51cc..fa0d3410b 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -168,7 +168,7 @@ class ServerClient(object):
 
 
             self.addr = self.writer.get_extra_info('peername')
-            logger.debug('Client %r connected' % (self.addr,))
+            logger.debug(1, 'Client %r connected' % (self.addr,))
 
             # Read protocol and version
             protocol = await self.reader.readline()
@@ -212,7 +212,7 @@ class ServerClient(object):
     async def dispatch_message(self, msg):
         for k in self.handlers.keys():
             if k in msg:
-                logger.debug('Handling %s' % k)
+                logger.debug(1, 'Handling %s' % k)
                 if 'stream' in k:
                     await self.handlers[k](msg[k])
                 else:
@@ -273,7 +273,7 @@ class ServerClient(object):
             row = self.query_equivalent(method, taskhash, self.FAST_QUERY)
 
         if row is not None:
-            logger.debug('Found equivalent task %s -> %s', (row['taskhash'], row['unihash']))
+            logger.debug(1, 'Found equivalent task %s -> %s', (row['taskhash'], row['unihash']))
             d = {k: row[k] for k in row.keys()}
         elif self.upstream_client is not None:
             d = await copy_from_upstream(self.upstream_client, self.db, method, taskhash)
@@ -307,11 +307,11 @@ class ServerClient(object):
                     return
 
                 (method, taskhash) = l.split()
-                #logger.debug('Looking up %s %s' % (method, taskhash))
+                #logger.debug(1, 'Looking up %s %s' % (method, taskhash))
                 row = self.query_equivalent(method, taskhash, self.FAST_QUERY)
                 if row is not None:
                     msg = ('%s\n' % row['unihash']).encode('utf-8')
-                    #logger.debug('Found equivalent task %s -> %s', (row['taskhash'], row['unihash']))
+                    #logger.debug(1, 'Found equivalent task %s -> %s', (row['taskhash'], row['unihash']))
                 elif self.upstream_client is not None:
                     upstream = await self.upstream_client.get_unihash(method, taskhash)
                     if upstream:
-- 
2.26.2

