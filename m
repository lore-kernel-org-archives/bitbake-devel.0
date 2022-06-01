Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43311CCA473
	for <webhook@archiver.kernel.org>; Wed,  1 Jun 2022 18:22:45 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web11.1547.1654107763505817775
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Jun 2022 11:22:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Fjp1Od9Y;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id
 m32-20020a05600c3b2000b0039756bb41f2so1546825wms.3
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Jun 2022 11:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2bPcbiP1IwQ4QoflwSKWRQTFz2EYFkKmVq6xeV0tKTY=;
        b=Fjp1Od9YvGesPRSpNmqtqYxXA23H5by2mVAbY+gBgKMPppuHJlwsfXCk6Vs18LlCFA
         8ucgQnvzS+6uhLmwbVLsl9xCKo1TzJ6h+SfjjA2tLRNWySi5ASuAgs7q0sYuj/Sr6SkU
         BH1wUaW+AGDk+eeCxADPyFOrRcHymjEcilwF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2bPcbiP1IwQ4QoflwSKWRQTFz2EYFkKmVq6xeV0tKTY=;
        b=GyVBlH2glh6Fw8Tmns1OqSEA3Y80ltQDHlYNDriHVguIQJIMP4K2owfmFgdDUbueO6
         hnvyHjcgkq0TcbkQTHplOHbYqnwolSW/uSEdkr4006UjPZuzqhWx9INuWVcrQ/AgDTMD
         ESv9vvCq9x26nQpyg8VZJDPnjOCiF5x+qvt80Lj1mVHtp7xUjbiT1R5RqE8aOPDX6bzx
         pag3oXz1oBZvZz82i5z+jey8/48ywwg52DZE7eAVQQMfUVU24yFvftL2iEQTieHYOfhY
         De3L7RAiMnxcutITj6PlkYIC1CmelOul5+w7OHZroZHmSe6oSocyVCzKeKaGgvwuFJ3k
         pDnQ==
X-Gm-Message-State: AOAM531cQyZ6wKYLJ5JAfHEQJG/tzNOpU3Ef/NsfQKmkAWohJchoZZDx
	IaQy/hXhTM2vKC81rAgf4kQJE6G2kiCYKZUD
X-Google-Smtp-Source: 
 ABdhPJw2cdRDuH+knyVURkiEY5U0OGxUktvRIy3t152j+Wo6SZz5ONLU6moPxYmsMgNkvg0WWaZ/bw==
X-Received: by 2002:a7b:c841:0:b0:394:890e:9195 with SMTP id
 c1-20020a7bc841000000b00394890e9195mr29841407wml.59.1654107761838;
        Wed, 01 Jun 2022 11:22:41 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:eab:cafb:b8d4:fe67])
        by smtp.gmail.com with ESMTPSA id
 l14-20020a05600c2cce00b0039751bb8c62sm6665150wmc.24.2022.06.01.11.22.41
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 11:22:41 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/3] bitbake: Bump to version 2.0.1
Date: Wed,  1 Jun 2022 19:22:39 +0100
Message-Id: <20220601182239.103588-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220601182239.103588-1-richard.purdie@linuxfoundation.org>
References: <20220601182239.103588-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Jun 2022 18:22:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13727

This allows OE to depend on the unihash copy functionality.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake        | 2 +-
 lib/bb/__init__.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index 042c91807d..b56f6207c6 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -28,7 +28,7 @@ from bb.main import bitbake_main, BitBakeConfigParameters, BBMainException
 if sys.getfilesystemencoding() != "utf-8":
     sys.exit("Please use a locale setting which supports UTF-8 (such as LANG=en_US.UTF-8).\nPython can't change the filesystem locale after loading so we need a UTF-8 when Python starts or things won't work.")
 
-__version__ = "2.0.0"
+__version__ = "2.0.1"
 
 if __name__ == "__main__":
     if __version__ != bb.__version__:
diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index b8333bdb81..6b470aa195 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -9,7 +9,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-__version__ = "2.0.0"
+__version__ = "2.0.1"
 
 import sys
 if sys.version_info < (3, 6, 0):
-- 
2.34.1


