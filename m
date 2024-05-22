Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35542C25B78
	for <webhook@archiver.kernel.org>; Wed, 22 May 2024 16:30:00 +0000 (UTC)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
 by mx.groups.io with SMTP id smtpd.web11.60.1716395392688215800
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 May 2024 09:29:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=DhTUpTyc;
 spf=pass (domain: gmail.com, ip: 209.85.210.42, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6f12d22331fso498460a34.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 22 May 2024 09:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716395391; x=1717000191; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TQYdgn2fljXPG/QseT6zF5ymy03i/7hH1xHqLcSIymc=;
        b=DhTUpTycL7YzePhOgkbcarZ2j5z9oPAk7kT1OA0+Fz0qjApg6QiLacoFg/nZhuHP75
         YpsVsYhBhMYw/6ZOpxTOdV/cLob4xG2OQ58XFagk2LZXcbXAezIkc4XjkYpVZA6h3HIY
         1Bv7DtK5B7fdiORHIlmakdLrH1mlIRvhQLJfQ9/JZiAB6KDabG4ZRvCwMxqKBP1agZ84
         plQDTTkxCE+sGZsAHTBOrpevkVJu2O6/q3/TLJhnmudKgpAa+zexN67iB8G81g5q2cvD
         GnUfFBu8SP7ftLEKyR+KAZAuXJxJq3p4ts2vUpttfb6JZvbtYvT2P+u/E89FxJBrML3s
         iDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716395391; x=1717000191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TQYdgn2fljXPG/QseT6zF5ymy03i/7hH1xHqLcSIymc=;
        b=RSFHZVAue0VvFXeqFa0qweLUulprV/qZOTjG7nIYq9qiZ9dAnY+MrQwPyCd8qw2Lb1
         ieKjdG5+YjY1+ipP90fUl7j58lf1xJvJvrfp4REcuIUf8l52abEUlCKXMLSpLLjp5R/a
         /8++jWlNItx6aFrNNbrbyT2jagWlZmwp57Dr86v0T/OavnN5BDAnw/o1cCnDRRXMbVcY
         RocpM/UIxgBD0QX7DWjvWLP2V+9WZO6ax8j4E6wnGZBphkkxF53P861D6KfGtiBPUrSw
         WhD8aofNj3T3jfIV5ODUqOdd8wAAjjYltbOxJvtnlRF2sS1c56i4Fnykib9gUGOcp4uG
         5vTQ==
X-Gm-Message-State: AOJu0YyxC76qXibtJ4IcEyoZKdYLEPSJ+uMMEsRjRQfInmX5l6Nm+sJC
	EHFOedDpRhvNUHR3QhkV5s4WlljYcv8dLwSAvb8HCJoJgamH5ZNWH/y9VQ==
X-Google-Smtp-Source: AGHT+IF8/YHXEOz5OEQ3NNBwOwwrimPSK34qjhVMRyO9GTZCtn8xN2MlmVczgfCKm72WhJ+aikqx9g==
X-Received: by 2002:a05:6830:18d4:b0:6f0:e1b8:496a with SMTP id 46e09a7af769-6f656c47ee8mr1320548a34.3.1716395391334;
        Wed, 22 May 2024 09:29:51 -0700 (PDT)
Received: from localhost.localdomain ([204.77.163.55])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f11ad51199sm3282409a34.70.2024.05.22.09.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 09:29:50 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] bitbake-hashclient: Add ping command
Date: Wed, 22 May 2024 10:29:43 -0600
Message-ID: <20240522162943.2956896-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 May 2024 16:30:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16241

Adds a ping subcommand to bitbake-hashclient which can be useful to
measure connection latency

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/bin/bitbake-hashclient | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/bitbake/bin/bitbake-hashclient b/bitbake/bin/bitbake-hashclient
index 610787ed2b0..e1e11446448 100755
--- a/bitbake/bin/bitbake-hashclient
+++ b/bitbake/bin/bitbake-hashclient
@@ -16,6 +16,7 @@ import time
 import warnings
 import netrc
 import json
+import statistics
 warnings.simplefilter("default")
 
 try:
@@ -225,6 +226,26 @@ def main():
         print("true" if result else "false")
         return 0
 
+    def handle_ping(args, client):
+        times = []
+        for i in range(1, args.count + 1):
+            print(f"Ping {i} of {args.count}... ", end="")
+            start_time = time.perf_counter()
+            client.ping()
+            elapsed = time.perf_counter() - start_time
+            times.append(elapsed)
+            print(f"{elapsed:.3f}s")
+
+        mean = statistics.mean(times)
+        std_dev = statistics.pstdev(times)
+
+        print("------------------------")
+        print(f"Average round trip time: {mean:.3f}s")
+        print(f"Round trip time std dev: {std_dev:.3f}s")
+        print(f"Min time is:             {min(times):.3f}s")
+        print(f"Max time is:             {max(times):.3f}s")
+        return 0
+
     parser = argparse.ArgumentParser(description='Hash Equivalence Client')
     parser.add_argument('--address', default=DEFAULT_ADDRESS, help='Server address (default "%(default)s")')
     parser.add_argument('--log', default='WARNING', help='Set logging level')
@@ -322,6 +343,10 @@ def main():
     unihash_exists_parser.add_argument("unihash", help="Unihash to check")
     unihash_exists_parser.set_defaults(func=handle_unihash_exists)
 
+    ping_parser = subparsers.add_parser('ping', help="Ping server")
+    ping_parser.add_argument("-n", "--count", type=int, help="Number of pings. Default is %(default)s", default=10)
+    ping_parser.set_defaults(func=handle_ping)
+
     args = parser.parse_args()
 
     logger = logging.getLogger('hashserv')
-- 
2.43.2


