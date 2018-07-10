Return-Path: <Rasmus.Villemoes@prevas.se>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
	(mail-db5eur01on0119.outbound.protection.outlook.com [104.47.2.119])
	by mail.openembedded.org (Postfix) with ESMTP id 9AA5E6076F
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Jul 2018 14:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=prevasonline.onmicrosoft.com; s=selector1-prevas-se;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=QrY67gPqHuTdDGg9zmd6kQmugCkiG1UyH11J+5e5fwc=;
	b=AO6Wnz55t7TqGfxzbM5zy9zboDLZ1fpD5FgolhNx7zE6QAhHs5Qovbv/9sDOBUoDq9GL4gfNJgNNgYsU88S1/yRc9Jou/rvJPqdeJzfJTDO/PenqfCed2PK0xV+p/nnvESh1vuTKfnuwyKjQWPtoxcF0btCyH0CgBIH0rbEuUlI=
Authentication-Results: spf=none (sender IP is )
	smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
Received: from prevas-ravi.prevas.se (81.216.59.226) by
	AM4PR1001MB1332.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:200:98::22) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.21;
	Tue, 10 Jul 2018 14:06:22 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 10 Jul 2018 16:06:11 +0200
Message-Id: <20180710140612.26245-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
X-Originating-IP: [81.216.59.226]
X-ClientProxiedBy: AM0PR06CA0025.eurprd06.prod.outlook.com
	(2603:10a6:208:ab::38) To AM4PR1001MB1332.EURPRD10.PROD.OUTLOOK.COM
	(2603:10a6:200:98::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0cf1ad7-6ca3-45c2-b5c3-08d5e66e5128
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);
	SRVR:AM4PR1001MB1332; 
X-Microsoft-Exchange-Diagnostics: 1; AM4PR1001MB1332;
	3:jGSutapLmcQi7PE/gotR5+Dv09+KmNBXbYtj8oZ1wUkx9k+rllF+7VblLHERLxKBJzssChBlc0VPTK/pj7ACE9j/E40B2rQgFXoxH8halWV3kRSRZuq8pqtOaB89QTmBt7ord18yrNYfaMx91AMbaXf3hL8UkMzuF1CSwccHRLUapE6l44nBaN4BCiXH9jeDjOW6i8MI4m7atmRGmGLOGSGUhNMKsfd2TT+OkuhMn5CxNJrHkS5mgNj5W+vhIGti;
	25:pB8xJClQ0CjPrH1flGaIV8sny2VSbNYw7wnMkw1UcKg5JM5nEibnps9tGbsxgZbgn4t1wnUytuLP9ogBmoEvCMzvn4AvZ7jan50Cp1yex3qBtw9/UTuei0VUSUnK7BHNSQD6uwj6VFlgdBsQjrdUbjIIJtfit5hn4WSaeWfs1ty144/oscqVhLNuFQLbdjhQ7bSUInmWgq3QJgUIWQTF/r7zEIXe3IOsajfGOvJRlrGvRom5E6oPvSfpvIL8RjbI0f8jLHFa08vl+YBrfNLhWnM9gYa0ih5Lcyp5A0GS7OUyVq4qReHhxfnYZFIuhAKEzXTEc2GBnR9rnQy81n1mcQ==;
	31:MpQ917xoqmIVXI+8oNxxTtO+2sloRfFms2UnO9zwp2nd8uwUylFQbRN0lAgctQQTReJuvubCeiXnqpPscpwQJ6HICWA5+ZU9gYg+2untJetBo/SlVsA3u6nbcl21yCi0YHyaWhpzJqP+J29X1X/+Mt/z1V6sioSVDUnRWdjenr+wpSxbPPlXQT1Ft+f3G7MFgP/+MdN8wTsNdR9JmBM0Aldd/zUltFTb54/vCMv5G/Q=
X-MS-TrafficTypeDiagnostic: AM4PR1001MB1332:
X-Microsoft-Antispam-PRVS: <AM4PR1001MB1332D08935B4AC161FAAC4758A5B0@AM4PR1001MB1332.EURPRD10.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);
	SRVR:AM4PR1001MB1332; BCL:0; PCL:0; RULEID:;
	SRVR:AM4PR1001MB1332; 
X-Microsoft-Exchange-Diagnostics: 1; AM4PR1001MB1332;
	4:3RBkvnxxCdfQyGH9jGsvU7KdOPu3Cto8a/8owGEI+tebcXqdzlDwJjE+Ih1DqehPYQJYLfOCDTDXq1y8auK6yFTz2eRj1WQEIxSwvDIsvIiubeaEe5dQ+5KaVa2OM4pgnuKklyM9Agk/0JwIwmx8BQZTKjo1jKQezagbDA1qCmXtGXm+AIzKKJwnRufayrmCmoRnRCFMM4ma+B0Ik/Bh6tTPVhzHQIkBpxGwm+aIorxXkwCNl0Odg2aAtMSUWQDJ0Y76pgOgvJlb1Gbb063dkg==
X-Forefront-PRVS: 0729050452
X-Forefront-Antispam-Report: SFV:NSPM;
	SFS:(10019020)(366004)(39850400004)(136003)(396003)(376002)(346002)(189003)(199004)(53416004)(50466002)(48376002)(69596002)(44832011)(6666003)(6916009)(5660300001)(6116002)(36756003)(3846002)(2361001)(956004)(476003)(74482002)(47776003)(66066001)(2616005)(2351001)(97736004)(486006)(1076002)(25786009)(305945005)(6506007)(386003)(4326008)(26005)(105586002)(186003)(6486002)(42882007)(16526019)(8976002)(16586007)(107886003)(72206003)(52116002)(51416003)(68736007)(81156014)(53936002)(81166006)(2906002)(8676002)(50226002)(14444005)(316002)(106356001)(6512007)(7736002)(8936002)(478600001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM4PR1001MB1332;
	H:prevas-ravi.prevas.se; FPR:; SPF:None; LANG:en;
	PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: prevas.se does not designate
	permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM4PR1001MB1332;
	23:WwS7Jbx36tsT278wpGCpGAwQBpg8zBmgREXUiPE?=
	=?us-ascii?Q?tEJGLQrih66WQA3kthKkT8qw6WFfPBTZKJPHYnncH7ld+65/MjonadoFjImx?=
	=?us-ascii?Q?Jb/ilYsZn2D44EZ7T6WBFq2V+E3NZxu7+VSpCBA4/TqCwe+HR/Wlkdz79l4r?=
	=?us-ascii?Q?BGn/8/1YhZo82Vje0zblfQiNSdCnPhz2LS30YU/nLJBjFDvnAzsbw+EU+XAQ?=
	=?us-ascii?Q?WoiWJeqHwDRZSySOQzM2jDDPsK0MvAMCdiIM/EsDI6PYm86G9qs6a1+wqcg8?=
	=?us-ascii?Q?onMcMIxQytBWjS2N5LSxkkKqNNUpXPUc0T646dsf/kW9+aD4wSkEC16s1JR1?=
	=?us-ascii?Q?KECohnfMaPQjeWrM80J8su3N5WKMvy9wRl0Ovz4pxwO7y2k4nHQlHEFGsI5I?=
	=?us-ascii?Q?yk6mNQGdtQH/z0EQ01Dmo/i/pI6i9++cQ2uE2XP+sTuP1di0RpQCPS6y+auf?=
	=?us-ascii?Q?8dv1W/GLzpOyEaHIhTrrfpDJQf2wIWKz02iKdqFwRkpio8FfYVnexO+sapYa?=
	=?us-ascii?Q?+AA4OCRC8N+de2Kp7RYURCBo3jOsfu4d39RmODt2z511g+DIy1/cuuUoCPnG?=
	=?us-ascii?Q?xqTSaNWYzv74KKBKO528aC8LjSUaZ3koZ6oyobS9puEiSCPOFVZAc0gPTsOf?=
	=?us-ascii?Q?vukZQ+nZzAM0dFVGiiUm4xR3l1ZI+JcArevp1Zi256mQ98e36eso5IpLdC/3?=
	=?us-ascii?Q?YDBKkirxwVaS/xZD26t+uvmeR1gqR8Gmnh3zKz5V8KtaZNpplz9YlTOpYjSH?=
	=?us-ascii?Q?4PtBTjBHMJp+gBk6kRAktQD65d0fXfPioFbUTQpTi6Tm0+fWwb7Hd01gT0nB?=
	=?us-ascii?Q?7WOXZ3ZPUwqXxTQ6CPZGXqPYjMib4lkKxqq4FcgyCgLBevcyvG/iFpHZDaVV?=
	=?us-ascii?Q?VDjs5t8HK6Oir4xjNSe8ms2QXEQxJyu9HHHzYbRCvHY8nIasBiJ8gIWmBoHz?=
	=?us-ascii?Q?rqg60oDe+InPiWCDmEQlI1s2pmveymk+0hX7gpB9l6rUkfa10NKxU7j4e3gG?=
	=?us-ascii?Q?df3rYIWAgJFxncaXGkH9mlXmb3cy3xvELUl63OfQwd0ELE5g06XSAzY9on9/?=
	=?us-ascii?Q?lGX/T+An0QBhGH3+vh5cB1bLxw00hSm/QNYWdcwqcz8V/2nxnn1KWDqar2mY?=
	=?us-ascii?Q?4TI/UjYTt21hHtjMXFrKWCy9z7OcXjcJOyXuHw2qwR1MyosqdzgqUN8M3tXj?=
	=?us-ascii?Q?NBiRISuBYivpFG1MApmvdZE8PId+kGaMJuHnakDAOZ36Ej4EXHAjwNjbuOvz?=
	=?us-ascii?Q?CZ8un6ORrTUuEwsESJI6SHFX3fcSnBL948AF/qF73g3uMHnQ2QhhCaXEeclb?=
	=?us-ascii?Q?GeBSInopgJXweY37Lx4S3CQi7CtOUC1+8Egn3ItptzhUi?=
X-Microsoft-Antispam-Message-Info: /GisOC4inIScWGTonU5tRXasdkbBKE///Yu1deM8k0cYDec5i3Lg4yJIfb0Lro0mt+PwFRhc1p66PK9Y+6sVJ8XLp4bKIor8FbFzqbJSuq+SsSo0Zs/J0DE3/GTkVow+jPGVpJ7Q9vTUviu4ccOa/e3F8FTCyWgi5NqlcvwAG6Bx+TEyvURqSkyD8L2LA6tD3CiXPEsMkXg07+bt7qbwnQ81bCCUQuI7Ie358aqWMMHJm1zjCapNXvK1ytKVSktT2F8x7KteJdBSG9EKocdhcW29hbELOMyJ2X33K1RXzGxWXRS3bhfmaufCphOg+75tGbOdBh8mRcZ1onZogSSS221RovYeDaGVcXrDRUdvMBs=
X-Microsoft-Exchange-Diagnostics: 1; AM4PR1001MB1332;
	6:/BOaGyMM1EnsjJWl721oO/axHYLRLPr0xoggfOi+ehHP9gnNXAgaLdzS/xayvvFk55jnMDIf4igORpDxQ89TS3VxbCto2205hFK2l9DyQB1qUj5liUPEqDfVgzcLxOoyH2N9tzzoDv5j2o6WmoLvHi0P/EkK8R9awDA6UB07z414V7kEAl18muSa5KCVR3GTHouF9Bb1R9P1TTrLh5dpy4+MHFXzRm7H6fqXUU6SWQjA3uqgAS3h3+nnbU0ca5t9P4e9Ga0zaXs+kEtf89uwKOA1ct64sGK5atNb4PhaAW0XfrYoIVUS7oIuYGbFNWEGtKSg3yEthTi/jWLQM6jN2sKByIHm+3ep2SPyqj2x/cEIDKlKflhA+qHH5HSkFDPKmPSB4331QNxLGS7qhKJUcP1Be1Bk0xXxk42cHRghwNKVgFKW30gFnqmSQ8ygJV5WC54iwhNUJ0a4ACqBV0WJZQ==;
	5:++dYkw8jZaa0hTDwLLhCVomrcCVxESmpanA2JYGr1UtLxTm9z/ED2Ry5efTiXk/l28KuECeu0PZRcQJI/RizCAUtYAuAoR/97WynYHV0/3uNMqlmrYA9wylJhni8VGuV/hMeCgorIRpkvEySHbY7xyJcP66+3MsQjTFtmA1JoX8=;
	24:6CUtq1knr+11k9vAd5L1xM8YYvahfhbJ3CMUtvWQkv7sH4oGG4OlbvhSCQxLt/BOjuCgaECAltcjbRcKgLHzZaF6LbScQ1qJtBdpapZMGBA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1; AM4PR1001MB1332;
	7:A/01nKU3gbGHRcNaRjp3AZBFhq8kadApS/M8KrOxtbMzQJjaYXux2kbbIB/fq3AhCCaz3a8BM7/73XaQpkWRP908EeDvWt3bz9Rt0uQ9jFOBiFOPKsN8bWGuQHMf5/YND/m89zafpxMjuFD88SaTjRDhZYbzHtL7hvvk+EPLPcXfEnjUmx2BJtvOgQ/hKnOB5DGjV7Rd2EBAY7/ZydCBKZqDZ8Y/T54FBy9XCQ2DxB8dvRPnShel2CamGSBKMziG
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2018 14:06:22.3475 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0cf1ad7-6ca3-45c2-b5c3-08d5e66e5128
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR1001MB1332
Subject: [PATCH 1/2] bb/utils.py: add iterate_chunks and hash_file helpers
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
X-List-Received-Date: Tue, 10 Jul 2018 14:06:23 -0000
Content-Type: text/plain

The current (md5,sha1,sha256)_file functions are somewhat inefficient in
that they loop over the lines of the given file. In a pathological case,
a huge binary file might have no \n characters at all, causing a lot of
realloc'ing on the way to providing the caller with the file as one big
"line".

For random binary data (and compressed tarballs are effectively
that) there's a \n roughly every 256 bytes, and for text files even more
often, but splitting the input buffer into lines is a waste of time, and
all hash methods work beter with nice aligned chunks.

So introduce two helpers: One that will iterate over a given file in
chunks, another that takes a hasher object and calls m.update() on the
chunks.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 lib/bb/utils.py | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 378e699e..cb7a6fa2 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -520,6 +520,28 @@ def unlockfile(lf):
     fcntl.flock(lf.fileno(), fcntl.LOCK_UN)
     lf.close()
 
+def iterate_chunks(filename, chunk_size = 32768):
+    """
+    Return an iterator that yields the contents of filename in chunks
+    of size (up to) chunk_size.
+    """
+    with open(filename, "rb") as f:
+        while True:
+            chunk = f.read(chunk_size)
+            if chunk:
+                yield chunk
+            else:
+                return
+
+def hash_file(hasher, filename):
+    """
+    Update the hasher object with the contents of filename, returning
+    the hasher object.
+    """
+    for chunk in iterate_chunks(filename):
+        hasher.update(chunk)
+    return hasher
+
 def md5_file(filename):
     """
     Return the hex string representation of the MD5 checksum of filename.
-- 
2.16.4


