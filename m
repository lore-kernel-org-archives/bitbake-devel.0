Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EFFC04FFE
	for <webhook@archiver.kernel.org>; Thu,  2 May 2024 14:20:16 +0000 (UTC)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
 by mx.groups.io with SMTP id smtpd.web10.6622.1714659615813684031
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 May 2024 07:20:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=CnqNAzya;
 spf=pass (domain: gmail.com, ip: 209.85.166.47, mailfrom: jpewhacker@gmail.com)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7dedc577011so150123739f.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 02 May 2024 07:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714659614; x=1715264414; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w0trQ3AOWIEaOHOp30ezgWJZLTjssNX8XbKwknuWTN8=;
        b=CnqNAzyaJq9N9V1dgqnY1OQyrTvCL2bQAUbyocXyzG6Wgxb1goQAWs4SyDXkzLsqar
         DwlxxTdnT0qfFNsMUq+rggJc0EmW6nRVD8zJTKa7iAuhkZ1TcBbk2PPYSk+YJxkkN0yf
         m2rBUTzvGPQcB2AaWpFe5GJHJPOpMSPvCJ03qjNqbs1CEBQXl+a9qkx3mWPuT8e9FHQy
         O5WJwJ95+ly2ObMavxGYBhribrOMU6TV0tS2zn71ifLhyac/3IkMPcm1xkIrSRMvCSS/
         T0gKT0miColao9IR3HwMbwviR0hPJcfvTHG9WxVpBM5PAUkBB+Pu/vxDan+uFAbqwwKg
         sIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714659614; x=1715264414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w0trQ3AOWIEaOHOp30ezgWJZLTjssNX8XbKwknuWTN8=;
        b=em6M7tfgt51Q77ELrEsBjW3diEdQGucDF2ymsRen2EkJR095VEBrJ8ULEqPdXrBIqr
         qw+JYNzSD9olbJjAEas++Sj0aiMncWTlOhmytm1LNUJIxSuqYZpM/LBoBtMkDFXW3UXg
         cF1+a5OhLPs5cbaz18UZunL9Ysb/vZBpEdkeNfF11Ji3DYIqwPcft0awg7IiDgdfySQI
         JCzNV9w0igBzDcRq6EN9SOuQtWxPkKZUlVhyERvzztns1U9tNioKX06EFK7UZVF3ZEZ+
         r5f9hDdWKfiWUDJeN3NV9PZan+98oGYCW+7FudUqgz7m6wWNpWkfqlfApBib/1keT+52
         Q5BA==
X-Gm-Message-State: AOJu0Yxu6J4cMLqHFz7iGrlNqhEX51VTbqXrC7Hl+Fkf2suxTpNUCi9l
	R5+YfR3HT+mxaaOlWyXLCrcNEWJ2wdTuzsuPRKsmmfnlXimSk+MpzLdm4Q==
X-Google-Smtp-Source: AGHT+IFa2FaOPfWAQdnkzc6VB6KW8U9kHk1lZW15Dovb6JuxSdO1FdPTqxB59cLmx0Wh3y1eXce6QQ==
X-Received: by 2002:a6b:650b:0:b0:7de:ab07:6a4a with SMTP id z11-20020a6b650b000000b007deab076a4amr7007377iob.6.1714659613876;
        Thu, 02 May 2024 07:20:13 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::d802])
        by smtp.gmail.com with ESMTPSA id j11-20020a05663822cb00b0048813dbf4c2sm228929jat.156.2024.05.02.07.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 07:20:11 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] cooker: Use hash client to ping upstream server
Date: Thu,  2 May 2024 08:20:02 -0600
Message-Id: <20240502142002.1138009-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 May 2024 14:20:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16180

The cooker attempts to connect to the upstream hash equivalent server to
warn the user early if it is misconfigured. However, this was making the
assumption that it was a raw TCP connection and failed when attempting
to use a websocket upstream server. Fix this by creating an hash client
and using the ping API to check the server instead of using a raw
socket.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/cooker.py | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index c5bfef55d67..25b614f1e44 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -315,11 +315,10 @@ class BBCooker:
                 dbfile = (self.data.getVar("PERSISTENT_DIR") or self.data.getVar("CACHE")) + "/hashserv.db"
                 upstream = self.data.getVar("BB_HASHSERVE_UPSTREAM") or None
                 if upstream:
-                    import socket
                     try:
-                        sock = socket.create_connection(upstream.split(":"), 5)
-                        sock.close()
-                    except socket.error as e:
+                        with hashserv.create_client(upstream) as client:
+                            client.ping()
+                    except ConnectionError as e:
                         bb.warn("BB_HASHSERVE_UPSTREAM is not valid, unable to connect hash equivalence server at '%s': %s"
                                  % (upstream, repr(e)))
 
-- 
2.34.1


