Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DA2C433F5
	for <webhook@archiver.kernel.org>; Thu, 17 Mar 2022 12:22:30 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web09.9649.1647519749408809204
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Mar 2022 05:22:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=bt4G4Fo+;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id j26so7149115wrb.1
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Mar 2022 05:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DQOgM9y9zU7tvK7rZUE6zn7wEs9DUOJ8SABVMYAvRow=;
        b=bt4G4Fo+3gXecHQkSEAdriCpVRkvCuP9M5e40nX+xBeruzq4qcGRqW6Dqtsbsk5vJp
         eADzyMnhGyEBzE+vcvP751is/kFk/x+Br16t6+SUXv9sa4/gSUIZvVkYRF6aUfzZ5e2z
         NonLlnaUJFzdHPNn45TixdO8jwMvumvI8Xnoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DQOgM9y9zU7tvK7rZUE6zn7wEs9DUOJ8SABVMYAvRow=;
        b=8CKGEsEx6r5de0cXUmVBPFfV1r1WNkhCmU8bo5I/jZ9U21JB4CKd+b1oKqHFGJchi6
         Rg+sNyJgKoUIJ59KKgubVfwEZ/NK+tI7JaXFi/4yCE1W19W/0w9Eaa9z6oa0nxDYMqBD
         jq5Bg16WVIlttNwWhfG2JeikG6ABZH5G/Ahu1SZa+AL+rhV0SLV4SyLVy4nt0vxtukd6
         Xqxk8OWFwCcgmESmd1R0/xQ/SCnzahB1Q376a0zz0F5faGOKGRaFl0A6hb8tRIOn/UEY
         O6cct5VU41okNocd53QJ+SGbesAHZAXg1idnhu18HzU4yJfeZR52hW7vZT9IaTMxUZKT
         rJLA==
X-Gm-Message-State: AOAM533hrsrxL2FUjyWunSuE96YpGClHQSPkicev6r5YnWKhG46pk9UQ
	Mw+rhXnc/w/8vjS5lsi1pFVuKzc4KuaKClRz
X-Google-Smtp-Source: 
 ABdhPJwc6f2SY6lX7o6hgt2P0p2jcT9+CgqXPii9vw8IJQL8AQCf18NSgnCRxPoQHNSPnQOQI21vzg==
X-Received: by 2002:adf:c5ca:0:b0:1f0:aa2:494b with SMTP id
 v10-20020adfc5ca000000b001f00aa2494bmr3916863wrg.275.1647519747491;
        Thu, 17 Mar 2022 05:22:27 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:64d8:6f1c:d663:861])
        by smtp.gmail.com with ESMTPSA id
 i15-20020a5d584f000000b00203ded4f92esm6338248wrf.18.2022.03.17.05.22.26
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 05:22:26 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/3] data_smart: Skip commonly accessed variables from
 variable data context lookup
Date: Thu, 17 Mar 2022 12:22:23 +0000
Message-Id: <20220317122225.996597-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 17 Mar 2022 12:22:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13483

The code tries to expand missing entities when they're encountered in
python expressions. Looking at traces, these are often things which
would not be in the data store such as "bb".

Optimise to skip the data store queries for things we know will never
be there. The expansion cache usually covers these but skipping
entirely cuts a few million function calls parsing OE-Core.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 8d3825f398..ca78d84133 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -152,6 +152,9 @@ class DataContext(dict):
         self['d'] = metadata
 
     def __missing__(self, key):
+        # Skip commonly accessed invalid variables
+        if key in ['bb', 'oe', 'int', 'bool', 'time', 'str', 'os']:
+            raise KeyError(key)
         value = self.metadata.getVar(key)
         if value is None or self.metadata.getVarFlag(key, 'func', False):
             raise KeyError(key)
-- 
2.32.0


