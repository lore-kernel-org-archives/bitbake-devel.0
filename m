Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCE5C83029
	for <webhook@archiver.kernel.org>; Thu, 21 Apr 2022 16:46:12 +0000 (UTC)
Received: from mail1.wrs.com (mail1.wrs.com [147.11.3.146])
 by mx.groups.io with SMTP id smtpd.web11.19150.1650532304301331194
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 21 Apr 2022 02:11:44 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=permerror,
 err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid
 domain name (domain: windriver.com, ip: 147.11.3.146,
 mailfrom: liezhi.yang@windriver.com)
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com
 [147.11.82.252])
	by mail1.wrs.com (8.15.2/8.15.2) with ESMTPS id 23L9BgWK024982
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>; Thu, 21 Apr 2022 02:11:43 -0700
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 21 Apr 2022 02:11:42 -0700
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.12 via Frontend Transport; Thu, 21 Apr 2022 02:11:41 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH V2] fetch2/ssh.py: decode path back for ssh
Date: Thu, 21 Apr 2022 17:12:31 +0800
Message-ID: <20220421091231.69425-1-liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 Apr 2022 16:46:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13656

The path has been encoded by urllib.parse.quote(), so decode it back for ssh.

Fixed when fetch from PREMIRRORS via ssh:
$ bitbake bonnie++ libsigc++-2.0 -cfetch

scp: /paht/to/downloads/libsigc%2B%2B-2.10.7.tar.xz: No such file or directory

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 lib/bb/fetch2/ssh.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/ssh.py b/lib/bb/fetch2/ssh.py
index 484453088..8d082b38c 100644
--- a/lib/bb/fetch2/ssh.py
+++ b/lib/bb/fetch2/ssh.py
@@ -32,6 +32,7 @@ IETF secsh internet draft:
 
 import re, os
 from bb.fetch2 import check_network_access, FetchMethod, ParameterError, runfetchcmd
+import urllib
 
 
 __pattern__ = re.compile(r'''
@@ -70,6 +71,7 @@ class SSH(FetchMethod):
                 "git:// prefix with protocol=ssh", urldata.url)
         m = __pattern__.match(urldata.url)
         path = m.group('path')
+        path = urllib.parse.unquote(path)
         host = m.group('host')
         urldata.localpath = os.path.join(d.getVar('DL_DIR'),
                 os.path.basename(os.path.normpath(path)))
@@ -99,7 +101,7 @@ class SSH(FetchMethod):
 
         if path[0] != '~':
             path = '/%s' % path
-        path = path.replace("%3A", ":")
+        path = urllib.parse.unquote(path)
 
         fr += ':%s' % path
 
@@ -139,7 +141,7 @@ class SSH(FetchMethod):
 
         if path[0] != '~':
             path = '/%s' % path
-        path = path.replace("%3A", ":")
+        path = urllib.parse.unquote(path)
 
         cmd = 'ssh -o BatchMode=true %s %s [ -f %s ]' % (
             portarg,
-- 
2.17.1


