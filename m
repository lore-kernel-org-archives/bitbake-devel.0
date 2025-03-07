Return-Path: <pmi183@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EF6C282DE
	for <webhook@archiver.kernel.org>; Fri,  7 Mar 2025 10:33:58 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web11.8170.1741343636002924393
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Mar 2025 02:33:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=XSXlL+og;
 spf=pass (domain: gmail.com, ip: 209.85.221.43, mailfrom: pmi183@gmail.com)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39127512371so1043894f8f.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 07 Mar 2025 02:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741343634; x=1741948434; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RgIbSjmaet9EtzlbeavUtiEjsGZoLMXThSsSNHsxdfE=;
        b=XSXlL+og9Jd7XgynjsBelc/m9vrlbRW6zUPdZq90+YfAdL/aFccLlZ6cNRCdoWxGlI
         4Mwv7q8hj7k4Eyg5BJI0jWIclTSkXjHyOLJ7bpelDL9HxgKEXv0OqeiA1eoODrOTezSK
         2v5lITdECLvNrFOOPPcWF1OySSW/X2MfTs7BhX9Kjz01NsmCyJFzqDyhMIkQ5RzvUmSR
         l5Y2uZnFELbnOfyu/G41azCM7vPTurpy8iafyk1yqjR+LqaaiqqIVfvVccHYDO2T7nY7
         bknhpOlZC6q4JW6rISCz5D06D7z9R2FJEocyBPOvvZ4bmKLpvYCRL4BMNOoBD32Jee9K
         KNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741343634; x=1741948434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RgIbSjmaet9EtzlbeavUtiEjsGZoLMXThSsSNHsxdfE=;
        b=FG2XoPHkJNB7mWJ3lpBFZzYulbAlVlrgZWYP4aIgQr+ed1srkWHPgnKjiKKZF3wEfZ
         Edh/bqDZ3jtW1HLhcYeag9pqdbMFFq8sQWXHxMVswIDL9p/4m/7C6SmK/MbCMoLHWWFe
         LGrtHw+08FnHTPPuy5Sjx+M/B4HnrtRO6OrgM7CBvcWAijhjdzLB9DD/lAAGe2nry20G
         /qdjOMNIlZFgghk0izac9I3ue70slU5vd2qFeu1KKFFG9/7+6hK2crM0+MEw3zcT8Rul
         akAhKZTAAfLxK2MkCdRUi4wNkDzTrZBlguYzijIIZ32cpENSBamyjifxG5HWb0HGql8s
         LEog==
X-Gm-Message-State: AOJu0YzHQKFTtulKWmEEjEttGk+CpIZyW1mMfTqrtsbm2mTAMLa8yZeS
	AKbYXCwvxQgbyv/l6ao2FDlAbPAPgreRk1+iAUloP/AfgWnEM1CsggWxNw==
X-Gm-Gg: ASbGnctDb0g64IF5dxr9Rhs10HIUnzDls0vl7xLYg4x+NkpEK/fCs6MJIrJPPUnHuer
	qXObkzat93gzUlJ/K89OGoYXyEVXu0SZSbgMaLyqoRZv299YXpyydtJmkQvgT0G12qFFHV7UGdD
	+waTahtwj2bWvmCD3uD2kLqqpMUado/+ZxR1WjFnIxFrAUWSHVTDSu9NvfNnyT9tzjyUaDhoaoX
	NaJjTvwma64OZHzmdevKJRsdzdd3ZXWC5WLGPVAymn91i2gBFSkUh/QRmVnaI0Cj8/rJpAXKZCb
	HwkOlFofHWy23WMGeyov/QiYdHT0Jsu5u6oHhB0taOcT2c/yeCsPlRsHcgQEHovd68fFgajPWEw
	=
X-Google-Smtp-Source: AGHT+IFX5GR6IfBCIMSUrM757EWCLCq3dtgr9gGgNdOaG6uAa2SnLbJ/AKqev1BTrRv4OSA66qB+RQ==
X-Received: by 2002:adf:8bda:0:b0:391:2eb9:bdc5 with SMTP id ffacd0b85a97d-39132d8dc86mr1395758f8f.23.1741343634150;
        Fri, 07 Mar 2025 02:33:54 -0800 (PST)
Received: from LAPTOP-0FHSM1V0.criticaltechworks.com ([78.137.195.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c10437dsm4998248f8f.99.2025.03.07.02.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 02:33:53 -0800 (PST)
From: Pedro Ferreira <pmi183@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Pedro Ferreira <Pedro.Silva.Ferreira@criticaltechworks.com>
Subject: [PATCH v2] codeparser: Skipping typing when inspecting Python modules
Date: Fri,  7 Mar 2025 10:33:51 +0000
Message-Id: <20250307103351.374456-1-pmi183@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Mar 2025 10:33:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17400

From: Pedro Ferreira <Pedro.Silva.Ferreira@criticaltechworks.com>

If a custom python module is added thru BBIMPORTS and it
uses typing(Any,Tuple,Union...), codeparser will fail because
inspect.py raises TypeError exception if the object is a
built-in module, class, or function.

Signed-off-by: Pedro Silva Ferreira <Pedro.Silva.Ferreira@criticaltechworks.com>
---
 lib/bb/codeparser.py | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index d249af326..4bc6adbe4 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -72,12 +72,20 @@ def add_module_functions(fn, functions, namespace):
             parser.parse_python(None, filename=fn, lineno=1, fixedhash=fixedhash+f)
             #bb.warn("Cached %s" % f)
         except KeyError:
-            targetfn = inspect.getsourcefile(functions[f])
+            try:
+                targetfn = inspect.getsourcefile(functions[f])
+            except TypeError:
+                # Builtin
+                continue
             if fn != targetfn:
                 # Skip references to other modules outside this file
                 #bb.warn("Skipping %s" % name)
                 continue
-            lines, lineno = inspect.getsourcelines(functions[f])
+            try:
+                lines, lineno = inspect.getsourcelines(functions[f])
+            except TypeError:
+                # Builtin
+                continue
             src = "".join(lines)
             parser.parse_python(src, filename=fn, lineno=lineno, fixedhash=fixedhash+f)
             #bb.warn("Not cached %s" % f)
-- 
2.34.1


