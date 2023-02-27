Return-Path: <fawzi.khaber@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563D4C7EE2D
	for <webhook@archiver.kernel.org>; Mon, 27 Feb 2023 11:25:02 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web10.87846.1677497092229872139
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Feb 2023 03:24:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile-fr.20210112.gappssmtp.com header.s=20210112 header.b=TiZn3C4q;
 spf=pass (domain: smile.fr, ip: 209.85.128.43, mailfrom: fawzi.khaber@smile.fr)
Received: by mail-wm1-f43.google.com with SMTP id j19-20020a05600c191300b003eb3e1eb0caso2225079wmq.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 27 Feb 2023 03:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eC3ckaF/JKvWSvdPugcy/Fcd1VwGhwtx2Yff8lHbmtg=;
        b=TiZn3C4q/QYLIcxW9ajLF/SJVigZuMYJHm0RezBNC79XyVq3XUCCBTuNmwupmnNlWz
         X6q32UYGYiHjMIkiAeba5lBePXNG5+16/SmsQOg8WH69ikOtN1WY8VmD1zvGkvFPpqj6
         Bauy/GWlG06UiFZSs3B5tCIjCWW3uurrhBLwpmiu8I45muB9/gYk3rJfvdWtGaRFOyzq
         AOrYzoyw5rcc/DQyBaA3vxLCUvXF4yr5nWO3pGedcL2NXF1e1GuWR+oKOtGZjpV/+XAn
         v+nxD6Qg0gTfpD7BAMvjHyy/OR/hLM40zw68JkzeOuJszs8dQhK6BPOX+Dbn8FlSBZW1
         fKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eC3ckaF/JKvWSvdPugcy/Fcd1VwGhwtx2Yff8lHbmtg=;
        b=tzZRcXYQBQjda1A9XkQlBIoHJXMEfxC7HzaHtY8HtPwKgPlPmfEMZdKSID3qVu2msh
         JdA/YaobcVkVYOBkoTaSzf1HqVy+ZfHz532tSFNP4bt+krPCBRqu43jpFJk48ycWVeSF
         tSw0a73Ama5HTsdPHWjn+BRsPsT12hsHtWAQvZdrvpNAXSoiIAUmTju2OIx27YQlrGsm
         bgUTx+OZfYwUZF0axUVmMi2PSIAOVFbvE6m/Zu3Lu8ZstxCcgOJehxsz0ovBmDWlGeeO
         C4x6llGVnTauTUrIDzfvFpFh4ibTT6wwRptL7zIrCCYKAaXBYo/fTg68Z55+8DpkVwgt
         SiRw==
X-Gm-Message-State: AO0yUKW9WiImrW8upE/jUcINEQRzklzRRL16ldUB8hUWwfp0zHwbUSnb
	CeKxNUFaYtjY+GywaN2TyolU4i1NwYuxTgnC
X-Google-Smtp-Source: AK7set9bRXhnmRzIfb4cgekfp/LBwLHEfxI93XkPyOcV01dQphfyH2nEn9EGK9PXlnqv/XJQsQBFkw==
X-Received: by 2002:a05:600c:3d9b:b0:3ea:f6c4:5f2a with SMTP id bi27-20020a05600c3d9b00b003eaf6c45f2amr11345749wmb.17.1677497090471;
        Mon, 27 Feb 2023 03:24:50 -0800 (PST)
Received: from P-ASN-SCRUM.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id n41-20020a05600c3ba900b003e20fa01a86sm9283106wms.13.2023.02.27.03.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 03:24:50 -0800 (PST)
From: Fawzi KHABER <fawzi.khaber@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Fawzi KHABER <fawzi.khaber@smile.fr>,
	Ever ATILANO <ever.atilano@smile.fr>,
	Yoann CONGAL <yoann.congal@smile.fr>
Subject: [PATCH 1/2] doc: ref-variables: add LAYERSERIES_COMPAT to term glossary
Date: Mon, 27 Feb 2023 12:24:46 +0100
Message-Id: <20230227112447.26871-1-fawzi.khaber@smile.fr>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Feb 2023 11:25:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14495

Bitbake throws a warning if the layer compatibility is not defined since
cca81e33b58c390dcf5cc3a31555a43b79177166. This variable did not figure in
the documentation.

Reviewed-by: Ever ATILANO <ever.atilano@smile.fr>
Reviewed-by: Yoann CONGAL <yoann.congal@smile.fr>
Signed-off-by: Fawzi KHABER <fawzi.khaber@smile.fr>
---
 .../bitbake-user-manual-ref-variables.rst     | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 09d09a8d..3611ee78 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -1096,6 +1096,29 @@ overview of their function and contents.
       variable is not available outside of ``layer.conf`` and references
       are expanded immediately when parsing of the file completes.
 
+   :term:`LAYERSERIES_COMPAT`
+      Lists the versions of the OpenEmbedded-Core (OE-Core) for which
+      a layer is compatible. Using the :term:`LAYERSERIES_COMPAT` variable
+      allows the layer maintainer to indicate which combinations of the
+      layer and OE-Core can be expected to work. The variable gives the
+      system a way to detect when a layer has not been tested with new
+      releases of OE-Core (e.g. the layer is not maintained).
+
+      To specify the OE-Core versions for which a layer is compatible, use
+      this variable in your layer's ``conf/layer.conf`` configuration file.
+      For the list, use the Yocto Project release name (e.g. "kirkstone",
+      "micklemore"). To specify multiple OE-Core versions for the layer, use
+      a space-separated list::
+
+         LAYERSERIES_COMPAT_layer_root_name = "kirkstone micklemore"
+
+      .. note::
+
+         Setting :term:`LAYERSERIES_COMPAT` is required by the Yocto Project
+         Compatible version 2 standard.
+         The OpenEmbedded build system produces a warning if the variable
+         is not set for any given layer.
+
    :term:`LAYERVERSION`
       Optionally specifies the version of a layer as a single number. You
       can use this variable within
-- 
2.39.2


