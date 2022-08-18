Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BFBC3F6B0
	for <webhook@archiver.kernel.org>; Thu, 18 Aug 2022 17:09:12 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mx.groups.io with SMTP id smtpd.web12.44699.1660842547736243182
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Aug 2022 10:09:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=7ZRET6da;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.170,
 mailfrom: steve@sakoman.com)
Received: by mail-pg1-f170.google.com with SMTP id c24so1750477pgg.11
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Aug 2022 10:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=PqMc7Q/SAvxMpPkvvuL6bzFlHltPUuyWlXbZ1W3GCd8=;
        b=7ZRET6daC6augUC9k73V+GChmGw5gQPNUAMDSpcBStnOYOPN6kwVb9iijzCKY01Mf5
         ybJPcMtlIE9q/3yWvl8P15HjUdXb8PE7gt7AanY/4gYIVGl5es5X7o/ji6S7h0uEtpyy
         xyWLIifO+KDOreurqbSugiihD0vsGQfSFSUlTaollpmm+dA7jARPHrx6mMp/n13ef/ln
         wg0eB/mINiCaMccV+0YXp4RikmiARvjsTZyN80nfYsRBPh0LJPFXjR2kvQnrt4CuNJKP
         x5DUi5LXuiBNpcdeap95Nc4yXMNFUtZCoqMdZlStqa2ImL1IzqF+sbmBUQFBL25g1Kgr
         Jixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=PqMc7Q/SAvxMpPkvvuL6bzFlHltPUuyWlXbZ1W3GCd8=;
        b=RpYUH3Q6kjg+IOyfcaPd/jpbZWI/3Vl3AS9MksA0+1nx7/jQzCY+f8HMSret7VGDAX
         meDUrQLZ5t1Ea/Bius40AuDZKuSJ62DG/shtlOz3EcuO516R2wa6XEXsniAhFqmZ3WEw
         B+f9oNFKUQJr/Ie7nyWYM0tpxG+39opqOmGrCjPX+4ruVF+taQ4RTED083anvYaAXTt9
         7sENIi3QRY4RKAnQBZh0eOHOVMX2Rm50ad5gBw3j7f7RruKlTPDMq6nuozkqvP07Gdsp
         kLNELiz6tYZiGQlPzD7ptaBBOhipSAHsffgt8gz6lkgh/ElJjuM5r5+lCQvNx8KbS0en
         v9gw==
X-Gm-Message-State: ACgBeo1pPMiMgmTdW718cLkTg3DcmzLdxWsSC8P5+vhrCH48QG+4esMQ
	eEHBU2sfpeLIDTeiGdKqZZMwYogpwTq1CZRT
X-Google-Smtp-Source: 
 AA6agR4cnGgsjO+ihOOivG1q948OOvJjQRVLdZrQ3SRaG1AWbhvVX5V+Asa412kWg5HlbXIoXbij4w==
X-Received: by 2002:a05:6a00:1352:b0:52f:bc83:c93e with SMTP id
 k18-20020a056a00135200b0052fbc83c93emr3774228pfu.45.1660842546511;
        Thu, 18 Aug 2022 10:09:06 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 b1-20020a170903228100b0016d1d1c376fsm1644339plh.287.2022.08.18.10.09.05
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 10:09:06 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 1/1] fetch2/wget: Update user-agent
Date: Thu, 18 Aug 2022 07:08:52 -1000
Message-Id: 
 <17be38290d1e971cd89785e6bf44caef0a6416f8.1660842419.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660842419.git.steve@sakoman.com>
References: <cover.1660842419.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 18 Aug 2022 17:09:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13902

From: Christophe Priouzeau <christophe.priouzeau@st.com>

With the usage of enterprise proxy, the user-agent defined are
too old and refused by proxy configuration. Updating to something
more modern is desirable.

Signed-off-by: Christophe Priouzeau <christophe.priouzeau@st.com>
Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 7001fdd7c4dca372cbebd8fd2c0b03c5d43f9400)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/fetch2/wget.py | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index d208f5ee..368c6443 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -52,6 +52,12 @@ class WgetProgressHandler(bb.progress.LineFilterProgressHandler):
 
 
 class Wget(FetchMethod):
+
+    # CDNs like CloudFlare may do a 'browser integrity test' which can fail
+    # with the standard wget/urllib User-Agent, so pretend to be a modern
+    # browser.
+    user_agent = "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:84.0) Gecko/20100101 Firefox/84.0"
+
     """Class to fetch urls via 'wget'"""
     def supports(self, ud, d):
         """
@@ -303,7 +309,7 @@ class Wget(FetchMethod):
             # Some servers (FusionForge, as used on Alioth) require that the
             # optional Accept header is set.
             r.add_header("Accept", "*/*")
-            r.add_header("User-Agent", "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.12) Gecko/20101027 Ubuntu/9.10 (karmic) Firefox/3.6.12")
+            r.add_header("User-Agent", self.user_agent)
             def add_basic_auth(login_str, request):
                 '''Adds Basic auth to http request, pass in login:password as string'''
                 import base64
@@ -407,9 +413,8 @@ class Wget(FetchMethod):
         """
         f = tempfile.NamedTemporaryFile()
         with tempfile.TemporaryDirectory(prefix="wget-index-") as workdir, tempfile.NamedTemporaryFile(dir=workdir, prefix="wget-listing-") as f:
-            agent = "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.12) Gecko/20101027 Ubuntu/9.10 (karmic) Firefox/3.6.12"
             fetchcmd = self.basecmd
-            fetchcmd += " -O " + f.name + " --user-agent='" + agent + "' '" + uri + "'"
+            fetchcmd += " -O " + f.name + " --user-agent='" + self.user_agent + "' '" + uri + "'"
             try:
                 self._runwget(ud, d, fetchcmd, True, workdir=workdir)
                 fetchresult = f.read()
-- 
2.25.1


