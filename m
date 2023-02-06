Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6B2C05027
	for <webhook@archiver.kernel.org>; Mon,  6 Feb 2023 14:49:34 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web10.54974.1675694965316173181
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 06 Feb 2023 06:49:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=J7sbnd0E;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.175, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f175.google.com with SMTP id 203so8550110pfx.6
        for <bitbake-devel@lists.openembedded.org>; Mon, 06 Feb 2023 06:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pK3SjbXBWmFtVR/ArT1F/MwZPxfmmG1xmcW6UY+T6qc=;
        b=J7sbnd0E5NDloPGDboiQq5+Y0nyI/RGTXRI+2+KSjqWhrdKKPmtKOqTxTXUumntL74
         nd7qcLPSBhh+hpeIDrkTgkm7gzs3GsfznzoNR9EbbTCazSk+7dUgFSYkYczNNCS+bnBc
         ZvEtisBKafYeCR0lwgqyqkBQ7+H7aHU9lECIRsEga8mTMukUgwjGhtk1lHXf9iBGS8hX
         Dc+Au05PX46l7B8UhmTVORQFdT454UqBs/VaIFw+9jqpOxaz8PtrZz4CKJ/kQ3F7iBWy
         buKM5NqvcYPoZ1JczChr36ljaHyawlrSzPkF9dUJwLGjU9fqAiOM/40Ia7kHngfVi7sh
         ckGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pK3SjbXBWmFtVR/ArT1F/MwZPxfmmG1xmcW6UY+T6qc=;
        b=K3hGHJmz94sXVrzY7YIGowWMB4ReHHMKKS8gDFMJMzxVh5e/u+tCILI+q8UHVVvZMB
         iiZU2/9lg5uZJlZBB3aO3d8mDt/oY44xON8+LrT227mPecFk3iIDx1VJTYIrV8qn6zks
         jF4mMHu1rHlY+8dYXYN+FiiGBW1Z3y5fYwn59yD2748lhdh9it5GsViE4gwWfvsCnW0P
         DiEDQs+knxzQTBVbjilazzJN4QPQ+CvRbT/PEabavIzGmrOuq/55/d8MTgtcUXcdOw8m
         /98hOJoZCVJ5thtiEf9r2oSsA/bC7ZtAVyeb0Nb9msDqExeIs1WEolqfxe4kHI8wdaas
         /XCg==
X-Gm-Message-State: AO0yUKUWI2Srd7D3C/fDlPb8La/gbQPXqqu3apKbx7x2UpmORuTEUdc+
	3oqzuH9T/e7cL3yC8grU+BcG4H375J3PuV1qoQ4=
X-Google-Smtp-Source: AK7set/xdQ/nLqHwVKKxmvfX6whx4U2Peh11jXBIf9wTp7P0PqVq7cj9o9RQX9HxJND/2q8D5A3lFg==
X-Received: by 2002:a05:6a00:228d:b0:58d:ac19:8950 with SMTP id f13-20020a056a00228d00b0058dac198950mr13525792pfe.33.1675694963993;
        Mon, 06 Feb 2023 06:49:23 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-4-112.hawaiiantel.net. [72.253.4.112])
        by smtp.gmail.com with ESMTPSA id y5-20020a62b505000000b00588fb6fafe0sm7166994pfe.188.2023.02.06.06.49.22
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 06:49:23 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH] bb/utils: include SSL certificate paths in export_proxies
Date: Mon,  6 Feb 2023 04:49:18 -1000
Message-Id: <b858d1efc6f4345a77c28595afa8c85ee1294706.1675694307.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1675694307.git.steve@sakoman.com>
References: <cover.1675694307.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 06 Feb 2023 14:49:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14372

From: Ross Burton <ross.burton@arm.com>

bb.utils.export_proxies() is a poor-man's alternative for the
environment setup code in bb/fetch2, but it's used in several places
where recipes want to download manually (such as cve-update-db-native).

Notably, export_proxies() doesn't pass on the SSL certificate paths from
the original environment, so if SSL_CERT_FILE needs to be set (for
example, in a buildtools environment) then proxies work but SSL doesn't.

In an ideal world export_proxies and the same logic in fetch2 would
merge, but until then we can add the SSL_CERT_ variables and duplicate
the basic logic: check the datastore first and then the original
environment for variables.

[ YOCTO #15000 ]

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit c19035e8e71c419c5688a86bfc9c946c96f638e8)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/utils.py | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 82602466..1a5a0aae 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1570,21 +1570,22 @@ def set_process_name(name):
 
 # export common proxies variables from datastore to environment
 def export_proxies(d):
-    import os
+    """ export common proxies variables from datastore to environment """
 
     variables = ['http_proxy', 'HTTP_PROXY', 'https_proxy', 'HTTPS_PROXY',
                     'ftp_proxy', 'FTP_PROXY', 'no_proxy', 'NO_PROXY',
-                    'GIT_PROXY_COMMAND']
+                    'GIT_PROXY_COMMAND', 'SSL_CERT_FILE', 'SSL_CERT_DIR']
     exported = False
 
-    for v in variables:
-        if v in os.environ.keys():
+    origenv = d.getVar("BB_ORIGENV")
+
+    for name in variables:
+        value = d.getVar(name)
+        if not value and origenv:
+            value = origenv.getVar(name)
+        if value:
+            os.environ[name] = value
             exported = True
-        else:
-            v_proxy = d.getVar(v)
-            if v_proxy is not None:
-                os.environ[v] = v_proxy
-                exported = True
 
     return exported
 
-- 
2.25.1


