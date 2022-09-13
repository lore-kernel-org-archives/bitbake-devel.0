Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339F4C6FA82
	for <webhook@archiver.kernel.org>; Tue, 13 Sep 2022 14:27:20 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web11.5257.1663079231112855644
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Sep 2022 07:27:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=IvwqiRKx;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.48,
 mailfrom: steve@sakoman.com)
Received: by mail-pj1-f48.google.com with SMTP id q3so11484015pjg.3
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Sep 2022 07:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=A8ec0QVMnyBmVjf/L9T6ekHB8tq3Eo4Bc86WJ7hh7Nk=;
        b=IvwqiRKxVUmgg9BL81WuG5DjuHmnlz8Wy0qm9tfToAeV9JlN9BxFj5ge/rFXsTtKwT
         u8S1Ts6Dj+In/pk5YhkEJHsYTJWbgSfkNjCp0Gz3ZOqvlt47f7c1ug/LzMnGP+Ec9CTM
         DLF+Wo9COMF4WA+jof4gz7xahKaPeaJImAV10VoxLPGxUCF6Z+72CagPCGAtPGLGxa/0
         rLC9HyjB4dt9Lvnf2GbcmWyMwKTQiN9QI6K0vjC6JaEBo5Zncb9AFCJVAwnCNLfTp7SC
         nhiTlOms/YHRgwt2NOCZXyYbXa9HDPSoQ1loRAiB6KdeDE5vTiWS5RAjnY3slqW2VT4d
         TX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=A8ec0QVMnyBmVjf/L9T6ekHB8tq3Eo4Bc86WJ7hh7Nk=;
        b=hYOYq7o1SJ7/D2BMqfZn+HWkZefmXdpwWEnl90Hr9V+SPPm9cU52vT7uFAwUCpn2Uh
         YEjRdQG8ZTQZn+a2vL62r81HTH5FY3jmztoWal8k4Nl17rIrHY9XcrwM3wSYTARKaNjm
         bu9rhIdEo1A0D+SLh230tKXyLMux5Rt2bjTzzTerQ+SaSOMn73b6iJczEHa6Pammg5zd
         XeSGiZXHksDiD6iCdOsxbK5V9tX2hJQNSjlK56cY0P6iInvIYT/EBE9EHY2yER9RJ3gA
         RlYNh7SYN1ibfW5WRhwfwR+YjKwLUO8+yf/4ffqc+VRPcCDsd9DdQKv0mrkP/E5vNm4h
         A9IQ==
X-Gm-Message-State: ACgBeo0suOYlEnIqe74/MQwQy8ImuABKRHomuxT90X1yguq2jbH9TkQJ
	l1gDain7lRhZKt5Peyfkf3lUl8GChFWSS++/
X-Google-Smtp-Source: 
 AA6agR6t0sTEMTMadSu+romeq9y4vxMi5wow6RRqgPQNh/Hpy2RFzLnKqNXqtYihsDp6qEXQlS+yzw==
X-Received: by 2002:a17:90b:1b10:b0:200:934b:741f with SMTP id
 nu16-20020a17090b1b1000b00200934b741fmr4362361pjb.212.1663079229908;
        Tue, 13 Sep 2022 07:27:09 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 f196-20020a6238cd000000b00540de61c967sm7840286pfa.201.2022.09.13.07.27.08
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 07:27:09 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 04/14] ConfHandler: Remove lingering
 close
Date: Tue, 13 Sep 2022 04:26:34 -1000
Message-Id: 
 <67f46734f5e8c095548ce7aa854e7ea8e8e3a004.1663078873.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1663078873.git.steve@sakoman.com>
References: <cover.1663078873.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Sep 2022 14:27:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13965

From: Ola x Nilsson <ola.x.nilsson@axis.com>

The f.close() statement should have been removed in
459ad524756a3f9b50feeedf31e33502dceae8d5.

Signed-off-by: Ola x Nilsson <ola.x.nilsson@axis.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 9fc1bab6b7e3c0fca3ddec4bc8c7763d2aff8bab)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/parse/parse_py/ConfHandler.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
index b895d5b5..810b6011 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -147,8 +147,6 @@ def handle(fn, data, include):
     if oldfile:
         data.setVar('FILE', oldfile)
 
-    f.close()
-
     for f in confFilters:
         f(fn, data)
 
-- 
2.25.1


