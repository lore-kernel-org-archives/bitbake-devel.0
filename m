Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3AFE81E10
	for <webhook@archiver.kernel.org>; Fri,  6 Oct 2023 15:37:02 +0000 (UTC)
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
 by mx.groups.io with SMTP id smtpd.web10.16163.1696606612989330060
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 06 Oct 2023 08:36:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Mw6/56Pl;
 spf=pass (domain: gmail.com, ip: 209.85.160.50, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1dd5b98d9aeso1148203fac.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 06 Oct 2023 08:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696606611; x=1697211411; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUoWHkynR4Ogd1i339u7tNTcw45boZtbQCJfU0l7Hm0=;
        b=Mw6/56PlsZtZtQrcWjNbSQsymr1KA6CAqStB44uFi90sXpDw9UNq9ElAsIQviIkE9k
         /mXZtQKDHHZ2gGAGjupoe5aU7+JfXPWUYvniejQcjkRzw4AJQycsojfTyAHOqorBhS/O
         LqpmG0V3W5tRrGPcuQc1g20YmC3EnxjGlraZeODm1BJg2mEiZ5peQqmpPdbsKowSH/Kz
         BGW3jr92Rbj7C0ROONpU25/iMDwshpvBWndDZ5xdZKxOtsRF80DcCHfbk9YR7OAxhRcG
         4RoPfYfgQsz84qsDe8zna9HrAegOvDfR9bDvHri3pFt8WQBaqG0dKdJWC8OuriCHvGmX
         202g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696606611; x=1697211411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GUoWHkynR4Ogd1i339u7tNTcw45boZtbQCJfU0l7Hm0=;
        b=mvyVI267GabGwm7CDAN+TBY0fO/J+h+QgbxAJ9qHWdBR1gHtsGB3EyJwMfFVyHiW15
         avZ8e1HcLh7MNBrelhrtJ8jXcUPEPyXexKjIhupCEUWJlTYuYJpXv7xtnS17NUTACNif
         Yb2TmVuqZYNr2PeFLNhm/1VthVQZ8GxxuttPpbVi+LNeroCw+RrU3aeg/FQTbXgjVrG6
         bX8zHayFT2cJNRStZmr9plHu/jfYdlEmd3vzaAkcdF3uT8Po8WxyorTWVnv8DIpdh9Nf
         TcyXtycn/DnlGiQRrY7YNB0rvpdzTDEtVf4xi7jRaeWJ/puSp2prjraS9/yL/llk/GsV
         sYNg==
X-Gm-Message-State: AOJu0YyA1aeDoQjuYt7e5Gl2/KwDMnpxKtuQGCWyFYq1v/fcNaRSvcZM
	d2pYcGw4jjmk0t9XV/kARU0dmfmSMY8=
X-Google-Smtp-Source: AGHT+IHdqg3euQ50e4wpJofCu8nM8qLCUvXr9chlMOIxi3dhFv3LuUwqU/RLEeMxeByAom0BCfEiPg==
X-Received: by 2002:a05:6870:1cb:b0:19f:e5a8:7525 with SMTP id n11-20020a05687001cb00b0019fe5a87525mr2588222oad.12.1696606611443;
        Fri, 06 Oct 2023 08:36:51 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::8282])
        by smtp.gmail.com with ESMTPSA id 26-20020a056870135a00b001dd395339c3sm780426oac.19.2023.10.06.08.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 08:36:50 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 2/5] bitbake-hashclient: Add remove subcommand
Date: Fri,  6 Oct 2023 09:36:42 -0600
Message-Id: <20231006153645.1609760-3-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006153645.1609760-1-JPEWhacker@gmail.com>
References: <20231006153645.1609760-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 06 Oct 2023 15:37:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15189

Adds a subcommand to invoke the remove API on the server


Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/bin/bitbake-hashclient | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/bitbake/bin/bitbake-hashclient b/bitbake/bin/bitbake-hashclient
index 494f17592ac..d09104336ab 100755
--- a/bitbake/bin/bitbake-hashclient
+++ b/bitbake/bin/bitbake-hashclient
@@ -113,6 +113,14 @@ def main():
                     with lock:
                         pbar.update()
 
+    def handle_remove(args, client):
+        where = {k: v for k, v in args.where}
+        if where:
+            result = client.remove(where)
+            print("Removed %d row(s)" % (result["count"]))
+        else:
+            print("No query specified")
+
     parser = argparse.ArgumentParser(description='Hash Equivalence Client')
     parser.add_argument('--address', default=DEFAULT_ADDRESS, help='Server address (default "%(default)s")')
     parser.add_argument('--log', default='WARNING', help='Set logging level')
@@ -137,6 +145,11 @@ def main():
                                help='Include string in outhash')
     stress_parser.set_defaults(func=handle_stress)
 
+    remove_parser = subparsers.add_parser('remove', help="Remove hash entries")
+    remove_parser.add_argument("--where", "-w", metavar="KEY VALUE", nargs=2, action="append", default=[],
+                               help="Remove entries from table where KEY == VALUE")
+    remove_parser.set_defaults(func=handle_remove)
+
     args = parser.parse_args()
 
     logger = logging.getLogger('hashserv')
-- 
2.34.1


