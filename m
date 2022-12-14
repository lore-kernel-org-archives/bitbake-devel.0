Return-Path: <debrabander@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05F3C4332F
	for <webhook@archiver.kernel.org>; Wed, 14 Dec 2022 16:10:25 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
 by mx.groups.io with SMTP id smtpd.web10.107879.1671034215577460599
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 14 Dec 2022 08:10:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=X8IvQP6M;
 spf=pass (domain: gmail.com, ip: 209.85.218.48, mailfrom: debrabander@gmail.com)
Received: by mail-ej1-f48.google.com with SMTP id tz12so23040897ejc.9
        for <bitbake-devel@lists.openembedded.org>; Wed, 14 Dec 2022 08:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7m/bZMlPimqEWSm9wiNPAdNRhH6uRlmGT1Ew+cNCneg=;
        b=X8IvQP6MxgHHGhKARdW6NNVt1DVr4D3nRwYo2WZqI8GlKs8xA/sxrzt21ztZzSGxj+
         /Zisx0UX92eoC+Riyvmge982G09Y5d8+kIEVpOE3DPVjt86MOn76gaI7yl7clV5D968p
         D1uRndl4uoLpKglEZgwx5oOXsLNArwKYThVrb84qbEJnPaYthcMo5y38r01rzKwjLMJ3
         z03yFifwpVovXs0Fa/C37LHDlK1SkZmNWBWezvoAf/AacTUFzHhlvqpeRGZ/L7Cr+xtT
         OQma1MQRK3OSHu8c024C6V95wIrMWYrBp0PSq5BDQBgYWPDRFunSN0Xhmq4I0TAjJYhm
         WGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7m/bZMlPimqEWSm9wiNPAdNRhH6uRlmGT1Ew+cNCneg=;
        b=Jb16U2OFLxa3QquR9pDPolqOv2P9Jvd8qzy2qtdiiVCNHfv0bxYltM+lQgwVmOq07F
         GNx0f2sw7E9vjKfc9KQDAEzDOvHn8Vfgd3Y1P/p6xKJI9eNjdEAbpHa+YrGjOXjCuFqc
         nxt3D+n9904rXkeOH0X1qhPcG4c3oESGIv6j7aLs7oKcSL6fQnKhGmNzT2bo5GpLxZvd
         ydIC29lWsSgGDBao3cPCus6f96ZgvJkfJdjL5txLqqE+B60kjWVkpE9K0RYNhmXKq+cO
         /DJ8mcbOdRmstk6cxV7ENYhB0l+qa3bsuffPGoX1SRuA2rtZErqPEjESkBt9HNz39NjP
         P/iQ==
X-Gm-Message-State: ANoB5pnLwzyLa8yqouRt/z3kcMj5Yynb4y9m2vFBsOIBTQuCi/uqXbGX
	RL6vJtb/N7Vtfq12JlaoRkioeVQ37473Qg==
X-Google-Smtp-Source: AA0mqf6KUTyYzUWmCquaA96Bd7jua+/dZG9A35JrF34Nid8QPvOcI0tVVIb0nrtw8ptQH6SRszi34g==
X-Received: by 2002:a17:906:14ce:b0:7c0:e0d9:c1df with SMTP id y14-20020a17090614ce00b007c0e0d9c1dfmr22602918ejc.10.1671034214051;
        Wed, 14 Dec 2022 08:10:14 -0800 (PST)
Received: from polar.foobar.local (186-153-172-081.dynamic.caiway.nl. [81.172.153.186])
        by smtp.gmail.com with ESMTPSA id f3-20020a17090631c300b007c0aefd9339sm6109304ejf.175.2022.12.14.08.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 08:10:13 -0800 (PST)
From: Frank de Brabander <debrabander@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Frank de Brabander <debrabander@gmail.com>
Subject: [PATCH] process: log odd unlink events with bitbake.sock
Date: Wed, 14 Dec 2022 17:09:46 +0100
Message-Id: <20221214160946.19456-1-debrabander@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 14 Dec 2022 16:10:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14188

Log when the socket file already exists and is removed before
recreating a new socket.

Log when unlinking the socket file failed.

Signed-off-by: Frank de Brabander <debrabander@gmail.com>
---
 lib/bb/server/process.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 44c65451..12498a6c 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -278,8 +278,8 @@ class ProcessServer():
         # Remove the socket file so we don't get any more connections to avoid races
         try:
             os.unlink(self.sockname)
-        except:
-            pass
+        except Exception as err:
+            serverlog("Removing socket file '%s' failed (%s)" % (self.sockname, err))
         self.sock.close()
 
         try:
@@ -543,6 +543,7 @@ def execServer(lockfd, readypipeinfd, lockname, sockname, server_timeout, xmlrpc
 
         # Create server control socket
         if os.path.exists(sockname):
+            serverlog("WARNING: removing existing socket file '%s'" % sockname)
             os.unlink(sockname)
 
         sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
-- 
2.20.1


