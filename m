Return-Path: <pierre-loup.gosse@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40BBF013EC
	for <webhook@archiver.kernel.org>; Mon, 16 Mar 2026 09:04:35 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.46611.1773651867584125178
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 16 Mar 2026 02:04:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=gTejpFJM;
 spf=pass (domain: smile.fr, ip: 209.85.128.44, mailfrom: pierre-loup.gosse@smile.fr)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48540355459so39715115e9.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 16 Mar 2026 02:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1773651866; x=1774256666; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=du8bTGlQbOf4C1dbr0QIR/dx1Vy8Bs6le5s42UMXRjg=;
        b=gTejpFJMXJWnGoPnkCLptHKx+D+0cEqeT4tq8IWDsdHr03pG1q1LN5eFak2JzWOmN6
         6l8rZa4YwHJuEjKJBU7K6P50eqT9pwHZ5SwELmT8C5L6va1t89RHl+ZuAZicZw8mDbzu
         5a+8GY6ViS02Wq7LeREBO6BOL7n4ZtG+e5vTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773651866; x=1774256666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=du8bTGlQbOf4C1dbr0QIR/dx1Vy8Bs6le5s42UMXRjg=;
        b=CtcJ29x5/w1hC/uJc62PdLMrw0exbNcYIl2SN5bzt1XBnlhaaNHCmikpaw7wDBbCT0
         bVzIQh7AdDROHNsEK/Hr8vEUx1Py8T/SKNws93J4FakHKmPyjB5Ita1aFR87w6FdvIlh
         3PDddYKUAjdj8PeRHgp6VuPojOJZywARPNs6d7F+9MPVkO9iQmrwaVsPYE/y6pvgeiDD
         jxYtxUfte62WihjFJcxJI3safrIQI5gVTUNekEZlEKVLd6VYS1lYkokwu4Idw36avFDJ
         KJ6/4ic0YXutOD6xY3Ck95Xzky4jfZptdvtPtdnl33m5OW4z04Eg/9I2ANWf9lg7+le9
         0dDw==
X-Gm-Message-State: AOJu0YyLgIN+zy1gnnQ1K+1VNneViMhK6rLldqHWF2/6aE+B48+0lDua
	3OfTp/iwvyQn3LpB2UsiKVafWRcjjYCxbXl8ibaxs8NviFAcdqYxEVTX5uPhMWZfHhTv1CSMoEa
	JbWRW
X-Gm-Gg: ATEYQzzykNs20D9yKA512pAmnqwfEp8b0W3SSFN/744MffGldR5ZGKdp9HQLRnp8VFh
	4XOJB87M/DjCFcf6ImutmQcMHK7hYd76GiRaZCtHBPmzWEpV/h3nlRf29097tOsWxRAR/aLXx79
	FtLAbjJHSDm4JZkW80qPiBh5qRHK1NFOgs6dkDJ0q9PAIeT+Wcm5Ld23V9V5vPi4xqM3V3o/35s
	9NTUz2KZvaFeWLq96tzEXUbFgQ09FcCFN0ZUZq8ogsZ2Eq4/70++EpBl0jWSyAr3WvXybISMLUk
	4PZXG1oFdxyF2cKIxtzrLoBdqrfOcdSHCi7mIX1bHZV2iQhi22lKDCrxCn1knmXqDzjLneRUnVN
	mpQAXOyQOyPkNV2I638FTkaquExvDzR3mpvrHH/50P2fEyjFO+Wi+d63z+kDNrfQJMjlMzDMvdN
	GzyqTGdb3nGMdz7WcVyrggsijlImrYUXWXuYT7p6m2hVcSXjA5Ka6CGJwhLvQ2UZgy5EoxbUxsi
	Ln+vb21chlIR5YbiYoaIcODxC7NQF6POKgZGT3vAALlsmyhUcS7yTEnLulIeCY/YNs1YAaxOtP1
	R+Xls2+qUwsDURliJSPH7y8=
X-Received: by 2002:a05:600c:6748:b0:483:71f7:2782 with SMTP id 5b1f17b1804b1-485570ce1damr180568025e9.12.1773651865743;
        Mon, 16 Mar 2026 02:04:25 -0700 (PDT)
Received: from FRSMI24-BLUE.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485563903bbsm143241335e9.0.2026.03.16.02.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 02:04:25 -0700 (PDT)
From: pierre-loup.gosse@smile.fr
To: bitbake-devel@lists.openembedded.org
Cc: Pierre-Loup GOSSE <pierre-loup.gosse@smile.fr>
Subject: [PATCH 1/1] fetch: AWS Codeartifact fetcher
Date: Mon, 16 Mar 2026 10:04:20 +0100
Message-Id: <20260316090420.914602-1-pierre-loup.gosse@smile.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 16 Mar 2026 09:04:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19156

From: Pierre-Loup GOSSE <pierre-loup.gosse@smile.fr>

Class to fetch AWS Codeartifact asset with the AWS cli. The aws tool
must be correctly installed and configured prior to use.

Signed-off-by: Pierre-Loup GOSSE <pierre-loup.gosse@smile.fr>
---
 lib/bb/fetch2/__init__.py     |  2 +
 lib/bb/fetch2/codeartifact.py | 94 +++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)
 create mode 100644 lib/bb/fetch2/codeartifact.py

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index dcf7adc26..411b3012d 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -2119,6 +2119,7 @@ from . import az
 from . import crate
 from . import gcp
 from . import gomod
+from . import codeartifact
 
 methods.append(local.Local())
 methods.append(wget.Wget())
@@ -2140,3 +2141,4 @@ methods.append(crate.Crate())
 methods.append(gcp.GCP())
 methods.append(gomod.GoMod())
 methods.append(gomod.GoModGit())
+methods.append(codeartifact.Codeartifact())
diff --git a/lib/bb/fetch2/codeartifact.py b/lib/bb/fetch2/codeartifact.py
new file mode 100644
index 000000000..d6035b20b
--- /dev/null
+++ b/lib/bb/fetch2/codeartifact.py
@@ -0,0 +1,94 @@
+
+# Copyright (C) 2025 Pierre-Loup GOSSE
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Based on functions from the base bb module, Copyright 2003 Holger Schurig
+
+"""
+BitBake 'Fetch' implementation for AWS Codeartifact asset.
+
+Class to fetch AWS Codeartifact asset with the AWS cli.
+The aws tool must be correctly installed and configured prior to use.
+
+  SRC_URI = "codeartifact://<domain-owner>@<domain>/<repository>/<namespace>/<package>/<package-version>/<asset>;format=<format>;unpack=0"
+
+The package path should use '/' instead of '.'.
+The format of the package is a required URL parameter.
+Refer to https://docs.aws.amazon.com/codeartifact/latest/ug/download-assets.html.
+
+For example:
+
+  SRC_URI = "codeartifact://111122223333@my_domain/my_repo/com/google/guava/guava/27.1-jre/guava-27.1-jre.jar;format=maven;unpack=0"
+
+    domain-owner:       111122223333
+    domain:             my_domain
+    repository:         my_repo
+    namespace:          com.google.guava
+    package:            guava
+    package-version:    27.1-jre
+    asset:              guava-27.1-jre.jar
+    format:             maven
+
+"""
+
+import os
+import bb
+import re
+import urllib.request, urllib.parse, urllib.error
+from bb.fetch2 import Fetch, FetchMethod, FetchError, MalformedUrl, runfetchcmd, check_network_access
+
+class Codeartifact(FetchMethod):
+    """Class to fetch AWS Codeartifact asset via 'aws cli'"""
+
+    def supports(self, ud, d):
+        """
+        Check to see if a given url can be fetched with aws cli.
+        """
+        return ud.type in ['codeartifact']
+
+    def urldata_init(self, ud, d):
+        ud.basename = os.path.basename(ud.path)
+        ud.basecmd = d.getVar("FETCHCMD_codeartifact") or "aws codeartifact"
+        ud.localfile = d.expand(urllib.parse.unquote(ud.basename))
+
+        if 'format' in ud.parm:
+            ud.format = ud.parm['format']
+
+        if not ud.format:
+            raise MissingParameterError("Parameter 'format' required", ud.url)
+
+        m = re.compile('/(?P<repository>[^/]+)/(?P<namespace>.+)/(?P<package>[^/]+)/(?P<version>[^/]+)/(?P<file>[^/]+)').match(ud.path)
+        if not m:
+            raise MalformedUrl(ud.url, "The URL '%s' is invalid: path must contain /<repository>/<namespace>/<package>/<package-version>/<asset>" % ud.url)
+
+        ud.repository = m.group('repository')
+        ud.namespace = m.group('namespace').replace("/", ".")
+        ud.package = m.group('package')
+        ud.version = m.group('version')
+        ud.file = m.group('file')
+
+    def download(self, ud, d):
+        """
+        Fetch urls
+        Assumes localpath was called first
+        """
+        cmd = '%s get-package-version-asset --domain %s --domain-owner %s --repository %s \
+                --format %s --namespace %s --package %s --package-version %s --asset %s %s' % \
+                (ud.basecmd, ud.host, ud.user, ud.repository, ud.format, ud.namespace, ud.package, ud.version, ud.file, ud.file)
+        check_network_access(d, cmd, ud.url)
+
+        return runfetchcmd(cmd, d, False)
+
+    def checkstatus(self, fetch, ud, d):
+        """
+        Check the status of a URL
+        """
+
+        cmd = '%s list-package-version-assets --domain %s --domain-owner %s --repository %s \
+                --format %s --namespace %s --package %s --package-version %s' % \
+                (ud.basecmd, ud.host, ud.user, ud.repository, ud.format, ud.namespace, ud.package, ud.version)
+        check_network_access(d, cmd, ud.url)
+        runfetchcmd(cmd, d)
+
+        return True
-- 
2.34.1


