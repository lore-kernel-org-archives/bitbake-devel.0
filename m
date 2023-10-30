Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63308C00144
	for <webhook@archiver.kernel.org>; Mon, 30 Oct 2023 19:18:24 +0000 (UTC)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
 by mx.groups.io with SMTP id smtpd.web10.158348.1698693498670561914
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Oct 2023 12:18:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Fn3UU8sA;
 spf=pass (domain: gmail.com, ip: 209.85.210.44, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6ce2eaf7c2bso3340747a34.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 12:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698693497; x=1699298297; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vllbvf2QC63w5kgh8Upy6LpMkxWE4pcy1xac5Pt+QzU=;
        b=Fn3UU8sAfLOMUoV119opn+NRGibuuY73OPY74G+b5mVmbzrAljF209VOJH3+YjWLPo
         r3L9QdYTSecrDJhvq7OMA+Kve89o9WsuvogKe3EpYw+YtlSO9e1/e8oE7g7mJH+zwRGX
         EJZ18EiOAqFTkJE8XUwKPNGMhExyhuvLY7DAUvoqV0eJVJ8FWUucz1MauaerfGOS4TJQ
         B3HS7gCD/P2wlDH2+YZEIUVai2lbUbFi5qXLy5hiZ73bOi1DRQe/khRvWUAkgv5qrSbL
         xX9KmMuHIZ68/iiMqqn4zTLvWa3GpWl+3lD3UmbIs98ElXH41BRWgpv51ohfyW86c4RU
         //Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698693497; x=1699298297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vllbvf2QC63w5kgh8Upy6LpMkxWE4pcy1xac5Pt+QzU=;
        b=n9V9loU79xT3AlzFKcZd8uMDcs2mde37+VyPiTvxJHOptgJrmNwB/vrwGIHaujE0uc
         DiTswcNM1YWhLFu2BwV2YUo2NNHo4mg/l3ulrEsiqa6n5xb7Wg2xOPMShewSwPfAjH0Q
         glusf9aTBiLudBHwVuI6bjSVQK8RLESz89AptCHfB2YfE1eIRiaFXQUi2vbKZkzK3r9T
         e+8DDKoLazSNdI4uB+0wVcxLPzPogKnggv/PPZ9DOHrXaYtCOkznNOvKOajjs3XQHKXY
         9ExOLWv90GUMztRJiPXUcsdAkWAIGWN4nef9QZOQH+1t122WXCBnLaamtQZG4LTgq724
         KytQ==
X-Gm-Message-State: AOJu0YzYCzbW2RPkW3NpYlBVtUB2gh3x72ExoiGf8slWOk2qAzhuRFiu
	RwGsxNzqEADGHO5XrwuEGwcgb3+7HR8=
X-Google-Smtp-Source: AGHT+IH7ksZWXB8h1gJd7dnN+dAtDBB6wHsDIjG20sIeD6NgnximVO+VBh62NvLVb/xM5ld3usGunA==
X-Received: by 2002:a05:6830:4d8:b0:6b9:6a43:1f7c with SMTP id s24-20020a05683004d800b006b96a431f7cmr10800420otd.26.1698693497368;
        Mon, 30 Oct 2023 12:18:17 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id l38-20020a0568302b2600b006cd099bb052sm1510500otv.1.2023.10.30.12.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 12:18:16 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v3 18/22] bitbake-hashclient: Output stats in JSON format
Date: Mon, 30 Oct 2023 13:17:24 -0600
Message-Id: <20231030191728.1276805-19-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030191728.1276805-1-JPEWhacker@gmail.com>
References: <20231012221655.632637-1-JPEWhacker@gmail.com>
 <20231030191728.1276805-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 19:18:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15320

Outputting the stats in JSON format makes more sense as it's easier for
a downstream tool to parse if desired.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bin/bitbake-hashclient | 3 ++-
 lib/hashserv/tests.py  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake-hashclient b/bin/bitbake-hashclient
index 58aa02ee..3ff7b763 100755
--- a/bin/bitbake-hashclient
+++ b/bin/bitbake-hashclient
@@ -15,6 +15,7 @@ import threading
 import time
 import warnings
 import netrc
+import json
 warnings.simplefilter("default")
 
 try:
@@ -56,7 +57,7 @@ def main():
             s = client.reset_stats()
         else:
             s = client.get_stats()
-        pprint.pprint(s)
+        print(json.dumps(s, sort_keys=True, indent=4))
         return 0
 
     def handle_stress(args, client):
diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index a80ccd57..2d78f9e9 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -815,7 +815,8 @@ class TestHashEquivalenceClient(HashEquivalenceTestSetup, unittest.TestCase):
         return "unix://" + os.path.join(self.temp_dir.name, 'sock%d' % server_idx)
 
     def test_stats(self):
-        self.run_hashclient(["--address", self.server_address, "stats"], check=True)
+        p = self.run_hashclient(["--address", self.server_address, "stats"], check=True)
+        json.loads(p.stdout)
 
     def test_stress(self):
         self.run_hashclient(["--address", self.server_address, "stress"], check=True)
-- 
2.34.1


