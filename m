Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C07EC83F01
	for <webhook@archiver.kernel.org>; Thu, 31 Aug 2023 14:30:56 +0000 (UTC)
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
 by mx.groups.io with SMTP id smtpd.web11.18558.1693492246578316435
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 31 Aug 2023 07:30:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20221208 header.b=lFEdf12+;
 spf=pass (domain: gmail.com, ip: 209.85.160.47, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1c8e9d75ce1so472995fac.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 31 Aug 2023 07:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693492245; x=1694097045; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=geLfj6ivCsco72x9Mt0XTMc5VFwhgLE/MwdbTrsWTnw=;
        b=lFEdf12+PhaY1KgModr+/r18oxK5sxrSW6swnIz7pE4TOcpskOZ0qtbexSQ/vLcc5s
         tgxEaqU/maJmJZLdPGR+bS7OPWw8kEyhaPAPlLqmNL/jqejNos9Dres28fQKcbl+a2cg
         GcIukvT9s2UZZvVb3H1DGNdENfQLRp/zhZUV1s1gnfybKbpKF/V20W5PAyG/AFiLfyll
         8QQE/HbsDcJ3lFL+miiBgQuFurLi1LswWBaXB+M4kqMF0/1joWbDUYQatqIOgqNtmuNC
         kV5rTxWEvkdXjMV7DTqFkYJdYomU4o3vEa4SvLM7F9w5jRa+fYjB6ggBRd76IuaG4UG0
         9rZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693492245; x=1694097045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=geLfj6ivCsco72x9Mt0XTMc5VFwhgLE/MwdbTrsWTnw=;
        b=aOuFLHMY2e22Vt3rAfTtzZDD4LMeets57/M+SEsQ0zguVUKlUy+Pc5UEbjm1aYd9Qf
         ItJfX0TGJWpgu1b82cLmEpujYnFj1bD2+NyPR8Bqx9Djn+8sJ+bhYnZMsEtDpHP59APh
         bR7e2stWXS0P8wPXLAo89VQauBVcpbkymXQug7IPuML0Y/GNcVh4XHY5CifN4U/zlemQ
         RwLrnz7j/VkS+aIFb3gbzcEZQA+oKDUerievl90PEnOOOa038Jn/jBTNYQeQH4vh0tSL
         EFauF5zs34NaVwMisZq8IQsX0N6kE08Fb2smCr6FsJcrZYR0nI+irRquFgJuZULZb+lY
         QTSw==
X-Gm-Message-State: AOJu0Yz0P4e30vQ970f5AY8Dv/lfN3rb0M2zPWV2roYCL6sg5hSrdZi4
	xc6tOkJshTDx8lg+iQzXsnYH3MQpqWQ=
X-Google-Smtp-Source: AGHT+IHSLkMBJ9sQh8V5cA3QfFZ01vrLImXpw9a+dCKUX4r+pMXKPft9KqSBYyY8iUh6GJnJQq68iw==
X-Received: by 2002:a05:6871:a7c2:b0:1d0:c45c:9c0 with SMTP id wk2-20020a056871a7c200b001d0c45c09c0mr4848671oab.1.1693492245200;
        Thu, 31 Aug 2023 07:30:45 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::b66b])
        by smtp.gmail.com with ESMTPSA id ed38-20020a056870b7a600b001c52b2bdb51sm910977oab.37.2023.08.31.07.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 07:30:44 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: paulo@myneves.com,
	Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] fetch2: git: Remove useless try..else clause
Date: Thu, 31 Aug 2023 08:30:32 -0600
Message-Id: <20230831143032.1463093-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 31 Aug 2023 14:30:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15000

There is no reason to have the else clause in this try block, as it can
be moved into the try block, which is clearer.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/fetch2/git.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 33895e09b29..e11271b757a 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -373,10 +373,7 @@ class Git(FetchMethod):
             try:
                 # Since clones can be bare, use --absolute-git-dir instead of --show-toplevel
                 output = runfetchcmd("LANG=C %s rev-parse --absolute-git-dir" % ud.basecmd, d, workdir=ud.clonedir)
-            except bb.fetch2.FetchError as e:
-                logger.warning("Unable to get top level for %s (not a git directory?): %s", ud.clonedir, e)
-                needs_clone = True
-            else:
+
                 toplevel = os.path.abspath(output.rstrip())
                 abs_clonedir = os.path.abspath(ud.clonedir).rstrip('/')
                 # The top level Git directory must either be the clone directory
@@ -387,6 +384,9 @@ class Git(FetchMethod):
                 if os.path.commonprefix([abs_clonedir, toplevel]) != abs_clonedir:
                     logger.warning("Top level directory '%s' doesn't match expected '%s'. Re-cloning", toplevel, ud.clonedir)
                     needs_clone = True
+            except bb.fetch2.FetchError as e:
+                logger.warning("Unable to get top level for %s (not a git directory?): %s", ud.clonedir, e)
+                needs_clone = True
 
             if needs_clone:
                 shutil.rmtree(ud.clonedir)
-- 
2.34.1


