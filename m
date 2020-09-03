Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web12.11655.1599132271846867994
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 03 Sep 2020 04:24:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=MPHZ1OZw;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.67, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f67.google.com with SMTP id e16so2829537wrm.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 03 Sep 2020 04:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GM0Tj6/pS5F66XmAQbTfhhKyeXI/1HiB8YB6yN1E0mE=;
        b=MPHZ1OZw9srTGQv9mV+jroFnrTYnaGHlvv+WY3cYRGXoQPb7bJ4mfTdsh+GfGiR2H+
         2MQtIzzzDPeGcxEAiQa2xdYYzPRQ7WPnEn2abL9UgGfeWRq9KwMPj7ck8FBzea+VrukD
         sidwzQgzxHMqmZp/60Dwx+PxnG6W7++ZMsa5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GM0Tj6/pS5F66XmAQbTfhhKyeXI/1HiB8YB6yN1E0mE=;
        b=A2esE7d6Jnv8f44zEfNTVXMevR0xb3zBBnFyzIe+cf6fdTbzYAJshHLSpDAnnkfG7t
         H8OLhSy4klNYugzvvMsp2pb7gi5dUPjdTUGnOCNFuobD8MxzNOL0pHM2lZdaFDT6rYQI
         VKqFIssyawNW4JKhcl0Ka6rM0e9k/AsSobP79RykGol2ipY0O+88UzROuZ1REYf5/QXW
         6caz5+aetqcKAFqOc+HW+l8tssvDaGu5qp7bxXoc3w/93u8+MJIzUtGT4DzE8k8xS7os
         XOqJJ6syzGc0Mxw0Kotj1eNG3/xQT5sffjOfyH51dgNREd3BTFofFM7VmxLKGTeFicE8
         Q3cA==
X-Gm-Message-State: AOAM533QoHSQDBggqmhT3bhOE7Da58d7sc+0fOXc/BwVPfIBieUaM3jZ
	5F1ikSaf6FzuePR9YlsFGq2fDMxSYdIlQA==
X-Google-Smtp-Source: ABdhPJzs53WMs1d1jfXrB06AadJzjzjyPkptyr2My5pBTkK/M54wlwqlTDcSf8LzWZ5tt5NqgtluUA==
X-Received: by 2002:adf:e2c7:: with SMTP id d7mr1948461wrj.110.1599132270075;
        Thu, 03 Sep 2020 04:24:30 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (d.f.d.f.5.0.6.0.0.2.6.1.6.b.c.7.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:7cb6:1620:605:fdfd])
        by smtp.gmail.com with ESMTPSA id f1sm3974013wrt.20.2020.09.03.04.24.29
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 04:24:29 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/3] cooker: Avoid parser deadlocks
Date: Thu,  3 Sep 2020 12:24:27 +0100
Message-Id: <20200903112427.1777983-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903112427.1777983-1-richard.purdie@linuxfoundation.org>
References: <20200903112427.1777983-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 lib/bb/cooker.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index a85e3587fd..beb72958af 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1991,7 +1991,8 @@ class Parser(multiprocessing.Process):
             except queue.Empty:
                 pass
             else:
-                self.results.cancel_join_thread()
+                self.results.close()
+                self.results.join_thread()
                 break
 
             if pending:
@@ -2000,6 +2001,8 @@ class Parser(multiprocessing.Process):
                 try:
                     job = self.jobs.pop()
                 except IndexError:
+                    self.results.close()
+                    self.results.join_thread()
                     break
                 result = self.parse(*job)
                 # Clear the siggen cache after parsing to control memory usage, its huge
@@ -2119,10 +2122,11 @@ class CookerParser(object):
 
             bb.event.fire(event, self.cfgdata)
 
-        # Allow data left in the cancel queue to be discarded
-        self.parser_quit.cancel_join_thread()
         for process in self.processes:
             self.parser_quit.put(None)
+        self.parser_quit.close()
+        # Allow data left in the cancel queue to be discarded
+        self.parser_quit.cancel_join_thread()
 
         # Cleanup the queue before call process.join(), otherwise there might be
         # deadlocks.
-- 
2.25.1

