Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71583C6FD19
	for <webhook@archiver.kernel.org>; Fri, 10 Mar 2023 20:45:41 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web10.30833.1678481137769508976
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Mar 2023 12:45:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=cHTnEg6F;
 spf=pass (domain: gmail.com, ip: 209.85.221.48, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f48.google.com with SMTP id v16so6253118wrn.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Mar 2023 12:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678481136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ici8ngGTFKAdb3QgWeePJEkL9CATtA6yKoICPBgOI8=;
        b=cHTnEg6FiK8Mrh+PVugRcQJ3hsEb3oWNiLYS1RMnmnsaJpcSa3GC99iLia7NFt6Oqd
         GjOMUDBZT+Qa2cnci9j+LMMcKcLOuFmW0RCPu7dA8WgO/4id+Blo/VTbcXftCefa1qEX
         OEOy/7aebxfkvqzPav63eWQ/zLkDD7bX012tUeQ7U+X4u/egYOFSk1YPEemi1Iw/TApb
         iwnwqThMNbRgpJJX3U1TMCEkTDGERNRDNLbd65tk6MPs8NwFmAjoWefgXWE0AqhMv+vI
         +Nc+tKQETjroiei5SpYsE0sccvsiPnhGXYGdW4gTiu7c/mVfE4Vmr8gt+5Ra+GojtO58
         Fvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678481136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ici8ngGTFKAdb3QgWeePJEkL9CATtA6yKoICPBgOI8=;
        b=B/ipg60ZPQcajoKVn/V4UR3PHfSpJ5Lp7jjDdMoJx4bdv3dkrTG+qWdLa/z2pEyWGb
         9CIgQe+esqM1P4ge2OiNqo65TNsl5ySTshlgU98gR4NgjbGYHIYkYRw08cv8jm3Tobn1
         hfBUzpe18/1lhb1UXEdl9VmO75bXp6TlAZaI5SWmvgqY2lJ6UHwHcruOfiMNQLTuQrYw
         nNfMuv7h8TXdnd8y7augB6qFHH8HgekwyTGEFupA26Gm2XQHGH5/Kz0REArtEHTHYbLU
         2twBLgtxbNWrhpjHhcxu4a78d4cr6AFye5OLJgEfZMNIDhIFaZPHwPt07ksq5/Pa1UA+
         PBIQ==
X-Gm-Message-State: AO0yUKUBWLSld3R3Rvh+0uFUDSWokVAoIeqzweAA7JntlqfQBr/rwx7z
	qUgn2OXI08luNUf1wUR5TeViaMbqEZs=
X-Google-Smtp-Source: AK7set8uRzU+x8tlF+dUFZ7j/E4zPU2S6iJaYLVoqji/pdRAjmKbRQrLKNOQ9SFRQcP3od/nnw6/KQ==
X-Received: by 2002:a05:6000:4a:b0:2c7:faf:af32 with SMTP id k10-20020a056000004a00b002c70fafaf32mr16560878wrx.14.1678481136321;
        Fri, 10 Mar 2023 12:45:36 -0800 (PST)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id h16-20020adffd50000000b002c56af32e8csm644089wrs.35.2023.03.10.12.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 12:45:36 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: steve@sakoman.com,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [2.2][PATCH 2/4] cookerdata: Remove incorrect SystemExit usage
Date: Fri, 10 Mar 2023 21:45:17 +0100
Message-Id: <20230310204519.706973-2-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230310204519.706973-1-Martin.Jansa@gmail.com>
References: <20230310204519.706973-1-Martin.Jansa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Mar 2023 20:45:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14541

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Calling SystemExit doesn't work well with server/client usage since the string
isn't printed to the right place. Use bb.fatal() instead which prints the right
log output and raises and handled exception which then shows correctly on the
UI.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cookerdata.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 8a354fed7..3555585c8 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -436,7 +436,7 @@ class CookerDataBuilder(object):
                 msg += (" and bitbake did not find a conf/bblayers.conf file in"
                         " the expected location.\nMaybe you accidentally"
                         " invoked bitbake from the wrong directory?")
-            raise SystemExit(msg)
+            bb.fatal(msg)
 
         if not data.getVar("TOPDIR"):
             data.setVar("TOPDIR", os.path.abspath(os.getcwd()))
-- 
2.39.2


