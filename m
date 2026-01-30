Return-Path: <anibal@limonsoftware.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877CDD73EAF
	for <webhook@archiver.kernel.org>; Fri, 30 Jan 2026 01:56:36 +0000 (UTC)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1347.1769738188952333317
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 Jan 2026 17:56:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@limonsoftware-com.20230601.gappssmtp.com header.s=20230601 header.b=NgmvHgTA;
 spf=pass (domain: limonsoftware.com, ip: 209.85.167.174, mailfrom: anibal@limonsoftware.com)
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-45f053b7b90so1028695b6e.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 29 Jan 2026 17:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=limonsoftware-com.20230601.gappssmtp.com; s=20230601; t=1769738188; x=1770342988; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tkxCJ6mGj2qCZk8Ds906xR3MRBKNh4afQKTLg9S2x44=;
        b=NgmvHgTAJ4TInoVtp/rUXVgoeLBKGGMHd1E0Lyr0DzdJL+iwHjDVsv3xz826YQwDGe
         bloYHBsUCQHFH9BeN/N2aD3pK41YjGeUyLi7HizHrIwJtd+Fij08AUwsmFq4ymMNVvx5
         nzoYFpw085S3Z5Pws+uv7dHxHtgI/uu8s/CDwuWcX4qFpxr8SQcWdRQ33Fa3Pig8yHjK
         Bg/Yr02+y4C5z2OpHYTxhz45PxGQdiqNJiO98+4sfCMn3JWBUVc1KAgwQ48b4+0xGTFR
         He9uY3DDgAU+tTJM2VcICnIUUur+FSJQ36ytHmmrYDA46GaKjpTFgsGNCWK+CjCnIATq
         Xssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769738188; x=1770342988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkxCJ6mGj2qCZk8Ds906xR3MRBKNh4afQKTLg9S2x44=;
        b=SaE7/PqfI7dlJB+d7D4Bgw91vS1Fy9LndYSDM8HFx96DfrBEG+GGtM8aorWjA7sc05
         OrRVZZmaAqlOFThqAe25CO6dvpeBNsti6AR6sj3EVwQp4zUyMeT62nCC+dEGSTIhyxcr
         tSzi0o4u8e5CLQsGQR5JQt81QOEd/bPO7iS/2lfhrPZZeumKUPWeZv4qqhxi+0JKFuUF
         AcPoGt/Je91jAQBxIosurhdjbbob78trVwryVimr0stnsm0TlYoKgw2psjPRQ0FgbxPJ
         rvNhTpTmvVMdr12ZS6rmljJM2MuGflfTcmGwoocQOHTxQ3CYyTMcQMDbbhVq2jXS5mgX
         1M+A==
X-Gm-Message-State: AOJu0YxF/gljMhv5/guAEfbsu7MFNmNjptqDNjjOiBAUlXWn4dCBey4c
	Drh172PUlEkvaAa5I4bLJAP59tmQNkncutrlQwr9X82MhePmKkcLU/dxYsCvvdipW/UoeYpLyj9
	xYa+Wh+I=
X-Gm-Gg: AZuq6aKpCj5+ErNSagdoHzBcA9/e6+uoHmk/GKt69GmX1LR6B7ZLK+2F26Tmxkxl4Fo
	CpIjdWH4q/CMQeHPJv8JyyVtmowyYabTPNwAQqn1gMZTFW9hNIAPAJHhpmnPN7t4WZKrirFPh2L
	aW7VbiFMEsTXt7m9o0xPUPHieWz8b4BAgKdbFNUTSuO4KpJsNEzxkZeyh51QLnXbpMwnJPiCPPH
	xPcMorfQ+k5DSFtbZ1T9K0PvMnc8xF3TaT6PCu6NYBfJkVptn8sGyYxUQ1aXfLcdsLvMg7XMdy8
	MCfZB4b0H1L0Is1gP9qb8krz4YYwacLHw326bT/+vqgCnlRwX6P3j+Ok7Uhp/bH0AUfTNej1C0/
	8zt59f0GmN9MGK+jZBweHDB2UyNbfZRQrWpD194PLsWqyjbfrOX7m/6nFpRQTUAtfAOnbt9XvPP
	scAmyU/V6Ck+U4CGqUWERpmsjWXF1HdStb8qFoF0yI5VZ2y/pPjLBlSifgZvpgkESNhqdrp5Tl8
	gKPskOd
X-Received: by 2002:a05:6808:15a1:b0:45a:770c:d77b with SMTP id 5614622812f47-45f34cd613cmr1242229b6e.35.1769738187882;
        Thu, 29 Jan 2026 17:56:27 -0800 (PST)
Received: from blackbox.Home ([189.197.16.79])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45f08f60119sm3784500b6e.17.2026.01.29.17.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 17:56:27 -0800 (PST)
From: Anibal Limon <anibal@limonsoftware.com>
To: bitbake-devel@lists.openembedded.org
Cc: alex@linutronix.de,
	Anibal Limon <anibal@limonsoftware.com>
Subject: [PATCHv3] bitbake-setup: _has_local_modifications fix user case when add/remove/add layer
Date: Thu, 29 Jan 2026 19:56:24 -0600
Message-ID: <20260130015624.2228926-1-anibal@limonsoftware.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 30 Jan 2026 01:56:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18936

While develop a registry configuration adding a new layer and then back
to previous configuration without the _has_local_modifications breaks
because the code expects the layer to be in sources-fixed-revisions.json.

This can be reproduced with next steps:

- Call bitbake-setup with configX.
- Remove a LayerY from the configX.
- Call bitbake-setup with configX.
- Add the layerY again to configX.
- Call bitbake-setup with configX (break).

Fixes:

```
  File "/workspaces/ls/meta-ls/bitbake/bin/bitbake-setup", line 1137, in <module>
    main()
    ~~~~^^
  File "/workspaces/ls/meta-ls/bitbake/bin/bitbake-setup", line 1130, in main
    args.func(top_dir, all_settings, args, d)
    ~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/workspaces/ls/meta-ls/bitbake/bin/bitbake-setup", line 735, in build_update
    build_status(top_dir, settings, args, d, update=True)
    ~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/workspaces/ls/meta-ls/bitbake/bin/bitbake-setup", line 719, in build_status
    update_build(new_upstream_config, confdir, setupdir, layerdir, d,
    ~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                 update_bb_conf=args.update_bb_conf)
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/workspaces/ls/meta-ls/bitbake/bin/bitbake-setup", line 408, in update_build
    sources_fixed_revisions = checkout_layers(layer_config, confdir, layerdir, d)
  File "/workspaces/ls/meta-ls/bitbake/bin/bitbake-setup", line 184, in checkout_layers
    elif _has_local_modifications(r_name, repodir_path):
         ~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^
  File "/workspaces/ls/meta-ls/bitbake/bin/bitbake-setup", line 143, in _has_local_modifications
    rev = fixed_revisions['sources'][r_name]['git-remote']['rev']
          ~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^
KeyError: 'meta-freescale'
```

Signed-off-by: Anibal Limon <anibal@limonsoftware.com>
---
 bin/bitbake-setup | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 4d709ed8c..893cb68fe 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -140,6 +140,14 @@ def checkout_layers(layers, confdir, layerdir, d):
 
     def _has_local_modifications(r_name, r_path):
         fixed_revisions = json.load(open(os.path.join(confdir, "sources-fixed-revisions.json")))
+
+        if not r_name in fixed_revisions['sources']:
+            logger.warning("""Source {} is added with path {}.
+This path already exists, but it has no entry in a fixed revisions
+record. To ensure possible local modifications are not lost, it will
+be preserved in a backup directory.""".format(r_name, r_path))
+            return True
+
         rev = fixed_revisions['sources'][r_name]['git-remote']['rev']
         status = bb.process.run('git -C {} status --porcelain'.format(r_path))[0]
         if status:
-- 
2.51.0


