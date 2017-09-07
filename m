Return-Path: <ross.burton@intel.com>
Received: from mail-wr0-f171.google.com (mail-wr0-f171.google.com
	[209.85.128.171])
	by mail.openembedded.org (Postfix) with ESMTP id 0A2D677CCC
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Sep 2017 09:24:37 +0000 (UTC)
Received: by mail-wr0-f171.google.com with SMTP id m18so1633642wrm.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 07 Sep 2017 02:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=VAzkhNx+cD/XzUFFgt4+yp7nmXRwJpdknmzDDO+EstA=;
	b=sAr6hzQ7UYSy8SGCCMmBly9vc5dHHzgt05VU3VqPHQb4NtTGbF64j4VyRdYxykzk63
	DNTccG0bgSjHCbSdDu9a3I1zC2Us4Sq6oilxtO/+g9Pt2+SGYIWPiWC6jeeeYvKGj34y
	KSzhQOWjIWGwjBEZwVllKAZmH9165zqX/2c6Ey+VQNgaG6Ysi8CS2lYnWD/W4lqU9TEI
	ZyfNfshwf1BJ+uth2I2SetsyeoYAluSlVoa7z6LK1wBFWKum8RVBFg1Ea/1fsrGq0hbw
	qxbcL7dis2usGy9hS2JpzBbO+Dks23s/89tUMMsL+GdDY+sPlsd6TGOPlBbr2QSmgE4t
	X5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=VAzkhNx+cD/XzUFFgt4+yp7nmXRwJpdknmzDDO+EstA=;
	b=N1wNWOMiOdzlqOA47KpXiY57Hvsjmbkf3oHn+owuQWi04eHOFhnCSaV+VpBXEyljIk
	R3gjeV5VS8ZSMhabM/AO3SkHRI4AL2bQVDYHzJzPfiuhVRdU3New0SSOBxjCXkj0DnZ5
	tO0cxN0y2kpCkDmsJnwo+GE1N3tv+/bbT4o5clHWSiiaCSjIZCP3HFj4Euj4BfdgipVs
	8ZqmS5CTegEjjVkuQ6i16cWPczG+VHPW2lEUv0vxDlfdWSOuf+xHypoEuAsjV69Dv8vn
	ArtMpnKNIlpc6295xnN0DhebxxD/CPxLxFYxD4GfHxiBUVJWHQurwDryydVg9tq4Sd9C
	nb0A==
X-Gm-Message-State: AHPjjUiTtGgknfgxEiFVsnMJyeCxa0nlRph/scnV4VoIw+nj4mjy7zkM
	Fgt24kX4hVyhNB9sn7o=
X-Google-Smtp-Source: ADKCNb5A1oTzpjxATuOBc+tvkPzhQdxc1JfgBoJ8POzMcfOdpuCbR5vhDY+m8a2T41/BW18W7r9BfA==
X-Received: by 10.223.139.146 with SMTP id o18mr1560314wra.236.1504776278637; 
	Thu, 07 Sep 2017 02:24:38 -0700 (PDT)
Received: from flashheart.burtonini.com (home.burtonini.com. [81.2.106.35])
	by smtp.gmail.com with ESMTPSA id
	a39sm3635221wrc.48.2017.09.07.02.24.37
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 07 Sep 2017 02:24:37 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  7 Sep 2017 10:24:25 +0100
Message-Id: <20170907092425.25124-2-ross.burton@intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170907092425.25124-1-ross.burton@intel.com>
References: <20170907092425.25124-1-ross.burton@intel.com>
Subject: [PATCH 2/2] tests/fetch: handle network failures gracefully
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
X-List-Received-Date: Thu, 07 Sep 2017 09:24:38 -0000

If there is a network failure the return value from latest_versionstring() is
('','') which later causes an exception when comparing versions.

Improve this by checking the return value and failing the test early.

[ YOCTO #12053 ]

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/tests/fetch.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index faa5c74aae0..209b13f6953 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -793,6 +793,7 @@ class FetchLatestVersionTest(FetcherTest):
                 ud = bb.fetch2.FetchData(k[1], self.d)
                 pupver= ud.method.latest_versionstring(ud, self.d)
                 verstring = pupver[0]
+                self.assertTrue(verstring, msg="Could not find upstream version")
                 r = bb.utils.vercmp_string(v, verstring)
                 self.assertTrue(r == -1 or r == 0, msg="Package %s, version: %s <= %s" % (k[0], v, verstring))
 
@@ -804,6 +805,7 @@ class FetchLatestVersionTest(FetcherTest):
                 ud = bb.fetch2.FetchData(k[1], self.d)
                 pupver = ud.method.latest_versionstring(ud, self.d)
                 verstring = pupver[0]
+                self.assertTrue(verstring, msg="Could not find upstream version")
                 r = bb.utils.vercmp_string(v, verstring)
                 self.assertTrue(r == -1 or r == 0, msg="Package %s, version: %s <= %s" % (k[0], v, verstring))
 
-- 
2.11.0


