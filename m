Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75745C4167B
	for <webhook@archiver.kernel.org>; Tue, 20 Dec 2022 10:07:22 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.47035.1671530832393327016
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Dec 2022 02:07:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=WkYQ3NUX;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so10721461wma.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 20 Dec 2022 02:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UR/6n0fa3oDlXvpXUUPNrYmgk/a4Jps4wswGq3eZ4qQ=;
        b=WkYQ3NUXqzx8YhQzsZjHSSuaNLsnc/P2xPu6JhxI6JoyS+NCZzmLck71ayg7/q7/PQ
         feKTztxB1wpdfkIvsJCjn5mW5pjxoajm2LoYFf9QwmR2eHU/KTUvnn6GXzFG3qb5XrrR
         hU6wB8ZP3NnIzBvpDnDluy+Gf7ZG9Ny/o3SjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UR/6n0fa3oDlXvpXUUPNrYmgk/a4Jps4wswGq3eZ4qQ=;
        b=sVXMZDXlKbd2zIvs3xTFMRXTVtDWNw/L6CvSL7f4AByjrIsg4Q0hna5Yt49ypxHJtc
         QTFIVhGAfqV2g6dMeZzTN78p+2PUXYGEHbtqrWejXo6sn9z/eNurTlHJwKCTYlc7epIH
         J4yyOfKJG6HYfdohSI4Pd6Z96EinFiLzW1RXpVeo4j/GxnUrs0vodGEhmhmyqaWWT+PC
         hMySlXsDimWGYW92KL0ycuOP7if3R0fKZxLOxdIoxad5u7aTLSAo94oRp0eXlxJ3z9Cd
         bpoDPjkE/UguMTXSxb4V/wIy1E0E5t6lHpNBsKPkZ5TOOrDCrXi5iADuxdxJNdweCOqY
         WGMA==
X-Gm-Message-State: ANoB5pmBf+nTQ9noQhIm/Vgbe9Yaz4WS+1daLW/CZIctV4cE6fr8WDJA
	3m5lXhOPseeJ92/0zmtozL4rKbSxexsBY49H
X-Google-Smtp-Source: AA0mqf5Lt9dWDeEny8xBoFXnUY6vUAY9wFID7LUTa4rSIOWloaRuK9MiORx291D8u+p+DY4ArlyV0Q==
X-Received: by 2002:a05:600c:5405:b0:3d0:47c:9fe7 with SMTP id he5-20020a05600c540500b003d0047c9fe7mr34009578wmb.40.1671530830572;
        Tue, 20 Dec 2022 02:07:10 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:1273:dbb7:632c:a9de])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c1d1300b003cf75213bb9sm25464052wms.8.2022.12.20.02.07.10
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 02:07:10 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] command: Add ping command
Date: Tue, 20 Dec 2022 10:07:08 +0000
Message-Id: <20221220100709.402769-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Dec 2022 10:07:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14207

Add a simple ping command so the UI can check the server is still there.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/command.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index c9571f63d8..0208e30ec4 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -166,6 +166,12 @@ class CommandsSync:
     These must not influence any running synchronous command.
     """
 
+    def ping(self, command, params):
+        """
+        Allow a UI to check the server is still alive
+        """
+        return "Still alive!"
+
     def stateShutdown(self, command, params):
         """
         Trigger cooker 'shutdown' mode
-- 
2.37.2


