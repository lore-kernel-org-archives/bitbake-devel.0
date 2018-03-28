Return-Path: <ross.burton@intel.com>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
	by mail.openembedded.org (Postfix) with ESMTP id D5EEB78449
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Mar 2018 09:54:17 +0000 (UTC)
Received: by mail-wm0-f67.google.com with SMTP id x82so4048095wmg.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Mar 2018 02:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id;
	bh=lP2rXniwLgdSMkyWDq8DsnfQ/aOLRsbskGvOhKwIIQc=;
	b=dTUzpTFpgexKhURgTz5b8dVFrn3ZGMpbKN8xalT1azgMsJAbIQPCpO8nppIIg984SB
	d8kr9EP79Tu4rwm27FQb0Z8VV/DDcLDaoLkeiCTKcvt0lfqpofU+jxmGGXReSngcp0tE
	Hc/l0MaU+aavgUlmGADAGNdK+TJfu3UbBKiovy18tdetrOzExi3xI+Z76lXkLounf335
	QqlwCoCXr4MI/eLxwhkIw0XufNudtw9dd5Z9FNjvkYMr/0/YV2vc2xO94aZln5DZtDaH
	js9s5wX/wmxDuAnL9Kt6zf1oRp7YOo+5anZCiXz50H1PGoGog3j9Owkp6X02MCO7LiSJ
	rh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=lP2rXniwLgdSMkyWDq8DsnfQ/aOLRsbskGvOhKwIIQc=;
	b=E/671dsKqqu66rw0g7psckt4meYxQaJ9NW/1ZDUoPWf32t+RsERBCPS5hAD9gNPJWU
	zM/0TUiQ3blSo9OnUrM1Qtwh1r1pjGd+NrRigibx9XG1FE1wRNPFlPgFpntDs7jKYLAC
	wVfxbPy8iijRpXIwNrIR61FZB82QPDrQtlqfPLmYKAUpQFUP14EShHESJpzM2zBUgx51
	GZIUI3JVTw5cPTisEOx4EDetzBF9lxNlbiIgsMqA/HlLLfWQw/HY2z7rr+GaN+DmTtNh
	Nxf0p34Hy844YpC+4EFeLq2MPuN/Q/ZAK0OTIlx6x+8ikm0pZ0LHspKL5i7QB1DKnMvh
	MQoQ==
X-Gm-Message-State: AElRT7HF2Q9uvmd1pz9ef8g7aTNrFCKg3Ay0+L48Qba18Ofu7O1hYaYK
	J/pv1TLzJglTsvjl+ncgcLquJ4iO
X-Google-Smtp-Source: AIpwx48jQ+01CFugeiFjfuqs1Y90MyIFiC1EgFhkuUJMGUmqP/wqJtju7W7RV1McfkgLamShvr0FsQ==
X-Received: by 10.28.71.155 with SMTP id m27mr2183612wmi.126.1522230858025;
	Wed, 28 Mar 2018 02:54:18 -0700 (PDT)
Received: from flashheart.burtonini.com (35.106.2.81.in-addr.arpa.
	[81.2.106.35])
	by smtp.gmail.com with ESMTPSA id m9sm3351496wrf.13.2018.03.28.02.54.16
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 28 Mar 2018 02:54:17 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 28 Mar 2018 10:54:12 +0100
Message-Id: <20180328095413.32013-1-ross.burton@intel.com>
X-Mailer: git-send-email 2.11.0
Subject: [PATCH 1/2] tests/fetch: state which upstream failed
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
X-List-Received-Date: Wed, 28 Mar 2018 09:54:18 -0000

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/tests/fetch.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index d711c77d358..74859f9d302 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -913,7 +913,7 @@ class FetchLatestVersionTest(FetcherTest):
             ud = bb.fetch2.FetchData(k[1], self.d)
             pupver= ud.method.latest_versionstring(ud, self.d)
             verstring = pupver[0]
-            self.assertTrue(verstring, msg="Could not find upstream version")
+            self.assertTrue(verstring, msg="Could not find upstream version for %s" % k[0])
             r = bb.utils.vercmp_string(v, verstring)
             self.assertTrue(r == -1 or r == 0, msg="Package %s, version: %s <= %s" % (k[0], v, verstring))
 
@@ -926,7 +926,7 @@ class FetchLatestVersionTest(FetcherTest):
             ud = bb.fetch2.FetchData(k[1], self.d)
             pupver = ud.method.latest_versionstring(ud, self.d)
             verstring = pupver[0]
-            self.assertTrue(verstring, msg="Could not find upstream version")
+            self.assertTrue(verstring, msg="Could not find upstream version for %s" % k[0])
             r = bb.utils.vercmp_string(v, verstring)
             self.assertTrue(r == -1 or r == 0, msg="Package %s, version: %s <= %s" % (k[0], v, verstring))
 
-- 
2.11.0


