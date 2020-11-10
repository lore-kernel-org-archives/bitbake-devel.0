Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
 by mx.groups.io with SMTP id smtpd.web09.28957.1605020529803795951
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Nov 2020 07:02:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=eg8WCLij;
 spf=pass (domain: gmail.com, ip: 209.85.210.65, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f65.google.com with SMTP id n11so12789024ota.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 10 Nov 2020 07:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZWHblobLeSfdZLpZ6+cEA86VF3BxpT0EFQgagovRtKs=;
        b=eg8WCLijEZV+KSG3Q06Qn87CXSe1fCi5lDFckUDPGjeKuQBQr3zjmgTJkRMmQNedrR
         nK/0vN0DFjVhO8XyUDp0Z/Gcuq5qO/dDlBf6giqjBLO3Gd08pFXTmxcS7OrWmTUyyrnL
         C9zXNbq6nCg4BUKkznYcXfmDQ0U7a2x4SE4EtciH9O3yxzYrgTOA0nh1r/hR7+1XdLQT
         WUZbHw26kfgAJacMi20Ae9cj5YtzjFAnBGZTUxgdzA/tMsm78PFKbVTIuBvBMZaG53hA
         mXnxu9L2yiDdackdhf5iMzS/mauKiTG1k2uQ5kYaD/0gYAvj0sQjor0PN9Yp7n+Omsoq
         ScFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZWHblobLeSfdZLpZ6+cEA86VF3BxpT0EFQgagovRtKs=;
        b=P8C8tB3pg25qULsuq5p043jsrnMZghdajMQXZsvx9/tq+mvWZUrf4tYI4Qmzog82Rr
         BY3Kk3mUntqOhmHabWj3lA3yNko7h4/UafyH/HeGx6kGfyByvUIpTDkqRZxGJpUcPwkS
         JK9LtBfz0dCKTZnzShaiXW5OR2x5AE6p/XdA0Dq+k39KA+m7oPjY738enqAfjij673Ll
         No/iRixNWoczRu8DoHU5NweZ1W7LoCih99BaZgpV4fSVYRnp6CLLcLchEgVZGLpEcdkI
         B8QFvyGNeda6yUlLA7rFpGj5vcclqHn9l3MFx4cteJ1bXIN74OcDfScExymbYQE/ZaMJ
         Xyzg==
X-Gm-Message-State: AOAM533Rf8bzbkQwz8hPGJzy2tnbp+j+70XZMNYLfOMMj2bM8QZ9tQ2y
	8GK6PGa6qflEghZIHp+lyNz2OUAZSEEZ4w==
X-Google-Smtp-Source: ABdhPJyuC/GOEqciA/JJdHp0V8Ilw8r6u/eDc0a6NN82W9J4wjibUhIiuMkUkBZvu9arT0WpCScISA==
X-Received: by 2002:a05:6830:1047:: with SMTP id b7mr5064318otp.175.1605020528799;
        Tue, 10 Nov 2020 07:02:08 -0800 (PST)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:e3e8:d9:3a56:e27d])
        by smtp.gmail.com with ESMTPSA id d13sm2429188oth.59.2020.11.10.07.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 07:02:08 -0800 (PST)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] bitbake: cache: Remove bad keys() function
Date: Tue, 10 Nov 2020 09:02:03 -0600
Message-Id: <20201110150203.1519739-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removes the keys() function from the MulticonfigCache. This appears to
be a leftover from before the class inherited from collections.Mapping,
is now unnecessary, and was outright incorrect.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/cache.py | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index ebb2422496..b8054e028b 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -814,10 +814,6 @@ class MulticonfigCache(Mapping):
         for k in self.__caches:
             yield k
 
-    def keys(self):
-        return self.__caches[key]
-
-
 def init(cooker):
     """
     The Objective: Cache the minimum amount of data possible yet get to the
-- 
2.29.2

