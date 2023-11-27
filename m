Return-Path: <charlie.johnston@loftorbital.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786E0C4167B
	for <webhook@archiver.kernel.org>; Mon, 27 Nov 2023 18:14:40 +0000 (UTC)
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
 by mx.groups.io with SMTP id smtpd.web11.102213.1701108870210869741
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Nov 2023 10:14:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@loftorbital.com header.s=google header.b=igL0NGCl;
 spf=pass (domain: loftorbital.com, ip: 209.85.166.173, mailfrom: charlie.johnston@loftorbital.com)
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-35cc26b399fso3414245ab.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 27 Nov 2023 10:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=loftorbital.com; s=google; t=1701108869; x=1701713669; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ENxnZINMQMShmNP9yKaZdH1p4GibpYXZD4XoEoIdJek=;
        b=igL0NGClKnB/vxiFMjSQioouFm9qjLhxKAwwJJFC3UFdt2L2GhJzWl6OAQlXoY7gZg
         aOaXTILRNXBwW9tsgW7qg/9Ma+TTHWCA7TtNmdm/tkCPOYD2+5mXkZ2FzeAHxlZfiZo0
         VPcsgeo77g330UXQMNKQmxSwCX/8qdHV4pEFm3aGs+vkY7lfy3aPJbY7mhJdRIE5mGBM
         WLvrP8JVzh/Pgy9NpJ6XOcRQQqr6mgdnkUv6Z8KzEmRHaT5LK88+XAGc3lgpLJDCHqc7
         2oE+mJq6a0xTo2RAUjh8mp5qTXgKaSKrtnkho4ovZSvTBmiV8WGG/2HqUnmbAmbBIKoc
         sKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701108869; x=1701713669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ENxnZINMQMShmNP9yKaZdH1p4GibpYXZD4XoEoIdJek=;
        b=OwUZEDgRSGtxIRV9JJc1CC5aFISYylydqoLCN4AkeudyLCQKCO3loaguFkGVefJdgA
         ppNuBFR5yHEXpNXVk9qD1wBOBfN/+6k6iS5/l8nUSAyLiPcsH5KNsSgHzKfobN1PRV+M
         WiZhTmmtomI3Fb+ICgtmo33Dp1za+5aD4NaJ/pHBeiDr/rs7glnO3hPzpstDrfyxJDc6
         u2QlYNkeixkYIsZGJjCXqZTtCAbFNEqzg/F33q2za7UEwmsbu6kFn+ONDfl/49xXNliN
         JU6RWaC46HXXpJV+mtiV4b0ririTxM05KQgHQTwJJDLI+lhWP6Jf2ASSHaFuXxpt0mQV
         qBFg==
X-Gm-Message-State: AOJu0YwXYMFXjLBRx7HKBUg+IB0F8Qd5Pc2PgNRikBVrcsphsH7xck3A
	kh/NfVhoZM5l4SMtIsY8Mh+b19/BCxnShrVXukwaxw==
X-Google-Smtp-Source: AGHT+IHzMQxPwcPAj0jA4mGni5lYOAW1KqFSAp+IASHtbm+bIyuQ7rf5tJi7am5gbItnd4olXGAehA==
X-Received: by 2002:a05:6e02:1c4b:b0:35c:d0b2:2c8 with SMTP id d11-20020a056e021c4b00b0035cd0b202c8mr3885633ilg.16.1701108869159;
        Mon, 27 Nov 2023 10:14:29 -0800 (PST)
Received: from localhost.localdomain (71-211-94-90.phnx.qwest.net. [71.211.94.90])
        by smtp.gmail.com with ESMTPSA id r9-20020a92d449000000b0035260e105fdsm224634ilm.36.2023.11.27.10.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 10:14:28 -0800 (PST)
From: Charlie Johnston <charlie.johnston@loftorbital.com>
To: bitbake-devel@lists.openembedded.org
Cc: Charlie Johnston <charlie.johnston@loftorbital.com>
Subject: [PATCH] fetch2: Ensure GCP fetcher checks if file exists before download.
Date: Mon, 27 Nov 2023 06:11:47 -0700
Message-Id: <20231127131147.1128798-1-charlie.johnston@loftorbital.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Nov 2023 18:14:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15576

The GCP fetcher was calling bb.fetch2.check_network_access with
"gsutil stat" as the command, but then never actually ran that
command to check if the file exists. In cases where the file did
not exist in a gs:// premirror, this would lead to an unhandled
exception from do_fetch when the GCP python API tried to perform
the download.

This change resolves that issue by adding a runfetchcmd to call
gsutil.

Signed-off-by: Charlie Johnston <charlie.johnston@loftorbital.com>
---
 lib/bb/fetch2/gcp.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/gcp.py b/lib/bb/fetch2/gcp.py
index f42c81fd..f40ce2ea 100644
--- a/lib/bb/fetch2/gcp.py
+++ b/lib/bb/fetch2/gcp.py
@@ -47,6 +47,7 @@ class GCP(FetchMethod):
             ud.basename = os.path.basename(ud.path)
 
         ud.localfile = d.expand(urllib.parse.unquote(ud.basename))
+        ud.basecmd = "gsutil stat"
 
     def get_gcp_client(self):
         from google.cloud import storage
@@ -61,7 +62,8 @@ class GCP(FetchMethod):
         if self.gcp_client is None:
             self.get_gcp_client()
 
-        bb.fetch2.check_network_access(d, "gsutil stat", ud.url)
+        bb.fetch2.check_network_access(d, ud.basecmd, f"gs://{ud.host}{ud.path}")
+        runfetchcmd("%s %s" % (ud.basecmd, f"gs://{ud.host}{ud.path}"), d)
 
         # Path sometimes has leading slash, so strip it
         path = ud.path.lstrip("/")
@@ -88,7 +90,8 @@ class GCP(FetchMethod):
         if self.gcp_client is None:
             self.get_gcp_client()
 
-        bb.fetch2.check_network_access(d, "gsutil stat", ud.url)
+        bb.fetch2.check_network_access(d, ud.basecmd, f"gs://{ud.host}{ud.path}")
+        runfetchcmd("%s %s" % (ud.basecmd, f"gs://{ud.host}{ud.path}"), d)
 
         # Path sometimes has leading slash, so strip it
         path = ud.path.lstrip("/")
-- 
2.39.2


