Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04F7C433EF
	for <webhook@archiver.kernel.org>; Tue, 10 May 2022 18:06:53 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web08.657.1652206008515745564
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 May 2022 11:06:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=GP4a+DUp;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.175,
 mailfrom: steve@sakoman.com)
Received: by mail-pf1-f175.google.com with SMTP id p12so15603462pfn.0
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 May 2022 11:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=T7eeSUrNVKzuMM1AZ/HIwS8sZVbN1XhrIFB4l2C5grw=;
        b=GP4a+DUplk5rZeg8a4NYK6SHwFXnYTwrqmPM7pbHUYiMmH+Biz1Wfy19SMiE7tlEnl
         8sPTECAwpQG6enBKCJCwZq4qeNaORqO7y+MHUN+q0LLhwdk/ZRiiQex09wKhS7b8f2nJ
         OY6wCDnwf1kRFam9vP/Uk/83J3on7iyBu3r9Loa2AI5LYmmCSZwYNITT5CeuB6WWXEzE
         1ZiPHRNMJGqmgxHjH0hsRX7mhXsWZOCP0+bGbbxeNxPin5p8SDy9RQAkSPJTHd4cMmwG
         lsTDH9Hm8xBS/DLBxGy4QSnuY/IuEk8I47KNi6Jy5JXMLEkL39y7JPCrtzEK0Folqt3C
         ovRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T7eeSUrNVKzuMM1AZ/HIwS8sZVbN1XhrIFB4l2C5grw=;
        b=sa2yw4/WBeWtuIv2ENM36421R6u8xzMobTRWvU6THtHhyrLCfatumOqOgIf6vfeINL
         y3zvfj84G7+ODhUylvg39Tfl4ByvuM0ZCFcOD6yiREr1omdQ5ofFpYeVV+r+0R3WSZuI
         zS8vXSLH4Qsp+oW3yuN9APuYo+9RxAgpcvkXLacTFjGcBfQj4D9dDp3w3wJmZET3GxDU
         3tbJ0ruyfScx1lB4RsQRDr6Y/rkk2zm+8Xq43c9R+YANAbV4G6h+Sp/gxWUM8fS0QhSq
         kj+gVOvZaxyPphtn1aDB3QHGvAhuuoIEO5//vigjcf9BivcmCGjLmlCpoL71xhtizRQi
         H60Q==
X-Gm-Message-State: AOAM533vrpZBAJbuSr1NVfeTNnd69dOR2HB2rqzs3KalgugqNDR08Alg
	Ncdu4oU0o/YlpQsMAMKSgSUSeJzX3cuOoS8f
X-Google-Smtp-Source: 
 ABdhPJwljjZMR1CzirCRINUA7b3lgmOe0tqT+Oujj2y7vTNpqBjAqbDero2YPp/qVJFa3UfjCVpxvQ==
X-Received: by 2002:a65:604a:0:b0:3c2:fe7:a14e with SMTP id
 a10-20020a65604a000000b003c20fe7a14emr17443952pgp.156.1652206007325;
        Tue, 10 May 2022 11:06:47 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 12-20020aa7910c000000b0050dc76281c4sm10846777pfh.158.2022.05.10.11.06.45
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 11:06:46 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 18/18] fetch/git : Use cat as pager
Date: Tue, 10 May 2022 08:05:43 -1000
Message-Id: 
 <e7b26d210c911a51cf6439fb8f2fedbabe30c53a.1652205806.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1652205806.git.steve@sakoman.com>
References: <cover.1652205806.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 May 2022 18:06:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13698

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We don't have less in HOSTTOOLS in OE and this can confuse git. Force the
pager to cat to be consistent and minimal everywhere.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit d3d406e8552fdd865dc58b419a84411736475ad2)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/fetch2/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index b3eb8248..f0df6fb6 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -240,7 +240,7 @@ class Git(FetchMethod):
             for name in ud.names:
                 ud.unresolvedrev[name] = 'HEAD'
 
-        ud.basecmd = d.getVar("FETCHCMD_git") or "git -c core.fsyncobjectfiles=0 -c gc.autoDetach=false"
+        ud.basecmd = d.getVar("FETCHCMD_git") or "git -c core.fsyncobjectfiles=0 -c gc.autoDetach=false -c core.pager=cat"
 
         write_tarballs = d.getVar("BB_GENERATE_MIRROR_TARBALLS") or "0"
         ud.write_tarballs = write_tarballs != "0" or ud.rebaseable
-- 
2.25.1


