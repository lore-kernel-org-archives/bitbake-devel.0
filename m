Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
 by mx.groups.io with SMTP id smtpd.web12.11470.1593094409375145501
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 Jun 2020 07:13:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=k8iL/ndt;
 spf=pass (domain: gmail.com, ip: 209.85.216.66, mailfrom: jpewhacker@gmail.com)
Received: by mail-pj1-f66.google.com with SMTP id q90so2573105pjh.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 25 Jun 2020 07:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lkU7X08xhdXaf+v4hXJVx03THZ2BGSDTRIyeXh9W5VU=;
        b=k8iL/ndtvymhpCnqjRXQiRpmHQe0fQ7U0mMbURVROOrVMRsvKootGHeYM1AVyuRU5J
         dqnslnutkqw8V0LAWgOpji8yOpYUS0/Z6p7M1vVr/R8mi+k4RYlBjVhsfBEgC8wYEzuv
         b5PuXtvbDT1xZxdSoVNXO5uOzLqZZhh8KPga/klVUBjm/gJxNeWuSj4yfY8S2erD4doO
         jhoW5jJDgwIPG/cu2/0uPdXDMQ4yaXxFgOeeH1EUz7tHYrWXFrtkXaR+YocK702lKs7Y
         Mr65GDGYfYaxqczrgSI4flt/tCEhw3Nez0tjeODMhnEL9dUWgo5QrK9/+3kSnw3ByoG3
         wLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lkU7X08xhdXaf+v4hXJVx03THZ2BGSDTRIyeXh9W5VU=;
        b=ED0GinmpPiKSQBZ4wiAi0ekf1/tQoXgrbG9++916oZZuXglsUma2WenXrmqozCDYJm
         wDpgGi85TX2mK7etAqGUSTGjG/TYj5T31HG8b4T/b7wn08pzIuCnK6roPxdDVhGtKBAg
         2wpLnyMyrbyE/4xeJnUfQUS7P/iSgCxygjnxeCulXr7ij4p46dKlNCxR7pZcY3efhxLV
         lwpFVjMGBtRNlqXEkbfMya4IQmEKxBSIIQNlMyj5HtNmL2EbEKUUFfDvYAdjhPwg0aWb
         MHbrlbyRsOMNWNlaX5N0IziOP2tdlkFIH356Hf9oeQKef4WVIHt0v9eOoGxKmJGU2jjm
         eQQA==
X-Gm-Message-State: AOAM5330CGVw9cHllTpXN0YFbZUD1ZAh3qKoNxQMGz/Fe0jU0v6m9bEp
	8nlSEB8yYO21ndaR9bxCGkCHyAHV
X-Google-Smtp-Source: ABdhPJzdMx25EBF/E/rhbJStAy6sEXGiJ8GlSJ9AytxU95EsXElf0/TAIPiNjcFkdcjbCP+YYUT91w==
X-Received: by 2002:a17:90a:8d11:: with SMTP id c17mr3533209pjo.201.1593094408485;
        Thu, 25 Jun 2020 07:13:28 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:7004:574a:57d2:4d47])
        by smtp.gmail.com with ESMTPSA id 7sm9935057pgh.80.2020.06.25.07.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 07:13:27 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] siggen: Fix error when hash equivalence has an exception
Date: Thu, 25 Jun 2020 09:13:20 -0500
Message-Id: <20200625141320.8979-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code that handled exceptions from the hash equivalence client was
raising an exception itself because hashserv.client wasn't imported

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/siggen.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 872333d7fd..4c63b0baad 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -14,6 +14,7 @@ import simplediff
 from bb.checksum import FileChecksumCache
 from bb import runqueue
 import hashserv
+import hashserv.client
 
 logger = logging.getLogger('BitBake.SigGen')
 hashequiv_logger = logging.getLogger('BitBake.SigGen.HashEquiv')
-- 
2.27.0

