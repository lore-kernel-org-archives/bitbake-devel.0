Return-Path: <develop@schnelte.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EE8E784A5
	for <webhook@archiver.kernel.org>; Mon,  2 Oct 2023 06:42:26 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by mx.groups.io with SMTP id smtpd.web10.76086.1696228941119060819
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 01 Oct 2023 23:42:21 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: schnelte.de, ip: 212.227.126.187, mailfrom: develop@schnelte.de)
Received: from DE-L-7495107.europe.abb.com ([91.33.147.45]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MYvTs-1r97DG3A1Y-00UsGW; Mon, 02 Oct 2023 08:42:18 +0200
From: Matthias Schnelte <develop@schnelte.de>
To: bitbake-devel@lists.openembedded.org
Cc: Matthias Schnelte <develop@schnelte.de>
Subject: [PATCH] Adds VSCode devcontainer support
Date: Mon,  2 Oct 2023 08:41:06 +0200
Message-ID: <20231002064106.16886-1-develop@schnelte.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1KL1uuVeQTjszTQn4+5n63JXvsDPHfS1B8aFGNeFAcE20tIT2tg
 Mrq6qXORNBqHU2URpq1yjQibRRpB5mu1mmRJSL8Hp5nQ1l7+jCK8etrtK2kIRQPFEU0z6O9
 Ys8yRhk/u+lpuO4F2NT4NOHu17GWPA3o74RoQkKj6ZLdzVLXnB1z2FiD5E/uTFO9HceyS1t
 oWTMB0GuYMhc5IXoemxAg==
UI-OutboundReport: notjunk:1;M01:P0:i/+SmAPFACQ=;94v8J5/tu2WG1FBeBZ052EJzDSF
 c5gwocR3z7wUPIdcTjipcYMFqe5gF8yfYZRAqmKhL1H3JXSyyWJgfoRDxEgv2IUCYDkXV1sT6
 oIkGECauz+pRzuNCRridlZ5aswOszvdqe9XYIwuD4Gpgr715lyCqplslqH59w/CFMyCan5dg5
 jXxeyf9UbamYyICndbsWSPI7HDjlGEa1F+yHpUcVs+CdsVT75e6KJbF2qnF0i9SA46pjQW8iJ
 XN6CPDZI74rhaZyeDyvO9vK3BSxIaLt42M4Efm4znn4GvmLrK0bir3+yfFQRWz0rXGpBsof9S
 iOQILjykk8o784qGVghCNkkSrRUDm+t3mwI2SrB93tpanQduOXCPwSM5QAy2+jyFkHZ25AG2d
 BmLGVjTrdowKs/RZB8NqcQXOIjb901TTWeEsvcMYzTb30jSM/P0DjMvGJARE74fh0JIzAl8Lx
 UjiLHsxrj0IzMukV05PcqkN/BC+2lwTVvDO7Ul+bPylakSYRzSgmAmYCIBoJ6xlxFVZcD15gB
 RHa8g9RMzGTnpaIawXAcm6QTSkm6Fe369NgkgNIZ59+VBpUz2hwyk7aAvyO1JfUUQULUinWMr
 H/CrgKRDC0aYuVre+TojDNzvbInj+jhtKHTtvNV/DAIwD/gzvEyGVCnCa01dH2DCW3U53l7kG
 9vX1x9bN81CpYUizuJyRznXK+RpObQYuVItofzfCotrf/GwRJoOzhE7A9YPhLO/atk9bLh8bG
 WJll2VLYpV5BSEa7pIzWF7kqKxXgfNs/E21HsAheS8o1D5SpxX+YHr1VkSGGrPH0NO+pBO3jD
 LyLNe3RTMOxyn6GDWW1rJ6w+bXVhHd4V+8CGQNzPUi+TdZklur4iz5VK+5f/jB2Y7oqSM3WFi
 9I7wXnADokV8wrA==
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 02 Oct 2023 06:42:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15153

Visual studio code's devcontainer solution is injecting a git credential
helper into the devcontainers. This helper forwards the host credential
helper into the container.

The git credential helper injected by visual studio code into
dev containers needs the REMOTE_CONTAINERS_IPC environment
variable in order for all git commands that require authentication
to work.

Signed-off-by: Matthias Schnelte <develop@schnelte.de>
---
 lib/bb/fetch2/__init__.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 765aedd5..ffb1a92b 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -874,6 +874,7 @@ FETCH_EXPORT_VARS = ['HOME', 'PATH',
                      'AWS_SECRET_ACCESS_KEY',
                      'AWS_DEFAULT_REGION',
                      'GIT_CACHE_PATH',
+                     'REMOTE_CONTAINERS_IPC',
                      'SSL_CERT_DIR']
 
 def get_fetcher_environment(d):
-- 
2.42.0


