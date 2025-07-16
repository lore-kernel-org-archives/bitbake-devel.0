Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE853C83F1B
	for <webhook@archiver.kernel.org>; Wed, 16 Jul 2025 15:22:56 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web11.25141.1752679373053446695
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 16 Jul 2025 08:22:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=C3yKbyQe;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a507e88b0aso5036882f8f.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 16 Jul 2025 08:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752679371; x=1753284171; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uD5hyyLm5eid0GU+7/tUcpRXpde53WAclPTtYt/Bdow=;
        b=C3yKbyQeAcPNC5qGWoqsvvXinVToD0J07bIMWcj4P7my0VOz0D5MQZJSVt2csLxdE3
         7hIGUL7wxIAtsxQpe8b/wyOwV2ib4tj6yc2BHLYEZWX0d5njfJj2myrbhlrWDsrl+sZb
         rbfdlYDFBVuORAJKVpPXvDq2Q0niZn2GXqFms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752679371; x=1753284171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uD5hyyLm5eid0GU+7/tUcpRXpde53WAclPTtYt/Bdow=;
        b=lO6w4kIyyCsbI9ggz47DBFsy780O15kNVDZJfPyqvGiHho7VR3F2rLg8YC794l8WJ/
         r5GAC+5W4LeH9t8v3ScQ0kXL/t0ZHjBbogi9KxggFJV+Z+33y/RrkAGp67HS98DDBTw2
         JqzumKIQcfilVFuZar/csBgxKD8bnjLyRNOUiUg3wdfKQTVeIvKMHO8/oM2BdRi46Z7S
         wJNpFFZN6VSdHdSKwBiiSzM5r8oDLuWRfO5XpDU8kEWxYNDFrhDis4tUOgw2zehNpue0
         yev6ihH2kvXLAVVxEQQa+pbd/ZO/Uvp3FbMP1LV5JWjgWDdnXInbPSdy7qJp/5SMJLxM
         PrHw==
X-Gm-Message-State: AOJu0Yyx4Ysw3LVfwJL61xcO4swp6/CLA6Cqtqkdo1G0XIc6FKM2PQOE
	Fu1KBEqyhHKgeMpn3FD+LcWpmPuHb1usXRSXEqyNrMQU/NSufv5ZnbuuVTU7dRAR98bc/ZpgCsu
	xID5P
X-Gm-Gg: ASbGnctVVxpetgE+fnL8hz9B1dv8+zuS1WIZnccnwUxos7KqF/NQ8lFjIyP+iwwebNb
	8UzMNmXEgkKTaWgrdmrKZr/nawZH1T+NCPFelgcdk6SirIuIRwdG4p9a5TeK9WFS4YpAGM9zj7P
	i3TtL0NqvDkoMKtvTetjvQ5824G9XwTghQqYyzEyU82MqACxCA68DLpATJ25GRMUBqiF8JJD+qC
	oevfChIYcqKwgCzl74dho+o6r3oWXXv5jesr1DIdrgBsOkzTxCVAAP1++HbjGk7GYJTaJSADbLQ
	fzxyzkcv9jgYeEibxYT573tLw4DsLOTRbV9fnSaIQtpt5bW5g7ZE0FJuhD1p2ltfOMd+CliWPBp
	gsZH953ZEL15npqGVCgtl2xaaC+puCIhkR+NDpQFbSps6lzBO2sU=
X-Google-Smtp-Source: AGHT+IHc00KUVB/kxPe8sfKR0OtVeS/vkOIejPZg0ij1m1BkyIrS7/s1CE90RdgELsCpKiIweM6jwA==
X-Received: by 2002:a05:6000:144b:b0:3a5:2599:4178 with SMTP id ffacd0b85a97d-3b60e4c8f5fmr2355418f8f.19.1752679370977;
        Wed, 16 Jul 2025 08:22:50 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:22ad:92e1:8848:8bb0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d872sm18362725f8f.60.2025.07.16.08.22.49
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:22:50 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/4] asyncrpc: Avoid file not found traceback in logs
Date: Wed, 16 Jul 2025 16:22:46 +0100
Message-ID: <20250716152249.96126-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 16 Jul 2025 15:22:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17779

If the server is quickly stopped, we see tracebacks in the locks
due to the file not existing. Hide these as they're not errors.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/asyncrpc/serv.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/asyncrpc/serv.py b/lib/bb/asyncrpc/serv.py
index 667217c5c1b..35e93f7c969 100644
--- a/lib/bb/asyncrpc/serv.py
+++ b/lib/bb/asyncrpc/serv.py
@@ -211,7 +211,10 @@ class UnixStreamServer(StreamServer):
         self.server.close()
 
     def cleanup(self):
-        os.unlink(self.path)
+        try:
+            os.unlink(self.path)
+        except FileNotFoundError:
+            pass
 
 
 class WebsocketsServer(object):

