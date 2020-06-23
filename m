Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
 by mx.groups.io with SMTP id smtpd.web11.3095.1592902877374541728
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 23 Jun 2020 02:01:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=mB/cVlRM;
 spf=pass (domain: gmail.com, ip: 209.85.218.49, mailfrom: onea.alex@gmail.com)
Received: by mail-ej1-f49.google.com with SMTP id i14so2418765ejr.9
        for <bitbake-devel@lists.openembedded.org>; Tue, 23 Jun 2020 02:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eH6RCr8HS4L/W6zh4dKWSD9KUqJwFMM60pLuOgzowQU=;
        b=mB/cVlRMnmVTgxz1sglpY1bR+QFiZw8RJkxuHehy2LohHgZ/U7w7F3Z91vjVRQz/mn
         MHeltH3eEeINj4tnk4TetTVrh9ynazRfuOTtZWFfzRwjZVU580uiCjn1ZYdr0NULOPZc
         1pbytfTVTU1rUzvzMYP8oQXHVBpbiem/HIeCA6yS3OOK8dRGMbLzo9oRujIPYRhdwwof
         LYrHK6+VGjSCDRB/i64+Au2Amkdiv4RDRk9ZW0dr5NlfIjq9AsN09/iM56oZOxmmBP9d
         v5oY4D1+lANUQyYZFxn27HFbsi85nQWwCpAPC+lJOIerEkB+xC7V4U/FRfqB5ZWBN4GG
         jidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eH6RCr8HS4L/W6zh4dKWSD9KUqJwFMM60pLuOgzowQU=;
        b=hNtPaRLWNK7TZ+T7Mnlg1fNq/orxP083iqghigWseEB5SRvsxhGO5KcnSUdiatlzus
         bGugkk036X+DCS1wcAKa5dY06j4NQrsP4rRWmLVWCzyIFuw5ZS+L8NoOGOoWOl0mEOdd
         NPHxAVv1TCFH9bYi6aDrS5OMcD64cq7jki/Ki5Ie0Keb2PEDBeAtpiMR2Gk6mSFyO03k
         sxo8+bpK9d0GhHmlUrZKdXC57OcZNLvktRPuK5WBeLP3Rl++x7YUIhk0bedHiCDo+Dk2
         vNB/mky4hgrX1o+YcGrepedWA3kQ47+tz3qugP1jilLl+SXHC/MRAtzE5bk5GqRylE3g
         UvLw==
X-Gm-Message-State: AOAM533yTnlyHZwhj0sxa/n1zrVXNeOXyFvMp+3Dg9JfwR1jNHiBNnWL
	Uh94lf05kecasWH7StVj3vXsWm0i9Cnwng==
X-Google-Smtp-Source: ABdhPJwLjNNl1Yf6G8iqo6n+l0DN0/1FB9cWxR8caGSg4pnb746j9ny95wONq/bB1zB2LAeZCXWTvg==
X-Received: by 2002:a17:906:5949:: with SMTP id g9mr1395367ejr.305.1592902875562;
        Tue, 23 Jun 2020 02:01:15 -0700 (PDT)
Return-Path: <onea.alex@gmail.com>
Received: from localhost.localdomain ([82.76.227.25])
        by smtp.gmail.com with ESMTPSA id k23sm13229119ejk.114.2020.06.23.02.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 02:01:14 -0700 (PDT)
From: "Alexandru N. Onea" <onea.alex@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: "Alexandru N. Onea" <onea.alex@gmail.com>
Subject: [PATCH v2 1/3] perforce: add basic progress handler for perforce
Date: Tue, 23 Jun 2020 12:00:49 +0300
Message-Id: <20200623090051.85367-1-onea.alex@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a basic implementation of a progress handler for the
perforce fetcher, based on the number of files to be downloaded and the
output behavior of the p4 print command used in the fetcher
implementation.

Signed-off-by: Alexandru N. Onea <onea.alex@gmail.com>
---
 lib/bb/fetch2/perforce.py | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/perforce.py b/lib/bb/fetch2/perforce.py
index f57c2a4f..83128cde 100644
--- a/lib/bb/fetch2/perforce.py
+++ b/lib/bb/fetch2/perforce.py
@@ -17,6 +17,36 @@ from   bb.fetch2 import FetchError
 from   bb.fetch2 import logger
 from   bb.fetch2 import runfetchcmd
 
+class PerforceProgressHandler (bb.progress.BasicProgressHandler):
+    """
+    Implements basic progress information for perforce, based on the number of
+    files to be downloaded.
+
+    The p4 print command will print one line per file, therefore it can be used
+    to "count" the number of files already completed and give an indication of
+    the progress.
+    """
+    def __init__(self, d, num_files):
+        self._num_files = num_files
+        self._count = 0
+        super(PerforceProgressHandler, self).__init__(d)
+
+        # Send an initial progress event so the bar gets shown
+        self._fire_progress(-1)
+
+    def write(self, string):
+        self._count = self._count + 1
+
+        percent = int(100.0 * float(self._count) / float(self._num_files))
+
+        # In case something goes wrong, we try to preserve our sanity
+        if percent > 100:
+            percent = 100
+
+        self.update(percent)
+
+        super(PerforceProgressHandler, self).write(string)
+
 class Perforce(FetchMethod):
     """ Class to fetch from perforce repositories """
     def supports(self, ud, d):
@@ -150,10 +180,12 @@ class Perforce(FetchMethod):
         bb.utils.remove(ud.pkgdir, True)
         bb.utils.mkdirhier(ud.pkgdir)
 
+        progresshandler = PerforceProgressHandler(d, len(filelist))
+
         for afile in filelist:
             p4fetchcmd = self._buildp4command(ud, d, 'print', afile)
             bb.fetch2.check_network_access(d, p4fetchcmd, ud.url)
-            runfetchcmd(p4fetchcmd, d, workdir=ud.pkgdir)
+            runfetchcmd(p4fetchcmd, d, workdir=ud.pkgdir, log=progresshandler)
 
         runfetchcmd('tar -czf %s p4' % (ud.localpath), d, cleanup=[ud.localpath], workdir=ud.pkgdir)
 
-- 
2.25.1

