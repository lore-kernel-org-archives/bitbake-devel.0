Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D72C27C4F
	for <webhook@archiver.kernel.org>; Tue, 18 Jun 2024 16:36:45 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (NAM10-DM6-obe.outbound.protection.outlook.com [40.107.93.83])
 by mx.groups.io with SMTP id smtpd.web11.433.1718728604187337194
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 Jun 2024 09:36:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=1B8PawT+;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.93.83, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQaKEL54ZXfSu5lWbW1zF40A2sQn02+F0/K2P3iBnKqR/QCyJY/hXa5yJPaWqdgouJO1V4Fv4ivyu3/Rm86+58/Kad0utfJNeXakCQ9OXYb9+ARItP5/4lyL0NLjhOo8/2X7uCd0EdeguT8EpxA4SKNwVGHDIdHp/LQy4vOcCtboDihYMUHRkAmggEEHOYq4Y0uw9aoELaIK6bZQ+xnIL1BTtnwaYGasGes7oHdvcd4vCkeU2o0t4ncXXGHzT0Agt0PeyUrqnUVAw68g9i38hM4AesL0AIy6ZZbeHKbOwiF4wuRS43rAX59kZsyhvX1Hm/HqbUAt+Va573ZOvz0u1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8nTiEt1hQzqj5ULwPjw79NIQ9KNpyp5dkOTuo1dwR4=;
 b=ZvArvZqYHAS6gNn9LRkoub9FJAe7D+CQ6+ELMWhseYTN+qqqcwpDghtSwIL+adqG7Wj1t/KltL0OTovGX1f4uot3cFexTaRLJznTBxsWUkDj94XUhA5iLM/3jzcyqzXR9XSKVXq+NCNF2RF/xTxymIpCH7LF9x6TAGM/0gf6wM78Eik2YsPv3S2wymplMtzNMceCSBc2vPp3grKBo/3hyNGKkoMURBLfa+rtShdQxY8+/heoZEtWSNOnve8B7pbUzRTdam05//9V2LrnU1w1agzWAjzKAFT++i1x5wKPmAYiBWmN7SZ4F8OnN3qT1QVhJH79Bf0GptIABbEiqKOi4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8nTiEt1hQzqj5ULwPjw79NIQ9KNpyp5dkOTuo1dwR4=;
 b=1B8PawT+7UdsiW9HwrZAbJuUse2EHxZycQLT5QM74okbVeE+icVDOgw9/m5D9pZFRr8QzLIb4IHtkNZbs+VfZDam7Cw2fcJdo0G8Pw+AP8QVIHpasuWwMZPTGnIay6ARPBmKibu8YnwdataEcdQB/hldSOROnkKLMLM+wA5t6zKcsxoNPe6KKC0JRKRGZgBvJNNm7MkNEzqQlUYRW3imfch2GtM6UB6IzFHyrb8XSYvf6RV+dPwAU9vI9jHki6XEKmf7mcoul9YWGu6rkPyxUfNGarB5FDttfARVoT9MJSm3bNDAupOo3f3rCsRZKu1AlEf/L4DxCqlsggB3es6PWw==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 SA0PR12MB7004.namprd12.prod.outlook.com (2603:10b6:806:2c0::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.30; Tue, 18 Jun 2024 16:36:33 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 16:36:32 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [RFC PATCH] ui/knotty: print log paths for failed
 tasks in summary
Thread-Topic: [bitbake-devel] [RFC PATCH] ui/knotty: print log paths for
 failed tasks in summary
Thread-Index: AQHawPIapS/6pGKeAESDdgOaEDjIOLHNuM1Q
Date: Tue, 18 Jun 2024 16:36:32 +0000
Message-ID: 
 <DM8PR12MB5430FE1BDE5343FD142CA3D78BCE2@DM8PR12MB5430.namprd12.prod.outlook.com>
References: <17D9E3841C981E13.27929@lists.openembedded.org>
In-Reply-To: <17D9E3841C981E13.27929@lists.openembedded.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=df634e94-fdaf-4c67-8d26-2b3b695eef37;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2024-06-18T16:34:10Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|SA0PR12MB7004:EE_
x-ms-office365-filtering-correlation-id: c9891e24-9548-47e2-8535-08dc8fb4d020
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?NBY2ge+UzgesRLaX5RgGjBDFlvcfKmNT5XeHhMn4DBfXS+RBd7emvO4VRXkO?=
 =?us-ascii?Q?680kLqjvVfFdxVprTjyHWTCjhskzQXkhK/UDO27bxCtcZZW7c5hW3+EE8a+3?=
 =?us-ascii?Q?sNx9Wtsm0XNIz0PNElgs7hV+91Im/yx/xsdS7dRMVxELsQhzHTaFmDyHVXae?=
 =?us-ascii?Q?p8/GgTWdnONc0yGQQuo/4h9WZlu/FW4yoZTC05l31VSX40787r2WbEHQpdr7?=
 =?us-ascii?Q?7OSppAsvAyE26UmjPUagitb4tHstbrM7nSiTUIOwX34/EQ9UslsM6ynXB92K?=
 =?us-ascii?Q?fjq65hRY20Tagdu/pVIZyYfDmOtHQTfemHFxIhSllVmGz9q/YrFmWdZntA9q?=
 =?us-ascii?Q?E39RPzW8aZwIdK0QckowktCXiXeKGedl3cK1mmbk2VYeUcrAvthuET65ADXY?=
 =?us-ascii?Q?NJFOEO9V8IEiaPyJcI3IeUJLFSbd3ZQnC/Gu8Q9+N1KZkku6GxMOyCO3hnlP?=
 =?us-ascii?Q?2pezVPDa83ktM/Alnx1Un1x2BAAR5ybtE2oaqt7coMEpOi+npnx6xDe0u6QT?=
 =?us-ascii?Q?KRLnlBK2nJB/XYk64KSwdKGnBc3nBEzrVpkkYz7+HFPVMHRHWaIbgO7dVNr8?=
 =?us-ascii?Q?rdQPcBOUOUPmSMonITVtH1j0WS5lirHMowmeR9A36Yy66kwp0ESGe/BR17rx?=
 =?us-ascii?Q?3C/3pTu9f18PHPU+dG9Ar8GykKiGhaEpybyFBYqLgoztzs2EHZBmOCdsoSAm?=
 =?us-ascii?Q?JU5FF7utlItHw/iDC86wy7PdFY1Cor5wTYggzHjLcCjphf0kVH1HamDga6M+?=
 =?us-ascii?Q?YrWHQ+oAAgb0ArwCfm4C+w8qVhTVrqIERpf+sJtINOddJGzIAixIr7tY8M3d?=
 =?us-ascii?Q?6WGae09resSd6PSHKLG/9FpIVbZQa7hcvd2VHEX1TcT5Wnq7xXzHJl5a7Cqc?=
 =?us-ascii?Q?puWckLKCwWhRTJ9cPa1hWsSvWZk/Zcc6JpIx3bRCSCwfpxWFt0CXQvz6nnBN?=
 =?us-ascii?Q?Mp5ZxP05snsnMvls5KzGf37ZI9ZlVVSgW1cbUDHsfLIE+hyvf7vFub0lkPrO?=
 =?us-ascii?Q?5PKfodBn64/Jl9ujSvznBgM7F0bJGfJ2tuOywz1W5y984SGLI3s9rkd/v6io?=
 =?us-ascii?Q?oyRRzu7Y66EfNQ4P8H8SnspsRba9C6VHQpzcIO932wKPgL9gV16Pc3bIhQcp?=
 =?us-ascii?Q?mp8GkRnG2/P/yRmdOWFgtrnIJuGdI9vL1L57Wz1PuDgmR/9WXFfkf3kA12nH?=
 =?us-ascii?Q?OtuLHAte/XPyHsPIez87K3ZzgMnQyX0SB+2ObTFZO2x+LJjOleEKLgXq5Br0?=
 =?us-ascii?Q?AjyjqHX+Ak695y0HqrnlhRk1TJ/kV6yB46JSStCtgcYTnUZJyzifeHzCdEBp?=
 =?us-ascii?Q?TVwgAUkAMrgZqef6tBOIicAV?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?eZr66lWyf7GXRKXdPromKghgsbg7XL6Woz8KZUZETUbpaveO4fjS7RV2U7BT?=
 =?us-ascii?Q?OjYEsvUvY6zuDCiBfIwZCgikUAza21qJJkoOScrrveBQEnLnBiJRfvSZFMr+?=
 =?us-ascii?Q?8Yn5yEuU8htJFWDpSUYzPh066T2nADagKddJFGbTMppMr8VA++oIqh3BqjM4?=
 =?us-ascii?Q?AU2GuaTV3Wz1yLkEpfEP8ndukUIqC7gkhXItwAIEo+cQ9fLygQhBDHcVEeH4?=
 =?us-ascii?Q?if+TuYsZg0GtkCFA0xZXCdXpZWv5KubviZf92EGkbWc32Qq5BTyZpEynn/H1?=
 =?us-ascii?Q?EorLlsnfmVXt0Yk00Z4mWs85QxAr5RyEUG1fTdPzzZXaNWci/8rUI0t8zQEr?=
 =?us-ascii?Q?7KlUj6hYhEc1Iex0a2+qlTcRKtKMXlbkvNAcEk+4CehbIYQl1QmjJNJOpURL?=
 =?us-ascii?Q?B7DYtW3PKC2+jZjt1477d4YJbGZP0xKu3GlJvtu2L3OUily1y1Shc11AkvNx?=
 =?us-ascii?Q?R4rlYl2Cf2bZONlmxj20ty9+0bhkjpM3DCt3TUK044M0M+o4J3SVjcMeOCkU?=
 =?us-ascii?Q?pYOp9K/B8MAgfAZangaqjgtI3h2gEs2DB9WqN5PoP4l/ZZrjZdWRF/qVRtS1?=
 =?us-ascii?Q?jmjPxZbOd05sddgysf3ltcn3I0Mb5a7OlRpdo6WvHfvXlTOwU6vOjWBIlWzI?=
 =?us-ascii?Q?aF/Jrhrag662Nw5pC0VTJEkBnn4o+QPdmsBJpgrS0QaB6Nn7iCRwEtkEX+0e?=
 =?us-ascii?Q?4UE4oikZNXswKiYjIhBoE686RgWl1fVmmEkx+xEe2Ky5mRdJrKtNnGLmD556?=
 =?us-ascii?Q?TVIjt7QjfusSM5J8bsSjP0iyOxz+o/Ajd1DEWqljmw6mEPWtWSkj6zyn3bry?=
 =?us-ascii?Q?CqI6NJLiLOjw9TVeEs0Fpz5rpgfyg7t+nmq206fLCk3unbJMxLZk+xhTPPAV?=
 =?us-ascii?Q?N/W5ST/g8LbF77FGsA1D47Kob3uPnXgCpBr4oT3HB8uk630JHIAcQ+XuOPxj?=
 =?us-ascii?Q?0aVBSBcCMwRWoFYNpm+sGd2vAZEHEeBoEqCDubQk1ACrU86HwpGsnQBuhLB2?=
 =?us-ascii?Q?B0G2tZKf5kXnjydB1uXZnvPln5ylkPh6mOwQUGHYDMmCY1mhdNkwHVdNvekv?=
 =?us-ascii?Q?nYM8W3ldvSNJE7BaNwKC4vbVppnDNr7lAgMNJiRl/xeIgeQ0pXGU1WLLrB/y?=
 =?us-ascii?Q?hHTOnStAf+kKQDnmOc7loZDVHEXVsotkNrToAznUuUmD1Tid7ee9kPiNjrLM?=
 =?us-ascii?Q?FS50ldcs525QWqF+ToLF02v7iwiYSI/jty8DdXgukWCpQQHraqcQLeoi8GAk?=
 =?us-ascii?Q?n4V5nZA8Ce4W5aDj29BnMkl4peOfUslV77uLsXkiGxcKdvKsoY509YM0Wq1U?=
 =?us-ascii?Q?fYw4lJxYIogcyefyZzhH1v1srJ0QQtYEtxCzbU4j6t+f4BgNPRvXoGhXml8j?=
 =?us-ascii?Q?3QUtZm5X9HDe0iABhuJa/IkK1Bml6i9F4jr5JXvhJwKGsoBc6Crsd5nkOW+r?=
 =?us-ascii?Q?RgR2EfMFqvjX5DUbO7fijcj9w8LsUfr7xu2tm8cCIMotqZMEDQfHd62GnnEr?=
 =?us-ascii?Q?m6iXo3PSjuxwI4I+h7QzACn1kn2Pida/EBaboXnIJ1zDXRhGp6FYKE70GTDC?=
 =?us-ascii?Q?DKxmyZ8j/+l+b4GpcsSnSIWa9/kgH0tWAnnvhAGp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9891e24-9548-47e2-8535-08dc8fb4d020
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 16:36:32.8205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xJ7i0Iwr907ZszNu6USlXRMubr9mrZWD/j0dwqEFaQ+cS8XFoNb/JJHLkKPlVWMUWoDyOGrv4PaOPYpvnBONJAszuLsGo+SOa4mtta2EQQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7004
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 18 Jun 2024 16:36:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16365

> From: Chris Laplante <chris.laplante@agilent.com>
>
> When tasks fail, it's very frustrating to have to scroll up to find the l=
og path(s).
> Many of us have the muscle memory to navigate to the 'temp'
> directories under tmp/work/, but new users do not.
>
> This change enhances the final summary to include log paths (reported via
> bb.build.TaskFailed events). Here's an example:
>
> NOTE: Tasks Summary: Attempted 856 tasks of which 853 didn't need to be
> rerun and 3 failed.
>
> Summary: 3 tasks failed:
>   virtual:native:/home/chris/repos/poky/meta/recipes-
> core/ncurses/ncurses_6.5.bb:do_fetch
>     log: /home/chris/repos/poky/build/tmp/work/x86_64-linux/ncurses-
> native/6.5/temp/log.do_fetch.1253462
>   /home/chris/repos/poky/meta/recipes-core/ncurses/ncurses_6.5.bb:do_fetc=
h
>     log: /home/chris/repos/poky/build/tmp/work/core2-64-poky-
> linux/ncurses/6.5/temp/log.do_fetch.1253466
>   virtual:nativesdk:/home/chris/repos/poky/meta/recipes-
> core/ncurses/ncurses_6.5.bb:do_fetch
>     log: /home/chris/repos/poky/build/tmp/work/x86_64-nativesdk-pokysdk-
> linux/nativesdk-ncurses/6.5/temp/log.do_fetch.1253467
> Summary: There were 3 WARNING messages.
> Summary: There were 6 ERROR messages, returning a non-zero exit code.
>
> Each log is rendered as a clickable hyperlink in the terminal. See
> https://gist.githu/
> b.com%2Fegmontkob%2Feb114294efbcd5adb1944c9f3cb5feda&data=3D05%7C02
> %7Cchris.laplante%40agilent.com%7C81ac6523ef43415e28c008dc8f093617%7
> Ca9c0bc098b46420693512ba12fb4a5c0%7C0%7C0%7C638542517027782743%
> 7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTi
> I6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DJSz4jByKq5f5NjguXlR8S
> YS%2BZQ3FoJbz07BKRkheSjU%3D&reserved=3D0

I probably should have included a cover letter, but FYI the reason this is =
RFC is that I'm unsure if we should disable the hyperlinking in response to=
 NO_COLOR being set. I'm leaning towards 'yes, it should disable'.

Unfortunately there is no universal reliable way to detect if hyperlinking =
is supported by the terminal (at least according to https://gist.github.com=
/egmontkob/eb114294efbcd5adb1944c9f3cb5feda).

Thanks,
Chris

