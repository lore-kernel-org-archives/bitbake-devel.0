Return-Path: <ricardo@foundries.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0280C433FE
	for <webhook@archiver.kernel.org>; Thu, 14 Apr 2022 20:37:09 +0000 (UTC)
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com
 [209.85.160.42])
 by mx.groups.io with SMTP id smtpd.web08.213.1649965404013287339
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Apr 2022 12:43:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@foundries.io header.s=google header.b=hWJgZGms;
 spf=pass (domain: foundries.io, ip: 209.85.160.42,
 mailfrom: ricardo@foundries.io)
Received: by mail-oa1-f42.google.com with SMTP id
 586e51a60fabf-e2fa360f6dso6312079fac.2
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Apr 2022 12:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=19vOzTWH/l+DYofKWl0scEcXMgPMc4CzURUIsgCGsvU=;
        b=hWJgZGmsXIlTaP7pj1N2KIgIsxdyu0T/2/JMd7olin1RTL4KZdXHY2r6H/6ZECtCDY
         zbJgumttqO0lSBahfya71RVMPjugHOIndLJ3+yiNUAmeTdXCKiMNVzukMkG0J2VIB2MR
         96Fi5jwlM0DjBQCFa4PZ94EeuYb8RzG4TuZPzZi6DWH3dx2O7AXdnyC37FYGOO56rmNH
         tq1pvMb5fWrdGyEgWcrrQHCxYJpv4zSB9HQInFGSVQYgqOpAHzq+0K0+VVdqaER0UHyG
         Y3rCA+eLGCuuUMEYmacA25xbWrc+dg2mRUWbNclqIhAKzaN2yl1rz9aP0rt05CmWRoi8
         RuHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=19vOzTWH/l+DYofKWl0scEcXMgPMc4CzURUIsgCGsvU=;
        b=kjyAejUSK8AVJK/9uOqB4txMR9GG8D1HM6d+CZvfhvBLJK3zEG16NDBdKCRhb+p+tl
         6t8Nt/jDzMsHlA0tlt4bwDqePAuvlsLb69OVgdRvU77EeWvu5h5A8vWon7kXTHXIdHyU
         0eXlbHnkFS0PAhyaXOCGFfwGZrd0YW9jQsZbHhxot+LVBCw1/TAyjrC6IL5jhvhSSSn+
         ZXqz8UxgHYmV+BALPhBCrrkGZFd36sbqcxpi0Fi1xTOOmkCFnFJwkOxcOP4YQlkaUtw3
         JGM/dBkMYzuX9rzz0GEGZPGduTVqOFhinbRbeZewDSrvGej0VXatbOae78eM/y8rtsyu
         c4YA==
X-Gm-Message-State: AOAM533HNotsjRzanESjwRa6C/bxO5ifYTwSuDbN/CftIKg1j6cGlizS
	A9Rq55aOMwYmix85CMNPeASuf3d245jL
X-Google-Smtp-Source: 
 ABdhPJwt1fCo6WQRCelBJJTkSHAvrBbUBj2dab14YzZb9bYCSaaMiWWM91H7xJERm1OlMRNsePLjrA==
X-Received: by 2002:a05:6870:a106:b0:e5:929b:130e with SMTP id
 m6-20020a056870a10600b000e5929b130emr17496oae.92.1649965402742;
        Thu, 14 Apr 2022 12:43:22 -0700 (PDT)
Received: from localhost.localdomain ([179.181.86.70])
        by smtp.gmail.com with ESMTPSA id
 t10-20020a056830224a00b005cd9db03fabsm359931otd.78.2022.04.14.12.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 12:43:22 -0700 (PDT)
From: Ricardo Salveti <ricardo@foundries.io>
To: bitbake-devel@lists.openembedded.org
Cc: openembedded-core@lists.openembedded.org,
	daiane.angolini@foundries.io,
	caio.pereira@foundries.io,
	Randy.MacLeod@windriver.com,
	anuj.mittal@intel.com
Subject: [PATCH] bitbake: fetch2: crate: fix logger.debug line
Date: Thu, 14 Apr 2022 16:42:59 -0300
Message-Id: <20220414194259.2436452-1-ricardo@foundries.io>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 Apr 2022 20:37:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13624

logger.debug was giving an integer value (2) as event message, causing
knotty to crash when running with debug enabled.

bitbake/lib/bb/ui/knotty.py", line 685, in main
  event.msg = taskinfo['title'] + ': ' + event.msg
TypeError: can only concatenate str (not "int") to str

Same issue also happens in the original code that was taken from
oe-core (openembedded-core/meta/lib/crate.py honister) / meta-rust.

Signed-off-by: Ricardo Salveti <ricardo@foundries.io>
---
 lib/bb/fetch2/crate.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
index f7e2354a..aac1221c 100644
--- a/lib/bb/fetch2/crate.py
+++ b/lib/bb/fetch2/crate.py
@@ -72,7 +72,7 @@ class Crate(Wget):
         ud.parm['downloadfilename'] = "%s-%s.crate" % (name, version)
         ud.parm['name'] = name
 
-        logger.debug(2, "Fetching %s to %s" % (ud.url, ud.parm['downloadfilename']))
+        logger.debug("Fetching %s to %s" % (ud.url, ud.parm['downloadfilename']))
 
     def unpack(self, ud, rootdir, d):
         """
-- 
2.35.1


