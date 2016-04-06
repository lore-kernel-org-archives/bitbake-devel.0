Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
	by mail.openembedded.org (Postfix) with ESMTP id 063D2770C9
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 16:47:09 +0000 (UTC)
Received: by mail-wm0-f52.google.com with SMTP id v188so29611378wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Apr 2016 09:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; bh=WoI4iJ/eMc1oHs3RhfPMVii8QXWb/jFlqOzurpJjVEo=;
	b=ND+HwF/i3yYGFV7Zrug/f3Wdp/0vwmMs8JSEW0Ik9/kPhx+mLfM/LrP0Fh165K/HQb
	I0n+othtvs8TpI5JttMp98mygKonXxVcnNofvH5/PQLI4xrwAjr5fT6dsMqk0OVFM3mZ
	elZwNw6E6yn3uE+jyYowK7QSsFun2UUZqjz9rOi/iKQrq519Cr88U7SciEd6NCiWxvLN
	tG0Ypno9tw9NS57FrMLEuGYJGDxdGat50gYiOaGWQfFKKEMEmasYv0HikyWWtYS5v964
	+N0Ghs1KZ9Ye8Seq6XLNsiQsHgWVynTB0E9QDDLSIAd9eaUL1JegDXatdmnZD+c0nyTZ
	6a2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=WoI4iJ/eMc1oHs3RhfPMVii8QXWb/jFlqOzurpJjVEo=;
	b=OZRgxpqEe+EdIlr3oPskyf07NUkw/fNBVk9wZuz3v3yG2pPT3auPOK8vdsZZbCZlO5
	xCtwDvolPKj0wSNuvUtcxWUoe4SStu+kVKXwoQusQtYWI47qgMN75MyW1edvLq75cWVN
	LlSaDzoHcy+9bF924M4KSaPfUfWLCFrZ6DB+iFbJ5oTwBGSxD2vjyKb5EM8sVJIOqpMr
	hDHbrhik4HgFRqJ1KdTihPooYoQjw216a+9RhM8fom77aqjElRcVyRRowd6fG06TX3e5
	znEwA1zuwyWNFgPf5iHU03+pjK3wlqzJv51e3/9qcUmvNre1GdyUnuWl2SEAzDPRq82V
	6Nug==
X-Gm-Message-State: AD7BkJLkOPVver2umDhIUTwSfMJ6LqXvUHWSitJ4Zqe5UMwBSnIZASiwnoCQrP3qCTrHyueg
X-Received: by 10.194.95.198 with SMTP id dm6mr33251209wjb.136.1459961229993; 
	Wed, 06 Apr 2016 09:47:09 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id gt7sm4145345wjc.1.2016.04.06.09.47.08
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 06 Apr 2016 09:47:09 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Apr 2016 17:46:12 +0100
Message-Id: <4b90d0411bbdac98f4eef7c16babc79d47c9e9da.1459960764.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
References: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1459960764.git.michael.g.wood@intel.com>
References: <cover.1459960764.git.michael.g.wood@intel.com>
Subject: [PATCH 02/38] toaster: get rid of noui option
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
X-List-Received-Date: Wed, 06 Apr 2016 16:47:11 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

noui command line option doesn't makes sense anymore as toaster doesn't
run bitbake. It should be safe to to remove it.

The purpose of this option was to skip running bitbake observer process.
This was never used before as it's not possible to run toaster build
without running observer.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 bin/toaster | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index 6a85ae2..1e6e690 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -175,15 +175,11 @@ fi
 # make sure that the toaster.sqlite file doesn't default to `pwd` like it currently does.
 export TOASTER_DIR=`pwd`
 
-NOTOASTERUI=0
 WEBSERVER=1
 WEB_PORT="8000"
 unset CMD
 for param in $*; do
     case $param in
-    noui )
-            NOTOASTERUI=1
-    ;;
     noweb )
             WEBSERVER=0
     ;;
-- 
2.1.4


