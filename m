Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D26AC43458
	for <webhook@archiver.kernel.org>; Wed,  1 Jul 2026 13:56:05 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.45684.1782914161226047862
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Jul 2026 06:56:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=EIQn7o2Z;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-475881b9a4bso750757f8f.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 01 Jul 2026 06:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1782914159; x=1783518959; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ekHhyLPeybn5M05MFBOs+G3CqWcW5vr/UlTRo7sKatg=;
        b=EIQn7o2ZdSILwD0Hn+qWcEBMFBTkvPO5gkTxvwy9rNK0QhKdEULFi79eym5PEYzw+h
         qBK3azMczBUZV/jIaCRIWG6cml4IjiIU4nlr/hPDC6WvuJEF1LbfulFfGfy0KXUsa1Fs
         JF/2ltbSLQkxVZ1Nv1BvoIl6WDX0PdnOsPs3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782914159; x=1783518959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ekHhyLPeybn5M05MFBOs+G3CqWcW5vr/UlTRo7sKatg=;
        b=OEmyLRmUylG11uq3C7VqO347cIRLkJmFJfmHVg1GO8cRCkhZFqg8CYxWD3BMHeV7o8
         Blp1IFs/1vvpKOwre+UcK3L9qYjfbMsj3Q7ON254z8lHDUORcGakGGjGq+ls4b7HoyD2
         An7jczB5NumSvnyROwrGX92zgtWA0kQECLjzd+V54SLoqWa5xKddaqOnWtP4xmV41Mwg
         OcqbzuoZFkkrbeq8PttW9bernzom6MMli4oQqiB/uMRMhgeFpLQg57mwJsI/JpIpi/nN
         2R96j6fiqzu4pbAGsMUDwBEbADnMjOzQvjQiqDXrtbNvikrGFDaEIQNgcklzzOo/5tOk
         RObg==
X-Gm-Message-State: AOJu0YzdX46wC9TdXtYPz8ibmLNSvC+Y9MXSSa8vnagPuI6afGQNmjmM
	lkzHUMMWgRWf9zpx7pg3ule6SD19Aast8aYh8AuusjkhpdyzWFKfVCt2MW3G+Z2Uy8lCQYgxRsv
	sKlfA
X-Gm-Gg: AfdE7clQKeu79UjecUXJySpd1mOaWs+v9MpSKq2cLVUKV/2j1YIpQGk94NM+SHjmrjP
	TMOxPdD/Y1DhzKdJpCVLI9foWEpZMkTPc8ZjXedxVTjNI8k4r9or5RKwFCr4AYIt7Bxmh1XjzSv
	jOdjpVwtZLFbTwdmIwHJn88Mpt7vPvN7/rAgUewsiUmq7oFPFRxgA1R02Vo3/33obIy0i4mVaTU
	FeGpha+9OzKWVHCGzKjW945eJEvDkGaI6PqpUqxtr7Y3sZyl5GbVnRk5Mfc275S/TWKaH/wGVcd
	ZE5PuOCQuOV0GGopypnWi9JHY2RGQP8qa9/ylJj31Kg/M3nz4MCnLlO9bdwHrXdKgEWfAQsVpEA
	W1v/ANGDMYV2ER/VfHnTSESkzbO31VMaza44NjN9n5QhTSXRtkkzS5J0Gt5NxlLPPZj8bNsmzfI
	Y4EHD9WxMiE4XTJLwgjRbaH4yt6l/7wcWiGHT9TWHqJA==
X-Received: by 2002:a05:600c:c4:b0:493:aab3:c09c with SMTP id 5b1f17b1804b1-493c3cf0ef8mr7574995e9.28.1782914159032;
        Wed, 01 Jul 2026 06:55:59 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:6b3f:20f2:ee05:f032])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be4fef11sm72564285e9.15.2026.07.01.06.55.58
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 06:55:58 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] data: Optimise renameVar when a variable doesn't exist
Date: Wed,  1 Jul 2026 14:55:57 +0100
Message-ID: <20260701135557.3607851-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Jul 2026 13:56:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19811

Currently, if a variable doesn't exist, a history entry for the rename is
still created, even if you're renaming nothing to nothing.

That extra data is pretty pointless and we can improve renameVar speed
around 20% in normal parsing operations if we skip it. It will also lower
memory consuption and data store size which will help too.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 110dfa11162..9961269a3f8 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -669,6 +669,8 @@ class DataSmart(MutableMapping):
             bb.warn("Calling renameVar with equivalent keys (%s) is invalid" % key)
             return
 
+        found = False
+
         val = self.getVar(key, 0, parsing=True)
         if val is not None:
             self.varhistory.rename_variable_hist(key, newkey)
@@ -677,6 +679,7 @@ class DataSmart(MutableMapping):
             loginfo['detail'] = val
             self.varhistory.record(**loginfo)
             self.setVar(newkey, val, ignore=True, parsing=True)
+            found = True
 
         srcflags = self.getVarFlags(key, False, True) or {}
         for i in srcflags:
@@ -688,13 +691,20 @@ class DataSmart(MutableMapping):
             dest = self.getVarFlag(newkey, i, False) or []
             dest.extend(src)
             self.setVarFlag(newkey, i, dest, ignore=True)
+            found = True
 
         if key in self.overridedata:
+            found = True
             self.overridedata[newkey] = []
             for (v, o) in self.overridedata[key]:
                 self.overridedata[newkey].append([v.replace(key, newkey), o])
                 self.renameVar(v, v.replace(key, newkey))
 
+        if not found:
+            # No variable to rename so not worth the work in writing extra
+            # history data for performance
+            return
+
         if ':' in newkey and val is None:
             self._setvar_update_overrides(newkey, **loginfo)
 

