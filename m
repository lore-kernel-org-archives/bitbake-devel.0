Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web12.64.1599493805784672686
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Sep 2020 08:50:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=JMvXNUgQ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.68, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f68.google.com with SMTP id j2so16279744wrx.7
        for <bitbake-devel@lists.openembedded.org>; Mon, 07 Sep 2020 08:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ugfsKrNO1W9pOgi4sDROwe5FzzU6tfDD4lL6cOD6B2o=;
        b=JMvXNUgQGlmMgXGTEAMYKKG8jvfeF41EzBb1cY990GFqvAoXfTVbes2BbrTJXfg9g0
         eTmLxFHOxioMmjedZHLLq8FTAFkLwUf5VlLxh3PIngEkkCFjNfFZICIh5fN/XVThYGJk
         UFQlgXtBK0YdH8GnOnM1UuIVhKXGsexmUPotY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ugfsKrNO1W9pOgi4sDROwe5FzzU6tfDD4lL6cOD6B2o=;
        b=hq56PhfiFmG/3MpBaNIR7athNbjDcqUP/z4FRNv7H5hhqO0GmUwpkm+pLXcNWLG26X
         RXwe+iW8imtEiJwcwYCZ9Rn+uV9n9grK9GgnisGITXClUfmC04scNOOEUYPnDS/vCpD+
         a7YEMQlmZ9Ztfxl2FahKH1CFnyCxQ4MtzYo7QBVHGV/VRCnLP7ZIh/mH9qsderLIdxAK
         XLwNFsrz3Z8pW7hA9JhpXKwBvmGFd3xzrvttd9aZIAKirn9EibBAW8qwXfwWkC9F5bzo
         TzkjJjiz30SOnHz+XGWfZNIZEBhP6/E0Tlw3C36JVVu+9qbA3qwDGb21PYjM0rPKd0ih
         Z/Zg==
X-Gm-Message-State: AOAM533VJKZ9sqp5NuEW3jNZkeLEyiQ3a18l9uxd6nz3a3o3m4hH1mYP
	/yPb9KykQYbFWmT9Yk6x93qyY85hzcz7xg==
X-Google-Smtp-Source: ABdhPJyIOZypjw0xiXoJPxFtyeK3GGsbVgj+mW0wzgaLrnVX8t4pZC+iWG08m0+8AutRQv38KstYUA==
X-Received: by 2002:a5d:470f:: with SMTP id y15mr21737201wrq.420.1599493803831;
        Mon, 07 Sep 2020 08:50:03 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (d.f.d.f.5.0.6.0.0.2.6.1.6.b.c.7.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:7cb6:1620:605:fdfd])
        by smtp.gmail.com with ESMTPSA id i16sm25630526wrq.73.2020.09.07.08.50.03
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 08:50:03 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2] cooker: Avoid parser deadlocks
Date: Mon,  7 Sep 2020 16:50:02 +0100
Message-Id: <20200907155002.1928764-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
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
 lib/bb/cooker.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index e781ff8b30..7de3df018d 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1993,7 +1993,8 @@ class Parser(multiprocessing.Process):
             except queue.Empty:
                 pass
             else:
-                self.results.cancel_join_thread()
+                self.results.close()
+                self.results.join_thread()
                 break
 
             if pending:
@@ -2002,6 +2003,8 @@ class Parser(multiprocessing.Process):
                 try:
                     job = self.jobs.pop()
                 except IndexError:
+                    self.results.close()
+                    self.results.join_thread()
                     break
                 result = self.parse(*job)
                 # Clear the siggen cache after parsing to control memory usage, its huge
@@ -2121,8 +2124,6 @@ class CookerParser(object):
 
             bb.event.fire(event, self.cfgdata)
 
-        # Allow data left in the cancel queue to be discarded
-        self.parser_quit.cancel_join_thread()
         for process in self.processes:
             self.parser_quit.put(None)
 
@@ -2142,7 +2143,8 @@ class CookerParser(object):
                 process.join()
 
         self.parser_quit.close()
-        self.parser_quit.join_thread()
+        # Allow data left in the cancel queue to be discarded
+        self.parser_quit.cancel_join_thread()
 
         def sync_caches():
             for c in self.bb_caches.values():
-- 
2.25.1

