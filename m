Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
	by mail.openembedded.org (Postfix) with ESMTP id E64F477100
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 16:47:10 +0000 (UTC)
Received: by mail-wm0-f42.google.com with SMTP id v188so29611907wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Apr 2016 09:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; bh=j2DfTB26vsPZznTWEZkv6hWFXhY6/f137PHOIRs9QVA=;
	b=HAZPMGM5jeq/tuEqy7iZ8M/FccuaxNzHbIVju7bpOXpe+f9B55Xz0b26o8hXXbXUhN
	M3sI5Pbeh5Bp210fQcnDRc86NHBJktRcmlC2ZVDpbKyN2LqvN0Adq5tHF8pWg8RhKawe
	iNVSwLek4aaM/eHX18NdmCIUEG9fGuAryoi9dsxEizkJLJMfaC95GdMagxMbmQU/S2xl
	3IstQJ7b0KlQZ7wkioDp+ECg3y64excCgBs+CEJDI7tyca6NsIO2SAL4TIk0qhvb/urs
	x/26loOkqmsf26Yh550qbZnYA1HECcULVeUb7w//rZnrgACdo5meYo6RgCt3BN4TANfS
	tQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=j2DfTB26vsPZznTWEZkv6hWFXhY6/f137PHOIRs9QVA=;
	b=cy7VUjWVTFc93CHQlR7+zINwT6YV9TEPbr+AHfmyUArsyO+0lJiTqe/8zARX0fBxkH
	lD8LlF3ODurTk7Z0irJAK9OQhUsZ290TOzbym8+DZdg6wZsILb0TzSf85mku5io/V85w
	GVjSZBVJacy4u7Vvy45vx14JcObsOukk5/epGmsQ0TvJHSX5cK8LcRF0amqdCkFYykJz
	ihS1tLKP5x4S5padUUr2pfk9xafGHVkf1q4QV1GHXvghr8RdHioKbi+J5de0rs++3Jaw
	iXpSLpu+D45gFousUJQlaIWmRSrc3uz3qTd0IzS+ganHTmdDNRniPQJMrsb1tF0ZzVhK
	yW0g==
X-Gm-Message-State: AD7BkJIAtC+JFFGvNPX9peIRkqMH9CVm5fZzQUv3HOxjBcazrqAFIwGjsb9x6yxWUJGsrCM5
X-Received: by 10.28.187.136 with SMTP id l130mr15004166wmf.23.1459961231092; 
	Wed, 06 Apr 2016 09:47:11 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id gt7sm4145345wjc.1.2016.04.06.09.47.10
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 06 Apr 2016 09:47:10 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Apr 2016 17:46:13 +0100
Message-Id: <d6ebd4fb37f4888521d0fd185ba1e7c0d1fb614a.1459960764.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
References: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1459960764.git.michael.g.wood@intel.com>
References: <cover.1459960764.git.michael.g.wood@intel.com>
Subject: [PATCH 03/38] toaster: set BITBAKE_UI environment variable
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
X-List-Received-Date: Wed, 06 Apr 2016 16:47:12 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Set BITBAKE_UI variable to 'toastergui' for command line builds
to use toasterui as a default ui module for bitbake.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 bin/toaster | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/bin/toaster b/bin/toaster
index 1e6e690..5cc77ed 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -100,6 +100,7 @@ stop_system()
     unset DATABASE_URL
     unset TOASTER_CONF
     unset TOASTER_DIR
+    unset BITBAKE_UI
     trap - SIGHUP
     #trap - SIGCHLD
     INSTOPSYSTEM=0
@@ -259,6 +260,7 @@ case $CMD in
             echo "Failed ${CMD}."
             return 4
         fi
+        export BITBAKE_UI='toasterui'
         export DATABASE_URL=`$MANAGE get-dburl`
         $MANAGE runbuilds & echo $! >${BUILDDIR}/.runbuilds.pid
         # set fail safe stop system on terminal exit
-- 
2.1.4


