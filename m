Return-Path: <jpewhacker@gmail.com>
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com
	[209.85.166.54])
	by mail.openembedded.org (Postfix) with ESMTP id 789E661B81
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Mar 2020 16:34:11 +0000 (UTC)
Received: by mail-io1-f54.google.com with SMTP id t26so2002448ios.11
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Mar 2020 09:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=hCgIvHD59xsgRqfZMB6CTMQI4T85FazB2pSoVx1yVrE=;
	b=hH/dWKic9tKZJvlSezKvA1/R5xCNOAM7VgQFq3C2IaDeYLkQmY1via/U4H7zn5aY97
	DWl26sKHcV2Fb+55uYx2ZSXmLanO9nZYqO1nPbQeC8LysljDzUuEHr3oNrx/FHgZinyX
	D9cDKhi966z8c3cuUq3WcJy7O0ESojEQKd6FkXy4u7PNzhJvS+CeKKM0+760DOVPC2p6
	OkAnLujS7QEWWTx7FkM1ZBZJ6w8e0Q4kp1G/HejinC86JRko6vn2IDkC8uEGLKW4GgUN
	BxzVmhflkXZ5N64pBwRv/EreHJbiMgmkIUS1jiO8dOE2Mu6+Bx8PehoLZusR4bIv6IV4
	Cn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=hCgIvHD59xsgRqfZMB6CTMQI4T85FazB2pSoVx1yVrE=;
	b=quCLzeeQ+O/b5ZonF4GZntUGYvVNSWWbj4LUneR5R8Yjim8onzopO9rGu1wcpQhg20
	r04RhhT2c4irpsmWpBX0eZOvyztxhBCYEN3snbaymmO/yjOBYQF3HGM737ZauYGRGwzM
	ZaYgm+h/S4XwrwqpwHiUqKWxuqwfYC9fh8Cf3eK0dzT9FNGxC3n6xFGoNFdp3aQ07BBs
	LtHZvPv7TCLKQQxTOcCbXBg4CF2By463IMSK6Ohm2/Sf9aIpMioky1KYDKPRMr+jJvQg
	QG3uVH5k4FdtcF6U1Xs5PK4uZwA3doIttXhiKalcCEKq0ABm2utHHPoCbL015570R6LR
	lx/Q==
X-Gm-Message-State: ANhLgQ3uvNxcST8RUHeC7aDHYvQsRE4k0OixtOk0z3/ZEIEHRAR/0/J6
	icPLCIJHjzmFmbqgIrrgEhF//CY70Uc=
X-Google-Smtp-Source: ADFU+vuCU6/O6/5itRtQqNzLZqweth16lsaVTahf2Gb3x/mnNCVIAC6bftU3FZGw8HnDdH/kA/ZNGg==
X-Received: by 2002:a02:8184:: with SMTP id n4mr16069273jag.31.1583771652260; 
	Mon, 09 Mar 2020 09:34:12 -0700 (PDT)
Received: from OLA-8C37N23.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	q1sm15049593ile.71.2020.03.09.09.34.10
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 09 Mar 2020 09:34:11 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Mar 2020 11:33:51 -0500
Message-Id: <20200309163353.15362-14-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309163353.15362-1-JPEWhacker@gmail.com>
References: <20200309163353.15362-1-JPEWhacker@gmail.com>
Cc: docs@lists.yoctoproject.org
Subject: [PATCH 13/15] bitbake: Add autobuilder logging configuration
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
X-List-Received-Date: Mon, 09 Mar 2020 16:34:11 -0000

Adds a configuration file that the autobuilder can use to capture
interesting logging domains above the ones that show up for normal users
on stdout/stderr.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/contrib/autobuilderlog.json | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 bitbake/contrib/autobuilderlog.json

diff --git a/bitbake/contrib/autobuilderlog.json b/bitbake/contrib/autobuilderlog.json
new file mode 100644
index 0000000000..103a1141f6
--- /dev/null
+++ b/bitbake/contrib/autobuilderlog.json
@@ -0,0 +1,27 @@
+{
+    "version": 1,
+    "handlers": {
+        "autobuilderlog": {
+            "class": "logging.FileHandler",
+            "formatter": "logfileFormatter",
+            "level": "DEBUG",
+            "filename": "autobuilder.log",
+            "mode": "w"
+        }
+    },
+    "formatters": {
+            "logfileFormatter": {
+                "format": "%(name)s: %(levelname)s: %(message)s"
+            }
+    },
+    "loggers": {
+        "BitBake.SigGen.HashEquiv": {
+            "level": "VERBOSE",
+            "handlers": ["autobuilderlog"]
+        },
+        "BitBake.RunQueue.HashEquiv": {
+            "level": "VERBOSE",
+            "handlers": ["autobuilderlog"]
+        }
+    }
+}
-- 
2.17.1


