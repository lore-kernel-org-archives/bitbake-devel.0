Return-Path: <anibal@limonsoftware.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF30D46BF6
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 19:32:04 +0000 (UTC)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3258.1769628722783642731
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 28 Jan 2026 11:32:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@limonsoftware-com.20230601.gappssmtp.com header.s=20230601 header.b=3Z8Usffm;
 spf=pass (domain: limonsoftware.com, ip: 209.85.210.46, mailfrom: anibal@limonsoftware.com)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7d1916d1e24so112695a34.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 28 Jan 2026 11:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=limonsoftware-com.20230601.gappssmtp.com; s=20230601; t=1769628722; x=1770233522; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V8I5ihvOLy4xm/XQW8LX+ajLL1GGOJA1fNgPWKvZ2a4=;
        b=3Z8Usffmg4CnM9tsszDeKxSfu1xtmrpMSXWKreSOgfp3wPPbsT3y5qrUUU8x/Kq2RP
         whvopGeAqvFc2sff0QB/Yfu3jKdk+dAq6zUJxwiCcaB3q2p/wOQcQBchyR3uLWJTgiGu
         KM4EExCjhnCf+CkQoJYCK7JRnwMkO74RfJJWHvQMZHRLYsiwit5Sn7DGF+S0Rxppea+X
         UeImTxGzN+857ROTwhAObMGA8+kymHFlkTNSIRalxnKzH3xCsupn24xdVT23z0gwoL4T
         Bqy4hyg3WX/WIEpYPJ9jJ9dSjvb/7gu1pbBuq+YydGa4q2HQAlSeVTrAM3WJh17gvsqF
         gNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769628722; x=1770233522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8I5ihvOLy4xm/XQW8LX+ajLL1GGOJA1fNgPWKvZ2a4=;
        b=mOfb38RbpsjdBqIakC+DJFaJN2EfoDv6UvPjiWbP/Gjip6tHT/zN5M2+EA0vkRjhfE
         4eOuBRkCUbZl7bmWU5HqMgLjjXd9LITuFmaLGxpZa2dJq+S3Wk4ZrVhJDILUF8JKAVyf
         1jNyNPeyG2CXti9IlDE3GQByKOOwQk4LLBl/2tjtLFTlsYOvNxgHJF9EbCp6966rN5su
         DjtADPXyQ/hBHid4WvcImlEYfxMBCIAd5oiOCSAsUXGVYjCZAKwbEmIg6whOW51lX/pN
         tQH3DL08gLAxUbq7YEgoKDGK0XZjJzg1nVwgVSDjgq7yM2XedF6Anzen+yFLRIIy5AEs
         BCsg==
X-Gm-Message-State: AOJu0Yz7GoJU4EkS3Gvd8npkSrAjsEaOJ9aYYTQRiIojnlwIVKsTi3R/
	GxKRJS1pNciWYII2d0qYCq0JpsR0oZzYZqY8R7iqfBYwmkkgWOc5vrrSpMz6IE1molhTIhNj3Da
	+x4oq4uw=
X-Gm-Gg: AZuq6aJu1dt0Nw8bhntuvjal4oRHyjULNcgDNlZ1RuL+BKnUL74/1sOgeHImQbm9Kns
	ereAKuUVi6z86uCU7dVVKoG6YaukSMXfDeLzsxiNA2ybV1fAfO1767ZXBSI2h/hS6pMlBvMLYRM
	4vO7AoswO8pqCIJobMgOcw3x6wIuBu6WkhFIHdKmVi1UKq9BPv/EtZglCKjqyGALhNSRJyg7jMJ
	ocqQBR2qnjsYd47vJiKTNgCn0VSjGnnhxSWWPEz9QtKyr1InmkVNdTaTov407tq0Lf1j4JNRVt9
	ks3NAyPPZGQkm8U6ojCL/Lozmw18LH09nodnxDtjn+SOUEIXxDl03zjo19X5c/RD/oR/ddJ4i42
	jzXqxVDVLEgaW0vMyrjQ/8fojfr3Nuj8sI3hcWWVENMYqV+c4TZkohEia8oTUXwyOUkBUPHEYUK
	GQcNE+c1QWde84UeOJuxFqD3BZ1lgghLrFfk5RsPGv6efp2fwIi3u3F61p2IVZxVZvTy7KY52zs
	lCloybbkg==
X-Received: by 2002:a05:6830:411f:b0:7c7:6479:38ce with SMTP id 46e09a7af769-7d1850ce292mr4303505a34.18.1769628721855;
        Wed, 28 Jan 2026 11:32:01 -0800 (PST)
Received: from blackbox.Home ([189.172.116.66])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d18c6b9c8dsm2482811a34.13.2026.01.28.11.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 11:32:01 -0800 (PST)
From: Anibal Limon <anibal@limonsoftware.com>
To: bitbake-devel@lists.openembedded.org
Cc: alex@linutronix.de,
	Anibal Limon <anibal@limonsoftware.com>
Subject: [PATCHv2] bitbake-setup: _has_local_modifications fix user case when add/remove/add layer
Date: Wed, 28 Jan 2026 13:31:56 -0600
Message-ID: <20260128193156.2019850-1-anibal@limonsoftware.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 28 Jan 2026 19:32:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18926

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
 bin/bitbake-setup | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 4d709ed8c..5e0f15555 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -140,6 +140,12 @@ def checkout_layers(layers, confdir, layerdir, d):
 
     def _has_local_modifications(r_name, r_path):
         fixed_revisions = json.load(open(os.path.join(confdir, "sources-fixed-revisions.json")))
+
+        if not r_name in fixed_revisions['sources']:
+            logger.warning("""Source {} in {} doesn't have an entry in sources-fixed-revisions.json,
+ Source {} was previously remove from configuration.""".format(r_name, r_path, r_name))
+            return True
+
         rev = fixed_revisions['sources'][r_name]['git-remote']['rev']
         status = bb.process.run('git -C {} status --porcelain'.format(r_path))[0]
         if status:
-- 
2.51.0


