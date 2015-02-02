Return-Path: <ross.burton@intel.com>
Received: from mail-wg0-f45.google.com (mail-wg0-f45.google.com [74.125.82.45])
	by mail.openembedded.org (Postfix) with ESMTP id EC4D6606BF
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  2 Feb 2015 15:11:25 +0000 (UTC)
Received: by mail-wg0-f45.google.com with SMTP id x12so39287570wgg.4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 02 Feb 2015 07:11:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=4G54F/IXa5MA4egD2oiVgbiB3SqnZTVh+J5nHlS1Yh4=;
	b=EXwmCuCwsna4vysWoqFpVU07bZ4wfPOx3MnNptc0tEAFmLeDI/Awtz5IXwXpnfL+Uv
	LG9FWGuubMmG+UKid2YrAZjmFbqssOwAOcmyaa+bGGgxBvqBD3OAs4CSLAN/1cKRahut
	8qmJDBj3doHezg1YZrXG1ybT1Gs2pIAqFt34mlpLeMI8QsmI5Aw2B2LVVExKdGvFRjUm
	YxKAtNEqyBX3YwXIeJUIcoJvSV/KxkqStbSyhBJuikSNgDftcMmNyJDtDviTBgZG2TFt
	NrUN5Po8l9fpWDS5eKn+HZJXGlB1xiqUt7bh5AtxMeVSvsPrijFJse6alOGrXz84UbRK
	WpZg==
X-Gm-Message-State: ALoCoQkOjvJDs+bkhlaje2DvDNt5GHFDPa+vfLs5IimO5INW2O9Gmko6ilpuuen2Motn1eyS5JEi
X-Received: by 10.180.89.210 with SMTP id bq18mr25296440wib.45.1422889879274; 
	Mon, 02 Feb 2015 07:11:19 -0800 (PST)
Received: from flashheart.burtonini.com (35.106.2.81.in-addr.arpa.
	[81.2.106.35])
	by mx.google.com with ESMTPSA id 18sm28294829wjr.46.2015.02.02.07.11.18
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 02 Feb 2015 07:11:18 -0800 (PST)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  2 Feb 2015 15:09:25 +0000
Message-Id: <1422889765-1308-2-git-send-email-ross.burton@intel.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1422889765-1308-1-git-send-email-ross.burton@intel.com>
References: <1422889765-1308-1-git-send-email-ross.burton@intel.com>
Subject: [PATCH 2/2] data_smart: split expanded removal values when handling _remove
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
X-List-Received-Date: Mon, 02 Feb 2015 15:11:27 -0000

Given these assignments:

 TEST="a b c d"
 TEST_remove = "b d"

TEST evaluates to "a c".  However, if the _remove override is given as a
variable:

 TEST="a b c d"
 FOO = "b d"
 TEST_remove = "${FOO}

TEST evaluates to "a b c d", because when FOO is expanded it isn't split into a
list.

Solve this by splitting all members of removeactive once they've been expanded.

[ YOCTO #7272 ]

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/data_smart.py |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index b1ea33f..7bb7b4a 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -621,7 +621,8 @@ class DataSmart(MutableMapping):
                 cachename = var + "[" + flag + "]"
             value = self.expand(value, cachename)
         if value and flag == "_content" and local_var is not None and "_removeactive" in local_var:
-            removes = [self.expand(r) for r in local_var["_removeactive"]]
+            removes = [self.expand(r).split()  for r in local_var["_removeactive"]]
+            removes = reduce(lambda a, b: a+b, removes, [])
             filtered = filter(lambda v: v not in removes,
                               value.split())
             value = " ".join(filtered)
-- 
1.7.10.4


