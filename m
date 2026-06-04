Return-Path: <david.reyna@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B70CD6E6E
	for <webhook@archiver.kernel.org>; Thu,  4 Jun 2026 18:51:36 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2833.1780599089556758550
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Jun 2026 11:51:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=PbnlW0dt;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=0615bc182f=david.reyna@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654GkjWv2725334
	for <bitbake-devel@lists.openembedded.org>; Thu, 4 Jun 2026 18:51:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=kcEH77CTJWOPbf3jVzq5
	aTT6B8O/sXCJe75AAA8FO1U=; b=PbnlW0dtHFTV11Ue+es+2UWcZaascDPVx/Ba
	x5iKTuC04ieNFkIGrCuItdFODfFHwrorQbHwl49pH4XgERkTCUnzw/n0+3SZLgDO
	/4KplWFH+x0bQIKU2hYgk+Ufx+LqTSSJRqlWhqVQZtsJt8hZXztv2nAseoYBHvDA
	roEtwxmxTUHhrQq3xb9wLQfwHGsVDp4l5pg0AySPX4vzYUQj8uRIyMdFvTqwD+XB
	wfMxWrhkGTAa6VWFThhzQ/9jfzrxNIl07XoOoTqejVR/idCzbPcaRHLFd3n6TqlW
	+gjmc7J62jREkghtnYjPIw/5iD9f7+dE1QOF3H8+tM81Lm8GYQ==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012022.outbound.protection.outlook.com [52.101.53.22])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4efpv8h38k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 04 Jun 2026 18:51:26 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dH6ufELEnpEDIuWD+n1tYc0zW+r1jllz5hTDtHq+Q5ugEbsny5kNZ8+8RzoI38f40uaMi6snsjyo5pg08RP4U8bl8pEn7R/9jDBYR9F/KS+FC3TtRSfsZbYxg77gP3pAMaAwqoiJYe1JM36SpbK5JQkF405SA8iE99x3FqiGAF87jUs8qEcDulMliIFk89P1dDUqeKEAzO5kieifHujnqlLCKotkY2xEvpMcpRLhK5BBowjYxqDkysZuigh17DGTa5qUEhyQjLTOvaeSotdGS5jg5fgg3pg93K6BiqqWTaW+WVMI1uzajTdUtTgdDlVwGrvAYoRyBUiSY65D30m44g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcEH77CTJWOPbf3jVzq5aTT6B8O/sXCJe75AAA8FO1U=;
 b=EXre/JmMPAsGbwMRy+bh/nJz1hEj9HA//YgJmKRikDELR/Blvp/pqDd/MnbVgYPZOGyDFXjsnhIitzdrYaafnebWyS5dJ1Uyynjkp5zW3ts27P7Qn/LzBzi7Nrfdy6nvGRJnJ0yJhWdWMVbDyGqTyDtnaxv+DHiJOkqRkJTlR4AZ3A0k1FVdoV7RkaA59U5IdXq7UZO7j8cKBOzkNPWIuPZWAlxJstk4m92nR3eIqV0jKP99KrVaGCJIzaOmttpWK8QwYKdZFnpUGFaSVZwLqZHffeEeCvm/g/R504rbzCph4CvUFaHHVJaDjVlVtffeLEJmxXxUxQ7nChEnQigR8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA1PR11MB7677.namprd11.prod.outlook.com (2603:10b6:208:3fd::5)
 by CH3PR11MB7322.namprd11.prod.outlook.com (2603:10b6:610:14a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 18:51:23 +0000
Received: from IA1PR11MB7677.namprd11.prod.outlook.com
 ([fe80::d8e5:e930:6a48:871e]) by IA1PR11MB7677.namprd11.prod.outlook.com
 ([fe80::d8e5:e930:6a48:871e%6]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 18:51:23 +0000
From: "Reyna, David" <david.reyna@windriver.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: [bitbake-devel] [PATCH] toaster: use https for clones, remove cgit in
 links in defaults
Thread-Topic: [bitbake-devel] [PATCH] toaster: use https for clones, remove
 cgit in links in defaults
Thread-Index: Adz0Usb3PJF8uOQrR9qzEYrE3eYeIQ==
Date: Thu, 4 Jun 2026 18:51:22 +0000
Message-ID: 
 <IA1PR11MB7677F6126AE7A7925853D7BAEA102@IA1PR11MB7677.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ActionId=c6c176b2-6772-41f7-87cf-ba331e81df0d;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ContentBits=0;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Enabled=true;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Method=Standard;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Name=INTERNAL;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SetDate=2026-06-04T18:45:07Z;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SiteId=8ddb2873-a1ad-4a18-ae4e-4644631433be;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB7677:EE_|CH3PR11MB7322:EE_
x-ms-office365-filtering-correlation-id: 6d2dcf14-5caf-46e8-72c1-08dec26a45fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700021|13003099007|12006099003|18002099003|11063799006|56012099006;
x-microsoft-antispam-message-info: 
 apRrBxyx3uO9ah1YMo7TgbogSThrcSVJBYBj7fCLdAR2YVF1H6Nh7E7qQoX6QZKDJYwF0doqlSQF7zioLLbtk4GFRrSSJHjhFmZJkGrIgRqJcobVkKPVrQ35TiIDYCGn6llJSaBxJZCFZDLg+cGeRCwdh19WX1IwiqvPKMKhD8A+ZJin2p25RVMHrWiRmiyPXH4v/2gPSnP9PUNmt0Zv1O+7RGv7q95/Tszoch2T8m8MjMRW/Jw4gj4H9yY/l8aQgIe+EDIxEKRIopl2Ys3VIFnudHc+YZwhNtINtGk29UXZVHtoK71pfIaq3HcA8iaiWWVmViJ/AfMu7nIkzj4MbxrFm3iBjhsDFNJJuWzWFioYS6KD+azhiVykffYdFLh4ZSr1vB4swPGU+QBacdP4EoQMrkqrVZ6T9DE+h9pkEgPDSpAcTDcX4sUpNtO7A1kOIQOtreZUdi8tojpB8Wo86j9Y24jakvlHz0kgsR6iloCsEwtR3WGx4pVijd9lxlXSOcqNh49A1/H1aK6AMC4T4v687jeQMtKz9qnqnnwxYISCCpNDFN+Pn6NdJXa2yqWiS2i/DgtJP6L12W9b5iN7/kS6aH4vqsiQrS6uNbNacabxTncU1jtju+VRmvBAxBxuvq8rbqlr7n3oAzbV6FPXnNYAZ0UpNaX8aVB3JypTo0PmKT6FcdqNmRV3rXDx/g/3M9WS/43VkEmYI0fhQMKntQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7677.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700021)(13003099007)(12006099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?r8y2HrkmhHM2H9K+O3sf7tW1RHvTJo+ktF9/pjJOuN1iC4hdWF0v/p/eGgov?=
 =?us-ascii?Q?PLLKJBBXM6qz65BmVUkMsDmbSBAvBBBd1KPES1iJNFAQu1dmSZO2CyYpDTKH?=
 =?us-ascii?Q?ibojMwrpnD4obShSEnbZBgQuSeFkaBvMYhGTmPabyG8+XHqXyok0Jc6+8EVJ?=
 =?us-ascii?Q?1YA/e/FtfBRdtIrPL8SWiqyd5gi8s7kE/qhvtBls5xi0qWF/7V+EvIFEgnga?=
 =?us-ascii?Q?SU98R28aYwaiQDk50GpKIcdLudTqdS+7wnG6k6yrhRWxelcSeUFelzjXFfXG?=
 =?us-ascii?Q?28/eyzuKTKEwd6rmJ09/w7KMMlF4J0UDBLV9nHOCL2ylX7D/Hi6oYDY7Djmq?=
 =?us-ascii?Q?xm/NKk+yPy82nd669GN6MGJ37huTE8jC2wjsjSfe/a2vizQl1O1Vd8H8IYUN?=
 =?us-ascii?Q?q7egXd9i1FDwt6FMGGPk62qyug2e8TtjYJfeb2vjwaqULUQ6gJhcNdsL4BaJ?=
 =?us-ascii?Q?dD+vdsLEYYOzZuLUavmr1Dnt4gJe+UiU/YAion1MtIBg6b3DujlmeaS6VHmr?=
 =?us-ascii?Q?Bmd65MI0/LC7cndRrjO8xjZxRXmxJ+EqQRrUTv4CDSZBl365tqq28rewThrD?=
 =?us-ascii?Q?2D7Mvz2Bfg+BUY50NCPyG44DzRptfgEUEn6s2G/4SDq6Tu0CatOU9cG/q+2y?=
 =?us-ascii?Q?XHBzCLtDb6uf7UXX0/HDm+G1gMn/xZosedicHSf3pfLifXEfhsl0SZmXtxkO?=
 =?us-ascii?Q?AXO+DjqMABop2g+qVcMZespUrew8VQiYchAPxGs8ewF3Ht401ND5lCFNHXLF?=
 =?us-ascii?Q?/U36K66SDSAq7fd4Hsu13BHbfcRftpxehgziWcw54SBlLAp6Vu5n/tQIbYU9?=
 =?us-ascii?Q?oDtbi6H8Cguo7S8XAgZCyA2CKnbdWNTQqe0wNV4gVJ2E2V0HWFZ5LpyCpLNS?=
 =?us-ascii?Q?3dqj5YpYuFfMfbWKxCg3w8pP8l3YVDfZJ6ycK2qdoaiRqUWr6WxO6aQwE8ak?=
 =?us-ascii?Q?Z2NeqVBoPvIjyIWInkcS0H0vAjntGljxLOrop1KUhAQPmtNKZUCT48KACLht?=
 =?us-ascii?Q?nyP0ld6mkUtMtQd81MOn2W/2JSSFf71umNzf4itA7B/CqKLKF/JclgHAI2ze?=
 =?us-ascii?Q?2uVixfuj5GxDJKPnFA1T6LqLslRr0p7BJ5v57CpKSEu/gP+4iKhZn80vK5hS?=
 =?us-ascii?Q?IWXKWcqxXzMJ88iklSCNjAqzgSqntMjHhdqVTUd5oXvIpAQhAMLAXa2nmK7D?=
 =?us-ascii?Q?WMycxtMI35JePaQnFCT1VN/22AZmcycIBq5YNmHhnOSnqQWHaycXkuhcCIRS?=
 =?us-ascii?Q?Zhkz9Kja7O1Q5wxSODs2XUkNbrnrzWlxQlNrDNGQvCkTrR88g0MbJUkXYQ+b?=
 =?us-ascii?Q?7i7NgHJawgIrUdKxXHk5NZ+pVd7FY1sYcPgIMeAH7cB4B400DmQ40T718Nr+?=
 =?us-ascii?Q?hCXz4dTtjoopAYcshyn0ulbL128E03LOfPLmz273RXr9VpfBs5ELZZl/FEQN?=
 =?us-ascii?Q?qnYFXOZ3mdG8EjIQiicIMcx1aSqV2ESqltLrTzqCud5z3h7VgNyAh7Sm9y6d?=
 =?us-ascii?Q?eob2WDyRwU7lknUzhcprcfWIg3znXvksWF6a3qewdG91z98q2opO3vLD5pQx?=
 =?us-ascii?Q?SrZK2TnzBULMQYIz2xpCLU096bZHHxapSQSWQ5Yb+T3XxnVXGb6GQ3q5f2E6?=
 =?us-ascii?Q?BRnlHVB1LqRb9dFjBsyfnpjtUjsC94ZywWgYf3+pWsLHb4e5J9O2OsA9e5Ds?=
 =?us-ascii?Q?ZDdnIq7rtznNKRFcb192DlCOB/cCxjg+8r4J9aNQ1HpxLxmkO6nBB7jAfI1N?=
 =?us-ascii?Q?T8S7raGoHHhKmCYhlgffKKu6WyqEOgPviV4JsnUhIXgaDLUexv/FiXgPEOQ3?=
x-ms-exchange-antispam-messagedata-1: MqXsgQy7I7FIdQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	CplVJYK3MoXsxI7XVZF4VxISRZaYenXqdSK94/9GbS1PbYRNSLYHxN6bw9xnTRL/93qMDPXgxjoI5q4ADJRTFJjkyuqCkwOh452lCcboDN5I5BYu/NDZYUd1qw8HeqNLskedPPTFxPhp6TM0xpej2e/kStbbOFLIGk/ZtJYtvp7oVQVz0wmpy97fOAghefAsQUGKtjzXkKmRKBcf4dl4jy79gGXH/tJY7Nc5TlyL9RHAo6Pr0w0Z0GC06EesxYdYKmWgwhP9hf2q7s/cTfmuZSJBMPIThQE4NqueBkggyd8/E8wJGQhEfrP4r/gXdkbEzMR0JRp8LMhNiVgamxcjdg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7677.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d2dcf14-5caf-46e8-72c1-08dec26a45fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 18:51:22.9638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oQ/nxwoges6ONqYaw5tKX/n/QNasDZTp5n0nMwDaoEn/kHPXojftHuTbZSQdWVVMeem33QJcW+zNIk1d6l+D/egwXMv4rLFEFtj6/DIDkIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7322
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE4NCBTYWx0ZWRfX7p0dtxkHRSqC
 7xHcsfQHmYPXW1cfriD+23UQxifoGklTjrg0Uu7f7tsuCrpnNCkzJf0Pc7ldKssFMZXxyYGywg0
 FWuoNrgND+wp1hVLdtlm8c9aE7AAotRu0zGB2r3UGcueulpC7IC9VnXf2VuzvKtjEgeZdUn34RO
 eAUAewqrsgBtJxmZofZ61+coEA9jXfoChheuVGzw4y+oGif1NJ5KPfgjpYV41wF6BpzfvWrpK83
 4F17tAmQW7TsexbPNcj4SW97DEJ63YAbGlVw4L85EJ15m/zB9bFSqrZirNKKxM4wQqqYuAiJZDL
 5CIRF8htRDxaQA2ANzNgGnWQsIDq9A217Sgakkt2Pn7uMZc0fJH5H8FXyRbmuDoPMj+je3MQcfY
 WlZnbbtnjGq+06c9vcySdBdbObsG2RBioSzCNVzGx+N+SSPHd+l/KvYRXcnCJuvSGPGmclRTfzE
 J8Gej63UoaDeYr4B1Ng==
X-Authority-Analysis: v=2.4 cv=Opt/DS/t c=1 sm=1 tr=0 ts=6a21c92f cx=c_pps
 a=NvljgnbIoj+kJW4KAcm4xw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8 a=Q4-j1AaZAAAA:8 a=iGHA9ds3AAAA:8
 a=xQlD5id27TxGrhr-z4oA:9 a=X-DhfrOAHt_3wxq4:21 a=lqcHg5cX4UMA:10
 a=r-HJ9bD__24A:10 a=CjuIK1q_8ugA:10 a=ImwWUX5h3JJ3gRE9moBe:22
 a=8DJy0ENz141agDM1nwP5:22 a=OEIawDv5KMfXcO1rhPY7:22 a=FdTzh2GWekK77mhwV6Dw:22
 a=9H3Qd4_ONW2Ztcrla5EB:22 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-GUID: bqZWAdBdzZ-uW0t7PXHORg7m8WhrF1W7
X-Proofpoint-ORIG-GUID: bqZWAdBdzZ-uW0t7PXHORg7m8WhrF1W7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040184
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 04 Jun 2026 18:51:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19610

From 6aaf733d340aacc5d3be3920d84976e7034166a2 Mon Sep 17 00:00:00 2001
From: David Reyna <mailto:David.Reyna@windriver.com>
Date: Thu, 4 Jun 2026 11:37:01 -0700
Subject: [PATCH] toaster: use https for clones, remove cgit in links in def=
aults

The YP and OE repos have moved to "https:" instead of "git:" for cloning. Y=
P has
removed the "cgit/cgit.cgi" from web URLs for layers. This patch updates th=
e
fixture files that bootstrap these values for bitbake and the default layer=
s.
Also, fix Wrynose bitbake version.

Note that Toaster is dependent on these values also fixed in the Layer
Index (#16240).

[YOCTO #16304]

Signed-off-by: David Reyna <mailto:David.Reyna@windriver.com>
---
 lib/toaster/orm/fixtures/gen_fixtures.py | 31 +++++++++++-------
 lib/toaster/orm/fixtures/poky.xml        | 40 ++++++++++++------------
 2 files changed, 39 insertions(+), 32 deletions(-)

diff --git a/lib/toaster/orm/fixtures/gen_fixtures.py b/lib/toaster/orm/fix=
tures/gen_fixtures.py
index 8c03d9c9e..dda0b8196 100755
--- a/lib/toaster/orm/fixtures/gen_fixtures.py
+++ b/lib/toaster/orm/fixtures/gen_fixtures.py
@@ -35,7 +35,7 @@ verbose =3D False
 # [0=3DCodename, 1=3DYocto Project Version, 2=3DRelease Date, 3=3DCurrent =
Version, 4=3DSupport Level, 5=3DPoky Version, 6=3DBitBake branch]
 current_releases =3D [
     # Release slot #1
-    ['Wrynose','6.0','April 2026','6.0 (April 2026)','Long Term Support (u=
ntil April 2030)','','2.16'],
+    ['Wrynose','6.0','April 2026','6.0 (April 2026)','Long Term Support (u=
ntil April 2030)','','2.18'],
     # Release slot #2 'local'
     ['HEAD','HEAD','','Local Yocto Project','HEAD','','HEAD'],
     # Release slot #3 'master'
@@ -81,7 +81,7 @@ prolog_template =3D '''\
 bitbakeversion_poky_template =3D '''\
   <object model=3D"orm.bitbakeversion" pk=3D"{{bitbake_id}}">
     <field type=3D"CharField" name=3D"name">{{name}}</field>
-    <field type=3D"CharField" name=3D"giturl">git://git.openembedded.org/b=
itbake</field>
+    <field type=3D"CharField" name=3D"giturl">https://git.openembedded.org=
/bitbake</field>
     <field type=3D"CharField" name=3D"branch">{{branch}}</field>
     <field type=3D"CharField" name=3D"dirpath"></field>
   </object>
@@ -89,7 +89,7 @@ bitbakeversion_poky_template =3D '''\
 bitbakeversion_oecore_template =3D '''\
   <object model=3D"orm.bitbakeversion" pk=3D"{{bitbake_id}}">
     <field type=3D"CharField" name=3D"name">{{name}}</field>
-    <field type=3D"CharField" name=3D"giturl">git://git.openembedded.org/b=
itbake</field>
+    <field type=3D"CharField" name=3D"giturl">https://git.openembedded.org=
/bitbake</field>
     <field type=3D"CharField" name=3D"branch">{{bitbakeversion}}</field>
   </object>
 '''
@@ -247,7 +247,7 @@ def generate_poky():
             params['description'] =3D 'Local Yocto Project'
             params['name'] =3D 'local'
         else:
-            params['help_source'] =3D 'using the tip of the &lt;a href=3D"=
https://git.yoctoproject.org/cgit/cgit.cgi/poky/log/{{h_release}}"&gt;Yocto=
 Project {{Release}} branch&lt;/a&gt;'
+            params['help_source'] =3D 'using the tip of the &lt;a href=3D"=
https://git.yoctoproject.org/meta-yocto/log/{{h_release}}"&gt;Yocto Project=
 {{Release}} branch&lt;/a&gt;'
             params['description'] =3D 'Yocto Project {{release_version}} "=
{{Release}}"'
         if 'master' =3D=3D params['release']:
             params['h_release'] =3D ''
@@ -280,10 +280,17 @@ def generate_poky():
         params =3D {}
         params['layer'] =3D layer
         params['layer_id'] =3D str(i+1)
-        params['vcs_url'] =3D 'git://git.yoctoproject.org/poky'
-        params['vcs_web_url'] =3D 'https://git.yoctoproject.org/cgit/cgit.=
cgi/poky'
-        params['vcs_web_tree_base_url'] =3D 'https://git.yoctoproject.org/=
cgit/cgit.cgi/poky/tree/%path%?h=3D%branch%'
-        params['vcs_web_file_base_url'] =3D 'https://git.yoctoproject.org/=
cgit/cgit.cgi/poky/tree/%path%?h=3D%branch%'
+        if 'openembedded-core' =3D=3D layer:
+            params['vcs_url'] =3D 'https://git.openembedded.org/openembedd=
ed-core'
+            params['vcs_web_url'] =3D 'https://git.openembedded.org/openem=
bedded-core'
+            params['vcs_web_tree_base_url'] =3D 'https://git.openembedded.=
org/openembedded-core/tree/%path%?h=3D%branch%'
+            params['vcs_web_file_base_url'] =3D 'https://git.openembedded.=
org/openembedded-core/tree/%path%?h=3D%branch%'
+        else:
+            # Yocto Project layers: meta-poky, meta-yocto-bsp
+            params['vcs_url'] =3D 'https://git.yoctoproject.org/meta-yocto=
'
+            params['vcs_web_url'] =3D 'https://git.yoctoproject.org/meta-y=
octo/tree'
+            params['vcs_web_tree_base_url'] =3D 'https://git.yoctoproject.=
org/meta-yocto/tree/%path%?h=3D%branch%'
+            params['vcs_web_file_base_url'] =3D 'https://git.yoctoproject.=
org/meta-yocto/tree/%path%?h=3D%branch%'
=20
         if i:
             print_str('',fd)
@@ -392,10 +399,10 @@ def generate_oe_core():
         params =3D {}
         params['layer'] =3D layer
         params['layer_id'] =3D str(i+1)
-        params['vcs_url'] =3D 'git://git.openembedded.org/openembedded-cor=
e'
-        params['vcs_web_url'] =3D 'https://cgit.openembedded.org/openembed=
ded-core'
-        params['vcs_web_tree_base_url'] =3D 'https://cgit.openembedded.org=
/openembedded-core/tree/%path%?h=3D%branch%'
-        params['vcs_web_file_base_url'] =3D 'https://cgit.openembedded.org=
/openembedded-core/tree/%path%?h=3D%branch%'
+        params['vcs_url'] =3D 'https://git.openembedded.org/openembedded-c=
ore'
+        params['vcs_web_url'] =3D 'https://git.openembedded.org/openembedd=
ed-core'
+        params['vcs_web_tree_base_url'] =3D 'https://git.openembedded.org/=
openembedded-core/tree/%path%?h=3D%branch%'
+        params['vcs_web_file_base_url'] =3D 'https://git.openembedded.org/=
openembedded-core/tree/%path%?h=3D%branch%'
         if i:
             print_str('',fd)
         print_template(layer_oe_core_template,params,fd)
diff --git a/lib/toaster/orm/fixtures/poky.xml b/lib/toaster/orm/fixtures/p=
oky.xml
index dd9ea3c1f..b1b3861d6 100644
--- a/lib/toaster/orm/fixtures/poky.xml
+++ b/lib/toaster/orm/fixtures/poky.xml
@@ -9,25 +9,25 @@
   <!-- Bitbake versions which correspond to the metadata release -->
   <object model=3D"orm.bitbakeversion" pk=3D"1">
     <field type=3D"CharField" name=3D"name">wrynose</field>
-    <field type=3D"CharField" name=3D"giturl">git://git.openembedded.org/b=
itbake</field>
-    <field type=3D"CharField" name=3D"branch">2.16</field>
+    <field type=3D"CharField" name=3D"giturl">https://git.openembedded.org=
/bitbake</field>
+    <field type=3D"CharField" name=3D"branch">2.18</field>
     <field type=3D"CharField" name=3D"dirpath"></field>
   </object>
   <object model=3D"orm.bitbakeversion" pk=3D"2">
     <field type=3D"CharField" name=3D"name">HEAD</field>
-    <field type=3D"CharField" name=3D"giturl">git://git.openembedded.org/b=
itbake</field>
+    <field type=3D"CharField" name=3D"giturl">https://git.openembedded.org=
/bitbake</field>
     <field type=3D"CharField" name=3D"branch">HEAD</field>
     <field type=3D"CharField" name=3D"dirpath"></field>
   </object>
   <object model=3D"orm.bitbakeversion" pk=3D"3">
     <field type=3D"CharField" name=3D"name">master</field>
-    <field type=3D"CharField" name=3D"giturl">git://git.openembedded.org/b=
itbake</field>
+    <field type=3D"CharField" name=3D"giturl">https://git.openembedded.org=
/bitbake</field>
     <field type=3D"CharField" name=3D"branch">master</field>
     <field type=3D"CharField" name=3D"dirpath"></field>
   </object>
   <object model=3D"orm.bitbakeversion" pk=3D"4">
     <field type=3D"CharField" name=3D"name">scarthgap</field>
-    <field type=3D"CharField" name=3D"giturl">git://git.openembedded.org/b=
itbake</field>
+    <field type=3D"CharField" name=3D"giturl">https://git.openembedded.org=
/bitbake</field>
     <field type=3D"CharField" name=3D"branch">2.8</field>
     <field type=3D"CharField" name=3D"dirpath"></field>
   </object>
@@ -39,7 +39,7 @@
     <field type=3D"CharField" name=3D"description">Yocto Project 6.0 "Wryn=
ose"</field>
     <field rel=3D"ManyToOneRel" to=3D"orm.bitbakeversion" name=3D"bitbake_=
version">1</field>
     <field type=3D"CharField" name=3D"branch_name">wrynose</field>
-    <field type=3D"TextField" name=3D"helptext">Toaster will run your buil=
ds using the tip of the &lt;a href=3D"https://git.yoctoproject.org/cgit/cgi=
t.cgi/poky/log/?h=3Dwrynose"&gt;Yocto Project Wrynose branch&lt;/a&gt;.</fi=
eld>
+    <field type=3D"TextField" name=3D"helptext">Toaster will run your buil=
ds using the tip of the &lt;a href=3D"https://git.yoctoproject.org/meta-yoc=
to/log/?h=3Dwrynose"&gt;Yocto Project Wrynose branch&lt;/a&gt;.</field>
   </object>
   <object model=3D"orm.release" pk=3D"2">
     <field type=3D"CharField" name=3D"name">local</field>
@@ -53,14 +53,14 @@
     <field type=3D"CharField" name=3D"description">Yocto Project master</f=
ield>
     <field rel=3D"ManyToOneRel" to=3D"orm.bitbakeversion" name=3D"bitbake_=
version">3</field>
     <field type=3D"CharField" name=3D"branch_name">master</field>
-    <field type=3D"TextField" name=3D"helptext">Toaster will run your buil=
ds using the tip of the &lt;a href=3D"https://git.yoctoproject.org/cgit/cgi=
t.cgi/poky/log/"&gt;Yocto Project Master branch&lt;/a&gt;.</field>
+    <field type=3D"TextField" name=3D"helptext">Toaster will run your buil=
ds using the tip of the &lt;a href=3D"https://git.yoctoproject.org/meta-yoc=
to/log/"&gt;Yocto Project Master branch&lt;/a&gt;.</field>
   </object>
   <object model=3D"orm.release" pk=3D"4">
     <field type=3D"CharField" name=3D"name">scarthgap</field>
     <field type=3D"CharField" name=3D"description">Yocto Project 5.0 "Scar=
thgap"</field>
     <field rel=3D"ManyToOneRel" to=3D"orm.bitbakeversion" name=3D"bitbake_=
version">4</field>
     <field type=3D"CharField" name=3D"branch_name">scarthgap</field>
-    <field type=3D"TextField" name=3D"helptext">Toaster will run your buil=
ds using the tip of the &lt;a href=3D"https://git.yoctoproject.org/cgit/cgi=
t.cgi/poky/log/?h=3Dscarthgap"&gt;Yocto Project Scarthgap branch&lt;/a&gt;.=
</field>
+    <field type=3D"TextField" name=3D"helptext">Toaster will run your buil=
ds using the tip of the &lt;a href=3D"https://git.yoctoproject.org/meta-yoc=
to/log/?h=3Dscarthgap"&gt;Yocto Project Scarthgap branch&lt;/a&gt;.</field>
   </object>
=20
   <!-- Default project layers for each release -->
@@ -121,10 +121,10 @@
   <object model=3D"orm.layer" pk=3D"1">
     <field type=3D"CharField" name=3D"name">openembedded-core</field>
     <field type=3D"CharField" name=3D"layer_index_url"></field>
-    <field type=3D"CharField" name=3D"vcs_url">git://git.yoctoproject.org/=
poky</field>
-    <field type=3D"CharField" name=3D"vcs_web_url">https://git.yoctoprojec=
t.org/cgit/cgit.cgi/poky</field>
-    <field type=3D"CharField" name=3D"vcs_web_tree_base_url">https://git.y=
octoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=3D%branch%</field>
-    <field type=3D"CharField" name=3D"vcs_web_file_base_url">https://git.y=
octoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=3D%branch%</field>
+    <field type=3D"CharField" name=3D"vcs_url">https://git.openembedded.or=
g/openembedded-core</field>
+    <field type=3D"CharField" name=3D"vcs_web_url">https://git.openembedde=
d.org/openembedded-core</field>
+    <field type=3D"CharField" name=3D"vcs_web_tree_base_url">https://git.o=
penembedded.org/openembedded-core/tree/%path%?h=3D%branch%</field>
+    <field type=3D"CharField" name=3D"vcs_web_file_base_url">https://git.o=
penembedded.org/openembedded-core/tree/%path%?h=3D%branch%</field>
   </object>
   <object model=3D"orm.layer_version" pk=3D"1">
     <field rel=3D"ManyToOneRel" to=3D"orm.layer" name=3D"layer">1</field>
@@ -159,10 +159,10 @@
   <object model=3D"orm.layer" pk=3D"2">
     <field type=3D"CharField" name=3D"name">meta-poky</field>
     <field type=3D"CharField" name=3D"layer_index_url"></field>
-    <field type=3D"CharField" name=3D"vcs_url">git://git.yoctoproject.org/=
poky</field>
-    <field type=3D"CharField" name=3D"vcs_web_url">https://git.yoctoprojec=
t.org/cgit/cgit.cgi/poky</field>
-    <field type=3D"CharField" name=3D"vcs_web_tree_base_url">https://git.y=
octoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=3D%branch%</field>
-    <field type=3D"CharField" name=3D"vcs_web_file_base_url">https://git.y=
octoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=3D%branch%</field>
+    <field type=3D"CharField" name=3D"vcs_url">https://git.yoctoproject.or=
g/meta-yocto</field>
+    <field type=3D"CharField" name=3D"vcs_web_url">https://git.yoctoprojec=
t.org/meta-yocto/tree</field>
+    <field type=3D"CharField" name=3D"vcs_web_tree_base_url">https://git.y=
octoproject.org/meta-yocto/tree/%path%?h=3D%branch%</field>
+    <field type=3D"CharField" name=3D"vcs_web_file_base_url">https://git.y=
octoproject.org/meta-yocto/tree/%path%?h=3D%branch%</field>
   </object>
   <object model=3D"orm.layer_version" pk=3D"5">
     <field rel=3D"ManyToOneRel" to=3D"orm.layer" name=3D"layer">2</field>
@@ -197,10 +197,10 @@
   <object model=3D"orm.layer" pk=3D"3">
     <field type=3D"CharField" name=3D"name">meta-yocto-bsp</field>
     <field type=3D"CharField" name=3D"layer_index_url"></field>
-    <field type=3D"CharField" name=3D"vcs_url">git://git.yoctoproject.org/=
poky</field>
-    <field type=3D"CharField" name=3D"vcs_web_url">https://git.yoctoprojec=
t.org/cgit/cgit.cgi/poky</field>
-    <field type=3D"CharField" name=3D"vcs_web_tree_base_url">https://git.y=
octoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=3D%branch%</field>
-    <field type=3D"CharField" name=3D"vcs_web_file_base_url">https://git.y=
octoproject.org/cgit/cgit.cgi/poky/tree/%path%?h=3D%branch%</field>
+    <field type=3D"CharField" name=3D"vcs_url">https://git.yoctoproject.or=
g/meta-yocto</field>
+    <field type=3D"CharField" name=3D"vcs_web_url">https://git.yoctoprojec=
t.org/meta-yocto/tree</field>
+    <field type=3D"CharField" name=3D"vcs_web_tree_base_url">https://git.y=
octoproject.org/meta-yocto/tree/%path%?h=3D%branch%</field>
+    <field type=3D"CharField" name=3D"vcs_web_file_base_url">https://git.y=
octoproject.org/meta-yocto/tree/%path%?h=3D%branch%</field>
   </object>
   <object model=3D"orm.layer_version" pk=3D"9">
     <field rel=3D"ManyToOneRel" to=3D"orm.layer" name=3D"layer">3</field>
--=20
2.43.0


