Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB5AD5B16F
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 12:51:45 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.47587.1765803101210799227
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Dec 2025 04:51:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=OhgshmjK;
 spf=pass (domain: gmail.com, ip: 209.85.128.41, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47789cd2083so17695545e9.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 15 Dec 2025 04:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765803099; x=1766407899; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOA7jdb7VMS1AP03P6V6D3fejhob3fBniwiRuAG9NOY=;
        b=OhgshmjKZ6BNEwRKLxu+5XBQFmGGgZK2DHXncWwOl3byPmZvcTDqxeZtD8XTaaPDUO
         /+pZCwWO0IYojobTcsW3HWJZAqBxgfczYh553WMSAyXndDixIyai93VNbA/fh7NC7jpF
         eKVTW/m0HkOH+Cjdbjy4a53szGFYdEPHOluMp8/51EK6CYslJ1o6uOdvMfzhgA3ita19
         JmgVWNOmseYVqFz57kNBav95OjWkj1Lx395LzCZg/NGbkR5NZU0EcQuvwZisPAGkPKv7
         Kr2k9qpgK2YWdOx4fAcSYSUy+A9TMDyY8l3Kc36pifrl/1/wBq0z23UeTFhBhAPgG9Jc
         hkTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765803100; x=1766407900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pOA7jdb7VMS1AP03P6V6D3fejhob3fBniwiRuAG9NOY=;
        b=uR+9fQWUShNKQTfJfJj86uQACNNQO/Jjd+PqCFr7KBKSy4kH0oaL9WWcQxPisp6ZxL
         mf/zu4rU+ukUAILvAlnto5PX0KcqHkTKr4nSZdK4oUcJZqtPROwqTks90I02IynXZqdT
         Tm/fj9W3Ipu5kKm6X9jVgHEEY0KFWbLxR9rTHWmGzFFwHVKXB44it3CFPokPqabfoQLS
         FZ4FhjmIjaw1RT4mi2Aa9ilJe6ek1Gf2AWnY8lE8IRom0is0XayJUSaS4el4NmrRT/Dp
         QYezoMo209tIVBg4hS69PuDoHshIhRSqX3GMqNmPWoK0bEPy8HCCKcXtxaByFKrOxjeb
         hYFg==
X-Gm-Message-State: AOJu0YzVtoojyCNNWmpWLxY9bAB50jWL9RuTM1luhpRSljQAPzXJxqAR
	9Hikklri+PTqoNbwhND8wDdmzg5lY5aFXAFKyry9uw5QjdI8oXraEyFm2J9WEQ==
X-Gm-Gg: AY/fxX66+tbsl6ujJ/8YsFf6FjhULf9DqNrcd0Zq5SJm81qOkIase3KQaAisvJ9ihkS
	W6D0ybb+5jq2aAe/UdutSZQXGlJmwTl3EIXUfKcFzULHqmAWdJCLAL9kZpXzYjGM5a3hRs+PtOb
	nqLKcrZh565G/KTRtZSQuqQ8SHl1GH7CESG1xHJXy9oyaxnfYJYgIZEuCVHKag49tQrv+bz7ahT
	PoXjuRzGP13y/CMJlVFM+98bFsfmG1/hH79JeRgWzExULbeiCxHnJL46g21BJVD/X7/CjLdjyUc
	XNCmP2o3H6ix+bB7g5hRJKqBcK4qEH3dTYsn7kP2/FkiJ4xZV86hP8wQAJIvEjd+RMzOxX6CVkk
	8xwho0Ibxjah5VwbVUlunoFMJUnMIKwKMFiTJ15NRLAGyzveykndTRb1pN72feOm8+lKZkkrun4
	921E8zCQCpwM2LDVsfsew6XH4pfZJcMAcspRY4bS8H6TH6GdQ=
X-Google-Smtp-Source: AGHT+IGonLle4z6DnY7qyxaEQbNHKY3JWqoQ7nDlTsVRjZx3hWFdpNTQlX15sC3Av9rvuOgvBAe4Yw==
X-Received: by 2002:a05:600c:c172:b0:46e:37a7:48d1 with SMTP id 5b1f17b1804b1-47a8f915c34mr98254365e9.34.1765803099254;
        Mon, 15 Dec 2025 04:51:39 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8a09fbesm29303342f8f.0.2025.12.15.04.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 04:51:38 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: paul@pbarker.dev,
	antonin.godard@bootlin.com,
	Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH v2 5/5] bitbake-setup: adjust the decription of git-remote properties to correctly describe remotes
Date: Mon, 15 Dec 2025 13:51:27 +0100
Message-ID: <20251215125127.2660714-5-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251215125127.2660714-1-alex.kanavin@gmail.com>
References: <20251215125127.2660714-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Dec 2025 12:51:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18595

From: Alexander Kanavin <alex@linutronix.de>

Specifically, 'uri' property is not on the top level (for now), but
inside a remote, which itself is in a 'remotes' dictionary.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 .../bitbake-user-manual-environment-setup.rst                | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index 35aa43f9b..ec1bdeecd 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -702,8 +702,9 @@ They contain the following sections:
 
       ``git-remote`` entries are specified with the following options:
 
-      -  ``uri`` (**required**): a URI that follows the git URI syntax.
-         See https://git-scm.com/docs/git-clone#_git_urls for more information.
+      -  ``remotes`` (**required**): a dictionary of git remote names, each containing a ``uri`` property
+         with a URI that follows the git URI syntax. See https://git-scm.com/docs/git-clone#_git_urls
+         and https://git-scm.com/docs/git-remote for more information.
 
       -  ``rev`` (**required**): the revision to checkout. Can be the name of the
          branch to checkout on the latest revision of the specified ``branch``.
-- 
2.47.3


