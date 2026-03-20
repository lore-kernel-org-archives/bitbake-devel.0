Return-Path: <zhangfei.gao@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DDF1098797
	for <webhook@archiver.kernel.org>; Fri, 20 Mar 2026 15:03:34 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15016.1774019011678696311
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Mar 2026 08:03:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=x5Lb+NOT;
 spf=pass (domain: linaro.org, ip: 209.85.128.47, mailfrom: zhangfei.gao@linaro.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48558d6ef83so6757005e9.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 20 Mar 2026 08:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774019010; x=1774623810; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMrp1sC9cvPAua46zgYQGqEZX8VTCeuby5c8Rw2WTGo=;
        b=x5Lb+NOTHjcgUNED0HB9dCQV4Y/DNyywtVX5TFW41Xmd7vOv1pXwqGB0VKNQXnm/Nd
         4DqqtWRa8Pcix6orTrXrf9NnCbIxLL9n+X/01fKyLGscqJDcBr0X9pPdAkOavggQOEQz
         Z8jABYKZkDHVjMdLygoVIF1+CyPVVxb/TulFbtgqb8dasyBBiqb//DfRrR+EsBZD+Swc
         wCgSj7+9LpQeaDvh//lciSx8eZo/M/78XkBDsHnJsEQl6NuVfl6sfVueRDL2OWhz6OlH
         /UQSMt//Fj3M/QhMqWEX29pGUS7pRgolVYSDbaU5qUdOUyrme1qiMwjBlTtMKu1vKLSM
         vXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774019010; x=1774623810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vMrp1sC9cvPAua46zgYQGqEZX8VTCeuby5c8Rw2WTGo=;
        b=niXUyM1sMuID/WBsqqdJrjqRJVsfBXL80aGXoMj3he9az4gUF7wL6X6FxF4qQDVF/l
         fZIvYnJQtLtUdX1TpyJ7Ki1EeV0V1SMb2OkfmXfGRq8CPINeP2doeYj8iA+GYRGM+1ga
         JeN6Bfxe111Zt2s332tN2QU0ffYW8F49rsqee8qMunlhyx1oFi4zKwPCi34J2jVF38xi
         OTYtVLfdQO2BCpVFxzIVAcfxuDGdYnwHHTzWwmy4HvaAA2Tv2awWitv9oHM1em+xHAVJ
         41g/tqMGgDCWTG1vNocUKwJQcOQRNNn3SwAU2QMdvQvolTwRQrDsT6wodIsIGalnynyZ
         ntVw==
X-Gm-Message-State: AOJu0YxOnPHvDObQgpB1Pd7eciXvKnan6C2u2c+1XCFZQYI8Ku3/sdNS
	G7DdEUSMEAoxZQ8RCdqti5byrqZMgW7G8tkGuIWHgwAgy/h2KgeHIcuXue4Km2G/Y6tpBWkDHAI
	jBAzd9+XNhg==
X-Gm-Gg: ATEYQzw1JYOwogDDeArXKuOo6k652wCi5F1TGriOrqdd/bqHVGyPB5bwUkT8F2U9lwe
	/CHAT1QwlL0ow7rYNtPo5NAMZj+3VRBTbxtSIu+CabzsRrldkCb0hz4VqWX2T+C6wjekwZI+aqC
	6P1rxOwmCn5XnuJG2kFI5Qf5ADzcxTHW+0wIqGMBtALQMxk8ywjY0edND/oKwqFnRab8J/jw6LK
	FmMntnAIxLyiy/tMf3xdRaGJwlsrnFXYP8SRpYghxWMwZVHpJWYRR7ioNCKnZTd3Yx0+Y8Ldrvk
	iWgvTWgZb501DPED02X2IhH8nx6dm90lV6jN9XxSr+kwlK8vMqBkmdg3y0ihiKg85DUnADE3USh
	kO//IK1Fs3V2EYZ82Q7ohpKEXec3fehnvq0Mu3GCpTNxEfrWihD2m+tgM6Olf7bFJGs0s0QOyYR
	Mel8AFmRppzErUKq8KvxF5077mU/PEZPYw7mJd+pB9Xu+AZWk3RxCm8VI/bFaNp58N1gqSsKaz
X-Received: by 2002:a05:600c:8b25:b0:480:6bef:63a0 with SMTP id 5b1f17b1804b1-486fee0d8cdmr57888645e9.21.1774019009594;
        Fri, 20 Mar 2026 08:03:29 -0700 (PDT)
Received: from hackbox2.linaro.org ([2a00:2381:fd67:101:f4c1:e8ff:fe8f:2fb2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8b322d9sm132096145e9.8.2026.03.20.08.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 08:03:27 -0700 (PDT)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: bitbake-devel@lists.openembedded.org
Cc: christopher.obbard@linaro.org,
	Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH 1/3] bitbake-setup: support bb-local-conf-header injection
Date: Fri, 20 Mar 2026 15:03:10 +0000
Message-Id: <20260320150312.1243270-2-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320150312.1243270-1-zhangfei.gao@linaro.org>
References: <20260320150312.1243270-1-zhangfei.gao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Mar 2026 15:03:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19192

Allow bitbake configurations to provide local.conf content through
'bb-local-conf-header'.

When present, bitbake-setup appends the provided value (string or list
of lines) to build/conf/local.conf during setup initialization.

This helps projects carry machine-specific local.conf policy in
configuration data instead of wrapper scripts.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 bin/bitbake-setup | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 9d08f3a1b..edb8c4d1f 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -310,6 +310,15 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_c
 # layer fragments from changes made here.
 #
 """
+
+        local_conf_extra = bitbake_config.get("bb-local-conf-header")
+        if local_conf_extra:
+            local_conf += "\n# Added by bitbake-setup from bb-local-conf-header\n"
+            if isinstance(local_conf_extra, list):
+                local_conf += "\n".join(local_conf_extra) + "\n"
+            else:
+                local_conf += str(local_conf_extra) + "\n"
+
         with open(os.path.join(build_conf_dir, "local.conf"), 'w') as f:
             f.write(local_conf)
 
-- 
2.34.1


