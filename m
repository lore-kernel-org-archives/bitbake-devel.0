Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web10.822.1632170431634161098
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 20 Sep 2021 13:40:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=FRkJgDEG;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id q26so33167828wrc.7
        for <bitbake-devel@lists.openembedded.org>; Mon, 20 Sep 2021 13:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EqnkVV2wGcaqXe/Dgb0yGGoG/gQbgQG7Ar8fM5vbfOg=;
        b=FRkJgDEGdZLo/JHoNhDaiOL8j+M39AVQoeRdr7rx4msWSH4EZy3eJAYPOx2NKfHtFe
         V8yo1M2O3+KW554fQhqCkR948H0haRegiQ/Q+ja7VBwhjjlNwDSj4ziXVibsj/dCA0Tb
         pg/tGkTjvIskkoWBGCCarWtKhdpOLhRxhGy1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EqnkVV2wGcaqXe/Dgb0yGGoG/gQbgQG7Ar8fM5vbfOg=;
        b=NyDWq8t5cSYLztkZn05rVFNGMvBoCL9AonKd2sIyZQ70fvEogyR2bMIXELXF+RAOFr
         Y05fnUzUtnPMrHokj7icuNAUeMT603iiCBhPakczutB+7MVjaeuS/rm9Ij9YQp1tLQOE
         CEwRpuMh9K4HH+hcgPqvMEY8G/Hl6qrLpSm+/O0/sOV1MmhF7d60Wm1J1G7Lpmv8lDYf
         kgFgNpVRfr9CcsLO39VK6Px05kI62qkdNH8b65BihEAcR6BhnHdQsri4ZrrC1hvWCorG
         ZSYhwzMsXrs5qnnvobWNl1Qg5VtHzTplaaR1OolRV1erWvkzMxi+STVGHQpU3PknJNJf
         n+bg==
X-Gm-Message-State: AOAM533ex1vG1HAOwLSZBIVtH2y9L49VzA1oYTbdPThh9eliDPjWQ/6h
	VrjRR0L0UdP8OTlGUxYS2ozEdEcqw8hPsNGv
X-Google-Smtp-Source: ABdhPJw7zVnVvlBDkWU9/rxf9Ydd3eMufFaQmvrJGGDqlDUAd0bOrOlfsaXdn5bQ8awGuZ/YJKvKtQ==
X-Received: by 2002:a1c:9851:: with SMTP id a78mr894566wme.107.1632170429668;
        Mon, 20 Sep 2021 13:40:29 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:97b0:b8a0:39a5:2c93])
        by smtp.gmail.com with ESMTPSA id r27sm17167101wrr.70.2021.09.20.13.40.29
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 13:40:29 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch2/svn: Allow peg-revision functionality to be disabled
Date: Mon, 20 Sep 2021 21:40:28 +0100
Message-Id: <20210920204028.1590226-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes the peg revision functionality we use in the svn fetcher is
not the correct option. Add a parameter nopegrevision which can be added
to disable this behaviour.

[YOCTO #6258]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/svn.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/svn.py b/lib/bb/fetch2/svn.py
index 80102b44f2..d40e4d2909 100644
--- a/lib/bb/fetch2/svn.py
+++ b/lib/bb/fetch2/svn.py
@@ -57,7 +57,12 @@ class Svn(FetchMethod):
         if 'rev' in ud.parm:
             ud.revision = ud.parm['rev']
 
-        ud.localfile = d.expand('%s_%s_%s_%s_.tar.gz' % (ud.module.replace('/', '.'), ud.host, ud.path.replace('/', '.'), ud.revision))
+        # Whether to use the @REV peg-revision syntax in the svn command or not
+        ud.pegrevision = True
+        if 'nopegrevision' in ud.parm:
+            ud.pegrevision = False
+
+        ud.localfile = d.expand('%s_%s_%s_%s_%s.tar.gz' % (ud.module.replace('/', '.'), ud.host, ud.path.replace('/', '.'), ud.revision, ["0", "1"][ud.pegrevision]))
 
     def _buildsvncommand(self, ud, d, command):
         """
@@ -98,7 +103,8 @@ class Svn(FetchMethod):
 
             if ud.revision:
                 options.append("-r %s" % ud.revision)
-                suffix = "@%s" % (ud.revision)
+                if ud.pegrevision:
+                    suffix = "@%s" % (ud.revision)
 
             if command == "fetch":
                 transportuser = ud.parm.get("transportuser", "")
-- 
2.32.0

