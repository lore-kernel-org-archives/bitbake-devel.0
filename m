Return-Path: <patrick.ohly@intel.com>
Received: from mail-it0-f47.google.com (mail-it0-f47.google.com
	[209.85.214.47])
	by mail.openembedded.org (Postfix) with ESMTP id CA98077B44
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Mar 2017 13:36:14 +0000 (UTC)
Received: by mail-it0-f47.google.com with SMTP id y18so24625136itc.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Mar 2017 06:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=jCnAHnk/5wguEkbcwfw9TNxaGQy1Yy6aodxUMmIlIs0=;
	b=IagWIHP3H25MtIe6fTcVMpJmwzG7RQg24cW/GZ710KUm7q31KVZ+gJfbZqkSerfa49
	H0F3WenZ1BzYRv4PFLTDo+4C+xUuPyqlT4p4HQZvNX3YdbDGbEvj73CA9FHlyvDGDafO
	vcMXLpR5qzXpex3I4aiSN89Xql3jCNoN0T9P3kgTdj4I4092lEBHLP1pS0ORhnyGw3Eh
	c5tzkYhg92R1hrrjuDsHqUg/Ahiv+TxOpdWRWqmfabQzLHPClITw6iv6pKW6xcdZNrO+
	kalN/zoASPK7O7o6As5Td4WFXF/i+RNz5RAHvUPy9wtmTe7xXJBzUHPPnbfu1cymcgNN
	Q3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=jCnAHnk/5wguEkbcwfw9TNxaGQy1Yy6aodxUMmIlIs0=;
	b=YPendeenfJUy+ysnTGdIrR4A39FElq7KSUfprnTyFdOseB6oeVWKjr7YewKjQFyJEO
	QO1CCLoD3r/poxdQEk3XY6iCS0aIzrc1WrZKnVCDK2W76/gQhRYLk9R7xr19jHRh6vBq
	zvzUnKXXEsSjpL2QI/tgSmRScvy75NIgu3BVZEYrV02n9jtvkUhDQq0ObpxJ2J5ycIbe
	s66nUttlBVpmN7+XkDbPQhGLZSs7lnZVQKIdSa/oAFf5/nrUCg8UH0NDweHKDkVfgFxT
	aXRJHXu9X79dwwxgGEza4f0JWVZqsJzD4OgyYlLXX+7xLsFI2+FLLrZyxmlL1W+BiM34
	4ENg==
X-Gm-Message-State: AFeK/H2EuwYUK/BEJXhGmIqNdaFi9ZHjXpeMsqVytOqeL94j4dXHq1st5SNr2+FYGQdzRDvy
X-Received: by 10.36.67.133 with SMTP id s127mr7862558itb.50.1490189775672;
	Wed, 22 Mar 2017 06:36:15 -0700 (PDT)
Received: from pohly-desktop.fritz.box (p5DE8F72D.dip0.t-ipconnect.de.
	[93.232.247.45])
	by smtp.gmail.com with ESMTPSA id 78sm128489ity.7.2017.03.22.06.36.13
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 22 Mar 2017 06:36:14 -0700 (PDT)
From: Patrick Ohly <patrick.ohly@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 22 Mar 2017 14:36:10 +0100
Message-Id: <16602fdd8a9fc57eb0c927c79a2c687f9cdaee4f.1490185431.git-series.patrick.ohly@intel.com>
X-Mailer: git-send-email 2.11.0
Subject: [PATCH] cooker.py: use correct multiconfig prefix in dependency graph
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
X-List-Received-Date: Wed, 22 Mar 2017 13:36:15 -0000

The dependency graph in the bb.event.DepTreeGenerated and the
corresponding pn-buildlist and task-depends.dot from "bitbake -g"
contained entries like multiconfig:qemuarm.gcc (dot as last separator)
instead of the correct multiconfig:qemuarm:gcc (colon as separator).

Signed-off-by: Patrick Ohly <patrick.ohly@intel.com>
---
 lib/bb/cooker.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 662a7ac..3e6ab30 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -762,7 +762,7 @@ class BBCooker:
     @staticmethod
     def add_mc_prefix(mc, pn):
         if mc:
-            return "multiconfig:%s.%s" % (mc, pn)
+            return "multiconfig:%s:%s" % (mc, pn)
         return pn
 
     def buildDependTree(self, rq, taskdata):

base-commit: 1ff9b3c669fa187f152de7b8b57d14c2468d926c
-- 
git-series 0.9.1

