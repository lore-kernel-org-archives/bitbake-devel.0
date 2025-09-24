Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D4ECAC5A5
	for <webhook@archiver.kernel.org>; Wed, 24 Sep 2025 10:32:26 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web10.9476.1758709943936309775
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 24 Sep 2025 03:32:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GV81IaPh;
 spf=pass (domain: gmail.com, ip: 209.85.128.52, mailfrom: quaresma.jose@gmail.com)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45ed646b656so57632625e9.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 24 Sep 2025 03:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758709942; x=1759314742; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2LPbK88nc6SdkJvqQv2gYthLyoD/EXO3h9vqpi5cEsI=;
        b=GV81IaPhccH7HwFoTZfX49UnQ/Ue7QrpwE2gcpq+xTZYNebc40ywUM94yIQcsSdccB
         g37WEOcuuZIOcKT5v4NFRf7f9x3RJ31IjKRhTsLHNgfNRJHe8llpfatdL4l6CnfD/0CF
         0OSE6Rk933Su7DSGcdNF1JWSuPG2jKTjepxifs6Pcj5adO4ymu5v4a6omWOEEtFEeCAj
         vpVb+D0c46kgUhsXrtqjn0CjHs0Qqa7hdXxsY//2zW3x6dvXGHRESVSLsDCi9GcsnwHu
         5sE/rcbNROUoBf0dkJXczbK1GDGAwC7UkNH3/udRaQHWsCHfL8sBtRdxd2DtPxCFGReg
         XtKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758709942; x=1759314742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2LPbK88nc6SdkJvqQv2gYthLyoD/EXO3h9vqpi5cEsI=;
        b=Y8+kMQtfnXbYB+dYizQ6LKVwCDCBuzUAFvFwK6IecxniUzlnIqWjBXAVNi27HPdk5G
         UHmsYHGETr+PVWIK8gNRRPdidK3m9pFIWxaKP7P1NYPZex4RNNNdafzGgoe/AgGRZNd/
         JtJQyXz1BxrHjhzCi6nJwLqD1xJV9unQbMqiyyvwquk6SZghdbpeRlB9vqX6fAgVU9Fi
         bE051pU3g5twgwfwkXw/sFW4o4FFww50UykH+bE6BQOChlPXLU3ECcjyhVskqBN95KOr
         cRsfTtNiH6BmKyb1kNCj0+qpLObb6avKZS6K/qkW/Z0lq9IcL9cJwtVrKc+RddetWCvs
         O2aw==
X-Gm-Message-State: AOJu0Yxi6Gx3iofLViM1A7V1YyGlgHQ6hBxGuedtUAiUbe5/BYR9oZfp
	Jrq95t3RwF6+uvhlYBlLT7BVHJdJvwujSZlh6vXqMDPvMZwZTmL+VshOLm8nfg==
X-Gm-Gg: ASbGncusZ41sp/gpml9s7K606B1Y1v325tzwYpASypkjQE1M8tOyRgLyD5H9Z0x8zZE
	9Mk5JrE7RO4PrLE5NTg4S7HwvGNHLpgp3/98EnJ/WMMVEqDDpkxHUECf8wswnJsEuz8/PZqxtdK
	sdeVXL4Eo6wFzbbgglpEDOvhocfYKZCVR55UFZmsayH2nV6pF2yBduVVZNKN+P+UDVQHMPPwZaw
	pbNsRkQJUCrYS/y/9Jk2pHYHRsgVfxyy0I5VWH0juZK+FIp/0J0e0SqpAA0F+sqTwy0Iw7zv6tb
	Ainfoh0Li1Xf5ZcmYfDAXe1D39Q1UaujXoP42Yr7+ySw53cTct1Xurlf4VBtc7TkUGUdpyGn7bj
	3Eqplao8udwYVqsEUjLWRJQ==
X-Google-Smtp-Source: AGHT+IH9pbK8k8QiTc35QwvQTawwYehmw83SgYd56kzW+jBzszBXd3nRg15F20KG82GGBL7QDaqxAw==
X-Received: by 2002:a05:6000:610:b0:3e7:5f26:f1ea with SMTP id ffacd0b85a97d-405c5bd86c9mr5464898f8f.20.1758709941734;
        Wed, 24 Sep 2025 03:32:21 -0700 (PDT)
Received: from fio ([185.228.162.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab61eecsm26201605e9.20.2025.09.24.03.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 03:32:20 -0700 (PDT)
From: Jose Quaresma <quaresma.jose@gmail.com>
X-Google-Original-From: Jose Quaresma <jose.quaresma@foundries.io>
To: bitbake-devel@lists.openembedded.org
Cc: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
Subject: [RFC PATCH] cooker: add support for more than one server in BB_HASHSERVE_UPSTREAM
Date: Wed, 24 Sep 2025 11:32:01 +0100
Message-ID: <20250924103201.936605-1-jose.quaresma@foundries.io>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 24 Sep 2025 10:32:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18083

From: Jose Quaresma <jose.quaresma@oss.qualcomm.com>

Making the use of python websockets mandatory when connecting to hashserve could
create several difficulties for users, especially when the python-python is not
available in the distribution used.
So it will be better to have a list of servers where for example we can
have a second fallback in case it is not possible to use the first one.

If it is not possible to use any server from the specified list, this will
cause a fatal error.

Signed-off-by: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
---
 lib/bb/cooker.py | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index fb87368f1..976065622 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -312,21 +312,25 @@ class BBCooker:
             # Create a new hash server bound to a unix domain socket
             if not self.hashserv:
                 dbfile = (self.data.getVar("PERSISTENT_DIR") or self.data.getVar("CACHE")) + "/hashserv.db"
-                upstream = self.data.getVar("BB_HASHSERVE_UPSTREAM") or None
-                if upstream:
-                    try:
-                        with hashserv.create_client(upstream) as client:
-                            client.ping()
-                    except ImportError as e:
-                        bb.fatal(""""Unable to use hash equivalence server at '%s' due to missing or incorrect python module:
-%s
-Please install the needed module on the build host, or use an environment containing it (e.g a pip venv or OpenEmbedded's buildtools tarball).
-You can also remove the BB_HASHSERVE_UPSTREAM setting, but this may result in significantly longer build times as bitbake will be unable to reuse prebuilt sstate artefacts."""
-                                 % (upstream, repr(e)))
-                    except ConnectionError as e:
-                        bb.warn("Unable to connect to hash equivalence server at '%s', please correct or remove BB_HASHSERVE_UPSTREAM:\n%s"
-                                 % (upstream, repr(e)))
-                        upstream = None
+                hashserve_upstream_list = self.data.getVar("BB_HASHSERVE_UPSTREAM") or None
+                upstream = None
+                if hashserve_upstream_list:
+                    for hashserve_upstream in hashserve_upstream_list.split():
+                        try:
+                            with hashserv.create_client(hashserve_upstream) as client:
+                                client.ping()
+                                upstream = hashserve_upstream
+                                break
+                        except ImportError as e:
+                            bb.warn("Unable to connect to hash equivalence server at '%s' due to missing or incorrect python module:\n%s"
+                                    % (hashserve_upstream, repr(e)))
+                        except ConnectionError as e:
+                            bb.warn("Unable to connect to hash equivalence server at '%s':\n%s"
+                                    % (hashserve_upstream, repr(e)))
+
+                if hashserve_upstream_list and not upstream:
+                    bb.fatal("""Unable to use hash equivalence server:
+    You can also remove the BB_HASHSERVE_UPSTREAM setting, but this may result in significantly longer build times as bitbake will be unable to reuse prebuilt sstate artefacts.""")
 
                 self.hashservaddr = "unix://%s/hashserve.sock" % self.data.getVar("TOPDIR")
                 self.hashserv = hashserv.create_server(
-- 
2.51.0


