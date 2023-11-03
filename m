Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99189C001DD
	for <webhook@archiver.kernel.org>; Fri,  3 Nov 2023 14:27:26 +0000 (UTC)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
 by mx.groups.io with SMTP id smtpd.web10.53514.1699021642981003649
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Nov 2023 07:27:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Uu+5hWmp;
 spf=pass (domain: gmail.com, ip: 209.85.160.46, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1f06931e4f7so676273fac.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 03 Nov 2023 07:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699021641; x=1699626441; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vllbvf2QC63w5kgh8Upy6LpMkxWE4pcy1xac5Pt+QzU=;
        b=Uu+5hWmpzh08oBVl+ap0GrAh3g68NJYIUvxBA/iZTr/pai5RJp+r6BvVeC89kvG+fq
         qsW9nf1cThx4ewnKY1YRh8AF1To6MvSaE2vBQpzEmmBRVUXZ7yxIank9Vp1+Rd+mnoE3
         7HeSpcr/4eIQL8V7YHHyQswpgNgNM1EocbSqmzhhI+55b5hNtTP4sUs3UuM1g1QRiU1/
         mstbBRxAM25zDWrlgPdzl4b/nBaicMwluqGUcGKIzNgn/KosHNSaVWS+UljrOuW6lGRe
         y+Z1B/XDQnm8CGSfVyoXacoo1OE+y++q7951xJRQ1bJXHCXwAMsQwlPAhyubkwOjHW4j
         j3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699021642; x=1699626442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vllbvf2QC63w5kgh8Upy6LpMkxWE4pcy1xac5Pt+QzU=;
        b=M/D4sUI+5AqQQyBvgDiSilo7UzzfBymnnTQ90AsiGr87POvinQ95O2Rcfeg2z+JsSD
         hbosHQqblA7gvO3slcM248QMX3lhlsHyCW0e3C46RJhku8rQqqXzexxejYYp+ADLwaB5
         BW+xg2x5fyPC8egMkqU17e3ddRF7oyuWCp9RcMegtfYtE1jM9tB7t50PEaSiN6Y2Ccsp
         h6UZ5Y5fGlRncvIrSzXANpl4JEufI42Ncg8sAVcW2EQuVrw18Hb8mPX1WTb/JmBhDBCs
         Tk0bbHwoqwq2cYkD8bGdIzamMVgBSQGEJFLEqEOIqX170APo8KfmMDDWU1EVnF9Wu42U
         Fl9A==
X-Gm-Message-State: AOJu0YwawAfn0M5opkje/DrIsyKVGWdlU0oMFXW9sIC6p0LjMSsnrzqP
	YPnVljjZqeZZOHUWgdu4auWK05dO550=
X-Google-Smtp-Source: AGHT+IH1LFjhdzSA5VbfG5/LRZmb77TrfmEp860ZtfhUjNPa8IRdI8TvoQXj9NIBArPBNtg/oP7OQg==
X-Received: by 2002:a05:6870:d683:b0:1e9:a741:44f3 with SMTP id z3-20020a056870d68300b001e9a74144f3mr25565089oap.14.1699021641733;
        Fri, 03 Nov 2023 07:27:21 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::2fe0])
        by smtp.gmail.com with ESMTPSA id bb29-20020a056871b21d00b001dcde628a6fsm308272oac.42.2023.11.03.07.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 07:27:20 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v6 18/22] bitbake-hashclient: Output stats in JSON format
Date: Fri,  3 Nov 2023 08:26:36 -0600
Message-Id: <20231103142640.1936827-19-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103142640.1936827-1-JPEWhacker@gmail.com>
References: <20231031172138.3577199-1-JPEWhacker@gmail.com>
 <20231103142640.1936827-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Nov 2023 14:27:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15439

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


