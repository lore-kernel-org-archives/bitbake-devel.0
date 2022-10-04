Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD21C43219
	for <webhook@archiver.kernel.org>; Tue,  4 Oct 2022 15:55:28 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web12.12504.1664898927981725831
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Oct 2022 08:55:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=N24L3Of/;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.45,
 mailfrom: steve@sakoman.com)
Received: by mail-pj1-f45.google.com with SMTP id lx7so13253408pjb.0
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Oct 2022 08:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=gE1JcnoXBI2sJQmRPjFIy2Bdfj0eBjSqgCpOzPe+AXg=;
        b=N24L3Of/z46vtiJLLNMtC97HLsViEQ04H5XwGtjUbh+WzMGqSL7Y38zgl8QtCY6+rN
         NUN0jtcPtRYtlRnBDKb9bAnmcQ7SvYRs5CPS5hwZ+vinxIbvBBreWKGkjkagKyUtv+X7
         Z0ig8DyDTLGXEAoivLl8LhhwaUS+bfsjYAhJqaAlNFYAimqtioLmHUgbXhwuHBc83HDE
         syCpjtqibhnEWFolzQHeSFrvP9n7m7a104nbyE3nG1nWzrpSewn5ArJ3WjB2R6Yh/if9
         8L5HkBrYrP4wXseBWZZcHHrpv7mypEXf72+/aGWNRSeNYsHM/ASUIe0qJV4AgTo/AkKn
         9z5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=gE1JcnoXBI2sJQmRPjFIy2Bdfj0eBjSqgCpOzPe+AXg=;
        b=TSHlIy7nJUin/f20/PnN20e82EmSHeoUbp9cM255KRmoJm7cgXwzgwkJL3FwfoO1+Y
         gFTcKg0Y1CzbWdNvdcfoksCNE2b+TjhiRcb8tNYAoELNkvFt+B5bpMuMjYNkcatqM90v
         nDlbwBTfMo5aQvpiA4FP3w8uBc0BDerBdx0j42CNAZu77TY0UzbfYzsOSICuqqKkObD4
         pxYaNWcJvOGwlmudSgtJlmLzd81v02VPvZnWCbgbV/T5X75438Hgmp7GEercf+ppIyeD
         zwkyUI9gRtcPcHSRPXmmIR3oFgBnQO2innJrBcNAsI8VkgFaJ9R7UMGYLUrWAgUMBaCa
         jiMw==
X-Gm-Message-State: ACrzQf1H4rirNpzXLdyWK6EPl67aADQgBIpVTuhFQPtHFexJJqqS4wYd
	oyKLHpgihgP/wT8C3RPH/2R723uIy/734i2B
X-Google-Smtp-Source: 
 AMsMyM6WLzSN3URR3ib497Jd4T0zjlc7RO+UIwiq4J+NA1PyJeqw4Fon84cA5ioM6UWoEx0LMDq2vA==
X-Received: by 2002:a17:90b:4b0d:b0:203:690d:9f7f with SMTP id
 lx13-20020a17090b4b0d00b00203690d9f7fmr358543pjb.145.1664898927041;
        Tue, 04 Oct 2022 08:55:27 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 k18-20020a170902c41200b0017e232b6724sm4716457plk.69.2022.10.04.08.55.25
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 08:55:26 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 6/8] Fix npm to use https rather than
 http
Date: Tue,  4 Oct 2022 05:54:57 -1000
Message-Id: 
 <bb5c43220f5f1c3d82334c65aff1ce13008db8d9.1664898736.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1664898736.git.steve@sakoman.com>
References: <cover.1664898736.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Oct 2022 15:55:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14021

From: Neil Horman <nhorman@gmail.com>

Hit this error while building nlf-native recently:
{
  "error": {
    "summary": "URI malformed",
    "detail": ""
  }
}

Some poking about led me to discover that:
1) The npm.py tool replaces npm:// with http://, not https://
2) Some versions of the npm tool don't handle 301 redirects properly,
   choosing to display the above error instead when using the default
   nodejs registry

It would be good to go fix npm to handle the redirect properly, but it
seems like it would also be good to assume secure http when contacting a
registry, hence, this patch

Signed-off-by: Neil Horman <nhorman@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 2cd76e8aabe4e803c760e60f06cfe1f470714ec7)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/fetch2/npm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index 8f7c10ac..8a179a33 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -156,7 +156,7 @@ class Npm(FetchMethod):
             raise ParameterError("Invalid 'version' parameter", ud.url)
 
         # Extract the 'registry' part of the url
-        ud.registry = re.sub(r"^npm://", "http://", ud.url.split(";")[0])
+        ud.registry = re.sub(r"^npm://", "https://", ud.url.split(";")[0])
 
         # Using the 'downloadfilename' parameter as local filename
         # or the npm package name.
-- 
2.25.1


