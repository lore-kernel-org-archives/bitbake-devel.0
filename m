Return-Path: <jacob.kroon@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E7CC433EF
	for <webhook@archiver.kernel.org>; Thu, 18 Nov 2021 16:27:04 +0000 (UTC)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com
 [209.85.167.41])
 by mx.groups.io with SMTP id smtpd.web08.3990.1637252823086016792
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Nov 2021 08:27:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=LChuSkTF;
 spf=pass (domain: gmail.com, ip: 209.85.167.41,
 mailfrom: jacob.kroon@gmail.com)
Received: by mail-lf1-f41.google.com with SMTP id bi37so28763428lfb.5
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Nov 2021 08:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JUQM5b+7GyVgImNlROSsChsBV6k4KUKRp1GxQD8LJ7I=;
        b=LChuSkTFlJlkbGBDmRHfZK//TP9h+c5mda5rVDpkZVpyGJ6C6r6zz1n7N8KlgJcr8N
         3IFcRBA6lVHHtLWr0uWbn30UmYzdEMhjsbc5+fehv2e8Xzz4rsDrgRnjUrGvSq5DR70J
         8AoAaOuO25R9Us0zIix9k+dx7u+2u28Ze+lgbzxDQIKU++TLVghVgsXBgoKTFpyDYdc1
         P37NXKEjcOK227bI7HODqdcIMStXL+nfEk655Hyg91CMbpDYzx48eqQppqwP7bLC+XC9
         TfzNz0pahpAB+6OBN0XspB0ortx/vrRegiIYKtaPvv3iFR32jNm4CrY7R9NOkKOWcGXW
         ovtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JUQM5b+7GyVgImNlROSsChsBV6k4KUKRp1GxQD8LJ7I=;
        b=yisqvPKmMfbsPNyIZvtlAWwPXp0n07lHIOigtP+QRxy2d/WvVVm7XS4xo3cVjdHNeI
         ELg6EUZ3JTdb9L62lCrg4d/O/XzxEPVIZOAZXZ5l9spQsQs+ySk31hRoJL/ggz6oR7w/
         MriaEUdga0MMw3uEMoyhwS966iqC+NC+UWiilzn23v2/E4yjFVhfK4zfDCObLdRDAx/s
         LQPDAUkPQIQL+dDo06YKqioQJgPjKuUDNSi3U1kFZogapGBTLZiapcJG/JF2MxBXaiRU
         CuzJhqPCk55FkkzbnL1RIu/i6ymS3eUc/seWKbMmKWYk1LlE5EE8jPBxB3DRQDN4W4aH
         mqNQ==
X-Gm-Message-State: AOAM530YflePVe+JfFyTyLszBiCv1B7kCnf97tFgSnPGV1jtYsmn1GRc
	0oYL9OwrRB1nNK6bGO1e6bDp3lHDs7V+COJs
X-Google-Smtp-Source: 
 ABdhPJwEA17vUqS53pGcc5UobPT0Xqy5srHPbwaooeclTqEG8wBGu2ObAkEWXNs26zQPR1Kr2Fi0kg==
X-Received: by 2002:a05:6512:3ba4:: with SMTP id
 g36mr26168913lfv.546.1637252821484;
        Thu, 18 Nov 2021 08:27:01 -0800 (PST)
Received: from localhost.localdomain (37-247-29-68.customers.ownit.se.
 [37.247.29.68])
        by smtp.gmail.com with ESMTPSA id
 p17sm37252lfs.292.2021.11.18.08.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 08:27:01 -0800 (PST)
From: Jacob Kroon <jacob.kroon@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Justin Bronder <jsbronder@cold-front.org>,
	Steve Sakoman <steve@sakoman.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [1.50][PATCH 2/4] hashserv: let asyncio discover the running loop
Date: Thu, 18 Nov 2021 17:26:21 +0100
Message-Id: <20211118162623.3117035-3-jacob.kroon@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211118162623.3117035-1-jacob.kroon@gmail.com>
References: <20211118162623.3117035-1-jacob.kroon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 18 Nov 2021 16:27:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13070

From: Justin Bronder <jsbronder@cold-front.org>

>From 3.10 documentation [1]:
    Deprecated since version 3.8, removed in version 3.10: The loop
    parameter. This function has been implicitly getting the current
    running loop since 3.7

This is fixed in master as a side-effect of
cf9bc0310b0092bf52b61057405aeb51c86ba137 which is more intrusive but
likewise drops the loop parameter.

1. https://docs.python.org/3/library/asyncio-stream.html#asyncio.open_connection

Signed-off-by: Justin Bronder <jsbronder@cold-front.org>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 74a1e71b1e677a482fdedc685a71a1798ad63920)
Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
---
 lib/hashserv/server.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index a0dc0c17..df0fa0a0 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -521,7 +521,7 @@ class Server(object):
 
     def start_tcp_server(self, host, port):
         self.server = self.loop.run_until_complete(
-            asyncio.start_server(self.handle_client, host, port, loop=self.loop)
+            asyncio.start_server(self.handle_client, host, port)
         )
 
         for s in self.server.sockets:
@@ -546,7 +546,7 @@ class Server(object):
             # Work around path length limits in AF_UNIX
             os.chdir(os.path.dirname(path))
             self.server = self.loop.run_until_complete(
-                asyncio.start_unix_server(self.handle_client, os.path.basename(path), loop=self.loop)
+                asyncio.start_unix_server(self.handle_client, os.path.basename(path))
             )
         finally:
             os.chdir(cwd)

