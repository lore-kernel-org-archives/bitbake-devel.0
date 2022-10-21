Return-Path: <mark.asselstine@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69825C4332F
	for <webhook@archiver.kernel.org>; Fri, 21 Oct 2022 02:20:34 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web09.5686.1666318822832589210
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Oct 2022 19:20:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=kK9nXJX7;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7293df2f17=mark.asselstine@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 29L2KMNb011527
	for <bitbake-devel@lists.openembedded.org>; Fri, 21 Oct 2022 02:20:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PPS06212021;
 bh=HvjnBOVjLUYcj+nCf9cChP4BeesTopmQmFE0E/Q9+GM=;
 b=kK9nXJX7F55xWHPklOiGQRAtITDTy+8Z6diLGbkyCH3djU+l073aT45UKPNOjyUj7Z7P
 +vHc4NS07DMAi/Av3RP3QWHFc2wNQ7nuhxFqE8nbKAmk/iYtiIJVmzB9YpQsujpTgyk9
 eTL4le3Bgfw9bw6PDnx8SzKK8Zj2ByfUr+mrJfUbaI6uwukDvkS/HmjZ3h4BNg7iYyT8
 y5Bch0T8TLmCuGR+K0RhgLe524Ooke/0WmvgyNoYOKISHv2FAvgdJy7j7uJnVA4oaBC5
 7Ij4BfnZQsXAeEzu8Cesx2tLeaJhUJjgNQ57FDccpcU9Gv902oXTmNu34U6+HVqZ8YC2 fg== 
Received: from ala-exchng02.corp.ad.wrs.com (unknown-82-254.windriver.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3kavuu13bn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 21 Oct 2022 02:20:21 +0000
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 20 Oct 2022 19:20:20 -0700
Received: from yow-dellw-ma.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.12 via Frontend Transport; Thu, 20 Oct 2022 19:20:19 -0700
From: Mark Asselstine <mark.asselstine@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] tests: bb.tests.fetch.URLHandle: add 2 new tests
Date: Thu, 20 Oct 2022 22:20:18 -0400
Message-ID: <20221021022018.2454713-1-mark.asselstine@windriver.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: oQd76F3und9HXy11joYP11IOjZWKGtLA
X-Proofpoint-GUID: oQd76F3und9HXy11joYP11IOjZWKGtLA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_13,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210210011
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Oct 2022 02:20:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14043

Add a test for special characters in user and password to qualify
decodeurl() inspired by a bug report describing that '=' signs in a
password was problematic.

Add a second test to qualify decodeurl() as related to the change in
commit 628c4bf6c89b [fetch2/__init__: handle @ in package names].

Relates to [YOCTO #14476]

Signed-off-by: Mark Asselstine <mark.asselstine@windriver.com>
---
 lib/bb/tests/fetch.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index b4ed691f..c5f6ce9d 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1331,12 +1331,14 @@ class URLHandle(unittest.TestCase):
        "cvs://anoncvs:anonymous@cvs.handhelds.org/cvs;tag=V0-99-81;module=familiar/dist/ipkg" : ('cvs', 'cvs.handhelds.org', '/cvs', 'anoncvs', 'anonymous', collections.OrderedDict([('tag', 'V0-99-81'), ('module', 'familiar/dist/ipkg')])),
        "git://git.openembedded.org/bitbake;branch=@foo" : ('git', 'git.openembedded.org', '/bitbake', '', '', {'branch': '@foo'}),
        "file://somelocation;someparam=1": ('file', '', 'somelocation', '', '', {'someparam': '1'}),
+       r'git://s.o-me_ONE:!#$%^&*()-_={}[]\|:?,.<>~`@git.openembedded.org/bitbake;branch=main': ('git', 'git.openembedded.org', '/bitbake', 's.o-me_ONE', r'!#$%^&*()-_={}[]\|:?,.<>~`', {'branch': 'main'}),
     }
     # we require a pathname to encodeurl but users can still pass such urls to 
     # decodeurl and we need to handle them
     decodedata = datatable.copy()
     decodedata.update({
        "http://somesite.net;someparam=1": ('http', 'somesite.net', '/', '', '', {'someparam': '1'}),
+       "npmsw://some.registry.url;package=@pkg;version=latest": ('npmsw', 'some.registry.url', '/', '', '', {'package': '@pkg', 'version': 'latest'}),
     })
 
     def test_decodeurl(self):
-- 
2.25.1


