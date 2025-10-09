Return-Path: <bhstalel@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CCACCD184
	for <webhook@archiver.kernel.org>; Thu,  9 Oct 2025 17:53:18 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.6997.1760032393854822929
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Oct 2025 10:53:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=g3ndSHcA;
 spf=pass (domain: gmail.com, ip: 209.85.128.47, mailfrom: bhstalel@gmail.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e34c691a8so2346205e9.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 09 Oct 2025 10:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760032392; x=1760637192; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T1zDwKEMsz4eTa5YLqV36gZr/qF8SmeloiqOrR3aTx0=;
        b=g3ndSHcAYDZ7+dSzV9//u5U/tKNKBzrE+2jXvmgRQQCgmVdrP5gsmqEeK7mQiP59L+
         7fusTKma5Wib8x6WWGcYl3nLKBvwHjZMDKYqxhtn4vUTG3drUyxkzCUH2NyNrhRI51+A
         rlj98Oxpjb68r4dZmBymCCo4srB/2r+q7kElxzu8pGV4+WoBV7dIyOjcTzV+QkUWtFsV
         KF+N+xs49a1wreVGMqjrp7OLT8MBPkiX2lVVJFTNK8tjMNukK4htrQuka+Vf/s+njD2Z
         WrXwsaBTbYLLSBuMAf6a5joWWp28tSpZrGRr0fqX4VGcDd+Estdm5T1JDlPc3mqgG6ib
         4OUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760032392; x=1760637192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T1zDwKEMsz4eTa5YLqV36gZr/qF8SmeloiqOrR3aTx0=;
        b=dEp4gu8f34HHz4IVxcLL9ECB3R+DPVCdV0vjHu0xc59kkx0RIRsgWDU7ojIRcM3n6u
         AUfRmysmZtmti+5AQowFaIAL8FNVR27NYsxRe/+GHMXayCzyUUHWfYMmjc2M941+k9Q8
         LSEaS49fcABaHg/W4jf5Ycv/JpY4+e7+zrO4eX57M4byJCfORFOLs2H5U+TgwsnggmwA
         0Epm2kqMdir/xpGFPLXXgoa0gzjK6uSGYArVV3f32u5ItwxCLKidoOPttxq4/kcZtWXA
         5dTyMvLYRaiNUNeq2uqJXWAS/fS1C5eL+Irmi3uaIcIrn7amrYd+FNwHMHztUxgAHMyc
         8kpg==
X-Gm-Message-State: AOJu0Yx3fGG/Ga9VzCmv7jIGiEyIdYOPPy/9XiU5j0vv+5mjysU7WZfM
	jp7sgq5GkQnj4dJDC+B/QDj+gVa7ueTNbbG9yoevg9mHegtITo62eC+zGT/gYeXr
X-Gm-Gg: ASbGncsxr1e6F9kuXWgyDLQYNAl4GZiC1jBcyqwtAUnLxd0+obakQ4rKGguK9umkOfC
	kB0m07bsQE8P7dChxjQEusywGwUXxTSWZlY/h3EM6N51zKrhjmYQsTmlZfUEbSLQfoM9tS5a9VG
	a8bhBWi+bgtIz6M/hqHrz25kbxj41DspKMFKFUMJ4OgCCPJ8aDS6K2nXutTltsX4aTbyDNYJXiW
	jougKpJGzm+cG1J6gzAEf+6Dnr79i1HqtKSEBNAq22uRitg2bwAmkVvHyFmslWM/E7gWMuhIG/d
	rot7DbdoU6l7laL0WSfoZSADgPELf5JWYzaMQAtJqLD4geg3+WZPgS2RzfaOHCSz/YzwIm2x1pL
	oflOV0gO3smwPJddq+tROlho0Es5iMyei3S5nQrtJNCF0r4dqtwm5
X-Google-Smtp-Source: AGHT+IG34dU3HMzeOfujqinoRzHsi365BRNfMQrG0lbvtQ3+fdtqcrKdqgFekn2P+xAI5Frt3Va8rw==
X-Received: by 2002:a05:6000:2c0c:b0:425:6794:f19b with SMTP id ffacd0b85a97d-42666ab303bmr2785193f8f.2.1760032391898;
        Thu, 09 Oct 2025 10:53:11 -0700 (PDT)
Received: from techleef ([196.176.30.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e1024sm114169f8f.42.2025.10.09.10.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:53:11 -0700 (PDT)
From: Talel BELHAJ SALEM <bhstalel@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Talel BELHAJ SALEM <bhstalel@gmail.com>
Subject: [bitbake-devel][PATCH] lib/bb/data_smart: add removeFromVar method
Date: Thu,  9 Oct 2025 18:53:00 +0100
Message-ID: <20251009175300.7480-1-bhstalel@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Oct 2025 17:53:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18156

Tested with:

MY_VARIABLE = "foo hello foo world"
python () {
    d.removeFromVar('MY_VARIABLE', 'foo')
}

$ bitbake-getvar -r example --value MY_VARIABLE
 hello  world

Signed-off-by: Talel BELHAJ SALEM <bhstalel@gmail.com>
---
 lib/bb/data_smart.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 2e0d30858..554255f3d 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -714,6 +714,11 @@ class DataSmart(MutableMapping):
         self.varhistory.record(**loginfo)
         self.setVar(var + ":prepend", value, ignore=True, parsing=True)
 
+    def removeFromVar(self, var, value, **loginfo):
+        loginfo['op'] = 'remove'
+        self.varhistory.record(**loginfo)
+        self.setVar(var + ":remove", value, ignore=True, parsing=True)
+
     def delVar(self, var, **loginfo):
         self.expand_cache = {}
 
-- 
2.51.0


