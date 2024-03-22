Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6847EC54E71
	for <webhook@archiver.kernel.org>; Fri, 22 Mar 2024 13:50:51 +0000 (UTC)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
 by mx.groups.io with SMTP id smtpd.web11.13760.1711115443956889325
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 22 Mar 2024 06:50:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=l6e7RKzD;
 spf=pass (domain: gmail.com, ip: 209.85.166.43, mailfrom: jpewhacker@gmail.com)
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7d026c0a08aso68219239f.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 22 Mar 2024 06:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711115442; x=1711720242; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b4OhbdXlXs8JgG1OUDlSeb77p1J5Ro0A7r3KN2aNhv4=;
        b=l6e7RKzDk3v/f3qGt5QFy8YDHNExkO5kT/fzZFhZuyZh6NbbyTiGZgW4YMWF83MQpQ
         EyQe94ieyvec3whKoWaXpgWG4q/nuZ74vlCV+jaW25boc3hoDZF5Fqwd7+xITQIyyMFc
         lgsABXGfcqP0q/8zzD4I+/5Sb1L57WT5RE5pzGJpuJA/6crjoF2aexwtZTGgLGPUZLf7
         ZElVFfSYXf/zr3UT6RD0Ng59NYKjI5MbKyPio+59Fx2M98jOPV64wO3/xu9GHJhFwAnT
         fM4okQhWfKPrCgacqGudAn1D/Jt5jaTmjqm+XAwngaiE8iW3YC0H7dX83uCf5l8JXF5u
         Mb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711115442; x=1711720242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b4OhbdXlXs8JgG1OUDlSeb77p1J5Ro0A7r3KN2aNhv4=;
        b=udnXIe7WLBXI2ew8ugZ5hcKh8gAGRJmIU8ElLDe7H6TQWCUv75Ge3N+ia8M+eGYOuk
         ruOJDzuHX6B8F7yPW25fpzhm8eSuRl6XamdqLNi5DxpI0LWn+b0kZEF/WPgCpMn2SYUK
         Dg9zql8lOF7rzZg6VR6ucYdhVcEJ1qztqpbqeiDov0ofQaLvyZiYt0UNBYAFXvExid/r
         +9CBJ1fUS5OAWlCepUWYmhOW9kNlA/fvCk3Mq/R5Q+goS6CobNSRQ552kVGQrzXGlf6i
         Ee2gPuonBDlK0G7JQBa3HQlbKds3UQaxqABGqeyGQjckuiYdgQ9uBiFszPARGKdyCzOW
         3aBA==
X-Gm-Message-State: AOJu0YyyZdwC67BV2XRTnXVhwoEkiiuedrPozmLw1nw4J+dtjN7rtAYf
	HBfjAmYTD6uP196JNuXfvGRkAZoeO/hgFvaiDFHr/rj/DOP1cPmP2vx4GHDO
X-Google-Smtp-Source: AGHT+IHhspBqPfvWwv6SSkpc7V8epWSD0wcf3U15MGKGc4Q0R7wl5TG8qj+AumxZqiVkqFCOcNeNrQ==
X-Received: by 2002:a6b:7502:0:b0:7cc:fbd:270f with SMTP id l2-20020a6b7502000000b007cc0fbd270fmr2565476ioh.6.1711115442039;
        Fri, 22 Mar 2024 06:50:42 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::dd43])
        by smtp.gmail.com with ESMTPSA id s21-20020a5eaa15000000b007d02d0b2d3dsm502203ioe.34.2024.03.22.06.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 06:50:41 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] siggen: Add support for hashserve credentials
Date: Fri, 22 Mar 2024 07:50:35 -0600
Message-Id: <20240322135035.1113817-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 22 Mar 2024 13:50:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16012

Adds support for hashserver credentials to be specified in the
SignatureGenerator

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/siggen.py | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 3ab8431a089..2a0ecf57e16 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -535,23 +535,34 @@ class SignatureGeneratorUniHashMixIn(object):
         # hashes to appear over time, but much less likely for them to
         # disappear
         self.unihash_exists_cache = set()
+        self.username = None
+        self.password = None
         super().__init__(data)
 
     def get_taskdata(self):
-        return (self.server, self.method, self.extramethod, self.max_parallel) + super().get_taskdata()
+        return (self.server, self.method, self.extramethod, self.max_parallel, self.username, self.password) + super().get_taskdata()
 
     def set_taskdata(self, data):
-        self.server, self.method, self.extramethod, self.max_parallel = data[:4]
-        super().set_taskdata(data[4:])
+        self.server, self.method, self.extramethod, self.max_parallel, self.username, self.password = data[:6]
+        super().set_taskdata(data[6:])
+
+    def get_hashserv_creds(self):
+        if self.username and self.password:
+            return {
+                "username": self.username,
+                "password": self.password,
+            }
+
+        return {}
 
     def client(self):
         if getattr(self, '_client', None) is None:
-            self._client = hashserv.create_client(self.server)
+            self._client = hashserv.create_client(self.server, **self.get_hashserv_creds())
         return self._client
 
     def client_pool(self):
         if getattr(self, '_client_pool', None) is None:
-            self._client_pool = hashserv.client.ClientPool(self.server, self.max_parallel)
+            self._client_pool = hashserv.client.ClientPool(self.server, self.max_parallel, **self.get_hashserv_creds())
         return self._client_pool
 
     def reset(self, data):
-- 
2.34.1


