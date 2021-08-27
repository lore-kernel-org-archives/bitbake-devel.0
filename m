Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
 by mx.groups.io with SMTP id smtpd.web10.1848.1630089669353406562
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 27 Aug 2021 11:41:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=SC/KqXEM;
 spf=pass (domain: gmail.com, ip: 209.85.218.48, mailfrom: martin.jansa@gmail.com)
Received: by mail-ej1-f48.google.com with SMTP id me10so15757660ejb.11
        for <bitbake-devel@lists.openembedded.org>; Fri, 27 Aug 2021 11:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oOiWqkk1UkgzxnmbAp7iq4DinxiWcYbbpUJl+Mpa1Ig=;
        b=SC/KqXEMbwM9rdYb7dXC1V6hDwrYm9IEqO9EAOIwAOIcyF4t1x6sqsVObSBnWJ09v9
         /51hccckAxMveRKGb1l2NPmBxmnHtT5GdWO8719HkAwwxD4Vckob2566gNgjwnp7Iaof
         QrKMVXSDK5ids7DTbjFi5Ape3aMio89cZOyF2w5AbSAyk46iRYgZwGweKyOTJK576FNc
         JQo8Z+8nxE1U1MMd+yAknasUZug1m6+12lImt/OYmFhGcsSQ3qlnoSA9KRl5E0fU8PVT
         ArTs0dE719pD7kQvPBPh2GFuGJN0zDsJR4Y+Dk5GAppXTH5LSUfpC54o71LsfP/T74bV
         F1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oOiWqkk1UkgzxnmbAp7iq4DinxiWcYbbpUJl+Mpa1Ig=;
        b=c9ZkSj4HiG4pwepjNR9z2IunANGL4ykRvDfbUYSokjuZka56Pm74IXkbFQ0Cig/wTI
         TCE4tvQZ07oEEK4yf2E1lZUjG6S4jn1S/H26szu4qwyMeFKjd+DGwNIaQzSOAHQCnP2o
         7YqW3SysPss50f2nbwxKIVvmaJg8gPZkSSK1i/qqKtnUal2hXjpKTnyk5HpAEKkvqUMX
         Ooaex/AArO77LZn/B/eiXFx4jURKFrRzzeKBXtXPQsEcn1Y41QklCiBR4kAeKQnGpImY
         zqos0+Q7ny58smAQaNGJDxyaDCaTSXJ3O+UEblObL0Ae49ZYk7cyxU3VVkqV1CzRO3fO
         hEIA==
X-Gm-Message-State: AOAM531IVNbs/fgjsQs5Go97hxRc9qiErDDHMyLxK1W+CqtS8labRYWy
	o2hUZVwIFBDugaZUWS/jAVfJ7dlbqXRhlg==
X-Google-Smtp-Source: ABdhPJxqSeKRWxWVfDdvh9PTGJBdog5FZTrhcOACoJabHkI/X/UMK1Kq4tRJEA5lx0tJRLwf9qxOUw==
X-Received: by 2002:a17:907:101a:: with SMTP id ox26mr11521874ejb.282.1630089667826;
        Fri, 27 Aug 2021 11:41:07 -0700 (PDT)
Return-Path: <martin.jansa@gmail.com>
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id e22sm3931162edu.35.2021.08.27.11.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 11:41:07 -0700 (PDT)
From: "Martin Jansa" <Martin.Jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: scott.murray@konsulko.com,
	Martin Jansa <Martin.Jansa@gmail.com>
Subject: [PATCH] Fix typos in exiting
Date: Fri, 27 Aug 2021 20:41:05 +0200
Message-Id: <20210827184105.1453473-1-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <169EE6B2B92BC747.1595@lists.openembedded.org>
References: <169EE6B2B92BC747.1595@lists.openembedded.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 bin/bitbake-worker       | 2 +-
 lib/bb/cooker.py         | 2 +-
 lib/bb/server/process.py | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 7765b936..7d982f90 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -517,5 +517,5 @@ except BaseException as e:
 worker_thread_exit = True
 worker_thread.join()
 
-workerlog_write("exitting")
+workerlog_write("exiting")
 sys.exit(0)
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 55eed092..db991702 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -382,7 +382,7 @@ class BBCooker:
         try:
             self.prhost = prserv.serv.auto_start(self.data)
         except prserv.serv.PRServiceConfigError as e:
-            bb.fatal("Unable to start PR Server, exitting, check the bitbake-cookerdaemon.log")
+            bb.fatal("Unable to start PR Server, exiting, check the bitbake-cookerdaemon.log")
 
         if self.data.getVar("BB_HASHSERVE") == "auto":
             # Create a new hash server bound to a unix domain socket
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 6127fd40..b593830c 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -473,7 +473,7 @@ class BitBakeServer(object):
             try:
                 r = ready.get()
             except EOFError:
-                # Trap the child exitting/closing the pipe and error out
+                # Trap the child exiting/closing the pipe and error out
                 r = None
         if not r or r[0] != "r":
             ready.close()
-- 
2.30.2

