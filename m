Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web12.11653.1599132271122883171
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 03 Sep 2020 04:24:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Nkhr6wZR;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id s13so2475488wmh.4
        for <bitbake-devel@lists.openembedded.org>; Thu, 03 Sep 2020 04:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=66MW0OK9Znus/bo4w2SqQaoTVFNt580MRgmT1yTHT+I=;
        b=Nkhr6wZRQ4vcrtMdhxTMkS/FkOdNMqfVKBv3JB1hkLdK/BAJwi+0Y8MqDK1SrYD8/I
         IgHB4dsuXHxDrmqz9rHYIAKfNQH+92BfZqYaz3iCvA8j+D/GZbAfaOrrzOOry6rZvJcL
         BY9Cq8X67CgBm8bko2kvbczN4XEp5xQAeirBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=66MW0OK9Znus/bo4w2SqQaoTVFNt580MRgmT1yTHT+I=;
        b=LM0vkHwenItUOgNbdBNQRyPVuQQYDY3EJEA9xYeQSUrmJ7bcNSMHl5f877hoQJXiUV
         hwlyV+fEBKun5mmVRDVb5y+7CO0Rh0Y3vKqK4aWLCD/S5swr/e5sy3meZd+ioPBkvDRm
         Zo9goF4ABPwuEx7GbbqPXO8FxwapStOUOVfjdxZzIEhuwn1G+DN/wxSdbDi91XPpjjXS
         /iw3wewcvEpp9Cbn0PLkiiHAYHekLVerjeVz2trWbt6wFXwtqOxtFkixN5YEnH9WAnQr
         Nq72TSGE0qXZkIqxypcnIckbY16H2tQWrFQbjIWJkuLccnOIXlTqAzTIMWB1W25Z4tXJ
         kJIg==
X-Gm-Message-State: AOAM5306VDme4K0Ze4oAK2c0ehv1xWrome74KtI5UsWZVnAl+m5Hla9+
	ExzixOEtkSkYGnDQqNVYL1y4LXKnUFSxbw==
X-Google-Smtp-Source: ABdhPJzyUHESmCOGSNkWHAtUzcUQBp8EAJY0B5+anWej0Dfzf064SAQNEY5ndIHJqn+6MJDmg2axrA==
X-Received: by 2002:a1c:1d17:: with SMTP id d23mr2025096wmd.187.1599132269324;
        Thu, 03 Sep 2020 04:24:29 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (d.f.d.f.5.0.6.0.0.2.6.1.6.b.c.7.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:7cb6:1620:605:fdfd])
        by smtp.gmail.com with ESMTPSA id f1sm3974013wrt.20.2020.09.03.04.24.28
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 04:24:28 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/3] cookerdata: Fix exception raise statements
Date: Thu,  3 Sep 2020 12:24:26 +0100
Message-Id: <20200903112427.1777983-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903112427.1777983-1-richard.purdie@linuxfoundation.org>
References: <20200903112427.1777983-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lets use valid python even if it the original happens to work.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cookerdata.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 48953a830b..91cc4347f6 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -300,13 +300,13 @@ class CookerDataBuilder(object):
 
             self.data_hash = data_hash.hexdigest()
         except (SyntaxError, bb.BBHandledException):
-            raise bb.BBHandledException
+            raise bb.BBHandledException()
         except bb.data_smart.ExpansionError as e:
             logger.error(str(e))
-            raise bb.BBHandledException
+            raise bb.BBHandledException()
         except Exception:
             logger.exception("Error parsing configuration files")
-            raise bb.BBHandledException
+            raise bb.BBHandledException()
 
         # Create a copy so we can reset at a later date when UIs disconnect
         self.origdata = self.data
-- 
2.25.1

