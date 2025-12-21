Return-Path: <anibal@limonsoftware.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8366CE6748E
	for <webhook@archiver.kernel.org>; Sun, 21 Dec 2025 00:47:30 +0000 (UTC)
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.51293.1766278046444150751
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 20 Dec 2025 16:47:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@limonsoftware-com.20230601.gappssmtp.com header.s=20230601 header.b=Zh+yT9/i;
 spf=pass (domain: limonsoftware.com, ip: 74.125.224.50, mailfrom: anibal@limonsoftware.com)
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6446c1a7a1cso2521341d50.3
        for <bitbake-devel@lists.openembedded.org>; Sat, 20 Dec 2025 16:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=limonsoftware-com.20230601.gappssmtp.com; s=20230601; t=1766278045; x=1766882845; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WQcyQsqSpwfeGBtcxJ88F7f0o0GEOOzmavHMkjtAF0k=;
        b=Zh+yT9/i+uelny/gmhTyaqslCYSS7sJ0z5lkXoqDEBgs9W/n/teZPn869a4l5c0Mrz
         jEecDf8f8fc7Nd5ZFGERBzKhphl/bYVprxdp/JWoFjGcBo2q9elup1j0oWeEAW/zPHSB
         CCFzHc1f57yeP+a2DGOl6XvgISB9xntgQR8/rJWqJ8v88Fcc5p3GvdyX39Ck39ld3v45
         OeY1tjit4CxkH8WpbiJeJjrRkVEsTuHSiL4923uRoFkLaoLNyuivYBoZRhsWc3zrDXO7
         u0yMOD32eoHa096gtC6TPObeJs+Pfd4qduscAaC/50EYV8qniJbx/Uu3XfS1X2frE0tX
         pg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766278045; x=1766882845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQcyQsqSpwfeGBtcxJ88F7f0o0GEOOzmavHMkjtAF0k=;
        b=wzYXUE1R19hcEK2YUv6KnXaAHcIMdVi4/vmTav6jO1PtZQwxQhsjhbxkVnMnLHneX7
         N1nb7AJI9ZkVqTWQqbXsVCZlFnfjWQ8Pfxng/zDCfiXVzHfqnBV82nL5vO4NhehJO5Ep
         ut7aa5Iecm3wQ2yhObA+t+Gq8NNScgdeLd7VgHwUdvimIBa0IYu2FzMTABlTp1pFrZc9
         F62G5WCd7x0A1PH5GQbx/6grSJ+nooB0BxEq5pCx0J2FY8vER7QsVlPqCEQXueqGfbEU
         GuwbXKOYL8t63BBDwKhjxUNrq5K+o2QxCmh0+lNjCncLhWxuqKBtr2Bkuz6gtuSFz0sp
         vJxA==
X-Gm-Message-State: AOJu0YxpqI45V/ZFmc05CZ18l8p8gTskRNtFTv1RPSZvI21w9qffO6J0
	BWsdWpftqjA8LyBV98uw0EbzYWgKhOE6KekZpYtpMRdNNkUB8YqD64L//JuSKwRu7Msl7an9B36
	Oist9S6Y=
X-Gm-Gg: AY/fxX5457XmByQeCtpDXG6ja6ApFep+1Og3AoI5N1GqdBYaxBTR8FjlO6MmleWGrJg
	rg2nfbONsmUgjYELoo839zXUsZpZdwqJCUKV6aK79d/Z5WlCsKUgtalvaNXWHhUXKmGGheKw6sW
	q4gfTmrkyO6BnPXy9elBzo/x8VHVnqVbBXL0NJSOy3gqpb+0CCB/V7lWo0mCz3lQTuRxMAgYJD+
	xZMUqDDni5OHz+RCXIGazPDJnT1MTMq4ynOr/C44n0pERtgxSF1Z7/Pqi0l3xfnMvmDuIVvb1pe
	RlT6mASFpCUb2cAGwcROlLTUFNC7z4/VodBB2T8nKRrs7YGFMyqH3+y7DnaziJHaR+7T3qIjy6+
	rVxKFFVt+cs5yZt9D60+bcG5BIGy7ZPBlSSHTQcI4v2hpOGYy5RkNnJhh2xfG5thDAQoJZpwQCM
	N+FhkqK/mDJd50GScH946710cA2dzXvDoAbZZhocGv3DJ4bjtDx1z9gJhborW0x1PHtdM3Bzwy5
	JETf+0TBJxsgbXO4lYqIAGfnPmvtA==
X-Google-Smtp-Source: AGHT+IEzcocirHveg0xTVvK7fchfoqZWGvbp9YU5Gq5lHlfTfrs6VrRHYIrvYkaSIqRqe8jEQZSu6Q==
X-Received: by 2002:a53:a104:0:b0:63f:9b00:70cf with SMTP id 956f58d0204a3-6466a8455famr4745334d50.16.1766278045423;
        Sat, 20 Dec 2025 16:47:25 -0800 (PST)
Received: from localhost.localdomain ([189.197.16.79])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6466a8b1948sm3374999d50.5.2025.12.20.16.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 16:47:25 -0800 (PST)
From: Anibal Limon <anibal@limonsoftware.com>
To: bitbake-devel@lists.openembedded.org
Cc: antonin.godard@bootlin.com,
	richard.purdie@linuxfoundation.org,
	Anibal Limon <anibal@limonsoftware.com>
Subject: [PATCH] bitbake-setup: fix are_layers_changed when use local source
Date: Sun, 21 Dec 2025 00:47:21 +0000
Message-ID: <20251221004721.35098-1-anibal@limonsoftware.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 21 Dec 2025 00:47:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18629

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
---
 bin/bitbake-setup | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index d19aee971..cb7da73d3 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -622,7 +622,7 @@ def are_layers_changed(layers, layerdir, d):
         r_data = layers[r_name]
         repodir = r_data.get("path", r_name)
 
-        git_remote = r_data.get('git-remote', repodir)
+        git_remote = r_data.get('git-remote', '')
         if git_remote:
             changed = changed | _is_git_remote_changed(git_remote, repodir)
 
-- 
2.47.3


