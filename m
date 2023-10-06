Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B0DE81E14
	for <webhook@archiver.kernel.org>; Fri,  6 Oct 2023 15:37:02 +0000 (UTC)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
 by mx.groups.io with SMTP id smtpd.web11.16223.1696606617454019270
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 06 Oct 2023 08:36:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=jx/FtFTk;
 spf=pass (domain: gmail.com, ip: 209.85.210.48, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6b9e478e122so1521189a34.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 06 Oct 2023 08:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696606616; x=1697211416; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3g97yjGXbXFbP5HGnu6VO3o1P55wxI9Ev0ppm6C2408=;
        b=jx/FtFTkIsGwbaJZ9csz0iqenHmKuL8vIgLqln0C8hLb4bZD1pZdz5ZO3Uk0dz6QsS
         c43CSAoA3Ls6Wp8FLJTuUGFM6Mr2AhCOIxi3lJhxvkwLB+/Ij4awha6DilIcTuY5JJ5n
         8w8Ye+EoGns7VdnQDiFs0zZzcpi7AGFHBMkpc1RQhkxzwgFDub/qLccIv5Ztqlj6Pdt2
         /NPgNId3vCc/n4LYT9381bw18Mlpl9Ex9htRCSwoZUJYZSEiCVp5zfp/PWOskP/F7Vjc
         SfLUth3/wDL2rcdaBAK4Kla2l9GUX1rr9Jz61LelXCpR7jCH+pZ7SwRRil+3DQdTSfpj
         ZVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696606616; x=1697211416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3g97yjGXbXFbP5HGnu6VO3o1P55wxI9Ev0ppm6C2408=;
        b=hPxSOhdDXiQ3hxPuo2Jra6KMfNsQs7fNiP/Cw/dQqUrzhfbTmZI4ordQlcSjo2tmB+
         3URld01eZuMC1N1vzTLtpZyslZD1wyjXMW99hWVO2a7tPmWcRxWcNA5PlYzMl5l6UrBp
         GndxlHij4lIR65okhf3AH6FYqtxgvAJ9Sph8hFcFbKmwJc8lkoJiV1wOk95C1teiUzII
         7nKGSnjoGAJr4c15SFCrgHpjianocw3BSVU5Zn4jWvFKdItM4iiFSfyrmWjz9l4hVqiY
         UUpkltrZ++9HVFG2BeqgbLPJd6mrzw+88FrxHKjs6j5Rwoi3VpQ6GCygdPLsaND5I6lw
         3mlw==
X-Gm-Message-State: AOJu0YzdG7GT27+6o+YGKOc8kSHCda9BAs8rtdvv3m9CO1L6Cvaezpie
	7yWjg6ClySRpe/nFDD88LcYRF14OnmE=
X-Google-Smtp-Source: AGHT+IEY0X1Z6YKWR9gYbp1Mv0hHkvdAs4gCFXLviqs/w8PAbzQufVzklC+0e555RfATB7j3kZj7uw==
X-Received: by 2002:a05:6871:54f:b0:1bb:c50d:7451 with SMTP id t15-20020a056871054f00b001bbc50d7451mr9475114oal.46.1696606616143;
        Fri, 06 Oct 2023 08:36:56 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::8282])
        by smtp.gmail.com with ESMTPSA id 26-20020a056870135a00b001dd395339c3sm780426oac.19.2023.10.06.08.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 08:36:55 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 5/5] bitbake-hashclient: Add clean-unused subcommand
Date: Fri,  6 Oct 2023 09:36:45 -0600
Message-Id: <20231006153645.1609760-6-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006153645.1609760-1-JPEWhacker@gmail.com>
References: <20231006153645.1609760-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 06 Oct 2023 15:37:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15192

Adds a subcommand to clean unused outhash entries from the server based
on age

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/bin/bitbake-hashclient | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/bitbake/bin/bitbake-hashclient b/bitbake/bin/bitbake-hashclient
index d09104336ab..3f265e8fa7b 100755
--- a/bitbake/bin/bitbake-hashclient
+++ b/bitbake/bin/bitbake-hashclient
@@ -121,6 +121,11 @@ def main():
         else:
             print("No query specified")
 
+    def handle_clean_unused(args, client):
+        result = client.clean_unused(args.max_age)
+        print("Removed %d rows" % (result["count"]))
+        return 0
+
     parser = argparse.ArgumentParser(description='Hash Equivalence Client')
     parser.add_argument('--address', default=DEFAULT_ADDRESS, help='Server address (default "%(default)s")')
     parser.add_argument('--log', default='WARNING', help='Set logging level')
@@ -150,6 +155,10 @@ def main():
                                help="Remove entries from table where KEY == VALUE")
     remove_parser.set_defaults(func=handle_remove)
 
+    clean_unused_parser = subparsers.add_parser('clean-unused', help="Remove unused database entries")
+    clean_unused_parser.add_argument("max_age", metavar="SECONDS", type=int, help="Remove unused entries older than SECONDS old")
+    clean_unused_parser.set_defaults(func=handle_clean_unused)
+
     args = parser.parse_args()
 
     logger = logging.getLogger('hashserv')
-- 
2.34.1


