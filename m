Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56123CCA471
	for <webhook@archiver.kernel.org>; Mon, 29 Sep 2025 12:56:45 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
 by mx.groups.io with SMTP id smtpd.web10.53023.1759150596925512677
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 29 Sep 2025 05:56:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=TuByk20f;
 spf=pass (domain: gmail.com, ip: 209.85.208.41, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-62fc0b7bf62so6848802a12.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 29 Sep 2025 05:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759150595; x=1759755395; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bLTUF9/N8IcqeBSQC3/AqZ/bOhiF23/H+MqoNOhb0U=;
        b=TuByk20frCzlqLLgdq3pPt+B+4/W2OyWTZLYQZnYcnIUq585Dx8BFA4j+L0CZSCzbE
         RWMKgBQcPs2DenZRhVeqwdRXP98jnb7ZDrmg8bfln/eBSbekzYfruxx2Un+xTKTUezXa
         K0iFabeV/xwy1nxUSdysJDDjU4rny99gnIW/Pbc4pkpWl9Xxwg/aP40gVuyCAES0ccTd
         FwaTmScHZwZIRimDzTLVsA+7VIvST74jbWz95YehQvneJ2oPKTLEhsSHALfgwE8DBpOW
         oIksmbhveyhQaabC5Gyvz3uGl9FwcQFiNbq286eeWBEU0NmUvz64hqY4rwfY+aZ0xIk9
         LreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759150595; x=1759755395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bLTUF9/N8IcqeBSQC3/AqZ/bOhiF23/H+MqoNOhb0U=;
        b=IibvBMWS4px4I2O33ZbL6fej/3AROrcUJhNHc70e2bhXJoy91SYzlsOvOPUEGtOKIW
         7LxwFS8aeL0/xzHUFJR4wws1sRmYD21zkBzYDJJQ/yizxcstjgTG04gNZty9PmHNf0jE
         +ppYnyR3EfiuRoyMVlbx1nFHnY4Ayi4rvbnOgT0eYSRgpneTzpZiUMs80JWAbFywSIA6
         Xck0ygVZof57ZFSYccI5TferwhH8oF6pPVc/vPoXzroLr/t+rixmA+hgoh7mEIyMYVSJ
         JPrUdU0nhPEi5wjXX1cbaFLn4jq3Ml9SOhQqaE3Qo6d8B9TqOGzSWuvhIUcMEbdncMwY
         ZA7g==
X-Gm-Message-State: AOJu0YxRLeb0+v96VKEmegLeLvBQ9mhhN9GyHl2459qT01LnLKQTRgEV
	wF6DzULUIKEtkZ680vQ3JZoia2xzDOGJJwQWg5FSOZiCpoyetOgrY+W8dXKvaA==
X-Gm-Gg: ASbGnctdmQbQfJ1zkQiTxr1FwkaikVcqaUu+kH1qrVoQBAEC591+bbcaF7PhFrgJIcd
	gWhf+JOpYlcxAvN0po3/a/sWLpWX9KIYAlSbaii2woVafeI++hax0SVzxbQveMFuIlTDRAfGdlz
	X7VIJr3QDnuqCxvF5ItwkF3O/BRBZfMdjSjQxvczh/h+++j72RRCEftQ2jtYeDSeGwO6Uk1G2ul
	ZdewYjwruerWupNWt/BIGDrkgBIp7NxlDyBA4AEbMZS5PD+Awb/ZyQ2jfZF9v12s1aPmCmTSr39
	xVCnJoU6FdPCa25fv+mGA+B95e3L0ByVbbqVWhc973GokappDuL/m7DJ/uZYgWY9WjPRSCclp3g
	ACo0riwYVJLKR7WMFk5vWUA/sjNVhX4jwRZKWeUf5SDzkvDaiC6vIAmB+RANDYssoL9s5EiUnDu
	Xc8xtNcnhnvpGhmmjndlUaso8xDXoUZLXt6oStjUXpzJo1B6eqCAEybvMXCA==
X-Google-Smtp-Source: AGHT+IHt6V6JM8ANQzt6dPflrLmTP8VBrwuGgKGzNJ9tgO8TuDZCMnTlKWTC3EMMgCc0r51nB3rR4Q==
X-Received: by 2002:aa7:c147:0:b0:617:9bff:be16 with SMTP id 4fb4d7f45d1cf-6349fa79a44mr12695366a12.22.1759150595146;
        Mon, 29 Sep 2025 05:56:35 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634b46dca59sm6575915a12.8.2025.09.29.05.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 05:56:34 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [PATCH 05/10] bitbake-setup: Allow local registry paths
Date: Mon, 29 Sep 2025 14:56:11 +0200
Message-Id: <20250929125616.1751116-5-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250929125616.1751116-1-alex.kanavin@gmail.com>
References: <20250929125616.1751116-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 29 Sep 2025 12:56:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18104

From: Richard Purdie <richard.purdie@linuxfoundation.org>

It is useful for bitbake-setup to support local paths without access through
the fetcher so that internal data to the bitbake repository can be used as
a default.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-setup | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index d6509500d..b07bf2eb7 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -509,10 +509,15 @@ def do_fetch(fetcher, dir):
 
 def update_registry(registry, cachedir, d):
     registrydir = 'configurations'
-    full_registrydir = os.path.join(cachedir, registrydir)
-    print("Fetching configuration registry\n    {}\ninto\n    {}".format(registry, full_registrydir))
-    fetcher = bb.fetch.Fetch(["{};destsuffix={}".format(registry, registrydir)], d)
-    do_fetch(fetcher, cachedir)
+    if registry.startswith("."):
+        full_registrydir = os.path.join(os.getcwd(), registry, registrydir)
+    elif registry.startswith("/"):
+        full_registrydir = os.path.join(registry, registrydir)
+    else:
+        full_registrydir = os.path.join(cachedir, registrydir)
+        print("Fetching configuration registry\n    {}\ninto\n    {}".format(registry, full_registrydir))
+        fetcher = bb.fetch.Fetch(["{};destsuffix={}".format(registry, registrydir)], d)
+        do_fetch(fetcher, cachedir)
     return full_registrydir
 
 def has_expired(expiry_date):
-- 
2.39.5


