Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
 by mx.groups.io with SMTP id smtpd.web12.299.1584983836472563270
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 23 Mar 2020 10:17:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=UMoDHg5R;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.66, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f66.google.com with SMTP id b12so229650wmj.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 23 Mar 2020 10:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2e6zfmpo+TsnaW5UKmLPn5E9MaXvBdNKidjtTNe3pWo=;
        b=UMoDHg5R6WZXsgpBDaNcf+dauaiO6Tj98N3B9+62Junsx3DpE9r6ToGT5WN2oKFm8c
         KZE62GbAXGIdB2F2Ks37LPwmWOfHWXefwjdVJSd2Ipe4Z6TkcffxBj8m5m9iRZ/QwDMm
         3TfjPUr+no45240QtwZSqKojDk2UrTF6vd+Dc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2e6zfmpo+TsnaW5UKmLPn5E9MaXvBdNKidjtTNe3pWo=;
        b=NSI/nrR6ohzvJAhzwjQtJ7VATvTCo2DmJnHq/SFDe7MsyYexgvQYPuhXlxfQT5WyrA
         Q1dbhiZSBecwezx92C4o1/6nnxDMVUAFJ0Uq9kCWzYvjvzQ7Y0uIJDtJQc3u6aj8TSnv
         RloMdgYxRRWf7gsgMBfiyg4H8kVU/r6O+Vlg+xEMgFSAQbYCl+DiJQYHWuscHNijok7q
         uQQKw92lOpIWVGszAXRt4a4fua/tVjwA91sIGh2vkMPaiPUvuRSCEspvN1qS9jZ2PPW0
         CIUF8Ooko2F/5jAZLUpI5E8DnplTaEo/rofmSne/x5t6skz9Otgs09kbkSLMdMUhXi7l
         /7/g==
X-Gm-Message-State: ANhLgQ3puM3zhnb/7P6PBLjNBy7kzzoCvNtLv7BxTyP+PWaTsb5vUy/K
	D941iuC+lpm/Z+tBJ/sTl0JLCh5v+3c=
X-Google-Smtp-Source: ADFU+vtmoI/eJLzXco6WXebc5KZ875BajsfOmGrQZs2sxDYa44hhx7Y7xB7akfIdPjI7h3ni8JQjiw==
X-Received: by 2002:a1c:b743:: with SMTP id h64mr334727wmf.88.1584983834386;
        Mon, 23 Mar 2020 10:17:14 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id q185sm342144wme.10.2020.03.23.10.17.13
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 10:17:13 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/3] tinfoil: Drop parse_recipe_file custom datastore support
Date: Mon, 23 Mar 2020 17:17:10 +0000
Message-Id: <20200323171712.434949-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This parameter is unused except for a single selftest and is problematic
with regard to fixing some other bugs. Remove it for now, if really needed
we could re-implement it in some other way in the future. Experience
tells us we likely don't want to support this kind of change to the metadata
anyway as its not as useful as it first sounds/appears.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tinfoil.py | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index a8e835d29c..70b381e351 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -615,7 +615,7 @@ class Tinfoil:
         fn = self.get_recipe_file(pn)
         return self.parse_recipe_file(fn)
 
-    def parse_recipe_file(self, fn, appends=True, appendlist=None, config_data=None):
+    def parse_recipe_file(self, fn, appends=True, appendlist=None):
         """
         Parse the specified recipe file (with or without bbappends)
         and return a datastore object representing the environment
@@ -626,9 +626,6 @@ class Tinfoil:
             appends: True to apply bbappends, False otherwise
             appendlist: optional list of bbappend files to apply, if you
                         want to filter them
-            config_data: custom config datastore to use. NOTE: if you
-                         specify config_data then you cannot use a virtual
-                         specification for fn.
         """
         if self.tracking:
             # Enable history tracking just for the parse operation
@@ -636,11 +633,7 @@ class Tinfoil:
         try:
             if appends and appendlist == []:
                 appends = False
-            if config_data:
-                dctr = bb.remotedata.RemoteDatastores.transmit_datastore(config_data)
-                dscon = self.run_command('parseRecipeFile', fn, appends, appendlist, dctr)
-            else:
-                dscon = self.run_command('parseRecipeFile', fn, appends, appendlist)
+            dscon = self.run_command('parseRecipeFile', fn, appends, appendlist)
             if dscon:
                 return self._reconvert_type(dscon, 'DataStoreConnectionHandle')
             else:
-- 
2.25.1

