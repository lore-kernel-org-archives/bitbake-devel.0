Return-Path: <jpewhacker@gmail.com>
Received: from mail-it1-f195.google.com (mail-it1-f195.google.com
	[209.85.166.195])
	by mail.openembedded.org (Postfix) with ESMTP id 7DBF07E279
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 May 2019 21:49:58 +0000 (UTC)
Received: by mail-it1-f195.google.com with SMTP id i63so181595ita.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 May 2019 14:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=3yw96ovuTHS2NQRPFr/YUGMUN5Oda8MKUtlWW6TnyOg=;
	b=dgfhif9Sh5X0xhCVbOhqzGpJbcophsDjl6arAaMHjbGqa8Oz99uLV0uMoHFUrqUIYl
	X0mHcuOIJT/1zuWJZdgWVCnrxrnpdY5AUUpDBXNPpgaMlKsHfMKs0qRyGbbEgbVZQ9i1
	QKwhrP4kndNXRZ32nETZb/OwfPTagheigOit9EmvD05IuQXiEhu5U2RXlhy2VMbSfXn9
	Jlpi/WTTYsGYGXCNTaZz8f7w5D9HZdy5rXSgukLjwga0aMILbJ3aoVsggtpmD8l/0eP5
	tLGWdXmo6LoNG2dZYcVB0/27x2VMZjDWvH+TMDrIfzA9lYZJCef6PH4NZKgIJUU2WHSx
	MHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=3yw96ovuTHS2NQRPFr/YUGMUN5Oda8MKUtlWW6TnyOg=;
	b=t9ls5Qu2C/eoI9MQIhMYrReoNjvI71logfehde44Qb2AHSi/fDtGHN1iTncgtrVnsq
	OGIjvPXm6wfoufEizffQ0Y0hoAZb7lcfgim2sd1ha9ZPUwpoMqdKnkV6tdLqA/YckIAd
	+k8dII3fXSw5jpzE08L4FBCCFilIQuLYHHD7LvoHq+c0N287G6iVs7lkO6dqelYhCr/R
	fTIFm+RRZ3HUvp+uxR64YNMrTcB4OB4inLAsfbw5gH0jBH7CLwzwhxZWDbLon+Ym6HfD
	hHSk1laqRgVYSZU0lVkwCH7hgsrKF/2R41XbBZn/f8tc7t/YL2yk1YMKAxWxJgLjBJjj
	IYgA==
X-Gm-Message-State: APjAAAU/RQp2feLYag9tSqRcaFHXPZMw2mIQWNntW9BOBViwdQ3BIMCT
	kd1gQkxEYjbiT6QdTGcONPXx9k7K
X-Google-Smtp-Source: APXvYqxMjl8r1HasC8tOG2+N67g2xXd691Sjafv6TISwRtIdP7zmt9GmTJodr+YdfR2gjR6ap39FsA==
X-Received: by 2002:a02:b79a:: with SMTP id f26mr6028706jam.135.1558475399171; 
	Tue, 21 May 2019 14:49:59 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id l25sm7266782ioj.8.2019.05.21.14.49.58
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 21 May 2019 14:49:58 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 21 May 2019 16:49:42 -0500
Message-Id: <20190521214942.3300-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Cc: Joshua Watt <Joshua.Watt@garmin.com>
Subject: [PATCH] bitbake: cooker: Rename __depends in all multiconfigs
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
X-List-Received-Date: Tue, 21 May 2019 21:49:58 -0000
Content-Transfer-Encoding: 8bit

From: Joshua Watt <Joshua.Watt@garmin.com>

The renaming of the __depends variable to __base_depends and file
watches needs to occurs for all multiconfigs, not just the base config.
Failing to do this for all multiconfigs will result in a huge increase
in the size of the parsing cache (about 5x for a single mulitconfig)
because all multiconfig caches will still depend on the base config
files. This will also seen a similar jump in the amount of time required
to load the parsing cache from memory, both because the cache is larger
and because of explosion of additional existence checks that must be
done for the base files.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/cooker.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index adc41014e64..78658a1683e 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -391,8 +391,9 @@ class BBCooker:
         if CookerFeatures.BASEDATASTORE_TRACKING in self.featureset:
             self.disableDataTracking()
 
-        self.data.renameVar("__depends", "__base_depends")
-        self.add_filewatch(self.data.getVar("__base_depends", False), self.configwatcher)
+        for mc in self.databuilder.mcdata.values():
+            mc.renameVar("__depends", "__base_depends")
+            self.add_filewatch(mc.getVar("__base_depends", False), self.configwatcher)
 
         self.baseconfig_valid = True
         self.parsecache_valid = False
-- 
2.21.0


