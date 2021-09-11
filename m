Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
 by mx.groups.io with SMTP id smtpd.web11.3429.1631365002996734412
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 11 Sep 2021 05:56:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=MBPZdkXT;
 spf=pass (domain: gmail.com, ip: 209.85.210.47, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f47.google.com with SMTP id c8-20020a9d6c88000000b00517cd06302dso6257214otr.13
        for <bitbake-devel@lists.openembedded.org>; Sat, 11 Sep 2021 05:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tWPxABx+MPm1jkSnZJZmtDX4BK9UtcKzmddJHFvmIKk=;
        b=MBPZdkXT3gK/EgGtQHlv/tUovH4wezN7iIyF2ma8Ngc13u76nWAawro2NwQKOG0x1n
         s87XDUb9IWAkhFiFj855PQyq5ccnTBt5TLLJ6Lz19tWm0L6WnR62rvoB/r7kBKb2WkEQ
         xiAhSV4+kkfu9YA9AqKHvYSoCpntdskb6CCU0Xmq3WRIKE9tf5UxuA/1Ibg3tSyKclKw
         3Qp74+YZag/2NOCznFLGeLBhwiWRHK7ddLp1RdYPS/Gq8ndjk/wx9jbZcIEQ1TNiA95r
         8m8iiTlTAfP0KfHcHzCqCjPjo/TIkfHMMfIh/1tPXya0av6Txw+70q1PuK5FFNgCpUvd
         64Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tWPxABx+MPm1jkSnZJZmtDX4BK9UtcKzmddJHFvmIKk=;
        b=nAw7S2C48ZpdwBold+a9AuV3I3WA3Baxr5a/26sMzpV8r9f+eR9H6vcncAIFwCib/K
         df2TPTHzZXiNuXjB91J+RaKMCrHXrg5hIT8Np9tJ7P17gjKKL0APnV4N7Ywww/KCSztn
         U55TXWkIh9K5b8MIVZ1lzKBe2+ZbWZ+nzmGUq3k5wCYzOodN2llEUH6bEO6Gb5M939lw
         8snwPHFGIjlLYCQMzFfTS/t9BeSxMIbykjYeENUuhhtxQTJYWpIy5uTtkgRU7QJpV1ov
         JSu39GeEECToR6kKuIjSiKLp0CI8zg4NXBA6F4pJZEYmQq3pZijJ6yjScK8LurC/Gra1
         FwUw==
X-Gm-Message-State: AOAM533M/ttPJPN/cgW1AjIFrxEmXYMJ4r7Uhg6Qk4dUih+kBncAzwBk
	gDDhlERc5aYSKTnKZADXP4Vnsbun8uk=
X-Google-Smtp-Source: ABdhPJz4nzGZzlmub4n1m7zYowutAczNErOBStSa+aAx++K+WpyTAqUrRDXblzGhjIn8TLVB/WkrWQ==
X-Received: by 2002:a9d:4d93:: with SMTP id u19mr2207694otk.86.1631365002043;
        Sat, 11 Sep 2021 05:56:42 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:4f37:550:d1b1:6f01])
        by smtp.gmail.com with ESMTPSA id t9sm395214oie.20.2021.09.11.05.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 05:56:41 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: richard.purdie@linuxfoundation.org,
	Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] cooker: Allow upstream for local hash equivalence server
Date: Sat, 11 Sep 2021 07:56:28 -0500
Message-Id: <20210911125628.487933-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hash equivalence server has had the option to support a read-only
upstream server for some time now when launched as a standalone program,
but there was no way to set the upstream when using a locally started
server. Add a new variable called BB_HASHSERVE_UPSTREAM that can be used
to specify an upstream server when a local hash equivalence server is
used (e.g. BB_HASHSERVE is "auto")

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/cooker.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index db991702e2d..1f55d9ad73e 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -389,7 +389,12 @@ class BBCooker:
             if not self.hashserv:
                 dbfile = (self.data.getVar("PERSISTENT_DIR") or self.data.getVar("CACHE")) + "/hashserv.db"
                 self.hashservaddr = "unix://%s/hashserve.sock" % self.data.getVar("TOPDIR")
-                self.hashserv = hashserv.create_server(self.hashservaddr, dbfile, sync=False)
+                self.hashserv = hashserv.create_server(
+                    self.hashservaddr,
+                    dbfile,
+                    sync=False,
+                    upstream=self.data.getVar("BB_HASHSERVE_UPSTREAM") or None,
+                )
                 self.hashserv.serve_as_process()
             self.data.setVar("BB_HASHSERVE", self.hashservaddr)
             self.databuilder.origdata.setVar("BB_HASHSERVE", self.hashservaddr)
-- 
2.31.1

