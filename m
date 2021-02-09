Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web10.11673.1612883318727980538
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Feb 2021 07:08:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=O0Ac/ZGa;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id b3so22320310wrj.5
        for <bitbake-devel@lists.openembedded.org>; Tue, 09 Feb 2021 07:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tFqe2eMRZNE5liqNbfhCsRWde5oxzxE9RVMhSnDnGzI=;
        b=O0Ac/ZGaX2mNIZeMdPs/SE2JRK+uiU6EMHVqguyWiMInTyo0N6HtK5BejLpxbi472N
         mrxkkY9cFehyO7kM+5wI9Mzd+AI1x6S1mpnxqeHHeezjr6ZM4uyBScJmFDemxyopLzvZ
         u/fZHzNYLhJDlZmtlLZEqddoIE5FSQDEqu4+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tFqe2eMRZNE5liqNbfhCsRWde5oxzxE9RVMhSnDnGzI=;
        b=iVWwlqCd7swI5Ph0aYEfPBx0Q/or4lWBqH3rC4FT+Zl23KOmLZw1uz/eLnSDXDTx9O
         06X8vSrkQMbHJYgcg2gLjpG8EdU7AW0kKiZ/xeQvxDa+7AauxXxzmLwLyoKBjFPIOUB1
         KB0+8DHXSlop1lLyuD+dOnQ2tE4VqNf2clzV4rc5XL3S6upP4USpamyJU1Tw0PpGJi20
         Iv/AR+rCfK+sEG4Sn7onlQ0xDP+dQtSO1t8edPwK1JormRnKKX300POhZ/sdikAf5elv
         z0iC/L9zEmpOM+9As0mutgznwNQ+4p3GtmlxVS5O0i09DW2VDuY6uPfU4hjfgiQLD7uO
         IXOQ==
X-Gm-Message-State: AOAM532G/Nm0kaNsTjEXaod9RfVqv+yMw2zTLTnwPTSxcHydFfj7PP03
	NohnN6p+J6XncKJJ/eyG/+8Jw0CNdwEg8g==
X-Google-Smtp-Source: ABdhPJzOZL1epN5mruxh3luxFOJBvQvz/ayNC+FACLEO65LEQQpLixIoswPEsgMfdW0Srpg5LXVmcQ==
X-Received: by 2002:adf:e3cd:: with SMTP id k13mr4860883wrm.289.1612883317037;
        Tue, 09 Feb 2021 07:08:37 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:6e64:a4a9:6e48:217c])
        by smtp.gmail.com with ESMTPSA id 67sm5236280wmz.46.2021.02.09.07.08.36
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 07:08:36 -0800 (PST)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] cooker: Ensure reparsing is handled correctly
Date: Tue,  9 Feb 2021 15:08:35 +0000
Message-Id: <20210209150836.1809879-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From tinfoil, if you edit bblayers.conf and break it, then call
parseConfiguration (e.g. by adding a bad layer with bitbake-layers),
the system doens't show any parse error yet it should.

Add in a call to the updateCache function so that things really
are reparsed when requested.

Partially fixes [YOCTO #14054]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 4446addc77..67bf925441 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -411,6 +411,8 @@ class BBCooker:
             self.data.disableTracking()
 
     def parseConfiguration(self):
+        self.updateCacheSync()
+
         # Change nice level if we're asked to
         nice = self.data.getVar("BB_NICE_LEVEL")
         if nice:
-- 
2.27.0

