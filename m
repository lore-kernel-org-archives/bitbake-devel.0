Return-Path: <changqing.li@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D48CD0E6CD
	for <webhook@archiver.kernel.org>; Tue, 25 Nov 2025 12:08:29 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15282.1764072507036802362
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Nov 2025 04:08:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=JLcAG3sk;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=34243e2576=changqing.li@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5APAUm5p3346880
	for <bitbake-devel@lists.openembedded.org>; Tue, 25 Nov 2025 04:08:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=3Usb2D07e1xKJZMIbFhN
	Foe4fPHMuj3O43YDrbPLFHo=; b=JLcAG3sk/zv16vhUfCFu0uVd6VzE62DMtuF4
	1kuQ6hrycyhtoWU5/x9HNkCistvjqm95/lUKJXTrY2fBz7XD100ftyBY3kn0VW73
	hiM1F7UB1IFPbNmf3EOQNYrjEvGhAQ/7xCAVbRVF7rYDNnu2V6Dkcp2+aW1lUyhO
	WqmI9byWrpDX96rowRY+aufzroZl9bcZJ4Azx6faqtBbiec5lTxtqZMrOVmYHpdC
	OOMTD2QGvHLrc5IF+rK20nwPFMbJ0YvZ807RUNih3QM1qh51w/vY05hr+dwVRizd
	zCvkgp6XolZ1jh3GLixPMvxI/LriCl0bvcbBWS1DWKAZm0s7qw==
Received: from ala-exchng01.corp.ad.wrs.com ([128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4akdjjaqqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 25 Nov 2025 04:08:26 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 25 Nov 2025 04:08:25 -0800
Received: from pek-lpg-core6.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 25 Nov 2025 04:08:25 -0800
From: <changqing.li@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH V2] bitbake-setup: Avoid unexpected positional parameter propagation when sourcing scripts
Date: Tue, 25 Nov 2025 20:08:24 +0800
Message-ID: <20251125120824.1023662-1-changqing.li@windriver.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDA5OCBTYWx0ZWRfX0dUPpXMEsGY9
 ngg+1+Jq2xNrABgXXI+yaz1EObqEnxfq2T13Bx/uy7Sv1fXImIBl7sxpzNNeWjkaib6EP+BoIsw
 qKUwaNXUvM4rBaUL5MJe0Mrg71RVkHM4jX37gxNOkAymoTsiJfGf5LyWUYLkIKk2FX8GbQE0wk7
 2e4NKYJ3slXUQdcbaL3w7H2P67xs5V86efP3wlkUjPyWTvReYd/UJPOMN7UBCy2/p80k/UdvVm4
 lbEheCMfOcXbwRo3asbc+qTpmZBUBvyiOSmolXvStgH6+qowFYsWxY0QTDoOOqqEXvTegtVBWtc
 dbpNJVfYk3v2bACSujQAxEdBh/jew9E9ellokF+j0RHdFk8gQgNQweojC4IRmaXmXHChiSKCv6y
 aRbg6Hu9QiQuno8sMVhQ9R+uSysjgQ==
X-Proofpoint-ORIG-GUID: BCYGfNoeBXdDRZviVn1uHV43tr494WQt
X-Authority-Analysis: v=2.4 cv=Wq8m8Nfv c=1 sm=1 tr=0 ts=69259c3a cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=t7CeM3EgAAAA:8
 a=q66ld7yrh25gMnS-DFMA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: BCYGfNoeBXdDRZviVn1uHV43tr494WQt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511250098
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Nov 2025 12:08:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18490

From: Changqing Li <changqing.li@windriver.com>

Using `set` to define positional parameters in the current shell causes
those parameters to persist. When another script is sourced in the same
shell without explicit arguments, it unexpectedly inherits these
positional parameters. This change prevents such unintended propagation.

Signed-off-by: Changqing Li <changqing.li@windriver.com>
---
 bin/bitbake-setup | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 75be90940..8e229073a 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -184,7 +184,7 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_c
 
     def _make_init_build_env(builddir, oeinitbuildenvdir):
         builddir = os.path.realpath(builddir)
-        cmd = "cd {}\nset {}\n. ./oe-init-build-env\n".format(oeinitbuildenvdir, builddir)
+        cmd = 'cd {}\nset {}\n. ./oe-init-build-env\nset --\n'.format(oeinitbuildenvdir, builddir)
         initbuild_in_builddir = os.path.join(builddir, 'init-build-env')
 
         with open(initbuild_in_builddir, 'w') as f:
-- 
2.34.1


