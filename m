Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5028FA375C
	for <webhook@archiver.kernel.org>; Fri,  2 Jan 2026 19:35:00 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11802.1767382490643626598
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Jan 2026 11:34:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HmDMhU+Z;
 spf=pass (domain: gmail.com, ip: 209.85.218.49, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b79ea617f55so2368843366b.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 02 Jan 2026 11:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767382489; x=1767987289; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CpdJzUw9SMxn5LmzNOuQmPvXU0YGfPMFhYPS+4Ho5Pk=;
        b=HmDMhU+Zu5oruUZupQLIlo6dgRY6JRUJUQ/krEJP0rBQM8iuOIEqKHPV55Nylj+1Ff
         y28iULJDlFOUXnYiOmy5JeTM4ykVxfTRydcg1FSiDofTH09f7e1gIwxEIA3Ua3xgm/24
         5XJYzVpjVW4+LT93HCfP7XtVQTYh5WXHDHYamuUads8L0hSIdmtKKBhb5PVw7Bxb5N92
         dH2dV/X2ckwBv6AVbWhL73MXeeZLegMx17FJvRIr2pLY91BzNC0wtV1eKajIV5hCOdbH
         611Eq5/2h4YndZzdoYchwnANAwsbrrtct75Hc16JAUMCqu+EoWGR1IZ2+wO9GhMB/iQl
         0kNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767382489; x=1767987289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CpdJzUw9SMxn5LmzNOuQmPvXU0YGfPMFhYPS+4Ho5Pk=;
        b=QjYaBvUkCdjp1CL6JBR+ieY8rdMfsbuZWECDoTyw2FO9Gkq6Qi409/meOaU6jLqkGY
         FATwZiOURFGfJ5ou2DvudMhP2zfS+xTMNW6E6iW4iGLxA5ckVnRgtO5WoTZ6HGDaTTh+
         4SRCwbjP3yWGYGhYYC0vv47OonWtD84Sg5HuFs+rsszjtRcEIeQkyHXKLlMdO/djq/1A
         EfTU6llP6f2PuMVzn3s3HYMgSJ+HMCnRJmpH56GghOHGHzy/qUWAcG0oJdS11a5UkAqS
         Kd1Hwk0urMmOR+6iEb9yqnHD90fTNvTHojQKPWcPUYE5HU74HkgGKjctoUo6a/xsnBZU
         UzQQ==
X-Gm-Message-State: AOJu0YwlWlYcz+eNZob6JI0PBOPK2/6SWW7nLtexpNUiGdTRNbd7s36b
	roLYhQaAlfdszdOd0Mec8y6wtcsXxgFN/piuN/rqe9jP/cPbVfds8gDIoLiX2A==
X-Gm-Gg: AY/fxX5NQDi7CH23VN8bm+EOB0MKbZIhlhaUoy89JbIP32ItZXWADFw2MXPzL7hgM1W
	lGTyT9/LbDDtLq6fcZmgtbQnl7BKHkV8z37T0XbmlAKnAHqKCkmX7LizzoKFywMPOa187So8/Rp
	GJQT/ONBa4S4HSpnOedGBoe3FMoLZ60VbuQFENe+Y3lmLz+i4qZB5kr3NsRCqtAnowXBeniWjc7
	d6aBRZcfvyxnSTYVZBg/4C+5lPGxaQ1DvGyp2QtQfTcv5FQG6bfT1nq5OLphP6K2tfyyvn8QaV2
	fOnsjNdY2BtQQa96gNNTydw6od87YLpWOF+xtsVXO4hH8sXyl6EOqhbuF0+myemoBmQNmLqcD4y
	v5GJUBsZklAOvWIJMRZU6un6tkm8m2wCU9zFjJ/K8Xkk8IbSUrIEggWAvWual7TzQepml6REdss
	wS1Nddgj2l05v/K/wGWXzmFAlxa/0gQle7ALfCeb51/eEZCL4=
X-Google-Smtp-Source: AGHT+IHPzYgnJFR2BQQGcqk9fHOJEgeunBEF6KYYJ0BPFM8R0c57LnhXC3D8w43vtL1NNO6y5m9lfg==
X-Received: by 2002:a17:907:2da6:b0:b83:95c7:f87b with SMTP id a640c23a62f3a-b8395c7ff41mr1264577966b.37.1767382488874;
        Fri, 02 Jan 2026 11:34:48 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037de11e5sm4645615866b.39.2026.01.02.11.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 11:34:48 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Anibal Limon <anibal@limonsoftware.com>,
	Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 05/10] bitbake-setup: fix are_layers_changed when use local source
Date: Fri,  2 Jan 2026 20:34:32 +0100
Message-ID: <20260102193438.2960561-5-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260102193438.2960561-1-alex.kanavin@gmail.com>
References: <20260102193438.2960561-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 02 Jan 2026 19:35:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18675

From: Anibal Limon <anibal@limonsoftware.com>

When use local source the git-remote isn't set causing exception because
takes repodir as default value.

Fixes:

```
NOTE: Looking up config ls-master in configuration registry
Traceback (most recent call last):
  File "/home/workspaces/ls/bitbake/bin/bitbake-setup", line 1042, in <module>
    main()
    ~~~~^^
  File "/home/workspaces/ls/bitbake/bin/bitbake-setup", line 1035, in main
    args.func(top_dir, all_settings, args, d)
    ~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/workspaces/ls/bitbake/bin/bitbake-setup", line 667, in build_update
    build_status(top_dir, settings, args, d, update=True)
    ~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/workspaces/ls/bitbake/bin/bitbake-setup", line 658, in build_status
    if are_layers_changed(current_upstream_config["data"]["sources"], layerdir, d):
       ~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/workspaces/ls/bitbake/bin/bitbake-setup", line 627, in are_layers_changed
    changed = changed | _is_git_remote_changed(git_remote, repodir)
                        ~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^
  File "/home/workspaces/ls/bitbake/bin/bitbake-setup", line 601, in _is_git_remote_changed
    rev = r_remote['rev']
          ~~~~~~~~^^^^^^^
TypeError: string indices must be integers, not 'str'
```

Signed-off-by: Anibal Limon <anibal@limonsoftware.com>

Alex: remove the default '' value from get() as None is used otherwise, which is also suitable.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 7c4fa1934..0d33f0896 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -625,7 +625,7 @@ def are_layers_changed(layers, layerdir, d):
         r_data = layers[r_name]
         repodir = r_data.get("path", r_name)
 
-        git_remote = r_data.get('git-remote', repodir)
+        git_remote = r_data.get('git-remote')
         if git_remote:
             changed = changed | _is_git_remote_changed(git_remote, repodir)
 
-- 
2.47.3


