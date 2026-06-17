Return-Path: <Gabriel.Smith@belden.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0425ACD98E2
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 18:59:40 +0000 (UTC)
Received: from mx0b-00015a02.pphosted.com (mx0b-00015a02.pphosted.com [205.220.178.250])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2576.1781722770197839075
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 17 Jun 2026 11:59:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@belden.com header.s=podpps1 header.b=Qud0SKDx;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: belden.com, ip: 205.220.178.250, mailfrom: prvs=462805845a=gabriel.smith@belden.com)
Received: from pps.filterd (m0382793.ppops.net [127.0.0.1])
	by mx0b-00015a02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HHhL2v3122593
	for <bitbake-devel@lists.openembedded.org>; Wed, 17 Jun 2026 14:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=belden.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=podpps1; bh=z3PuvO378vowuToLBSlDK06B
	weHjK06FBcbujDrpRmQ=; b=Qud0SKDxVlINGzbJQeBmhkB81ild6G7G/yv6TEpq
	19nPh/Kij+cVgSAowC+GZmDW14xuJ4IrCFsWR0uBDPpwRtJxAN5xK5XsUQh1Iy2i
	hVBK2wS+ukjV/Q1v8ZahaH6hbkTA49VFd4/xwxElu0+jBHgi0d0J7khCcQDiWg+a
	d+jxnYlQy6FYWeI50l0kFKKx86eoOQI9E3LPQNfD8KsOWo5gBQwObK02dZA9EnxI
	i6q3lw2dPGBjq4sSqPOqAJvkN8vE5vQTb6ssSr6pAl01Zty6JiG97VZ71vTvWY+T
	hIfz4qGzy3TrCi4waUvWEjgUfRMMVm8kmJxa7TEIXyliVg==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013001.outbound.protection.outlook.com [40.107.201.1])
	by mx0b-00015a02.pphosted.com (PPS) with ESMTPS id 4euefr2psk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
	for <bitbake-devel@lists.openembedded.org>; Wed, 17 Jun 2026 14:59:28 -0400 (EDT)
Received: from LV8PR18MB5783.namprd18.prod.outlook.com (2603:10b6:408:1ee::7)
 by CH3PR18MB5548.namprd18.prod.outlook.com (2603:10b6:610:1a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 18:59:24 +0000
Received: from LV8PR18MB5783.namprd18.prod.outlook.com
 ([fe80::29ac:d0ba:6581:49c9]) by LV8PR18MB5783.namprd18.prod.outlook.com
 ([fe80::29ac:d0ba:6581:49c9%4]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 18:59:24 +0000
From: Gabriel A Smith <Gabriel.Smith@belden.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: [PATCH] fetch2/crate: support user-defined protocols
Thread-Topic: [PATCH] fetch2/crate: support user-defined protocols
Thread-Index: Adz+it1ciEWyYGSUR4y0gnoqQpn2SA==
Date: Wed, 17 Jun 2026 18:59:24 +0000
Message-ID: 
 <LV8PR18MB5783EC1D3247161CBB9FFFB482E42@LV8PR18MB5783.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR18MB5783:EE_|CH3PR18MB5548:EE_
x-ms-office365-filtering-correlation-id: ca64952f-f29c-482a-88f8-08decca28c90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|56012099006|11063799006|3023799007|18002099003|38070700021;
x-microsoft-antispam-message-info: 
 RoM2aSw2VucxoMCaeyQcrbkxYTfBPFS4T3eHiX3BkFQdANa1DtLc4TsDCMYccKkJJuy68bpXG1PwbwMiL6J4ucHhUYsXyCyxv+fKsYpj+1XIdL9gcAdiVjQrz/HavFkcV1BOjDWCrPtvwY6qKqXbsCeTRrjArwvg0/5PSeV2Es3Wj5zTFZzqsqe9C+/4kJhwoOZ396MsRKj3C4gQQ9iLcynf0CfjxC8lNJx7Nld4y/miPWJcioQGCnQYlXHiFhwqSC92A67vXBCkjclRah76OQv9uHWWYUTER1VPqmwpUTGsaoqwSZJ6ZQ95JXnioM3CMzjHbmHFc0eyClnxFfTxyHw8kWCugj6eT998ymkXNTXRJ6xwKX6c0PBkd2MJZ1s4MpW/4H+KoPesaAnoxLjZCLMcOcGobLqbt2ykYhavuY/8LLwUzD9iZCE77mWcXZ61AFOdNAE+GyI+dKUsTK2GlCGzO+uaTQGQyffM7bEya/9ko8ZV+MQcjP4CAbEJ7GGwxGlp9oJFR8jK8plZHfJ+0EeG7AXvUj+mDA9VAjuQAWTPeMQaZSHEql6pxtRUQHWkof0mxOX2W4F0pFOPAqzjsOVs35+1hPwD0/PdO6f5JDzl3H+wH5zXElLhLsFsNVCo/tO+8NNuGFXpi3YSm52Ghn/Tbxf37T3xOEW4Vz9Wi3/n8ZXxM+ryl7oINb0EljWu
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR18MB5783.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(11063799006)(3023799007)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?6RpmtRF4S0fi7PGchK5wTqxt7S/iGu0iVsSsY8NNQVrTki88Ehyx432fWpuW?=
 =?us-ascii?Q?zFSUK9rzTtpHBdU8oPnY3qxz7khGAj3QAT6Tc92hYNosJePFV9bEZMD/c0/C?=
 =?us-ascii?Q?8Z7bjooJT/lOBpt/FWdIVBYX/9YmeuKfUjCs4hPOTKuzYXso9iXdm6Iuh91t?=
 =?us-ascii?Q?W/Y2gcsKQ6/RaR8K2FSMVrt4zuxyhLZH1vYpMC74I9okudEsY1O6BifmWEvf?=
 =?us-ascii?Q?kOtVcZucSO9W7j8ySJuvhu94G3sgZIh5AX/PQ1/5mYuoOgMiq+ImzfYewSvn?=
 =?us-ascii?Q?yi479CQMXQy/ouAoZDdksnTJISFhWAeNuQgy23ExlEa9GZMSy2cEpIYy3zfa?=
 =?us-ascii?Q?AuZgMtETh19OhfFRwMMExjTheIlbqp7Hs8Ng4MfgMSJ0c8mksRVCPrHSc/Da?=
 =?us-ascii?Q?mw35dZz5DIdnMEqvXB0PMGS6H9amq82iBVa/UzvSLxw+LvMGZ5SnDi7WUydi?=
 =?us-ascii?Q?mb+91W1cNroAx1gRV/zL7CaUtZO8Rs6PNBgVkIlHhX/egBroc+WUejhY7PIS?=
 =?us-ascii?Q?RR1E2s1FTvw1cI4FtiAecxE47ew9tAv7z7RJtUwaw1LvzGzJ7yUujp9OxdeD?=
 =?us-ascii?Q?aYZwNBZR1plD6QA7U3EDvMp6ujLQv2PLfITfppaK/d9PwttD26eEvnJU4Ssk?=
 =?us-ascii?Q?1bIVm4zGefjHLzckanNK+GYMJYMyOkPffszxS0oZkTwXlmT+hDuMqIHMIPrD?=
 =?us-ascii?Q?Uf/NzIMPZv/0psF4ibCPZ6PeBU1W5pPuFVnBhJaE2i5iuXE8vmUBXzQ1daHA?=
 =?us-ascii?Q?NfMOWLijfLTIV7e7Hufm0R5OtTKYrZ0lTWu/lkHrRGgFimtzIPMqcF4CFhLR?=
 =?us-ascii?Q?4piHRyOL/829MVeU78fIDsmcp3uTexMgBAJhoUcz0hCOrk3ebELQFkTtVleH?=
 =?us-ascii?Q?OUyphZsjuU7SvtD6kNqLD8oYoCs5qk+qYTAIhJoRlVcGewGibchvUez+/TNL?=
 =?us-ascii?Q?hdaI6Yl+VWuIMqvktg4QcFt6pD6naVdpkBioHxV6NqF6lvA+aYUakuqTLr7u?=
 =?us-ascii?Q?PRTBypQa+Umx0EgIaPHBbV5le1YLoQ9TKF4ofEmHjdXTj9R2Bvy9zdnd6fnf?=
 =?us-ascii?Q?NyuPVLO/beUi2EtG8m/fHiJTVQGa0G/IJ1x+fWWzH+4KygdURacg0dnVkMPi?=
 =?us-ascii?Q?JKK62WiEuQKXkM3KIfSppG73oHA7o2Jy5myPZo7R24Buy2w2UhwrMSPXVMlE?=
 =?us-ascii?Q?QI3HsfRyK2xjGb48sQodsiqO2SI+n44CnFdMELG40GY7FyBf3KJYZSC+UcMn?=
 =?us-ascii?Q?w4oB5avvxtgkS7m1e5XwS3mF4nfXqNpo+vTQ59DZIYzORYkVuLKsOfqX+pKO?=
 =?us-ascii?Q?PyrbhT0jUiZdKTM3Dg20I3zsgAAi3ANbmpZfHibkEr/M6AmZykW8Ox5MFMr7?=
 =?us-ascii?Q?8ZQhN4kYENprBuT6FjbRvq1XYhP4mOA8mdo8qfectZLuv5DS1mPa4cUDs2GD?=
 =?us-ascii?Q?3oicC+FPz9D9szTYPLSz3GJgSuCbLqvr//QGRz9pRn9eBj84xIZfemsIfGXc?=
 =?us-ascii?Q?pKCNPiKcgAjrnK+sNAJUBxN5pRYGX31HMAdyDcN9aUB8rclAzw1BrGu+R8e2?=
 =?us-ascii?Q?6oeB1+fesZ4hZBeSlgT2VbMz63yornkqKMcVl6DX+imnVBb2OiNaynIsmsZz?=
 =?us-ascii?Q?kbUvzVzneyqr4m2dfyYwwMnhrWyL7HGf+WPWNi5BqykHZqCaxeQoaQeNA1dT?=
 =?us-ascii?Q?a3a9G+CSRyGxMthAflm/g9f+/rqdJkhX1BHhmIqrQ6hDDPA0tlDujszpET+x?=
 =?us-ascii?Q?NPBgw5QFtg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	fhCL0voJ+MgRP1thgJJHN5bMu9Hyg0kIUSvaWASJu/I7Xyf6p3AStIWEcpG+Z39hbSV9fDzv6R9Lu7K18lYqTT7wlgmbjrHDmDq/WTNj+t0VBb0ENHc9hW+eiquOiANjsMQtTHeXT7ZRHMX8uieIdmIA57NXTQ5+1JXKh5b4/2Evf8ZiD0n5hpSWYnHZ2RiuZweMCLFCifNSBPQyEqzhW8YkqeCHaTL58i6bTrgUqrpKUh0mIfhsrO+xaVpyAC3GAymi1obY/urhBbgu1W2tHpYOiCQEWA2evQjeJt+cBglgkhuEPmA/nbxe8V3jDGChuJvSu4kP3IS9Hid521xIZg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qYI7XT5hdspjkPIaBp3DnLxqn9KZz2A8xlsV71MrpRTPtO8guhDJwNYt7i1y35wrn79ETj74Qtknp6yIJZ1ss/2tnCGYi+n1z4+tFwZ8rw45rfPve10Mlx2jxZI+5KZ76zzYQj6r79NFwddBQzVaZS67mLIvAHnmbB3SgVTpkBYRL6ddDMNs+hT9jRA0cfIeSK+elhx9aDONxe8kQTzaEhT/cvWZoywIybROPrxcbA6wJqoqKfUuXlVxcWB6SPL3vqGnYh8KEvEQmmjZMmDgiFNv8nykYn+1V9QA+jZJEf3yRxypa8goY9fQbqfCkPO+gWLGlG27EDHT+KNkNgTlR2+LjTWYPKoVIw+5QPfgtLHFO29U7Z7Dx6NzEoUHvqXK0C6Lu7A5xoU5wkwBvI6FsWzvj7kirFHoyJ5Iuc6H0wSJ2dzK+N9HhCKCRfxHwX4odmiP4VSf20BoTKL181MGdUk4WEXgamoLOqLbcgHPt2iVCMHi7QtQBwQi6dAMXCBnNZbfiCPyMYeK20HqiQUyU29I14OPVHPNuWONGRTOL+Mf0DwZ3//nMu92Zeyo4JKZjM3KckhPpXvKgjgKqAUr50/Ki+LK/4+DIM9CuPdXE6let5StIv9qrEIDPS6sPI/7UbCl106Fn8/LYIHzrLZ3zg==
X-OriginatorOrg: belden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR18MB5783.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca64952f-f29c-482a-88f8-08decca28c90
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 18:59:24.7962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0f7367b1-44f7-45a7-bb10-563965c5f2e5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M6AN+pmi3VgVkzpugP4yRVmRbKg3FfrZNF7vdmxOVvanWhmkSFTg2pK2hfX0J9xAMH8sj2wUmuJMd8K1QE1Nxmu+FeCBlhfQlEnv/j9pPwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB5548
X-Proofpoint-GUID: fHGQGK-PnWq4ErFq0ZC38kM5SNkrvpew
X-Authority-Analysis: v=2.4 cv=Bs+tB4X5 c=1 sm=1 tr=0 ts=6a32ee90 cx=c_pps
 a=3079EDIPZoP+OxznWXLZSg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=mCf63rc527wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l-oUmhW3RMErs0E8rZCB:22 a=408dvcsKgvW3Vj-g96bp:22 a=OcE5tU-iAAAA:8
 a=WDlp8lUfAAAA:8 a=rTBFlHIACeVy1l0DLesA:9 a=r-HJ9bD__24A:10 a=Wpz8ju6o9T4A:10
 a=CjuIK1q_8ugA:10 a=s5zKW874KtQA:10 a=BooMQqvJ4ork6bmEOYlM:22
 a=qwkNQZnGtIHGNKTLT1RO:22
X-Proofpoint-ORIG-GUID: fHGQGK-PnWq4ErFq0ZC38kM5SNkrvpew
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE4MyBTYWx0ZWRfX++A4RGvfiQoq
 I1jm07NjWxgacK8M8GrVCd994oXVTz4nqopfYIFwD86+kAiZIC0+s4FinW30VW/DdKOA2UscUoq
 tSv2qMISPHQ6WWoV7yURsLFTWDwAHxUQ/QL3hhv8INP4hCLRXKL7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE4MyBTYWx0ZWRfXxZT3a+97Q+Td
 DwQqy/aoKecmDzlQe9R7uZSXpb5LUxFwJG4Ijn2XOPW0l5iyRc3CMWXyeZVQ4QwhRhdMZvINc8G
 AM3vyykV2I8fUDbuKPLm89999beBDsRzgXDo6yNzUtggwzL0K2TobS1janHgZqF/dTIZxeyH+SF
 QuuXbFtXPZ05ZQeG0k7DZDYaIF4zdELtS/ZhhBuj+1cyBoZq1xkT6pn/b8OQ25qokRGUJfbMFIQ
 wDwhKPa6mWUGaC2FhaRnyqYzpejccjpsbkKBRGeeI0c5hwg1/spHhBpIYvx+IIUvQrHFOmAGRZo
 MB0HXYR+dRTHlue9bTrhy1CFr54+hQ+wFJ3oidGn3yBOS+3EPHy32pXNwihpoa/mWkFSjEi1Cc5
 fMpVKYyP3v5mOoOGgfzmcW+7kMGlEVdLhmMUGbtZSy0bHaSzZ3nFNc3XdHANXB3z/nSGRRXHwxu
 /SKq/9QVv586h/W+HMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170183
X-Proofpoint-TriggeredRule: module.spam.rule.outbound_notspam
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 17 Jun 2026 18:59:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19729

From cd89f0c841d9611d79047c70045a05f6ac41da56 Mon Sep 17 00:00:00 2001
From: Gabriel Smith <gabriel.smith@belden.com>
Date: Wed, 17 Jun 2026 17:53:56 +0000
Subject: [PATCH] fetch2/crate: support user-defined protocols

By default HTTPS is used for crate downloads, but both HTTP and FTP are
also supported by wget. FTP is not supported by crate registries so
it is not recommended. This adds a protocol parameter similar to the
git fetcher to allow a user to specify a different protocol.

Documentation has been updated to mention the new parameter.

Signed-off-by: Gabriel Smith <gabriel.smith@belden.com>
---
 .../bitbake-user-manual-fetching.rst          |  5 ++++
 lib/bb/fetch2/crate.py                        | 24 +++++++++++++++----
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc=
/bitbake-user-manual/bitbake-user-manual-fetching.rst
index c2747c401..b96018a4e 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -716,6 +716,11 @@ The format for the :term:`SRC_URI` setting must be::
=20
    SRC_URI =3D "crate://REGISTRY/NAME/VERSION"
=20
+This fetcher supports the following parameters:
+
+-  *"protocol":* The protocol used to fetch the crates. The default is "ht=
tps".
+   You can also use "http".
+
 Here is an example URL::
=20
    SRC_URI =3D "crate://crates.io/glob/0.2.11"
diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
index f94e153ee..830612c98 100644
--- a/lib/bb/fetch2/crate.py
+++ b/lib/bb/fetch2/crate.py
@@ -1,7 +1,16 @@
 # ex:ts=3D4:sw=3D4:sts=3D4:et
 # -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 """
-BitBake 'Fetch' implementation for crates.io
+BitBake 'Fetch' implementation for cargo registries, e.g. crates.io
+
+SRC_URI =3D "crate://some.host/crate_name/version;OptionA=3Dxxx;OptionB=3D=
xxx;..."
+
+Supported SRC_URI options are:
+
+- protocol
+   The method to use to download the crate file. Common options are "http",
+   "https", and "ftp". The default is "https".
+
 """
=20
 # Copyright (C) 2016 Doug Goldstein
@@ -63,7 +72,7 @@ class Crate(Wget):
         Sets up the download for a crate
         """
=20
-        # URL syntax is: crate://NAME/VERSION
+        # URL syntax is: crate://HOST/NAME/VERSION
         # break the URL apart by /
         parts =3D ud.url.split('/')
         if len(parts) < 5:
@@ -78,13 +87,20 @@ class Crate(Wget):
         # host (this is to allow custom crate registries to be specified
         host =3D '/'.join(parts[2:-2])
=20
+        if 'protocol' in ud.parm:
+            proto =3D ud.parm['protocol']
+        else:
+            proto =3D 'https'
+
         # If using crates.io use the CDN directly as per https://crates.io=
/data-access
         if host =3D=3D 'crates.io':
+            if proto !=3D 'https':
+                bb.warn("URL: %s does the %s protocol which is not support=
ed by crates.io. Please change to ;protocol=3Dhttps in the url." % (ud.url,=
 proto))
             ud.url =3D "https://static.crates.io/crates/%s/%s/download" % =
(name, version)
             ud.versionsurl =3D 'https://index.crates.io/' + self._generate=
_index_path(name)
         else:
-            ud.url =3D "https://%s/%s/%s/download" % (host, name, version)
-            ud.versionsurl =3D "https://%s/%s/versions" % (host, name)
+            ud.url =3D "%s://%s/%s/%s/download" % (proto, host, name, vers=
ion)
+            ud.versionsurl =3D "%s://%s/%s/versions" % (proto, host, name)
=20
         ud.parm['downloadfilename'] =3D "%s-%s.crate" % (name, version)
         if 'name' not in ud.parm:
--=20
2.54.0

**********************************************************************
DISCLAIMER:
Privileged and/or Confidential information may be contained in this message=
. If you are not the addressee of this message, you may not copy, use or de=
liver this message to anyone. In such event, you should destroy the message=
 and kindly notify the sender by reply e-mail. It is understood that opinio=
ns or conclusions that do not relate to the official business of the compan=
y are neither given nor endorsed by the company. Thank You.

