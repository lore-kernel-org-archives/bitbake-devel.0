Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADC8C433F5
	for <webhook@archiver.kernel.org>; Sun, 27 Mar 2022 16:44:29 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web11.773.1648399469409476689
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 27 Mar 2022 09:44:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=qRNd3UG4;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.174,
 mailfrom: steve@sakoman.com)
Received: by mail-pf1-f174.google.com with SMTP id p8so10543003pfh.8
        for <bitbake-devel@lists.openembedded.org>;
 Sun, 27 Mar 2022 09:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tbNisSeCfv5j6a5FWdDrUhbmfciP9G0bznxtYjqng7w=;
        b=qRNd3UG4abqXGEWZQdIFfSTpIKDYqzt5ndeGgvaSCyLHp71Hcem3e+CO3O//X8XI16
         8GREWieTEtKnQTMmsbgmmOXxEfhQD+WnmXSuXeY/8rtJfuW5qSD0tWebxCPs75ke+ff8
         llscbg5vxKV1KCNDckEoFF5Aqt0zsfu0qz2IB3YyTaI3Rbtf5fyixCSmpWB53Q2doY1j
         cL3e3MBHEwgBPA84Hw+VZ3InXANtAAM2OsRvR0cHKrp3gIY9MxY/lCSuCWyvFA5+QZSV
         5fm46a0cA3RN7SZCQnyAAV1Iq1HV+TuxqkBjxHq1uEJU6RjuoE7AEP4ljrTjcwqPRyyw
         nRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tbNisSeCfv5j6a5FWdDrUhbmfciP9G0bznxtYjqng7w=;
        b=jhxtukP0R/LVgCrTjTcj8PZhjhQtv5xkduMjfyK+mKdnANjw3N8vQbexW3gKZ0HfQU
         WNeKmG7Zh19P02rY4z24Cuxi4fGA+WUWNlF5540WOj2B+lOvBFV0HUHVyhs6WvZu679b
         fyhdDXuI3tfVlZPtus4Km1Yf5Xr2gE/i/JpIw6mu/0qVbaRrgdem6JHr8vc8+mnFDnLO
         3szgPwt+fuc+kY7EqDWjuGA0DZLF5TlD5jLlioNODZEudGxdZMqStaMuOX5xcWf9XPK8
         T6oCuGwES81DKgcy4jhmfcM+HX4CzbidyBMnKXBX3AqlPTNY80eqOk5Dka/si4MExh6C
         JnZQ==
X-Gm-Message-State: AOAM531wtLIrG+7ldnLreaDcrhk1HkbTYwG8pLIsYpqX09TZ35wyY91y
	N0tSqF/7m+83b8bcLK545qIfUejiFWp7dzgMEeg=
X-Google-Smtp-Source: 
 ABdhPJx0EovHATlqufp5TTCBPldWHF4X3Bb7dNNkT9tZSaTyjCq7m5Qw0xLbkPHKJz6EyE/PmUX6cg==
X-Received: by 2002:a65:410c:0:b0:381:effc:b490 with SMTP id
 w12-20020a65410c000000b00381effcb490mr7210425pgp.274.1648399468561;
        Sun, 27 Mar 2022 09:44:28 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 k13-20020aa7820d000000b004fa72a52040sm12935630pfi.172.2022.03.27.09.44.27
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 09:44:28 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 2/2] tinfoil: Allow run_command not to
 wait on events
Date: Sun, 27 Mar 2022 06:44:01 -1000
Message-Id: 
 <439be20cb3c08a8c668f618e7eb582c194152dba.1648399312.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648399312.git.steve@sakoman.com>
References: <cover.1648399312.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 27 Mar 2022 16:44:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13521

From: Richard Purdie <richard.purdie@linuxfoundation.org>

There are some commands where we want to see the events returned so allow
the caller to request this. This also allows us to fix an infamous bug in
the tinfoil testsuite in OE-Core.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 0e8421c41d97d5d50a553d70c8f775d521f1a199)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/tinfoil.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index ae690389..28f1e562 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -448,7 +448,7 @@ class Tinfoil:
         self.run_actions(config_params)
         self.recipes_parsed = True
 
-    def run_command(self, command, *params):
+    def run_command(self, command, *params, handle_events=True):
         """
         Run a command on the server (as implemented in bb.command).
         Note that there are two types of command - synchronous and
@@ -468,7 +468,7 @@ class Tinfoil:
         try:
             result = self.server_connection.connection.runCommand(commandline)
         finally:
-            while True:
+            while handle_events:
                 event = self.wait_event()
                 if not event:
                     break
-- 
2.25.1


