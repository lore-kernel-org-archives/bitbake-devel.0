Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web08.6811.1612524380033195741
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Feb 2021 03:26:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=T4799/g8;
 spf=pass (domain: konsulko.com, ip: 209.85.128.41, mailfrom: pbarker@konsulko.com)
Received: by mail-wm1-f41.google.com with SMTP id 190so5741857wmz.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Feb 2021 03:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8ZNEVG3XAYcpRUs49lMzB51nuCUi/WGWP+Mua8EDfC4=;
        b=T4799/g8cE28SpY1Ejr59k6YZkZWClRRGC4NJZfcVVNPfNdsLrKv0ulb7hyH0uPs7I
         hT65XcVshdivG1hOn2+ARSYbNcfCN0vRKzec0ZHGi05leKp2qyUFDzzWKn42/NafPEdT
         5gOpH+AprS0nUXPexptj+fnpMRpYFEePZ/tpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8ZNEVG3XAYcpRUs49lMzB51nuCUi/WGWP+Mua8EDfC4=;
        b=KOBPkkWH5Wah/bQhaUyZDYdMg4d6zz2Lz1B7LAbF9w0tw+1OlIuTxW+eN5rubKY2Ek
         OML2qJUN7vIOg0MOs0a/uITP8wrH/RTt8GdF+H4Qsugij2q7VQuKGTOWEFnEzBRRzLiN
         uZdm4DkpfJ5hVm74oMyPKjNv+4Eiy8WjVULoNsRuKCN09p441yLwSWFxEO0XaaBpgHgO
         2NDvt7W3L4pEvjf7NDfRheoaJjCmC58eRGuGqsgRiuUEIl/kzv2wwtsd+qpGBLX0NJnd
         rgiC2ISbWkkM5BLd9qCCBifOJqN8FGf+8Jx2uSkouYEk6dLeiCJ15JEuk6bHdyJIwR6j
         xyVQ==
X-Gm-Message-State: AOAM533HIrfCAHQ5anxHF/tEUeSKMOmp0jPPYiqOkHW0aRXOUkO5k+Zt
	Y661HMOB74R54dz/y0iHL/iI4ASjO3cm1HtD
X-Google-Smtp-Source: ABdhPJykNnLeHbE27TeXKsjUm8ItAOi51K7bRAmXCaLWFJBzCophJgQJNwu5h2fbtLA+DJ8bs7rT5g==
X-Received: by 2002:a05:600c:190c:: with SMTP id j12mr3276135wmq.16.1612524378361;
        Fri, 05 Feb 2021 03:26:18 -0800 (PST)
Return-Path: <pbarker@konsulko.com>
Received: from tortoise.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id y18sm11881716wrt.19.2021.02.05.03.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 03:26:17 -0800 (PST)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [PATCH v2 3/8] hashserv: server: Fix logger.debug calls
Date: Fri,  5 Feb 2021 11:26:06 +0000
Message-Id: <20210205112611.17167-4-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210205112611.17167-1-pbarker@konsulko.com>
References: <20210205112611.17167-1-pbarker@konsulko.com>
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

