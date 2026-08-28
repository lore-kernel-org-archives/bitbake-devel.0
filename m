Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DA5C61DD3
	for <webhook@archiver.kernel.org>; Fri, 28 Aug 2026 14:45:24 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com (MW6PR02CU001.outbound.protection.outlook.com [52.101.48.29])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2381.1787928322256658825
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Aug 2026 07:45:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=Z3CyPMr5;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 52.101.48.29, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVoatTvLCl0BzM9rde+7b9OxNCBloIcl5N9SAaClW4n80HgDxWUMw8L0joCJjy4PxAmuwQdVWTnWFRUUT8Ng1sZdXXn6l3m93Ay3NBG9yif9g46QghmVy75l7PIMNvLosJX+UyLGIUJNE8WOlF01e2V8czS2lC2Fmjr4NQM8w03mP2cqlPwnoo4effjx0iGHLHp0Tl1XP8Lmvt2TrydtVbctOMs8sIaBxdAAJ3STLjsIwZzE32z7giZO0HHvGJ1E8mNxkGMD2Iw/0+kPCYpxFFz2pcNFThFINyGTwBjNRKB79+2SmYg/msZni3klPnbdyzdQsO32zYT4Fmy6TmtAEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wd9CHIxoLEOV8BQ38L18P2E/BLdD+Z52/v9SHMPujdc=;
 b=Z8hgOd8zPSRo69X0OF/XuhcxEkyuJ7MCfo9/iDWXsSJJR4I1Nc2XxGo4f7uLRPOJP/L1I2lajw23VqYWpGDcwvvqSmgwW9dZ42ynLs2IPOsjKgYOdTd1tgf7sGIP/3GlO6xbDCgdppXZyuVre0HCjouyPRkXE0XAMvl7rCQwnhcOgKEAH7krGhGHWdp3Afb6k2gzKUYk8hjIa9SlaJI1+65ss29uJzDZx8k9h9lXrPXb7s5CO2pAdtsrG3aUsYdagKGGQ1shl2QU6kqVWTf6VQfcc8tHIJdI1hhRo2SC25gQqd8mhcVjk850lO/j++hqepDWitT95kiM8ZCPqILwbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wd9CHIxoLEOV8BQ38L18P2E/BLdD+Z52/v9SHMPujdc=;
 b=Z3CyPMr5JrCXUvfJXAoeirzsbdHBBh2jXJcbWbAaZb7FEMO7Ep7cXQmbHpv/i1PbQySU8Pj3H/d9kTAoJWAdbS3XVR0KkscYqY9w+esDBMFjFRj8o2qF3b+hyJOjnBZbDFflTI6CryvIcCs51JaVsnyk/uue6xkdcjtVSahvhcBYaDnCvTd/v6eyPWZlUBEU1MvuoL5P03bz4u+WS6grP9nJGpF7EMXW6g8oNoLL2PWmkVMInDpVypuvmVjrs/ZLRxl6gvy032NlRpG9S2BfGhGeO48Xm606iV5fM4JTyp3N0kAwhPtDg+yvSk/bDUyh2hQOy3S91jwVGaX98X58Ow==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 IA0PR12MB8328.namprd12.prod.outlook.com (2603:10b6:208:3dd::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.11; Fri, 28 Aug 2026 14:45:17 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::152b:7346:321d:4a2]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::152b:7346:321d:4a2%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 14:45:16 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	"mathieu.dubois-briand@bootlin.com" <mathieu.dubois-briand@bootlin.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: "docs@lists.yoctoproject.org" <docs@lists.yoctoproject.org>
Subject: RE: [bitbake-devel] [docs] [PATCH 1/4] lib: rename fetch2 as fetch;
 invert compat shim to make bb.fetch2 = bb.fetch
Thread-Topic: [bitbake-devel] [docs] [PATCH 1/4] lib: rename fetch2 as fetch;
 invert compat shim to make bb.fetch2 = bb.fetch
Thread-Index: AQHdNjCzG0PhMvCD4UuJ/onN4EB8c7ay9jmAgABnJYCAACt20IAAAjSw
Date: Fri, 28 Aug 2026 14:45:16 +0000
Message-ID: 
 <DM8PR12MB54305B0839AB4F9311B518AD8BAC2@DM8PR12MB5430.namprd12.prod.outlook.com>
References: <20260827142958.547182-1-chris.laplante@agilent.com>
 <DL0CCF115T08.227YUHOXXHLP3@bootlin.com>
 <AS8PR02MB10201CF48B8F8DD1675237AD3EFAC2@AS8PR02MB10201.eurprd02.prod.outlook.com>
 <DM8PR12MB5430838E898C61E85CBF14818BAC2@DM8PR12MB5430.namprd12.prod.outlook.com>
In-Reply-To: 
 <DM8PR12MB5430838E898C61E85CBF14818BAC2@DM8PR12MB5430.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=8530a8f5-d2a2-4334-a00c-ce3a38963b2d;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2026-08-28T14:36:26Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|IA0PR12MB8328:EE_
x-ms-office365-filtering-correlation-id: 867cca0d-27b5-4117-7b3f-08df0512f993
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|56012099006|4143699003|38070700021|11063799006|10067099003;
x-microsoft-antispam-message-info: 
 wU6b1XpKlXioLzbZ9312OU3nj8ZtwbybZ+PlB9MgVSe4cNRIIpCacCZQdB0PnwGe1dF9xc/GKIEOWQIrwjnYGp0MvgT9kfgAJYGMS59FhszEFwaklfF/Et3oMROmb49aSGe7jylRr+/zrrjSQ38D5SoBMTvUxoSjKXW12x7f/QK8UP9kr+O+Sok/yTVttHdwvSBpI79xUw+uS5EsG4KFAkLVDfxE7Hl/XNBn130P5V8/pZY85oFwko+Ld5UeDSlnWm5jZ6rVfz8Gd/eW5gYZ2Np2rg3HJP5sEl+FfbKgJb+DCXLSk0nnUInsHn4D/eE6St9UwNzSaICi6rzSPX3BJTbfxlpjcgReeiaLnOjuiR/G18FkYFanFnfV6PMgrLHKlRb8ACmRcOtpIkoFczuR+MbmvECYxPmLNPvfQ3mnEHuTsdXMozjuJaog4mXXdWVr3k1PDMDqVb7cexlc+T6tCS8rpFvQohpv6XGN8a4ADoPotZ+iyf0MdhU6V6qHaxVU9pxRQdNn6TGTawSs5TdwDhErJCeIQw+l2aCx1XBZvlAYWgFQLTuoPjfCp0C0h5GT7g/PHN/lW5j3H5CoBL9ElpsgQc28xicQ1cwDFkrI2nKC47qKW+rXu24mOslB2R4PVFEHh91Z57qQO5MB3nCVPAYgCRZ9iJ5Q3SfsaVXQvRyHZjkDMs3wbVG+Vuuoec392c0+jlnpxYJ7Swso1/eJkxA/fb4BR3PAe0dl9EIcwPU=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(4143699003)(38070700021)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?D95CdU8jjF2SPFdnkqPbUY2/fVE8RLIlAvwTNEeCwFzzKwkR89YGI+zque9v?=
 =?us-ascii?Q?yE5j3k1Lnq+6Rv7KGbaZAIjtXSDU/RFqXVj87XM7wkLnkoIm7Ou6QkUgOlgx?=
 =?us-ascii?Q?BKZCokhDumRbZrcWnKCRZhMGdkHouAAUAJ5J1IGRHaHcwiH33pVqiOGNDgsR?=
 =?us-ascii?Q?wpWu6VmfXnMAHa97C1kzcQ8zJGAah2QvbFvnpSkiVVx9kp1V5pKwKvOsbb9k?=
 =?us-ascii?Q?fNoQlbI4peGNRJIMQiMPRFPng4WaMsYhZPd1JIDlbdRXqGdb7Nin7SYXvW15?=
 =?us-ascii?Q?xhbhfwN+G4E61SDw2otd5lsHaBavcPe2BkMLJMFs7Edw7k8OJnhWVnZTPYxX?=
 =?us-ascii?Q?Oy1vkkqY44r/62aG9dUsT5GAivlk+KjxM8MBGBQ5M3ZQuSVwqQnlNdr1TXKx?=
 =?us-ascii?Q?7R1OWOIRBC6gcVvFr4Q8KqB63DnndbfQKnROyQLhahtRNqN24uyEhgGuSM1j?=
 =?us-ascii?Q?j3Oz0ldJYmtuI8V5Ptkl27iVIVZdGmyoOy4fDhaaGXo38RjBPCaQ2REbXLlw?=
 =?us-ascii?Q?tIfn7ANzGISU2VqaaOMLx2mTVTXx7FirFp0awUmPLSSjxg1wNAfO8gfDHXQh?=
 =?us-ascii?Q?3b74D/30PP1ydYGB0ryWA27e+ltKvC8tGykVAVOSYWB8omX0O1SOdzCtMJAv?=
 =?us-ascii?Q?6RDMZ6SsT8YlCw3kSJSUoBA8Fk95wVhNBI+skl+Pw95uSnEjAU4sFsdiIKYZ?=
 =?us-ascii?Q?bkcVLIHjSnNlbW595SFTgwVtpxiEw/wcSiCs8PHI0xYW9ODRLhffi0G9OGT4?=
 =?us-ascii?Q?2ZdWWtZG9zmgs3INoDPVMNEpArKbAaklERGzxEZ/XI9itkLF4AG+kGRSf86c?=
 =?us-ascii?Q?ph+FgbSNv2IxSCRssdyH94PaTrhsIVSe/x59uC8y/YLMWlVj5QUy52uSd9zp?=
 =?us-ascii?Q?YpnrN/zXfElebI5xyP/kILhDmdZAak/DNNQxAkg6EYXYd3Z6D12ltrTxJ9vm?=
 =?us-ascii?Q?BDEm6ZhdE+Xs0Q1G2wwNGsX0sWQj6xYsd+RmVRaUxcqw5hCZX6aU8WjByqdc?=
 =?us-ascii?Q?ioHB7ASQsE4nA5p/JNVmQhOHO8kIY7+BvERJGSTQ66XNz7KEiL7IgB45KPA5?=
 =?us-ascii?Q?HzGSCsSKuohYNuYqTzL8+kd7eRHTQtcK5o00/gsEQyrw3auxCc1xWhZmR5NZ?=
 =?us-ascii?Q?ZMkJwuQiWS9uiIeQxQa3Dfg+wnK5UsHHJiI0logk1V9gN0bwCzlBZGC18S7V?=
 =?us-ascii?Q?otDG98j5La3ishohF41EgvrUX12vyi6PbE7uQnShpE+vrACN5KjU5xKWunUP?=
 =?us-ascii?Q?3u/ZTS96BG/IXP63BuwWl0FjZTalyhJ/76a+IePbS2D7x0+OuacpV7XkaPXj?=
 =?us-ascii?Q?Ts0VX5xM9NJogP2ihmypMhz+eEZ4MyzxuNxmOCWYn7Ugu+86dz/pZH6p+eAi?=
 =?us-ascii?Q?j/FAaWWHFgqQX4q2CxRIbnxL0ot62q9P+sT+ENZ2IWwKcYAiNiUyyvhTA1e/?=
 =?us-ascii?Q?8n9EeZLSnpS5ygiphwNvi1PdT1p/xmc3ft2zLa+sFROhLa18K8j2HrTpveFY?=
 =?us-ascii?Q?efvsRSEBKZaVkNMt+L3Nz9pmb32Qyg+sJXrLlmBrkkTMKQNW8/W8g4MO1FiN?=
 =?us-ascii?Q?LTbgAKJlY+8Kl5cXeiGQOstD3zK/ru6P663xREvYYYAOuojRg8GBMTuOFBxS?=
 =?us-ascii?Q?+jYynZ4T6f99q4/sEljnH2BKdVPIUV5M11a/HmeF5NI/Pz4GdK/r0aDnWvpJ?=
 =?us-ascii?Q?XIYNLjw9B7v5MT8id8liSH12eTh//TB9V8rkO23+tuH5Y16EYRbC15OBHmjG?=
 =?us-ascii?Q?JJ+1a+sn+w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 867cca0d-27b5-4117-7b3f-08df0512f993
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 14:45:16.4350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eshZL15hfiCp3PSBq5Nk33RDFKyqsz2rPTkOqG+l2kr7iVCJFs7LlQYxD7KDzuWAcvyq/POlJjxMW6LmIAr++QdT6i42uemcKXP41dBfP+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8328
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 28 Aug 2026 14:45:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20104

> %7C&sdata=3DNM5g2OmqXtTBYvIZEK%2BZhXJEgw3kUdwosF6Ptn8heOo%3D&rese
> > rved=3D0
> >
> > Isn't the bb.fetch2 shim expected to take care of that?
>=20
> Yes, this is what the shim is for.  With the full patchset applied things=
 should
> work (TM).

I take that back, the shim should already be in place as of this patch :(. =
I will investigate.

Thanks,
Chris=20

