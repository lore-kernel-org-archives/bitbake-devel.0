Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322E8C433FE
	for <webhook@archiver.kernel.org>; Thu,  3 Nov 2022 09:04:11 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
 by mx.groups.io with SMTP id smtpd.web09.17263.1667466242102145885
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 03 Nov 2022 02:04:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=UrQgTlso;
 spf=pass (domain: gmail.com, ip: 209.85.218.50, mailfrom: martin.jansa@gmail.com)
Received: by mail-ej1-f50.google.com with SMTP id bj12so3351262ejb.13
        for <bitbake-devel@lists.openembedded.org>; Thu, 03 Nov 2022 02:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X1a2B7OuTmrCqdEGqLUN+P4YLsZFErkI3UHf7608QS0=;
        b=UrQgTlsooAHWQmhpUs1aAqe96YYOnThyJRrRUWFsBppGTSxgzX5U40y9AwelMPaNqv
         zthoEatwIORFG/EtXrFbqm9wNo/Fgc94sg4JvWgcQtS2H6t/oin40lnBON+mTHZi/IpM
         PehVvJ4iO5QkiK/o1/Rm7a55z1XVy4tNl2zHgGNMghxwOeae/qpuBPG5S1hOIrO5jd8b
         K3qt8d0Q3NXhxiCSWj95rcTGqY8rP4dbciiJLTUg+4FTOiOwIqy2KhQuqDMTognFSzIE
         NceAe4CYHPipcQEEVqNA6U1hrkmvKLe2yXiemXk513umkGvEH5gVsGjOWA6ZlygV92U/
         +KVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X1a2B7OuTmrCqdEGqLUN+P4YLsZFErkI3UHf7608QS0=;
        b=K2ZEW9iGuZLoFIMP4JJPvsJc/gCsLtN7w4VRVYbLD1Zx1RYmfW0fdJmeOIa3u/52hX
         xXLohjhv6wSEjtSBG0weUO1H17cu6Aa2kdJLGsMLlWg2j//hE+8rNyyrj5fL7Ch7sf/h
         5ho3oDm2Yx7fZrpQGgQ2sf+z6UZAIJBT0a0uIsSrgXU/R5YWpCm8AeyJE+nYVVA4iBIQ
         wQhAZuuyMy0Bd+FLaWpp1h2xHKg0XkDUe3ZZRo0J2IH+SjTbgDiFtF8228eADJ4a6CFj
         LvJ8i/Jl0pTlManXGNKWkp2sh8+Gl0XhWkfEPiPtd2nEcd+WQKm7iIuAtMBHYI9Li/om
         EK1g==
X-Gm-Message-State: ACrzQf0Px/VkHYeMxvKGTuMLRhRb6Hzv3gTo+sg0ICAlNgdO+Yb9SDv2
	d07uu2luEaJHheVKAqN0cUEfJyGObAE=
X-Google-Smtp-Source: AMsMyM6OL1yHMWv1d4AY/x4O2vKGmT+ezw2POREL9lAJ7/Ye63X48aBZ85bzX9Nzffg0/vnqfzYI5g==
X-Received: by 2002:a17:907:a428:b0:78d:9fab:84fb with SMTP id sg40-20020a170907a42800b0078d9fab84fbmr26569439ejc.694.1667466240540;
        Thu, 03 Nov 2022 02:04:00 -0700 (PDT)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id bo1-20020a170906d04100b0077077c62cadsm242675ejb.31.2022.11.03.02.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 02:03:59 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Martin Jansa <Martin.Jansa@gmail.com>
Subject: [PATCH] bitbake-worker: expand network varFlag
Date: Thu,  3 Nov 2022 10:03:56 +0100
Message-Id: <20221103090356.1655054-1-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 03 Nov 2022 09:04:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14055

* this allows to use conditional when setting the value

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 bin/bitbake-worker | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 7be39370..fa606667 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -263,12 +263,15 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, taskha
 
                 bb.utils.set_process_name("%s:%s" % (the_data.getVar("PN"), taskname.replace("do_", "")))
 
-                if not the_data.getVarFlag(taskname, 'network', False):
+                task_network = the_data.getVarFlag(taskname, 'network')
+                if not task_network:
                     if bb.utils.is_local_uid(uid):
                         logger.debug("Attempting to disable network for %s" % taskname)
                         bb.utils.disable_network(uid, gid)
                     else:
                         logger.debug("Skipping disable network for %s since %s is not a local uid." % (taskname, uid))
+                else:
+                    logger.debug("Skipping disable network for %s since network varFlag is set to %s." % (taskname, task_network))
 
                 # exported_vars() returns a generator which *cannot* be passed to os.environ.update() 
                 # successfully. We also need to unset anything from the environment which shouldn't be there 
-- 
2.38.1


