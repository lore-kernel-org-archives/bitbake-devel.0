Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D211BD29FF1
	for <webhook@archiver.kernel.org>; Wed, 14 Jan 2026 11:34:03 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7993.1768390435617854911
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 14 Jan 2026 03:33:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Y94K9GkV;
 spf=pass (domain: gmail.com, ip: 209.85.128.51, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47795f6f5c0so53810815e9.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 14 Jan 2026 03:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768390434; x=1768995234; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gnX0uFAvmn8tbc/lgcjjmad4X754XCqVK2WUEBX2UmI=;
        b=Y94K9GkVMibq0olPC76XZdOOEA9ph7gIB55iaAL0XfR/ANLj3oD4SUFLTZfDfkB468
         ghuudVcz2754dngXNrFJqXVi1WNjgXdVyituekoifNLRAvE3LoKRgl0Gpv4kKwIVIRQb
         2FURJe8C9r00nFYZkQSCr5MG1mgEzpovw/2tgCHh4bSovtvxeRs4c3fgHN6TATR8dMdA
         bbMkk11+DpMnOVKNP2VAJpbTqNLrw0U7RX6vnL6qIzs4nKTFfQjIWlTsx+UhQ3aKk82U
         HOXmLJ1ucZaPG/Zdd1NgiBjnCdYVffY+FP5InLdBSbKQq79fIV5YdBxwOeMLed23lYFY
         HlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768390434; x=1768995234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gnX0uFAvmn8tbc/lgcjjmad4X754XCqVK2WUEBX2UmI=;
        b=OfZLr8vwJeCTrkJ7VnLEfNsAd2FHz0rcUOUxhe9XJxxuph/eaoNuVaJBPi0DPAHXjG
         uG8fsQOClOBH/RyrFmXUgJq5TjtHc6yJTDjK7l1kPCSjWZ6RpyYnUVNMmMx21qmVcZq9
         CvrQxLChHnX39Z+ypMiKVwVfqzRsRTucjsPIzrLnUcatRbYuFcgk0ayAtmXfJD8Lf33l
         CcQ36tht2wCJdXsk26V5nJqtvtlrxrI9wG7Ref5s9oKp+DhctFAtxxUpE3HkqdUJwx28
         p9ul7tS5ED2wk+IfL8O3lb9hstrq+7wvWE+ULAIrv9boAHD8GqZNV9bF2lXj5B2b/JQd
         foyg==
X-Gm-Message-State: AOJu0YxEFh4nF/lj5e8uB3cCYWdGCYqj/R6OijXL8RyKh7Yj6NKLyAxk
	2ycNUGonTOS6L9pQWVUL7NxKBEUa8Fqtphh6NCNXOfs6kEgWcWOJ2oPXHbt3fLiU
X-Gm-Gg: AY/fxX7pjDqLWhPhMFKwz3I2dDfn945H+Q+BmMXQaAxWm5epnGjLgzoeq/jjDwynp1P
	9iMkN9/Fu7xkN51jvOVBEuzmO30Dv3Xwd4voaQGO+MuL7MWieYs5WDU4anKIkHS/nmKDJP+NhFM
	MHjPCikVsodVdPyQw6WZFZ6PZy4s9PAfANzbCzfMjE9efauokUR6XV2xIUeHco2Rmjc8rB8QX/i
	zUP4W1+FHKWq9GC9E6airoQebCigTxBW8UMOjds2vGzdFVD98+7ewYioki4vWA4ahNrwwevj8iy
	Pte6uEr9VJUWopj4mVkdZpZKyflraGvNUe6lMD/IMPSzZJHIupQxxqJm1MALLF/FOaIhY1En5X2
	+eTugyCcZfZycvsSN4KsOhdDB8PNCO2UCee0dpFxmtPwgkM42TljWL9jXBOPvSe1J7iXuUjjGky
	LSErHYZ1GQ6oMt/7J2+Y8vpRnmgkFfAEaOMk4vyyJuMIGz6+c=
X-Received: by 2002:a05:600c:3544:b0:479:2f95:5179 with SMTP id 5b1f17b1804b1-47ee335494fmr28564935e9.15.1768390433817;
        Wed, 14 Jan 2026 03:33:53 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee28567a8sm17417655e9.17.2026.01.14.03.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 03:33:53 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH v2] bitbake-setup: use internal registry if run from git checkout, bitbake repo otherwise
Date: Wed, 14 Jan 2026 12:33:48 +0100
Message-ID: <20260114113348.2991476-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 14 Jan 2026 11:34:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18752

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
 bin/bitbake-setup | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 2c2b6d8ec..4ed06fc62 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -21,8 +21,6 @@ import signal
 import functools
 import string
 
-default_registry = os.path.normpath(os.path.dirname(__file__) + "/../default-registry")
-
 bindir = os.path.abspath(os.path.dirname(__file__))
 sys.path[0:0] = [os.path.join(os.path.dirname(bindir), 'lib')]
 
@@ -37,6 +35,17 @@ GLOBAL_ONLY_SETTINGS = (
     "top-dir-name",
 )
 
+# If bitbake is from a release tarball or somewhere like pypi where
+# updates may not be straightforward, prefer to use the git repo as the
+# default registry
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
 
@@ -1084,7 +1093,7 @@ def main():
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


