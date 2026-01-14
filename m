Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FADD31A24
	for <webhook@archiver.kernel.org>; Wed, 14 Jan 2026 08:04:42 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5842.1768377875201983163
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 14 Jan 2026 00:04:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GvT08UIj;
 spf=pass (domain: gmail.com, ip: 209.85.208.54, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64b92abe63aso17535260a12.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 14 Jan 2026 00:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768377873; x=1768982673; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAvPnHnkZ0iCNooS1yk6/tSmdDl+446HsWS6PyTYWOM=;
        b=GvT08UIjDYH+jIGF50UgW4yuDDLhXiUKWK6yn8JC09IIm22edTznkkea2KsJnA4KAu
         lrvM7WC+G0G9M0zkSbOyuWkbIDo/kqN12dv9wBTSqpkIWXxunKy92T1at79ng3M7LdCC
         Qlc3zKXHUKu2EWXaqkud66uVNxfzsGdntl6dudGZ6EChsj0i/hzvjI9uW1O/kZP4I+L/
         0WXohRdTx6vnBGvBvFF95avDJaXsGOdtUnQua2qthPA5bR4FLTLmv0B4q/d4DNVJYkxh
         sFoTq4bufwlDjg1x+6FEBD8jPorqF1Y8qkbPZ5YAGwFjfKa5sXf3lF2kNzi0QR6mziyc
         wvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768377873; x=1768982673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZAvPnHnkZ0iCNooS1yk6/tSmdDl+446HsWS6PyTYWOM=;
        b=CqDI/S9daaTIMsJIwnczyEnXItflzzMAIa2a4W+0I+ZU+KET4TkaWCGEUSQfftdfO4
         Mlsg0GJc4Tb53r7b/YTiHu+wgzjtJk2VDgdrwegFu1fHPcqoLQPuQlYIGG/MwFX220I6
         WCk4DXNiTL6SDAw15VAnMxaSvl4uG5QDTLlylQh3H+ZWwcqYvTj50OBEgbKje+Iz03AW
         +7kZ1agjn96PvW//lGAxitmIIVGD9Lp9mR5KY95wABVB4deoB2nZ1q6hUVtIcAciDvyw
         7HcWWmtXcXdAoouSD/viTbYW4pcF/LbGbuXukithle0UFA8z3Ge7Jq5aliTnJzlFUftr
         /0KA==
X-Gm-Message-State: AOJu0YymgPOqVOs5YsjrQXskyGFMwOhcz5DXWeIczctNF0asTsAMiYzn
	RbP1bZlknSTD2A8sYEm+Ax6/Dq6vAPURlLHidHuJGozQAN9rekTTrxxDywJwxjJi
X-Gm-Gg: AY/fxX6EYyMHihmGOVOIim+m4i/PSNrpVEF0CsxF97z32rGoNb0FjX5C7N8OSB30q8y
	pml4xOzXZtVf1znsJLq0ndSrJRFvrt/d3zzB17mBCxAyci6anYGcv7zcdHFR6444P8bbLNYRYCI
	H4PblbWO2hXvA8f/ogYU5o67Y72s7cqA9UAPrW1dalXjMRPvFLpQfOAZw6W2RacV2Sku/eZ5Fb1
	JWpYzfIAou7GnbUa8IG2JziJLhlAt5oVocmihJ6H9UwIDBSYu/AM9ITtS33w5iONNI5gQzZt1//
	n1jl1p+IjprE+So/qtiKBoZx4uURMhd6rUIoHdgjSTvDuXctrs2Vp4iylZC6yMxSI0RF6C5sxTF
	Ci6bfSPT7agRRufd/iUVK2y+vvbsJkTDg6s7KWk19NHd+zOQu8XoyI3NbOZT/ajodF5Q5+hjTef
	pUYQ4G8TtKaKfSWtq5A87MLkec2VzyjmsJ1K21M/2F3JuSKIohdATvPOWKmA==
X-Received: by 2002:aa7:d898:0:b0:653:9849:df10 with SMTP id 4fb4d7f45d1cf-653ec459ebamr920971a12.26.1768377873072;
        Wed, 14 Jan 2026 00:04:33 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b9eb402sm22098574a12.15.2026.01.14.00.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 00:04:32 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Rob.Woolley@windriver.com,
	Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] bitbake-setup: use internal registry if run from git checkout, bitbake repo otherwise
Date: Wed, 14 Jan 2026 09:04:14 +0100
Message-ID: <20260114080414.2927046-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 14 Jan 2026 08:04:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18748

From: Alexander Kanavin <alex@linutronix.de>

If bitbake-setup is packaged and obtained from pypi, or another package feed
it needs to be able to find standard configurations. It is not impossible
to package configurations into some location inside the package
and add logic to find them, but it is much easier to just fetch the bitbake
repo and use that as a configuration registry. The other benefit is that
such packaged/installed bitbake-setup will not have to be updated in order
to obtain latest configurations: it will simply check the registry and fetch
them as needed, which is the original intent of config registries as repos.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 2c2b6d8ec..dc0c4b1c4 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -21,8 +21,6 @@ import signal
 import functools
 import string
 
-default_registry = os.path.normpath(os.path.dirname(__file__) + "/../default-registry")
-
 bindir = os.path.abspath(os.path.dirname(__file__))
 sys.path[0:0] = [os.path.join(os.path.dirname(bindir), 'lib')]
 
@@ -37,6 +35,14 @@ GLOBAL_ONLY_SETTINGS = (
     "top-dir-name",
 )
 
+def get_default_registry():
+    internal_registry = os.path.normpath(os.path.dirname(__file__) + "/../default-registry")
+    git_registry = "git://git.openembedded.org/bitbake;protocol=https;branch=master;rev=master"
+    if os.path.exists(os.path.dirname(__file__) + "/../.git"):
+        return internal_registry
+    else:
+        return git_registry
+
 def cache_dir(top_dir):
     return os.path.join(top_dir, '.bitbake-setup-cache')
 
@@ -1084,7 +1090,7 @@ def main():
         builtin_settings['default'] = {
                          'top-dir-prefix':os.getcwd(),
                          'top-dir-name':'bitbake-builds',
-                         'registry':default_registry,
+                         'registry':get_default_registry(),
                          'use-full-setup-dir-name':'no',
                          'common-sstate':'yes',
                          }
-- 
2.47.3


