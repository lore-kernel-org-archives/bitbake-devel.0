Return-Path: <danielwa@cisco.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EC2C43458
	for <webhook@archiver.kernel.org>; Fri, 26 Jun 2026 20:35:03 +0000 (UTC)
Received: from alln-iport-6.cisco.com (alln-iport-6.cisco.com [173.37.142.93])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.43707.1782506097030565485
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 26 Jun 2026 13:34:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@cisco.com header.s=iport01 header.b=WFvVg+BH;
 spf=pass (domain: cisco.com, ip: 173.37.142.93, mailfrom: danielwa@cisco.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2366; q=dns/txt;
  s=iport01; t=1782506097; x=1783715697;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=K2lnGhe3VKCf0NaOVgFBhD+Q0cfgSFNl9sHeSHdl30A=;
  b=WFvVg+BHSIuMr+1EGtv0NXxQ2ldqArAAsFwXSl2DAjPnxV8+9k9ZmDc7
   4FzfVGJsX7TTk8gyIQ1QjdWQz5QC0yI+zo7bFSfkMz9ZIIs0sMvvHo5+Z
   sKigh4A8Q8no0cPn6BWJLVmivE4ZHXz66Mp7lJvqSPzlt5hhxhGN84sPD
   siE8AGzJBapW5XxEjNiNr+RxWXrAnEwrGgD/tCuzwlW0JxOQZKfwDJZ2c
   uW36XJ9U1IT8/f+0XUoARIw94vk2Ut9hw9rXVLXt0xWstMkF35IK13o7/
   Z3Nd02TgSeeT8zbH6IXE1rgwxNm7MBWWJUSUaUtAEWo2TxSCRMQRlxIsf
   A==;
X-CSE-ConnectionGUID: vT4X3FLiTymyRkYeBXXDrA==
X-CSE-MsgGUID: Ji+ug+PwRCKbOjcomIC8eg==
X-IPAS-Result: =?us-ascii?q?A0DhBAAK4j5q/4wQJK1aHgE8DAILOoErgW5TgQqBIUmEV?=
 =?us-ascii?q?4NMA4UsiHyFeoxVHI0uDwEBAQ0CLgkaBAEBhQYCFo01AiY3Bg4BAgQDAgMBA?=
 =?us-ascii?q?QEBAQEBAQEBAQsBAQUBAQECAQcFgQ4Thk8NhlsBAQEDAREREUUQAgEIGAICJ?=
 =?us-ascii?q?gICAg4XChUQAgQOBSKCYYJzAwECrV0BgT0Ciip6gTKBAeA1FYEKLohbAYFwi?=
 =?us-ascii?q?QInG4FJRIRAPoJhBAGBXYNbgmoEgiKBDIJIgVCNBQlJeBwDWSwBSwo1DDMuQ?=
 =?us-ascii?q?kMDgSlLBTdlEj8hHS0eOQI4BwUSIBEZQUUjAyc0BCE/OE4FgVwCaIEkTiMfA?=
 =?us-ascii?q?zl/gTGBI2Q/JxUwNYEBAS8KbEIkJgN4PTcUGwQ9jWoXD4I2OF2BMUCBBS2WY?=
 =?us-ascii?q?a4bgT4KhB2MIY0+iFyFSKURiDuQTakXAgQCBAUCEAEBBoF+JoFZcBWDIglKG?=
 =?us-ascii?q?Q+XNsY7eQI7AgcCBw4DC5NlAQE?=
IronPort-PHdr: A9a23:fiRgFBZDhq/AeQlgws0ez8z/LTAchN3EVzX9orIuj7ZIN6O78IunY
 QrU5O5mixnCWoCIo/5Hiu+Dq6n7QiRA+peOtnkebYZBHwEIk8QYngEsQYaFBET3IeSsbnkSF
 8VZX1gj9Ha+WXU=
IronPort-Data: A9a23:YkwsGay0T1+n9bRJmMN6t+drxyrEfRIJ4+MujC+fZmUNrF6WrkVWx
 jcZCm3UbqqDZDf9LdhwboWz9U1QsJKDxtI2Tgc6qFhgHilAwSbn6Xt1DatR0we6dJCroJdPt
 p1GAjX4BJlqCCea/VH1buSJQUBUjcmgXqD7BPPPJhd/TAplTDZJoR94kobVuKYw6TSCK13L4
 4+aT/H3Ygf/hWYqaDxMscpvlTs21BjMkGJA1rABTagjUG/2zxE9EJ8ZLKetGHr0KqE8NvK6X
 evK0Iai9Wrf+Ro3Yvv9+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+vpT2M4nVKtio27hc+adZ
 zl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuoNcrLZUj2CCe5xWuTpfi/xlhJF8KYb1D1MJ2PXBL5
 MYbGT0nXiCvncvjldpXSsE07igiBMDvOIVavjRryivUSK59B5vCWK7No9Rf2V/chOgXQq2YP
 JRfMGQpNUiYC/FMEg9/5JYWkO6uh3T7bDRwo1OOrq1x6G/WpOB0+OezYIaLIITVHK25mG66p
 yHb8CfBHSsxF9a4yzGC91OH1uLAyHaTtIU6UefQGuRRqFeS2mYaCxBTWValrP2Rjk+lR8kZL
 FQZ/Ccrp6U++EGnCN7nUHWFTGWstxoYXZ9UVuY98gzIkvGS6AeCDW9CRTlEADA7iPILqfUR/
 gbht/viBCdkt/ueTnf1y1tehWra1fQ9RYPaWRI5cA==
IronPort-HdrOrdr: A9a23:fY53+6opB9JqrFCoHn4vGEoaV5stLNV00zEX/kB9WHVpm5Oj5q
 OTdaUgtSMc1gxxZJh5o6H/BEDhex/hHZ4c2/h2AV87NDOW91dAX7sSnLcKpAeQVREWl9QtmZ
 uIHJIOcuEYYWIK6foSpTPIbOrIo+P3sZxA592uskuFJDsCA8oPnmUJbzpzUHcGODWubqBJba
 Z0k/A33AZIDk5nFvhTaEN1ONTrlpngrr6jSxgAABIs9QmJih2VyJOSKXKl9yZbeQlihZM5/0
 b4syGR3MiemsD+5g7X1mfV4ZgTo93819tFCvWLj8geOh/shgyraIkJYczDgNkymo6SwWdvtO
 OJjwYrPsx15X+UVHqyuwHR1w7p1ytrw2P+yHeD6EGT4/DRdXYfMY5slIhZehzW5w4Lp9dnyp
 9G2Gqfqt5+EQ7ApiLg/NLFPisa03Zc4EBS1dL7vUYvF7f2W4Uh9LD3O3klSKvoKRiKr7zP1t
 MeV/00qswmK29yJEqpzlWHiObcLUjbWC32AXQqi4iyzyVcmmx/wg8zwcwSmWpFybcGIqM0ut
 gt9s9T5e5zpgh8V9MgOM4RBcSwEWDDWhTKLSabJknmDrgOPzbXp4fw+6hd3pDgRHUk9up6pH
 36aiIRiUciP0b1TcGe1pxC9R7ABG27QDT208lbo5x0oKf1SrbnOTCKDAlGqbrsn9wPRsnAH/
 qjMpNfBPHuaWPoBIZSxgX7H51fM2MXXsEZsssyH1iOvsXIIIv3sfGzSoeYGJP9VTI/Hm/vCH
 oKWzb+YM1G80CwQ3f9xAPcXnv8E3aPi66Y0JKqiNT75LJ9QrGk6DJl+2hRzvv7XAF/jg==
X-Talos-CUID: 9a23:OaM+SG+Jk0MYOJbwfryVv1AoRvB+XFnc8GbVMnW7OGtDeI25U3bFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3A2nq9nw12xHI1pDHwcEKUBWNpRjUjwaXtFU9OqYo?=
 =?us-ascii?q?8kOqOEi57PDK8p2S6Tdpy?=
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-l-core-03.cisco.com ([173.36.16.140])
  by alln-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 26 Jun 2026 20:34:54 +0000
Received: from alln-opgw-5.cisco.com (alln-opgw-5.cisco.com [173.37.147.253])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-03.cisco.com (Postfix) with ESMTPS id 539E118000431
	for <bitbake-devel@lists.openembedded.org>; Fri, 26 Jun 2026 20:34:54 +0000 (GMT)
X-CSE-ConnectionGUID: MXLkkk3qSDid7scSERZSHw==
X-CSE-MsgGUID: 3gR+8lAbSxabm1ThV8ABvQ==
Authentication-Results: alln-opgw-5.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.24,227,1774310400"; 
   d="scan'208";a="58699697"
Received: from mail-westus2azon11012007.outbound.protection.outlook.com (HELO MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.7])
  by alln-opgw-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 26 Jun 2026 20:34:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cl4fJpaioeW5EdqHqlWX17k5yhew39dHCnp1Ae5kSBI+H0mUvIWVKdH19OpZc8z/6NywGYUYjb9H+3UtjmvshFCQGM9qHU0KTgRekjO3Ngq46icvBuj4VGC/Mh/CMdgRaQknRfeRnEyCjkhW9LE15F0PNfY2WqP6T9x1mtqns0d+XaLVtY/eXfrh5egmV9TI8QF+O2BoG8oUMwcMrxeWVczOaKvbDfX2+CgUZV+J4qqbFzkCTyNrAuPnbtYbG1mMI8CAQJ4WyfEz36CAP+Cy5uMeyWiCtQfZNdlNwFnHuGo0F6l7Grd9SmNlioIKYtGyKhEyKc0PJ8OwBJBzSza9Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2lnGhe3VKCf0NaOVgFBhD+Q0cfgSFNl9sHeSHdl30A=;
 b=VHD9k28uBugjyuJ5l4Q7uXgekvlD/5teigSJJwaPMbS0QV1GjLW9tUtgSrIZy4lEdnDipQaGZ/UgStmpC+17zaPZuREV6MLsQ4BEU+AmzTl4n+nZiQrWvRY30EJuksAqrk5A8R5tQbiwwyzZABI3+bdimjI1H5EUFmJ0/WRaZWGieWNBDxugEyueyxACbgaULkQptqPCcm9fikxOyCIjJ2TeGkJROF+BplHj3MCOGCsMwkQkGPBCojLpzBRAPOock5TH4KUzLrO+UxYfn8if5ymmzYn3oVE/1nIFpqL84wCadaGOdmIbKUktwqd+7ZVjoQatHNEpCVmSQn25OfRi/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from LV8PR11MB8770.namprd11.prod.outlook.com (2603:10b6:408:202::19)
 by CH2PR11MB8777.namprd11.prod.outlook.com (2603:10b6:610:283::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Fri, 26 Jun
 2026 20:34:49 +0000
Received: from LV8PR11MB8770.namprd11.prod.outlook.com
 ([fe80::ca15:f6e2:7255:94]) by LV8PR11MB8770.namprd11.prod.outlook.com
 ([fe80::ca15:f6e2:7255:94%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 20:34:49 +0000
From: "Daniel Walker (danielwa)" <danielwa@cisco.com>
To: Bruce Ashfield <bruce.ashfield@gmail.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, "xe-linux-external (Internal Group)"
	<xe-linux-external@cisco.com>
Subject: Re: [bitbake-devel] [PATCH] fetch/git: add reference option
Thread-Topic: [bitbake-devel] [PATCH] fetch/git: add reference option
Thread-Index: AQHdBas7kwckKxSEL0y38RDCvTLR1g==
Date: Fri, 26 Jun 2026 20:34:49 +0000
Message-ID: <aj7iaF9eu-G9w0Wx@goliath>
References: <20260626191028.162111-1-danielwa@cisco.com>
 <CADkTA4MVj9Ja806ja_0y7zo2J4sFdOvvUbm2_aR3tcQig4brvA@mail.gmail.com>
In-Reply-To: 
 <CADkTA4MVj9Ja806ja_0y7zo2J4sFdOvvUbm2_aR3tcQig4brvA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR11MB8770:EE_|CH2PR11MB8777:EE_
x-ms-office365-filtering-correlation-id: 547a1228-e8a4-4bcb-34a9-08ded3c25e83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|38070700021|3023799007|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info: 
 yBfheJzv9ucGHd7Cy5miW+VBCzhamWOnCR4d1JaF/vpggAYS6Dp2gBMQsfBArXP66l9qk9NebTCA0gOdnU+WoV1odKtODJdcX40m04badzSG0C8Y/ZjY0qUAyvf/jG+aenxFIXqu7nWSurUrJ6pY8e5pRLxfQkRHkSAz0cxuJ8OWaTXMJqwU9+4nd7/rLbWhD6jQtZLULK5IFET7LX/lUTbukMW9Calpotd5tkwn1MXpG1tsnwyJJ6s51YmXhxmjGR8D1h9/l1UbjJ2vV976Xl4kJmeD2iDtNwTDpxDc9X4RZGtLB5bLaragbEdvtll2ueIDAfh2yTi2YYlMMnw1/3YhonSIsHbBqq57I7NVSEcraujnVsuvpXM3pADLEMvG1YaA5j3RxEf8A4v6ZrSlZS3XRLN0Y1Mw/vHHAS8Fns65pWov6o/CPvDqPWCMpaX+edEfATk3h9NlEZ7TW5C39ShbXa5JBGjmj6rxyKUo8Jrq0IzVOJPlZEKRfI8YpTAubcSrNJI8wk+Mn4wUrNwnhVm53fhD0FoKpDUq31xqSNQUvZ3KvQ9hmV6reaYm0C+VUjj9Q+9l2ImVem6slNFb4Y/CBcDM2oV16D2Wi6+vpNgGxLA7s6h9kRz1y+A9FmKHLwRrsaWybLGyWVfqSDbu4SH9rr4PBW6dlSMkr1JyxShdrNLTkWG1t9sZgXUU9JSPolpMyHfZY4oRVld0Xr8IXKoqswEvuuq03VWZxoZd/28=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8770.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(38070700021)(3023799007)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Wm9jbjBFalFYTDR1SCtrK3hSUUlBSXJZT1dXTTFGWjljcnMwNFJpdlc4bVBm?=
 =?utf-8?B?ajZBRlE4ZUpJTHl1ZmZtdCs2SjZvZGpQMjhrYVF3d2gyNU5DOHp0TFVkMDJu?=
 =?utf-8?B?cTFmNTZQWWRpZUFxbW1jMkdHWkZ0S1V4bnRGUlhweHpIOWdhSmhWdDZKYkxS?=
 =?utf-8?B?NG5hWnZjYWhJRFkrUVl4U3p5bnVBYzl2bmtpdU5ReGlFREQwVUFsSWJtSWNT?=
 =?utf-8?B?L2Q2dDBXR01ZYVk1RU5BQ003emNLdHVjcmN1Wno1SHBvNy9WbWhWVHVCTmdZ?=
 =?utf-8?B?a2lNcEJ0dEgwcG0rOFBFSFhsQkkwak5heDFBWlVaSFgyais1U3pnRVFtTURK?=
 =?utf-8?B?eGJtblhpSzUxVjlPUkJoSFM5Qk5WOEt0d1dqVVYvNCtDdnZEZVJZOUc3bkdi?=
 =?utf-8?B?M001UzVpVjNEQ0JqR2JNUTVGcWVxWDROZDZzcU93bjFvMWExVkpxSGw5OTRx?=
 =?utf-8?B?bUF3c3YyekUzaDdMcEc1Q1JRZmhmZnZ5VXRCdHdtMHdXZy9yQ0Z5R3ZsMVhI?=
 =?utf-8?B?bzlFQkw0UE5WNTlmVlRnMTBZaUp0R2ZjdnlVQis4MlBCeHlUcFBySDlZOTZ2?=
 =?utf-8?B?aENqMHRHNmdMQUtMak1pZTNXaDV3dWNuRnVuR1E3VytlaUdjVVM2WEVveGRt?=
 =?utf-8?B?NFVtN1NFNjY0UlpibFNnY3VMS1kva1hLL0ZCS0x1WkY2dXcyaXNqcGdGSnRD?=
 =?utf-8?B?YWp3czdGZjhReGw0SWoxMFhrRHBEZ1Bodi9mWXh1T2paKzU1ekFhck9vWTFz?=
 =?utf-8?B?TmkxVWROVmQzQTl3dmtNUzFJeU1iWlhjUmk2aGhwNktMUWdMaWk0c3hUODJN?=
 =?utf-8?B?dXRRUjYyUE5ZbGVGL2IraDJYckgxVVZKVnlMY0hDdXNKZndQbWptUEhUQ2Zm?=
 =?utf-8?B?d2c4dkQ1MG5BaVhwSDVpM1pBU3QrVnNSQjFpeDc1T0tYdFQyK2lMTUpYTXFr?=
 =?utf-8?B?dFNXOEFubFRsV2phTkEzYi91VldTN3BxQ3Yvb2R0RUdkN202QUVzUlROWUtI?=
 =?utf-8?B?WU44MjZYYUs3bmx3L1FId1VrT0QvczEwZGFMQkFwQTNEUVE4Q3VhTTVCd3ZV?=
 =?utf-8?B?Y2lqVGFEQ3RNY1ltcUxMcGY1MnZWUVZyeDNMRERzQ25iUmVOb3l6enJVdDBq?=
 =?utf-8?B?cVRnV0x3UFZXQlQ2YkFkczhpaUdpeUVBNE1nZTh2b2crT1I4NENLcjFHZWRn?=
 =?utf-8?B?K2dZeWhuUjZ5N0Vqbnh2QkxFTURSVWZiWkhwdVlMVmQ0anFRZ05GVkR2a0V0?=
 =?utf-8?B?MWtDY25oNkt2ME54M2dsYUlIZ0NLeXhtMGpxR3krZ3IzaVVKcVhndThWdmVM?=
 =?utf-8?B?RGdoNkhmUFQ4SzFsYitMWFQ4SnlUTG9seWVld0hSVW9OeEhPNzNUTjBOSkVS?=
 =?utf-8?B?ZnNCc2wwNEVzc2VYL2V4b2Y5b0xneEtkVmFKeFdSc2lBMGw5TmQ0cUUyemtj?=
 =?utf-8?B?TnNmSFJIYVJOcVVnZk8zQjFBUS91VG5QZW5lQjVVb1pyTlRhL01xc3BxRnQ1?=
 =?utf-8?B?Qm5KMFdXTlJKV2RDazdZeEdJNDI4dGE4Q0JyRnE3TnErUkdpeE9uaTBjVmhX?=
 =?utf-8?B?MUpTUEd1c25mVHZUSGdFOWpoR0FxZWYwU001NW9GSllVY1FpOHZmTUZKNU5N?=
 =?utf-8?B?NXFnMVdnZENmVThHSjBmOFU4TklvVk5GdEUrQ3h4emYrZy9ST014TEF4MGtU?=
 =?utf-8?B?bVUvSU5XSFhnbUI5eTBIUWtHUjB1bW8yTXdaYmdQMEV5VFdpRkVrVHZha3ZK?=
 =?utf-8?B?dFNpemh4dllMWTR2NFNTLy80aVFkSEFieWxaZExzek5kcUNGaFNoUkVhb1lH?=
 =?utf-8?B?TUpBRXBFSjN1dFJWMGhTSC96VE04T2pBVFZXcTczaGdmWEd4MEFWbWNHUU91?=
 =?utf-8?B?N1NCZkJQeHp0aWtuMzJCUjlyS1hFT0tMY09QTFFKdTdib1lINDVRbTBGTGU5?=
 =?utf-8?B?SEZYazRJSHd1bzVlekdjdGcyZzlZdnJjUWNuM055ck5kd2U0R3F3bWpZZFVj?=
 =?utf-8?B?NTlQTjdKV3BpaUJTc2xSK3VsRXhQT0NhUmYzaGdkMXJHd1lRRXRjbVF0SE9P?=
 =?utf-8?B?bjhFTXNwSGdHbGR5b2hsenFGbzZWVFkvSGl4MFJKdkJGVXFUMHRWQjJoSy9H?=
 =?utf-8?B?ajdkbEhpbUFKRXpjVkozV0hzNXVtU2RITGVqOTQxb1h4dU1kZm13UnpaN2NL?=
 =?utf-8?B?WjRSOFp5TnRJd2ZtUmpIVzAwSTBSRnpXQUlCWmYxQnRPNWJuTlBKYzhlWEox?=
 =?utf-8?B?VHhObWEwR1B4VmpHK2pkK25lZW9CY1N0d3E1QTByQzE5SFQ1TmdrNmNxc3RR?=
 =?utf-8?B?akNLdUpjdTVXcnJ3V2l5UHIvKytBMjZhOUZjdnhUMWVqbDFYdnN6Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C38CDB49EEBD6B4E820003010F6BA6E4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	busofWs8OeBRlrh/8N05K1TTiVf35qkeBjVULoKF3wyoagYVRAcZt5NgJ0HLcFTFynMIDB38f9u7P9CFjeI/hk5+qjXVIbwlKvUnmrEy0Aag+vwNqBY7QlcuJd4doMT4ORggVi4tDwZW6ljT6KO3S8BG5gTFJRPY8z2D1uHvxxRc8hsroLHJ0wL9qnkN5PPjWnElPNRE9HQecZ/i16XVkk6VE7C4yZbSwIuSYl8fh7YjVV85Px/MaW2JWF6CUorgQKTBOk26qRPzl8/gUkQRpe7l6+yRGkhB0pAME4IJ5/HRZSdquuXFWhsT0X6gKMXhhdnyQO1l/ZA7JtVqbPgzLg==
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8770.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 547a1228-e8a4-4bcb-34a9-08ded3c25e83
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 20:34:49.5369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vMsOP0nx3TFWHpQNt7NBTVhamUaCZZM/94yvD9+ELA9Gr/JcaQRT6+8sfP7CVIJBBqPM7RPmQidHx4aLfOJAbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8777
X-Outbound-Client-TLS: ANONYMOUS;alln-opgw-5.cisco.com [173.37.147.253];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 173.37.147.253, alln-opgw-5.cisco.com
X-Outbound-Node: alln-l-core-03.cisco.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 26 Jun 2026 20:35:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19798

T24gRnJpLCBKdW4gMjYsIDIwMjYgYXQgMDM6NTY6MDJQTSAtMDQwMCwgQnJ1Y2UgQXNoZmllbGQg
d3JvdGU6DQo+IE9uIEZyaSwgSnVuIDI2LCAyMDI2IGF0IDM6MTDigK9QTSBEYW5pZWwgV2Fsa2Vy
IHZpYSBsaXN0cy5vcGVuZW1iZWRkZWQub3JnDQo+IDxkYW5pZWx3YT1jaXNjby5jb21AbGlzdHMu
b3BlbmVtYmVkZGVkLm9yZz4gd3JvdGU6DQo+IA0KPiA+IEFkZHMgYSBvcHRpb24gdG8gdGhlIGdp
dCBmZXRjaGVyIHdoaWNoIGNhbiBiZSB1c2VkIHRvIHNwZWNpZnkgYSBsb2NhbA0KPiA+IHJlZmVy
ZW5jZSBmb3IgYSBnaXZlbiBTUkNfVVJJLiBXaGljaCBpcyB0aGVuIGZlZCBpbnRvIHRoZSBjbG9u
ZSBjb21tYW5kDQo+ID4gYXMgIi0tcmVmZXJlbmNlLWlmLWFibGUiIHdoaWNoIG1ha2UgdGhlIG9w
dGlvbiBmYXVsdCB0b2xlcmFudCBpZiB0aGUNCj4gPiBkaXJlY3RvcnkgZG9lc24ndCBleGlzdC4N
Cj4gPg0KPiANCj4gV2UgdHJpZWQgdGhpcyBpbiB0aGUgcGFzdCAobWF5YmUgMTAgeWVhcnMgYWdv
IG5vdykgdG8gY2h1bmsgdGhlDQo+IGtlcm5lbCBpbnRvIGRpZmZlcmVudCBzZXRzIG9mIGJsb2Jz
IGFuZCBkbyBhIHNldCBvZiByZWZlcmVuY2VzIGZvcg0KPiBvcHRpbWFsIHNoYXJpbmcsIHJlcGFj
a2luZywgZXRjLg0KPiANCj4gSW4gdGhlIGVuZCwgaXQgd2FzIGRpc2NhcmRlZCBhcyB1bm5lY2Vz
c2FyeSBjb21wbGV4aXR5Lg0KPiANCj4gSSdtIHN0aWxsIG9mIHRoZSBvcGluaW9uIHRoYXQgaXMg
dGhlIGNhc2UuIFdoYXQgcHJvYmxlbSBpcyB0aGlzIHNvbHZpbmcNCj4gdGhhdCBqdXN0aWZpZXMg
dGhlIGNvbXBsZXhpdHkgPw0KPiANCj4gdGhlIHBhdGNoIGRvZXNuJ3Qgc2hvdyBhIHJlYWwgd29y
bGQgdXNlIGNhc2UsIHdoYXQgdGhlIFNSQ19VUkkNCj4gd291bGQgbG9vayBsaWtlLCB3aGVyZSB0
aGUgcmVmZXJlbmNlZCBjbG9uZSB3b3VsZCBiZSwgd2hhdCB3b3VsZA0KPiBoYXBwZW4gaWYgdGhl
IHJlZmVyZW5jZWQgcmVwb3NpdG9yeSB3YXMgc29tZWhvdyBjbGVhbmVkLCBvcg0KPiBhbnkgbnVt
YmVyIG9mIGRpZmZlcmVudCBpbnRlcmFjdGlvbnMgKHdoYXQgaGFwcGVucyBpZiBzaGFsbG93IGlz
DQo+IHNwZWNpZmllZCwgZXRjLCBldGMpLg0KPiANCg0KQXQgQ2lzY28gd2UgaGF2ZSBzZXR0aW5n
cyB3aGljaCBtb2RpZnkgdGhlIFNSQ19VUkkgdG8gYmVjb21lIHRoZSBsb2NhbCByZXBvLg0KDQpG
b3IgZXhhbXBsZSwNCg0KS0VSTkVMX1JFUE86cG4tbGludXgtY2lzY28gPSAiZ2l0Oi8vL2xvY2Fs
L2dpdC9jYWNoZS87cHJvdG9jb2w9ZmlsZSINCg0KVGhpcyB3b3JrcyB0byB1c2UgYSBsb2NhbCBj
YWNoZSBvZiB0aGUgcmVwbywgYnV0IGl0IG1lc3NlcyB1cCB0aGUgc3RhdGUgY2FjaGUgc28NCm9i
amVjdHMgY2FuJ3QgYmUgdXNlZCBieSBvdGhlcnMuDQoNCklmIHdlIHVzZSAiLS1yZWZlcmVuY2Ut
aWYtYWJsZSIgdGhlbiB0aGUgZ2l0IGhvc3QgYW5kIGxvY2F0aW9uIHJlbWFpbnMgdGhlIHNhbWUs
IGJ1dCB0aGUNCmxvY2FsIGNvcHkgY2FuIHNwZWVkIHVwIHRoZSBjbG9uZS4NCg0KRm9yIGRvd24g
c3RyZWFtIHVzZXJzLCBsaWtlIENpc2NvLCB3aG8gd29yayBpbiBhIGNvbXBsZXggZW52aXJvbm1l
bnQgaXQncw0KaGVscGZ1bCB0byBoYXZlIGZsZXhpYmlsaXR5Lg0KDQpUaGUgcmVmZXJlbmNlIGlz
IG5vdCBoYXJtZnVsIHRoYXQgSSBrbm93IG9mLCBpdCdzIG9ubHkgdXNlZCBpZiBpdCBjYW4gYmUg
dXNlZC4NCg0KRGFuaWVsDQo=

