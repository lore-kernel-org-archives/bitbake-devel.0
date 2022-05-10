Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DD1C4332F
	for <webhook@archiver.kernel.org>; Tue, 10 May 2022 18:06:23 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web09.625.1652205971397246784
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 May 2022 11:06:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=5l815EF3;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.44,
 mailfrom: steve@sakoman.com)
Received: by mail-pj1-f44.google.com with SMTP id
 cx11-20020a17090afd8b00b001d9fe5965b3so2646079pjb.3
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 May 2022 11:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=irAwxtw+2l2pV2lfo2mVFihkd2cxnyjtQMAgdh0nskE=;
        b=5l815EF3nuVJQFEWbaEb7+RPwmKcJEuM7LgWHnJhm8fwBhzWKhSiPLZMpq3eHG+eWP
         HFCqt7KnVs3UKwaNvzxFke7HVIsUbxkLr/RZotkRABUlYHMgRhh27lGNRADpv5d9XZQe
         LJejzRNA62IxXuocnda4qGWIqMwv1Q42DAwvpg5ZsYWa6mvLZBJo19WrnpYTVkiWz8cb
         cQeZobtK5dsqZ8f33TNIWxJXPL3oSK44Hx/T083TBVtRifsh+I+dQBQmAuOUSZ2Lbs/8
         E9Xe2nrzOrpPXkct1cXG8DZyf4UVxtfKgyeT6b4iabv4lP/uGLi4RdRHRKd9jOFU1Qfv
         qgMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=irAwxtw+2l2pV2lfo2mVFihkd2cxnyjtQMAgdh0nskE=;
        b=nBIKmK7qeY3Y9AfpnR5YlTr1oj7WrE4wLOezmzGLVZw6hMUz6fNxHgGMZaIFyPFvWd
         AwQ2cOmA71ZMPPP3DIFiUO+8219MNoH3pJYcRsiyL02G+ea6heo4y1XjdJP9Dv5Jd/bG
         FPGN37EbgrKqq8HyVQCp8NmMzb20rbh0Z31sb6k7iS8XlDs3KihLTtGVf1PN504worcs
         fmERb5VscG13bLnNDr3rNPowWPrTaQgVMD23TQK+bqTS1t8HkDwJMYuYKXxenalAFjH8
         OLL5SnDbqggwgcLovkfF6d4gUSKXa1tIJbPBHlFD2Dn/Pl/ky6P5HxXkExmxUYJDisos
         +hkA==
X-Gm-Message-State: AOAM533STm/f4We12lvB2xscVoGk9opJOVCxBGCCHlAulpsxppPr8UXK
	3nsb4OriWjG1T85VI29XG1pg8eH27XNFbmdN
X-Google-Smtp-Source: 
 ABdhPJxoqUZcSKZFh2Ne7HOetSJymny3GAegklP8GhYAenSub24X0rDbOs8h2whrzlL2CFlKnyNqIQ==
X-Received: by 2002:a17:902:c409:b0:15e:bdd3:1fa3 with SMTP id
 k9-20020a170902c40900b0015ebdd31fa3mr21668125plk.67.1652205975650;
        Tue, 10 May 2022 11:06:15 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 12-20020aa7910c000000b0050dc76281c4sm10846777pfh.158.2022.05.10.11.06.14
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 11:06:14 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 06/18] msg: Drop unused local
 variable
Date: Tue, 10 May 2022 08:05:31 -1000
Message-Id: 
 <98b6158c174779fcfa214bb52e2e91d1db86ef83.1652205806.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1652205806.git.steve@sakoman.com>
References: <cover.1652205806.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 May 2022 18:06:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13686

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 140929b404ee1e2f5e0e1a3a1d3aa49fb3759ade)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/msg.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/bb/msg.py b/lib/bb/msg.py
index c95a874b..93575d89 100644
--- a/lib/bb/msg.py
+++ b/lib/bb/msg.py
@@ -133,7 +133,6 @@ class LogFilterShowOnce(logging.Filter):
         self.seen_errors = set()
 
     def filter(self, record):
-        msg = record.msg
         if record.levelno == bb.msg.BBLogFormatter.WARNONCE:
             if record.msg in self.seen_warnings:
                 return False
-- 
2.25.1


