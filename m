Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F06E77188
	for <webhook@archiver.kernel.org>; Fri, 10 Jan 2025 19:09:20 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.408.1736536150599962652
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Jan 2025 11:09:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=Cy90bemL;
 spf=pass (domain: smile.fr, ip: 209.85.128.43, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43626213fffso22174445e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Jan 2025 11:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1736536148; x=1737140948; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29mlo2Bz4XHbhFgoshgxOs+0MPjSIMUQ2Q+NNdgK94g=;
        b=Cy90bemLNAExSVTudJvZUUq8O4MJtc9NQ7VQhT3JW0grgZo6R+ZQ5DtquvFa8PUfm3
         proGmB1F9JuOeR18RrRetTDU0t8uNjDhYrstoM0woQ2WEaOjhH3t0j83S2dWFY/H7r0K
         RjNR+GN00Vfxi88is1IcnGApa2ofyzyBhA54A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736536148; x=1737140948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=29mlo2Bz4XHbhFgoshgxOs+0MPjSIMUQ2Q+NNdgK94g=;
        b=ZLn+iKO/yvyWVrsPKdnEcMrWX5hx7rly6OgTT45UB+PJ05FbWsdWbsaXbNeXsNUxDF
         pQCU39wwdLWUhZ/2bLYjaqe2IlYhWcVHyLJyxbc5WWjlHGQw0NnBskMMlIzI7y72g499
         f4fR0/VCZO2I7QwYvUwpK1a47NeaSxIw6tMpI4uxD0NJy+vObeTmC+/Mg4gP4HrdO/8P
         25gBtWJwvG7CMNbKuhrMLKPGamZKsO63A1bVoDtWrHbD6oFBkdIFa0zSQdeZyyoGAc2Q
         H7Gf3GgIOIwHa3wrIwDsCLo8ZceUfL/NT0gJaYnnME4gxKWWdZayTCubLP1mUwypHVng
         3ygA==
X-Gm-Message-State: AOJu0YyT3nms7UJrzSfHs10NNUqMyAy7pagHhHPNLnYrTjAEtjwpZy15
	a0bYOGwj9ByHBXZFMQKQWpuOGLawifyRD+zBljXv8uRWVedUQ0MsrnKLAdy0+4rCiLEYWb1WZk7
	hYqs=
X-Gm-Gg: ASbGncvQRlsFVgz9bhN0WN+NroIwcN4Wgo40gq8/xvbiU5zxqrBKQjotpGFapBhHC8C
	uSLjEXohTuaxbwqjZvswIF9h9K4aRGt8scxS/INtyD6/ahyZDntjGdcv+fPQYwao9yIrtaxisz3
	7ZDe8jBV2RP8TD1HfTGKVc3fGk77VbVgzoJi+eFd4xnW4vaYzfIEXQFwDcBnSXs8sJlfsWMRZbl
	6klytyHdG2SmbVmz97fykUYm6nPYU+BwA7BLk3qdHno00j3CCur9hRNy1qndpENekoz8Z5EgnnA
	io5N/Rya/PhOVGLxUmz33o+/cGpIp3aZMUuF/A3uTCaOG3xvrsMi5usMkpBw7CA=
X-Google-Smtp-Source: AGHT+IGeBXjLtYe8PWWQSUZqRmLbHz3PmTF4hK7EEVQJuRpMboeRmEY1Ir+Xkobl6gCuXcgO2eaMNQ==
X-Received: by 2002:a5d:5f87:0:b0:386:37f8:450b with SMTP id ffacd0b85a97d-38a8b0b7fc5mr7397782f8f.5.1736536148126;
        Fri, 10 Jan 2025 11:09:08 -0800 (PST)
Received: from P-ASN-ECS-830T8C3.home (2a01cb000deef000bdfc82d7e16362a9.ipv6.abo.wanadoo.fr. [2a01:cb00:dee:f000:bdfc:82d7:e163:62a9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4c1cf2sm5275443f8f.99.2025.01.10.11.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 11:09:07 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH 2/2] data_smart: fix ??= operator for variable flags
Date: Fri, 10 Jan 2025 20:08:42 +0100
Message-Id: <20250110190842.3861684-2-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110190842.3861684-1-yoann.congal@smile.fr>
References: <20250110190842.3861684-1-yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Jan 2025 19:09:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17009

From: Yoann Congal <yoann.congal@smile.fr>

??= operator works for variable value by defining a "_defaultval" flag.

Use something similar for flags: For the default value of the flag
"flag_name", define a flag "_defaultval_flag_flagname" that is used when
reading flag_name but no other value has been set.

Fixes [YOCTO #15685]

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/data_smart.py | 2 ++
 lib/bb/parse/ast.py  | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index c6049d578..897ceeb32 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -827,6 +827,8 @@ class DataSmart(MutableMapping):
                 value = copy.copy(local_var[flag])
             elif flag == "_content" and "_defaultval" in local_var and not noweakdefault:
                 value = copy.copy(local_var["_defaultval"])
+            elif "_defaultval_flag_"+flag in local_var and not noweakdefault:
+                value = copy.copy(local_var["_defaultval_flag_"+flag])
 
 
         if flag == "_content" and local_var is not None and ":append" in local_var and not parsing:
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 2f6c6a005..dcc845dcd 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -151,8 +151,10 @@ class DataNode(AstNode):
                 bb.warn(key + " " + groupd[op] + " is not a recommended operator combination, please replace it.")
 
         flag = None
-        if 'flag' in groupd and groupd['flag'] is not None:
+        if 'flag' in groupd and groupd['flag'] is not None and not groupd["lazyques"]:
             flag = groupd['flag']
+        elif 'flag' in groupd and groupd['flag'] is not None and groupd["lazyques"]:
+            flag = "_defaultval_flag_"+groupd['flag']
         elif groupd["lazyques"]:
             flag = "_defaultval"
 

