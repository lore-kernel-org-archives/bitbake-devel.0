Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
 by mx.groups.io with SMTP id smtpd.web10.11193.1625747434206049619
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 08 Jul 2021 05:30:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=dwrobel@ertelnet.rybnik.pl header.s=ertelnet header.b=CjQ7ih9v;
 spf=pass (domain: ertelnet.rybnik.pl, ip: 136.143.188.14, mailfrom: dwrobel@ertelnet.rybnik.pl)
ARC-Seal: i=1; a=rsa-sha256; t=1625747432; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UUSnFEoiMKhJCw2AamDNuGXHObygRREVFKOlvkucv0PCTYkAhqrF54hVxiygezhVZZTEqb7z0yyeS6OtvpOBsuyBdy8CkGbmS7w5iwg3Ix6AnCnMRF4yzIpQjFPjVdDK39Dqwq3HfifvS1gK9my0Bl57DoSO5jUP7PI7CB6MarE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1625747432; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
	bh=Xyu+/3qtamrTb9CSIaol3GSRTG5JCShwKz5V7YvpZns=; 
	b=Y8mH0KEh6QFdVxSZin22a+DYHvgtu+b1K5tncFF7cKIn2oi5oLYq+GRjrHOikuMTaxA8krRCtbl1IOuzZmD6AsV/bRBROmrAWi9dpEquZgXaovFQB0Q0/XQWdI9YCirSi0meLeLGK7UtilRozWZh90Ej2aQgtPsUVw887mfz1Gs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ertelnet.rybnik.pl;
	spf=pass  smtp.mailfrom=dwrobel@ertelnet.rybnik.pl;
	dmarc=pass header.from=<dwrobel@ertelnet.rybnik.pl>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1625747432;
	s=ertelnet; d=ertelnet.rybnik.pl; i=dwrobel@ertelnet.rybnik.pl;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
	bh=Xyu+/3qtamrTb9CSIaol3GSRTG5JCShwKz5V7YvpZns=;
	b=CjQ7ih9vU8Rc6vLUXQDytHac/T52dW+S2peMd6nhQ8uzdkGqVOdtvsT8psdq1Nf/
	tNYevYnaHymIgDILMmQ0s595V2JzKCvfY3x260iQIAUJs+jc3JtmcBoXaKzCfYDz7US
	amm2kfyZ7TXctfsCk9BIS7wzjslBuj4vW/Rm20jg=
Received: from localhost.localdomain.pl (91.230.58.69 [91.230.58.69]) by mx.zohomail.com
	with SMTPS id 1625747430494238.63443862347265; Thu, 8 Jul 2021 05:30:30 -0700 (PDT)
From: "Damian Wrobel" <dwrobel@ertelnet.rybnik.pl>
To: bitbake-devel@lists.openembedded.org
Cc: Adam Romanek <romanek.adam@gmail.com>
Subject: [PATCH] fetch2/s3: improve checking if object exists in s3 by using botocore
Date: Thu,  8 Jul 2021 14:30:21 +0200
Message-Id: <20210708123021.568443-1-dwrobel@ertelnet.rybnik.pl>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-ZohoMailClient: External
Content-Transfer-Encoding: 8bit

From: Adam Romanek <romanek.adam@gmail.com>

Botocore uses urllib3 which in turn uses a connection pool to issue HTTP
requests. Keeping the S3 client obtained from botocore library allows
one to reuse that connection pool.

The S3 client obtained from botocore is now kept in a connection
cache, which in case of sstate-cache checks is set up in
openembedded-core/classes/sstate.bbclass.

On Python 3.5+ a ResourceWarning on unclosed SSL socket is issued when
dropping the reference to botocore S3 client, which is a known issue but
apparently a false positive: https://github.com/boto/boto3/issues/454

Initial results show the time to check ~2700 objects is cut by 85%
(4 mins -> 35 secs).

With this change setting SSTATE_MIRRORS directly to S3 could now be the
preferred method for using sstate-cache from S3 (no need to sync
sstate-cache from S3 prior running the build), especially when the cache
grows significantly over time (e.g. from 4GB to 30GB during the day).

Signed-off-by: Adam Romanek <romanek.adam@gmail.com>
Signed-off-by: Damian Wrobel <dwrobel@ertelnet.rybnik.pl>
---
 lib/bb/fetch2/s3.py | 89 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 75 insertions(+), 14 deletions(-)

diff --git a/lib/bb/fetch2/s3.py b/lib/bb/fetch2/s3.py
index 6b8ffd53..bbc9f007 100644
--- a/lib/bb/fetch2/s3.py
+++ b/lib/bb/fetch2/s3.py
@@ -1,12 +1,14 @@
 """
 BitBake 'Fetch' implementation for Amazon AWS S3.
 
-Class for fetching files from Amazon S3 using the AWS Command Line Interface.
+Class for fetching files from Amazon S3 using the
+AWS Command Line Interface and python botocore library, if available.
 The aws tool must be correctly installed and configured prior to use.
 
 """
 
 # Copyright (C) 2017, Andre McCurdy <armccurdy@gmail.com>
+# Copyright (C) 2020, Adam Romanek <romanek.adam@gmail.com>
 #
 # Based in part on bb.fetch2.wget:
 #    Copyright (C) 2003, 2004  Chris Larson
@@ -21,8 +23,17 @@ import urllib.request, urllib.parse, urllib.error
 import re
 from bb.fetch2 import FetchMethod
 from bb.fetch2 import FetchError
+from bb.fetch2 import logger
 from bb.fetch2 import runfetchcmd
 
+try:
+    import botocore.exceptions
+    import botocore.session
+    HAS_BOTOCORE = True
+except ImportError:
+    HAS_BOTOCORE = False
+
+
 def convertToBytes(value, unit):
     value = float(value)
     if (unit == "KiB"):
@@ -60,7 +71,13 @@ class S3ProgressHandler(bb.progress.LineFilterProgressHandler):
 
 
 class S3(FetchMethod):
-    """Class to fetch urls via 'aws s3'"""
+    """Class to fetch urls from AWS S3"""
+
+    def init(self, d):
+        if HAS_BOTOCORE:
+            logger.info("S3 FetchMethod: using botocore implementation")
+        else:
+            logger.warning("S3 FetchMethod: consider installing botocore to speed up S3 access")
 
     def supports(self, ud, d):
         """
@@ -106,19 +123,63 @@ class S3(FetchMethod):
 
         return True
 
-    def checkstatus(self, fetch, ud, d):
-        """
-        Check the status of a URL
-        """
+    if HAS_BOTOCORE:
+        def checkstatus(self, fetch, ud, d):
+            try:
+                return self._check_object_exists(fetch, ud, d)
+            except Exception as error:
+                logger.warning('S3 FetchMethod checkstatus error: %s', error)
+                return False
+    else:
+        def checkstatus(self, fetch, ud, d):
+            """
+            Check the status of a URL
+            """
 
-        cmd = '%s ls s3://%s%s' % (ud.basecmd, ud.host, ud.path)
-        bb.fetch2.check_network_access(d, cmd, ud.url)
-        output = runfetchcmd(cmd, d)
+            cmd = '%s ls s3://%s%s' % (ud.basecmd, ud.host, ud.path)
+            bb.fetch2.check_network_access(d, cmd, ud.url)
+            output = runfetchcmd(cmd, d)
 
-        # "aws s3 ls s3://mybucket/foo" will exit with success even if the file
-        # is not found, so check output of the command to confirm success.
+            # "aws s3 ls s3://mybucket/foo" will exit with success even if the file
+            # is not found, so check output of the command to confirm success.
 
-        if not output:
-            raise FetchError("The aws ls command for s3://%s%s gave empty output" % (ud.host, ud.path))
+            if not output:
+                raise FetchError("The aws ls command for s3://%s%s gave empty output" % (ud.host, ud.path))
 
-        return True
+            return True
+
+    def _check_object_exists(self, fetch, ud, d):
+        """
+        Call HeadObject via botocore to check if an object exists in S3 bucket.
+        """
+        def create_s3_client():
+            return botocore.session.get_session().create_client('s3')
+
+        if fetch.connection_cache:
+            class FakeConnection(object):
+                def __init__(self, client):
+                    self.client = client
+
+                def close(self):
+                    self.client = None  # see https://github.com/boto/boto3/issues/454
+
+            dummy_host = ''
+            dummy_port = 0
+
+            connection = fetch.connection_cache.get_connection(dummy_host, dummy_port)
+            if connection:
+                client = connection.client
+            else:
+                client = create_s3_client()
+                fetch.connection_cache.add_connection(dummy_host, dummy_port, FakeConnection(client))
+        else:
+            client = create_s3_client()
+
+        try:
+            client.head_object(Bucket=ud.host, Key=ud.path[1:])
+        except botocore.exceptions.ClientError as error:
+            if error.response['Error']['Code'] not in ('NoSuchKey', '404'):  # see https://github.com/boto/boto3/issues/2442
+                logger.warning('S3 FetchMethod ClientError: %s', error)
+            return False
+        else:
+            return True
-- 
2.31.1

