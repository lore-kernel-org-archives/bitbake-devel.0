Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCF0C43217
	for <webhook@archiver.kernel.org>; Wed,  9 Nov 2022 14:30:00 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web10.3969.1668004193856984079
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Nov 2022 06:29:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=iAZPiwMU;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.43, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f43.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so2065584pjl.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 09 Nov 2022 06:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wljpKbtmYUJvTpqZEI788O8HXmcIrCd9rFF/kkd1VNQ=;
        b=iAZPiwMUU3/cM7GbIlL6KFjDE1ht4TTSb4baI9cI8PmGqDZkdWxNCEYiCrG42WNFmw
         FygZNP91/HQBGZHqJVav1whL+bTnmzJPlLCo52sFwolkcvvDsbqme4ss/2cwaud2jP5+
         0uS0+5wrM9ZCx/fsAyq7l3py79D2iTRbmSQvvroduqNwThBEeZ9l6Ji0d2WHE51edWaQ
         wZz2ZGWaqJPa/L/tS+2BDcAL1/yU6Sjit7F0E7tenIBsgc9EWjmtg7QQRbSlXHcV2/np
         02/BR/cP97jpCxF1hIQEUHP9bFmXsOaFD2SP9qPm1wMt2fakuhTMlmYPc5bM0m8rBZmD
         zWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wljpKbtmYUJvTpqZEI788O8HXmcIrCd9rFF/kkd1VNQ=;
        b=Ju3Kzy/WPYZaAnOFGYD/TyX5ch0BE8t5O9Ado5Tc9C32wzPsCnacd1LwbobkR3EYN6
         lB3wg/31BGfTVJ+fk2ISMCvSgJo2KC7AReYYts7rr7yaUmRVu3ah9yohJlxYpFJtICmC
         I7DrY86eAK/mIzIwrlCIgqlfT3lCCpr6c5GdTcv/h9+5sq+SEW98bsTxGYmbi9kpUYl+
         koyT332ngJvcdO0QAfCMa9DmGK7bS+mid5PTYAIdlKlMsCSZDxzThUv/jRkZqo19XdkZ
         leSYyQwHlpvxtKC+aGRFU2w6xxRfVsDwfyRgcXSLXEP3m4M+s/VpHG8yHcS8PbYKl4p4
         nEyQ==
X-Gm-Message-State: ACrzQf0wc0C3rIcYn8W+IrPyhsB2C1jvchkKPACbPjCX7XsxAOkWpxY4
	1p3M3Qqq6z01GQ7lLhE06X6a4nb9W2U+THhC
X-Google-Smtp-Source: AMsMyM5GKhJbMkjbpsWJSgHv/nSSWSlc9wRq9Z2NZUvK2eE3Z/Yxa/MlUz+iQmK1a1oiNOH8+asY/A==
X-Received: by 2002:a17:90a:88f:b0:210:f235:1151 with SMTP id v15-20020a17090a088f00b00210f2351151mr1212909pjc.230.1668004192755;
        Wed, 09 Nov 2022 06:29:52 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net. [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id nn14-20020a17090b38ce00b00213d28a6dedsm1308611pjb.13.2022.11.09.06.29.51
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 06:29:52 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][langdale][2.2][PATCH 2/4] fetch2/git: don't set core.fsyncobjectfiles=0
Date: Wed,  9 Nov 2022 04:29:34 -1000
Message-Id: <0b7011c4fb3f641e1e14ab92c489518264adc4f5.1668003926.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1668003926.git.steve@sakoman.com>
References: <cover.1668003926.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 09 Nov 2022 14:30:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14063

From: Ross Burton <ross.burton@arm.com>

This git configuration variable is deprecated in 2.36.0 onwards, so git
warns in the logs for every git call.

Luckily the default value has always been false[1], so we can just remove
this.

[ YOCTO #14939 ]

[1] https://github.com/git/git/commit/aafe9fbaf4f1d1f27a6f6e3eb3e246fff81240ef

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 8ad310633e0c5d5593631c1196cbdde30147efce)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/fetch2/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 17d49049..578edc59 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -243,7 +243,7 @@ class Git(FetchMethod):
             for name in ud.names:
                 ud.unresolvedrev[name] = 'HEAD'
 
-        ud.basecmd = d.getVar("FETCHCMD_git") or "git -c core.fsyncobjectfiles=0 -c gc.autoDetach=false -c core.pager=cat"
+        ud.basecmd = d.getVar("FETCHCMD_git") or "git -c gc.autoDetach=false -c core.pager=cat"
 
         write_tarballs = d.getVar("BB_GENERATE_MIRROR_TARBALLS") or "0"
         ud.write_tarballs = write_tarballs != "0" or ud.rebaseable
-- 
2.25.1


