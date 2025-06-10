Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31326C5B543
	for <webhook@archiver.kernel.org>; Tue, 10 Jun 2025 09:44:05 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.83217.1749548634686899091
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Jun 2025 02:43:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gP7+s1lR;
 spf=pass (domain: gmail.com, ip: 209.85.128.50, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-450cb2ddd46so31574685e9.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 10 Jun 2025 02:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749548633; x=1750153433; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MpUVzKEz9LIFxZfQILDHp29aWYfPwF/K+7Fq8Hw972s=;
        b=gP7+s1lR/TVSsmWZ7dmZnWJwLbk8g6aEwtgK/Hn32Rrr8XbJWfJf08EhZvfLOiHG8a
         OJozqezq6T7CBr8HXgf/wFVqRdNZQ8Qtq1SgnffVNUZdeZkcLoy2RUlBToYQ8ZNI2xF6
         +vIf30/2nFrzV0fp8a57Y1hX6CzGk1MAWTF5aCVLP5nOR2gW3b2e1TomakOFrRM2ZaWC
         ElV8820PjuJeVk8HQchX3IxYo6L3AszZaRa1feiZ3Cs5Y0cRhGfBWZ0Q42TWIJRVssr+
         VsLCS8vwhxnIAC5o9UBTvMduc6RnoodjUUG9fabndTIqQqqP5P0uBziVLvKYMG0O8oEp
         D0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749548633; x=1750153433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MpUVzKEz9LIFxZfQILDHp29aWYfPwF/K+7Fq8Hw972s=;
        b=Tg8TsVTO0PkopP3hPr5wfg4v05/xT6cqJ5S9Bj8gTqhtazoxgmKKx4Bcgk5REM/EGg
         G48b0GrPqiuMowh5S+Uoh7GdbsB9M12/ZJ5fipf3VMoZDBm+i6jB8Onzyzs6p/kMcA54
         zcc82AzuSoJlIhs9fyAoOMR0VMCqXz4x23WBiFjS46631fHtcdtsODVaVYkBVKUyfCbb
         aFnc4hthlbpQWyCCrH7ykJXzEmpifV6SpUmHR61VPvb1TxudfjV8UN6r+UAgryrrqljc
         Qe3pzW9ZkCIlWvp9z9ZYv2aASL32wNZizlMRExk43mu/oR5BeXKB+IOiDoFfBi/ATRyD
         VXVg==
X-Gm-Message-State: AOJu0Yw/6QmXq31k3jOxvMJAKt6av40Lt4KBLmH9CXsXUSyDab6runvi
	i4nTEF0ID0J/6wklezy2CDMWyWBlsRhFHj8Dapz5sAkXYb+iR6VAviVSsbkBbA==
X-Gm-Gg: ASbGncsRrUu5BZZJMRTWkikVMLNJMp2HYtrgI+HqOVbllfzK4reDslrsqMHSYzIDSAg
	NoHUQE666BD4gQ5etxquDh2h6nQXitHBuQlfKJiCYU53imAEVjs6uLMbLki9GUmQsQffkLXsQhO
	GvVVzZjx9/ziECDDvZXgnoufonQDFuA+FlDPcWIfDJJWjAho209K50ls7Fx4PaoEZs512199OZd
	QLkn4tbMS75z/R6eSjHugf5ohjsxgPIHX4G3k6PJm2qFiKhtjUELef01XjpgQBO7gKlClHVdLo3
	iQzYNcdJwZDWReoTtYLHCrQHDu9c4ozKsafN9oqmAwDBqXQLnDFFd4NwM6p24qFCrr1LLoKZgbe
	xUkSBAu2sEbN8EqgWJ/Pn/6+5Ty0/ZaPCkA==
X-Google-Smtp-Source: AGHT+IGw0LID24Et24N66CMw49VnyPP5azkEgZkXXD3HPeMQ9BrofhYR1eiu4oYpQdwS5qTQDYiLKQ==
X-Received: by 2002:a05:6000:25c7:b0:3a5:1f2:68f3 with SMTP id ffacd0b85a97d-3a5522bf87amr1529983f8f.46.1749548632778;
        Tue, 10 Jun 2025 02:43:52 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45307b9d827sm87998445e9.22.2025.06.10.02.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 02:43:52 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [RFC PATCH] fetch2/git: allow overriding default unpack directory with a variable
Date: Tue, 10 Jun 2025 11:43:34 +0200
Message-Id: <20250610094334.1653567-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 Jun 2025 09:44:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17693

From: Alexander Kanavin <alex@linutronix.de>

This will allow setting the variable in oe-core such that it matches
S, which in turn will allow dropping S from almost all git:// fetching recipes,
and not having to set it in newly written ones.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bitbake/lib/bb/fetch2/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 55dd084abce..0af8070080b 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -660,7 +660,7 @@ class Git(FetchMethod):
         subdir = ud.parm.get("subdir")
         subpath = ud.parm.get("subpath")
         readpathspec = ""
-        def_destsuffix = "git/"
+        def_destsuffix = (d.getVar("BB_GIT_DEFAULT_DESTSUFFIX") or "git") + "/"
 
         if subpath:
             readpathspec = ":%s" % subpath
-- 
2.39.5


