Return-Path: <sh0127.shin@lge.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1FFC5DF8C
	for <webhook@archiver.kernel.org>; Sat, 22 Aug 2026 01:20:20 +0000 (UTC)
Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2777.1787361614582995285
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Aug 2026 18:20:15 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: lge.com, ip: 156.147.23.51, mailfrom: sh0127.shin@lge.com)
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
	by 156.147.23.51 with ESMTP; 22 Aug 2026 10:20:12 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: sh0127.shin@lge.com
Received: from unknown (HELO swfarm-oeci-r122-2204..) (156.147.61.178)
	by 156.147.1.126 with ESMTP; 22 Aug 2026 10:20:12 +0900
X-Original-SENDERIP: 156.147.61.178
X-Original-MAILFROM: sh0127.shin@lge.com
From: sh0127.shin@lge.com
To: bitbake-devel@lists.openembedded.org
Cc: sh0127.shin@lge.com
Subject: [PATCH] fetch2: add 'fixperms' option for tar archives with restrictive permissions
Date: Sat, 22 Aug 2026 01:20:07 +0000
Message-Id: <20260822012007.189830-1-sh0127.shin@lge.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 22 Aug 2026 01:20:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20017

From: "sh0127.shin" <sh0127.shin@lge.com>

Some tar archives contain directories with restrictive
permissions (e.g. drw-r--r--) that can prevent extraction
or subsequent processing from completing successfully.

Extend FetchMethod.unpack() with a new 'fixperms' SRC_URI
parameter.

When 'fixperms=1' is specified:

  1. Add --delay-directory-restore to the tar command to
     defer directory permission restoration until all
     contents are extracted.

  2. Apply chmod -R +X after extraction to ensure
     directories remain traversable and executable files
     retain appropriate execute permissions.

Usage:

  SRC_URI = "https://example.com/foo.tgz;fixperms=1"

Signed-off-by: sh0127.shin <sh0127.shin@lge.com>
---
 lib/bb/fetch2/__init__.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 9cb268be5..1c3bab6d7 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1564,6 +1564,8 @@ class FetchMethod(object):
 
         if unpack:
             tar_cmd = ['tar', '--extract', '--no-same-owner']
+            if 'fixperms' in urldata.parm and urldata.parm['fixperms'] == '1':
+                tar_cmd.append('--delay-directory-restore')
             if 'striplevel' in urldata.parm:
                 striplevel = urldata.parm['striplevel']
                 if not striplevel.isdigit():
@@ -1659,6 +1661,9 @@ class FetchMethod(object):
         bb.note("Unpacking %s to %s/" % (file, unpackdir))
         _run(cmd)
 
+        if 'fixperms' in urldata.parm and urldata.parm['fixperms'] == '1':
+            _run(['chmod', '-R', '+X', unpackdir])
+
         if iterate is True:
             iterate_urldata = urldata
             iterate_urldata.localpath = "%s/%s" % (rootdir, iterate_file)
-- 
2.34.1


