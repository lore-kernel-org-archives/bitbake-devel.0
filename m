Return-Path: <frederic.martinsons@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFA2C6FD1D
	for <webhook@archiver.kernel.org>; Wed, 15 Mar 2023 13:40:40 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web10.8242.1678887633912283939
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Mar 2023 06:40:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=TAsUwfrP;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: frederic.martinsons@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id p16so12585477wmq.5
        for <bitbake-devel@lists.openembedded.org>; Wed, 15 Mar 2023 06:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678887632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ed0C/QImnUoKWc0uRUmYE/8yjc0Q4ciep2yVn2/EVs8=;
        b=TAsUwfrP/KfCHgLziB3gmZ5Dve9lFxHE9cRD7NkuKU0KKM9tiGw5WUktxNQfZ/foGw
         LJh4H8aD2mr9MumWK60Y91IMuDp02OiMPVaC9jKTGqevFs00+2Jt5r4Iq0830DZvksuU
         Dm03yT9y3GSnHwhbaoHkT1DlbPpNiIiJ05xkKcMHeC5Ny/hIIawzB2FFgl/yl9Vv8PQx
         SqD8eqV9zHhxpeNvANbGm6rz8qtgQfjKCEgdCjWmCCaAcib3NbqZMp71+wOvGunhO25z
         aYUHEvBAGVTvIuNmZqs3175OamLu5ZJEPmWu5VoY26y7p/OCioZqA06B5P8JHurL27YN
         ql5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678887632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ed0C/QImnUoKWc0uRUmYE/8yjc0Q4ciep2yVn2/EVs8=;
        b=Nm842ODXvmhu4pbhZ9NEGryOfS82734rHvKd4v1CczNDm2czdT1sAVXZ75Xvds0nU/
         53xJeeq13WPfya6Vgdb6xkmXoH7Alcw2uPzMpTzjbrK66IJaChhzVZJ2XSPSFbRYC1jc
         9RizcpfBG+tp2dMXe2wUUFQ3DzKDV2pNi5K7ogSIVgNmkSkKGaAkhRvJjD+zGsHUIYJ3
         KmS03mI3mrwXogjQWUKYYWfjKU/77O0LxGBqzq/Ay9bT0puiv4k/4SWIqXXgZIFE7k7G
         1XOLbsq8fzBze0bzAL4aVI86P9O9tOdZG14VZomXY4prGjwMkAj88YMO/s7zwlrmCDsO
         y0Hw==
X-Gm-Message-State: AO0yUKVqSs4Z/SEgRN6Fr0Pi5DPQRjGWsIPl3WkBKwWE6T9bTY2bwSmQ
	+H26TxDB0hECMhUp8e8BS8RoFx3d/DY=
X-Google-Smtp-Source: AK7set9YoZ2pTIX6ex4TU39WfmEoJJ0jh7nlIRJMvH/1VUX7EyKLK9UyvNilhwjtqgOFmNqewaR8Sg==
X-Received: by 2002:a05:600c:c8a:b0:3eb:2067:1141 with SMTP id fj10-20020a05600c0c8a00b003eb20671141mr17301497wmb.38.1678887631921;
        Wed, 15 Mar 2023 06:40:31 -0700 (PDT)
Received: from work-pc.core.sigfox.net ([2a01:e0a:8d5:c6c0:de0b:a9f8:3449:816c])
        by smtp.gmail.com with ESMTPSA id f2-20020a7bc8c2000000b003ed243222adsm1865454wml.42.2023.03.15.06.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 06:40:31 -0700 (PDT)
From: frederic.martinsons@gmail.com
To: bitbake-devel@lists.openembedded.org
Cc: Frederic Martinsons <frederic.martinsons@gmail.com>
Subject: [PATCH] crate.py: authorize crate url with parameters
Date: Wed, 15 Mar 2023 14:40:29 +0100
Message-Id: <20230315134029.52934-1-frederic.martinsons@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Mar 2023 13:40:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14564

From: Frederic Martinsons <frederic.martinsons@gmail.com>

This allow to have classic fetch parameters
(like destsuffix, sha256, name ...) not being
considered by crate fetcher itself (and so mess
up its download)

Moreover, it allow to overload the name of the downloaded
crate (maybe usefull if there is a naming clash between
two crates coming from different repositories)

Signed-off-by: Frederic Martinsons <frederic.martinsons@gmail.com>
---
 lib/bb/fetch2/crate.py |  9 ++++++---
 lib/bb/tests/fetch.py  | 24 ++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
index f091200d..2889e39c 100644
--- a/lib/bb/fetch2/crate.py
+++ b/lib/bb/fetch2/crate.py
@@ -56,8 +56,10 @@ class Crate(Wget):
         if len(parts) < 5:
             raise bb.fetch2.ParameterError("Invalid URL: Must be crate://HOST/NAME/VERSION", ud.url)
 
-        # last field is version
-        version = parts[len(parts) - 1]
+        # version is expected to be the last token
+        # but ignore possible url parameters which will be used
+        # by the top fetcher class
+        version, _, _ = parts[len(parts) -1].partition(";")
         # second to last field is name
         name = parts[len(parts) - 2]
         # host (this is to allow custom crate registries to be specified
@@ -69,7 +71,8 @@ class Crate(Wget):
 
         ud.url = "https://%s/%s/%s/download" % (host, name, version)
         ud.parm['downloadfilename'] = "%s-%s.crate" % (name, version)
-        ud.parm['name'] = name
+        if 'name' not in ud.parm:
+            ud.parm['name'] = name
 
         logger.debug2("Fetching %s to %s" % (ud.url, ud.parm['downloadfilename']))
 
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index fd089bc8..85cf25e7 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2423,6 +2423,30 @@ class CrateTest(FetcherTest):
         self.assertTrue(os.path.exists(self.tempdir + "/cargo_home/bitbake/time-0.1.35/.cargo-checksum.json"))
         self.assertTrue(os.path.exists(self.tempdir + "/cargo_home/bitbake/time-0.1.35/src/lib.rs"))
 
+    @skipIfNoNetwork()
+    def test_crate_url_params(self):
+
+        uri = "crate://crates.io/aho-corasick/0.7.20;name=aho-corasick-renamed"
+        self.d.setVar('SRC_URI', uri)
+
+        uris = self.d.getVar('SRC_URI').split()
+        d = self.d
+
+        fetcher = bb.fetch2.Fetch(uris, self.d)
+        ud = fetcher.ud[fetcher.urls[0]]
+
+        self.assertIn("name", ud.parm)
+        self.assertEqual(ud.parm["name"], "aho-corasick-renamed")
+        self.assertIn("downloadfilename", ud.parm)
+        self.assertEqual(ud.parm["downloadfilename"], "aho-corasick-0.7.20.crate")
+
+        fetcher.download()
+        fetcher.unpack(self.tempdir)
+        self.assertEqual(sorted(os.listdir(self.tempdir)), ['cargo_home', 'download' , 'unpacked'])
+        self.assertEqual(sorted(os.listdir(self.tempdir + "/download")), ['aho-corasick-0.7.20.crate', 'aho-corasick-0.7.20.crate.done'])
+        self.assertTrue(os.path.exists(self.tempdir + "/cargo_home/bitbake/aho-corasick-0.7.20/.cargo-checksum.json"))
+        self.assertTrue(os.path.exists(self.tempdir + "/cargo_home/bitbake/aho-corasick-0.7.20/src/lib.rs"))
+
     @skipIfNoNetwork()
     def test_crate_incorrect_cksum(self):
         uri = "crate://crates.io/aho-corasick/0.7.20"
-- 
2.34.1


