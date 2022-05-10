Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1782C433FE
	for <webhook@archiver.kernel.org>; Tue, 10 May 2022 18:06:33 +0000 (UTC)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mx.groups.io with SMTP id smtpd.web11.611.1652205987756061556
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 May 2022 11:06:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=qh+ldY4G;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.171,
 mailfrom: steve@sakoman.com)
Received: by mail-pg1-f171.google.com with SMTP id x12so15257552pgj.7
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 May 2022 11:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5XhttYXoW9GNle+UOsHsjipgvJ0IppAdGNzM41y3NZ0=;
        b=qh+ldY4GhBtzLph3Vps/Wwtr2Xn8/bunz5rIUVCMRjP2WuZ9P/o2pfVWpbxLDPTZ9C
         o46+w2JZ89Cdu7WXj66AST2cQvMkEnV17HNiEne5aWbvpaiZvgSiLaMSYvwee7FkAKku
         VhqYZnpSZMojsD1mzUNkB5LmsVyd9E5r+l3v+MAqmWMM/ADBqWUkVma9FQ4VGKpjD1fJ
         9AiQwUJLq1FRud8LITlspsfJAujGbctXJenBk6MG3ITPCESlw8bvmirx3Oswr0rf8ibM
         WUqXnl9wXhvsLHUSvS6y27exYYfLaIp/8mL4c1vuISg0R1dRnT9UcOuyZlGoXfH1m12i
         mPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5XhttYXoW9GNle+UOsHsjipgvJ0IppAdGNzM41y3NZ0=;
        b=I1OWVZIFG6GAlg+tkgDQl7VydjpMvYwBAxKQXSqaogOmgv7EJN1eSK+yd8cKNUDWGQ
         9SHZSxnNlW3Po16aAE+Lr3uS8wIB6qsQWepl0/gG7K2ppVX8xjUAj5ODM1eZyBageWC3
         oLt1U38Mqi3dTNexOdmGXWCEfnBYoFcIUrEsrPR3RT4JeZsdfoFpN0bIgTr2ckUBXTfB
         7DtJkeRdSJtHiB4LllRThY7IxuzJ1rIMCL2cEEzdLTcjEXt3Sg6Bf/0qZn7QXfgEi3gY
         sVUXhtun2sEraLPVa7wjagiengKuJwaqFwAshpWEPoVWZVdI9Yaol2afolMFUdIVSE7C
         GuJw==
X-Gm-Message-State: AOAM530OAtMGKgFXRfLc5/Wt25cg9bFqra8bZhR1d7alPI2thaw/xdEd
	zKEtyQ3bYo+bOSKILeQzx7EyiwlXGwEjr/0/
X-Google-Smtp-Source: 
 ABdhPJy7+GM6nKeCYN//XTZRqi8ZKyZSKuH6tqESD4DNg7aitJ3bKWtQpjYXEgUmTdVudp2BYHP65A==
X-Received: by 2002:aa7:83d0:0:b0:50c:eb2b:8e8a with SMTP id
 j16-20020aa783d0000000b0050ceb2b8e8amr21636266pfn.31.1652205986587;
        Tue, 10 May 2022 11:06:26 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 12-20020aa7910c000000b0050dc76281c4sm10846777pfh.158.2022.05.10.11.06.24
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 11:06:25 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 10/18] ui/knotty: Drop pointless pass
 statement
Date: Tue, 10 May 2022 08:05:35 -1000
Message-Id: 
 <db541830aa9d73f278043a08f78f5f59a625b793.1652205806.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1652205806.git.steve@sakoman.com>
References: <cover.1652205806.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 May 2022 18:06:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13690

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 625565087d8c9e7a6a79b0b4f3e5be2d77d5f100)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/ui/knotty.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 3f410fd5..61cf0a37 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -877,7 +877,6 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                     state_force_shutdown()
 
             main.shutdown = main.shutdown + 1
-            pass
         except Exception as e:
             import traceback
             sys.stderr.write(traceback.format_exc())
-- 
2.25.1


