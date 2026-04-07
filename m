Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB72EFEEF59
	for <webhook@archiver.kernel.org>; Tue,  7 Apr 2026 15:02:51 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.83445.1775574171277011434
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Apr 2026 08:02:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=gJb/1CIn;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=8557d86685=rob.woolley@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637BTJfH4040614
	for <bitbake-devel@lists.openembedded.org>; Tue, 7 Apr 2026 08:02:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=yB6MIF44GZ2Bh2VHVl+TbDJmI1oLr+YJK6FpzjW36v8=; b=gJb/1CIn5jhn
	hm3bU+gvkQYFrh2/1jqIvuXdrf0Ep+/TxghyBJpEViZUqWKv+x6+aY0Kg2A/qOuN
	EVjgFEg9tAI4fOl4ixM6g/5ablNrZ1/XSe8Ly9cPuk0T94fyGzn3b9XVtYJd5T6m
	8W8BnQGvxK4C5ywz+EWxGyb0kwIiKFAyUBaWSykdUBnV7AtvffZYEbwLdpJt56oz
	Af5icmXUHtQk0Da08koLbF430o2DVafAwpKVz17PD9ZB/j7xyOiIE1xqQQMZsaCr
	1XUUcvbPx+ZjGpx72p7PWoI7dTaN+Y0b+Ndb1COhJ+PpG8WaKWR9OMnFXHLNcm0T
	wPxjOnFCTg==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dcmrygvh5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 07 Apr 2026 08:02:50 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 7 Apr 2026 08:02:50 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 7 Apr 2026 08:02:50 -0700
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH v2 3/9] bitbake-setup.schema.json: Use anyOf for non-disjoint subschemas
Date: Tue, 7 Apr 2026 08:02:44 -0700
Message-ID: <20260407150250.104135-4-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260407150250.104135-1-rob.woolley@windriver.com>
References: <20260407150250.104135-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: HbNfwebzo3sPhvnMBK-zXHGhrcqrBgOj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEzNyBTYWx0ZWRfX1Xqt/65U7pMC
 9NBejFxhK9vK0KJQuci3iq6dhPkIFTibTcMdiMeB8xmBpxnapOzA/zNzLAvmf1KDWYaNO4hvMXa
 48ND/XfWI5RBjYOf+t3Zca8OvoJu5t0OTj3V7bfDYekXPrVNLEbkIUhmTL55Cx87JSd54TLYLtw
 RChZ80z+3QDsUf7ILdE5bMeBlziKZ3eDwhVxjWHMZPJtCq6eyqnvKz+2gGtVwUKVVes+OOynEmz
 zmhNdI/ElmB2Z/xH71NrplRRmmT4QWJiIaPy9agr8EOWRREMzGYmgxZycDEnm9AZiUXtkVfnh5B
 VKdcpqCbfsZKMe6+bRzm6uW27GGGpaTn8UFIwojqAxSQN9ON3iy9RWIWAEgoyKM0qCwEZ+f82pl
 Bfuxz2xH750jB/nhDcRLstNwMhXe78Vnv8qH4GVD2n04GiUcWqvOdvEHMtNo9G4TtyP76zpiaQT
 lf7uO8k5e5SJ8NvjBhA==
X-Proofpoint-GUID: HbNfwebzo3sPhvnMBK-zXHGhrcqrBgOj
X-Authority-Analysis: v=2.4 cv=Wcg8rUhX c=1 sm=1 tr=0 ts=69d51c9a cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8 a=jJoEvPsC45Y7O9PwoMIA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070137
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Apr 2026 15:02:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19339

The oneOf keyword is for matching exactly one subschema.

However, the 2 possible BitBake configuration fragments
are not disjoint. Since a simple example with type and
description would match both. For this reason, we should
use anyOf instead.

This resolves the following jsonschema linting error:
  A `oneOf` where all branches have disjoint types can be safely
  converted to `anyOf` (oneof_to_anyof_disjoint_types)

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 setup-schema/bitbake-setup.schema.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/setup-schema/bitbake-setup.schema.json b/setup-schema/bitbake-setup.schema.json
index 3324546de..f2e466c9b 100644
--- a/setup-schema/bitbake-setup.schema.json
+++ b/setup-schema/bitbake-setup.schema.json
@@ -92,7 +92,7 @@
                                 "type": "array",
                                 "description": "List of BitBake configuration fragments to enable",
                                 "items": {
-                                    "oneOf": [
+                                    "anyOf": [
                                         {
                                             "type": "string",
                                             "description": "Configuration fragment name"
-- 
2.49.0


