Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D62C433EF
	for <webhook@archiver.kernel.org>; Mon, 18 Oct 2021 03:45:32 +0000 (UTC)
Received: from mail1.wrs.com (mail1.wrs.com [147.11.3.146])
 by mx.groups.io with SMTP id smtpd.web08.32032.1634528731349888942
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 17 Oct 2021 20:45:31 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=fail (domain: windriver.com, ip: 147.11.3.146, mailfrom: qi.chen@windriver.com)
Received: from mail.windriver.com (mail.wrs.com [147.11.1.11])
	by mail1.wrs.com (8.15.2/8.15.2) with ESMTPS id 19I3jUCT027673
	(version=TLSv1.1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>; Sun, 17 Oct 2021 20:45:30 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com
 [147.11.82.252])
	by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 19I3jTFl008258
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
 Sun, 17 Oct 2021 20:45:30 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 17 Oct 2021 20:45:29 -0700
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Sun, 17 Oct 2021 20:45:29 -0700
Received: from ala-lpggp7.wrs.com (147.11.105.171) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.12 via Frontend Transport; Sun, 17 Oct 2021 20:45:29 -0700
From: Chen Qi <Qi.Chen@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [bitbake-devel][PATCH V2 1/3] fetch2: fix downloadfilename issue with
 premirror
Date: Sun, 17 Oct 2021 20:45:27 -0700
Message-ID: <20211018034529.70236-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Oct 2021 03:45:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12790

The following commit to fix [Yocto #13039] causes regression of
the behavior of PREMIRRORS.

  "bitbake: fetch2: fix premirror URI when downloadfilename defined"

Take meta-openembedded/meta-networking/recipes-protocols/freediameter/freediameter_1.4.0.bb
as an example.
SRC_URI = "\
    http://www.freediameter.net/hg/${fd_pkgname}/archive/${PV}.tar.gz;downloadfilename=${fd_pkgname}-${PV}.tar.gz \
    ...
"
With the above commit, it now tries to fetch 1.4.0.tar.gz instead of
freeDiameter-1.4.0.tar.gz. This makes https://downloads.yoctoproject.org/mirror/sources
not work for freediameter, as it holds freeDiameter-1.4.0.tar.gz.

The commit above tries to avoid fetching from invalid url such as:
https://<some_mirror>/1.4.0.tar.gz/freeDiameter-1.4.0.tar.gz.
And its solution is to make basename to be 1.4.0.tar.gz, thus causing the
regression.

This patch fixes the above regression. For Yocto #13039, it now tries
to fetch from url: https://<some_mirror>/freeDiameter-1.4.0.tar.gz.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 666cc1306a..000b49a500 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -466,9 +466,13 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
                     # Kill parameters, they make no sense for mirror tarballs
                     uri_decoded[5] = {}
                 elif ud.localpath and ud.method.supports_checksum(ud):
-                    basename = os.path.basename(uri_decoded[loc])
-                if basename and not result_decoded[loc].endswith(basename):
-                    result_decoded[loc] = os.path.join(result_decoded[loc], basename)
+                    basename = os.path.basename(ud.localpath)
+                if basename:
+                    uri_basename = os.path.basename(uri_decoded[loc])
+                    if basename != uri_basename and result_decoded[loc].endswith(uri_basename):
+                        result_decoded[loc] = result_decoded[loc].replace(uri_basename, basename)
+                    elif not result_decoded[loc].endswith(basename):
+                        result_decoded[loc] = os.path.join(result_decoded[loc], basename)
         else:
             return None
     result = encodeurl(result_decoded)
-- 
2.33.0


