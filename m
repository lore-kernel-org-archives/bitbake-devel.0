Return-Path: <fabien.lehoussel@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B263BC44501
	for <webhook@archiver.kernel.org>; Thu,  9 Jul 2026 07:28:03 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3827.1783582079620157457
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Jul 2026 00:27:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=r+Zp/5E6;
 spf=pass (domain: smile.fr, ip: 209.85.128.41, mailfrom: fabien.lehoussel@smile.fr)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493bc8fda98so10940305e9.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 09 Jul 2026 00:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1783582078; x=1784186878; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lquSrZ1o5BEgc+c5839x7HjCp+p1vC9mZ7/WbQkBRjw=;
        b=r+Zp/5E65z2kcFqfyIKh/dGERDbE0Wl0j0uVm1YW2UzOutO8vvQVtCa4FwNYXmE7VF
         w2oYZMm+aKRjBWxyPeapmfc3DnRr3oiOQk/4i23fpE3J7p7ZILWPbQfdCW+dqvrGL2bX
         R1zF+g9NamhnlXEExHhMCaVPz0EmFOT2+fjNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783582078; x=1784186878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lquSrZ1o5BEgc+c5839x7HjCp+p1vC9mZ7/WbQkBRjw=;
        b=l7o4gC5oPh72CysszxwnUZzP+6p323bR/jSlRWHh2TZzKQntv0/BBXuoekTmpT5GHb
         xctQhqTY1ooIr0WtBuCjxVgPI3wdhOcg4z8NjXEx2gU3ZPmaZzdk83pERXDzhwe/+0dI
         VMdJCK9jBRBfqVwipFF2fMw7PZWTPFCxGd9Mbnoi946hWDwJWjiF5kJT2/09hwavIWxM
         t7PiU6KC/RMCF57XSPJYPWvy38mLV1pOgwhJFgN3vGqYY8rwgmFx2rm5JY8XqwKXgY3h
         sTQ4I08tqh6kRgGOqK6Fnu4JkqCwvDSD6K5hDutDguLpDERnDyV2Vdk/tVPiHitRlKs5
         7f3A==
X-Gm-Message-State: AOJu0Ywp6D1zrT1aTvMXukv06lJ0SxBcVK+w68+xUJ2aGur54N98111p
	iLLPF86ULWiC1BmouOg6bKoLoEIm43MYq8ABh2KCkEnTf3Q3iVZ8rXnHsKdk9xt41SURlpl9uc5
	UUP0dnfI=
X-Gm-Gg: AfdE7cnDlRowhYd5B0VVPFyvCgdY/sVMFOsUtox7xp/nj3uxFH9mh7AP+IC0fmPLnV0
	exDaonKOeir5QjV0MqNanHoNDGYtIjNkFYYKyK7915iPHGCZaLRTonTyBJhjikkrmQLOPcXmeU1
	uiefwRLBC3u2tQuNhZS3i2LYLXTAAqdstR5HRmGb403A5JlfOnenGefAQ1HDlD5GHVfCVFDgL2l
	bTWhBz0uknhaoaVGyVQ0gFW4JoTryOA7SIZMbPoPH/XOi6OF6/M3k3CX7frsjO7l4Tda4jMMh04
	kFYFB9Cty0TTdgVcfmpoOKUo9+kE/wpuBVTE43lNvEqQDjkZXA+kVJ+7guNfJ4o2uwIJTU6ItG+
	KQhUM/AwmAOS/EWWNwqKZSZ7f4+Z7I7cwQE0ZZgQKELEbdHhCyRmZ9K0zU9tFIpm3Ko89t2bNxx
	GYB4EQTBR4LRN82B5h/SpifMLvsbIjTi1kwg+14sZ9I9duCgizfT63MZsvg68WTLPSdO0xSs63r
	hjxgOjsz4QdfusEddWjAUwBPJxjyUw=
X-Received: by 2002:a05:600c:628b:b0:493:e947:b24a with SMTP id 5b1f17b1804b1-493e947b27fmr30218735e9.14.1783582077773;
        Thu, 09 Jul 2026 00:27:57 -0700 (PDT)
Received: from FRSMI25-GRAVITY.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e5a61135sm76747475e9.1.2026.07.09.00.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 00:27:57 -0700 (PDT)
From: Fabien Lehoussel <fabien.lehoussel@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Fabien Lehoussel <fabien.lehoussel@smile.fr>
Subject: [PATCH v2] bitbake-setup: handle dict entries in oe-fragments
Date: Thu,  9 Jul 2026 09:27:40 +0200
Message-ID: <20260709072740.2773081-1-fabien.lehoussel@smile.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707163424.678708-1-fabien.lehoussel@smile.fr>
References: <20260707163424.678708-1-fabien.lehoussel@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Jul 2026 07:28:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19834

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

v2: normalize oe-fragments entries before concatenating with
oe-fragment-choices, rather than over the combined list, per review
feedback.

AI-Generated: Uses Claude Sonnet

Signed-off-by: Fabien Lehoussel <fabien.lehoussel@smile.fr>
---
 bin/bitbake-setup | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index b81d3ad11..e21df6277 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -386,7 +386,9 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_c
     init_script = os.path.join(bitbake_builddir, "init-build-env")
     workspace_file = os.path.join(setupdir, "bitbake.code-workspace")
     shell = "bash"
-    fragments = bitbake_config.get("oe-fragments", []) + sorted(bitbake_config.get("oe-fragment-choices",{}).values())
+    # oe-fragments entries can be strings or dicts with 'name'/'description' keys
+    oe_fragments = [f["name"] if isinstance(f, dict) else f for f in bitbake_config.get("oe-fragments", [])]
+    fragments = oe_fragments + sorted(bitbake_config.get("oe-fragment-choices",{}).values())
     if fragments:
         bb.process.run("{} -c '. {} && bitbake-config-build enable-fragment {}'".format(shell, init_script, " ".join(fragments)))
 
-- 
2.43.0


