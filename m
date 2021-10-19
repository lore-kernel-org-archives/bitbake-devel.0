Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC34AC433EF
	for <webhook@archiver.kernel.org>; Tue, 19 Oct 2021 20:06:47 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.web10.15686.1634674006631310705
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 Oct 2021 13:06:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=6jgcAVYT;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.49,
 mailfrom: steve@sakoman.com)
Received: by mail-pj1-f49.google.com with SMTP id
 na16-20020a17090b4c1000b0019f5bb661f9so819990pjb.0
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 Oct 2021 13:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cixD5GXRw1zGTIPzxshDfzgzi0YTDlZnMCR6kY7ZRW0=;
        b=6jgcAVYTfBsxWAVh2xCkQSgTm3r364uofT9htAmwMdCalW0TJ1miEKIYlUAjGNgYtO
         OewyBLXlsd/guoq8nfkDa7C/drHQyJ7rrB1epX/nidzzhtKehVCdUjPUUGcIbcM20vcc
         pZk999t1C8QhewYO8dDeep/Cy6y+8QZLwlooVVD4moPacJfkKAJSp6fVk77EAq9Y2d9J
         5n6Ic+78MuH83ZCr76ZI6uPE4feQsMWv1VcM7Pfn15OUYhHau4Slj/EMKgvZ4o92eOvk
         ghrILukLHK20iuBLFMdIlnus7Zjh9nRy19+MMT0dwP6RBQK3iIW6dEFrTgxVw+Z4+56L
         vVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cixD5GXRw1zGTIPzxshDfzgzi0YTDlZnMCR6kY7ZRW0=;
        b=nUwAx0fB/Ey2YYrSLGT6SWnilsXVL/Vz+3jwHg0ysmy6+n/W5F38CR7KBhnmDo6rmo
         kcon0Hm3lR5YidqYpwdfT3yQ3jqnjfZccZvRZehQKXHxBHV6PUBdDXvusjcBcKyS8kBh
         kSxBJ4veTajH4veetQFphV8AMtZa4bNzCXI0pAO4ZvjvCFqTelKI196YknIo2xOURZyI
         zNOVQeXbY2oN8wXqIeBFCCWdH62et3xc4OQYp60siaQRAbUuRH2HSuE4tHxs4qXk1U63
         1UIZWStfaXUateJD4E+YbxDYkCv0XZrG1dSDtG1h2CDtRrN65u9j349BIP2chLjn0hCj
         r5Kg==
X-Gm-Message-State: AOAM533yA8Qr5+j2HwiVzRVOTYelqV3spZS+5wFUhcFFXmSuttmzKEII
	Fw1pfcoQB2OnCeOLjBDz7W+pC8kjarmZv/Y0luo=
X-Google-Smtp-Source: 
 ABdhPJzwRa1eTZ+7kBJUHkg7WcwbCHgqi+c34pQHo5ssuS76BHwrVSyCw/rqOFG0Tk9v4JmfNr7HvQ==
X-Received: by 2002:a17:90a:17e1:: with SMTP id
 q88mr2088495pja.99.1634674005657;
        Tue, 19 Oct 2021 13:06:45 -0700 (PDT)
Received: from hexa.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com.
 [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id
 l6sm3533562pjy.23.2021.10.19.13.06.44
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 13:06:45 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 8/8] hashserv: let asyncio discover
 the running loop
Date: Tue, 19 Oct 2021 10:06:16 -1000
Message-Id: 
 <4611af5c10d9d838bb0384bebbc647e6cc9f42c4.1634673786.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634673786.git.steve@sakoman.com>
References: <cover.1634673786.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 19 Oct 2021 20:06:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12810

From: Justin Bronder <jsbronder@cold-front.org>

From 3.10 documentation [1]:
    Deprecated since version 3.8, removed in version 3.10: The loop
    parameter. This function has been implicitly getting the current
    running loop since 3.7

This is fixed in master as a side-effect of
cf9bc0310b0092bf52b61057405aeb51c86ba137 which is more intrusive but
likewise drops the loop parameter.

1. https://docs.python.org/3/library/asyncio-stream.html#asyncio.open_connection

Signed-off-by: Justin Bronder <jsbronder@cold-front.org>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/hashserv/server.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index 81050715..56f354bd 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -420,7 +420,7 @@ class Server(object):
 
     def start_tcp_server(self, host, port):
         self.server = self.loop.run_until_complete(
-            asyncio.start_server(self.handle_client, host, port, loop=self.loop)
+            asyncio.start_server(self.handle_client, host, port)
         )
 
         for s in self.server.sockets:
@@ -445,7 +445,7 @@ class Server(object):
             # Work around path length limits in AF_UNIX
             os.chdir(os.path.dirname(path))
             self.server = self.loop.run_until_complete(
-                asyncio.start_unix_server(self.handle_client, os.path.basename(path), loop=self.loop)
+                asyncio.start_unix_server(self.handle_client, os.path.basename(path))
             )
         finally:
             os.chdir(cwd)
-- 
2.25.1


