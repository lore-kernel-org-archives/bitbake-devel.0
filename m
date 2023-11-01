Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4912AC0018C
	for <webhook@archiver.kernel.org>; Wed,  1 Nov 2023 15:42:58 +0000 (UTC)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
 by mx.groups.io with SMTP id smtpd.web11.10737.1698853371441732417
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Nov 2023 08:42:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=DBdr/KQO;
 spf=pass (domain: gmail.com, ip: 209.85.167.174, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3b2ea7cca04so4389143b6e.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 01 Nov 2023 08:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698853370; x=1699458170; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vllbvf2QC63w5kgh8Upy6LpMkxWE4pcy1xac5Pt+QzU=;
        b=DBdr/KQOYoymkrYwgvGgc9VjNaXXdMOdUaJI64Gw30BzB8DllN6E+SUyghArkPoqHx
         OvhdorLP+hvIaEzQdcl1ybmXynELay7UsEfg6duKcyhJU2+FfLfT46QsRH4j8srFpRBY
         FuYDfc56+UBOYHydJczbBm2dq+bUxVRXe0ekflZQjAsHwT4jb38lLUKIb4JM3qJgh40J
         QIYJa2B8arQa5ZUYNjeK8J0cNLnTiiEbzxSpplsHU7HjgwUHfmEFPChZAP1KW4Dz9klp
         wgfXYNGYbJAYISn4ZKin7pg8bg2je8Zb0SWfHdnhA3O7Eeg25LBEP8U+pqqVWgXLYG9I
         Wc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698853370; x=1699458170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vllbvf2QC63w5kgh8Upy6LpMkxWE4pcy1xac5Pt+QzU=;
        b=BNXc/I6CRH81Baf1wiPmGncbZ16zKsNg+yATF4B6pWHwM4L4TfjzhCOjS75XHVl+Nb
         jzxtcTutxYzu+1qo7KwK8dGYnODW5Ui+4xqohH/psAzWCJBBMSvhrOZDlkjExMpANc04
         3zzNuSP7W4LOkS6wzdy4rDlC/L3OUQbdFTg5cSk5oSa3hV6OItgkFnbt8jnEKEAeylgG
         goaudBVHtLDSZYm9ZXb0MKPIneAJjbyrJXNDcL0bJCU0yuqCmNlzVX4q1m9asi1XbHXB
         IDxQpbSCjuXGOWmzncfMVY0P4r8DtWQ9rHgcofy7Odd8TsMQmKoZeBxK3QO5ezMyOvd4
         sgWw==
X-Gm-Message-State: AOJu0Yz10CK33vRwHnOc6sPoyJ7G3TyfLpVxPafSkUNNy44Ze/UpeaqD
	8InygYIkku159m2w8D5bPuUdlA6/NG8=
X-Google-Smtp-Source: AGHT+IGHHeQIkdH0FFgRzCZL51emAiOAZSY1pOJc74ntYKGNbsyaEgobLM4AUAhxpyArvCUC0rT13w==
X-Received: by 2002:a05:6808:1986:b0:3b5:6533:d2cb with SMTP id bj6-20020a056808198600b003b56533d2cbmr5847453oib.46.1698853370167;
        Wed, 01 Nov 2023 08:42:50 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id l9-20020aca1909000000b003ae36d664a9sm249651oii.39.2023.11.01.08.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 08:42:48 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v5 18/22] bitbake-hashclient: Output stats in JSON format
Date: Wed,  1 Nov 2023 09:42:12 -0600
Message-Id: <20231101154216.2758185-19-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101154216.2758185-1-JPEWhacker@gmail.com>
References: <20231031172138.3577199-1-JPEWhacker@gmail.com>
 <20231101154216.2758185-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Nov 2023 15:42:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15400

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


