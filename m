Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0C8E7AD68
	for <webhook@archiver.kernel.org>; Tue,  3 Oct 2023 14:53:02 +0000 (UTC)
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
 by mx.groups.io with SMTP id smtpd.web10.110643.1696344776954788392
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 03 Oct 2023 07:52:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=feKMBj+X;
 spf=pass (domain: gmail.com, ip: 209.85.160.42, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1dd830ed844so662629fac.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 03 Oct 2023 07:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696344775; x=1696949575; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XY9kKr2eBN8L3/KZiT0Y8ZACyU8zjbHqSJZ2t+dd+o=;
        b=feKMBj+X5PRkKjbpVeqL86hS6p3BdGFXpylVveDAhO7Owj7IgIxcm3mdQprFzvMAnJ
         rxW9IDZgmAQv8pDO3QTzT5Ys3Xbgz1sRIcC1jMoRLK2LJvP9rngF06LIwsKvyWIP7ALf
         qOHTHZdfkZbYRrOg8WCaTIRw8jyBrj6AV5tghstT58VqIxvAI3JYhCaxV0aUs70HWAlJ
         CkArduSw2Kn8i8fpD8S6E+ElhAJiC4ed9ubberKDHM/XaqszUBz7auRstGvYYolLrMy6
         s1Ysk4SMCuHMGXNonSptvceaKj+1zZxsQUfZw4818po6yARYaHmdh7a6pwqV9TCffz4k
         WyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696344775; x=1696949575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7XY9kKr2eBN8L3/KZiT0Y8ZACyU8zjbHqSJZ2t+dd+o=;
        b=mmGkCcDDP6JzciGHVE8NapM1C5WHI6PaKrRJg/kRp2+Ehlx9xv1tZFbqt6cCfRlCfp
         t09oIk1yQnhUs9tmg45/PQkh7Im3YYMW5niJp5ujREHisYZSwOfNogqZPs+KDdCVBZBX
         w/KLfHvuvj4sPsVkwr263cwqolr8tVIVvVZTzUKCAbQKPLrSEZfvMrNw1Y1Ymkn4IBFO
         5bcdWBXO25Q9s+UdLMezAh5Iz7iA3iecSLxNaSQd1DrLHZSYZYrRA6lj7PMXGWR8WIGV
         BUEZuzuCQkbS/PriKQOg5SvTR0GfNxqy7wmJd0Fl6llkFZr9hwa3E6xry6Xh2+5S7itD
         tbsQ==
X-Gm-Message-State: AOJu0YwOBNtnMmjnKof/PNLvtqy/nX2uAdDDDwsFRQv39ytCDPrxpaCC
	E0hiFDznHd5U4A9WG173vBIhX4xNrq4=
X-Google-Smtp-Source: AGHT+IHIPUK2mjcGoSFJUiSNi3cGdDkdQ0FKSDy5+wM4T/lILN2QTHczNQg2SuqE6HH5Y3j5UNAjzw==
X-Received: by 2002:a05:6870:8a1e:b0:1db:70ee:efed with SMTP id p30-20020a0568708a1e00b001db70eeefedmr17031207oaq.18.1696344775685;
        Tue, 03 Oct 2023 07:52:55 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::589])
        by smtp.gmail.com with ESMTPSA id du28-20020a0568703a1c00b001dd2b869a26sm253477oab.17.2023.10.03.07.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 07:52:54 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][RFC v2 03/12] bitbake-hashclient: Add remove subcommand
Date: Tue,  3 Oct 2023 08:52:40 -0600
Message-Id: <20231003145249.1166276-4-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003145249.1166276-1-JPEWhacker@gmail.com>
References: <20230928170551.4193224-1-JPEWhacker@gmail.com>
 <20231003145249.1166276-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 03 Oct 2023 14:53:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15164

Adds a subcommand to invoke the remove API on the server

[YOCTO #15064]

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


