Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D65C433F5
	for <webhook@archiver.kernel.org>; Thu, 18 Nov 2021 23:35:44 +0000 (UTC)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by mx.groups.io with SMTP id smtpd.web10.1186.1637278542124956808
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Nov 2021 15:35:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.onmicrosoft.com
 header.s=selector2-intel-onmicrosoft-com header.b=uRwWiYd7;
 spf=pass (domain: intel.com, ip: 134.134.136.126,
 mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="221194622"
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800";
   d="scan'208";a="221194622"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2021 15:35:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800";
   d="scan'208";a="646978144"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga001.fm.intel.com with ESMTP; 18 Nov 2021 15:35:39 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 18 Nov 2021 15:35:39 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 18 Nov 2021 15:35:39 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 18 Nov 2021 15:35:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVuPtrCswGYqd/u15zdDKR31CrzEyN20xY5RHYYl/0rx22UX49QmhvAYr0fFgi42nvk1HA0oXkPCz3jthet5kWauzIxJu+K1kykfC3J7FfnFKAwxDBYvlP94AQhtzy+k4PFtICw37xxe48CfIF7DdsQZuQoWDkqO8FFf72ngv3EN/r029Yw2pX7GBznvLefmlFl+PHOYzbmEBqd9Fj1LWb48+qkS1TtqXroFyhX7dZSW/pvl6g2mzD7Hgl2RhVwGWUPmhaPz+CRded/MAGjKANtxxzN+Ms17dN2zSVghLunwA69CksWPDy+j7cpMK2JzZzQ/Fqb318hh8iE6z3JOyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbtSKuXDAR/Jr2o1PkPseIAoGllNaeUvXp5XzO4CbM8=;
 b=AQwLk28FDjWVIWbhaio+cByEFYlE8/rjBxL2FR52H5jT6YZ+I2EIZWkI1yy01dX1824hfI0dkP76daKE9mx9AehizEfiVqm/eZOC8kTUZvB2pBPZH7Srq3lK7ymjL/odTA9MKg4NoyLdM2RANO9RoK681LwLkvpoOGr5APgKwGfBetz1eTbhSyP10O8RE6zkwjNTlwg1AoFOYYdAu6MIQI3u2CeqedfCesxxz7lmHX+tHpdn7VrpyN1wxKxN1IRr2DmYON0m80maAMYbtxBsNA/m0qm8zXZSQvgpisEwxXoJc0texVq2q2eK3yxK7Pu2X/cy/VLDVcsMv/fZsJZDSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbtSKuXDAR/Jr2o1PkPseIAoGllNaeUvXp5XzO4CbM8=;
 b=uRwWiYd7yPIO1tvHS6iiciu2ZOwZGMKtS9R0z4tuR1J9XjHS08UV9LWuDtV576lj26Nra+GJn3TSJgIjzcXGBvB6/q+8+LFeq3T6roY53fnhLuGxXpPli5YfW3ynWOul70oj6jpsPvnoLLpCCIcun8O7N/Rt7QBcwn80Sm2SkvE=
Received: from SJ0PR11MB4896.namprd11.prod.outlook.com (2603:10b6:a03:2dd::20)
 by BYAPR11MB3063.namprd11.prod.outlook.com (2603:10b6:a03:89::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Thu, 18 Nov
 2021 23:35:36 +0000
Received: from SJ0PR11MB4896.namprd11.prod.outlook.com
 ([fe80::2c3d:dccb:aa85:53c5]) by SJ0PR11MB4896.namprd11.prod.outlook.com
 ([fe80::2c3d:dccb:aa85:53c5%2]) with mapi id 15.20.4713.022; Thu, 18 Nov 2021
 23:35:36 +0000
From: "Mittal, Anuj" <anuj.mittal@intel.com>
To: Jacob Kroon <jacob.kroon@gmail.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [1.50][PATCH 0/4] Backport fixes for python 3.10
Thread-Topic: [bitbake-devel] [1.50][PATCH 0/4] Backport fixes for python 3.10
Thread-Index: AQHX3JnVD3Xt78dyWUGluBWLGn3PUKwJ8FIA
Date: Thu, 18 Nov 2021 23:35:36 +0000
Message-ID: 
 <SJ0PR11MB4896E641713CC8C0787C9E28F89B9@SJ0PR11MB4896.namprd11.prod.outlook.com>
References: <20211118162623.3117035-1-jacob.kroon@gmail.com>
In-Reply-To: <20211118162623.3117035-1-jacob.kroon@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9df4100c-4195-4b69-15ab-08d9aaec1f95
x-ms-traffictypediagnostic: BYAPR11MB3063:
x-microsoft-antispam-prvs: 
 <BYAPR11MB30637923DAF08E5D0789E088F89B9@BYAPR11MB3063.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 1MKlNoSERqtNrx+dOCunmiovVDlQ4QwEpEpCeLf0VAxAZvxykEnpLCuLT3YsI3NyTSGpcPOcGd9WLOpliOi2IBHrabXmnRMIpj4OpBPojKYF9y4Wx8m+4r+lDf3TVMplczW/wfYeNDZW34DF3bRwjhjgbZes5JUHizi05uUOJNcjwvIBndX2Mqx2aJSneJd7So4TpCk7mUeZr1uAkg8U/STByrCbUeD7Pa7J5a5gF0dQ6+/uCT1BqkSxXeSqPzqRAoFu3/PRsBDVmjuA7qQdDcqjuC9YfB1cCJbVRZ2hufYzaCTHjdsNQuv7oLZBX1wrKKMzvbgrJwsacApN+UQAASXbT8adjkb5v4WmxpVFDDDa1cUIGCgIFj64ybO8uHK/MsJwZN1dhVHiSdoXzRPNeLuRDAxPhu2J/7h8BhN6V0b+tJn+t14KB8SSvMiQ7fMMTBuzqQF1iMJjFx9qyWl4hV1TPD6OQBdPlp0s3mWYwjkeGAMhATsc5SjiH6CoPO0DrXCD66NgE8Ij33uKEfzce2wHTJYLx7zmNDRZxWgAIug5yfUb3Py8HhO3Dv0iVIp9YlGXfqJaK4O3k/5+YwoSnNJgX2mDeK34H0A2X5ELGipxlkTrtKapMERgDXXFwR5BnvG7Qb2zdQhW6n+2p73ECDOV4sZenxUlJU4qQTj0x6W1m1LEQ4SR6UelSL4RDfSfo9wiNiq3KAx/Glk6jeSAW+dfccDVEcRA0OIh3gZSx6npe23+OKY0duwQs1xvLAP3uIuDNS5tL1mQJ4VpXRsksdjEhmClYY6mXxa0VW+sNF4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(55016002)(7696005)(76116006)(186003)(8936002)(8676002)(38100700002)(966005)(122000001)(71200400001)(110136005)(508600001)(52536014)(66476007)(66946007)(38070700005)(5660300002)(33656002)(86362001)(9686003)(6506007)(316002)(2906002)(66556008)(64756008)(53546011)(66446008)(82960400001)(26005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?ZKkyiPO/c/XCNO/YZAe5esIXDEYt/F3h1yAFnwjo1N8ayoERVwV/H1BIe/UN?=
 =?us-ascii?Q?yL/HzLZc027vQWGhLXqktcvk1Y+7zVTp20jgx4avOQsZunNHsz6G0ZhnQpvg?=
 =?us-ascii?Q?WDpXhfsUjAJYGckZYP0E8+BdDV+hNz55YbdzpCVZuB7Z3wB+oeUno7EzU4So?=
 =?us-ascii?Q?93NA56Os1KqlQLjMLdhhc5RoZJM77cLL1XTK+OrAjzCo8S2rBHX3eZ153GEy?=
 =?us-ascii?Q?hyCJEsmQgflOsBSjzCkXtn9sodqZArquOZFALTTjib8PaDR6T08xUWe4km7q?=
 =?us-ascii?Q?DQHftwp2r4K+o5lwDg6Ss5yMHjIjRiT69RTcthQNyz8FaEBWje4UMDqCJGX1?=
 =?us-ascii?Q?bKKf/lxDTg/uThcy82f75eySZCSxPqIWLUkWKmmvRtsXVXCHiyoJf019A6Um?=
 =?us-ascii?Q?szOl0JnhzQs+4cQWRjytRESbAPfvHAn0R74XYMQP592X76txMNGt4NEDldPf?=
 =?us-ascii?Q?lYu32vzKAv3FWSQgLT059V+hJfZBFcXVygUbmZCmHTCNDsXRaGa5CGIi0NOo?=
 =?us-ascii?Q?cMYJf7MSoBNw7hvOCNE7DEu6t4SXWYHiVsb0JNx8/+V16dWJiWIv/JrFhfQf?=
 =?us-ascii?Q?WSdf5kJnQmhvjq/OXvbNuA1ILzLKKMgNkRP9LF80mXyViJ55ee0FrE78nak/?=
 =?us-ascii?Q?VkQDwvULpHmNUy7DGTFPaqDYJGf4EncpYcQ5LOLlTMnDZ+7qc0/eOJ6EvLB1?=
 =?us-ascii?Q?NUtZKf18una40dMraoX2+tSyV9MZTo041Es7MOe4n7Ih/JXphx6frNTIy8nz?=
 =?us-ascii?Q?qqWHeDMg/zosOHV1DuIzfV3u0aKRg3lv54XuZMUX7iUsO8ZAPGa/dv6XoTsf?=
 =?us-ascii?Q?Q2nAWm/ZRBoCVO5y6xb857YuZinIg+a3HXWHrr7nGT8uPw/t/f52qKxdlvHc?=
 =?us-ascii?Q?95kZMxuLJFxlRDV/5daX7+5PER286Kr+85pVPJYAGjXm2qmhUOPc1AkFXJna?=
 =?us-ascii?Q?NT2LuWFimYcZWAcRgl7cSkdu9lgxgG6dy5BAqBOWf8jFkCpUG1rvb9iQKX3K?=
 =?us-ascii?Q?AyGSa+TEbRI/i63uACgbaYsa1nxybOZCPek9BlyZZq15qtHH2rSWnwh8ZvZ5?=
 =?us-ascii?Q?/sLmM3OgxystFF3iFo3E7+cSQ7jtvtWOCbd96sWXtuJDx8zvV4UGjQkqb0ZH?=
 =?us-ascii?Q?vuCKpCDFslYKRk6KFc9kQT+39SSHRW8sj4ebxFqjIsIXCYU70z7ehrbYo2Hy?=
 =?us-ascii?Q?lv8x7HWgE3V042bCH2yGXPKc8dPn+TA8sF+Mw8fQJCsFaMgwp3sEAhdERH5U?=
 =?us-ascii?Q?5UdD/jt3D+cp2YUqYfxTuTg/0S1GFG4RhdAD5Mz46+EuFrabI/jfxaq55yfB?=
 =?us-ascii?Q?CNkjeT3/+4FcgxbEHyp+8U0zalaQz5AGpIam5SccwFgPnvpl7vakK595KTy1?=
 =?us-ascii?Q?ZajMtoVcwyQrXi58pD3Wr2U8Al03zZI63OsDf5Ii9ai0FBj7gX0paV+SVX8N?=
 =?us-ascii?Q?aEOlRCzAcqI6OSqhRVNuVRDwgDVviOomo1YVtbKsc8WQc1/XNL+0sCH+TL16?=
 =?us-ascii?Q?CpuKIy/UNJdPpo1OdgiSG8ZkYO1SbWpEnU/TB0r8q39bavZyK6EyCV5vcoyA?=
 =?us-ascii?Q?bg//Sav38JNW75NPDgbIWa18VVDmSlGUNydJ/nW3OYfWuwKq32u1Q9Vz7P3N?=
 =?us-ascii?Q?cjWmZ7xxjW5YsqMKzgyv1ks=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 9df4100c-4195-4b69-15ab-08d9aaec1f95
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2021 23:35:36.7597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 XQqHZ8s17vGLD4EY7tVe2R0YsJXmAedWVLz5OEgrX6LsixzZvwb+U4jNfUXWgHD2LumVJ6cpsp41Y2C5tV124w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3063
X-OriginatorOrg: intel.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 18 Nov 2021 23:35:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13074

Thanks, I already have these in my queue and would be sent as part of next =
merge request.

https://cgit.openembedded.org/bitbake-contrib/log/?h=3Danujm/1.50

Thanks,

Anuj

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Jacob Kroon
> Sent: Friday, November 19, 2021 12:26 AM
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [1.50][PATCH 0/4] Backport fixes for python 3.10
>=20
> Backport fixes for running bitbake on Fedora 35, which ships with python =
3.10.
>=20
> Alexander Kanavin (3):
>   bitbake: correct the collections vs collections.abc deprecation
>   bitbake: adjust parser error check for python 3.10 compatibility
>   bitbake: correct deprecation warning in process.py
>=20
> Justin Bronder (1):
>   hashserv: let asyncio discover the running loop
>=20
>  lib/bb/cache.py          | 3 ++-
>  lib/bb/data_smart.py     | 4 ++--
>  lib/bb/persist_data.py   | 5 +++--
>  lib/bb/server/process.py | 2 +-
>  lib/hashserv/server.py   | 4 ++--
>  5 files changed, 10 insertions(+), 8 deletions(-)


