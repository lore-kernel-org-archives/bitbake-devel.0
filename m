Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
 by mx.groups.io with SMTP id smtpd.web11.988.1606939096602536777
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 02 Dec 2020 11:58:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=g0Fe6+2H;
 spf=pass (domain: gmail.com, ip: 209.85.167.195, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f195.google.com with SMTP id x16so2915917oic.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 02 Dec 2020 11:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NlEyaef5FTBG3DIzsoT5P2rz0Nf18EFOQtHTRL/PZvY=;
        b=g0Fe6+2HtbgtdT3nZwfApdkq3ziIVKAmNw3HdOeAhsOYO+iuIiARLhf/2X6og/zb11
         zx2oTYHPsVfsxjPMMcj+aPN33oq4J+57hq8bMidhb+js4XP4dLQqTzipyuPntr/G8g/X
         BV448MyFdaFQhFPE663Vg4q/k9Ev9k7svqFxGjNwF95HakSep5EbHPxY8c00sHxfb3q3
         0Z/zv/8zqoEiNAgvAQO4VOmfEdYvquvlaCLlzbu7q2S2VeHxJ/9fRVsROZDL/2xzNuBj
         sTQbnsPyvvRyfuvyg3FS857Q1rIkbRbH09/mTzV4gMxlH8T1ehvln2hzufdNilpRlTKJ
         15Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NlEyaef5FTBG3DIzsoT5P2rz0Nf18EFOQtHTRL/PZvY=;
        b=I+DCdM+LPvUCtx1f+90WPX5A1KMlMWnVwa4FWRLGfeSR9APhYLU54Cg5vno3/0gknB
         ShCNGLQZVC5I/BLIZeboID5+nT0gcdeZ1Vn7LBzLGihJ4ofEZLnL5pLGjCqGisFrihh4
         hqLsx1R/89SJJ5wJMMiy/2MSgF9AjdUmixkxcuupnQMBd3AQ1n5yAE6dZiXX3aNCrpqW
         vukhYJpEv4rgLBpXJtoEfHjYHJhOICPRoYW21w3X1ZeTd96H7vW2hUQ5J5dN7vrFUl/0
         hvxsrYh9BJHnroy3ornOR6VQywpxLN1UDKhRLG+7CNd3siYxf+58zVvLAdgRx1RocoU7
         AS8A==
X-Gm-Message-State: AOAM531+YVVnbJlHvuNV4jbbuK8dHIXltyKdoBPEVXcJIugc+P2BFOTy
	vlpQkbCDFOzSz29A0mxaQejJzmmG+opV7A==
X-Google-Smtp-Source: ABdhPJz52NbYIYeWT0DlEotQ/E50UOYaZ2GaRSVkWGLwQ5ymHrkE/DtOsAwB41+VU24dEZXyjZCj7w==
X-Received: by 2002:aca:5052:: with SMTP id e79mr2783456oib.58.1606939095695;
        Wed, 02 Dec 2020 11:58:15 -0800 (PST)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:e3e8:d9:3a56:e27d])
        by smtp.gmail.com with ESMTPSA id 6sm598424otc.19.2020.12.02.11.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:58:14 -0800 (PST)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: anuj.mittal@intel.com,
	Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] hashserv: client: Fix AF_UNIX path length limits
Date: Wed,  2 Dec 2020 13:58:10 -0600
Message-Id: <20201202195810.20800-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Restores a fix for unix domain socket path length limits when using the
synchronous hash equivalence client that was accidentally removed when
the async client was added.

Unfortunately, it's much more difficult to fix the same problem when
using the async client directly due to the interaction of chdir() and
async code, but this will at least restore the old behavior in the
synchronous case.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/hashserv/client.py | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/hashserv/client.py b/bitbake/lib/hashserv/client.py
index ae5875d1b3..7bbf0865d5 100644
--- a/bitbake/lib/hashserv/client.py
+++ b/bitbake/lib/hashserv/client.py
@@ -40,7 +40,7 @@ class AsyncClient(object):
 
         self._connect_sock = connect_sock
 
-    async def _connect(self):
+    async def connect(self):
         if self.reader is None or self.writer is None:
             (self.reader, self.writer) = await self._connect_sock()
 
@@ -62,7 +62,7 @@ class AsyncClient(object):
         count = 0
         while True:
             try:
-                await self._connect()
+                await self.connect()
                 return await proc()
             except (
                 OSError,
@@ -190,7 +190,6 @@ class Client(object):
 
         for call in (
             "connect_tcp",
-            "connect_unix",
             "close",
             "get_unihash",
             "report_unihash",
@@ -209,6 +208,16 @@ class Client(object):
 
         return wrapper
 
+    def connect_unix(self, path):
+        # AF_UNIX has path length issues so chdir here to workaround
+        cwd = os.getcwd()
+        try:
+            os.chdir(os.path.dirname(path))
+            self.loop.run_until_complete(self.client.connect_unix(path))
+            self.loop.run_until_complete(self.client.connect())
+        finally:
+            os.chdir(cwd)
+
     @property
     def max_chunk(self):
         return self.client.max_chunk
-- 
2.29.2

