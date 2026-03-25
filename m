Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF8EFEA828
	for <webhook@archiver.kernel.org>; Wed, 25 Mar 2026 07:14:12 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17083.1774422847652154619
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 25 Mar 2026 00:14:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm1 header.b=RcPYbYmN;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-1329275-20260325071404aeeb10ca7b0002071f-omcnjg@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260325071404aeeb10ca7b0002071f
        for <bitbake-devel@lists.openembedded.org>;
        Wed, 25 Mar 2026 08:14:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=lppszxLz4QTVAYbLIpXDV4/5Xlh/vWpcjTQZo9Ctb+0=;
 b=RcPYbYmNNoEamp03VNZ+B5HwGp29cE3BEnYGf3MjhVMZuqwvtNQuJ1z9Z8Aeo/4A1vix9B
 Z025GDfQw/HDXsyPl90Jgc/a7Q6Uoc6OMFZI8R/6e+7njIn7VGF/CpBaLmeYvb0ku6XnB2hX
 xai9A30GwFm+yOVOUm66P4EIMFwzRPhjUxC2SHD9smbhl0JSMT9GW5MBysK+G38J5brjkvl3
 fcD8WLFUAq7WjvWc/FA5mKL9rUeFF81G4HL8+IzxRcICq2WaaiKw7Hy2LcLppxa1RW6Ae98A
 owTPWKtZcbfzZvkwqf1J2SeWdHMd6pQLOT8Boq6pE4TDiolPOXOvdqjQ==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH v2 03/10] tests/fetch: remove unused import, fix trailing whitespace
Date: Wed, 25 Mar 2026 07:51:45 +0100
Message-ID: <20260325071342.47272-4-adrian.freihofer@siemens.com>
In-Reply-To: <20260325071342.47272-1-adrian.freihofer@siemens.com>
References: <20260325071342.47272-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 25 Mar 2026 07:14:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19226

From: Adrian Freihofer <adrian.freihofer@siemens.com>

Just cleanup, no functional change.

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 lib/bb/tests/fetch.py | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 25432e030..570865106 100644
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


