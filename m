Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DAAFD0052
	for <webhook@archiver.kernel.org>; Sun, 29 Mar 2026 18:34:30 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34483.1774809263057676862
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 29 Mar 2026 11:34:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm1 header.b=E08vHLEV;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-1329275-20260329183420369d5ed52200020719-mfrge6@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260329183420369d5ed52200020719
        for <bitbake-devel@lists.openembedded.org>;
        Sun, 29 Mar 2026 20:34:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=gabGuLbbibLPYOMUoZ3amckwHUWnrOh/pQU8zTZjIXc=;
 b=E08vHLEVmm/SqgvWAeWt6nWkYk403qg1F2Fe9BuxMmcmfsxmLqs7TZH3f1g0OChk0j8k+y
 OQx3RdDhz+XI/dZ60AV2XJyLLQ/urP4vnxVdxUCNfUwuYcopsHebQfsuMywUVrfQQASxicmV
 ypHBAcytnSfGj/nqLrrf3P5O4c1SI41YQJ/WVLI/6ip5VRerNkT117+yNRUk+rND15PpHxfW
 ftch4whRNdN2uRGBLXzgMBVxKQOooKmsKfTFOpdZ+W/CRy2F0JJRW2u0wzJ7HdDwTILV3DSK
 Xf3Rysi5+1jh0cO3aV+taEn27Danj/+Bn8+FzhLLuNFPvbdUshBzIlqA==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH v3 04/14] tests/fetch: remove unused import, fix trailing whitespace
Date: Sun, 29 Mar 2026 20:32:51 +0200
Message-ID: <20260329183332.1996183-5-adrian.freihofer@siemens.com>
In-Reply-To: <20260329183332.1996183-1-adrian.freihofer@siemens.com>
References: <20260329183332.1996183-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 29 Mar 2026 18:34:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19274

From: Adrian Freihofer <adrian.freihofer@siemens.com>

Just cleanup, no functional change.

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 lib/bb/tests/fetch.py | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 1d018671a..5b3fc8a41 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -18,7 +18,6 @@ import os
 import signal
 import tarfile
 from bb.fetch2 import URI
-from bb.fetch2 import FetchMethod
 import bb
 import bb.utils
 from bb.tests.support.httpserver import HTTPService
@@ -551,8 +550,8 @@ class MirrorUriTest(FetcherTest):
         fetcher = bb.fetch.FetchData("http://downloads.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz", self.d)
         mirrors = bb.fetch2.mirror_from_string(mirrorvar)
         uris, uds = bb.fetch2.build_mirroruris(fetcher, mirrors, self.d)
-        self.assertEqual(uris, ['file:///somepath/downloads/bitbake-1.0.tar.gz', 
-                                'file:///someotherpath/downloads/bitbake-1.0.tar.gz', 
+        self.assertEqual(uris, ['file:///somepath/downloads/bitbake-1.0.tar.gz',
+                                'file:///someotherpath/downloads/bitbake-1.0.tar.gz',
                                 'http://otherdownloads.yoctoproject.org/downloads/bitbake-1.0.tar.gz',
                                 'http://downloads2.yoctoproject.org/downloads/bitbake-1.0.tar.gz'])
 
@@ -1390,7 +1389,7 @@ class URLHandle(unittest.TestCase):
        "https://somesite.com/somerepo.git;user=anyUser:idtoken=1234" : ('https', 'somesite.com', '/somerepo.git', '', '', {'user': 'anyUser:idtoken=1234'}),
        'git://s.o-me_ONE:%s@git.openembedded.org/bitbake;branch=main;protocol=https' % password: ('git', 'git.openembedded.org', '/bitbake', 's.o-me_ONE', password, {'branch': 'main', 'protocol' : 'https'}),
     }
-    # we require a pathname to encodeurl but users can still pass such urls to 
+    # we require a pathname to encodeurl but users can still pass such urls to
     # decodeurl and we need to handle them
     decodedata = datatable.copy()
     decodedata.update({
-- 
2.53.0


