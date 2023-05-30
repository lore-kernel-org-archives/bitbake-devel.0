Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337E5C77B7A
	for <webhook@archiver.kernel.org>; Tue, 30 May 2023 15:30:38 +0000 (UTC)
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
 by mx.groups.io with SMTP id smtpd.web11.334.1685460632668795759
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 30 May 2023 08:30:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@gmail.com header.s=20221208 header.b=Mzi73wSj;
 spf=pass (domain: gmail.com, ip: 209.85.161.51, mailfrom: jpewhacker@gmail.com)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-55554ab909cso2220270eaf.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 30 May 2023 08:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685460631; x=1688052631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K/cdCCe1SpifhkoS/xkdbtXI49QSJsUkOH3Qp7W9/hs=;
        b=Mzi73wSjxmqGM9yEgjL7AEh55JuMzPdUG9nSXvaidbBn2B6QuTVK8rJgDVQHKqkCos
         6r/Lx5+9ol0SVJrdqSCzh3I3lqbUKIr3lCvifrlHjfuhcfyA5+SMg4Gr+bFnYkyzwoik
         Brh5nYFEam76mHGDBzpz+gPca6HhCZNEXPmWk4rkKEHuox3SVZ6lfPiIKOoVolYGwjHD
         cM2NhVa8/+4CNMGVI8Ix2J9Pyj8WdLLxGygT3vHQwbEbPD6WOu2K0wMuKRShuvBKg4jU
         OdECUH01XgGvuJCgb7sUuINATocdCdpCuJbvJSMP/LkyyHz3I3jIMvzw5JMZXuQ/vFgv
         e9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685460631; x=1688052631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K/cdCCe1SpifhkoS/xkdbtXI49QSJsUkOH3Qp7W9/hs=;
        b=QhfYO66Kxl8/0bHyHL8vk1cDfNr1Hiucqqfc3Opd+4hEpFSafFnPvPz3gtD9Mwzf8b
         xduKHTdMeH8krMoMOUm9b5BuyjwRwa715nu4bnviJ8NnMtFqwnHMv5k/zyJAA0VqZlPB
         +IsQ622sewkDeQmAvIoPxajMS9aIkYqtWJn2lJ5sIKCcJDPgD8iWSnHCQzqNfEUmPmtZ
         h+G3dIYJaZ9OzygXN21sXJyylJx7E5KOSzDFQ58i2kucvk6FfprFQYgAZvub0J46TbEp
         Y6pR+eFj9+7hJm7KlQo+XqJPybiHT0kfTzGn+Pds28YdThBkb1oUEpxs2fqbAIrLNhFb
         dEjA==
X-Gm-Message-State: AC+VfDySR4mQmmcLQcqODayHAsjjD3lJ0H3rJuBx1sDlUFsUn6/0bgKG
	wMdYifjUaqE8/9L7poJtErW93SDg8R0=
X-Google-Smtp-Source: ACHHUZ5B5H+qQnbo0VytWOGUhJMSqeuxk7xvNGOfeI1QsXTdlJUDlxP/XbQBtRQY7agIJtM4wqbyAw==
X-Received: by 2002:a05:6808:1915:b0:398:627e:c71 with SMTP id bf21-20020a056808191500b00398627e0c71mr1834774oib.0.1685460631340;
        Tue, 30 May 2023 08:30:31 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:ac3d:c100:e3e8:d9:3a56:e27d])
        by smtp.gmail.com with ESMTPSA id q127-20020acad985000000b0038bb2f60064sm6029406oig.30.2023.05.30.08.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 08:30:30 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] runqueue: Pass hashfn in taskdep data
Date: Tue, 30 May 2023 10:30:25 -0500
Message-Id: <20230530153025.190113-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 30 May 2023 15:30:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14818

Include the hashfn (the value of BB_HASHFILENAME) in the task dependency
data. This allows tasks to get a specific unique hash for dependent
tasks when one is available.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/runqueue.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 1eac2da5e80..01701348eda 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -2353,7 +2353,8 @@ class RunQueueExecute:
                 taskhash = self.rqdata.runtaskentries[revdep].hash
                 unihash = self.rqdata.runtaskentries[revdep].unihash
                 deps = self.filtermcdeps(task, mc, deps)
-                taskdepdata[revdep] = [pn, taskname, fn, deps, provides, taskhash, unihash]
+                hashfn = self.rqdata.dataCaches[mc].hashfn[taskfn]
+                taskdepdata[revdep] = [pn, taskname, fn, deps, provides, taskhash, unihash, hashfn]
                 for revdep2 in deps:
                     if revdep2 not in taskdepdata:
                         additional.append(revdep2)
@@ -2693,7 +2694,8 @@ class RunQueueExecute:
                 provides = self.rqdata.dataCaches[mc].fn_provides[taskfn]
                 taskhash = self.rqdata.runtaskentries[revdep].hash
                 unihash = self.rqdata.runtaskentries[revdep].unihash
-                taskdepdata[revdep] = [pn, taskname, fn, deps, provides, taskhash, unihash]
+                hashfn = self.rqdata.dataCaches[mc].hashfn[taskfn]
+                taskdepdata[revdep] = [pn, taskname, fn, deps, provides, taskhash, unihash, hashfn]
                 for revdep2 in deps:
                     if revdep2 not in taskdepdata:
                         additional.append(revdep2)
-- 
2.33.0


