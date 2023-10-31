Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139A3C41535
	for <webhook@archiver.kernel.org>; Tue, 31 Oct 2023 17:22:23 +0000 (UTC)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
 by mx.groups.io with SMTP id smtpd.web11.1686.1698772939276699250
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Oct 2023 10:22:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=FiiHzKPB;
 spf=pass (domain: gmail.com, ip: 209.85.210.49, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6d2de704f53so2812313a34.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 10:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698772937; x=1699377737; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vllbvf2QC63w5kgh8Upy6LpMkxWE4pcy1xac5Pt+QzU=;
        b=FiiHzKPB8TItGIBB77rZeIi5M1YVzgyqZgOZcuEgykJHji7L8KYXPYHuTWSMdGbkHN
         UM8RVyPmjvAW0B3f5ereEPeHaRfHfhtdHh5RzDFR4Cea8Iedbt2UhbPb1cFIc/klSn+I
         vJLILN4MzY6U+woHQcw7iaYdk1ytG5ZXyKpGeSZla0w9gPASuls5MjVG8yzD3Q1dc36k
         Oln/7pOID9nOjLRyG+L9kSsZ5/Hqh9MIdOcAyVPE69OccM5oZTY/a72nFXZyyfWCqz9Q
         pgA3OB8yvvJDl9PgTVV8dXL1d/BI3Cf19I+OoyW/KiaoO7NEob/LSqnn4ZwFDNT2QDLS
         96Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698772937; x=1699377737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vllbvf2QC63w5kgh8Upy6LpMkxWE4pcy1xac5Pt+QzU=;
        b=WFTDzuZ8q2eIIQ3adWJCd9rNqQiTCXX6E7t2P2+uD8B/O+UKOFhQZmOaKufYukSrg1
         Mbx7fojwxr2GBb/dkswT4+3XIrRUE+FTg6ZEwF+LjWASqj6IZ0hfZ/gahiVA0Rpyzm/A
         GTed5Oomfy4LjfltrDNbxE6/k0l0f5qrfwA1asSRrj2nZW2tA9yCvoJvpgWKkbY9Lg5w
         GWYFxhFJB0qtBbxrJgkwWtMPnIGD7kS3TCmQXJj24TqUP2D+IWh96yZbRe4PnLEpMYcI
         AD8L/X6+h0sRZqCCSXJmcFwmloZeGzU0x66uCUvoHDoKU12WqFC4tIbY0ALehUXxiHpR
         aN3w==
X-Gm-Message-State: AOJu0YzWEDO3M1fgH+aFK0cSypK6p823H5DFtcWjx5WJQqw4ksvhcARr
	2dItEnKLP2vS1jltIIfsUUrpt4Ip0/8=
X-Google-Smtp-Source: AGHT+IHZ+fK6lIGgn1UOLkoLY1TgCGQWhmlxExmb37nWLFam8w6P7S5fLtC60nU9bRpD9z82KTDBTg==
X-Received: by 2002:a9d:74cf:0:b0:6b9:26ce:5e5c with SMTP id a15-20020a9d74cf000000b006b926ce5e5cmr13256459otl.31.1698772937613;
        Tue, 31 Oct 2023 10:22:17 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id k6-20020a056830150600b006ce2e464a45sm282503otp.29.2023.10.31.10.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:22:16 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v4 18/22] bitbake-hashclient: Output stats in JSON format
Date: Tue, 31 Oct 2023 11:21:34 -0600
Message-Id: <20231031172138.3577199-19-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031172138.3577199-1-JPEWhacker@gmail.com>
References: <20231030191728.1276805-1-JPEWhacker@gmail.com>
 <20231031172138.3577199-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 17:22:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15368

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


