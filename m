Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f41.google.com (mail-wg0-f41.google.com [74.125.82.41])
	by mail.openembedded.org (Postfix) with ESMTP id 19DDE73236
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 14:18:00 +0000 (UTC)
Received: by wgbgq6 with SMTP id gq6so37855331wgb.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 07:18:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=N9HeL1r1cvbJyEx4eIclblbbhcqZW9l5hnIYC5o2p70=;
	b=mJla/+mpWN2r8uJ9ZKqp5UbrCBHYGRO7+Vz81whuZzY3UxvqZQd3POA4x7KawEISMP
	EBjcHHN4BL7GWUKCD8OTZx42cVeOBrHCev389E421D1qRU5o6jZAjJ37QzvXk9Q/L6ty
	H2C1KeqzikTYjJqEpHUoQalyYpbLLcxBB1bW97/FoK69aviSmbVRRnEpNJqJh2yh+9TQ
	Z3SNIB+kBn/uRU+HTW6+91zDCdohWjng2waYtDVIPnC6o0o2fAH+FROlJh+0zvkcYSre
	FcdO3JKEdOJ9vZb4ByVfxTgYakQXXUwmVi1j6zXdgyaw+I1d8KJ//Oq60KmyJ6tCtJel
	A/yg==
X-Gm-Message-State: ALoCoQlkrH3TxnLmrn5VlOjot/IVOtYel1O+iayWfJaDV/Yx6Fmr14beKy96uzWfJV5/cBcc22KE
X-Received: by 10.180.101.105 with SMTP id ff9mr16497357wib.64.1432822681630; 
	Thu, 28 May 2015 07:18:01 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id um5sm3595084wjc.1.2015.05.28.07.18.00
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 May 2015 07:18:00 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id D50C65615C8; Thu, 28 May 2015 15:14:17 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 28 May 2015 15:14:13 +0100
Message-Id: <7e95b3a3d44aa8c915e1ecfa3b1e40bf7821fc4b.1432822343.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <f4c88fd9e39602ab841967166a14593f92576079.1432822343.git.alexandru.damian@intel.com>
References: <f4c88fd9e39602ab841967166a14593f92576079.1432822343.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1432822343.git.alexandru.damian@intel.com>
References: <cover.1432822343.git.alexandru.damian@intel.com>
Subject: [PATCH 19/22] toaster: enable no browser start
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
X-List-Received-Date: Thu, 28 May 2015 14:18:01 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We enable a "nobrowser" parameter that inhibits
the launch of a browser when toaster starts.

This is useful for integration with automated startup scripts
and enables headless testing.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bin/toaster | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/bin/toaster b/bin/toaster
index 93abcfa..ee19937 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -154,6 +154,7 @@ NOTOASTERUI=0
 WEBSERVER=1
 TOASTER_BRBE=""
 WEB_PORT="8000"
+NOBROWSER=0
 
 for param in $*; do
     case $param in
@@ -163,6 +164,9 @@ for param in $*; do
     noweb )
             WEBSERVER=0
     ;;
+    nobrowser )
+            NOBROWSER=1
+    ;;
     brbe=* )
             TOASTER_BRBE=$'\n'"TOASTER_BRBE=\""${param#*=}"\""
     ;;
@@ -227,7 +231,7 @@ if [ `basename \"$0\"` = `basename \"${SRCFILE}\"` ]; then
         cleanup
         exit 1
     fi
-    if [ $WEBSERVER -gt 0 ]; then
+    if [ $WEBSERVER -gt 0 ] && [ $NOBROWSER -eq 0 ]  ; then
         echo "Starting browser..."
         xdg-open http://127.0.0.1:$WEB_PORT/ >/dev/null 2>&1 &
     fi
-- 
1.9.1


