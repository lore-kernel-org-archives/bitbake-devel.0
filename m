Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65185C25B78
	for <webhook@archiver.kernel.org>; Wed, 22 May 2024 17:12:36 +0000 (UTC)
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
 by mx.groups.io with SMTP id smtpd.web10.265.1716397947394847462
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 May 2024 10:12:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=OavNBItb;
 spf=pass (domain: gmail.com, ip: 209.85.161.48, mailfrom: jpewhacker@gmail.com)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5b680c1fdd4so743102eaf.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 22 May 2024 10:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716397946; x=1717002746; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FxzXfLP6PAoBArQPoo9AclGMbNnzrqhScE3CXmLKrDg=;
        b=OavNBItbx0CoaN0zCpPDjjbKdwIw+uVHTlEuV7V5LOtOpb99SbYAST0Upcm0OTUH/R
         A813TSkgttIZFOe9fhKM8vdzsIEorlsS2PoJHVyCZUzf75v5RgtI6508yN1+GKyb6tQk
         +zF/nuJZIwlmoFwX0JugZA4WDIufsR2ItxARXIQMTnjF0sSAqiwDanwzpzQ9/uq8sLaL
         G0AUqXq6wjzMLYksu/MX1rQJbcqqUzGHNiFqjgrsEUV6c7dUrOGKCjf16bjUN0yQMNl4
         3e66CpgluLEJuKtUj74oySvBY6Tt+0j2Y3ddNVQCMWnlpuZiN1VQO0uxZvoO7qa4aKn5
         jfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716397946; x=1717002746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FxzXfLP6PAoBArQPoo9AclGMbNnzrqhScE3CXmLKrDg=;
        b=I+ba87b5xHGHwlBQFDce+f21eEBaZc7ENyNJHMGZgf7ZVk6AltyTIFMOF4ZbNpqvsQ
         /VWUf48v86F2JBNG/e8pXejsvWUaJHCjLM3LLXahG9sxu07ZRVnviCEowKKLoYLRVDFn
         ZLPbrks0T7FwlsrVHWVRejZAyRoQw9z88yJRhbuWNsc5R3DPhqSzofEM2g1rXxiunuBU
         4XoK299zW6r2+i7YgnYXZ0M6my+5yuAT+1Yp9vKm41OQyUF2eiPiMR5P7SPOCvyZntRQ
         qxPKK4qmj+hXgJwKcSL0fZDvQ3ngyJECJaMRUoi7xGRDaqBXOvd0WiTLNo+mNCyOT0Dm
         xi4w==
X-Gm-Message-State: AOJu0Ywai7Uvikeb+T0fz0wwdvSmb+F/UWo0hOD5kEiel5Nj6V12Ckyj
	MRX59W7qJW+okk+ZWCyzPqmwFzJ/CJcxlgvkuMYxrW21e7RqoDD+b3uDOA==
X-Google-Smtp-Source: AGHT+IGzUcb4xbMs91CXmojexLrSS1Y+Dnabqz2t+moVT8x3rW7Iymftx8G3QThOjHd1wOIp8I9aPg==
X-Received: by 2002:a05:6820:169f:b0:5b2:f2a3:5e with SMTP id 006d021491bc7-5b6a3823643mr2766054eaf.4.1716397946013;
        Wed, 22 May 2024 10:12:26 -0700 (PDT)
Received: from localhost.localdomain ([204.77.163.55])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5b53c54a611sm1189109eaf.47.2024.05.22.10.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 10:12:25 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] bitbake-hashclient: Improve stress statistics reporting
Date: Wed, 22 May 2024 11:12:20 -0600
Message-ID: <20240522171220.2977248-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 May 2024 17:12:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16242

Improves the way statistics are reported for the stress test. This makes
it easier to compare them to the ping test

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/bin/bitbake-hashclient | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/bitbake/bin/bitbake-hashclient b/bitbake/bin/bitbake-hashclient
index e1e11446448..8d15604b345 100755
--- a/bitbake/bin/bitbake-hashclient
+++ b/bitbake/bin/bitbake-hashclient
@@ -82,6 +82,7 @@ def main():
             nonlocal found_hashes
             nonlocal missed_hashes
             nonlocal max_time
+            nonlocal times
 
             with hashserv.create_client(args.address) as client:
                 for i in range(args.requests):
@@ -99,29 +100,41 @@ def main():
                         else:
                             missed_hashes += 1
 
-                        max_time = max(elapsed, max_time)
+                        times.append(elapsed)
                         pbar.update()
 
         max_time = 0
         found_hashes = 0
         missed_hashes = 0
         lock = threading.Lock()
-        total_requests = args.clients * args.requests
+        times = []
         start_time = time.perf_counter()
-        with ProgressBar(total=total_requests) as pbar:
+        with ProgressBar(total=args.clients * args.requests) as pbar:
             threads = [threading.Thread(target=thread_main, args=(pbar, lock), daemon=False) for _ in range(args.clients)]
             for t in threads:
                 t.start()
 
             for t in threads:
                 t.join()
+        total_elapsed = time.perf_counter() - start_time
 
-        elapsed = time.perf_counter() - start_time
         with lock:
-            print("%d requests in %.1fs. %.1f requests per second" % (total_requests, elapsed, total_requests / elapsed))
-            print("Average request time %.8fs" % (elapsed / total_requests))
-            print("Max request time was %.8fs" % max_time)
-            print("Found %d hashes, missed %d" % (found_hashes, missed_hashes))
+            mean = statistics.mean(times)
+            median = statistics.median(times)
+            stddev = statistics.pstdev(times)
+
+            print(f"Number of clients:    {args.clients}")
+            print(f"Requests per client:  {args.requests}")
+            print(f"Number of requests:   {len(times)}")
+            print(f"Total elapsed time:   {total_elapsed:.3f}s")
+            print(f"Total request rate:   {len(times)/total_elapsed:.3f} req/s")
+            print(f"Average request time: {mean:.3f}s")
+            print(f"Median request time:  {median:.3f}s")
+            print(f"Request time std dev: {stddev:.3f}s")
+            print(f"Maximum request time: {max(times):.3f}s")
+            print(f"Minimum request time: {min(times):.3f}s")
+            print(f"Hashes found:         {found_hashes}")
+            print(f"Hashes missed:        {missed_hashes}")
 
         if args.report:
             with ProgressBar(total=args.requests) as pbar:
-- 
2.43.2


