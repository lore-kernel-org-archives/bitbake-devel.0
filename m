Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D405C433FE
	for <webhook@archiver.kernel.org>; Thu, 31 Mar 2022 11:04:42 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web11.5689.1648724681020858347
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 31 Mar 2022 04:04:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=J4enk6dQ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id c7so6655628wrd.0
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 31 Mar 2022 04:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bqexovU5LHPs3zxapw8VuPIT5QcZxRdFhTqn+RW/qoU=;
        b=J4enk6dQsdBqP0T/VYiCtSDBYZRcXYc7zvVQwqKIn3GUmv3MFkW/iDe1u3EbNkVjtj
         xxxE2L8wCkSxlawO06fqvA8HqhfoSjSWSWe4aw8000KHbAkGb5fXsgvspY3TkiCzeWsp
         mt+8wsCagtpSfd3y3QggpEDAQg1tFttQEqbc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bqexovU5LHPs3zxapw8VuPIT5QcZxRdFhTqn+RW/qoU=;
        b=zuFGi9asVHBUVC2UEO6rbhk5QxmVmxxg07TyVpYpcP9iaNLmjTfBG3nR6TwNdgcxaw
         FyefyJktl7OvB/z/U2mlPQg05mZt8ogP0DNZJ++Om75epeMO2sPGlIwocjf5Cg22Wd2k
         +BtY+Fmj8/IFkHC71LnnSJa6yN8oCfoPwthJTZwU6YYb70OhoDtG5kXjGMSdLABWut5Y
         8ZXfq8Z4pBuwd5JRztWPNWofMDNpTlSEDsEQhZdhORoKtoLjvylEJmhOczvRraXsFUJ8
         +nIH4R4838Z+9aKx3ndM0bKjYhXgdtftkNRaH+VEfW9xPM3kS8i6joME8dkUGRNhFXS8
         JS3A==
X-Gm-Message-State: AOAM532FDWIazWCRYvvO+r0jPtDY8EhVcavSy6VEmXjOBfx64ul+I5RU
	3j5L2IP3CBwK0ei/HI1oEiDshKNUW1ptkZrZ
X-Google-Smtp-Source: 
 ABdhPJx+T7ehBA1Dk4RIt4J1sk/nR8FCiqdszC2fWw5P+auvHkyI5fLKJEsecYgFzHzNu2k71YyC0w==
X-Received: by 2002:adf:ed06:0:b0:203:e759:8d51 with SMTP id
 a6-20020adfed06000000b00203e7598d51mr3653704wro.613.1648724679265;
        Thu, 31 Mar 2022 04:04:39 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:6605:7b3b:ef3e:a309])
        by smtp.gmail.com with ESMTPSA id
 m3-20020a5d64a3000000b00203ed35b0aesm33155728wrp.108.2022.03.31.04.04.38
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 04:04:38 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] cooker: Further fixes to inotify to fix memres bitbake
 issues
Date: Thu, 31 Mar 2022 12:04:36 +0100
Message-Id: <20220331110437.1562951-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 31 Mar 2022 11:04:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13555

The previous fix for inotify wasn't quite correct as we need to modify
bbseen before calling add_filewatch(). We also need to ensure the parse
mtime cache is cleared when directories are added/removed. There was also
a typo in the original fix and the wrong watcher was being changed. Fix
the various issues which improves memory resident bitbake testing results.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index f435b18c87..1359d33f77 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -254,9 +254,14 @@ class BBCooker:
         if not event.pathname in self.configwatcher.bbwatchedfiles:
             return
         if "IN_ISDIR" in event.maskname:
+            if "IN_CREATE" in event.maskname or "IN_DELETE" in event.maskname:
+                if event.pathname in self.configwatcher.bbseen:
+                    self.configwatcher.bbseen.remove(event.pathname)
+                # Could remove all entries starting with the directory but for now...
+                bb.parse.clear_cache()
             if "IN_CREATE" in event.maskname:
                 self.add_filewatch([[event.pathname]], watcher=self.configwatcher, dirs=True)
-            elif "IN_DELETE" in event.maskname and event.pathname in self.watcher.bbseen:
+            elif "IN_DELETE" in event.maskname and event.pathname in self.configwatcher.bbseen:
                 self.configwatcher.bbseen.remove(event.pathname)
         if not event.pathname in self.inotify_modified_files:
             self.inotify_modified_files.append(event.pathname)
@@ -272,6 +277,11 @@ class BBCooker:
                 or event.pathname.endswith("bitbake.lock"):
             return
         if "IN_ISDIR" in event.maskname:
+            if "IN_CREATE" in event.maskname or "IN_DELETE" in event.maskname:
+                if event.pathname in self.watcher.bbseen:
+                    self.watcher.bbseen.remove(event.pathname)
+                # Could remove all entries starting with the directory but for now...
+                bb.parse.clear_cache()
             if "IN_CREATE" in event.maskname:
                 self.add_filewatch([[event.pathname]], dirs=True)
             elif "IN_DELETE" in event.maskname and event.pathname in self.watcher.bbseen:
-- 
2.32.0


