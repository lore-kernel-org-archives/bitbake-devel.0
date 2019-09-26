Return-Path: <jpewhacker@gmail.com>
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com
	[209.85.166.42])
	by mail.openembedded.org (Postfix) with ESMTP id 470FB7E26B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Sep 2019 19:23:57 +0000 (UTC)
Received: by mail-io1-f42.google.com with SMTP id b19so9582526iob.4
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Sep 2019 12:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=WzYj8WvMCb6HQStilCJkHkLm+DnPqD8XX64arjLR644=;
	b=jJXCbzF9PZTS710R+qH4KwYZGRoklZ0zjUgbxfuAAe8+UzkrwkHXFewesdzViywSDo
	36S3te4g+W7o97sm831iRpEg5wtjwZ5qD2eyRx5PjeyqI35UMl13Rp6yIMhjcprIJkf8
	YfG8gLtoeX2Mu2VNGlErC6e4ayQnZLvvOXteTpeW+fTezPB0/5e+kOxMzP1zqmAgn7q+
	4ZEeFsFlrbcqVkcdzuMkVF98wjkB65KAKvrJKPECzVtaOc+KFxf34ANnSQnbfLvT8px/
	mDFk85SwBuLnsqEbrQcqW8K6SI2IQ1UM9JgxoPhkFObME4ulMONgYqcPcad9g9PL/PM+
	aU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=WzYj8WvMCb6HQStilCJkHkLm+DnPqD8XX64arjLR644=;
	b=n4H3a/SFl+e+o57zk2nm2BSjY9okH8KddzefT1uLdQpHW5iLSZUg8G3KWgkU+PUyFn
	hxVkzwVfanVvLxrGdjkU1y1HR4Zptf6zilgZPXqG+OErjaqYrl8uAfD5owE1NglYvxQo
	Rc8OEu1pPK7RGmhOsERiPqOQwwaXmlG0b+HIFZLHG/KRIxRRcixTIe+OGbwDxLi5W7b9
	gzRKli6Pb/Ae4sTKPa6PjSiw1a5LrigTh3Gy4xPBZaa7O5KMmcOoOp0p/yc3X/UumM8w
	VexKARHvoMO4f9GfIcYqBFGN24Jv7bFMc2ehCe+kYr7YW3AuvzC6FQCcE0uqlTuFItGI
	jytw==
X-Gm-Message-State: APjAAAVNHShRPvTWEYWFJklR9xyzlPFxEy9Xz791ZZhWGzaiwESAMLRn
	/CpVtxmPcUm/mOPqNl/8sQZEwdg9
X-Google-Smtp-Source: APXvYqzVqdn4v4H1Vzabs6mD+JdNbZK5yqtILM8I3B2BZjenOKAeYnNGKfWTDY7FUFH2Y5HaTam5mA==
X-Received: by 2002:a6b:b704:: with SMTP id h4mr4688415iof.218.1569525837843; 
	Thu, 26 Sep 2019 12:23:57 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id d9sm1334129ioq.9.2019.09.26.12.23.56
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 26 Sep 2019 12:23:57 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 26 Sep 2019 14:23:53 -0500
Message-Id: <20190926192353.822-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Subject: [PATCH] hashserv: Don't daemonize server process
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
X-List-Received-Date: Thu, 26 Sep 2019 19:23:57 -0000
Content-Transfer-Encoding: 8bit

The hash server process is terminated and waited on with join(), so it
should not be a daemon. Daemonizing it cause races with the server
cleanup, especially in the selftest because the process may not have
terminated and cleanup up its socket before the test cleanup runs and
tries to do it.

[YOCTO #13542]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/cooker.py      | 1 -
 bitbake/lib/hashserv/tests.py | 1 -
 2 files changed, 2 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 0c540028aed..20ef04d3ffd 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -399,7 +399,6 @@ class BBCooker:
                 self.hashservaddr = "unix://%s/hashserve.sock" % self.data.getVar("TOPDIR")
                 self.hashserv = hashserv.create_server(self.hashservaddr, dbfile, sync=False)
                 self.hashserv.process = multiprocessing.Process(target=self.hashserv.serve_forever)
-                self.hashserv.process.daemon = True
                 self.hashserv.process.start()
             self.data.setVar("BB_HASHSERVE", self.hashservaddr)
             self.databuilder.origdata.setVar("BB_HASHSERVE", self.hashservaddr)
diff --git a/bitbake/lib/hashserv/tests.py b/bitbake/lib/hashserv/tests.py
index 6584ff57b4a..a5472a996d2 100644
--- a/bitbake/lib/hashserv/tests.py
+++ b/bitbake/lib/hashserv/tests.py
@@ -32,7 +32,6 @@ class TestHashEquivalenceServer(object):
 
         self.server = create_server(self.get_server_addr(), self.dbfile)
         self.server_thread = multiprocessing.Process(target=self._run_server)
-        self.server_thread.daemon = True
         self.server_thread.start()
         self.client = create_client(self.server.address)
 
-- 
2.21.0


