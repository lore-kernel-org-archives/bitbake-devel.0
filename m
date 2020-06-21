Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.web12.1610.1592762186465501841
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 21 Jun 2020 10:56:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=JHdOijSM;
 spf=pass (domain: gmail.com, ip: 209.85.218.47, mailfrom: onea.alex@gmail.com)
Received: by mail-ej1-f47.google.com with SMTP id dr13so15596605ejc.3
        for <bitbake-devel@lists.openembedded.org>; Sun, 21 Jun 2020 10:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eH6RCr8HS4L/W6zh4dKWSD9KUqJwFMM60pLuOgzowQU=;
        b=JHdOijSMLobZOEU0dtuuOT5jrF0JqY9OPlwi5aq5sE8V906BHcJSqD1qLFI7/IxA0X
         M7YXf1wyVkbkOAUfrH6anuLKkiyhxWZV2QVSAZ9Yfi4RnFS2lW0S6ubnfZVJEXKmPOVz
         4UULWxLp0tB9+DO7WMZovO3hpZSXUMjG5//Reqr2Xpl6n9ry3yMEIgoSlrgEomuiJ2yO
         uIZX8RodN9RvkeCZYEP41FABUVFxOtjuK13lFgWEbCWS02ZOuhBFTs10bBtK2VMrUKwH
         WT8dWpmbk/F5kOsdslVYEQiGTs0yN0z6yIMHwswZzSYWR/QjJjyGbWLqgzngGvhCVxKq
         CjPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eH6RCr8HS4L/W6zh4dKWSD9KUqJwFMM60pLuOgzowQU=;
        b=kC4h8O2qrR04m5cy6IjIyTvDtNIdiJC62w60G+v/3Z2hzCHQNI4FYefJMe/1DqXK4U
         4plp8eFNbgFvcBirs3EhmZLVWhD1A6JhdDIQp/T4OfgU5NyzfcRJqdzLy8Zx1Y1xIm7R
         lobMQ9ClOjc2czoELX5Tu7bkxYLQJnSo79HG+9G6KRdGhsGRXfi09ujebwFYYeMCTO16
         GUq+i+gAn2ERoH+H0MmHJtL86KEduSGe3+x9ITxIFptfSt+xVTu7VPC9tLW8qxQugVt6
         S5HFgEzOCn0xxmqKQNQMMq2daeWqIBXUhFi1CD9Vlz/LVlYZVPVPedGko3kblRrpz+nz
         9iRg==
X-Gm-Message-State: AOAM532a/FjQJcid5VXK0nFrVRY3jvRaVYfPTpN1sfy7ojwxtpaxtBjC
	LwinNMYccYq7fYoqssuCN/tFJpaRrdkzhg==
X-Google-Smtp-Source: ABdhPJzoKqEr6rxU0xfpaqVYhaRSnhcTfJuM1mIglySKbQS3HBZTZCNCV422oAGzug/uAeich8jYMA==
X-Received: by 2002:a17:906:3905:: with SMTP id f5mr6628438eje.15.1592762184534;
        Sun, 21 Jun 2020 10:56:24 -0700 (PDT)
Return-Path: <onea.alex@gmail.com>
Received: from localhost.localdomain ([82.76.227.25])
        by smtp.gmail.com with ESMTPSA id f17sm10654346edj.32.2020.06.21.10.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 10:56:23 -0700 (PDT)
From: "Alexandru N. Onea" <onea.alex@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: "Alexandru N. Onea" <onea.alex@gmail.com>
Subject: [PATCH 1/2] perforce: add basic progress handler for perforce
Date: Sun, 21 Jun 2020 20:55:29 +0300
Message-Id: <20200621175530.894393-1-onea.alex@gmail.com>
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

