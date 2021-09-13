Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web11.26425.1631519829037636650
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 13 Sep 2021 00:57:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bytesatwork-ch.20150623.gappssmtp.com header.s=20150623 header.b=VCQUVv5o;
 spf=pass (domain: bytesatwork.ch, ip: 209.85.128.53, mailfrom: daniel.ammann@bytesatwork.ch)
Received: by mail-wm1-f53.google.com with SMTP id j17-20020a05600c1c1100b002e754875260so5899108wms.4
        for <bitbake-devel@lists.openembedded.org>; Mon, 13 Sep 2021 00:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytesatwork-ch.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=61T6vEndhR9R6fF8Mj/QB/LozyJ2LwA3eIYkBrZmO1A=;
        b=VCQUVv5o7O6O5IoRxfm+5pbkTKDbs+zLCk6XqQdL9RSOkYmEW+8Sj/yOllNxm5MQKp
         0Jzh9buqFcSBjOxdM4JCdNrnLlC0FSOQZ5lfAMFKRZUSk9V0oP/BNkA+++gqAwft/9Lh
         9KxyUyfxV2LCEXUMRqd+3Yp+DrdTED+ymAx8jUXpU/tqg/l+IsV080I9a8mwHX9yZg0v
         kIeuMdCXHzXo8gbYX/3+MfJQ0huFfE5I0Xw6WZWjLBF1FlaVRynVApwoXjy0tB8AwYPl
         Y4XJqnZWT7rEqf5/T01XkZ5XnH9eUYxH0L0/Xn13xUobnCrv4TsrM4i0A/NbHTGS+PUI
         KKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=61T6vEndhR9R6fF8Mj/QB/LozyJ2LwA3eIYkBrZmO1A=;
        b=he6OjqPpGDWtUu1cTgGtnSxwpWe5eaKWOYhtW9ywgzNeU5Tq6yyYGBi2jfdTtjrVhU
         03F+r8nJEnIfuxBXJa1IIIDweRVAaO9fJYNFhH9Mb757esggI6NHTc4X/lOYMjd+pDrC
         bS0Y0S/4fBmQAGpjECG9GFPuyX8bfKkdsJt/kAiI67RZR1rQFvgh0yV89K8JogbTX6jy
         wwDtv2CXc36omATHuwd9PidtUuXIuvXXdDcq2roBlfAYjHr59dkPq0lOCexfQ2ccIUov
         oTp1eUWElgx1KYMLSt59zkNWN2WQ9PBBFK6F1+xinCo41kbyp4Py6rSXoDwR75nQbjOy
         yYCA==
X-Gm-Message-State: AOAM532GvolLd+XPFs2xsi5QDIMKO3JItrIzKFh4V59yuWWvx9WGH7Ph
	2dOvlZmPg4ZQdsVNhvItfw9x3+izhTnzwQ==
X-Google-Smtp-Source: ABdhPJyLMbYWGLpgGV3wxpHGF/OMXsMPHjYFa+Ccnq9Qv4GeKerwPgXagPb9g+3eUPo6q6ZxN0q2fQ==
X-Received: by 2002:a7b:c8c3:: with SMTP id f3mr9950039wml.30.1631519826804;
        Mon, 13 Sep 2021 00:57:06 -0700 (PDT)
Return-Path: <daniel.ammann@bytesatwork.ch>
Received: from mimas.bytesatwork.ch (162.40.150.83.ftth.as8758.net. [83.150.40.162])
        by smtp.gmail.com with ESMTPSA id u26sm6899348wrd.32.2021.09.13.00.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 00:57:06 -0700 (PDT)
From: "Daniel Ammann" <daniel.ammann@bytesatwork.ch>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch2/wget: Enable ftps
Date: Mon, 13 Sep 2021 09:56:50 +0200
Message-Id: <20210913075650.5989-1-daniel.ammann@bytesatwork.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fetcher would fail with:
Could not find a fetcher which supports the URL: ftps://...

Signed-off-by: Daniel Ammann <daniel.ammann@bytesatwork.ch>
---
 lib/bb/fetch2/wget.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 9a49e64a0..349891e85 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -69,7 +69,7 @@ class Wget(FetchMethod):
         """
         Check to see if a given url can be fetched with wget.
         """
-        return ud.type in ['http', 'https', 'ftp']
+        return ud.type in ['http', 'https', 'ftp', 'ftps']
 
     def recommends_checksum(self, urldata):
         return True
-- 
2.20.1

