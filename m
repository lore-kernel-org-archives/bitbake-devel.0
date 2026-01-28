Return-Path: <anibal@limonsoftware.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845EAD3F071
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 14:33:43 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14648.1769610821889126122
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 28 Jan 2026 06:33:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@limonsoftware-com.20230601.gappssmtp.com header.s=20230601 header.b=DtZgXm6B;
 spf=pass (domain: limonsoftware.com, ip: 209.85.128.181, mailfrom: anibal@limonsoftware.com)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7942fca0da6so49699417b3.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 28 Jan 2026 06:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=limonsoftware-com.20230601.gappssmtp.com; s=20230601; t=1769610821; x=1770215621; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kh9V8fscpk9jHM72ic8ut+DVEuxYjcgyhkzlVYpUFvo=;
        b=DtZgXm6BK28C0sH/lWfy/wztSmRVNohz+9ZvJPddOYBxzX3h3UG08I5RQLfT8x3LtF
         2TaipenYVSgJLk2GaQPlUYS7x4zFo/i7sMGd6UcG0ajosKx8FiLF2HUyaVbXxpPsjWuy
         AC3gpGIaXXH9PqFrpIi4xg1lZKdbgOzFoKiP1kdGNQmUHROmifwUvqKmc+HAALtSU1eK
         HXwtQWtuMV3475JSqB6UIgCqf5HRQGzgG2ezw6Ooi9/AV4lVdH8FigF5QVwyKQnKV9zg
         Y0Z9YQviGcEoBUsesz7jkiAzd3uTY7CluTinipd+rGw9tuZrqRaTE29RnT5+FLV9rqlN
         VE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769610821; x=1770215621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kh9V8fscpk9jHM72ic8ut+DVEuxYjcgyhkzlVYpUFvo=;
        b=L7wnHx0w9xswaxL0wbWnqIGJMilVeaKA4iWU+Qf1PDm0FNohZemsCmeRrdFEPjr2xr
         eDIMlP6Q0Nl/a7QhPaQTo007nhPsYIE8MBsk0EdbtQpjupoBD7M8aGV2yfOSw3BFlMuj
         2Slu7nOLB1aYM2KQZjr4GqcBRMNEnCfDaad9KJnvxxqp4tuiGX7wCniJFmlzgLfu5wra
         E4+9GXC/Oz9E/QIzlIiWir8G5eQ1B8E41d6VgLauYgQR/6ZHvVqR2rXTHoNMuoC2KLOB
         U92DlQJX3Umht0IHBBNaafOTWGL4ODQLwXKG/tarHnivCV1FSlbI2S4rSCwgyYhhk2n8
         CcbQ==
X-Gm-Message-State: AOJu0YzHe+/ALcAZs1mbFrTiUt9AJxsOiL5Kpns05uBqo5v4KGl9xEIU
	i5MSnS14OqS8qC8ZeFf4RSnXmezlcT8dyjKjG1SuURggO0EjHkZSI7KnB5Ns4Uf0udq5sbNCyoo
	QYIR9aGQ=
X-Gm-Gg: AZuq6aKLpM+XBihCvMNnQYjjPIgMf7gvFoL13n4SN9ArHytUHUxTuCmLeSakfbgqchm
	n/aoaUK0+bLmifmeVSAXf+1I2L02xsHMkq+LIhsjOpnI5BuEtD3+3pn0KQHDoVLwHUXF+thDHdC
	ipqdjF65VWobH8xpprUYippbai+6ywcGsBsbgJZE9DLMDge/bxKFrJKoBk3l8OcAjhZaucG1b94
	Qdb39UC/H9mGo+eTXK703IVsR8Tf0ctV4yAYjo4Ivlv48JGtfRzNkeZihNHM6UQuK6CnhZTEggM
	F2yBFAddspmDkLDn0ud0HPN7NNC+qMrNe6zNu9jrNoNxlWU4pbQZdcK5y9om/gQrWLHYVMVHggk
	tPkdRq4OjDNDz7AApVnAS3RnyUUKMtcEA8H+u0nnRD1rCcseRN0rWDr/MjXnJNvXvoe0vB0eitO
	IHRmyTfOdwu0hDk2e8kpfcWfQG1tgv354e2wFaZ3AtAON5umA8z3BYCLGHK2YFYA/c7fR8Fb5Ha
	QSi1uRY/w==
X-Received: by 2002:a05:690c:6a0c:b0:794:8f0f:e8ae with SMTP id 00721157ae682-7948f0fe99bmr665337b3.64.1769610820918;
        Wed, 28 Jan 2026 06:33:40 -0800 (PST)
Received: from blackbox.Home ([189.172.116.66])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7948278ef12sm11227447b3.21.2026.01.28.06.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 06:33:40 -0800 (PST)
From: Anibal Limon <anibal@limonsoftware.com>
To: bitbake-devel@lists.openembedded.org
Cc: alex@linutronix.de,
	jonas@limonsoftware.com,
	Anibal Limon <anibal@limonsoftware.com>
Subject: [PATCH] bitbake-setup: _has_local_modifications fix layer add on existing project
Date: Wed, 28 Jan 2026 08:33:36 -0600
Message-ID: <20260128143336.1963432-1-anibal@limonsoftware.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 28 Jan 2026 14:33:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18917

When a layer is add to the registry and previous project checkout exists,
the sources-fixed-revisions.json not has a previous revision.

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
 bin/bitbake-setup | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 4d709ed8c..46b2bff01 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -140,6 +140,9 @@ def checkout_layers(layers, confdir, layerdir, d):
 
     def _has_local_modifications(r_name, r_path):
         fixed_revisions = json.load(open(os.path.join(confdir, "sources-fixed-revisions.json")))
+
+        if not r_name in fixed_revisions['sources']:
+            return False
         rev = fixed_revisions['sources'][r_name]['git-remote']['rev']
         status = bb.process.run('git -C {} status --porcelain'.format(r_path))[0]
         if status:
-- 
2.51.0


