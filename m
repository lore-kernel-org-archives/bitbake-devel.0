Return-Path: <zoltan.kuscsik@linaro.org>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
	by mail.openembedded.org (Postfix) with ESMTP id 48A536011A
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Nov 2015 05:37:44 +0000 (UTC)
Received: by wmvv187 with SMTP id v187so56477243wmv.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Nov 2015 21:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linaro-org.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=kCJ4dhutRS6Sd+eK4A8NwpjknLbLhOFSiUL0m2/CGBM=;
	b=MoqGQ5KOEFFJSqXlHWJBdbYCQ8We87tc3/QFcOXXepbuU2Vt8B32KkdwPHkgfR+bd7
	z4sYroTSDOZNrR+/M7SgG71dhxSlDqwwocGna3xrpQo5iv2PuTeQzkvIkCVszsNe5xMR
	7jwuCL53KgNpZpX3law3MXzLrrt4mW8Z/rf5I1B8I0WQ75UXUsYnRG8xCmB9Uwq335TV
	qZVd3aZUI9fDLBS7NXHjVoWPCRUpWE101iPwY80QeqOfQ38qYQOhapQ+AFrRINChfyvv
	5B7rFgyS+srxDkQTMlpPdGkxAZ/PMiXs4CRg54GQPksebCu2JLp/1G94www+z5/WDQpn
	woXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=kCJ4dhutRS6Sd+eK4A8NwpjknLbLhOFSiUL0m2/CGBM=;
	b=ZwHDsb1IsDv6vrf4dBZrQZ5SAJoltDmWfJEPeUDKxGbLPKY90C4h/Gw5dNvm7yamta
	SLIcGUUVp9hbbST86ly/RJwHS7oHX2IxQO0eiXCox7nsHjEgwxNZZ3Q3Md8g4YwY+lze
	/ErpVmP6d/jfqVn/KapSzU0RDebqP9gDoZ/OlVkntf27W436oUDy/7gKk+xLRzyKPgb8
	YtvXEswWYdaBVRpac10DX7c0EK49QMYssrRT+emNNYwdCLNaIdIn0DE/ww9eun9LNMBe
	X91BUrnqK5xWM6t6V4M+ysdt9WlgE5xYpt91ciAk81NhfjX4XmdShkc4rsGDTpxWJaBG
	ATSQ==
X-Gm-Message-State: ALoCoQlcKwyyvdVxN3AzaVVl7d5yPKT56hHAWBuA3U/U/szwZeWGaqFMEz7VBJkKFdU27AzrH5Iz
X-Received: by 10.28.102.8 with SMTP id a8mr95087wmc.67.1447997865207;
	Thu, 19 Nov 2015 21:37:45 -0800 (PST)
Received: from static.71.106.40.188.clients.your-server.de
	(static.71.106.40.188.clients.your-server.de. [188.40.106.71])
	by smtp.gmail.com with ESMTPSA id
	jt9sm10998810wjc.24.2015.11.19.21.37.44
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 19 Nov 2015 21:37:44 -0800 (PST)
From: Zoltan Kuscsik <zoltan.kuscsik@linaro.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 20 Nov 2015 06:37:34 +0100
Message-Id: <1447997854-20029-1-git-send-email-zoltan.kuscsik@linaro.org>
X-Mailer: git-send-email 1.9.1
Subject: [bitbake][PATCH] fetcher/svn : Warning on SSL verifaction failure
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 20 Nov 2015 05:37:48 -0000

OE core appends --trust-server-cert argument to
the svn command by default.  This change adds a
warning on invalid SSL server certificate.

We use wget to verify the certification as it
is more reliable than Python methods for SSL certificate
check.
---
 lib/bb/fetch2/svn.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/lib/bb/fetch2/svn.py b/lib/bb/fetch2/svn.py
index 1733c2b..d3a7cac 100644
--- a/lib/bb/fetch2/svn.py
+++ b/lib/bb/fetch2/svn.py
@@ -28,6 +28,7 @@ import sys
 import logging
 import bb
 import re
+import subprocess
 from   bb import data
 from   bb.fetch2 import FetchMethod
 from   bb.fetch2 import FetchError
@@ -173,6 +174,20 @@ class Svn(FetchMethod):
         """
         bb.fetch2.check_network_access(d, self._buildsvncommand(ud, d, "log1"))
 
+        if(ud.parm.get('protocol', 'svn') == 'https'):
+            svn_url = "https://%s%s" % (ud.host, ud.path)
+            try:
+                # Use wget to check the SSL certificate.
+                # The --spider argument ensures that we don't actually
+                # download anything.
+                wget_ssl_check_command = " wget --spider --timeout=30 %s" % svn_url
+                (output, errors) = bb.process.run(wget_ssl_check_command , shell=True, stderr=subprocess.PIPE)
+            except  bb.process.ExecutionError as e:
+                # wget returns 5 exit code on SSL verification failure
+                if(e.exitcode == 5):
+                    logger.warning("SVN repository %s has invalid SSL certificate." % svn_url)
+
+
         output = runfetchcmd("LANG=C LC_ALL=C " + self._buildsvncommand(ud, d, "log1"), d, True)
 
         # skip the first line, as per output of svn log
-- 
1.9.1


