Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web10.3361.1601583403641929487
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 01 Oct 2020 13:16:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=cL9xRTte;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id j2so122421wrx.7
        for <bitbake-devel@lists.openembedded.org>; Thu, 01 Oct 2020 13:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6GXoyIqUTG4JHaa5f/MednVVgLcedMICApNkohfkUNo=;
        b=cL9xRTte1DJFlHG4EmfICIYPHAEOuEuNEOrfvst+a3C47KY9gdRFgB7cES/sBOaLNq
         /SzcU79D1HWQAUecD6SzYwZl7BSFvHk9/SM2Djd1XFwqLlrs4aXjorRXC2vbSbMCX01v
         uPji4bhYwWEEiA+SFE9pmnDjQfprgCS0J9nwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6GXoyIqUTG4JHaa5f/MednVVgLcedMICApNkohfkUNo=;
        b=aGJZerUBAGMh++pYUi7iFVHWagXJgXYlPAducStNqSslHtQfJvA9Y9pNcE+/fKaOd7
         zn8XfC0O5WGx+R5++dWSyl5voxNR8iyVnBsJfFbRqKOe6FHfOL3B/d5rA+EGtR+Sh6sw
         w5MyANy1O6/u4RtNxDPpJbbFwKrt7HNoX8XGXpQBZHHUPixy6usDe1J0E7XbsJ3I8wg7
         G2emRfnSaA6ckWRHz4iEKDfM9Uv95BeKK3QHmI1LKoUiitwiaaZ0eHw8G6SNeAs6UQor
         NWUeTbOrocVXyU6sXz1hqXReWNLnjXPN4Sd95kJrN/+8vlI86wtINTl2ELNSfL+icaPe
         2zHQ==
X-Gm-Message-State: AOAM533DISWSGpqkmHuDJhNHBXUM77jqbXExwGTSepStcdSLQ+kTN/v4
	rnWnZ1IjQI7diMEDN74HLSV6t/8YMHceEw==
X-Google-Smtp-Source: ABdhPJx9sQlA5NyqZr7cPBCLJNvRJD+rfsDAv42dZXVDpnDdY6f6Y4rdlxjqmVykNaLSfYTbxHsIhw==
X-Received: by 2002:adf:f885:: with SMTP id u5mr10566079wrp.382.1601583401805;
        Thu, 01 Oct 2020 13:16:41 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (7.f.c.3.4.0.2.3.2.2.3.7.e.3.c.9.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:9c3e:7322:3204:3cf7])
        by smtp.gmail.com with ESMTPSA id w15sm10241676wro.46.2020.10.01.13.16.40
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 13:16:41 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] cooker: Avoid tracebacks if data was never setup
Date: Thu,  1 Oct 2020 21:16:40 +0100
Message-Id: <20201001201640.2871368-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent changes mean data might not be setup. If its not, avoid tracebacks.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 5442f7d225..1f4cc1e96d 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1679,7 +1679,8 @@ class BBCooker:
         if self.hashserv:
             self.hashserv.process.terminate()
             self.hashserv.process.join()
-        bb.event.fire(CookerExit(), self.data)
+        if hasattr(self, "data"):
+            bb.event.fire(CookerExit(), self.data)
 
     def shutdown(self, force = False):
         if force:
-- 
2.25.1

