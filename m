Return-Path: <pedro.miguel.baptista@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACBDC636D6
	for <webhook@archiver.kernel.org>; Wed, 15 Feb 2023 22:51:23 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web11.7736.1676501481834536174
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Feb 2023 14:51:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=lnRaeN1u;
 spf=pass (domain: gmail.com, ip: 209.85.221.54, mailfrom: pedro.miguel.baptista@gmail.com)
Received: by mail-wr1-f54.google.com with SMTP id by3so177505wrb.10
        for <bitbake-devel@lists.openembedded.org>; Wed, 15 Feb 2023 14:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WE1IYakMsPj97qLfrO4ubUi4OvvrGt925zIZilyP3u0=;
        b=lnRaeN1ug5K+wDizLA4Ds9b4UcpDGdAA1JRHwC6UZmTMZf7i+kaw/P9nUxXZUot6Fc
         kZ/9peTi0TUJoUCbJqkwvVwf2/IqSTO8kofOgH5cuvDCi+z7pZGuGveUx9v+ymYfktqg
         ySVCruTCOGK+np1uY5uhVLmle2DzXAuuBXmTk6NfoSJnl0IuwjylgV0MhVqkBYdvUQcJ
         XBbu4zNGu4pDJjmG5ErWhsoCWq7npWGrsstp01XmDWqvFnmEZjzLF/R6N+RoYrO0G87t
         YBRtZvPOJ/y7OBE7S7TQE+YJGj2B96Om9JLNIblkDGSACpZqN27R0p85dsaJi1F0tPJ2
         fDgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WE1IYakMsPj97qLfrO4ubUi4OvvrGt925zIZilyP3u0=;
        b=4S6VmRy1U6LuNZ9rP0WKhxPPFrz4eHws/fDTT3GYx6CKETRWqIma2QZRsW4xd45PsL
         IJMXFqFdZUsOEE1pjXk00+eqsy4zPBoLEGPjVX7gWaac8R/rkcUtSvBTiqGrHzt3H090
         E7GQTP6s0xmY47HmH9Ozl3PyBkCjD4pj8AGyxYK+MMRVAleTmY8s4UGPy53/TWAa2FOA
         bnSbfOR7HS7oITqMWVgfG6ifl6L16kxjqCPccBtpq48t/V/1HJQSjSYCFAW/Mtm3Sg50
         E53XUjEr9DoCLNx7HHSTHIIp+JIUNMGT+TiIqvJOw7abqCqXXZsucb9SbHD9ZIx1Ip7F
         72yw==
X-Gm-Message-State: AO0yUKWyLWBlQ5ODchz/p/MdvD46yJ2X91Xsxi6O1Ugu17DerSQbeUPb
	uFfN/a1UWztVAebgNAehFU5+Mv+fP2o=
X-Google-Smtp-Source: AK7set+xgiY3Vv+4sTAeLFxmmdLy4bDluCZ94Aez2HYtw87hRX8rVFokbnWmdBHT5pCZYZgLSXwfMg==
X-Received: by 2002:adf:f10a:0:b0:2c5:60e6:ebe with SMTP id r10-20020adff10a000000b002c560e60ebemr3151552wro.66.1676501480126;
        Wed, 15 Feb 2023 14:51:20 -0800 (PST)
Received: from localhost.localdomain ([213.13.226.153])
        by smtp.gmail.com with ESMTPSA id d1-20020adff841000000b002c5640f9bf9sm5294476wrq.85.2023.02.15.14.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 14:51:19 -0800 (PST)
From: pedro.miguel.baptista@gmail.com
To: bitbake-devel@lists.openembedded.org
Cc: Pedro Baptista <pedro.miguel.baptista@gmail.com>
Subject: [bitbake][PATCHv3 2/2] action.py: add topdir in bblayers_conf path for remove-layer
Date: Wed, 15 Feb 2023 22:51:10 +0000
Message-Id: <20230215225110.4288-2-pedro.miguel.baptista@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230215225110.4288-1-pedro.miguel.baptista@gmail.com>
References: <20230215225110.4288-1-pedro.miguel.baptista@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Feb 2023 22:51:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14442

From: Pedro Baptista <pedro.miguel.baptista@gmail.com>

By including the full path to bblayers.conf the remove-layer
command can be executed from any location, not only from the
build directory.

Signed-off-by: Pedro Baptista <pedro.miguel.baptista@gmail.com>
---
 bitbake/lib/bblayers/action.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bblayers/action.py b/bitbake/lib/bblayers/action.py
index d1ba101de2..0d7fd6edd1 100644
--- a/bitbake/lib/bblayers/action.py
+++ b/bitbake/lib/bblayers/action.py
@@ -66,7 +66,7 @@ class ActionPlugin(LayerPlugin):
 
     def do_remove_layer(self, args):
         """Remove one or more layers from bblayers.conf."""
-        bblayers_conf = os.path.join('conf', 'bblayers.conf')
+        bblayers_conf = os.path.join(findTopdir() ,'conf', 'bblayers.conf')
         if not os.path.exists(bblayers_conf):
             sys.stderr.write("Unable to find bblayers.conf\n")
             return 1
-- 
2.34.1


