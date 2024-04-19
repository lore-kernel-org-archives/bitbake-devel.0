Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8354CC4345F
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 12:17:21 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.web11.19114.1713529037733349806
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Apr 2024 05:17:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=I1z71bWX;
 spf=pass (domain: gmail.com, ip: 209.85.218.54, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a5557e3ebcaso326492466b.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 19 Apr 2024 05:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713529036; x=1714133836; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cjYCsEbMH6GPTNmhHqF45znN/OGRb9cKy0SeSlJtM0s=;
        b=I1z71bWXnFYi1wiPOxOAUI23Ev1akoVgYTiId/axBdOuJIK5+3vdAwbD3S4ZgeVYP8
         UPnf+amm4PrUmDfmaQQbTzdGAfnD1Hz0R8cYDy4e22gtzKzE2BebeUxuD/LykfoHvN1D
         WK1Chu54M4SRJdwwftUyO/S2AUgqFMGmCMctFf9CPJ2UKqQRy6E9XP9+XeMwKGnG7Un/
         KLIRI5Ytejnrw1EhjIRAy2TT9ovdIS9yKLtKo97eidWgrCk8w6YD/K/bnz7uPqTmbQ8l
         Bm+30Arcxq8p2I+olTE5zfffmu4RpH3/m6YsmkGdezeUvM6ga3FKmN6MAhvk4Gr1JWUo
         OqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713529036; x=1714133836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cjYCsEbMH6GPTNmhHqF45znN/OGRb9cKy0SeSlJtM0s=;
        b=Pz7M1+mX8E+3KWvk8k52oS+fMBYn445wZhpSDP/SGcUihlC/YeYDEiFTNAbSxAMkhN
         7ebZlodNqsAomjCUBjCMZ1lV1Xt12MLaAy5+pv6MaiSJaJ7AcD/Zt/Qo/pKusgBfh6xS
         b1pH7B01jedQqi2ZnTlRAL/mDBlytRK7f9rRMilSYsHxbkMGK/c77XW98cxsokv7aEsY
         9OG2hRZypZI7TKg0AdQ/lYeo642INv88amhAW+1HUZd9Gg1YV2lGhyEX46wcwwMJzdFP
         IfZl5GERL1PrFqGmvzkBw6V5+VA3s8IO4BLi87nPCq/9wJ2SYFEdMSvq8t8g02iT/WHo
         CSug==
X-Gm-Message-State: AOJu0Yyc6Avb9HIGC+frYtvlPJTfUSeBRsaqP3y/BzqCb4r/8/H8I1W+
	uiSjADVm7s83ICTi7+2ZgrKN+a8T5EXrQhboWVTNhggRzQbOnL2n910p4g==
X-Google-Smtp-Source: AGHT+IFm1PjknvW3gV9xLzaJ9LPmp1sTmgNQZHWC549YwYdq2BmsJcd3dy8AUowqTGtOBB33cOMvJg==
X-Received: by 2002:a17:906:66d7:b0:a51:8672:66e4 with SMTP id k23-20020a17090666d700b00a51867266e4mr4406651ejp.22.1713529035621;
        Fri, 19 Apr 2024 05:17:15 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id le23-20020a170906ae1700b00a4e4c944e77sm2117350ejb.40.2024.04.19.05.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 05:17:15 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
X-Google-Original-From: Alexander Kanavin <alex@linutronix.de>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] fetch2/crate: add upstream latest version check function
Date: Fri, 19 Apr 2024 14:17:13 +0200
Message-Id: <20240419121713.1920583-1-alex@linutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 19 Apr 2024 12:17:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16114

This is actually rather easy: crate web API provides a json
with all the versions, for example:
https://crates.io/api/v1/crates/cargo-c/versions

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 lib/bb/fetch2/crate.py |  9 +++++++++
 lib/bb/tests/fetch.py  | 16 ++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
index 01d49435c3e..e611736f069 100644
--- a/lib/bb/fetch2/crate.py
+++ b/lib/bb/fetch2/crate.py
@@ -70,6 +70,7 @@ class Crate(Wget):
             host = 'crates.io/api/v1/crates'
 
         ud.url = "https://%s/%s/%s/download" % (host, name, version)
+        ud.versionsurl = "https://%s/%s/versions" % (host, name)
         ud.parm['downloadfilename'] = "%s-%s.crate" % (name, version)
         if 'name' not in ud.parm:
             ud.parm['name'] = '%s-%s' % (name, version)
@@ -139,3 +140,11 @@ class Crate(Wget):
             mdpath = os.path.join(bbpath, cratepath, mdfile)
             with open(mdpath, "w") as f:
                 json.dump(metadata, f)
+
+    def latest_versionstring(self, ud, d):
+        from functools import cmp_to_key
+        json_data = json.loads(self._fetch_index(ud.versionsurl, ud, d))
+        versions = [(0, i["num"], "") for i in json_data["versions"]]
+        versions = sorted(versions, key=cmp_to_key(bb.utils.vercmp))
+
+        return (versions[-1][1], "")
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 85c1f79ff32..e5d85f9dac2 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1493,6 +1493,12 @@ class FetchLatestVersionTest(FetcherTest):
             : "2.8",
     }
 
+    test_crate_uris = {
+        # basic example; version pattern "A.B.C+cargo-D.E.F"
+        ("cargo-c", "crate://crates.io/cargo-c/0.9.18+cargo-0.69")
+            : "0.9.29"
+   }
+
     @skipIfNoNetwork()
     def test_git_latest_versionstring(self):
         for k, v in self.test_git_uris.items():
@@ -1532,6 +1538,16 @@ class FetchLatestVersionTest(FetcherTest):
         finally:
             server.stop()
 
+    @skipIfNoNetwork()
+    def test_crate_latest_versionstring(self):
+        for k, v in self.test_crate_uris.items():
+            self.d.setVar("PN", k[0])
+            ud = bb.fetch2.FetchData(k[1], self.d)
+            pupver = ud.method.latest_versionstring(ud, self.d)
+            verstring = pupver[0]
+            self.assertTrue(verstring, msg="Could not find upstream version for %s" % k[0])
+            r = bb.utils.vercmp_string(v, verstring)
+            self.assertTrue(r == -1 or r == 0, msg="Package %s, version: %s <= %s" % (k[0], v, verstring))
 
 class FetchCheckStatusTest(FetcherTest):
     test_wget_uris = ["https://downloads.yoctoproject.org/releases/sato/sato-engine-0.1.tar.gz",
-- 
2.39.2


