Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web11.6550.1622720761383904487
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 03 Jun 2021 04:46:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=vbOy5dR+;
 spf=pass (domain: gmail.com, ip: 209.85.128.46, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f46.google.com with SMTP id h3so3206076wmq.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 03 Jun 2021 04:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kaUPuirDqyFn6NPDb7mGYuvbGB1KVIyiDbZJxFFCuzA=;
        b=vbOy5dR+XsMLWZOVhIvxdQPR9U/GJqkUPOs6Swvq+6UGL9eTmHsUB4hhIJFiP7r6vk
         82S7SBXPlkMBZjlgFStRwrP7XTYw0+izRflpz/SUEMGHtXjgcCd9nOwlX/rhfbN5asws
         GlDEPatXUaVZyisBCIUiDPxBkS+4opuNMYRnd/0Ugy+BaF3orNUA7ChW8By9vMEtsGHy
         92cV8Sn6L8ONJVJccrzy4ADxkI7tiYASpsZxUMF3L64LTSWh6M3Ph3lUhWK2Q27Z4VFv
         b5/yy1OO6/nmJ30Wi0dXuP9fTcngL/hI2/1USbCNJ5oK5KKoPsy8sfyHg+7J7LvWcuzB
         g9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kaUPuirDqyFn6NPDb7mGYuvbGB1KVIyiDbZJxFFCuzA=;
        b=YfJtv44MC10Jk/DmPFKX/RvcFm5r16Rjv/xTDvMKRbKwGcylkP/LvF3z2n6skcHJAe
         lg/nGSu2xWyhNHrOxvxz60wq1f3qBefIE80wZl/RT3GTj+qPz3ioZQAy78+tLPeiPoiH
         mPkd2GmNzcsHzP66g9j6esNM1wKZ9GJZzD1Um/iX9rFfljgzxEZWbNlJKyKgKHuex4K4
         fGYZT+9NY8OjwvsYCawY+CxLynmMvBnYiXK3FHWyQq9KYLL1yav6RGSY/4gCaHh5+jxT
         2Z6PtgTdJxEsFtvA2nNH5IqpcVwZ3Tti53ek0+JzLxIu3PjtZODqBZP/vfNqQ62rjzp4
         P/fQ==
X-Gm-Message-State: AOAM531q99Zz0ZuT7Y0groAPN391n54/4EbLc56SMMgek4BULLr8WzOK
	YQkykcJcfHhZ4IZtJT/kEz+cWqClwkw=
X-Google-Smtp-Source: ABdhPJyO18Kp3ZxJ0/uKACXLMyZXVXeKpAvtuMdvxKVLDeydxNONkJ5xnJuKxeYBWcZVhneVqFT18A==
X-Received: by 2002:a1c:c90f:: with SMTP id f15mr9869536wmb.142.1622720760049;
        Thu, 03 Jun 2021 04:46:00 -0700 (PDT)
Return-Path: <martin.jansa@gmail.com>
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id j18sm2360945wmq.27.2021.06.03.04.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 04:45:59 -0700 (PDT)
From: "Martin Jansa" <Martin.Jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: steve@sakoman.com,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [1.46][PATCH 4/4] cooker: Avoid parser deadlocks
Date: Thu,  3 Jun 2021 13:45:43 +0200
Message-Id: <20210603114543.98044-4-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210603114543.98044-1-Martin.Jansa@gmail.com>
References: <20210603114543.98044-1-Martin.Jansa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Purdie <richard.purdie@linuxfoundation.org>

If you make parsing fail (e.g. add something like:

X := "${@d.getVar('MCMACHINES').split()[1]}"

to meson.bbclass, then run "while true; do bitbake -g bash; done"
it will eventually hang. It appears the cancel_join_thread() call the
parsing failure triggers, breaks the results_queue badly enough that it
sits in read() indefintely (called from self.result_queue.get(timeout=0.25)).
The timeout only applies to lock aquisition, not the read call.

I've tried various other approaches such as using cancel_join_thread()
in other places but the only way things don't lock up is to avoid
cancel_join_thread() entirely for results_queue.

I do have a concern that this may adversely affect Ctrl+C handling
but equally, its broken now already and this appears to improve
things.

[YOCTO #14034]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 4d2c62cd..730cdc56 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1933,7 +1933,8 @@ class Parser(multiprocessing.Process):
             except queue.Empty:
                 pass
             else:
-                self.results.cancel_join_thread()
+                self.results.close()
+                self.results.join_thread()
                 break
 
             if pending:
@@ -1942,6 +1943,8 @@ class Parser(multiprocessing.Process):
                 try:
                     job = self.jobs.pop()
                 except IndexError:
+                    self.results.close()
+                    self.results.join_thread()
                     break
                 result = self.parse(*job)
                 # Clear the siggen cache after parsing to control memory usage, its huge
@@ -2060,8 +2063,6 @@ class CookerParser(object):
 
             bb.event.fire(event, self.cfgdata)
 
-        # Allow data left in the cancel queue to be discarded
-        self.parser_quit.cancel_join_thread()
         for process in self.processes:
             self.parser_quit.put(None)
 
@@ -2081,7 +2082,8 @@ class CookerParser(object):
                 process.join()
 
         self.parser_quit.close()
-        self.parser_quit.join_thread()
+        # Allow data left in the cancel queue to be discarded
+        self.parser_quit.cancel_join_thread()
 
         sync = threading.Thread(target=self.bb_cache.sync)
         self.syncthread = sync
-- 
2.30.2

