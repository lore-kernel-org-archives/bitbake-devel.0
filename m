Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057EBC4332F
	for <webhook@archiver.kernel.org>; Tue, 31 Oct 2023 17:22:23 +0000 (UTC)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
 by mx.groups.io with SMTP id smtpd.web10.1631.1698772941213142695
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Oct 2023 10:22:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Gx27AH19;
 spf=pass (domain: gmail.com, ip: 209.85.167.175, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3add37de892so3014147b6e.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 10:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698772939; x=1699377739; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncOBBQVOKSJI4oIEZXme+bBgONZifXz6NgsuiVg1fgg=;
        b=Gx27AH19CqFNkdsNeUI3fNexl61h2m9pUSG7Qtf2RBoP6/7kMNH8ZNtZBgfcMsli5x
         35WUgm1zxjOjHgYP0ccoAayaUm+HksUVwOosjmFoFk2aNAWvdLWdB8ABCBjPo73RwG8Q
         e2029pnkyTz09wQ9xZHBq57gBWe7Hz36AIQ3q4xXZPMwIt8/8a1ZQP27w3DWGPJtA06J
         a89Tk2pSLhFPoK5seuavUDC9yuilBRcmR5FHfWb1Eo314pfF0a5BIe8vIDK141V7w7sk
         U5JQDwu6Bc7GdSaQM2WtgJHOJs/4I8vK5aPcjHirxVBkM2mgvQ2esvAiYYE5LYfNJnKT
         JC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698772939; x=1699377739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncOBBQVOKSJI4oIEZXme+bBgONZifXz6NgsuiVg1fgg=;
        b=Kq1ngZu8tE5a1SY91xY7BXKwPUJ4n5kW6f+xhl3W8YDlk8aSS31Ns7ekkFsi5j5lKo
         tdnQ9FuZUWGt2ZRAMuB9uf+A796awRUTTwMb93WWYPkhiaD6y8g/8gQseAQZmabq+jDT
         qwTg5b6uSzVhUlpFHo7uHxPLWCx/r4ezuqPeH6XoT23UAaAwszOnuYmu3ZxvNh1FQE+r
         KsgJpBw+4RuBea3/OJi1jPf6VQmGFDxCCGSC8496G9xhAGw1KOecipyrPHqsFSctK6/5
         Jb5OcECN28ZXstgV3CDicK2ZxPW3UpbSityDTiAyK06PLmwYosozKETHu60E/9NNsFgd
         gXPA==
X-Gm-Message-State: AOJu0YxcLjCinYjkDhu9vJXJwMlFU+dj7dxsWYmL+sUqz7HRHNbQYZpe
	fRcE1LxMSsFLpTRpkq9++/g7oJ4zZWY=
X-Google-Smtp-Source: AGHT+IF37Id8hNXFQZAym5n4wqamtxOMXL/xc3MpsqpOf7haYcnSh8+Q/6u7dJk5CFdwHqYv4DL/GA==
X-Received: by 2002:a05:6808:199b:b0:3a4:6b13:b721 with SMTP id bj27-20020a056808199b00b003a46b13b721mr13818977oib.46.1698772939475;
        Tue, 31 Oct 2023 10:22:19 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id k6-20020a056830150600b006ce2e464a45sm282503otp.29.2023.10.31.10.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:22:18 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v4 19/22] bitbake-hashserver: Allow anonymous permissions to be space separated
Date: Tue, 31 Oct 2023 11:21:35 -0600
Message-Id: <20231031172138.3577199-20-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031172138.3577199-1-JPEWhacker@gmail.com>
References: <20231030191728.1276805-1-JPEWhacker@gmail.com>
 <20231031172138.3577199-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 17:22:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15369

Space separation is more natural when setting the value from an
environment variable, so allow that here for convenience.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bin/bitbake-hashserv | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-hashserv b/bin/bitbake-hashserv
index 1085d058..c560b3e5 100755
--- a/bin/bitbake-hashserv
+++ b/bin/bitbake-hashserv
@@ -127,7 +127,10 @@ websocket, as in "wss://SERVER:PORT"
     logger.addHandler(console)
 
     read_only = (os.environ.get("HASHSERVER_READ_ONLY", "0") == "1") or args.read_only
-    anon_perms = args.anon_perms.split(",")
+    if "," in args.anon_perms:
+        anon_perms = args.anon_perms.split(",")
+    else:
+        anon_perms = args.anon_perms.split()
 
     server = hashserv.create_server(
         args.bind,
-- 
2.34.1


