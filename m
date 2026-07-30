Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A7FC55174
	for <webhook@archiver.kernel.org>; Thu, 30 Jul 2026 18:33:06 +0000 (UTC)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18818.1785436379523788690
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Jul 2026 11:32:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=XDp2zmsc;
 spf=pass (domain: gmail.com, ip: 209.85.167.170, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4a427e628a9so91907b6e.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 30 Jul 2026 11:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785436379; x=1786041179; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NDFCp80fnVzRsGRXZ7ucLzC6zLtSq5ASKZf+80e9RvA=;
        b=XDp2zmscYJ3UaV1LfM5Wh7JPygsH78G3i2hZ6R9f1oK1Mfwn3lzs1AFWEAB5o8fXDB
         pPl7SJxZ5RKQp1y7X3igzS2LFIqTIpoTxRCAAMO/cTNMsbTrRX+/zKD4xc5rehdw/62P
         xaldjOAZUOLcITmx7fExEt2yPhYyG4zZRVFRRcBfh4a4J6DrOKBYL8eu63wPFZ4QUDyw
         0ltMVzxR3e3k7YtEaSUsjFZpNyLnFY3Z+8IfxROV10i3jUBTuSvBMW9FHGsbkrC+6DIj
         Vy24zm8Qg7lHScWGlDeJJ/BhfZ3OmTxJUq+f4SQcDyE1EClh1QF6G1Srid7GTo0DhDHt
         OR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785436379; x=1786041179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NDFCp80fnVzRsGRXZ7ucLzC6zLtSq5ASKZf+80e9RvA=;
        b=gv3YLuX0gNl6cP8osk95dexUl0V3dD4vq3h+0Wb1mjR6UmmcHhNO2cNiRYB3PUU+9W
         SzoN+y8FNiThHgolB9r0r367Ayk7yo6yTTg0+xqDBzVR5o9uQFvQrnIDQlEzcZSojTa+
         13Qi7g3lWN+KEH/hJ/G4rpr45JXDxpfig8b1zvRVsD/Lo6R6J41zdeMHwCcDje39U1dO
         GXP+fiMGrXdwB723GVVtxPR54ZNFPbr0a9e1GX1SbZzXEVjruSRg0r7mGDNOXgZPKFrD
         c3GbLWZLvxuP2IHViHL3kqc//QxaI+XxLCCtpryURYARKaDcxrZ0hRnZXrJo5QnmpxbT
         nFDA==
X-Gm-Message-State: AOJu0YxDrEaIDdasyl4/g+fFGBEAMfnkhwbq+jSvcLQP8tD5DXMGyBr7
	5zIh+7QMNLBXaUjm82KK5czqs7BrKYV6DPFJPSMBcIXTvVH/CruEv2vYI+y97w==
X-Gm-Gg: AR+sD13MAQOtP9SF6RWGBCy4EuoQXyRi9iXKboecnBQGQHMFkcQNT0Ck8zo6r8rGqt/
	ItO3yX6Q6YUio4bPOTpfLtDZZylKkwxqqJWdwI3cSaGUDrlRY1hk+03mvnnezGktzM/iSw6EOc1
	bxkRbjJ8kYDK4H0Fk5Y5GrqETgslTcXqPvP2swkb78+VsMzb90xgFa04thDuDey/UDKuLkz3x1A
	Z20rbAOIvXHjiJipcXJIaFv0kH2wnuwqn/p08NRR4TosNGgtUdmLLxOSwzQsB7bbDd07XYFcce/
	LZgC0qXziq6oAZEmi8RMg0o8rQTA+mAnvd7E/8HUO/VBjAkQTvd/sG98ZpKdyhoVAx1LPXWKgZz
	4unkxS2kGaJ5nWsktFmxVrGqGwlevkOx+FyEKW9MtqzyTPU+hrDZeBfp6opEXsd0ZB6ly6udYCR
	osn9LnQ22W4Bxv1sqzjBfeRpsVq9t77UCuFoid4YWi5JdvbRETwspUrM1lFQ==
X-Received: by 2002:a05:6808:f14:b0:496:2b3:ae71 with SMTP id 5614622812f47-4ad8775789dmr2861803b6e.18.1785436378563;
        Thu, 30 Jul 2026 11:32:58 -0700 (PDT)
Received: from localhost.localdomain ([2601:283:4b02:22d0::10c9])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ad6efc5c3fsm4593047b6e.13.2026.07.30.11.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 11:32:58 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v2 03/10] asyncrpc: serv: Cancel all clients on server stop
Date: Thu, 30 Jul 2026 12:30:56 -0600
Message-ID: <20260730183254.793698-4-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730183254.793698-1-JPEWhacker@gmail.com>
References: <20260724212822.1165552-1-JPEWhacker@gmail.com>
 <20260730183254.793698-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 30 Jul 2026 18:33:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19883

When the server is stopped, all clients should be stopped, otherwise the
server will hang waiting for a disconnect.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 lib/bb/asyncrpc/serv.py | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/lib/bb/asyncrpc/serv.py b/lib/bb/asyncrpc/serv.py
index d3b1c6c35..dd77ed0a4 100644
--- a/lib/bb/asyncrpc/serv.py
+++ b/lib/bb/asyncrpc/serv.py
@@ -56,7 +56,7 @@ class AsyncServerConnection(object):
             if not client_protocol:
                 return
 
-            (client_proto_name, client_proto_version) = client_protocol.split()
+            client_proto_name, client_proto_version = client_protocol.split()
             if client_proto_name != self.proto_name:
                 self.logger.debug("Rejecting invalid protocol %s" % (self.proto_name))
                 return
@@ -123,6 +123,7 @@ class StreamServer(object):
         self.handler = handler
         self.logger = logger
         self.closed = False
+        self.clients = []
 
     async def handle_stream_client(self, reader, writer):
         # writer.transport.set_write_buffer_limits(0)
@@ -131,10 +132,16 @@ class StreamServer(object):
             await socket.close()
             return
 
-        await self.handler(socket)
+        self.clients.append(socket)
+        try:
+            await self.handler(socket)
+        finally:
+            self.clients.remove(socket)
 
     async def stop(self):
         self.closed = True
+        for socket in self.clients:
+            await socket.close()
 
 
 class TCPStreamServer(StreamServer):
-- 
2.54.0


