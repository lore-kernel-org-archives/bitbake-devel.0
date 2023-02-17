Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA15C636D4
	for <webhook@archiver.kernel.org>; Fri, 17 Feb 2023 12:27:43 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.5257.1676636853270744742
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Feb 2023 04:27:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=hVWdPFN2;
 spf=pass (domain: gmail.com, ip: 209.85.128.54, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f54.google.com with SMTP id f19so784223wml.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 17 Feb 2023 04:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5uynScjmUdxcGfyVgfI5AevLOQAWPSgGAelMxB2+nnY=;
        b=hVWdPFN2nUrhOsc1F0cXpgR+yS0VStIFDvcCE/OkhKDe5bXrwvLcIhpP/lkIlQJXqu
         gjB0ZoO4Z5H0zsQhUR0EBQvJtEzC/lv5yk0sDBCsZeJ6kx+cvJ1WKqo2BaDP64eD3LNJ
         d+HDiELAKGqk32+cmeb8EeprK3/MdK72KhcOg+/XiIOwW580n4hMLD9kgh1PMKQc9Aby
         THn1nrtX4+ZyUy6mVu/RIhz+xsR53vNygLv5vCnVsROjK/PdEkUm06uN3oif2ZUW6xmP
         OfHt1H/ON9MNNVkiV7Icm2NiOGoFpurjbJ90slIG+lHwmEv9PuoZVZpYeYdTI5BtJLnF
         kxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5uynScjmUdxcGfyVgfI5AevLOQAWPSgGAelMxB2+nnY=;
        b=PDzIepc4clq8yF5A2wkkXJ0rXXvwPmmHRyj+Y8GfPnFFJfCiugf7XbHrfjJgSxMiCV
         4kptXFPQIhxvbJD8weWhylqW3EwMCdVQp4kSuo579ZdtV9ARu3aLwYZRzEbE81wX7hpt
         J9mmpbeNqtP9CfwLUKsOi8G8b1UyGwDyfBxR20Nde3Z38UXow2FosjvvhqltcXS+ELPy
         WEnkBdwLzQ7UHqJa5Na3SiiP3d+IKJ6ShWSes5LuifnawMEmawO6sXYK6aKvc9N3lACq
         gcNE8FsAUIQts4KFGoTjUca9KvDpdYoQ9txNHnJLsUBuG4iUYD3yqTu4lFRW8DbSQ7t4
         bWTA==
X-Gm-Message-State: AO0yUKX/o0Y+BZOjpg7zCvW8hImXM7GEaCBvrBaAMXtecjGuajqPjaml
	EIEh1hwbApxLTfdvz913U7C1r2Nm/mA=
X-Google-Smtp-Source: AK7set+e3p2vaW/dEZUmJhe/N6JkVKCAd4xGFkct5pW0QsdZNTkPW+Xi4IeJ1lnCHLMYohGXB+yXRQ==
X-Received: by 2002:a05:600c:1d97:b0:3e2:1dac:b071 with SMTP id p23-20020a05600c1d9700b003e21dacb071mr2825808wms.13.1676636851508;
        Fri, 17 Feb 2023 04:27:31 -0800 (PST)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id 21-20020a05600c021500b003e209186c07sm6043583wmi.19.2023.02.17.04.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 04:27:31 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Martin Jansa <Martin.Jansa@gmail.com>
Subject: [1.46][PATCH] bitbake-worker: show debug output when network is enabled
Date: Fri, 17 Feb 2023 13:27:25 +0100
Message-Id: <20230217122725.3637432-1-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Feb 2023 12:27:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14450

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 bin/bitbake-worker | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index d743ff510..09e486f7e 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -275,6 +275,8 @@ def fork_off_task(cfg, data, databuilder, workerdata, extraconfigdata, runtask):
                         bb.utils.disable_network(uid, gid)
                     else:
                         logger.debug("Skipping disable network for %s since %s is not a local uid." % (taskname, uid))
+                else:
+                    logger.debug("Skipping disable network for %s since network varFlag is set to %s." % (taskname, the_data.getVarFlag(taskname, 'network')))
 
                 # exported_vars() returns a generator which *cannot* be passed to os.environ.update() 
                 # successfully. We also need to unset anything from the environment which shouldn't be there 
-- 
2.39.2


