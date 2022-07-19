Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87CDC433EF
	for <webhook@archiver.kernel.org>; Tue, 19 Jul 2022 18:37:10 +0000 (UTC)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com
 [209.85.210.49])
 by mx.groups.io with SMTP id smtpd.web12.44444.1658255821547066600
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 Jul 2022 11:37:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=djQ+FXwB;
 spf=pass (domain: gmail.com, ip: 209.85.210.49,
 mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f49.google.com with SMTP id
 cb12-20020a056830618c00b00616b871cef3so12371591otb.5
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 Jul 2022 11:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GDVCJrh2sx1K7rwvW8hMLrjDsLUbMcZP8uZQt90UUUs=;
        b=djQ+FXwB9qy4c4Qop5LTjJGlhNQUvKPpt20fXbczQBQQMKSaQVq6himg34EwNn/AhV
         0o6G6GRyAqRYJTUonRAeBzXSG6jox8sgu1Q/RRjKx6Kq0nm/+PhdAlyVldj+ePrs0iEP
         laJTmBaPIYPR79KxMzFECGOJQIT4XsDs0XA5+Yuvy9Rxfpy9EIUBOsSKBDVQZ23SR6fB
         DvnLgUSCeVaosjPNJva9XiRRgxXkwQOKvZpVs4QSNeRlKyzphNGfMtUEDHkQ97ONDujb
         p5NOazYIUdrHIxKeXSeXH2lCuhnZ6v+rER4OMtZ6SRqs14WhVpe0Djxlei8okEK7iEoW
         VZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GDVCJrh2sx1K7rwvW8hMLrjDsLUbMcZP8uZQt90UUUs=;
        b=DroAKehF8KAneXAAd44zE0p0XKAPtVAFknpVWAmTrj/8CTUdLnONx3RMxwT9t7hqAR
         LhZm65ccISEpvO2LwI8veMCX8ZrUtnMlLjjgysWX8PovhZB1nadbjNCJ2EgqTFlGA2Cp
         0tuaU9p/Y/DT10gpOUU+YUyus6MFCkivhL19Nr+FkButz9Dh9lagC4/uP+qZLA4rXWIm
         Bq+Ln9Gh8nX2sIeuW/o8T82Tr/NplKiBIEsx5sOUnMlOGZf4YpQjZd6flHUpt9W1j4q1
         hGA+2X2t7BinLaZuFyB848AW1BVI3jC1UMvaA6WBPhkvzepiXM919AEY+pl5VJp6jShB
         P6fg==
X-Gm-Message-State: AJIora+S3ZMAHheX/Byl8s+nnmZ5LuLl+kPqJfpMDcDOujzW+SqEfU/t
	vy3045mmEGRQfsfIhnqsEunjCRVbPiEqBA==
X-Google-Smtp-Source: 
 AGRyM1v3u6hElCLMVxM2l4FFk9jU63AGllcdSnGTQ75ugGDu6uWTm0Ez6Dx9C2StOl22h6DHtBOAwQ==
X-Received: by 2002:a9d:dc5:0:b0:61c:b51b:3db4 with SMTP id
 63-20020a9d0dc5000000b0061cb51b3db4mr1687037ots.301.1658255820443;
        Tue, 19 Jul 2022 11:37:00 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:ac3d:c100:e3e8:d9:3a56:e27d])
        by smtp.gmail.com with ESMTPSA id
 ca23-20020a056830611700b0061c7adb4006sm6371487otb.13.2022.07.19.11.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 11:36:59 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] asyncrpc: Add TCP Keep Alives
Date: Tue, 19 Jul 2022 13:36:53 -0500
Message-Id: <20220719183653.804775-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 19 Jul 2022 18:37:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13834

Adds TCP Keep Alive support to the async RPC server. This should help
prevent file descriptor exhaustion on the server when client connections
are interrupted and the socket never closes (e.g. no FIN is sent from
the client).

A keep alive is sent after 30 seconds of inactivity, then every 15
seconds after that up to a maximum of 2 minutes.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/asyncrpc/serv.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/bitbake/lib/bb/asyncrpc/serv.py b/bitbake/lib/bb/asyncrpc/serv.py
index b4cffff213..585bc121da 100644
--- a/bitbake/lib/bb/asyncrpc/serv.py
+++ b/bitbake/lib/bb/asyncrpc/serv.py
@@ -151,6 +151,13 @@ class AsyncServer(object):
                 s.setsockopt(socket.SOL_TCP, socket.TCP_NODELAY, 1)
                 s.setsockopt(socket.SOL_TCP, socket.TCP_QUICKACK, 1)
 
+                # Enable keep alives. This prevents broken client connections
+                # from persisting on the server for long periods of time.
+                s.setsockopt(socket.SOL_SOCKET, socket.SO_KEEPALIVE, 1)
+                s.setsockopt(socket.IPPROTO_TCP, socket.TCP_KEEPIDLE, 30)
+                s.setsockopt(socket.IPPROTO_TCP, socket.TCP_KEEPINTVL, 15)
+                s.setsockopt(socket.IPPROTO_TCP, socket.TCP_KEEPCNT, 4)
+
             name = self.server.sockets[0].getsockname()
             if self.server.sockets[0].family == socket.AF_INET6:
                 self.address = "[%s]:%d" % (name[0], name[1])
-- 
2.33.0


