Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4621FF8875
	for <webhook@archiver.kernel.org>; Thu, 30 Apr 2026 03:57:43 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12780.1777521456952265310
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Apr 2026 20:57:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=Qo0n5VYA;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=9580f49ff8=qi.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63U3vaDK2289407;
	Wed, 29 Apr 2026 20:57:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=GXxCnC78/YqMkbm30zu4xYmLLDLvUfr56Lt/zvBtyaU=; b=
	Qo0n5VYAmstiqvfTRd+igJf5VScNbr38Q5/YY8oD9Un1Rb9FRA5gtrTG707NC7YI
	dtDiyhHmK7wyfvCRmrmspn999DKdUaPIutjcPxso4H+tPblLuc+5h5XP7lvMPOpu
	Ixzpk22ZwNuXLFlS87hvbYfXDgadmhdXmOUrqai5io7YWgV787968UoUf87zknsR
	3252P4oAg+TKpuU68dphupTfF3RmjLfoJEiYN1NZYACd0s/FDorsRPAiOl/RXaIk
	ceKxeJ7Rfi2p8H1jHkfidXYKVuHW6y0SFmXpJl/qY3ROePYOzn7VQa9PGGTk5uQF
	iZd8hfWhvT3Yu8pa9782mA==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011040.outbound.protection.outlook.com [52.101.52.40])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dumcvgvqn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 20:57:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PXJTjJYbtEIzWWiH75CmuDkIx6i4Rv7YZbKhY8+5CFsflId3HekAFe7Snho9XmOEcUG4m+3dVLGixVzoJ9R2lnszHnk3aI9cHQSepjTrTKENwvrwcd+8M2q1ChIhc6wBoP0UmHvd79khJ/uZpigbK2JWBP83AzImLr1mX7vL3ZhUsNBgy9ldYBPZ4VSjHDgSh457g0u26pvJIy8K98ipJv1DtRkcDDaATTk9NrchTYzPzZuvjj51m32xpiHmRVyQUgGd+50Wtd3Kx5j6N4QlPblOa/TyYooGQBiFzEeloWvgfblg2rgh1+oUjM4huJPfDXeZNIOEaV5ZLhBF7/YLXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXxCnC78/YqMkbm30zu4xYmLLDLvUfr56Lt/zvBtyaU=;
 b=IqmFh7hewhuYb45B+EWC5vZf/TIip5sWUbmiQUv3RHPv0PsfHXzxsT8oXCQh71vdbAR59TBaCc4a5RY/5FbnnVvD8FCTb/UK96wEA7I3eBU7qj3XLjuAzjxY0XpV79S973XpQ/fz5wa5YWhC9s7HxgJ10g23CSCgjVJe2sFxOFw3stbufkulYbkwhd1w0YAwWfaWMfLwHDHk0RKWAtC9wShObRht9EfjA1jf6qR4tMe50qaQYPS/goAbB+gbCbqdF5puUDh6IcRdifkVLmk173hMQVCCveJW7YTPPAMJN3awLQ+uiBGgFXFuKZsnxGGUu8V+44uKCl8BEXTXFCkmEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5611.namprd11.prod.outlook.com (2603:10b6:510:ed::9)
 by DS4PPFA08475C7D.namprd11.prod.outlook.com (2603:10b6:f:fc02::3f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Thu, 30 Apr
 2026 03:57:32 +0000
Received: from PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::ecf9:dbb:16bf:5b2d]) by PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::ecf9:dbb:16bf:5b2d%4]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 03:57:32 +0000
From: "Chen, Qi" <Qi.Chen@windriver.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
        "richard.purdie@linuxfoundation.org"
	<richard.purdie@linuxfoundation.org>,
        "MacLeod, Randy"
	<Randy.MacLeod@windriver.com>
Subject: RE: [bitbake-devel][RFC][PATCH 1/3] lib/bb/fetch2/git.py: add
 optional major_version parameter to latest_versionstring
Thread-Topic: [bitbake-devel][RFC][PATCH 1/3] lib/bb/fetch2/git.py: add
 optional major_version parameter to latest_versionstring
Thread-Index: AQHc14e/rwbdwesaHEiL0WTJyZqD5bX146oAgAEXFqA=
Date: Thu, 30 Apr 2026 03:57:32 +0000
Message-ID: 
 <PH0PR11MB5611A36AAD495E9098AE6512ED352@PH0PR11MB5611.namprd11.prod.outlook.com>
References: <20260429032436.1075831-1-Qi.Chen@windriver.com>
 <CANNYZj-anuHaAL6bJbkpO_bUuqQd-ZLmdRAA8bLf3iSnMYRzdQ@mail.gmail.com>
In-Reply-To: 
 <CANNYZj-anuHaAL6bJbkpO_bUuqQd-ZLmdRAA8bLf3iSnMYRzdQ@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ActionId=672b6f3e-6970-4807-ad0c-eed46c6e6565;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ContentBits=0;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Enabled=true;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Method=Standard;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Name=INTERNAL;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SetDate=2026-04-30T03:53:29Z;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SiteId=8ddb2873-a1ad-4a18-ae4e-4644631433be;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5611:EE_|DS4PPFA08475C7D:EE_
x-ms-office365-filtering-correlation-id: af195879-3c3c-41cb-9772-08dea66c9b31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|38070700021|56012099003;
x-microsoft-antispam-message-info: 
 g0IWz3tEy2YZrhAhV52hkt/LXTPPnfvdaeeFdDIICMFTy1M7u6mb9aC+xSqWvPgd+eMDb+tcFeM2OGI/z8QvX9fRSmli7Q7QxHm1AXF9kE6IOOE5cOK3W+JdlJK9ykNKWnIOA3EmIJapeua581LL3Or/zDQ/GyUQyH/GCTnG1aSBP55sDPHHqC5HdvYfOGxmeGIcQ+4nIcHo2p28S4lnwx46hAvRbA8xdo+/4m+bAE3SMJiFIgKK9qLPbu5EFK2ZTp5kZ++yBRcZOxhLDViOlXiLZHw6uPZoxloMNwe8z2EAVJ0JVUlZdfIzixAyUI6DYu8YET/ALw0HjNSr9LZxhcJYmwg3LoUh7qm9IaD4kbT5e7yBELJZz9O32LFCzFEmtzuY2NC87WV5mjHeeZfr+NYDP3wCAiUuDPeJDVGg0l2pP4VXZw59/qYNIMnjRr64bYkxK0s86q4AqCcn3tVEXjfog69ivSCFxuJUlLldKoINfBTaOcNXQe9di733uEnATko3XAr20HyrWBX75DjRqSj52Po2I6CL+cDOHVYGS1WI3u5uYiXhSoG05XBq6lde0u/MLBT+eTmaLvoidcjzn6u9SzslYli0Fa2gPs6SmGBpZDfZ1e5yurmjxGXk3a3RFnvJ0TnzXx0+V8CxzETBE8Lo+ueKcmFCzT29SCa5w4FtH4D0DZjUwEWjZNlWUr4z355e05lAOyw2IJiktt5Sfl6UhqQLmWSRpJdwgPoADM/hBu+81cXCAcf2TcI3l/HFDi99dWqraW8FFCWQu8ushowayNKaixgofFOptQ/mgN4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5611.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(38070700021)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SmxKYnhvM0ViNkpGMDRuVjJiMVVob2VoTHgwbEIyZ25uVGdBUFVYRFNFK0tZ?=
 =?utf-8?B?em9WRWU2UTI1aHl0Zm5SWjNVVThQUWNwSkQ1OFg2cTVLUno3N3dWN3Q5NytS?=
 =?utf-8?B?eDhLdlhuS09RcEVCRk16UzUxaEdYYnVQdHdDQW1iem1JRlpPcVU3eVRwOGwx?=
 =?utf-8?B?OE5uejFheG1mSzNIckRDZmo4eUxBRjVxWjdlNUZmV1NpTjBqZTUrRXRIU2lj?=
 =?utf-8?B?bjdHYXo2Yk5YWEVoa3RldGlIZHlRd0RkZXVWRkp4ZzBFQVY0czEwZ1I4aEtQ?=
 =?utf-8?B?Ny85WmR4cEF0YmVUaEV6a3Zjenphd05ZS3cvVjN4aDlTcDRzN0c5RzgwYngw?=
 =?utf-8?B?dHhwWVlPUFdpSE1VbndsTGJnTTAveU5QVElqRUlBODhPcVZJdk9sUWE0OHph?=
 =?utf-8?B?Ylp2ank0VkJtM3AxNVZrU1ZzbnZRSGZTSWpDMDY2MXZFVm5RcTdYQ1FrNWJP?=
 =?utf-8?B?VlNlU2tNUUIrRStDcGVrbkYxd2ZoanpVQVk1VnhqZVdvQmtXM3p5NkZXaHNl?=
 =?utf-8?B?ZW0vMzRlb0VNWVgwSXM1dTlPdmN6YzI2SW1iOE5nd3RobTVqNStRcSt2SXlH?=
 =?utf-8?B?TWl4VzQwRWRodjRLUWJlTml1RE52Uk9CeTlzRUpJRnhvaUl0WkRJTzVEbkpp?=
 =?utf-8?B?bk5UWnpROXRId0E2MW5FVERaUzhhMjk5b0FDL1pYdWI0eTgwN3ZtK2llaVFn?=
 =?utf-8?B?YWFoUkUwVGgzOTdwZVNmYXF6VXJ5cTZXMHIwMEZPSlM5bGNuK0hGaHJxaFFm?=
 =?utf-8?B?SkxtVmxPUXdyclRUbWI4NzNXOTBKVUZGYUlCMkI1cFN1V0VKUTVDODdwb1dZ?=
 =?utf-8?B?MVdKUEluZFM1SERYMVc1WEk5VnpBR0tuMDFaeHpSNmtOcUF2elgraXg1Lyt1?=
 =?utf-8?B?dnI3MTJBd3ZsUzdvbnJyYnZpdi9odjBVbFRSNXl3QkRYTnBJT1dYRkh4Nm9U?=
 =?utf-8?B?ZDFwTmYwNkc1a2ROaFpnZnhNVFBRcWU4Qml0WWZEWkVHV2M2QUg0Z2pueVpl?=
 =?utf-8?B?MXJLU0E5WUxwMnFBdENkcDF6OUQ0a3R4QkZaZmFIMGVPcVBBbHNIYmk3ZzhE?=
 =?utf-8?B?dG4yNXdlcExzM0dESE9QOU9wcEV6SUJwTmlUWDBnWVJwemJxRTdUcVNLRkxr?=
 =?utf-8?B?WCtXeStxM0JiZXZrT3dVeFVIWmpuOXBxNkV0ZVFiU0FtUUtsSHplR0hmMHpi?=
 =?utf-8?B?MWdjOFJ2KzNKRk80elFhVWFjZkZob3duaEFFeGJ6Ukt4cjRKZnJXWm1OMyt5?=
 =?utf-8?B?aTZFM1h0K2JHbno3VTJYdjM4Ty9hY2ZvL1JTeU1lVTBTN0t2YzZwNEdUc1VM?=
 =?utf-8?B?Mk0xemZmRW5XZGpqS1pCSC9Ndk1QdnZDbUxjT0pkL0cwV2x6eFJ4LzhrZVRE?=
 =?utf-8?B?WDhaM1JuNE1ER3c5ckwvOGxSZzZvQjNpQ0pKWWJRdVdpTHMwRU1sdHllT1lr?=
 =?utf-8?B?cGQ2OGdZYjR3WWlqWjN6Y3NEVGEyUHZrL1plTUVhTjI5WWdnQWs4TjMwaUpL?=
 =?utf-8?B?bjM2aElKMEk2bUtQcVJjTFlJUDVETitRNHp6dUNEK09oRFNyVHBsR2tURS9Z?=
 =?utf-8?B?bmw5WndkWDhPaFlveDlTamM0cmx4TkpkWWhmbE80VDdkS0JmamlkZW9TWldh?=
 =?utf-8?B?QlZQK1JJZktIb21qYVkvZTBpb2JOTGxOdE5za3hHOXRuNEc3QTh5RUtzTkdo?=
 =?utf-8?B?WXJuQk9xMGJxcnB6ZEJXZ2Vja2phN0tWSFJWQjUrckQ3SW5wRzEwcG5NVlVq?=
 =?utf-8?B?ZkFEUzcvRGlSTWFhSXl0ZVdBcGswNXdUR010ZkdVZlhoWUpkaXBmNTBmUnFk?=
 =?utf-8?B?MlBWOEZvaVhLN2R3dDh5V1Q4UkI4eUR6QVVnTFJabTZtQXprVmdlN1BVSDUy?=
 =?utf-8?B?TUppZWRlakxUd1ZFN0lGSXQ2TXp0N1ZHSHdmQW1JdTl6THVuem53MmViTC9M?=
 =?utf-8?B?R0FjdHIzb2VsU3d4UzlMbjlWL0hqUXpUNUk1amRiaGFNZHVUeUN5RkUxcjRR?=
 =?utf-8?B?eC94UmFhb3F5cURTc2wzV29NYUlwUHZYemwyZHZEY2t1Z2p6QW9MRXZ1bm1X?=
 =?utf-8?B?RmxER1pZcFM5N0lTTHlqS203NWVid0VBUXliaEprMTNEc05keEorOUZnS1BW?=
 =?utf-8?B?QllhVWFmUWFSOHVTVkhWZG9jMGgvOW1HUXJVV2psWW10N042czUzdVBGTUMz?=
 =?utf-8?B?SVdaTy9QdFJrR0srbXJzbmlWSm85Vnk4UDNNSWFwaEc2TFd0NHdvbllmSGF5?=
 =?utf-8?B?TWljUjA0VEhVNmE5Rmc3bUJyS3Q3R2dDZEdzQTkzRy95SlFqdFVlbjR3cWxH?=
 =?utf-8?B?S0JXc0FKUVh6MEhtUFZnY05rbTViaXhXc0ltNW5EREZhWHlxcmppQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	dcUqtxk3RmhQOikri+jfeBRPSeRHt8o6GGTdgY3mpu4Wx0u0hsmhGBQzVWabTV7aSm85/QL/tO8/7DKF5aLjDRXuSTfdoENjcIxCja2iPg+Gm98fB1GdDnrpZkCLtplFXZ5zJcP9kRHUlfQ6vp6On1FCQmxEAw7NJZnP8gl8HhasZBmUsoyZFJFkm6Owuwyhnv2ML6urDkHDLWSo9358kllekxZbvvAxjrOBEsSm+ktgvR8zosW7Df55B7Euz5sewf1aHa6Ayu6iLOcV5kZz7UiK5NwKvtz/J4QpYMJo1vCLmK+oh1w5XkfZU1zZSx+HzlzJzU0wjnJ89++k4Zj7mw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5611.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af195879-3c3c-41cb-9772-08dea66c9b31
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2026 03:57:32.3280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vhXahE6dVYxfOtS20PA+HvnIXpNaykTbb/U+iJpLIeDwWW9QPZcGr50esmjGxooavrhpdAcU/qHIorFZs/aY2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFA08475C7D
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDAzNiBTYWx0ZWRfXwtUiUZySXhIt
 bil15LvMKe3WqgrTHmF2TS2ufOXJcGNtW45eCU3xXyWau0UMY6TrHJMBWLCpmpp5hKr5pfeuf2T
 /NygEbv9zE/nasfKsK5WUHdcEN9BcZTwkGSVo6k/SMKY6sWzQfOYbkkcAc9rB3ExdvvtDv1GhER
 bCNrgyJa1hY6y5DmBgQG8p5KIGSuAASBHtDkY67qCgc5An/8RtfqzrxE9628XZom0GJVhtKQ/0c
 IAGkhMtSG0Dc8GxFtK9bHl56Fntmtdlk1Fn/Rnq4zhqtO4mzi4XFXywA6jQngLzqrFHHpypuME+
 IpEPMRxx4Z9gbl5vTNFEOfcabmUINE//rgmL/Pj3wAroYa7cZZYCdhLInYkYdoFrj5tjo9/Xuen
 MPzgXtHmL1RjGBgZ87mAiRLPtJi2cPT/KWcKil/bVM5yg4mVAu8j8/iRBzbHu9BSS6j+S0X/CTw
 LDrXPz0EoClpq/Re5ew==
X-Authority-Analysis: v=2.4 cv=eYsNubEH c=1 sm=1 tr=0 ts=69f2d330 cx=c_pps
 a=u7dnV0yUwpVRNDUrCOcuvQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=HK-ge7EqtdluswH-FwHe:22 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8 a=Q4-j1AaZAAAA:8
 a=ag1SF4gXAAAA:8 a=af_HJyTeDLf6mZlMHX0A:9 a=QEXdDO2ut3YA:10
 a=FdTzh2GWekK77mhwV6Dw:22 a=9H3Qd4_ONW2Ztcrla5EB:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-ORIG-GUID: nPaET2e0wQdIyVW3HrBbzF-SR0NFI8oe
X-Proofpoint-GUID: -xPKnuPF6wsMNQAz9R2qwUCeCGgr4uGz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300036
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 30 Apr 2026 03:57:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19418

SGkgQWxleCwNCg0KVGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24uIEkgYWdyZWUgd2l0aCB0aGlz
IHNvbHV0aW9uLiBJdCB3aWxsIGdpdmUgdXMgYmV0dGVyIG1ldGEgZGF0YSBtYWludGVuYW5jZSBp
biB0aGUgbG9uZyBydW4uDQpJJ2xsIGdldCB0byBpdCBhZnRlciA1LzEgaG9saWRheS4NCg0KUmVn
YXJkcywNClFpDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBBbGV4YW5kZXIg
S2FuYXZpbiA8YWxleC5rYW5hdmluQGdtYWlsLmNvbT4gDQpTZW50OiBXZWRuZXNkYXksIEFwcmls
IDI5LCAyMDI2IDc6MTUgUE0NClRvOiBDaGVuLCBRaSA8UWkuQ2hlbkB3aW5kcml2ZXIuY29tPg0K
Q2M6IGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZzsgcmljaGFyZC5wdXJkaWVA
bGludXhmb3VuZGF0aW9uLm9yZzsgTWFjTGVvZCwgUmFuZHkgPFJhbmR5Lk1hY0xlb2RAd2luZHJp
dmVyLmNvbT4NClN1YmplY3Q6IFJlOiBbYml0YmFrZS1kZXZlbF1bUkZDXVtQQVRDSCAxLzNdIGxp
Yi9iYi9mZXRjaDIvZ2l0LnB5OiBhZGQgb3B0aW9uYWwgbWFqb3JfdmVyc2lvbiBwYXJhbWV0ZXIg
dG8gbGF0ZXN0X3ZlcnNpb25zdHJpbmcNCg0KT24gV2VkLCAyOSBBcHIgMjAyNiBhdCAwNToyNCwg
PFFpLkNoZW5Ad2luZHJpdmVyLmNvbT4gd3JvdGU6DQo+ICsgICAgZGVmIGxhdGVzdF92ZXJzaW9u
c3RyaW5nKHNlbGYsIHVkLCBkLCBtYWpvcl92ZXJzaW9uPU5vbmUpOg0KDQouLi4NCg0KPiArICAg
ICAgICAgICAgaWYgbWFqb3JfdmVyc2lvbjoNCj4gKyAgICAgICAgICAgICAgICBpZiBub3QgcHZl
ci5zdGFydHN3aXRoKG1ham9yX3ZlcnNpb24rJy4nKToNCj4gKyAgICAgICAgICAgICAgICAgICAg
Y29udGludWUNCg0KVGhpcyBoYW5kbGVzIG9uZSB3YXkgb2YgdmVyc2lvbmluZyBidWdmaXggcmVs
ZWFzZXMgKHgueS56IC0+IHgueS56KzEpLCBidXQgdXBzdHJlYW1zIG1pZ2h0IGludmVudCBhbGwg
a2luZHMgb2YgZGlmZmVyZW50IHdheXMuIEUuZy4gc3lzdGVtZCBpcyB1c2luZyB4IC0+IHguMSAt
PiB4LjIgLT4gLi4uLCBvciBvcGVuc3NoIGlzIHVzaW5nIHgueS0+eC55cDEuDQoNCkxldCdzIG1h
a2UgaXQgbW9yZSBnZW5lcmFsLiBJJ2Qgc3VnZ2VzdCBwYXNzaW5nIGluIGFuIG9wdGlvbmFsIGZp
bHRlcl9yZWdleCBhcmd1bWVudCB0aGF0IHdvdWxkIGJlIG1hdGNoZWQgd2l0aCBhICdjYW5kaWRh
dGUnDQp2ZXJzaW9uLiBUaGVuIHRoZSBtb3N0IGNvbW1vbiB1c2UgY2FzZSAocG9pbnQgcmVsZWFz
ZXMpIGNvdWxkIGJlIHN1cHBvcnRlZCBsaWtlIHRoaXM6DQoNCnVwc3RyZWFtLXN0YWJsZS1yZWxl
YXNlcy1wb2ludC5iYmNsYXNzOg0KVVBTVFJFQU1fTUFKTUlOX1ZFUlNJT05fUkVHRVggPSAuLi4g
KHNldCBmcm9tICR7UFZ9LCBlLmcuIDMuNC41IGJlY29tZXMgM1wuNCkgVVBTVFJFQU1fU1RBQkxF
X1JFTEVBU0VTX1JFR0VYID0gIiR7TUFKTUlOX1ZFUlNJT059XC5cZCsiICh0aGlzIGluIHR1cm4g
YmVjb21lcyAzXC40XC5cZCspDQoNCnN5c3RlbWQgYW5kIG9wZW5zc2ggb24gdGhlIG90aGVyIGhh
bmQgY291bGQgc2V0IFVQU1RSRUFNX1NUQUJMRV9SRUxFQVNFU19SRUdFWCBkaXJlY3RseSBhY2Nv
cmRpbmcgdG8gdGhlaXIgY3VzdG9tIHZlcnNpb25pbmcgc2NoZW1hcy4NCg0KVGhlbiByZWNpcGVz
IHdoaWNoIGFyZSBrbm93biB0byBkbyByZWxlYXNlIG1haW50ZW5hbmNlIChpbiBhIHdheSB0aGF0
J3MgY29tcGF0aWJsZSB3aXRoIFlvY3RvIHN0YWJsZSBwb2xpY3kpIHZpYSBwb2ludCByZWxlYXNl
cyBjb3VsZCBpbmhlcml0IHRoYXQgY2xhc3Mgb3Igc2V0IHJlZ2V4IGRpcmVjdGx5LiBBbmQgcmVj
aXBldXRpbHMgaW4gb2UtY29yZSB3b3VsZCBwaWNrIHVwIHRoZSByZWdleCBmcm9tIFVQU1RSRUFN
X1NUQUJMRV9SRUxFQVNFU19SRUdFWCBhbmQgcGFzcyBpdCBpbiB0byB0aGUgZmV0Y2hlcidzIGxh
dGVzdCB2ZXJzaW9uIGZ1bmN0aW9uLg0KDQpBbGV4DQo=

