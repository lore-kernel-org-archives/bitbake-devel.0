Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
 by mx.groups.io with SMTP id smtpd.web09.11133.1625747700908558942
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 08 Jul 2021 05:35:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=dwrobel@ertelnet.rybnik.pl header.s=ertelnet header.b=PXYHesX4;
 spf=pass (domain: ertelnet.rybnik.pl, ip: 136.143.188.14, mailfrom: dwrobel@ertelnet.rybnik.pl)
ARC-Seal: i=1; a=rsa-sha256; t=1625747698; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=n0JtHtUMI/EER1dsJwstpFAFw+4We7ETX5UiTXv51W0cQQ3PhkCLZKWjvD+5CsZ5DGrNT5+vAid7vHnCP99fU8v5WaOd0U5e/cYIhBnTlYPwHFgyKMc0jWWxISkpoqLeXYigr1QXiZTVlY/ImJ+svB1ADg2J9JnAR2ZD1AYw+fQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1625747698; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
	bh=b9b7zhGfzLvgPy8YRNZltsOJ/Q84jltiSfn4LVEMQcw=; 
	b=jNMXZFegnhX/oTkQKfLlUvKtA1M8w2mXcbOe3u17kfmOCB4WkfSeHu7SRtVZYUN0vwtdCKry2Qk95vlSJgLtDiXF/o729BygAUk4hilUeUYsHiYxd1hZhk7/j2QRIAlX2A1R+cHVQo3J/c9t/XsuUHtuZ0eJb/+9seZhn2fcqlQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ertelnet.rybnik.pl;
	spf=pass  smtp.mailfrom=dwrobel@ertelnet.rybnik.pl;
	dmarc=pass header.from=<dwrobel@ertelnet.rybnik.pl>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1625747698;
	s=ertelnet; d=ertelnet.rybnik.pl; i=dwrobel@ertelnet.rybnik.pl;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
	bh=b9b7zhGfzLvgPy8YRNZltsOJ/Q84jltiSfn4LVEMQcw=;
	b=PXYHesX4AAJUtmVgdruDWPYdvEF5oGbMVrhO8xI1BydyhqzXt0zGxffTeP7KJdy6
	HhhOxIj+o99IWydlChuRHMRIuUesZiMIQpSjO3weXhIvjYHuRBq/emnbOKGSvvXpVn2
	4lwc9MlDJj8o++xz1aYAClVn9lDvsGSW4zj+C3Cc=
Received: from localhost.localdomain.pl (91.230.58.69 [91.230.58.69]) by mx.zohomail.com
	with SMTPS id 1625747696443809.1143299903215; Thu, 8 Jul 2021 05:34:56 -0700 (PDT)
From: "Damian Wrobel" <dwrobel@ertelnet.rybnik.pl>
To: bitbake-devel@lists.openembedded.org
Cc: Adam Romanek <romanek.adam@gmail.com>
Subject: [PATCH] fetch2/s3: allow to use credentials from environment variables
Date: Thu,  8 Jul 2021 14:34:52 +0200
Message-Id: <20210708123452.568860-1-dwrobel@ertelnet.rybnik.pl>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-ZohoMailClient: External
Content-Transfer-Encoding: 8bit

From: Adam Romanek <romanek.adam@gmail.com>

Previously access to AWS S3 was expected to be preconfigured and
credentials to be stored in ~/.aws/credentials. With this change
one can use Bitbake s3 fetcher without AWS credentials stored
permanently as above, just with them exported as the following
environment variables:
 - AWS_ACCESS_KEY_ID,
 - AWS_SECRET_ACCESS_KEY.
 - AWS_DEFAULT_REGION.

Signed-off-by: Adam Romanek <romanek.adam@gmail.com>
Signed-off-by: Damian Wrobel <dwrobel@ertelnet.rybnik.pl>
---
 lib/bb/fetch2/__init__.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index c8e91262..0d49e1da 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -834,7 +834,10 @@ def runfetchcmd(cmd, d, quiet=False, cleanup=None, log=None, workdir=None):
                   'SSH_AUTH_SOCK', 'SSH_AGENT_PID',
                   'SOCKS5_USER', 'SOCKS5_PASSWD',
                   'DBUS_SESSION_BUS_ADDRESS',
-                  'P4CONFIG']
+                  'P4CONFIG',
+                  'AWS_ACCESS_KEY_ID',
+                  'AWS_SECRET_ACCESS_KEY',
+                  'AWS_DEFAULT_REGION']
 
     if not cleanup:
         cleanup = []
-- 
2.31.1

