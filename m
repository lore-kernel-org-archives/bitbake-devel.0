Return-Path: <nhorman@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E967ECAAA1
	for <webhook@archiver.kernel.org>; Tue, 30 Aug 2022 11:44:54 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.web08.10441.1661859888754232058
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 30 Aug 2022 04:44:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=HBrg/UmP;
 spf=pass (domain: gmail.com, ip: 209.85.222.179, mailfrom: nhorman@gmail.com)
Received: by mail-qk1-f179.google.com with SMTP id g16so8125212qkl.11
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 30 Aug 2022 04:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=3SK3xmyEA/ZtIxMJfUgQ1mIp+ChqdNROf84zaKciotc=;
        b=HBrg/UmPrje8iEFwaJvUP0GM/ZO2236okU+WBkU7MsKcmgFWsyvFPtFxc0eKyLM1G9
         sgf7ZTGkqAuVLYBu208E9QWQdfxs9nrzn1Su9lcnM51VGRgPqv2uuR2bEODxSdtg2FfZ
         mRKdlkqSuNaEN0+E8+KycBR5FmTn1Eq9l7lc86NdzjH3rMOIIvss2ryv8PrmiwM1hNtt
         udn4yoqCTx7et0mRlYa20ykg2P/JE8n6auhLbpR3fYW1tTYvYy+K0s8HpO33jTAXV/UW
         kVkNU1AmwU6jW7o4c9ZFrDNg9ALjXxCl2brmX96s8yQ8ORzfc8lRAp08aUNv6x7vi+mA
         +HzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=3SK3xmyEA/ZtIxMJfUgQ1mIp+ChqdNROf84zaKciotc=;
        b=cNfTKQBdirjzTpE8NbzRoPv2N6T0yyzVr2paFGKFThQPlk+/EewD1EOGjPIzyVrctX
         n7MVJe7LJ82RVclUxNAqe90E+rvicWzMDAmH611QJ/PEv5Q1xtnElaHYHthuT0pF+GDt
         0hPqfhJFQUpWCLkDTWGVRdHEaSMtsmsBzJulz8TJxGp0/rNma3dmqDXSCPiR1YRFvpFL
         CA9ydu9ts0QQEVcfcLmqmZ9reia8pzi4vk+SQUgPL7+VhBYfe5Rg5awcesyaDN5rkfJb
         xrDG7D2VlkIT4khLDgVperkTIC18hc2F10goVrzjV5hfdOY3Gw4dEC0rRbB+0vzAyaXX
         Bdqg==
X-Gm-Message-State: ACgBeo3+bcAHlxaBgZyvdtbXeBeYtmkdXzjX9ZbNNp1XarRUdno9veBz
	Lbg/FW4wrX1Un7UHSyhMwP0vAMs75Avl3w==
X-Google-Smtp-Source: 
 AA6agR7MofxZvNtgFHzE3LAVg1NObR/QQ48EJIITcf0cbb6BCBEZMoN/kiqTP0pjZyYo+hKaZap9RQ==
X-Received: by 2002:a05:620a:7e2:b0:6bc:980:db39 with SMTP id
 k2-20020a05620a07e200b006bc0980db39mr11680351qkk.176.1661859887501;
        Tue, 30 Aug 2022 04:44:47 -0700 (PDT)
Received: from hmsvengance.lan ([136.56.11.135])
        by smtp.gmail.com with ESMTPSA id
 i7-20020ae9ee07000000b006a6ab259261sm7721388qkg.29.2022.08.30.04.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 04:44:47 -0700 (PDT)
From: Neil Horman <nhorman@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Neil Horman <nhorman@gmail.com>
Subject: [bitbake] [PATCH] Fix npm to use https rather than http
Date: Tue, 30 Aug 2022 07:44:45 -0400
Message-Id: <20220830114445.704328-1-nhorman@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 30 Aug 2022 11:44:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13945

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
2.37.2


