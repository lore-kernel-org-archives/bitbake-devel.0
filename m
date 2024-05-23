Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18039C25B7C
	for <webhook@archiver.kernel.org>; Thu, 23 May 2024 16:45:07 +0000 (UTC)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
 by mx.groups.io with SMTP id smtpd.web10.629.1716482704819256463
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 23 May 2024 09:45:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Vj18VMcv;
 spf=pass (domain: gmail.com, ip: 209.85.210.50, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6f120ae1ca3so4457702a34.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 23 May 2024 09:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716482703; x=1717087503; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U2MNqPZWxRqKMz9J8puZb2mUyt0jqvczc1wuxRS0Ns0=;
        b=Vj18VMcv7Sp1v6yOS8TuCkf9AjsqrdaUYr/niqDilajwWPFylao3WEMnuUWAhURvFK
         Yg34hJO1iOHcrR28q4hOQ8WmeECCjtC+M5krUkmr1VBYOMJ7YZzQvNig+pB5bI0sg3E2
         ZQK6093yU4bdO5mpT1KRsGdUKWdZYub4IkJI6UEHgCEInkt6lOotPaVsJIQmhNu/rpRs
         nTMFr23L0PQjrXlCNi8Tu2Ny57tJAtpy5vLniqm7mGPDu5N4BWdl2msKglUV+KexP4Fx
         cbCGWBrUwuIEyIxWoUWDx+ygkCIWxTHHc/BirN+jQVGC7sRMpKxg0S3N0Uc0rUDMbomb
         jm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716482703; x=1717087503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U2MNqPZWxRqKMz9J8puZb2mUyt0jqvczc1wuxRS0Ns0=;
        b=WzWNPfq9zG5hCKSqDahrMR6PvFORnKJ2t5c9LICVC1cqOZSgaqrTmWp3OJSHDI555A
         UOmFJfb5L7bhi4wwKUsJ/srbdNrv4NZ/GaGU42h+qxhoHTm3lu0xZO9WWSyGlqyYR14C
         GhjQLoOhk4dvDvtYkegii+KoeoxlxTC6t5eI+RRpbfOEQLjYFfcgLDfHiPcKpZuMTqx6
         4v/+6ogYsXokt9bkGY8A1+Jl+QKnUQoUzZ2J4syrCqsYTUjXepN3PvSFebu0eVoU9muC
         BQcYV6Iry+nvnKfrThW9iSZj1kQtes+EvJHuGu3csqLaC4OMpt49/wTr+oidEeirldhp
         uN/A==
X-Gm-Message-State: AOJu0YycEbXCm6mhu9rCkLJTjKoWsqTS/DvZzgARf/ilTyp5hNC5CVWp
	XJ9YioBMxkEOf/92+eRqu3+LSWxXv9OsNRL3yWIENqkw5cSNEftGNTfoBg==
X-Google-Smtp-Source: AGHT+IHvXc/AmguSi/d1GUoxt1FcbrdulEbvbnDzeoJTgCP/3Kd/l1zYG7npyOQ2yTUngfc6E1Pk4g==
X-Received: by 2002:a9d:7acb:0:b0:6f2:5c19:eb9 with SMTP id 46e09a7af769-6f669b02750mr5789372a34.34.1716482703468;
        Thu, 23 May 2024 09:45:03 -0700 (PDT)
Received: from localhost.localdomain ([204.77.163.55])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f8ce8a5338sm32045a34.38.2024.05.23.09.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 09:45:02 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] bitbake-hashclient: Improve ping command line options
Date: Thu, 23 May 2024 10:44:54 -0600
Message-ID: <20240523164454.3190645-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 23 May 2024 16:45:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16247

Adds a --quiet option to suppress the message for each ping, and report
the median ping time.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/bin/bitbake-hashclient | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/bitbake/bin/bitbake-hashclient b/bitbake/bin/bitbake-hashclient
index 8d15604b345..5d6f67046bd 100755
--- a/bitbake/bin/bitbake-hashclient
+++ b/bitbake/bin/bitbake-hashclient
@@ -242,18 +242,24 @@ def main():
     def handle_ping(args, client):
         times = []
         for i in range(1, args.count + 1):
-            print(f"Ping {i} of {args.count}... ", end="")
+            if not args.quiet:
+                print(f"Ping {i} of {args.count}... ", end="")
             start_time = time.perf_counter()
             client.ping()
             elapsed = time.perf_counter() - start_time
             times.append(elapsed)
-            print(f"{elapsed:.3f}s")
+            if not args.quiet:
+                print(f"{elapsed:.3f}s")
 
         mean = statistics.mean(times)
+        median = statistics.median(times)
         std_dev = statistics.pstdev(times)
 
-        print("------------------------")
+        if not args.quiet:
+            print("------------------------")
+        print(f"Number of pings:         {len(times)}")
         print(f"Average round trip time: {mean:.3f}s")
+        print(f"Median round trip time:  {median:.3f}s")
         print(f"Round trip time std dev: {std_dev:.3f}s")
         print(f"Min time is:             {min(times):.3f}s")
         print(f"Max time is:             {max(times):.3f}s")
@@ -358,6 +364,7 @@ def main():
 
     ping_parser = subparsers.add_parser('ping', help="Ping server")
     ping_parser.add_argument("-n", "--count", type=int, help="Number of pings. Default is %(default)s", default=10)
+    ping_parser.add_argument("-q", "--quiet", action="store_true", help="Don't print each ping; only print results")
     ping_parser.set_defaults(func=handle_ping)
 
     args = parser.parse_args()
-- 
2.43.2


