Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B329410A88F2
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 17:39:59 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.53619.1774546794904699114
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Mar 2026 10:39:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=KJPLyf1R;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=75450e5aee=rob.woolley@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QFhRYX3113430;
	Thu, 26 Mar 2026 17:39:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=Qn77/mULI
	KLScdtMWUVVBwoMdWuPI3Pmh4yWE5SkkMc=; b=KJPLyf1R61fX3W/vgTl7TTpDx
	czIxR9fKYKyhruxPVCEdSLJ4ezGjbxhyHbVcKI5Uoc5l5c9350d25G6GhDd6Nt25
	MCwVCiA3UEVKkX/M7Bt8rfmSH+uCkzFH9xcOJJYKHytvrOMmR814gUb6cGMxfriD
	Iy1PodkYsvis+Bcd1hNKC5Kes2qDqvyWeSBXCN1FEGxapIBj9fkXCl/HZfM8dP5M
	VC0GfiNTPoKDY6yqW+zg+Q4LyTdVSCLDoNuvL3APqH7dIAo15ptjwFkBve3pSA8M
	ioZsirMXsehjnPyHeHcNUsgoJ5EuB/fpH2FvayLsTK4qCUWgd3Lr+5egLFMRw==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1gj86y45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 26 Mar 2026 17:39:52 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Thu, 26 Mar 2026 10:39:51 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Thu, 26 Mar 2026 10:39:51 -0700
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <alex.kanavin@gmail.com>, <richard.purdie@linuxfoundation.org>
Subject: [PATCH] Common BitBake Versioning
Date: Thu, 26 Mar 2026 10:39:47 -0700
Message-ID: <20260326173951.519326-1-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: i-iC8BujWIcuQaXV-PYq-0AvXVQrSXrx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEyNiBTYWx0ZWRfXyUx9glOTQYl+
 MHTT+RhqXRS4bZtGId/UdbyUX+kOqv8d7pG4lUSqCUfsrAoR9Cs1iBbOsXatx90lBpXf06yDlcr
 /Kn07qSbqbN0gRE9ltYfJbxpIdjbGh8jYM1kBVWihNtoTSvg8Q9oXmJUsdxYtJB/zAcBByuFWzS
 v13A4mhdGAYT8tWYoOr7cdaGu1a1KsQJ7mnma0jG4yFoGcZtpbp7X/QjwxoGqsJF8EOjuHSEsxe
 tr3a/jACzlXyp49VkHIZvsZwBu2ppzOBZp7Ot1J9y2pwSvowNIxraPWzBxpJ53+Z8ByBdqd9OHY
 f7pQNgmIW9mJ/LsBlQWjDa/k5kUZf3I5BalmvRCH457iv0iZCybScTPD73P+ASe3GV4YIFlGLii
 WZPSxKZSUnoToV+zl0yzSbWhGoYAsnO4Xs23WBZKt3iJzOcM4B2bWNEGfOXKmSDYgB383A8q8ST
 GxnuCwOYWS+IXrRdW9A==
X-Authority-Analysis: v=2.4 cv=LtqfC3dc c=1 sm=1 tr=0 ts=69c56f68 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=vXubCc6eOM8ClHXzI0cA:9
X-Proofpoint-GUID: i-iC8BujWIcuQaXV-PYq-0AvXVQrSXrx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 clxscore=1011 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260126
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Mar 2026 17:39:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19240

We discussed how to version bitbake and bitbake-setup on a Weekly Tech
call at the end of January.

The initial proposal was to use the git tags in the bitbake git repository
to dynamically determine the package version. There were complications in
this approach due to conflicting conventions between how the Yocto Project
maintains git tags and the format accepted by PyPI.

A simpler alternative of using the version strings directly was proposed.
The request from Richard was to converge the 2 version strings for bitbake
and bitbake-setup. He asked for it to be sent as a separate series from
the PyPI changes. He also asked for some sort of version checking in
case the scripts find the wrong version of the bb module.

Testing includes running bin/bitbake and bin/bitbake-setup inside the
git repository as well as installed from the bitbake-setup package.

The value reported by bitbake --version is technically the bb.__version__ 
whereas bitbake-setup is technically reporting version.__version__.  However
in both cases we verify that version.__version__ and bb.__version__ match
before any other work is performed.

In the coming PyPI series, the pyproject.toml setuptools.dynamic uses the
version.REQUIRED_BBVERSION directly. Should the packager wish to add a
suffix they may make the change in the pyproject.toml.  There is also
the option of adding additional VERSION variables in version.py should
we decide to differentiate between the tool version, package version, and
bb module version in the future. 

