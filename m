Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B705ECDC185
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 12:10:49 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88567.1767701441755637357
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Jan 2026 04:10:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=b6cOVXrg;
 spf=pass (domain: gmail.com, ip: 209.85.208.44, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6505d3b84bcso1358035a12.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 06 Jan 2026 04:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767701440; x=1768306240; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CpdJzUw9SMxn5LmzNOuQmPvXU0YGfPMFhYPS+4Ho5Pk=;
        b=b6cOVXrgpMfGyZJJatCNs4P5LRcDGyO7MP4/WILhUcEk3wK0uVi4lK97xnHpIAGPme
         JaOtH3dOFul0dqO49sK3YxIxMC2WsYSjsGodwjD4qsT0WbRciQDeQ7C3fLU2fFkA9oTL
         7soTKoXWNMaepxdwLVsUidUthVTMSdQMeVQQUIUmk3JcAW8ZKxCypvp0VzLdaQyQ7QhW
         xQGXzdcBIogm2y8h5cRQfzyVCNRQVpmQT5w/+u9WkmLqFukSiZ/215HPUuA8LA5G8LTg
         OIE/xrZkfCgvTZnYBbp+qMGgHlWaSJCFrRjCxz3+1ktevtmiI1yOiR9RfVoFEWbORtob
         FYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767701440; x=1768306240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CpdJzUw9SMxn5LmzNOuQmPvXU0YGfPMFhYPS+4Ho5Pk=;
        b=wqAJQpFX2KRiypvCmlJll8eQTLCfYQcPBQkiphDTOkKbp/lEKllb6tKjpERU1FWDFY
         VNyHFlybr7BtVSAFoL3xgClVUr/p0Fr3l6OQFo5gb76XHfGjoI+O9/ZBjt5KZScKI4+k
         tXtRL2rHMaWykkocyt5TE2DCpaHa7eew42HZxTvxlq17XEzN0okC7EpJbLxwoh017AwY
         ENZypFOKL7LnzHjoIqBks+64m8ETOQ96fvIl6orFxDB4uWgyoPP0WFqDZoJMEFrsTkqz
         cH6NsHVT2b3kDSKHXeDINSLqERs2HmAXmwEkqzchvpQiku2wOIlOF1OkW3B1kLGrsTsO
         XJ7w==
X-Gm-Message-State: AOJu0YxIVUd+kUR8p0+3SGTiqF4XYVr6iZLLrM08myN3dlIOGPxmwQx6
	LhXRmr0AphNdeY+nx/Kz77sv5cbRcAkMwToCzXwLsSR/vmWb83ueNGvppknz9Q==
X-Gm-Gg: AY/fxX7Wj4lTcbDkOaJce22c+XPExM0GPAW2OkmXPkhHtKLffuZeex8i97/547B0pd1
	kJnqaMrXaU0v9KqQyYNvAsxjBiQSRasz9YhclCNYLoGEqZ/1FokTZXBZdVS3NULgWsDgjXb6TUa
	j1Iu8plDRRD7F30oyO9HaRRMWf/L0CH/5IXbS6Q97WqvYvPa/U4TCyumX2oBe3DrMZPwYJgseXZ
	UcMuY4nGGhl30zjFp/BGKsN95pJB1e6ArjyGXSec8BzQW+E5HOB0kuXcTla52gODdk/BSSPpRUX
	Xv6KQwKvwQkjgpfeSbvatql9zY0aa57Oazcx8b6+DDYFRGClEQnPZKMlzg3Nzq/Er6htzMOGZ9n
	JvV0LEsUbYC3JtFTxXkT3bU/8t2Sz0kulKvaL+joMAxMD4EQJTAD6zM9sDu3ew1cMagG61y/39B
	RD/VlGZAJIgdNQIhg05UkvhCqSkFPEioTaR+/YRsSwUfTsGnE=
X-Google-Smtp-Source: AGHT+IHHtcsT+0B3fzcCik/OH/mtYZuHN+O8Cue94hooBqfdh9wEZ6HS87DUHBwBSaiyCHkgT4Rq9A==
X-Received: by 2002:a17:907:86a8:b0:b84:2223:56a9 with SMTP id a640c23a62f3a-b8426bff4eamr311297666b.40.1767701439896;
        Tue, 06 Jan 2026 04:10:39 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8429fdf4e7sm223329466b.0.2026.01.06.04.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 04:10:39 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Anibal Limon <anibal@limonsoftware.com>,
	Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH v2 05/10] bitbake-setup: fix are_layers_changed when use local source
Date: Tue,  6 Jan 2026 13:10:27 +0100
Message-ID: <20260106121033.3892596-5-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260106121033.3892596-1-alex.kanavin@gmail.com>
References: <20260106121033.3892596-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 06 Jan 2026 12:10:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18695

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


