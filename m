Return-Path: <osama.abdelkader@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F64BD59D8E
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 19:08:53 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1128.1765566531598446146
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Dec 2025 11:08:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=AIr8rxcM;
 spf=pass (domain: gmail.com, ip: 209.85.218.52, mailfrom: osama.abdelkader@gmail.com)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b79e7112398so299386066b.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 12 Dec 2025 11:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765566530; x=1766171330; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NsylsrwFUZoShH526iV6ncpDfhrJZAYWHjPtLHhFikA=;
        b=AIr8rxcM0ptx/kWAvofNSEHucj6cbkxBDh9LimPZg3aQYW4VP45F1Zrx14p6k7zVBk
         DAoqsl3UAJ+gLRUt0IS18HIcb/MRyhNOnzHmRTDsKbCYSMSqS/DkKzh0utDNvgcGEqbT
         Pe+lY9yZ5IRM1fcarI9KsCHWpihRpjS7p0tOj7uO+8bSeMLCvSgkVlF627mlm1KeIW9H
         WuH6X4vzyt2n4VhFVAnjdOusPZ8tl6Z2DfDAFjULHaR9wxfinThh0KQrq6SUe2M0PBEO
         0gX4eAHBefvv6LfJWjg+/I9TgJNUqTQrCfDJmQyR5WNALhjTBLeIG/llGG0WeHX2fO7H
         3ufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765566530; x=1766171330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NsylsrwFUZoShH526iV6ncpDfhrJZAYWHjPtLHhFikA=;
        b=TJl4yyoSVH+P4Zi3p3zQRQLJC04M9aMfpKNIskjQS202va7Rn3dj5hb4QHdVT2jUYA
         7rsDGn1I1EeaKTmmS4+Gvz2Ny7xJzpfKbvbDvwJycXzSMe5l32nUVMGbqZavvgLr0AtM
         ZjTGSuGLrvOYlucP1JFudR1+cPAnDIDvRk9zsosvt5WA7QBCD9q0Mi0TToscIKaMo1gx
         V9TAbItqi19OrdTwI0faHYI+rHRncWQf/mYsHzko6ybraFDE6B6sQhpL8byvWBysWN7L
         NFDiWigkFT0sUpi0qrFD1VnigkgJohWtR9KORo30Ry749DvJvUByGzMBQHLGp+6FhRU2
         pSjg==
X-Gm-Message-State: AOJu0YzU8gE1hijG8qagQyT+tj9ePx9vpZj8WoxOP9hAe5mVgXRmv4p7
	XRJy+988MuDM4wJk54gFrM8eSlGMwkDjKg+aatz3Vp/FEOpbdpzxuJ4p1WqGlg==
X-Gm-Gg: AY/fxX6gio4aqNSIWf+WIrLBGWwtuqtBaHWc8QH0BfYFU7GgF5sitoIG5IZFOJH+xLv
	5+Nlz8tCW/8LDHavRqGhVHesUIbX9GkfmR74GtdBPvoVnxAF1Ey/mHIXDyDR/DpWYraOijr/Ke6
	Yh2huDnYQqwNvdAKMQwQM9ZQKT0bGdmZ8PeqmGYjjVNI4cR6ynTRYjzXUih5vBEFTxnK1tnO7Mv
	3P37RIA78Md8FfR6Pq/Znkcl/m1zrH48zxOkiSkCj1Oe8cb9zepmMDsOK/mCVrf5NPUZapWX3jA
	x0x44dLS5lgq9IaH8jsAbAYBIPB38JVO2bpo30ADq45QNqDTperzv83HD1fkXdRA4kBg96Q+v9a
	Y/NqycmTaKEgQ7EpCr9xKL4okuVtrpBP4zE/3f3yWBgxeQF97uLwsoScrdEC+df0S5B/d/GPurD
	55YFT3jnERPDi9qhU=
X-Google-Smtp-Source: AGHT+IFQRe4pzciEtNymzbxoSXKvkkJ54ZAqAyAQHVssUQ7EbLI2DUThlquB/zwm34Ind+dxZEPLNA==
X-Received: by 2002:a17:907:cd07:b0:b76:3c91:68d with SMTP id a640c23a62f3a-b7d238b9589mr241367466b.33.1765566529908;
        Fri, 12 Dec 2025 11:08:49 -0800 (PST)
Received: from osama.. ([2a02:908:1b4:dac0:1401:37b6:6a29:b0c5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6498210de23sm6147003a12.28.2025.12.12.11.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 11:08:49 -0800 (PST)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: paul@pbarker.dev,
	Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH 3/4] bitbake-layers: layerindex-fetch: Respect --branch for already-configured layers
Date: Fri, 12 Dec 2025 20:08:05 +0100
Message-ID: <20251212190806.32476-4-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251212190806.32476-1-osama.abdelkader@gmail.com>
References: <20251212190806.32476-1-osama.abdelkader@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Dec 2025 19:08:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18582

When --branch is specified, prevent the early exit that skips branch
verification. This ensures that even if a layer is already in bblayers.conf,
the command will still check and switch to the requested branch if needed.

This fixes the issue where the command would exit early with "You already
have the requested layer(s)" without verifying the branch.

[YOCTO #7852]

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 lib/bblayers/layerindex.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bblayers/layerindex.py b/lib/bblayers/layerindex.py
index 1c6511889d..e0df630a7f 100644
--- a/lib/bblayers/layerindex.py
+++ b/lib/bblayers/layerindex.py
@@ -120,7 +120,8 @@ class LayerIndexPlugin(ActionPlugin):
 
         # Fast path, check if we already have what has been requested!
         (dependencies, invalidnames) = cookerIndex.find_dependencies(names=args.layername, ignores=ignore_layers)
-        if not args.show_only and not invalidnames:
+        if not args.show_only and not invalidnames and not args.branch:
+            # Only skip if no specific branch was requested
             logger.plain("You already have the requested layer(s): %s" % args.layername)
             return 0
 
-- 
2.43.0


