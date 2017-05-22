Return-Path: <patrick.ohly@intel.com>
Received: from mail-io0-f171.google.com (mail-io0-f171.google.com
	[209.85.223.171])
	by mail.openembedded.org (Postfix) with ESMTP id 7286E71D86
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 May 2017 10:50:28 +0000 (UTC)
Received: by mail-io0-f171.google.com with SMTP id f102so78096445ioi.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 May 2017 03:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=5DSwWEpBHqx+64ATq2Wbi00P3CI2ggM5YmzhawpOMxI=;
	b=voXhYYJOWIYaPYtWNoYPkKz7vmyQLHWuB86CazE58SGf2bdALCkf133HkhQ7fIXstZ
	pvIeKc9KLY45P2Ho8wneKgUD85Z4P1ekE1zfG/fbha4Z4gG5iUdF6+vaQ8J1Uk0QGxr+
	oxOlXk9sZInUH0v35UyJp5Jr+DjyGrx9QUDA8dvt0kqrJY66Mi8h7eGXUJB5cHyU3WGa
	BlNvGiGdt1zqlPFQgGB3BaftyYC8HDucZLyxCmD8oWzttGwbc7n8uTp2Bcdx33HSxqOX
	WHp7QJtXHUs4mcilq/v6DqTZgOosWg+JHRmXrnoqxjSmnXFT/Z372v0UW96AtM1+GG5U
	sbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=5DSwWEpBHqx+64ATq2Wbi00P3CI2ggM5YmzhawpOMxI=;
	b=OkOgelKuwq4j6rkaxTPxccLoKZgJyvezjRl3A6ZtKmVUuy+sGAI8UDTtcwo1k4tt23
	/I7xxvNNRV1038Dmi6ZAXSfR83AYVcXdkmGkVETamIjjPlnXoD5va2kG/3kbZrEdyURl
	wDUf0yvv/EjM6x6HNOlau0Yp9ZmlGYOdZBTmkT3GMXKK+WRUHnimTpl4h4pg81ZZwn0K
	w3HAAkostp2mvfnoiwfKeVpeLBFvJO4V9WE0H8I4HF8p8FqB7ni4qBzjvxx3gSj/BMBY
	CapO9B2XL8GGLSCHtTh6V16RgziYWTnFsl1Kq/TSWJYkfRheB0usxgLqzPfqwAokOmbJ
	cn1A==
X-Gm-Message-State: AODbwcC0xl0/cBKzArkS+FhwWkc9E/xASRoiitV132LeAzL/7rlXNWZl
	gzE/zzjFKE0xdLwv
X-Received: by 10.107.157.206 with SMTP id g197mr21304243ioe.119.1495450229637;
	Mon, 22 May 2017 03:50:29 -0700 (PDT)
Received: from pohly-desktop.fritz.box (p57A568EA.dip0.t-ipconnect.de.
	[87.165.104.234]) by smtp.gmail.com with ESMTPSA id
	y64sm1142112itb.31.2017.05.22.03.50.27
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 22 May 2017 03:50:28 -0700 (PDT)
From: Patrick Ohly <patrick.ohly@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 22 May 2017 12:50:20 +0200
Message-Id: <cf231a157650f22c55ce6861ce824b74b245af55.1495450175.git-series.patrick.ohly@intel.com>
X-Mailer: git-send-email 2.11.0
Subject: [PATCH] cooker.py: allow dangling bbappends if explicitly whitelisted
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
X-List-Received-Date: Mon, 22 May 2017 10:50:30 -0000

Having a .bbappend without corresponding .bb file triggers an error or
at least warning, depending on the global BB_DANGLINGAPPENDS_WARNONLY.

Some layers (for example, meta-freescale) avoid that message by only
adding .bbappends to the BBFILES when the layers they apply to are
present. Others (like intel-iot-refkit) avoid such .bbappends by
falling back to global assignments with _pn-<recipe> as override. Both
is complicated.

Now the warning code checks BBAPPENDS_DANGLING_WHITELIST and ignores
all bbappends which match a file pattern in that list. This is an
easier way to have bbappends which may or may not apply to an
existing recipe.

Example usage:

  # We have recipes-* directories, add to BBFILES
  BBFILES += "${LAYERDIR}/recipes-*/*/*.bb \
	${LAYERDIR}/optional-bbappends/recipes-*/*/*.bbappend \
	${LAYERDIR}/recipes-*/*/*.bbappend"

  # Several of our *.bbappends might be for layers that are not
  # guaranteed to be present. Don't warn or even error out because
  # of those.
  BBAPPENDS_DANGLING_WHITELIST += "${LAYERDIR}/optional-bbappends/recipes-*/*/*.bbappend"

Signed-off-by: Patrick Ohly <patrick.ohly@intel.com>
---
 lib/bb/cooker.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index bc8574a..687fbfd 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -45,6 +45,7 @@ import pyinotify
 import json
 import pickle
 import codecs
+import fnmatch
 
 logger      = logging.getLogger("BitBake")
 collectlog  = logging.getLogger("BitBake.Collection")
@@ -1008,8 +1009,11 @@ class BBCooker:
             applied_appends.extend(self.collection.get_file_appends(fn))
 
         appends_without_recipes = []
+        appends_whitelist = (self.data.getVar("BBAPPENDS_DANGLING_WHITELIST") or "").split()
+        bb.note('Whitelist: %s' % appends_whitelist)
         for _, appendfn in self.collection.bbappends:
-            if not appendfn in applied_appends:
+            if not appendfn in applied_appends and \
+               not any(map(lambda whitelist_entry: fnmatch.fnmatch(appendfn, whitelist_entry), appends_whitelist)):
                 appends_without_recipes.append(appendfn)
 
         if appends_without_recipes:

base-commit: 362f6044fcaafe51ab4377af8f2606165b112717
-- 
git-series 0.9.1

