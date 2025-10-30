Return-Path: <david.reyna@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C13CCF9E3
	for <webhook@archiver.kernel.org>; Thu, 30 Oct 2025 21:30:42 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.843.1761859841277390548
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Oct 2025 14:30:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=Zl3k4nYt;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=33986ba41e=david.reyna@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59UBhifP700623
	for <bitbake-devel@lists.openembedded.org>; Thu, 30 Oct 2025 14:30:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=pWxDjtW6aDaBVAm+wzieRaGosWR8g7c+WhDVxTbQo04=; b=Zl3k4nYt7gOa
	RN1TMhLjeRM0xYZ6Z/5+Ly+E5i+042M23so1OEjKx2p3xnE+hqdvb93OnNw1LRkR
	1pmmUlcGoZAMWBTCWVwAxOq0XnVFBOuMBeWFgE/xa0V5Qc4zqdzFku04yun9JOZT
	mRwRgY5ZW2C/ip3WoS2/IvSm+yhkxrBoawjuBjbBj8uMtSkuTTwTw8Gj7k0+SuN1
	fiCn9couf1aOC/HO+OxrmXmvrHSw2ueaOvTRKqaVonmJusgzovqTg6VBBViocCRZ
	kjliolh9wwCc3jErFEWWGvcS7wMcdpPgrk4vtFjzZbKJXEfu2AX0SxyILT92+JnK
	QIEE91gfbQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013041.outbound.protection.outlook.com [40.93.201.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4a3wa1s5db-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 30 Oct 2025 14:30:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYOUm6T1Ci4ggw+jzT0UDhV40CAN1fcu6JilBs7KR+o+2cGz9CdK1mcesJCzmo2TBTpZq/1rPGBlNNx/7nrJNWI7pOEa7rtz1r7KsM0JdWlFEZjXDflpp7vw5Qst6bHuU4R75rUTWNXQhap/OKf6whsuTp5EKD/hKcmkRDqUCkhYKjrRyWVXX7if0da/WKZUErEAmZbVQr85t+eQdDIrc2ecVshDQmhOW8UdE0LUhujRlVoQFovM8YPIqe5s97e+KR46l4j92FLQqN/aG1H/leR5Oe7wpDRy7OhGEw0eCS4znIiSa74LVKXJJu+DsYJre/FZBSb9WEch97jZ4Os4vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWxDjtW6aDaBVAm+wzieRaGosWR8g7c+WhDVxTbQo04=;
 b=iD69eGKpqBrLugbDfJVhtzwu2bNCCxZVk1xQiY08yrTAj2DtJEe7+ciVXxzXnQBeQUN1hzP9lQD9CbTH5OiWXXyxicoKC4k5G98ehCs/HUytKqpEwDpUaNXV21Yw9oL3Is8kZLbI+kqatwyc0wJ/SSFGADCGiloASMRMW9BIrl3jH6MI2vSwXfuINtbyXQyyjgwxA/mHHGfQfOZdRd7zinpQgMMvLhjn/zaNotMyppd/qOw0lrFo95oc45KaJQcpFyZbU0vYjXZ18A+hriHU2HHblObuqNbX4DiriC9HsEbYRus0RAPgiAkIloaRm+UlKC9IohtjgB3rfwK5fDhS+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA1PR11MB7677.namprd11.prod.outlook.com (2603:10b6:208:3fd::5)
 by CYYPR11MB8307.namprd11.prod.outlook.com (2603:10b6:930:ba::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 21:30:38 +0000
Received: from IA1PR11MB7677.namprd11.prod.outlook.com
 ([fe80::bad7:2979:d07b:ccd8]) by IA1PR11MB7677.namprd11.prod.outlook.com
 ([fe80::bad7:2979:d07b:ccd8%4]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 21:30:38 +0000
From: "Reyna, David" <david.reyna@windriver.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: [bitbake-devel][PATCH] toaster: support bitbake-setup
Thread-Topic: [bitbake-devel][PATCH] toaster: support bitbake-setup
Thread-Index: AdxJ42CvLSbXPIE/R8ii/sWz7k9qEg==
Date: Thu, 30 Oct 2025 21:30:38 +0000
Message-ID: 
 <IA1PR11MB76771970C94C4B34878FBB64EAFBA@IA1PR11MB7677.namprd11.prod.outlook.com>
References: <20251030141904.69494-1-JPEWhacker@gmail.com>
In-Reply-To: <20251030141904.69494-1-JPEWhacker@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ActionId=9667a3ba-c71c-4012-aeaf-597ab9cc4b43;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ContentBits=0;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Enabled=true;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Method=Standard;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Name=INTERNAL;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SetDate=2025-10-30T21:21:41Z;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SiteId=8ddb2873-a1ad-4a18-ae4e-4644631433be;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB7677:EE_|CYYPR11MB8307:EE_
x-ms-office365-filtering-correlation-id: 18390f66-1333-4d21-0773-08de17fb91f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?gN6NeqptwpFand23Iz3csrE1CdqHfpbmqtAU++rus0glJH8xaRsnqIObGgC4?=
 =?us-ascii?Q?hjFqbLwFZoFsnIBA7Mg11ozJQsL3Qkn0KmBOOGbutDvczFaXjJOvp3nbMGii?=
 =?us-ascii?Q?iC7Myh4qAMAHoYy4ziyWWnO8TH7A5TkoX4io7MK7BDARKSr3M1bptsR1X3D4?=
 =?us-ascii?Q?d907AOsm69xhYg/Z8gG3l4eT8qw9V73EJ9QH/3W29q+w4euVFvzBot7+o9j9?=
 =?us-ascii?Q?N72My4OrodWofCp6crwxKB/t4RcaSmq+3DSQeM6O3pvIhasjLFvWLdmEEHju?=
 =?us-ascii?Q?Ke4pakGgC698hra8ITAXaOxfG9Zg5an/es68QOUQhfgcIjyl0Th/fO6RuVBH?=
 =?us-ascii?Q?VuQXLpMOLuG+n0iRaQ3gQmNnoav7tzl0AWpNKwDeystyWRq522S5iHzKsw5E?=
 =?us-ascii?Q?qLnbyXIHBc/80wsssc8YIlmkObfYmTZrzv8NgoddK872TPqR9OPce4QkyOku?=
 =?us-ascii?Q?vYTRUSqBv/mbZa+dNVqtXj8eYdqMFj/2i5Y5EoklX0HUYctOKPkCy/yCSFxw?=
 =?us-ascii?Q?UT1lTbx2B/K+i6gxC3nx3ufxo2mtwdJ9X8pMDwm4H1RQ5FTruW7X/Gr5KDRF?=
 =?us-ascii?Q?OxVtW3Fxr7w9bn8TP0YIuQOMx6immRRPwayNN5bwVWUj35jcbup4f36zWlp9?=
 =?us-ascii?Q?lvk6kC/8oTV3gSQw+N4KX0N9FPnufC5POuvCIfFd4i6GN1U1t8B5LaDqfes/?=
 =?us-ascii?Q?RI5qU2lrstM/1yY2zUl1ZaxVaz67iiO3fOVFXjGrdZaUAI3+Yf8x6CrBGSes?=
 =?us-ascii?Q?grMwaNILdZ9IGSguA210jyK+dYeiQ8SbE03yC219+igydEa2G6bNP7aC01mj?=
 =?us-ascii?Q?r3URSgeg9qX4Nx1774WItpsBUvw15z67YisC+WE2iRejBCaUqTn3h0WbzREQ?=
 =?us-ascii?Q?1dte/UB0sRSyBVkybib0mDvdUvgzrJO7EAN1Oe3qvg6BgxMkbh+XwRxvihxA?=
 =?us-ascii?Q?3K/0xMvrSnOk1xgsmCbdpk6E4kbSvv0E5T3AD0W+q5JbMWrrEaa0tztXu+7K?=
 =?us-ascii?Q?Prb2/a5PMiQDZuCsQM2fJ7sbrb2EEQZxr71hGqNb1t8QFLHZTWEW9xZAYGqC?=
 =?us-ascii?Q?HKcEs5+qmq1P2fZgBblRIXRcJz9xu/FoDtdgMIXai8qNMqakbGb1X1aFC24T?=
 =?us-ascii?Q?3bomMaxH9JBbh85axF9s+av+hEvMOANz5m2aftlkugA6Ymf+i7Sx5khjWsbN?=
 =?us-ascii?Q?aKGelccgrb94fBtaGP8eNqDg6mk9luNobn3XnxMs7AKrdUfkuJo+FtV1/v3a?=
 =?us-ascii?Q?OCrzR01LReTQ2UpwhojhgxVf5ocS3JSDXpNayuibbbIARoqEDhmjyOeqJ8F6?=
 =?us-ascii?Q?LwRpOaQ3UJvkQSFsFAdxOfnVIGmjQp58Mpx0/Y0aMGcvc3IVwIZ35EljTBtm?=
 =?us-ascii?Q?rxPkVqo9YkTWekI/1jv5xq8It9TFCDiHDyF2L81JG3np6IfOdB0LkjLP9hZc?=
 =?us-ascii?Q?bueJqqriHB6Ds55McjHerAogCNyUN+I/852vKLQ2CxSoIowRLhikrzXmnxdU?=
 =?us-ascii?Q?FQ13nZKnDnGjRPTHpzjY7/42BFbVicRPf1Mq?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7677.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Xj14HrXv3HRv3JHo0inBT+ZIm4KmPyXGb/yqcYJsFCryW0UEpkxjnKuVIa1I?=
 =?us-ascii?Q?AyZ3zEsYf1kf7Phuio90taWeURtuboq/tHSwyZZ5cqtnR0XUFc/VDdWEgDib?=
 =?us-ascii?Q?mrTLLcCgoDmJWgOtzaXRFw46SIbhj5vqkac3zoXhqjnk8OU4wNt8iJqw8nhD?=
 =?us-ascii?Q?KWORVeRG9rT43VXRTWkF1tgQFScuU1DDBBHs9gEzIhfLfYNPLYJTF/EAlDtC?=
 =?us-ascii?Q?6cDytYulPtw/vk8W94KoVBSk4CXjHxdr1V1SSc+wyeXp17Y86Hdrg6Qv7KEZ?=
 =?us-ascii?Q?sPUcNff8CALpOo4Nw9GDnaKuRhQvL5xRcnttnHiA4AgthPaxegUdny2LmHJm?=
 =?us-ascii?Q?5xtY+D8bTCamW8rLqg7+33e1jTL7OlqLfF1GLcF27ftNBoKIJQ5wG7LRv6uu?=
 =?us-ascii?Q?kBZz6QDSi0a9sTFByYJQSuJ/sc089FkV3SgOkW/QfC8ZxzXpM2kuOo5BWtwt?=
 =?us-ascii?Q?KcS3gIGzey7LzmAPHzqX1UuLOntl60Wglr0StG4nyV2vTiU5dI515b3HSp28?=
 =?us-ascii?Q?my82ufWl/X3LnVIH5UyAA5OiD2nvNvYlwq35MGAEFU3SaF+eHhaRrU3hZELX?=
 =?us-ascii?Q?gSx21Jg9PukG3nws+lpLT91qCSSOgb4NDu84/SXkJWp2Xdtjo6f22fhK+FRv?=
 =?us-ascii?Q?yix3U9yLLQsgUGba/PdMnbwDy4XzLf5vs3akzCQCn7TZ7C9bFsGyWao+svfV?=
 =?us-ascii?Q?8Iy/dF7aP69AqxkBVo6et4PvEt4UQTvp2RwOCQhP4AxjwBdXQDFVLg6Swyub?=
 =?us-ascii?Q?Tvv1tsou8qw4IPF//qBeWu5RRDwHltHmshgR5i5lu0Q0FdxrInCGnsued0x4?=
 =?us-ascii?Q?/YOqaxJCmmPRT6EqYC/15uViUJ8h4UZR+bCPBqGQkcwNjupZgAJ3TV1oduYd?=
 =?us-ascii?Q?Po8dTu9eeRMH1k59aDskbM0m/l0Rg2NK1dmoS4pjmIxumoBXlek/6zwphtIX?=
 =?us-ascii?Q?azUaJTRBarN0RHe+59VjSRaUAg69ScqHyfyP89Kkp+HQRxX2fcy/8iWizOEg?=
 =?us-ascii?Q?uryNjMuPr36gM/kDf+ksFtNPAg8fOWrv6XNVtsCrR2bcmACcbieP9f29dhkN?=
 =?us-ascii?Q?LXkOQAgiiQLnZ5Gr9aZF8rxcQ6SE0rfaUBovLWQSaofzmCNpRjZaBTaioUl0?=
 =?us-ascii?Q?/MTTLh64ytelV0kxu0LVrTuKM976gMstShV81lYcxnrxQHoAqreI5mfQHoOg?=
 =?us-ascii?Q?+vgZD222q6mVcrBC64idXOMnDIm9vf1/8LryFRMlv2Po+SvCSZyDwElk5ULj?=
 =?us-ascii?Q?UtJiIY3nf6AKHpcOJZdAygmfavBC/ANgF9Jm+blMH9yjsRoBZ+8WcZQWyRHT?=
 =?us-ascii?Q?qWfJ4vFA/olXAwd/4GCkTcjCAjdKduuQjDA3sLleu0B9HGUi23a2IDwHrc5J?=
 =?us-ascii?Q?U7jhH8uSf4BOsItfsuv2o94Pufd8iUSKu2lQu9t1duilKN+Z7pLqP+WlZRFt?=
 =?us-ascii?Q?2Im67ZU8H6TmbkF2rVFTe7Gna3v5L6x/NpcjKr8kNWCQMk6SIIF/H6pxzMR0?=
 =?us-ascii?Q?J9Xl11xxoFfpZ/lhmKzKCpEz6K7h9FE9zoCVFNd4obkI0wEbQ3AxFPARO5LU?=
 =?us-ascii?Q?iiTnM3Qu4Yb4a+seplZU4T5aNjgGqpyU3B3N/HZiG1uP/NygUcnt5r/QyF1L?=
 =?us-ascii?Q?GwVvq4z4PgzAorEgpp1XWv9ZeETxpul356zKA/sQ9WCh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7677.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18390f66-1333-4d21-0773-08de17fb91f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2025 21:30:38.5954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d9cx01LCXRIqCzqKPCe+PWyKVPDO9m+bmDH9A9GibIIAOdPxeBx9Tgio35K3D6j+BT8bW7fKO0VVLAvDJiFXOGa7U2cBm6FoUmTevByv3CQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8307
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDE4MSBTYWx0ZWRfX7bjOrX2420ti
 ACgOcYg2uevv/JS9n/BoXWS2r2fKS+7PRfu0ujftjpxUsKLtmcLPGygaxEBAFciOdvqtftsNbQn
 +su8Q2EW697T08csxSuzDoTJGc4IwnJZUxgA1y+5YWuknY7Iz0yBdb/iBedO9JDDA/OmdyxeMJp
 dKdXXDRSa5mJvGnFzD0De1VWhdsYXSIB+MGJuRWnGnM9JeM41zSs0s6rZm0ulbpcSjHVgGrka6t
 haCd+uIrq4jHQ6De8//R2A8SK02v2MeBI1JWB34ry6Nn1kljLD5EFPrGmVGlqROE9eA87Y/N69f
 TfTLzRyVmp7CK8tyLXhN5oI1XtHByZgdpWXRMKrXqCNfANiF829CfB2MksdtOFA+xa+w0VWCzdr
 Rx1Bq6lCQ/xddwMgB+/nqIqJbNv36g==
X-Authority-Analysis: v=2.4 cv=HODO14tv c=1 sm=1 tr=0 ts=6903d900 cx=c_pps
 a=7YeuQJ2t1o+NR7xo1DCA9A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=t7CeM3EgAAAA:8
 a=U4B9xz3GZFFZrRCbFCQA:9 a=CjuIK1q_8ugA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: jZYEPUTShYq9g4L3fSsSRDcJNxxaGcPf
X-Proofpoint-ORIG-GUID: jZYEPUTShYq9g4L3fSsSRDcJNxxaGcPf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 clxscore=1011 spamscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300181
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 30 Oct 2025 21:30:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18231

From c063178ab0971fe297a9e9bca6e6b04eafc5149c Mon Sep 17 00:00:00 2001
From: David Reyna <David.Reyna@windriver.com>
Date: Thu, 30 Oct 2025 14:03:35 -0700
Subject: [PATCH] toaster: support bitbake-setup

    This adds support for the new bitbake-setup:
      * Maintain backwards compatibility for poky-classic releases
      * Assume bitbake-setup for all releases 'master' and forward
      * When no ".templateconf" assume Poky and not OE
      * Generate and use "init-build-env" script instead of 'oe-init-build-=
env'
        directly, but "cd" to the clone and not the local installation.
      * Include "bblayers.conf" because "cookerdata.py" now explicitly
        required it, and let it be over-ridden by the usual "toaster-bblaye=
rs.conf".
      * Force the value "TOPDIR" in "toaster.conf" to the local project's d=
irectory.

    Normally "cookerdata.py" sets TOPDIR from getcwd(), but somehow in bitb=
ake-setup
    mode the CWD at this point has become ".../layers/openembedded-core", s=
o
    "bitbake.conf and all other files cannot be found. This non-obvious pro=
blem was
    hard to discover. Until this is understood, the forced value will make =
things work.

    [YOCTO #16012]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 bin/toaster                                   | 21 ++--
 .../bldcontrol/localhostbecontroller.py       | 99 ++++++++++++++-----
 2 files changed, 89 insertions(+), 31 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index f002c8c1590..d20cbe90ba8 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -164,14 +164,20 @@ fi
 # in the local layers that currently make using an arbitrary
 # toasterconf.json difficult.
=20
-. $OE_ROOT/.templateconf
-if [ -n "$TEMPLATECONF" ]; then
-    if [ ! -d "$TEMPLATECONF" ]; then
-        # Allow TEMPLATECONF=3Dmeta-xyz/conf as a shortcut
-        if [ -d "$OE_ROOT/$TEMPLATECONF" ]; then
-            TEMPLATECONF=3D"$OE_ROOT/$TEMPLATECONF"
+# BBSETUP no longer supports .templateconf
+if [ -f $OE_ROOT/.templateconf ] ; then=20
+    . $OE_ROOT/.templateconf
+    if [ -n "$TEMPLATECONF" ]; then
+        if [ ! -d "$TEMPLATECONF" ]; then
+            # Allow TEMPLATECONF=3Dmeta-xyz/conf as a shortcut
+            if [ -d "$OE_ROOT/$TEMPLATECONF" ]; then
+                TEMPLATECONF=3D"$OE_ROOT/$TEMPLATECONF"
+            fi
         fi
     fi
+else
+    # Force poky
+    TEMPLATECONF=3D"layers/meta-yocto/meta-poky/conf/templates/default"
 fi
=20
 unset OE_ROOT
@@ -255,7 +261,8 @@ fi
 # 2) the build dir (in build)
 # 3) the sqlite db if that is being used.
 # 4) pid's we need to clean up on exit/shutdown
-export TOASTER_DIR=3D$TOASTERDIR
+# By default we move this all into the Toaster's parent build directory
+export TOASTER_DIR=3D$BUILDDIR
 export BB_ENV_PASSTHROUGH_ADDITIONS=3D"$BB_ENV_PASSTHROUGH_ADDITIONS TOAST=
ER_DIR"
=20
 # Determine the action. If specified by arguments, fine, if not, toggle it
diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/=
bldcontrol/localhostbecontroller.py
index 577e765f112..a7bc5722fad 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -6,6 +6,11 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
=20
+# DEBUGGING NOTE: if you need to add debug statements into the files withi=
n a
+# Toaster-imported layer, you must disable the "git fetch ..." command aft=
er
+# the initial clone else any changes will be automatically replaced with t=
he
+# original code
+
 import os
 import re
 import shutil
@@ -183,6 +188,8 @@ class LocalhostBEController(BuildEnvironmentController)=
:
             if commit !=3D "HEAD":
                 logger.debug("localhostbecontroller: checking out commit %=
s to %s " % (commit, localdirname))
                 ref =3D commit if re.match('^[a-fA-F0-9]+$', commit) else =
'origin/%s' % commit
+                # DEBUGGING NOTE: this is the 'git fetch" to disable after=
 the initial clone to
+                # prevent inserted debugging commands from being lost
                 self._shellcmd('git fetch && git reset --hard "%s"' % ref,=
 localdirname,env=3Dgit_env)
=20
             # take the localdirname as poky dir if we can find the oe-init=
-build-env
@@ -319,7 +326,28 @@ class LocalhostBEController(BuildEnvironmentController=
):
         layers =3D self.setLayers(bitbake, layers, targets)
         is_merged_attr =3D bitbake.req.project.merged_attr
=20
+        # Is this build for a Bitbake Setup installation?
+        isBBSetup =3D False
+        release_description =3D bitbake.req.project.release.description
+        if 'master' in release_description:
+            # This release going forward is Bitbake Setup
+            isBBSetup =3D True
+        else:
+            try:
+                # Yocto Project 5.3 "Whinlatter"
+                params =3D release_description.split(' ')
+                # Work past YP "10.1"
+                release_params =3D params[2].split('.')
+                if int(release_params[0]) > 5:
+                    isBBSetup =3D True
+                if (release_params[0] =3D=3D '5') and (int(release_params[=
1]) >=3D 3):
+                    isBBSetup =3D True
+            except:
+                # If release schema not recognized, then this release is i=
n the future
+                isBBSetup =3D True
+
         git_env =3D os.environ.copy()
+        toaster_run_dir =3D git_env['BUILDDIR']
         # (note: add custom environment settings here)
         try:
             # insure that the project init/build uses the selected bitbake=
, and not Toaster's
@@ -335,28 +363,44 @@ class LocalhostBEController(BuildEnvironmentControlle=
r):
         else:
             builddir =3D '%s-toaster-%d' % (self.be.builddir, bitbake.req.=
project.id)
         oe_init =3D os.path.join(self.pokydirname, 'oe-init-build-env')
-        # init build environment
+        setup_init =3D os.path.join(builddir, 'init-build-env')
+        # init build environment and build directory structure
         try:
             custom_script =3D ToasterSetting.objects.get(name=3D"CUSTOM_BU=
ILD_INIT_SCRIPT").value
             custom_script =3D custom_script.replace("%BUILDDIR%" ,builddir=
)
             self._shellcmd("bash -c 'source %s'" % (custom_script),env=3Dg=
it_env)
         except ToasterSetting.DoesNotExist:
-            self._shellcmd("bash -c 'source %s %s'" % (oe_init, builddir),
-                       self.be.sourcedir,env=3Dgit_env)
+            # Normal setup
+            if isBBSetup:
+                # Create an 'init-build-env' for the build directory that =
points to respective cloned bitbake
+                os.makedirs(builddir, exist_ok =3D True)
+                build_init_script =3D os.path.join(builddir,'init-build-en=
v')
+                os.system(f"cp {os.path.join(toaster_run_dir,'init-build-e=
nv')} {build_init_script}")
+                os.system(f"sed -i -e 's|^cd .*$|cd {self.pokydirname}|g' =
{build_init_script}")
+                os.system(f"sed -i -e 's|^set .*$|set {builddir}|g' {build=
_init_script}")
+                # Execute the init
+                self._shellcmd(f"bash -c 'source {build_init_script}'", en=
v=3Dgit_env)
+            else:
+                self._shellcmd("bash -c 'source %s %s'" % (oe_init, buildd=
ir),
+                           self.be.sourcedir,env=3Dgit_env)
=20
         # update bblayers.conf
         if not is_merged_attr:
             bblconfpath =3D os.path.join(builddir, "conf/toaster-bblayers.=
conf")
             with open(bblconfpath, 'w') as bblayers:
                 bblayers.write('# line added by toaster build control\n'
-                               'BBLAYERS =3D "%s"' % ' '.join(layers))
+                               'BBLAYERS =3D "%s"\n' % ' '.join(layers))
=20
             # write configuration file
             confpath =3D os.path.join(builddir, 'conf/toaster.conf')
             with open(confpath, 'w') as conf:
+                if isBBSetup:
+                    # Force TOPDIR
+                    conf.write(f'# Force TOPDIR\n')
+                    conf.write(f'TOPDIR =3D "{builddir}"\n\n')
                 for var in variables:
-                    conf.write('%s=3D"%s"\n' % (var.name, var.value))
-                conf.write('INHERIT+=3D"toaster buildhistory"')
+                    conf.write('%s =3D "%s"\n' % (var.name, var.value))
+                conf.write('INHERIT +=3D "toaster buildhistory"\n')
         else:
             # Append the Toaster-specific values directly to the bblayers.=
conf
             bblconfpath =3D os.path.join(builddir, "conf/bblayers.conf")
@@ -443,15 +487,25 @@ class LocalhostBEController(BuildEnvironmentControlle=
r):
             else:
                 logger.error("Looks like Bitbake is not available, please =
fix your environment")
=20
+        # NOTE: BB SETUP requires a 'bblayers.conf' even though Toaster im=
mediately overrides it with 'toaster-bblayers.conf'
+        bblayers =3D os.path.join(builddir,"conf/bblayers.conf")
         toasterlayers =3D os.path.join(builddir,"conf/toaster-bblayers.con=
f")
-        if not is_merged_attr:
-            self._shellcmd('%s bash -c \"source %s %s; BITBAKE_UI=3D"knott=
y" %s --read %s --read %s '
-                           '--server-only -B 0.0.0.0:0\"' % (env_clean, oe=
_init,
-                           builddir, bitbake, confpath, toasterlayers), se=
lf.be.sourcedir)
+        if isBBSetup:
+            # Use 'init-build-env' model
+            if not is_merged_attr:
+                self._shellcmd(f'{env_clean} bash -c \"source {setup_init}=
; BITBAKE_UI=3D"knotty" {bitbake} --read {confpath} --read {bblayers} --rea=
d {toasterlayers} '
+                               '--server-only -B 0.0.0.0:0\"', self.be.sou=
rcedir)
+            else:
+                self._shellcmd(f'{env_clean} bash -c \"source {setup_init}=
; BITBAKE_UI=3D"knotty" {bitbake} '
+                           '--server-only -B 0.0.0.0:0\"', self.be.sourced=
ir)
         else:
-            self._shellcmd('%s bash -c \"source %s %s; BITBAKE_UI=3D"knott=
y" %s '
-                           '--server-only -B 0.0.0.0:0\"' % (env_clean, oe=
_init,
-                           builddir, bitbake), self.be.sourcedir)
+            # Use 'oe-init-build-env' model
+            if not is_merged_attr:
+                self._shellcmd(f'{env_clean} bash -c \"source {oe_init} {b=
uilddir}; BITBAKE_UI=3D"knotty" {bitbake} --read {confpath} --read {bblayer=
s} --read {toasterlayers} '
+                               '--server-only -B 0.0.0.0:0\"', self.be.sou=
rcedir)
+            else:
+                self._shellcmd(f'{env_clean} bash -c \"source {oe_init} {b=
uilddir}; BITBAKE_UI=3D"knotty" {bitbake} '
+                           '--server-only -B 0.0.0.0:0\"', self.be.sourced=
ir)
=20
         # read port number from bitbake.lock
         self.be.bbport =3D -1
@@ -497,20 +551,17 @@ class LocalhostBEController(BuildEnvironmentControlle=
r):
         log =3D os.path.join(builddir, 'toaster_ui.log')
         local_bitbake =3D os.path.join(os.path.dirname(os.getenv('BBBASEDI=
R')),
                                      'bitbake')
+
         if not is_merged_attr:
-            self._shellcmd(['%s bash -c \"(TOASTER_BRBE=3D"%s" BBSERVER=3D=
"0.0.0.0:%s" '
-                        '%s %s -u toasterui  --read %s --read %s --token=
=3D"" >>%s 2>&1;'
-                        'BITBAKE_UI=3D"knotty" BBSERVER=3D0.0.0.0:%s %s -m=
)&\"' \
-                        % (env_clean, brbe, self.be.bbport, local_bitbake,=
 bbtargets, confpath, toasterlayers, log,
-                        self.be.bbport, bitbake,)],
+            self._shellcmd([f'{env_clean} bash -c \"(TOASTER_BRBE=3D"{brbe=
}" BBSERVER=3D"0.0.0.0:{self.be.bbport}" '
+                        f'{bitbake} {bbtargets} -u toasterui  --read {conf=
path} --read {bblayers} --read {toasterlayers} --token=3D"" >>{log} 2>&1;'
+                        f'BITBAKE_UI=3D"knotty" BBSERVER=3D0.0.0.0:{self.b=
e.bbport} {bitbake} -m)&\"'],
                         builddir, nowait=3DTrue)
         else:
-            self._shellcmd(['%s bash -c \"(TOASTER_BRBE=3D"%s" BBSERVER=3D=
"0.0.0.0:%s" '
-                        '%s %s -u toasterui  --token=3D"" >>%s 2>&1;'
-                        'BITBAKE_UI=3D"knotty" BBSERVER=3D0.0.0.0:%s %s -m=
)&\"' \
-                        % (env_clean, brbe, self.be.bbport, local_bitbake,=
 bbtargets, log,
-                        self.be.bbport, bitbake,)],
+            self._shellcmd([f'{env_clean} bash -c \"(TOASTER_BRBE=3D"{brbe=
}" BBSERVER=3D"0.0.0.0:{self.be.bbport}" '
+                        f'{local_bitbake} {bbtargets} -u toasterui  --toke=
n=3D"" >>{log} 2>&1;'
+                        f'BITBAKE_UI=3D"knotty" BBSERVER=3D0.0.0.0:{self.b=
e.bbport} {bitbake} -m)&\"'],
                         builddir, nowait=3DTrue)
=20
         logger.debug('localhostbecontroller: Build launched, exiting. '
-                     'Follow build logs at %s' % log)
+                     f'Follow build logs at {log}')
--=20
2.43.0


