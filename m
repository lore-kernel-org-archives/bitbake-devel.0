Return-Path: <frederic.martinsons@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22417C6FD1D
	for <webhook@archiver.kernel.org>; Fri, 17 Mar 2023 08:19:57 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web11.14342.1679041193638173708
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Mar 2023 01:19:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=Zy113i00;
 spf=pass (domain: gmail.com, ip: 209.85.128.44, mailfrom: frederic.martinsons@gmail.com)
Received: by mail-wm1-f44.google.com with SMTP id j42-20020a05600c1c2a00b003ed363619ddso2938317wms.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 17 Mar 2023 01:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679041192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBhVZ9P81FOLkf4KxzOUM17YuVgEmsYSvOQPUVHGf0Y=;
        b=Zy113i000qOrQOrfIHaqYE4Le6xQ70yk2w/rKoaa0UY+I/ngpHkfItM+6Q/GS7/H8D
         S6vjMJIZOoYdHh0RRrl3VJHrXKsdEEIcMRo459H4yKRojr81t2wy+uK+tjREY8L5KfJg
         6TfvSVnhWDwk3zCZI9BiJyPvDODAuABwyfbGQe3WfTDdZvZUr/LiBbY/rCkHVuGDsDBQ
         BeFGfb4Hmto9HATBbilv8N9LmLfZYp9Igq7zbvi6LYQjsd7M1budUDKGkvwNlbfoDaed
         zGmkTUS3Kp+LLXI+W7dKZ0rYB1WkxsiddvTEK8hqNXTnwq7FcKZqIWiUxTa1/pvtRGHj
         rK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679041192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EBhVZ9P81FOLkf4KxzOUM17YuVgEmsYSvOQPUVHGf0Y=;
        b=YzOcwN0oDmLK6qLeEZmluz3M2c51VoYJuIsOvSHc3dD2bssueARTpSnE2gHcjI1MFL
         HtzFoMmXB5O88owRNnj9IA+ThR8d+K2VVdRr21e1y1YgyjilGWgilNfk7KQogE83KDMt
         5P4/sDa+f2F+QFtd6fbzm6j/TTmY1oCcSgb0c3GQPsF90yI03sUyFB0FFZC2L9erMNlK
         OnEV/iuaCWDxMxph0lk3K+RbONRgkZCM6JvvXr0lI37zU9XFQRTaQtt5O2c+i/hCEzSn
         jIxLPUMJzFcXSFf/livu39FUOlnDXA21LJWgtDMQltBrBEdbh01wlb6WRYBsJERdeb3T
         IhMA==
X-Gm-Message-State: AO0yUKW9eAuoyKkNNmGSOdoz/YCBd5oMa0v3oESxV5vdY/78DwixnD4v
	od2QdlDSSF+O/UJv5YpdnpK2MbYbfpo=
X-Google-Smtp-Source: AK7set/STotdOV0dBtvm48+qfpUK9nNdIXKfWrbLbdi7eewxHj8B9ld6Z3I7Pagldn7d/Rr6yuS8Pw==
X-Received: by 2002:a05:600c:2185:b0:3ed:8780:f27b with SMTP id e5-20020a05600c218500b003ed8780f27bmr774166wme.16.1679041191588;
        Fri, 17 Mar 2023 01:19:51 -0700 (PDT)
Received: from work-pc.. ([2a01:e0a:8d5:c6c0:7a1:ff32:1d50:1429])
        by smtp.gmail.com with ESMTPSA id c24-20020a05600c0ad800b003e22508a343sm1293819wmr.12.2023.03.17.01.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 01:19:51 -0700 (PDT)
From: frederic.martinsons@gmail.com
To: bitbake-devel@lists.openembedded.org
Cc: Frederic Martinsons <frederic.martinsons@gmail.com>
Subject: [bitbake-devel][PATCH v2 3/3] crate.py: authorize crate url with parameters
Date: Fri, 17 Mar 2023 09:19:16 +0100
Message-Id: <20230317081916.1857201-3-frederic.martinsons@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230317081916.1857201-1-frederic.martinsons@gmail.com>
References: <20230317081916.1857201-1-frederic.martinsons@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Mar 2023 08:19:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14604

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
index f8367ed3..590dc9c1 100644
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


