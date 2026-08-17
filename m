Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F193CC5B572
	for <webhook@archiver.kernel.org>; Mon, 17 Aug 2026 13:48:59 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com (BL0PR03CU003.outbound.protection.outlook.com [52.101.53.1])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.30848.1786974538044542600
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Aug 2026 06:48:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=Rs+XoTvE;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 52.101.53.1, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hG+lXQlNCCLOymqyFXLZLptpSHAhMpQ42jzejSOHW8HHR2SPcUFxau1Vwft/g73bK6lCdhWGS3f/0PBEiTgU60bjFeTbPG0vSlpZF5JIoo+orbPbRc9eUyfW5yBadIapXENxb+JgucZdZDfKcEr3K6xQ0Io1IKlVRV2Z61ZDBZ+hXNgssHIHeHzf5F0jTOW+L8nVnOA5Ye6d4du23QbsT2ZZPF+p7I5NMwXtVczXcj/hgXObjXYFOnvXAyQBfvBxwKUc4CzdM+XH7zRbIABheSnc0CeRQZCO82c/hnQD5wNY5kc/iJm4s5R42XTAxXWD9OSnVx9P0kQi5Bt9fIdKOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8dT5aVqaHUmf9kVNoeGSo7zZQN4ck9lsAClhGXJwn4=;
 b=YKzccAye/AYa7pdwBjqm0XwSgplQXleyUk/M3bDMJEqXg6Tls5hgY3ViSstqVaohQYfNvAHEHwaieRVp+bQPa8/Cbmji0IN3nAeYe2Ry1k78SFlwsKsLIkIr1/ARFlRvv7xl8EC6U8pRfqPjH7exDhSPoEcUNic3l8boA6oAWXfMj4BQyt+M266aUIVP7BtrHxJdcY7YLKXfKghmk7BT9213U+lPr7cIEu0utz9L9L7REqzsiwDyuyLjhgsJJVtzXYP0dbYtZZeIWX842Usf9VJKk4u9DevP8tu40oCsajjsaeBkm7VNJDliyitgbKZQLMp15Eznej/6/mT+ARidBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8dT5aVqaHUmf9kVNoeGSo7zZQN4ck9lsAClhGXJwn4=;
 b=Rs+XoTvEy7okkMBnf34sfKuV0pMNHOXZnthkeVmRCtZBVTpx+4VVU+po3n+Yfr1pslhLA3fH6mFFHD1lQyWvqD8I3OF9Up7ditnE7XfGwMK+S2fOVrBYaOA4f6jP46n7JHM9ugzoq/yOhPomQ5lPCwX2WaTuEFzcRVwWRH92eTH6kIEcroXPMF8kUFiwt31RoLwpoZH1EoX/cMZVfFKSRGHLkgCZMftVHBBkhOQZ7zEeMzrBqkD9LchgyPyZOi+4/Q1DW5OMpDpkdZiYnPMOLj9THvosYoG15+368gX8q8S8uH2WlqicvFZn3mFGd258NTbGdAtkwUvvW46JHr6YOQ==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Mon, 17 Aug
 2026 13:48:54 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::152b:7346:321d:4a2]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::152b:7346:321d:4a2%6]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 13:48:54 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "svsvenss@cisco.com" <svsvenss@cisco.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: 
 =?iso-8859-1?Q?RE:_[PATCH=A0v2]=A0fetch2/wget:=A0reuse=A0cached=A0HTTPS?=
 =?iso-8859-1?Q?=A0connections?=
Thread-Topic: 
 =?iso-8859-1?Q?[PATCH=A0v2]=A0fetch2/wget:=A0reuse=A0cached=A0HTTPS=A0con?=
 =?iso-8859-1?Q?nections?=
Thread-Index: AQHdKnxaqgOfbFZ0Nk+1fTBcZToMq7aiSJ6A
Date: Mon, 17 Aug 2026 13:48:54 +0000
Message-ID: 
 <DM8PR12MB54309AEE365DF999981829528BA72@DM8PR12MB5430.namprd12.prod.outlook.com>
References: 
 <DM6PR11MB39625FB901F43B181E8B7C38CBDC2@DM6PR11MB3962.namprd11.prod.outlook.com>
In-Reply-To: 
 <DM6PR11MB39625FB901F43B181E8B7C38CBDC2@DM6PR11MB3962.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=910e671e-f650-4ece-ba89-b6868c0f2a60;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2026-08-17T13:46:25Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|CH0PR12MB8488:EE_
x-ms-office365-filtering-correlation-id: 4a06b3c8-3c2d-4ae6-2166-08defc66474a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|56012099006|10067099003|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 
 MM36gtFHSuDquZZN9pw3mKRyYQnBT2o6BuntgViVUPF3HvSr07oCao/2N9R0isL9YgjDFUZ9CYD/eFQmwg/5WU+Dm4uO2xZTsXLFgFFfA/TaC7qVImKeNEHFk19a2jL/W6l2vE7x5Eb6GV6aEOMMnTdLaDe3zqzlkU1E0fhVrkHnES0f0RklUWVJIeYKJ315KZ4uiggTgYLvnqiyni6NCgFtJU1UrChFBWdS6f55dAOESzhXeUJ/PXVs/9OHhDLl+G4JrZS+ttwd973w487VVOeQpts6GsuEQA7GFscq3mHKLjJa4AJ79Wut6/mY7rLMpMX1j0Rc5JsiGiR/Q5N1GkgY+3fI1hcwoTkyKz44szM3TYD4nPuoFPMIHmaIWck0gdyAZJ22wTZyYstZYTQ6RCpbHL6bVJq1YiBEJTwDjORrDyOGgnwgOU57GfvrtR2mjETO6+ynkFvPKXDfp65U/blUMaD5KdRzAHD/YGJGeKjd16lS0Zv5zVZb5y1yHfyivNOg83o4J68AWr4WJ4RrMRLgzOsmOC8CEK0uJcTZgcET+TI5sJ+4qMcYEYyFP4ttwpwpY0XIHd2rggWUOsY4Lc1nTlPHKmMDbGaGZAH0an6e7yM3fjqqWFFem+ncLlaeelHqRO9PUrhGBgGFAHOUZEEJjY2e++Thp0I3svjctoHDXB8rzPPLETlMC6Wr9gZi24lpt/eIHAFoquqGo//w/CLEgbdY9OLMk0SH3dxBjPk=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?6En73kynJDAIEJoeq/zV0TJHGt3TvOtd2tM2et+iA8GeGLBxdVpavOGcYS?=
 =?iso-8859-1?Q?2C3XPJga1fhi6lrbjkgHIHI/ouUnkVFbW++AWpKEoBrgz70qA/3o4Rd17U?=
 =?iso-8859-1?Q?NEYpBrsUFAxtrr3hilVmWaN6sa3XHGhQpCcCVKODfRi0HydDYU2PXd1tdZ?=
 =?iso-8859-1?Q?Ajn93bT1y7ERAxH1YXaUiL0OIU8gtYaJFy4WJnRXVz9iXnnMocyZ7Kn1oh?=
 =?iso-8859-1?Q?qFVlnAR+quraKNOcjDvIu6XImeu0hz+WBnyJn0FqznPNnb1oQp06vedf/i?=
 =?iso-8859-1?Q?gN7x/v0+hZmu5aFRXSXu07iUbGMdavz4Fols8d/LPw14BkhvmbAwaRe570?=
 =?iso-8859-1?Q?tp3YABlZeW30SMFB32xBpLj6mzjq0HrpT7gQAuoQWlTJVfH7Nre7R4+HjC?=
 =?iso-8859-1?Q?mLLalo1tA4ZCJG49COjoJX3V2UMapmTPNTUVznidhvwzyb5zq0mxQapEVM?=
 =?iso-8859-1?Q?/dFb6xWJp6ysK06AsZnbG7vcd3vqoMNJz+Szwv6gOctOyzgfoLNNrP0atD?=
 =?iso-8859-1?Q?hYeGSVALykWkuGSzyXioG19NCl6wgoF5BUcnigGq8AINFucexEBwejJlWv?=
 =?iso-8859-1?Q?slDk38txTONMDA4W3jSWMGJ9xk5ztmWk2pEdgUx1TwUd6ZQvf6qMDLPHy2?=
 =?iso-8859-1?Q?9dR/4+aQ6GykVhwxx1e3+KwqpRkgnWSJ8cTNRjKsytlwAIVT1556ZuGxwm?=
 =?iso-8859-1?Q?kivLeMAfxgOzJpy9Q3BkPQlbKNBidO7TsYq+oi7RP6vC/hv2HS9hoN4WuB?=
 =?iso-8859-1?Q?WOYPWu4kx1BTriFD+0MFkEEDPBzMTCv7kbuvcy8B9+m+2PUYtSKo3YhFrF?=
 =?iso-8859-1?Q?DgYfsVcaBQDPj1zjBS/s7Q2fJICY6pHiFnjS1RzP3AiDGxdWBgD6KtH+h4?=
 =?iso-8859-1?Q?+Pfv27oq+7I5VcW9yLIVEiGx9K/we6Kg7y0DECK2dpK2j0zhRLI2DVFGk2?=
 =?iso-8859-1?Q?Ynrio9YsFy7nfGYOCr22STjwUPz4DApqyEHY9+on5AZTr7Mj51xxPyqAEb?=
 =?iso-8859-1?Q?WveBn/2A7gpgI5jgo4CsIfaTKpk2bM7Q+MuWr4Dee6XIglsmIzHpSAk4bW?=
 =?iso-8859-1?Q?HXzbgV51AUOCeF+FkOQAXUkiN8g/2ut8gRd6a9NOlovsGI76zEdDEpN4NQ?=
 =?iso-8859-1?Q?h51Z4FMGgke6JYtks0ZM6xqEmxif9rtG2S1CmFugOjvlelgO2uGd+ZVw/j?=
 =?iso-8859-1?Q?5aNZqPJy+RwL3Jsk058/r2ZBFRJXqK0hfBV2wl4lnOz7audPTPT5xb9LZh?=
 =?iso-8859-1?Q?oIxpFH0RToPARrlxQ20qTn2IqmdDnu7tMRMCk5uQb7hmhQGNMApfgTgYaE?=
 =?iso-8859-1?Q?FFTGN5HoK/XxaylsxJd47cXbzHdplJ89zdB/YGs8RDqkKuzfs6EuKCj92O?=
 =?iso-8859-1?Q?yLj4uhhoKKG/JAzt34UrnqcUsk9at8JDTfK6BbY8xHcK1pzk0YPNBJCkNu?=
 =?iso-8859-1?Q?X8rtkDbAkrYQn65WqJRzKOjI8oJcVXncX10H4zLTJYH5Zl49yhYRCJuWIO?=
 =?iso-8859-1?Q?fpbKS2dbJsQKqFhMmUhBwLUiqa7bBmStOPHRkpGT5X/I2OQi6XiAdIf/CI?=
 =?iso-8859-1?Q?e+rLP2WmQx8BIdXaGwzkU4ZSo09zqrssR9+Xw7TiD0hnL56LX1F3cg43NV?=
 =?iso-8859-1?Q?uwbGv0NLZydJksEwm+0dfeyo/o3X8v6CQuLeONHD1nmPtEet20fXgB51iV?=
 =?iso-8859-1?Q?zkM1jWQeztYSbrJL6V7Ywp5sTpXBnJPA+RWuC3S8+NDJLizTOMGpRDXELW?=
 =?iso-8859-1?Q?nC5aLhKkezy0DaNOKTRClGs2Xlkb+A8zwYPyS5lwIlewLzluM4Q+Uf8pXz?=
 =?iso-8859-1?Q?87ngtmqxBQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a06b3c8-3c2d-4ae6-2166-08defc66474a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 13:48:54.5832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Px2cIDnDdDjCb5AMSamTkz7W9AG1sqI9nrzbwJedstYVDL4vMVdqk2Dgl4apMt7X4UYM5KBtFV6CCsV2r7Axjn3AkoxvUma0QOnRompOFvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8488
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Aug 2026 13:48:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19969

Hi Fredrik,

> The checkstatus() path reuses cached connections for HTTP requests, but u=
ses
> urllib's standard HTTPSHandler for HTTPS. Each HTTPS availability check
> therefore creates a new TCP connection and performs a new TLS handshake.
>=20
> Add HTTPS equivalents of the existing cached connection and request handl=
er.
> Preserve the SSL context selected by BB_CHECK_SSL_CERTS and extend
> FetchConnectionCache keys so HTTPS connections are kept separate from HTT=
P
> connections, different certificate policies and CA files, and different p=
roxy
> tunnels.
>=20
> Add a local TLS self-test which proves two HTTPS HEAD requests use one
> TCP/TLS connection. The test also verifies that a connection established =
with
> certificate checking disabled is not reused after checking is enabled.
>=20
> In an ABBA benchmark against BitBake master, 4,283 remote sstate availabi=
lity
> misses averaged 761.639 seconds without this change and
> 254.742 seconds with it. This reduced the check by 66.55%, a 2.990x speed=
up.
> The benchmark had no matching mirror objects, so it isolates availability=
 checks
> rather than download and unpack time.

Funny enough, just last week I was also poking around in this area using vi=
ztracer to do some profiling. I was preparing to send a patch that just cac=
hed the SSL context creation, which on my system costs 100-200ms each time =
(since it has to load the certificate store from disk).

Thanks,
Chris

