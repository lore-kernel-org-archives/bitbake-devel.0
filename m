Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779A7C61DDA
	for <webhook@archiver.kernel.org>; Fri, 28 Aug 2026 15:59:56 +0000 (UTC)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4200.1787932788448865750
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Aug 2026 08:59:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=FyXRdZXr;
 spf=pass (domain: gmail.com, ip: 209.85.210.52, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7f434cc1c5eso1163834a34.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 28 Aug 2026 08:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787932787; x=1788537587; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=24w7ijzTwTc0o1o+lkilFFejitrP11DCTbSdBpCLG8s=;
        b=FyXRdZXrGxJ/Itajp6aVk+JG7b5ZDMvNivJu0xUYYVVnnhtoFwK685tZz4w9/zLZ7G
         JA2EY04vDmvIvKIH0rPR50KWE+4LAI8CE8na55UvaBYww6LHxJ9OqkERBGuj9gmorv1H
         5SeqXxX0PWUDZGUOXhR+Ot3U192exRRY668/DYlTQiHdhlZdNQeX+X5Jk7Ctfy0qUzA8
         75ko9AFdv3kjTOZgoqwFGJXVpkB2dO86SluxoNEmbLs3BlbcW+zTT1qz0t4UKhOqHGnI
         iIEuwi8GTrHymZnClv3ST/7RGvdraERqN012uvQeicLKdwKK0tUFm3T02rb2/NDZzS4E
         s+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787932787; x=1788537587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=24w7ijzTwTc0o1o+lkilFFejitrP11DCTbSdBpCLG8s=;
        b=B640rYLsjx+dbMCDrnrDRfTiITP4Mflo8scDWoblskL2/4vSxg7AIn5qsfX1epwwfO
         QLDzJYPqo8Vxpv9fr+llz3654rddHBkH5xZ23wQ0hS/Sm7dHLPpybk7MXQr9itzanyrN
         /3KJevzqHe86fD+rfXvlhO8CyhcbXfVC0fZEqnXDTfYODkAhW0gB/4WH81DOKv7ff5bg
         7NVvzNBuw1Bbx8dfAu1cCrnY3CdziJ0+EHG+7kN5YgwFy9l4iJEHSe+PC/R9guztdN2i
         3Kk9yGq1YWeh1IBBi65OQX4SPGKDRXd4m6g26b98yjlPa8MGtmsNGh5BAGq+f9rxZ+63
         OEZQ==
X-Gm-Message-State: AFuF++mDpiUtAwXhSPZcmG+nHbL1b1BoRrXrSeHt7TpQcfuFvjYU22th
	EnH1V/bSnWj2nI2zvwbSn4jcuDxa1gWXv77VfqF95FO0DJScEwhIeohMWU8hKg==
X-Gm-Gg: AR+sD11Uf6eAso+izmavrVXNf0kC2kxnHePbBwMX/p63q+dQpRxSULPhBO1NG3qsQTf
	Z3fkrfqA6Iv7EIp1Lih+n0nZHRuTafCPzCNO4AGOuQRNLJyxNK/Q+3bJk/PY1fueCm5TbFDz7eX
	pwyGwz7REuygjK0iAcaS+xqvbfELNNdM2rDwq08iEdm22iTFxxYIp6uV+snTdGPo+pXOq2nvddc
	eE0gayXm0QYHttcAyiIJiXhL1k7SApL/Pe1tn7lRrZ1HSF1d+YGwrmmqfpCuX3+FCcIhdbLncGp
	b56CEjby01bqT2XfCZ5/1XirfWx6+5rLSd0uUJZVAcaQJIdSFlHSXdHAx+0S8V4Tx6vArnn75yn
	8osKiUovQKPEHYWM65yzBodPyjOu4dMPR42PzA8EgU4DDABjizKwQpH8oXTQtEj9tD/KsCxWEAI
	p30Y9xjBxy1XLfuKh4uLEctt6YFrGPMDtNwW/4mm1cK5oA95grwx+t0J8Wjs4yQPAqKgLn
X-Received: by 2002:a05:6830:2106:b0:7e7:8dc0:3951 with SMTP id 46e09a7af769-7f4f228d83emr10529994a34.8.1787932787539;
        Fri, 28 Aug 2026 08:59:47 -0700 (PDT)
Received: from localhost.localdomain ([2601:283:4b01:ba50::50d4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f4fa96ce0dsm1506165a34.13.2026.08.28.08.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 08:59:47 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v3 03/11] asyncrpc: serv: Cancel all clients on server stop
Date: Fri, 28 Aug 2026 09:58:10 -0600
Message-ID: <20260828155942.1219468-4-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828155942.1219468-1-JPEWhacker@gmail.com>
References: <20260730183254.793698-1-JPEWhacker@gmail.com>
 <20260828155942.1219468-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 28 Aug 2026 15:59:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20109

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
2.55.0


