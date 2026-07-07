Return-Path: <fabien.lehoussel@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421BAC43458
	for <webhook@archiver.kernel.org>; Tue,  7 Jul 2026 16:34:48 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1973.1783442079654467646
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Jul 2026 09:34:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=WyhY12Kb;
 spf=pass (domain: smile.fr, ip: 209.85.128.51, mailfrom: fabien.lehoussel@smile.fr)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493e497643fso2092525e9.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 07 Jul 2026 09:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1783442078; x=1784046878; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YUoYI+EiqRFE3qMj5RDAx/5GG02G56NDdEHOfEJwVmI=;
        b=WyhY12KbDBNyxfLEjhwKHMGhrbkcR9ecwgATR/Rl5MmAQIq0QfwT9+ncTnv7iH38L5
         aLNMRYBsX2MZy2gvrIVSh7+pUrMKZef9/jPCy8B4VueKTIdJFKPEwROvi2JIrLB5AFs3
         sWTrE1eohjKrFewzwrR4ouo+EL65USrf177rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783442078; x=1784046878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YUoYI+EiqRFE3qMj5RDAx/5GG02G56NDdEHOfEJwVmI=;
        b=Q6zfZ/2OMzAVQZJBUMtI50mjfhJSd9IRc/9U2XL1GTx5eW55HrGNCN+glffIwtZkEf
         aFJibNclSP3+V5gSV1H8po//nBMcZWJ3O2roZN0vA1MuvzHwQ4yTRvxDROoFfAXyFcGZ
         pZ8vR71ftTVqwAPfiWFmV1gXBc/HpUiJX1Xtt17HZUreP/SlqgrtO4t4xVSDtXILsQNc
         QpyB2/6O9Q+jtwFRUfrzPMP+aMUqJmG+xS/USzPRspEbnsQJCo4K0LpcSsFdUm3EVX4g
         KBX6Bg1UCH1VtZYRNu7xCCqivKqN9IvuRnSDVS6LT+mQdABvUpmhorY4yAl5jDlouT9J
         ufkA==
X-Gm-Message-State: AOJu0YxqJLsmtzOT6XzbmTIEuuxHdcptUx+6uhNkSF8juYj7laMenxdu
	VP7Fmb9HYPZXQ1rIGkpNbjylgJLZXoCH3qkgtOUXxLlX9llWlqOP7gqtP+JJt50n5yA/0Ak6KWs
	yRukxh7s=
X-Gm-Gg: AfdE7cm8FfFEZ6hS2nNynx6G+gX61qouFgqbUPNBfFjUUpdZJOk652y/bZdIaxzkS2t
	IFJMZEBwQvy2mPXzxA3iVFJFGruH4WwtH2UkMz3XIHPmeSNK299i5hAq6um3nT0T9W4t/oNcBa1
	iXmD8lcGU1ssTS01mZBszN2iHG4XNiN+WtKWgtkHaZ48cxKZ0//QNKyAoMrFczZCeXYiVH6a63Y
	IWNI5TJe0mgpuDmXdQifSehjpsT8pAlaUbSrCK33ywThrjaxJJ1kK5wiEYDchA9VWRzUNoLaE0b
	Bv1R0iHfqq9GdMY470bTGCTcUu8dMFpYqtrkPU5jW0yW7xT+D+BOqnuT9dUj4zDvE7WRB4+oqG4
	2kxwAeH3F56w0Pa9eFGfy8YibQso3i0nbaJffLvMsYC/l1djgwAVxfznyDwraIbodvy5fan1c5b
	7Be9hqFeKqhsFYg6iOyRHFcWZ8RJCc0KpH9Z91KdMc5GujCqnZ0MNwSPE6tPd+yKB3ZtCJJBLX/
	UbNbw7ZfCBWF5CEq8rlBBoWayNn/4g=
X-Received: by 2002:a05:600c:e557:20b0:493:bb29:af40 with SMTP id 5b1f17b1804b1-493df05fbf4mr50889055e9.14.1783442077793;
        Tue, 07 Jul 2026 09:34:37 -0700 (PDT)
Received: from FRSMI25-GRAVITY.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d8cdsm37965890f8f.1.2026.07.07.09.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 09:34:37 -0700 (PDT)
From: Fabien Lehoussel <fabien.lehoussel@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Fabien Lehoussel <fabien.lehoussel@smile.fr>
Subject: [PATCH] bitbake-setup: handle dict entries in oe-fragments
Date: Tue,  7 Jul 2026 18:34:24 +0200
Message-ID: <20260707163424.678708-1-fabien.lehoussel@smile.fr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Jul 2026 16:34:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19819

The setup-schema allows oe-fragments entries to be either plain
strings or dicts with 'name'/'description' keys, and choose_fragments()
already accepts both forms for oe-fragments-one-of options. But
setup_bitbake_build() joins the oe-fragments list as-is, so only the
plain string form works:

  "oe-fragments": [
      "distro/poky",
      "core/yocto/sbom-cve-check"
  ]

while a configuration using the dict form, e.g.:

  "oe-fragments": [
      { "name": "distro/poky", "description": "Yocto reference distro" },
      { "name": "core/yocto/sbom-cve-check", "description": "Enable SBOM CVE checking" }
  ]

crashes the setup with:

  TypeError: sequence item 0: expected str instance, dict found

Normalize the entries to fragment names before enabling them.

AI-Generated: Uses Claude Sonnet

Signed-off-by: Fabien Lehoussel <fabien.lehoussel@smile.fr>
---
 bin/bitbake-setup | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index b81d3ad11..4f1cf7ad3 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -387,6 +387,8 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_c
     workspace_file = os.path.join(setupdir, "bitbake.code-workspace")
     shell = "bash"
     fragments = bitbake_config.get("oe-fragments", []) + sorted(bitbake_config.get("oe-fragment-choices",{}).values())
+    # oe-fragments entries can be strings or dicts with 'name'/'description' keys
+    fragments = [f["name"] if isinstance(f, dict) else f for f in fragments]
     if fragments:
         bb.process.run("{} -c '. {} && bitbake-config-build enable-fragment {}'".format(shell, init_script, " ".join(fragments)))
 
-- 
2.43.0


