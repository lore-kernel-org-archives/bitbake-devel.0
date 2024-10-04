Return-Path: <mfumita@electromag.com.au>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66137CF856A
	for <webhook@archiver.kernel.org>; Fri,  4 Oct 2024 03:07:31 +0000 (UTC)
Received: from anchovy2.45ru.net.au (anchovy2.45ru.net.au [203.30.46.146])
 by mx.groups.io with SMTP id smtpd.web10.14126.1728011247291078697
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 03 Oct 2024 20:07:28 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: electromag.com.au, ip: 203.30.46.146, mailfrom: mfumita@electromag.com.au)
Received: (qmail 5130 invoked by uid 5089); 4 Oct 2024 03:07:24 -0000
Received: by simscan 1.2.0 ppid: 4969, pid: 4971, t: 0.5147s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950 spam: 3.1.4
Received: from unknown (HELO MORI-7680.localdomain) (mfumita@electromag.com.au@144.6.137.188)
  by anchovy3.45ru.net.au with ESMTPA; 4 Oct 2024 03:07:23 -0000
Received: from MORI-7680.electromag.com.au (localhost [127.0.0.1])
	by MORI-7680.localdomain (Postfix) with ESMTP id 9177D424726;
	Fri,  4 Oct 2024 11:07:24 +0800 (AWST)
From: Mori Fumita <mfumita@electromag.com.au>
To: bitbake-devel@lists.openembedded.org
Cc: Mori Fumita <mfumita@electromag.com.au>
Subject: [bitbake-devel][PATCH] fetch2/svn: Support to feed an external SSL certificate file and its password
Date: Fri,  4 Oct 2024 11:06:40 +0800
Message-ID: <20241004030640.10440-1-mfumita@electromag.com.au>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 04 Oct 2024 03:07:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16636

Add parameters to feed an external SSL certificate and its password to the following SVN runtime options.
  --config-option=servers:global:ssl-client-cert-file="..."
  --config-option=servers:global:ssl-client-cert-password="..."

Can be specified with:
  SRC_URI = "svn://[repository];protocol=https;cert_file=[certificate path];cert_pass=[password]"

Signed-off-by: Mori Fumita <mfumita@electromag.com.au>
---
 lib/bb/fetch2/svn.py | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/svn.py b/lib/bb/fetch2/svn.py
index 0852108e7d98..9f61390f1799 100644
--- a/lib/bb/fetch2/svn.py
+++ b/lib/bb/fetch2/svn.py
@@ -73,9 +73,17 @@ class Svn(FetchMethod):
         proto = ud.parm.get('protocol', 'svn')
 
         svn_ssh = None
+        svn_https_cert = None
+        svn_https_pass = None
         if proto == "svn+ssh" and "ssh" in ud.parm:
             svn_ssh = ud.parm["ssh"]
 
+        if proto == "https":
+            if "cert_file" in ud.parm:
+                svn_https_cert = ud.parm["cert_file"]
+            if "cert_pass" in ud.parm:
+                svn_https_pass = ud.parm["cert_pass"]
+
         svnroot = ud.host + ud.path
 
         options = []
@@ -117,6 +125,12 @@ class Svn(FetchMethod):
         if svn_ssh:
             svncmd = "SVN_SSH=\"%s\" %s" % (svn_ssh, svncmd)
 
+        if svn_https_cert:
+            svncmd = "%s --config-option=servers:global:ssl-client-cert-file=\"%s\"" % (svncmd, svn_https_cert)
+
+        if svn_https_pass:
+            svncmd = "%s --config-option=servers:global:ssl-client-cert-password=\"%s\"" % (svncmd, svn_https_pass)
+
         return svncmd
 
     def download(self, ud, d):
@@ -176,7 +190,7 @@ class Svn(FetchMethod):
 
         bb.utils.remove(ud.localpath)
         bb.utils.remove(ud.moddir, True)
-        
+
 
     def supports_srcrev(self):
         return True
-- 
2.46.2


