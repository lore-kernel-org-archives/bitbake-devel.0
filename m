Return-Path: <michael.g.wood@intel.com>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
	[209.85.220.47])
	by mail.openembedded.org (Postfix) with ESMTP id EB2A46078E
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Sep 2016 15:17:03 +0000 (UTC)
Received: by mail-pa0-f47.google.com with SMTP id gp7so6603772pac.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Sep 2016 08:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=sdx4quB9Nbhpqv5nLOZ7aCIKYndmIZEVvk4680Rr9TQ=;
	b=tyoGHTw7YWiKvOHm7xskJzhBfB9+G3xuG+k0pcnK5PmXir+maFTTexmBFovBeAmbP/
	4rvy/wEoC66NVZM+G5/CKrIeGn46/vLnDew30HfyKuKJQOFRAB9lglC95kR2OzroYFQr
	eTtasFN/7ARbpj4ljK7cP0tqNc/0RfMg93uVQTqOUJ7k2bVCyO8Bx0VKvq3pgVEmv5tk
	GBvDmgo/RHck5D+M7vM1JqShOpWH3OzL6Dox9Xy1tCzvBse/MWnz6lVVHnYa3PziPihL
	Li4aUQJUgASxiQyjmwaT0q7g0SQHyCRYMMIBqD6fXcDxFMKw3btkM8p9UUJ+n0Ks5e2V
	vlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=sdx4quB9Nbhpqv5nLOZ7aCIKYndmIZEVvk4680Rr9TQ=;
	b=ZOod9gXni7pFMh8exL/DXhqk0JZCe5hW9cOHtMJS8vGiEiY8oARe6yZyCNLaJ5Ln+u
	9kpHz16H03AK4sO+32usWM7YhamT7syaZAhS2gIdzHjl35YGOL7Oc6aINxBFFao5gtf+
	qjRYx5/d6pkY/IkOv4JxS24+rmes+jhuHUb97Ppa4+MznclJSC/Z7DvWqktltECqkybk
	Gob4jRie9Dphj5yyrbHipT0QSRqgGdj/hKippXnftbR2PXLNlOfhaA0G0TP7UHwV/gGe
	Qg/puSXO98leaa19PqJ4QPiF2etJmkD5IKJZ+khG9kCpfQ4wYWu7L5MZxChFY9gd7SQN
	fyKg==
X-Gm-Message-State: AE9vXwOsv46SYX3XgtTmhudL3NukfXQ/oLk8r97TY7tTn6eSyorZ6vb4nHRW5EC3Z8n+/+kY
X-Received: by 10.66.150.134 with SMTP id ui6mr48091908pab.41.1474989424966;
	Tue, 27 Sep 2016 08:17:04 -0700 (PDT)
Received: from orion.ld.intel.com (fmdmzpr01-ext.fm.intel.com. [192.55.54.36])
	by smtp.gmail.com with ESMTPSA id
	p1sm5784876pae.12.2016.09.27.08.17.03
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 27 Sep 2016 08:17:04 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 27 Sep 2016 16:16:52 +0100
Message-Id: <1474989416-10454-2-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1474989416-10454-1-git-send-email-michael.g.wood@intel.com>
References: <1474989416-10454-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 1/5] toaster: stop modifying OEROOT in toaster script
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
X-List-Received-Date: Tue, 27 Sep 2016 15:17:04 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Setting OEROOT in toaster script makes oe-init-build-env to
break with error:
  bash: ../bitbake/bin/../../scripts/oe-buildenv-internal: No such file or directory
This happens because OEROOT contains path relative to build
directory.

Renamed OEROOT to OE_ROOT and unset it after it's used.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 bin/toaster | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index 6641dbc..f92d38e 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -129,7 +129,7 @@ fi
 
 export BBBASEDIR=`dirname $TOASTER`/..
 MANAGE="python3 $BBBASEDIR/lib/toaster/manage.py"
-OEROOT=`dirname $TOASTER`/../..
+OE_ROOT=`dirname $TOASTER`/../..
 
 # this is the configuraton file we are using for toaster
 # we are using the same logic that oe-setup-builddir uses
@@ -139,16 +139,18 @@ OEROOT=`dirname $TOASTER`/../..
 # in the local layers that currently make using an arbitrary
 # toasterconf.json difficult.
 
-. $OEROOT/.templateconf
+. $OE_ROOT/.templateconf
 if [ -n "$TEMPLATECONF" ]; then
     if [ ! -d "$TEMPLATECONF" ]; then
         # Allow TEMPLATECONF=meta-xyz/conf as a shortcut
-        if [ -d "$OEROOT/$TEMPLATECONF" ]; then
-            TEMPLATECONF="$OEROOT/$TEMPLATECONF"
+        if [ -d "$OE_ROOT/$TEMPLATECONF" ]; then
+            TEMPLATECONF="$OE_ROOT/$TEMPLATECONF"
         fi
     fi
 fi
 
+unset OE_ROOT
+
 # this defines the dir toaster will use for
 # 1) clones of layers (in _toaster_clones )
 # 2) the build dir (in build)
-- 
2.7.4


