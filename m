Return-Path: <fawzi.khaber@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B21C64ED8
	for <webhook@archiver.kernel.org>; Mon, 27 Feb 2023 13:51:23 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web10.90516.1677505881947025799
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Feb 2023 05:51:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile-fr.20210112.gappssmtp.com header.s=20210112 header.b=A+kGfQDi;
 spf=pass (domain: smile.fr, ip: 209.85.221.44, mailfrom: fawzi.khaber@smile.fr)
Received: by mail-wr1-f44.google.com with SMTP id bv17so6301930wrb.5
        for <bitbake-devel@lists.openembedded.org>; Mon, 27 Feb 2023 05:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/0918a1DQgyOeWZBSQNtzuEK/5MPQVE8DO3uJsPDtfQ=;
        b=A+kGfQDit0Zu2gd8+4Ww4VQs0Rrikaz3aJ8YYfWJxvw8p5kNV0I3vLg2x0Z1M92c+V
         IAX0L7q0ujs8gdvb05+L2aUafOFY0AjfCjhQ/8yA+kJrAkEASXpTa+9yHeoMbaCMxejr
         MvbewCoHwRBEJvU1D/sKL++zGS/Ew5S0ofiv+kqflsKYvDbxVO+2zZWbBoZZSdpJYwY5
         K7j6/Yk6zzaBZBIy4lCSygDDLwiHUZvv2V6tR/UjRpYdoj7ar/4yDO+F3dYKD02K1K6R
         qBLbbx8zJU5bUDGlICgyii3Up3bBJooCRecq4nw3RKCX0xtEgXR06nNgPgREUwSGGlzL
         YUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/0918a1DQgyOeWZBSQNtzuEK/5MPQVE8DO3uJsPDtfQ=;
        b=0W2q5V8wpyyzDaKGCQF9lpLXWG2OU49GXwxjkRNNCXJ73rwZU/2d4l4q5WPZpAiNV2
         1ux1wRdnul7IHcymjWTk7zVUs9lEuljxUxPizxTxHdZvgwnKHMPNWXb6nHbi4As57zoV
         QejVK1v7uVxz5qsWMlKxX6Nv44MTnWNfgY0pdul7j3uFwX+27p3EiAIfwSKmwQW4oDvi
         txr7ACDdT+Y7CgpuqzdCN/Hk3gflQq1cQlDC81Vm/1gh5BcfjaczemPZjHvRg75t9tcq
         fV1Us/dnNOjjduHD00N4EOpOfAb8LcQVKK6YmDnQPzh5gkV+n46o6o+W3tgx2gnuQOs4
         pBpg==
X-Gm-Message-State: AO0yUKVlD6B6Aqmjs+/hIUswSdRgqj9YYO/usmYjs8y7IElWAUzcNPhc
	AANe2BLWmn0sfzuo2jRo4gOMeHShLC+D4Wi3
X-Google-Smtp-Source: AK7set87MwXagk3TpeYETniGrCc+eVjtUrsRJnkSQNGNNo3QVaGQMRMYFRtVUoIJxOScmFP+AcHxRw==
X-Received: by 2002:a5d:644b:0:b0:2c7:fcb:ed3a with SMTP id d11-20020a5d644b000000b002c70fcbed3amr12161448wrw.22.1677505880131;
        Mon, 27 Feb 2023 05:51:20 -0800 (PST)
Received: from P-ASN-SCRUM.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id l17-20020a5d6691000000b002c54e26bca5sm7201030wru.49.2023.02.27.05.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 05:51:19 -0800 (PST)
From: Fawzi KHABER <fawzi.khaber@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Fawzi KHABER <fawzi.khaber@smile.fr>,
	Ever ATILANO <ever.atilano@smile.fr>,
	Yoann CONGAL <yoann.congal@smile.fr>
Subject: [PATCH v2 1/2] doc: ref-variables: add LAYERSERIES_COMPAT to term glossary
Date: Mon, 27 Feb 2023 14:51:14 +0100
Message-Id: <20230227135115.29202-1-fawzi.khaber@smile.fr>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Feb 2023 13:51:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14498

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
index 09d09a8d..a48e7000 100644
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
+      "mickledore"). To specify multiple OE-Core versions for the layer, use
+      a space-separated list::
+
+         LAYERSERIES_COMPAT_layer_root_name = "kirkstone mickledore"
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


