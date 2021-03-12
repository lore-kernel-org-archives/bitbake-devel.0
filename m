Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 by mx.groups.io with SMTP id smtpd.web10.201.1615565598932428515
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Mar 2021 08:13:22 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: windriver.com, ip: 147.11.146.13, mailfrom: paul.gortmaker@windriver.com)
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com [147.11.82.252])
	by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 12CGD2MQ012244
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>; Fri, 12 Mar 2021 08:13:12 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 12 Mar 2021 08:13:01 -0800
Received: from yow-pgortmak-d1.corp.ad.wrs.com (128.224.56.57) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Fri, 12 Mar 2021 08:13:01 -0800
From: "Paul Gortmaker" <paul.gortmaker@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] gitignore: ignore runqueue-tests/bitbake-cookerdaemon.log
Date: Fri, 12 Mar 2021 11:13:00 -0500
Message-ID: <20210312161300.15854-1-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/.gitignore b/.gitignore
index 8ca4b5d15cfb..fbf9eb2031c8 100644
--- a/.gitignore
+++ b/.gitignore
@@ -15,3 +15,4 @@ doc/bitbake-user-manual/bitbake-user-manual.tgz
 lib/toaster/contrib/tts/backlog.txt
 lib/toaster/contrib/tts/log/*
 lib/toaster/contrib/tts/.cache/*
+lib/bb/tests/runqueue-tests/bitbake-cookerdaemon.log
-- 
2.15.0

