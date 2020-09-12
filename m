Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web12.19101.1599922923116859525
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 12 Sep 2020 08:02:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=N51Koy/S;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.68, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f68.google.com with SMTP id z4so14248082wrr.4
        for <bitbake-devel@lists.openembedded.org>; Sat, 12 Sep 2020 08:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IPOyw7wzlU6Q7qySRoiBkSm2D22Y7/65SdfGetkewb4=;
        b=N51Koy/S7SXeOgDrPJojFe9z+bBZWYO+XkeYcyI3VW7XMnSNk5P+PDgtbZAMmpeodD
         ra/fdZC2tpoA/efnaYJv5XOp64RhNaU0LQWelnlze8ma3Zt5mT14FgPMGgABUTOt/JpK
         w9zUN1OQSKTOaN2MTw26QA58+mXPvhH2CtIeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IPOyw7wzlU6Q7qySRoiBkSm2D22Y7/65SdfGetkewb4=;
        b=VEkc14ryVhLXdbzL3JOehJxuC4DEataFzm/g4eSkVrRbyf3zuWhWk677EroTvP6Axt
         3pUs9l8F1GryGLnuPu9YQjhkyMQ2+IowDDMyJOpt7nouozYwCF7fghGaBUuZOPMqH1fB
         UC6RlgcHBnCnxUW3VWw8i9gQ/g6OPqWIMFDawc9c1pAt3qaMJ1RSKykJttxkdi/OEfOL
         jvE6gfSYwOphkc/sxdWZnMrVavth9yUiaY2+Ix0gIvv1MnAUPO8BmI1fm1Lc2DMDnRJX
         OLPe4khQWbFQfHZTjr3EzTuDsJJBV7Gv4GMf/XRucl4Be6HO59nBhhbN9y9+9OotvWIk
         DuTQ==
X-Gm-Message-State: AOAM531p9u8T6nGEOs7/HMrBsALWLo4TPPBZZyEfiPlCO7MbldSZPaZW
	jKqscQ5sFXT5Mx3OHKum0MmtUf7PFycwZQ==
X-Google-Smtp-Source: ABdhPJz/mOuQeMmNQyNOTggcqQTetkhRcSu867kCXjcWj0Jf4RyUfzfpnS3uu1O/hLMdNTrzz5K+Ng==
X-Received: by 2002:a5d:5106:: with SMTP id s6mr7609048wrt.166.1599922920862;
        Sat, 12 Sep 2020 08:02:00 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (8.4.6.b.e.8.e.4.6.7.0.3.a.2.d.2.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:2d2a:3076:4e8e:b648])
        by smtp.gmail.com with ESMTPSA id l126sm10256804wmf.39.2020.09.12.08.02.00
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 08:02:00 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] tinfoil: Ensure sockets don't leak even when exceptions occur
Date: Sat, 12 Sep 2020 16:01:59 +0100
Message-Id: <20200912150159.2110698-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're seeing leaking open socket connections when errors occur and
tinfoil is in use. Improve the exception handling so the sockets
are closed even if exceptions occur, allowing more robust behaviour
when things go wrong.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tinfoil.py | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 5755e5a346..2fb1bb7d27 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -806,18 +806,22 @@ class Tinfoil:
         prepare() has been called, or use a with... block when you create
         the tinfoil object which will ensure that it gets called.
         """
-        if self.server_connection:
-            self.run_command('clientComplete')
-            _server_connections.remove(self.server_connection)
-            bb.event.ui_queue = []
-            self.server_connection.terminate()
-            self.server_connection = None
-
-        # Restore logging handlers to how it looked when we started
-        if self.oldhandlers:
-            for handler in self.logger.handlers:
-                if handler not in self.oldhandlers:
-                    self.logger.handlers.remove(handler)
+        try:
+            if self.server_connection:
+                try:
+                    self.run_command('clientComplete')
+                finally:
+                    _server_connections.remove(self.server_connection)
+                    bb.event.ui_queue = []
+                    self.server_connection.terminate()
+                    self.server_connection = None
+
+        finally:
+            # Restore logging handlers to how it looked when we started
+            if self.oldhandlers:
+                for handler in self.logger.handlers:
+                    if handler not in self.oldhandlers:
+                        self.logger.handlers.remove(handler)
 
     def _reconvert_type(self, obj, origtypename):
         """
-- 
2.25.1

