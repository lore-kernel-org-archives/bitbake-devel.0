Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web12.88.1599231333672852544
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 04 Sep 2020 07:55:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=MKp0dhFr;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id q9so6353004wmj.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 04 Sep 2020 07:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=pQ80sqiPIhAs/5Yiotz7peurmEPqWHqBZ8agOU3Fqkk=;
        b=MKp0dhFrmu345sW2q6H79rXuw1NFlOcpfjvkEL8RgDf3OX/z+PvqE/I3hHRcwyW0+n
         HvPu/TP8U5lit8h/LqDiUOCe87pOIXhXRBmqRxaFKsPWGGPQaFh8gleWLsqt5LXvmgVe
         RgkD5tDRX1EL8Fe9bxwgkEFBiNTfyY8JXUn6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pQ80sqiPIhAs/5Yiotz7peurmEPqWHqBZ8agOU3Fqkk=;
        b=P0TEJUkYzaAlbthYfZavGGztpixxXi8BYaoQ//ejg0w/2GSHAjnJSden19Ikki0T1A
         BLY2h1sDMHK/K5D5EWNMXiSVdvPXhKh1i51ymVpzpm87rtbS88MypG1K5aU4hDNp6vVp
         dRZbq+UAgG0V73pvRwMlpymNr6J/Q7ux6NhvTk+GHB/BNjGDteRHkA4csMQBWEiIpYQX
         oYobHu2KrlOjAceLF2nDtdeIyhknHX/2yv7uaGi/+q1W2z1dtyCXgQT9U1LWqeSZjg7n
         WGOC58eb/Bq8whEfYsDE0WgOtEb1mu2UBRYLS211Vm5XxENyhJysd2WpJxbyQzys5Mgj
         bG+Q==
X-Gm-Message-State: AOAM532GXMWUcsh9j+U8rVz6EofXlcUb/yfld2mVPFNSAXTBxWnH8bgK
	n1XFYg+IcjnoUa8IrB9GngI53M6f2eWktg==
X-Google-Smtp-Source: ABdhPJzSV3Z04kQts9PSRJm9CRD8dy+LDo9auibtLnSgSJQIzqEa/gwgSLdYV+wdHPyUfsfw1koN+Q==
X-Received: by 2002:a1c:5581:: with SMTP id j123mr8130454wmb.11.1599231331489;
        Fri, 04 Sep 2020 07:55:31 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (d.f.d.f.5.0.6.0.0.2.6.1.6.b.c.7.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:7cb6:1620:605:fdfd])
        by smtp.gmail.com with ESMTPSA id z11sm11684050wru.88.2020.09.04.07.55.30
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 07:55:31 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] cooker: Assign a name to the sync thread to aid debugging
Date: Fri,  4 Sep 2020 15:55:29 +0100
Message-Id: <20200904145529.1817812-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904145529.1817812-1-richard.purdie@linuxfoundation.org>
References: <20200904145529.1817812-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index ac64b0e1bc..30d7278505 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2151,7 +2151,7 @@ class CookerParser(object):
             for c in self.bb_caches.values():
                 c.sync()
 
-        sync = threading.Thread(target=sync_caches)
+        sync = threading.Thread(target=sync_caches, name="SyncThread")
         self.syncthread = sync
         sync.start()
         bb.codeparser.parser_cache_savemerge()
-- 
2.25.1

