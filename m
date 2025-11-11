Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6D7CCFA18
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 17:25:30 +0000 (UTC)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23188.1762881925616456146
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Nov 2025 09:25:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=b5gTaMcM;
 spf=pass (domain: gmail.com, ip: 209.85.210.48, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7c70e53db41so11761a34.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 09:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762881925; x=1763486725; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GFv5LqA3Fn7273usKjDvA38ahB/v4mIwfmOJ/jn8w4U=;
        b=b5gTaMcMvxP3Yxg8Xk14rMr5ngU2I9EEb4a3ncy3FkYC/EVbURDRt/d4eT91T40xsU
         ukFCq/jNRYwBOQyNGqNAvl+9gbR1epHg1WysIHyOviadTVR+1mzwxMT0DDtK1bc93LRd
         S/+0gMJ4pX5x71RPxqS4sKJuFv72er4DFgSW9IpcKoUPQsItOAaXpO44IKY+md75qUSW
         3HOpn8y2jmqNJVKypYfqX+8mUWmaN37LX+Hbmk5HYRof25CmN4mXRouGgF14RalqbwI3
         Rosg7uWue8Ti4ltrt0vtd3LLvd7ZRsJ0hQ8T6hwF1p4YNcZ7pLsooEzd28E6eaDUlcqf
         GmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762881925; x=1763486725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFv5LqA3Fn7273usKjDvA38ahB/v4mIwfmOJ/jn8w4U=;
        b=XakuSQilW8xeGhS2UqRCDZ8UAUJ/lQ50hx2P11MjIfUVTtMI1GNhqWL6tXWoBCD7FQ
         CZoSZJ4XD+pTYbPdxq4jam5w6tYeECGEqVu85SX3O9e1Lc7cO6Q77g2mZKA5NawRZbxy
         U7ZJp0corwGQD5NGgknoxOyZ/VmpDTYdXi1B4myh54RtPoXQCeeDTN4LxWSHDKV6/+JP
         e/vtSCRO75iMk13U7Wj0D41JfWK00EWThc4NhPBYI//ov0RXdAUTGAh26DaHQcwk7yaA
         KqD7utOwgB3ec1Eq3OrCYGhQQCv0lxMFR7kZU+J8uB1HTXsFaxKLIzPcg6ECTqnP6MJd
         vF5g==
X-Gm-Message-State: AOJu0YyFDULGn7ijRNv4YUZWFdAAHnb8QJv6A19Mb7q4ZmIwwRvx1/Y3
	b+C4ru/RrDnexiHzqA7a2zs/wkQ4tQO/lf5DkzV3peW1zjQiHkhdPPd/OfoPGw==
X-Gm-Gg: ASbGncumODE75UxGSUwgDT5oMPG5y1HHef9R+XBxtKKbwHyyanIGfLoknyoXHtBQJYQ
	l7P/EE+frwooDb+n5FtzOnMuMSr2kQb99we0zJBO20xelQuEfHjotaQ8b8MDXLF2sN0B/OYDEOQ
	Q2jUkh4iTz3s9Q8NPqXEuvqURmLtvjsMkougtmseW/3sqKr35p0ao9kj/+bUBqxX6AzGEEurwHd
	EjgDy2lZweKWQyASNtYEEoQ2SUixfVdjauBCh/v9bdz0jHVgvGK+8Yd7zmoZT+GtEihyZ8DGCVi
	8zHe8jEMFEBkaDTejbRxezh+NEsT4hhq5kGVN6hfMkiEdCNKS2AAK97DdKoyihfNv1fpzhbXFPk
	ojff599sx/9v6GpD8eKCm1wkHzogvcQIEI6CMUbB1nXsfs19YL6ARyalbqP0ZyIXCNZpjwWT/aw
	==
X-Google-Smtp-Source: AGHT+IHthst3yEaySinjGq6aCeMoiDNeHlFrYNvIr2jG8vRERzbgl1+xnTjoXp2gAYInvaa9fXbWpw==
X-Received: by 2002:a05:6808:2f05:b0:44d:a3a1:c86 with SMTP id 5614622812f47-4502a1cb8fcmr6161632b6e.22.1762881924737;
        Tue, 11 Nov 2025 09:25:24 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4300:19e0::9115])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4500253abcdsm7078127b6e.2.2025.11.11.09.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 09:25:24 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] bitbake-setup: Prompt setup directory name
Date: Tue, 11 Nov 2025 10:25:22 -0700
Message-ID: <20251111172522.2838760-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 17:25:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18331

If the setup directory is not specified on the command line, prompt the
user if they would like to change it. This allows the user to use an
alternative name (e.g. a terser one) at setup time.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bin/bitbake-setup | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index c32381e50..86c556944 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -466,7 +466,18 @@ def init_config(top_dir, settings, args, d):
     upstream_config = obtain_config(top_dir, settings, args, source_overrides, d)
     print("\nRun 'bitbake-setup init --non-interactive {}' to select this configuration non-interactively.\n".format(" ".join(upstream_config['non-interactive-cmdline-options'])))
 
-    setupdir = os.path.join(os.path.abspath(top_dir), args.setup_dir_name or "{}-{}".format(upstream_config['name']," ".join(upstream_config['non-interactive-cmdline-options'][1:]).replace(" ","-").replace("/","_")))
+    if args.setup_dir_name:
+        setup_dir_name = args.setup_dir_name
+    else:
+        setup_dir_name = "{}-{}".format(upstream_config['name']," ".join(upstream_config['non-interactive-cmdline-options'][1:]).replace(" ","-").replace("/","_"))
+        if not args.non_interactive:
+            n = input(f"Enter setup directory name, or 'N' to quit ({setup_dir_name}): ")
+            if n == 'N':
+                exit()
+            elif n:
+                setup_dir_name = n
+
+    setupdir = os.path.join(os.path.abspath(top_dir), setup_dir_name)
     if os.path.exists(os.path.join(setupdir, "layers")):
         print(f"Setup already initialized in:\n    {setupdir}\nUse 'bitbake-setup status' to check if it needs to be updated, or 'bitbake-setup update' to perform the update.\nIf you would like to start over and re-initialize in this directory, remove it, and run 'bitbake-setup init' again.")
         return
-- 
2.51.1


