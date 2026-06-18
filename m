Return-Path: <david.reyna@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5581CD98E4
	for <webhook@archiver.kernel.org>; Thu, 18 Jun 2026 03:23:09 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11700.1781752983994755443
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 17 Jun 2026 20:23:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=Pos/gxwB;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=06294e593f=david.reyna@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I2jl3k3549282
	for <bitbake-devel@lists.openembedded.org>; Wed, 17 Jun 2026 20:23:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=UdYyw1I3ZYZ1PhJkt2oo
	6LMVqnqrEaZGu8N3RRD0D+c=; b=Pos/gxwBlw3Aozl8T/2+GvkAolb9RuvOpHhp
	uaUZv4iQmBe83iSyf/4p2e/hn4AhM1SNHtu8xw8i4wHrAGGueeGhVZQ2AZ37A5PK
	dWp0OqJGYrFdc0h7FRE7XEei1zCQCN3SMT0z7z4GzZvuHzlbGYHAhlRSIN2OLNYt
	0x/wFr4wREozQOwl+xCQeojnbcXwruyNC+LAiAzrXi/OVXy1N2jha3uKdciiUmq2
	rXmEvvVtJOaumuB4ab9TRSPbvWxJqDT51RKivtDaQqFnQbKpLhYATIdDhCtJoTo4
	ETw79ppBpLdNr6P8cfXUIMmTZAI8IBcTe11pcFup2tWDiOEScQ==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010018.outbound.protection.outlook.com [52.101.61.18])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4eueft23a4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 17 Jun 2026 20:23:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vxrkSVl/fZREuLpBH0DGBEAvzTWXnxycg97s+SrHq8Puvh0Xa859Uocgu2JG6Q75G6U0DToCfEbyFJgGbOOVuILIILJ+hZDNCDyn1fj/ps4KCAcRBxDDqKPiCu3aLpu6l+y/Ws8hKZqgvTYoP3KCLgY0qXetjKPedNGjqXaLlHGYy5IDz+iockj5UjvZCMPm29kdXTo8MsnMFtqwEHxNkyzdBzIY/DCJAhwXvkySZdYUZlHloCh1Ou4uVPYC5vDGTzUIxHI9rkEXS54hMzUVMgXPbsjJWYqz1S6OpjfwNCTWru+LCM5Rs4tpNuBzrbCx/y6mg5XqwrefE4MEibbClA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdYyw1I3ZYZ1PhJkt2oo6LMVqnqrEaZGu8N3RRD0D+c=;
 b=gGGgg4U5GQ+p5u9bVqCGC+NNM+BZX4gSNNRTBufDryJ3r8NLUmRRiDBmgiIktyIWqPNC8Wfrv5o/pC8XwfPYern6axT+8h8FtOnoqUhM4715timZ0IKgz5Dpv1pQ4RelvNLHweAh/WvnWI2/mHlvRnpE6QUuXSFgN7Kt9teHw6XZJDPVi/cA7UoEln0Lf0cnzemY553nme66MC1y0brpFVoHZUZwitauVO2Kr9AXF1OczvN5caSZyW4JT+MMwqdQdSB7N/u8dzyuOvwgSB05vuxptOZRm26Lsyvr9ikKnIV5wtq261my0JZ5kvcmvzKADsliW8UKuSVg7ChmInXz+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA1PR11MB7677.namprd11.prod.outlook.com (2603:10b6:208:3fd::5)
 by DS0PR11MB8052.namprd11.prod.outlook.com (2603:10b6:8:122::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Thu, 18 Jun
 2026 03:22:55 +0000
Received: from IA1PR11MB7677.namprd11.prod.outlook.com
 ([fe80::d8e5:e930:6a48:871e]) by IA1PR11MB7677.namprd11.prod.outlook.com
 ([fe80::d8e5:e930:6a48:871e%6]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 03:22:54 +0000
From: "Reyna, David" <david.reyna@windriver.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: [bitbake-devel] [PATCH] toaster: confirm bitbake versions
Thread-Topic: [bitbake-devel] [PATCH] toaster: confirm bitbake versions
Thread-Index: Adz+0YD1AHEtQiC0QiuxdbihN5+4MQ==
Date: Thu, 18 Jun 2026 03:22:54 +0000
Message-ID: 
 <IA1PR11MB7677339C22226DD69F513388EAE32@IA1PR11MB7677.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ActionId=e7aa1850-3d4c-44bb-bfab-ab57cff81682;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ContentBits=0;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Enabled=true;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Method=Standard;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Name=INTERNAL;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SetDate=2026-06-18T03:20:50Z;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SiteId=8ddb2873-a1ad-4a18-ae4e-4644631433be;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB7677:EE_|DS0PR11MB8052:EE_
x-ms-office365-filtering-correlation-id: 36006398-c71e-4b11-6e25-08decce8e2cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10070799003|38070700021|3023799007|18002099003|56012099006|11063799006|6133799003;
x-microsoft-antispam-message-info: 
 164FuqsHSuSZ06zA5T2YHZtUotHlRe3X4mhIA73pYbLSRr9Xb0apchEYV/N5m1OXgLftFtKdg96oidm+ISW6vPtUUf49fQB7IUjmy/RwbdTSvyvF+y69GWP5l5TSzn0DDQlwSmLqqZj5h/s+jSZYd+oM/+jGJ3O79Ha1ohiuyTgNk7o1PsRWdEka/jjgG2c+/o1H4Xm70FaAgcsxyF+R5MiYDnIo/zB0RuOZVoEXUi4BYhfvg0zQztZtqbbioYm+V8PS428oqiQIATUvjGOeqVws2ObVADcUlprIkSVwsRO7u1rj9IZghgX7eyJLf8cmkL6MZ8A/FxhKHj/ZTjIT/EnvJdSSChkcofBjqwFCzvUBPSdsDEGYLtyKIeOdYifz5inC2VNlP9vvYu4TqdlbB4rdu/YPEQysROq4JSvGB2yj0L902ar6O2EMgCG1/hoASofEGc69NIv8gTftLgnadVxurGfcFXJ0LUg9DVvt3veHmB50b64977qj5VLuU26KFsOsaWN6BR4SSA5hlNOCvTFhTrqYycpUpAIZC/sJXQSkp7GHpPVhjAXMcvR1ZD49gQueETIdyT6dQKd5y8o+ixDE0ZITVBY4svS7MNMkZNW3CJjcxwU3/Z2eSVmq0lbpjYgFdsS8tp9SPU1VIQQPcYsnXWzYi9oz0xrRSs7X/4KQUvXB4Paw89glSb4XW+eTCFgeR8sguLGYDPxezgTffcJDn8eHhq/51iV41zyT3OqNBL8MIFkf5k24z5ZSIXgf
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7677.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10070799003)(38070700021)(3023799007)(18002099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?sfs4+q+K5+Xds0o8qXpva1RH0mZhoK5cK1rMv3Q6vgY4sVsOw8fMjbF+p4IK?=
 =?us-ascii?Q?e2nlT4iy0U281HbIMNO/gXqhHdBO+dMefDJLOKWb7miXBNOL5mJWxZXdN++t?=
 =?us-ascii?Q?lR8LmgNZOOMCEvC/uCislwrYk7YjNoeSu4Fm9lHijqG/uxTqC4LvmP21GMs5?=
 =?us-ascii?Q?Cf1ryc+9hpSmniqkDNHBGjK5xb2XSZA5X8QVPdmTfI2YIdsT7A+tjDz0BqPL?=
 =?us-ascii?Q?1IxCg2kMmvqYMZ1jdLqAv8UCxlNtwjn5CmtZv6e+HF3Ke1zeRLpSruvP5hVb?=
 =?us-ascii?Q?9x5u8JcmeVaX+aHjOhvfcrJCHt529ThW2SosDUXxTWv3EYeVquA6A5aF5EO9?=
 =?us-ascii?Q?sel/s4I1CFm/UqeDPlRwqN13G1J6tSLZWLjakmKlCgtmSgJGPDWuTEIeiERZ?=
 =?us-ascii?Q?3znYgsciVF5+SITr5NpvtxCwWqCzr5293OMjmbuR7I7nJ/Kyk5gX9zkDcSu+?=
 =?us-ascii?Q?KpiSAVgTsw0bmdpH2Y2ZLNRjH9gEhLs/Pq8CcnxK0GisRmRIHsaXPaPU4WiH?=
 =?us-ascii?Q?qHZulroyvgpo22hJyVTopeovXQYbV58uI5liXQj+6CMYl+SNMtuYuhxEeVRh?=
 =?us-ascii?Q?v9F4QPruxyfmznnEMKnsmyhKLgfdvwt0ggXK1IhcXmmzlgVNre38Um0ab5a/?=
 =?us-ascii?Q?kRL237xyco/3JF/0C9o2cloJkRge1ZWP6Xa7Zxfu2MdyxeaRqZ+0cFynkBxG?=
 =?us-ascii?Q?YwgkqwRfITswRU6aOk8l1GZET2TsPMHxMWLtiJil4owTgwDAEf473kmh6QzV?=
 =?us-ascii?Q?NjxhzlJWJsLF8muGvqA13UkwQBPEy2jeK/7cOKFZo0QqkkFPJW5/rzZ+ngmy?=
 =?us-ascii?Q?CJtzqx71oxF8/QCNX7kJwUQem02lvBWnRKbn3/Rg5L6ejbEU0XoT8C0FTzmo?=
 =?us-ascii?Q?m23mcGLsQrgnMnlnWIBIsF7hU1fP+VkRDJeB+nUt+B6ctiFLCqtkLfthrQR/?=
 =?us-ascii?Q?9wFf9apxBuBVhGmAVrvBrYfIhf0qWQzqQnBNLq/1h9b5//+diHmA7ZtRYpD+?=
 =?us-ascii?Q?CSPysXVLDm+RQBIjtyQHrYf0pHh54GueFze/KRw/ZWhdkcOYBwq+W4V7OR6P?=
 =?us-ascii?Q?Bz/t7EoKPvPlxNdSrRac3cXMx0FVR+phbi4IyA2PWG/Vnt377fkVbjrLICSB?=
 =?us-ascii?Q?LjIXEkhSlkhH8hPzjtH217rR3V3eCPW1GsidZ/3LZWJxTfEs/RK+78huV7WO?=
 =?us-ascii?Q?neDk2o6UJPubfhm9dzjXTAa/FGcamsrKAPBvmKso4kWfK+ai7v2eVzoJ/n9w?=
 =?us-ascii?Q?qraHjdkuq22RRkbsfTWaPRy3mwQBKyaRNHTczrQkwyWbcfntRbDGOXyqOc4K?=
 =?us-ascii?Q?BWL8CLhcyZYUIdj/GFdymlvTwnSsFepWsqXU4UY7NlGQZB3l43EMz+EZ77Nu?=
 =?us-ascii?Q?kJof0Op3hv99V4b8vb3PKrNmwHPMdjlAkqZkALCQWyMcj+wWNVCyzcywz7qd?=
 =?us-ascii?Q?peIjmTTogVG5foDJA+176Kb2euEJFrOvVOvXqb3R3+zoOnmqK+++3+SYSMnV?=
 =?us-ascii?Q?GkbiRcA16g5g3rjFmmufJD+3q/ra/QKEKCEilGr26H+NW9BT6PbTKiqyClga?=
 =?us-ascii?Q?E/yEuQoLT3yDDRl79xnNQYGUt4pw11YAu3vuMHfAvzgLqh5YLCP5xNDDrYNo?=
 =?us-ascii?Q?CdTA6vIejq/8w6GTJx+X93FU+ealTZlrPGB8dnePmNKJ6dsat8vkNIY09g0u?=
 =?us-ascii?Q?JDRefQLhYBn9rqxKzgOzIgsF7acgKthnEAC070DEO2xXC8dZRRyf+7jptrQZ?=
 =?us-ascii?Q?lplXWky0vfxO9nxmzFMzjo68TJ7Llck/IvXGqcXseMUxEJBMb8Crk8/jEasl?=
x-ms-exchange-antispam-messagedata-1: Ojjmy/72FKW8uw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	n/K8gG/UautehJlvVL6e26M87w6mrYffa4oC60aUyjtUiHumSszW/TZwKsFT5AOFHnMSAeiP4Q1ki5IwJG9yj79/tLQIOtYpVWCZFxMFMzysLcUUwZnSP8KrsqK4w9/NcMtJnzklawNS8RcDUzxVcuxakuaKoXC8cR/NRnJRVXlvT0fZqUMUHGwLujN0XzydkKAxbEtYjnY8Iv0gv1pA0+pgA2b6oXB2Y4pfzBhPeUOHtWS3B30rn8YKc7gjX6vb8t5d2ffntvJP5GcgRcLBKvHsjLC8UrNGluxJJIPuEqSSD8UEw4wTXa8Fa8yxLUoC71EquIBSG6tzShKNqm5VPg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7677.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36006398-c71e-4b11-6e25-08decce8e2cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2026 03:22:54.2108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nBfNdUmVHSziCL3kPVXUe+zSS2COzCBlp5TjYOs1vyWuFNoUedCOr1qNpoemQgihS3Zi6SyOtBEeVndg4XMQfJC7CbOfb835a3ACcQmCr9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8052
X-Proofpoint-ORIG-GUID: fjlaErxqumCRguBH_2C1TrxXPIjmo_pH
X-Authority-Analysis: v=2.4 cv=B+2JFutM c=1 sm=1 tr=0 ts=6a336497 cx=c_pps
 a=+TgAdn5i6nn1e/5/V9fTSg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8 a=qnkBIS5oBtQzA4cjTToA:9
 a=CjuIK1q_8ugA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: fjlaErxqumCRguBH_2C1TrxXPIjmo_pH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDAyNyBTYWx0ZWRfX3BXcN5hyEgf3
 lEe6syN0uwExfdRb7c81fs+XlaK8RqCg1YqYPsi3tZ73Ya4gBE78MOi2hP9vd4dFkpgRTYL+jKP
 e3MrKPgBgrDU07MBpCmbfczZE/NcDPmb+e2Dh6AgHZxkHFnOUO5q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDAyNyBTYWx0ZWRfX47/dlWHg/KUh
 pRWHcQCJFQxgcc9CuzFVIxcyeyDoArnlD3mhGN1Mc+Ytb1M837oSoDe4purPB74V6BHHOj/on/0
 1hmyJp33OxqINg8DHEtdcKyPVPPOeE4X2vrFqyjO6JQBiadRsAxbyT0nuUeYElK1fEl2mb+JG3Z
 1IqdHh5yaXhFIodH5MCx4NvSD9NDGsUOz258kkYdYhTBSHEGugbZ3DO53uqQ6HoBFmegg+N2hvB
 qjJeUdlzrmo8QJpgzp+kJiS2m3S7BgdohkkuaG4O+c3HQ5kFPv+4GH6K4fumHa7mch2q+EDu6Xz
 legzbR9m0T0jpRJQZKc4F2VF7HAO6fytEYFhmh/re8aqdhe/kT+L9xMDC/N7OEBdKwHebn3FmyK
 haF7btL3fwp1Aw5+/B25KTONGXPlUzQtl2bqGm0UWj4mBbhsSUKVXZeRu9Wwecwo4LsArEgQx/n
 fVDUG1UrigHsI8l839g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180027
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 18 Jun 2026 03:23:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19731

From 7c5ec0b95f9dba932f74983f34d245646a371b7f Mon Sep 17 00:00:00 2001
From: David Reyna <David.Reyna@windriver.com>
Date: Wed, 17 Jun 2026 20:13:11 -0700
Subject: [PATCH] toaster: confirm bitbake version in 'gen_fixtures.py'

Also test that the version of bitbake in the release table in
'gen_fixtures.py' matches the registered version in the YP
releases URL.

Example output with induced error:
  $ ./check_fixtures.py
  Note: Active releases that are not yet in the Layer Index: ['blacksail']
  ERROR: Bitbake version mismatch for 'wrynose': 2.18 versus 2.16
  $

[YOCTO #16280]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/orm/fixtures/check_fixtures.py | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/orm/fixtures/check_fixtures.py b/lib/toaster/orm/f=
ixtures/check_fixtures.py
index 386c2da40..b33c093da 100755
--- a/lib/toaster/orm/fixtures/check_fixtures.py
+++ b/lib/toaster/orm/fixtures/check_fixtures.py
@@ -31,6 +31,7 @@ index_branches =3D [
 # Grab the recent release branches and add master, so we can ignore old br=
anches
 releases =3D fetch_json(RELEASE_URL)
 active_releases =3D []
+active_releases_bitbake =3D {}
 active_but_not_index =3D []
 for e in releases:
     if e["series"] !=3D "current":
@@ -40,6 +41,7 @@ for e in releases:
         active_but_not_index.append(release)
     else:
         active_releases.append(release)
+    active_releases_bitbake[release] =3D e["bitbake_version"]
 active_releases.append("master")
 active_releases.append("head")
 active_releases.sort()
@@ -48,14 +50,27 @@ if active_but_not_index:
     print(f"Note: Active releases that are not yet in the Layer Index: {ac=
tive_but_not_index}" )
=20
 # Get the list of releases instantiated in the Toaster fixtures
-fixtures_releases =3D [x[0].lower() for x in fixtures.current_releases]
+fixtures_releases =3D []
+fixtures_releases_bitbake =3D {}
+for fixture in fixtures.current_releases:
+    release =3D fixture[0].lower()
+    fixtures_releases.append(release)
+    fixtures_releases_bitbake[release] =3D fixture[6]
 fixtures_releases.sort()
=20
 # Report the resulting status
+ok =3D True
+for release in active_releases:
+    if release in ("master","head"):
+        continue
+    if active_releases_bitbake[release] !=3D fixtures_releases_bitbake[rel=
ease]:
+        print(f"ERROR: Bitbake version mismatch for '{release}': {active_r=
eleases_bitbake[release]} versus {fixtures_releases_bitbake[release]}")
+        ok =3D False
 if set(active_releases) !=3D set(fixtures_releases):
     print(f"WARNING: Active releases don't match toaster configured releas=
es, the difference is: {set(active_releases).difference(set(fixtures_releas=
es))}")
     print(f"Active releases: {sorted(active_releases)}")
     print(f"Toaster configured releases: {sorted(fixtures_releases)}")
-else:
+    ok =3D False
+if ok:
     print("Success, configuration matches")
=20
--=20
2.43.0


