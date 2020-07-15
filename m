Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
 by mx.groups.io with SMTP id smtpd.web11.7965.1594823260628845490
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Jul 2020 07:27:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=v0Zkj7SU;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.65, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f65.google.com with SMTP id ls15so3152528pjb.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 15 Jul 2020 07:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=IY1HPtHAFw2UxeGcUnK9Y6Y4+sC/eGYINII+seWVHW4=;
        b=v0Zkj7SUrDSfNEUa2UM9e4R75KK93i0CFkVYuKRvqRzmGy4fWTPnJiYPLKRraLeNhX
         V9oeflUrO/W5EQzv6N/A31SSa6FtaV3JdgLdqJNc5n5vdu9bQhe6JeNTka17C9Lq6Nr6
         qYAupoBidHMzPts6X//FL0cMGF13RRfDFHRBixPv3ccsHOQcEYszdPbn6Z1OfiH2Jbvi
         Kgo2jrq8TZYxiCOEzXslLriCb0W6qTeUDqh53qg07OHrf/MEVSx47KH54ydA1iAUUZM/
         MRwxOnQR1rQrZpy193ioqYYjkig0t4WEzDYDkUPTDsTkyl+0K/OTfZljFn9Twj043F6r
         wxQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=IY1HPtHAFw2UxeGcUnK9Y6Y4+sC/eGYINII+seWVHW4=;
        b=e5yIMOYWAl8U+dKQdKtnfsibYQAdfM1zhF5Wl0qoD0nRnatLGbGLIGahTDmbXYNnB9
         ZcfpPXUuMXGuUleK/AEztoXDhqeMFiStpgD7fecOmZUHsPf20NH4EDTg83GFkhfKeG6E
         5mDJucuEn3Qi6oWrDUB9vsxNkiEK9rhAHyPGEqcCv7DoA0PSM2u5LoUiNpakBimUvoQP
         w4BjirAjtxZESa0SPn/IuEgutPV9V+LwHXuAF/gKzHUSnolSTNwVp01z2C8hRQQfXo+6
         AL3o7ARYpE0k1gFjYvvA31fwneoXaYiB9O28yOzOKaHvt3/OXd5XfP2hedBpMuBvRxIS
         +33w==
X-Gm-Message-State: AOAM530K5L+2UkEAZA9+yh1/mQRQURm+HIH5xHACXbVnhYMmG3QrNi19
	TTFN3Y/RKc3ZxjbfBrmEoQHn2MAYd72+2Q==
X-Google-Smtp-Source: ABdhPJxM8MrJANqQ5BaheO5luBl1B2DOcitqSuP/7Y1ekelSbdZan41rFcWrS2FnqvM6s5nSaN8MCQ==
X-Received: by 2002:a17:90a:c715:: with SMTP id o21mr11023167pjt.35.1594823259692;
        Wed, 15 Jul 2020 07:27:39 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from octo.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id i125sm2423915pgd.21.2020.07.15.07.27.38
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 07:27:39 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 8/8] server/process: Ensure UI-less servers don't sit in infinite loops
Date: Wed, 15 Jul 2020 04:26:50 -1000
Message-Id: <81cad9b8c4df15218d1a419c6b8e3ac73b54600c.1594822992.git.steve@sakoman.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1594822992.git.steve@sakoman.com>
References: <cover.1594822992.git.steve@sakoman.com>

From: Richard Purdie <richard.purdie@linuxfoundation.org>

If server startup is broken for some reason (e.g. lockfile issues)
and no UI connection is made, the server will just sit inifinitely
waiting.

Add a timeout upon startup in the non-memory resident case so that
such infinite waits are avoided. In the memory resident case, the
server wouldn't have shut down in the first place or will timeout
according to configuration.

Since any race may mean the socket file is no longer present, ensure
the unlink doesn't fault upon exit, thus ensuring any hashequiv or
PRServ is removed from memory, allowing all processes to exit
cleanly in such scenarios.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 39888b750df12478e8bdea6727cca112dce1df85)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/server/process.py | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 475931a7..d4beac43 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -48,7 +48,7 @@ class ProcessServer(multiprocessing.Process):
 
         self.event_handle = None
         self.haveui = False
-        self.lastui = False
+        self.maxuiwait = 30
         self.xmlrpc = False
 
         self._idlefuns = {}
@@ -155,6 +155,7 @@ class ProcessServer(multiprocessing.Process):
                 print("No timeout, exiting.")
                 self.quit = True
 
+        self.lastui = time.time()
         while not self.quit:
             if self.sock in ready:
                 while select.select([self.sock],[],[],0)[0]:
@@ -191,11 +192,18 @@ class ProcessServer(multiprocessing.Process):
                 except (EOFError, OSError):
                     disconnect_client(self, fds)
 
-            if not self.timeout == -1.0 and not self.haveui and self.lastui and self.timeout and \
+            if not self.timeout == -1.0 and not self.haveui and self.timeout and \
                     (self.lastui + self.timeout) < time.time():
                 print("Server timeout, exiting.")
                 self.quit = True
 
+            # If we don't see a UI connection within maxuiwait, its unlikely we're going to see
+            # one. We have had issue with processes hanging indefinitely so timing out UI-less
+            # servers is useful.
+            if not self.haveui and not self.timeout and (self.lastui + self.maxuiwait) < time.time():
+                print("No UI connection within max timeout, exiting to avoid infinite loop.")
+                self.quit = True
+
             if self.command_channel in ready:
                 try:
                     command = self.command_channel.get()
@@ -220,10 +228,13 @@ class ProcessServer(multiprocessing.Process):
 
         print("Exiting")
         # Remove the socket file so we don't get any more connections to avoid races
-        os.unlink(self.sockname)
+        try:
+            os.unlink(self.sockname)
+        except:
+            pass
         self.sock.close()
 
-        try: 
+        try:
             self.cooker.shutdown(True)
             self.cooker.notifier.stop()
             self.cooker.confignotifier.stop()
-- 
2.17.1

