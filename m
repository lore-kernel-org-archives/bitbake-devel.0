Received: from mail5.wrs.com (mail5.wrs.com [192.103.53.11])
 by mx.groups.io with SMTP id smtpd.web09.5151.1620972343134626290
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 May 2021 23:05:43 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: windriver.com, ip: 192.103.53.11, mailfrom: mingli.yu@windriver.com)
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com [147.11.82.252])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 14E65e0I017293
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>; Thu, 13 May 2021 23:05:40 -0700
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 13 May 2021 23:05:40 -0700
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.4 via Frontend Transport; Thu, 13 May 2021 23:05:39 -0700
From: "Yu, Mingli" <mingli.yu@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] fetch2: make sure the uri added as expected
Date: Fri, 14 May 2021 14:04:43 +0800
Message-ID: <20210514060443.33335-1-mingli.yu@windriver.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain

From: Mingli Yu <mingli.yu@windriver.com>

Make sure the uri added as expected in some scenarioes such as
with below setting:

PREMIRRORS_append = ".*://.*/.* git:///net/SharedImage/downloads/git2/MIRRORNAME;protocol=file"

Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
---
 lib/bb/fetch2/__init__.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index cf0201c4..6701654b 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -430,6 +430,8 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
     uri_replace_decoded = list(decodeurl(uri_replace))
     logger.debug2("For url %s comparing %s to %s" % (uri_decoded, uri_find_decoded, uri_replace_decoded))
     result_decoded = ['', '', '', '', '', {}]
+    if uri_find_decoded[0] == '.*' and uri_replace_decoded[0] != 'file':
+        uri_find_decoded[0] = uri_replace_decoded[0]
     for loc, i in enumerate(uri_find_decoded):
         result_decoded[loc] = uri_decoded[loc]
         regexp = i
-- 
2.17.1

