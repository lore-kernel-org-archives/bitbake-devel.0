Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B33D59D6F
	for <webhook@archiver.kernel.org>; Mon, 25 Nov 2024 20:50:56 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (NAM10-BN7-obe.outbound.protection.outlook.com [40.107.92.56])
 by mx.groups.io with SMTP id smtpd.web11.29467.1732567846634751641
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Nov 2024 12:50:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=j6kPejDM;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.92.56, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fad6Cgdxt1XJNZVMVl2Sb/e10Hpf7MV9aFH6SFzc/D+6d3dObuKD7fETxnwcMXFnpvFcBCEHSZSG0T0gLe0oFY8RIScS02EhTmztGNqFI1udzX1J8uXlWAWUe7Vn63vdA2+lyemLgYWvZ+kT05vQOLBZJ0FQgoPcWtS5UuNpgo2lExkEh8qDw3sUFfEPoeEE2lbLHNtfF+ztOAxd5v6k3v41sFRe1DFOqsJm0G8HTe3YWCy+1Qw83EMjYdNZz/J0Nd38cbh57jaP8WGjXMKiDm9Tu9QWhLBJhnSI7Npailyq76Pt5VhWB5sQVL0tu4n7O18U8p3kp2vnqxm5q26vHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDWZSd/COUQuD7W8rjOgvGcollDKskJLYSnee1mhe6M=;
 b=qWYzOL4zLgdUvOOO06hlP23ehKXKad0FmTj8Gi7r9XcCn7G/yyRjwa/bxPcVAIOuNc/8ExOJlrfbgkca4ojseSGAhT+4G6Iof8ydu3TRewRVecMss4fU4FMgNwp3vAjmuFIYH3rjpcXEWQZ41/XOa2AckPHaG7gMUHdNVHpptZZtM6rqOtPphjcVrtYdEr+3R2/KcomyN1PyUvHkRzbF7AWSS6zo72gYyHiAjQRZPaigma/krm5If+lNkU9Xv/Mw4tiSuDi2ZnCL6XrYWc3Lf9MggqgK+4JQ13cT+3oe7L25V0LzL15OJfiQkSsZaGkgcJamCy19q9cp8Ua21Tewrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDWZSd/COUQuD7W8rjOgvGcollDKskJLYSnee1mhe6M=;
 b=j6kPejDM7iAE0THy0lsG0W/A5YVUinEn+ax2wg4LSBuWnRnUBb83wWf4OwEH2AhgdO8rSUKoCy58STj56vSJQqqAn4hDxd3V5MBdjsUpjxr3oBPcMvb6YFaFY+FkxWCL7YebNbXOTtdz6aFFK9tqCKhXK7ypXYPpL0I+rNVNc3AbfzfA4Pj5eBRcZQEtLnIfIhTEQTrZx1XWAbHIxLST0Awi41cAZDvfi9Y5IX916HmfiVHYeua/JkazOEuc0gOIh4BRyqdZ7ycdDdaRpsW5Bd9M7V4xLbI2xQi3msNMUwadV4QFfydfkD0ZSmU0h0zdKvg85bBl+1tK4E3+rajH1Q==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 DS7PR12MB6359.namprd12.prod.outlook.com (2603:10b6:8:94::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.20; Mon, 25 Nov 2024 20:50:43 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7%5]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 20:50:36 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: Alexander Kanavin <alex@linutronix.de>
Subject: RE: [bitbake-devel] [PATCH v3 1/4] bitbake-layers: ensure
 tinfoil.shutdown() gets executed when tinfoil.prepare() fails
Thread-Topic: [bitbake-devel] [PATCH v3 1/4] bitbake-layers: ensure
 tinfoil.shutdown() gets executed when tinfoil.prepare() fails
Thread-Index: AQHbOdagWlqoFoEaBEegLyetAiJmJrLIg15A
Date: Mon, 25 Nov 2024 20:50:36 +0000
Message-ID: 
 <DM8PR12MB54306FC322E76141FE4E05388B2E2@DM8PR12MB5430.namprd12.prod.outlook.com>
References: <20241118162610.1423384-1-alex.kanavin@gmail.com>
In-Reply-To: <20241118162610.1423384-1-alex.kanavin@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=db785e49-92fa-4117-b296-bd3149f531d0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2024-11-25T20:49:29Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|DS7PR12MB6359:EE_
x-ms-office365-filtering-correlation-id: a6c9770a-80cf-42f9-1b88-08dd0d92d051
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?W32d665mCZlf09sramH9AXbK4Og+VMBOQOMZ8xTblsmqfMDh3HdV/pe2fdYD?=
 =?us-ascii?Q?2ZfIRblyAyAub1CgFPj62DKV9b2pNA96azbQXLvX8nscTq1gig2q1pWVBCDL?=
 =?us-ascii?Q?sZXNgNyvneJxSY/HDXMw/0dywiGSdALiANVxjIfmCQJ8JJ7a+D45+JIljicX?=
 =?us-ascii?Q?jwkZVU+hc8H39qZ3p/WDnu+FYPJC5NQytJCUx7f3ojrHNnZj9oRJgyCQ+mA7?=
 =?us-ascii?Q?V9xnBnh9PSVPmXeKJwLV4VyqWrNFBf2RPAGxqqOtkdCaHI9bR9j+TMMHHVcC?=
 =?us-ascii?Q?M2yL8iLVhCo++Jh0DnP1+qCBiFX0YClMIwN3DdSm5nmSNtHfQoPbtYBcA5qs?=
 =?us-ascii?Q?vU1pdFmVdr6PE6CwpD3XEdwsOHUpsB/S+ASAucwNbV20OiXifbqJGN181w4O?=
 =?us-ascii?Q?0YT/jUZ/A8AIVJQNq4eqhiHv4BWYuI6qUEr9OvAKuqPAuQJMDBcwoh7dvoHo?=
 =?us-ascii?Q?1hWJQwtIRrOR5E0gBRGhnegT13lpoTjWJ4sgG8xXcX50+NOVU5lswidfY/9l?=
 =?us-ascii?Q?SL+5+21rezE1Z5OQ0gV2fFclcb6YuBT3/AGx4D4zFWTaTnThjZmmvzw+2EcI?=
 =?us-ascii?Q?DmsGsfejSQiZrG3M34lV3SiEgYHO11VUuZqHsvY3gIhjXHBTNxUplJNOp937?=
 =?us-ascii?Q?S9OX5vkE0224YVSut5dghn3RG1HmWah7gMRwyR7eH1P45TxnIJsbGBKrn5Ws?=
 =?us-ascii?Q?HR1lLVPaqJ2S1N2FeqgnKkO2t0DsXl9r/hWaMKDeFjbgLdAZ0B63efg1jSCM?=
 =?us-ascii?Q?PnTOhyNt8ynGmPhf9TX1XCSD/Cn4PprhBXI104CWFXvrjiBiEmsNIhnv/lVZ?=
 =?us-ascii?Q?10zwk8rAteVttdSVctLPUyIifNB393MImGf8tqUIXyM/gDEm68+UTr3/YQLK?=
 =?us-ascii?Q?T07EsCv86joOFYBOhJRbyTp/KNVfA5d1Fottxx4VYHPdgkl4OnpS6YK69lKL?=
 =?us-ascii?Q?H+eM0Rh+nDFUIafXN7D2waJXFQ1QbaXGjvFu5+MDYTDfdtjzdfOdnPIzvXuX?=
 =?us-ascii?Q?X4WcJhyUAINgQkin1zs2pmZWEZ6ycQsJ21hHSHBDSlnMVzMQvLjWzXx39f/m?=
 =?us-ascii?Q?LL8HnYe3iDEVlslJMCt3FnlvqHPfnsQJO1UlkqoVokg2z40MdEpLe1kRKg4a?=
 =?us-ascii?Q?8QmFPF0J2iHbi/77GdDqiRmAdpZqfiXy9a7fepckoe0/hnVuIeYwLf88dwOH?=
 =?us-ascii?Q?3NhKENBa9xViz+h3y/JtVhmuzrEsE/uStv0rHs0gRdwIhDizCz2EqmW7kBjk?=
 =?us-ascii?Q?Pg01/+NMmlHONl5DnsBCqurdi68Y8ZP1bbV52xCtwm8qGjwGx++2aKctcMPg?=
 =?us-ascii?Q?edsP3OUsMl3CXi8yFBBfoyDaZv53eaBHx8D6aGkhzU4ke9un+ISGM7U2XJWR?=
 =?us-ascii?Q?rJCxHhk=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?PO378i8k5so809MnKrm941szdR8i2I3S8cHF71u7gT2aPctHLTsbjA+gGBwd?=
 =?us-ascii?Q?v1JrtVTRxpx31+RQyB112qsQCCeiumoJkhB7KQl93cuSw1lhrgo2SU+cayXJ?=
 =?us-ascii?Q?5Xjm/bLt63XSPzPOopy4YBW3cgDA6edjfoWPKGXYQlidgcogV/k70SIWguQC?=
 =?us-ascii?Q?5Y4BMiDNWAuGfOjaFRhZnk48eQ8kzSeMHCtScAzKwuFph7CJnxl4D+VGLAVW?=
 =?us-ascii?Q?teOmLTT4zN+IGa901w4VCA9VIpWI6V8Rv/IoSPHPT1Z2HHun2JTiYgZm1LtQ?=
 =?us-ascii?Q?DLQ9++DKGnvf8VARshQrYgTfhSujckZJruYyiybcIEjqjnDX3m7vzcZYCDED?=
 =?us-ascii?Q?P6sj5AoyjPgOxi4QtTDAD22OPvQKERHS5dJQgNW6MN3IgkgAqzWMzh2OZH18?=
 =?us-ascii?Q?DMHhAhFHm5kKvA3CaUpLaKOUKsWkucin0R4MjYXJ/FA4GFnLsGXlgmYzfIUZ?=
 =?us-ascii?Q?JV5jfDYujyF1Jia369rSG34tLsHotfy+7qLqm6V2d/SkE0jaW2qB4cXi83ZZ?=
 =?us-ascii?Q?kTokcDv9yxZ+WdaEvMzTsf/huNJ3TcJVm+puWTi/ilGAANuB6aSiSm8IypOy?=
 =?us-ascii?Q?JzLUjTaFwvcHTivHhWLxECXCQ94eH+L6riG4htt9J0fmSTVI7JsfM1Batuf3?=
 =?us-ascii?Q?u2AYmw2VbryRv3X8AFIUdF+bZnS7zoSVy/tD9RcOJkk5UWCtS46mO65tiGj4?=
 =?us-ascii?Q?lAqi2deXjxG6M9L38dJXU4YCopgU+/OyglUUJNABbZpbZEglq9rYSxSSjcnY?=
 =?us-ascii?Q?/eDHyvQMLI3vBheKycu1C502Ea1sBAPEiDWEq7wDpvpQDf8bG6qqMokZz68d?=
 =?us-ascii?Q?YdZdBJNRCzlhhzcKBBlzGx3jzepz9N9NYe3Vu3uAxIvOQ4ep+pXQNLyv915m?=
 =?us-ascii?Q?YNsizaN+sp20YWmKUjkmrL4ivdXfYfz9lyCgGElIYmVRii2V+lZ77UYXliEE?=
 =?us-ascii?Q?qlJ3mzbTLpKAgvD2VM6RNPz6dSQZEwEREV1KEdF/Ok4i9MG/yq/ZEGqw7mKr?=
 =?us-ascii?Q?e0aC1aRG7DL7wOQg4nDuk76tcuURozSJVKZHu0ZrBa1o+L3Pl5JYrRgZ6IqT?=
 =?us-ascii?Q?/lcXxfdV+WCDKHDV4++Ws5XWyUopzwVgyAWpya/J+3khP8XPr/4vQj98r4D8?=
 =?us-ascii?Q?7Qap1fS5oZZeTZFkKswUmEcG1g/0XeKPHbajBtL813qRXT+fdscTPLrk0mai?=
 =?us-ascii?Q?sidEhc6SB5HzbizR5IZBuC5pVwSfoKMGHW/GXKqhjdQeg1Oihd96IcKANYbS?=
 =?us-ascii?Q?stU5KFThKm/0PUBEiAj/XZTHAKlxeUH8D/5mz3Im7gU0QDPkOlCUzEUbs9C+?=
 =?us-ascii?Q?F3zblPRI4M31GT1HopM01q5f9JtxdsGZ9HetLg1zpNibTcSinQWkPTV9FwAA?=
 =?us-ascii?Q?1+fgRpB5rungoM9E9WxO4dy5+S6/RBPEXhjamKrT4FGgxcul1J6VVpCRj/g6?=
 =?us-ascii?Q?U/uYVrNlO71DTLNjUZHZnNCzQ0BA6Bmy0IGGhTS2k98kav2i6DdG+uMHqVnQ?=
 =?us-ascii?Q?ayuj4hM87kJWoTWL07u6ZPpiGNtMCWGAbE3CfnLzmxUIUDBeetL353NUdVNe?=
 =?us-ascii?Q?jPmsBOAHSDJOhFn7d6d/sIMg8NsAd7fVbgzWFIVE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c9770a-80cf-42f9-1b88-08dd0d92d051
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2024 20:50:36.7548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NRYPrab7GCXJ4OsarLC6AgPeI1+RD290dbEJbKypGrxVLBFnIVAGdsrOsNaFyZKUfiKlHqdZ38qW3LL+nEBTB0EsCmD+anfvO7R1NpUVpr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6359
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Nov 2024 20:50:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16834

Hi Alex,

> https://git.yocto/
> project.org%2Fpoky%2Fcommit%2Fbitbake%2Fbin%2Fbitbake-
> layers%3Fid%3Df6de2b033d32c0f92f19f5a4a8c4c8874a00a8f7&data=3D05%7C02
> %7Cchris.laplante%40agilent.com%7C97e94e28efaa4067611208dd07edc001%7
> Ca9c0bc098b46420693512ba12fb4a5c0%7C0%7C0%7C638675439912466855%
> 7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDA
> wMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C
> &sdata=3DY05hVrsW%2Fo8KxXtUXrC62sAoPmA74U82IWtjyIGqxXo%3D&reserved=3D
> 0
> erroneously moved tinfoil.prepare() out of try..finally block, where 'fin=
ally'
> contains a tinfoil.shutdown() call.

Why not just use a 'with' statement here?

Thanks,
Chris

