Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
	[209.85.212.181])
	by mail.openembedded.org (Postfix) with ESMTP id F2EA86B8AD
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  3 Jun 2014 15:26:16 +0000 (UTC)
Received: by mail-wi0-f181.google.com with SMTP id n15so6814463wiw.14
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 03 Jun 2014 08:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=KjvauLoRowmM8+MQYvhpZYA0mKC9SaLIbUa4+rdgjuI=;
	b=TpfyCV05xKQPUz0+mxRVH3vA6Km7Bx0BxF3F5DTauHuWqdzNuNU5zCurEfNuzdFlkJ
	AT4JVNOBP5ZPCKQX1sQRwT3AN0ijdazg0soqzk+Zhw62DvON+uYz8e+PTxxJRIF0YFDy
	/+vBrRgGzW+ugyWMKLX7Rsmso04HOWvz0/PdgawmmaUaia8CO86uECuyATTzDxtxPFni
	qlu2jFDF5V0xu2WDFe4gPdTJzasRG4Y3vE7dcS0CtvloAZ0etqbtE6jUdnBfGgEHEkGl
	R3pwXp8X6XdXYshYaRnF6ezXtAFIc9uGPwDWP2OBNeLPsqkpCEbCEQsJ2ccZ/65NbiyZ
	RDYw==
X-Gm-Message-State: ALoCoQm3K/Onq7/GWksZ+RDbybOqfq1OHb5KJ2cXT1HbEn0MhV+/8xTeOWCN6PhCSoihN6wTkfWT
X-Received: by 10.194.57.38 with SMTP id f6mr59531844wjq.59.1401809177461;
	Tue, 03 Jun 2014 08:26:17 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id gb6sm20345554wic.6.2014.06.03.08.26.16
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 03 Jun 2014 08:26:16 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id CFC73561B10; Tue,  3 Jun 2014 16:26:18 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  3 Jun 2014 16:26:14 +0100
Message-Id: <6bbeb6b2f80e13d763e8ff2247a37259951046f0.1401808899.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <b6ae17f19c56ec99362290dd701542373720e572.1401808899.git.alexandru.damian@intel.com>
References: <b6ae17f19c56ec99362290dd701542373720e572.1401808899.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1401808899.git.alexandru.damian@intel.com>
References: <cover.1401808899.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 5/9] toaster: startup script noweb mode
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
X-List-Received-Date: Tue, 03 Jun 2014 15:26:22 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We add an option to the startup script, named "noweb" that
will start toaster without the embedded web server.

This is useful to start the system for build-only environments,
where the web server code is running on a different machine.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bin/toaster | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/bin/toaster b/bin/toaster
index dea69a4..f81e667 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -146,11 +146,15 @@ else
 fi
 
 NOTOASTERUI=0
+WEBSERVER=1
 for param in $*; do
     case $param in
     noui )
             NOTOASTERUI=1
     ;;
+    noweb )
+            WEBSERVER=0
+    ;;
     esac
 done
 
@@ -176,7 +180,7 @@ case $CMD in
     start )
         start_success=1
         addtoConfiguration "INHERIT+=\"toaster buildhistory\"" toaster.conf
-        if ! webserverStartAll; then
+        if [ $WEBSERVER -gt 0 ] && ! webserverStartAll; then
             echo "Failed ${CMD}."
             return 4
         fi
-- 
1.9.1


