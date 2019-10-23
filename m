Return-Path: <ross.burton@intel.com>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail.openembedded.org (Postfix) with ESMTP id E05357F808
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Oct 2019 15:33:42 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id r1so12820818wrs.9
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Oct 2019 08:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=yQfwv43OZbZf9wjGZ8urjAxzSTYrRNZ2RRSDrpXWXeE=;
	b=o1d1OEi1zV/LkS74p5jA98l1ZEwQwsjgyblCWA4gEpkkSapsDi7K2VyWiC6CoTkmI8
	+bwSMX3c+HD+b2cTv6nh9aHc/I7DO/9Q3hOaiLdR44MNKLL+E9gXRmuaN3c3iOl86N28
	6uWD7DBiVFQZRABiDUDo4dbMIFoq/NcFm4SN1DPdc1DfzBull1JEsuHWG8cauLmVLrPa
	xa+FSKUsKAI3ZqWLG4SfnsNxzUtDj1WfeeI066tUcIVOtcHo9/r+HBjswKzWcPh+kZoF
	p7ozjRDcynmwYsAPnGWtyQTqj+2vU/N+3JJ+ZH6F31QoxNtggQzu0IXSydMQu/rd63ym
	WwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=yQfwv43OZbZf9wjGZ8urjAxzSTYrRNZ2RRSDrpXWXeE=;
	b=Ob3h3LC3Y6J+/Yt8LPD7DHEIuD/siz9W9NQ8Vb/z3RWodNG9DfSzmvvsjtRQ8eZqtd
	4+/e2NyAYerADM50DZh38a6AjhqhGuWXChovaEjrTkV1RJvUrMa0clS4K2G6ov6qUJTt
	C5voS3/dQhXOSdEkLee1OM4TvPs4d7i4t1m/XvlP094ynhyLUMt7ezMNRDLIVJeoG5Kx
	B1a7o22VXbeFvJUH/KybtyGNL/QHGrT0LeILZa/akl1CGt5cCJa4dofYniyr1+jckyw6
	MMdBWP+Pt3Y1uM5/MpqiUxryoJ/VQy7GMDLRcdbMDqqTEDP7KK72kDnYP58GLorUeFMw
	Q10Q==
X-Gm-Message-State: APjAAAXbDE0Idv0R1Of2RfXPeXdNe7tGRGQZ9Oqb9S2fNLbZq4ZOeDwK
	Q/0KhNfZMpgVzHZa2m3jWc6LKvmh3HU=
X-Google-Smtp-Source: APXvYqzVdhkwja/zeTPUtz989C6ETuLbM7HlgGRb5Ijfr6Qf/qPaPj4ip0nq6259N2plvT1+J2KCdw==
X-Received: by 2002:adf:e512:: with SMTP id j18mr8718874wrm.291.1571844823357; 
	Wed, 23 Oct 2019 08:33:43 -0700 (PDT)
Received: from flashheart.burtonini.com (35.106.2.81.in-addr.arpa.
	[81.2.106.35]) by smtp.gmail.com with ESMTPSA id
	p21sm12154815wmc.25.2019.10.23.08.33.41
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 23 Oct 2019 08:33:41 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 23 Oct 2019 16:33:39 +0100
Message-Id: <20191023153339.2313-1-ross.burton@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH] bitbake/runqueue: don't shout about hash updates
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
X-List-Received-Date: Wed, 23 Oct 2019 15:33:43 -0000
Content-Transfer-Encoding: 8bit

With hash equivalency enabled the runqueue logs at level info quite heavily,
which spams the console.

Reduce the log level down to debug so it's there if needed but doesn't get in
the way.

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/runqueue.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 18049436fd5..e1eaf49b8cd 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -2361,7 +2361,7 @@ class RunQueueExecute:
             if tid in self.build_stamps:
                 del self.build_stamps[tid]
 
-            logger.info("Setscene task %s now valid and being rerun" % tid)
+            logger.debug(2, "Setscene task %s now valid and being rerun" % tid)
             self.sqdone = False
             update_scenequeue_data([tid], self.sqdata, self.rqdata, self.rq, self.cooker, self.stampcache, self)
 
-- 
2.20.1


