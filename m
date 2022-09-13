Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CF0C6FA89
	for <webhook@archiver.kernel.org>; Tue, 13 Sep 2022 14:27:40 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web10.5465.1663079256486981304
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Sep 2022 07:27:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=46sbGjEr;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.41,
 mailfrom: steve@sakoman.com)
Received: by mail-pj1-f41.google.com with SMTP id fs14so11476670pjb.5
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Sep 2022 07:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=0sMoDlW+E0cIU3wL3iyCgCe/WYt7BXuTxZxM9G2hKEg=;
        b=46sbGjEry+E2EM4kuSa8Ccojl4OVsiMObMmu+x6/UXtSx9yOGWl7vgk+SkSve20ni1
         kjsQmcMUvajJz3zW1oYjLfy6jv/yHC+XzFJetFy1pY+aA7EXChV+vGL3MS4tvGYEXXT+
         p9bLFvi2/o4OQZBHIHHUuoWNokPQRcVwOU111aiQycrn6ntVWOp/Bz3zzN0WvFWpMrh2
         UIPqL/WGExqSyrYEQHzFxDCEnRqeM4sAlUMHAwNvZOM3/sZU6Rl/rTJOc6K7NsaPj1aO
         /kJWQnrPpjIzNY7J0MizNja1ym0BXYczBQgr37+PbnEdZCFUP3o/Wii3u7FG5GmAoe3C
         zSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=0sMoDlW+E0cIU3wL3iyCgCe/WYt7BXuTxZxM9G2hKEg=;
        b=F5RFcAXn+6MeHqrGjtSS/viwVeXtZTcCgkMgnnXgERQ5x7I7n9ZWA2IEpeA29S23jK
         sxBYZ0zuGzy30NzJ8vEtkLyRyuR8a//jSbjGXzR6HujTW2uxW9xp/8M0OGLd26uUjshP
         KQPZhQE8vV4TyyQmaVAWeEIDLhjD+gWDbpHiCpLyIgXO8M9ZFPTAPz+hpS05iBuqmWxU
         M+Pg0GmWg8HpCTk+N5MES+WdiG2jsU75BkTk4HPcKlwFE9a5eKKp+Y8Wemgx9tHR9FJO
         QHL4crZgyZ39Zu+l3xC3uWXmbNrcex7f9BsYDsKrUv5zbBBgjl3zBBwsBvUm0BNoHsU2
         lqnQ==
X-Gm-Message-State: ACgBeo1Cb0TTNYeEkUqi1JSc5g1VxKbxvp73z/vGq7k3Md3EcJi2mwV7
	3LN6VARZ7bBJevOoadWNWtnZ036ov+6HaDbp
X-Google-Smtp-Source: 
 AA6agR4yHuFtW+A+11CRSY2yQkwow8IUIRjZUBKzlBkeg1pMLjkq8rI4LBbzZUOlcjox+dI7rNPSUQ==
X-Received: by 2002:a17:903:32d1:b0:178:1cf0:5081 with SMTP id
 i17-20020a17090332d100b001781cf05081mr16993988plr.54.1663079255516;
        Tue, 13 Sep 2022 07:27:35 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 f196-20020a6238cd000000b00540de61c967sm7840286pfa.201.2022.09.13.07.27.34
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 07:27:34 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 14/14] bitbake-user-manual: npm
 fetcher: improve description of SRC_URI format
Date: Tue, 13 Sep 2022 04:26:44 -1000
Message-Id: 
 <1f8fa1cb1dbd683a6177bb1275097df6821d2a3b.1663078873.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1663078873.git.steve@sakoman.com>
References: <cover.1663078873.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Sep 2022 14:27:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13975

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

Using the term "Parameter" which is consistent with the
description of SRC_URI parameters in the following text.

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Reported-by: Quentin Schulz <foss@0leil.net>
Reviewed-by: Quentin Schulz <foss+yocto@0leil.net>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
(cherry picked from commit 87e42f1202162152c779ccc8bbd06f88f0bdab96)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index 4dfb7889..9c269ca8 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -717,7 +717,7 @@ Javascript package registry.
 
 The format for the :term:`SRC_URI` setting must be::
 
-   SRC_URI = "npm://some.registry.url;OptionA=xxx;OptionB=xxx;..."
+   SRC_URI = "npm://some.registry.url;ParameterA=xxx;ParameterB=xxx;..."
 
 This fetcher supports the following parameters:
 
@@ -757,7 +757,7 @@ of an NPM package while locking their versions.
 
 The format for the :term:`SRC_URI` setting must be::
 
-   SRC_URI = "npmsw://some.registry.url;OptionA=xxx;OptionB=xxx;..."
+   SRC_URI = "npmsw://some.registry.url;ParameterA=xxx;ParameterB=xxx;..."
 
 This fetcher supports the following parameters:
 
-- 
2.25.1


