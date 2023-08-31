Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC19C83F10
	for <webhook@archiver.kernel.org>; Thu, 31 Aug 2023 15:54:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (NAM11-DM6-obe.outbound.protection.outlook.com [40.107.223.65])
 by mx.groups.io with SMTP id smtpd.web11.1442.1693497275702599801
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 31 Aug 2023 08:54:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=zc1kaD2u;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.223.65, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJVPNQeNXYn7X25UEaTaWPKarKcG4LmPNk3Jn4ugUG5O21S/9tzFPk50Kian9MR+ozMJ1h0Lbaml/yX4jNomWjjmlUqeEivXD5H3eATLMvxVp0mk4Ys5HZ8yGY+kQ1E0SJb0xH7gmr6mPO9BCbXqwMSJhZKEKNm6+0rybjqqIi0LxCqPOwQE+AmJ/5ihYnV7UbdOPvmIB1JXybBegujY/vvofeWHy0wotk09gbIynLZvUlJw2ftJYR9XZYP8BZeNqDqKMbHhPsqCR+P2Yzohm+cUPrhULkaNFMOvGN+UBNrKQy1+uE0gDrH+9MkgVAZkkdBlcrQDvXH+6ketsn5MlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UF+cUr+7z+RD4jdlyEv1l3zgTvp2kJovSeGECfN8EPU=;
 b=lB/CB4fUz72Sy6TaOtU/OpHxeM3ttOww3n7Fl00PF3GQTYH8mFyK1sXYRbaUzIXeYB02vKfCWhzjIlzYPQytBMz4Cn/WoSDy5UdxIgtna7MTb3ivDL/3cl+cg211c42FJ9BwaeQIyBxVTuj4pf/ZtL6joHrwf/naN8Myau+VN8dKC8nPYeSgwSOEKmC8SndaZdt/anP3Y1LiswHZNv1ffvdJOs0ZDiq8On6fpOupIeKN4Z1XIs/G/fz85PdmGN+8UYygh/267ZmI05rXIu4zH37y2iCu/EOv2rHBUpqfARw14wSicUL354ZaW9GkJouVh72dYQNJsy8FtgckqaTShg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UF+cUr+7z+RD4jdlyEv1l3zgTvp2kJovSeGECfN8EPU=;
 b=zc1kaD2uoZn/ST+moX/7W7yvTX6f+1ElLfuRowjPhRv1bCfpGkEufyNLQ/JcOsxgWQ2QlJCzPbS8q52Ch3pOtR1mgfzhRqGr/iw/vQys0u7o3fx20aSEy327BxkrSDg+77lJ22eEijEolJGuElLpht1VeWkvYRK4Ej19uKlUfbuMT4FJsd77OtWnmPIsW8OKEuot89+sdbEqzol5gdFaVc2Mh8ebOrwyEW2WIaErOO1wuCptNuwnznfjZJMT8E+B0s7iHlILg1gvLZXrzVaNIWhHK9l0fAr5vvqsfd+gykX6wYtqRbgxYJQSSLR6gUU/dZkldzDpmR7brrZ1aM7DVQ==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 BL1PR12MB5850.namprd12.prod.outlook.com (2603:10b6:208:395::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.21; Thu, 31 Aug 2023 15:54:31 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::3d4e:d9a8:d060:9ec2]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::3d4e:d9a8:d060:9ec2%3]) with mapi id 15.20.6699.037; Thu, 31 Aug 2023
 15:54:31 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "JPEWhacker@gmail.com" <JPEWhacker@gmail.com>, Richard Purdie
	<richard.purdie@linuxfoundation.org>
CC: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] Bitbake overrides optimisation in the datastore
Thread-Topic: [bitbake-devel] Bitbake overrides optimisation in the datastore
Thread-Index: AQHZMOY9sw9KSr3rR0GkjRHBYxrw0a6vxqOAgVYa1jA=
Date: Thu, 31 Aug 2023 15:54:31 +0000
Message-ID: 
 <DM8PR12MB543065CF83FA3B4D5453D11B8BE5A@DM8PR12MB5430.namprd12.prod.outlook.com>
References: 
 <8f03e675ecb19ea938428c52431cd1fc384b5cb3.camel@linuxfoundation.org>
 <CAJdd5GZKqXyETj4trusWAz2YyXheWeUj3p8ZLCwMz0NhJrnqZA@mail.gmail.com>
In-Reply-To: 
 <CAJdd5GZKqXyETj4trusWAz2YyXheWeUj3p8ZLCwMz0NhJrnqZA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=1603d7a0-72b6-44c1-8a71-f39fe2248d41;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2023-08-31T15:41:40Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|BL1PR12MB5850:EE_
x-ms-office365-filtering-correlation-id: 4b3ec755-e953-40ec-326f-08dbaa3a90d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 RshBnalSRdH8UivZi8Nt22uSfvRxiyImGSnUsYKZNLU2Ww/ewDQwFb0LAYAyjF4f6STUbULDkQtBjAv6Hb7PxBARphWWtB1h0ktnQRcwIZAeZaZTJfAkurl2Z+6/8YHpm0Boc1b3fF6M7Q/p9T58B+ZDxDLXQ27gaejTlguALQfakGcCbQNtxo4OOERBB/d0W/nBn0mGa6A5UEMPvI8E5vfPXD9vWVigXDeSLsyjjlRPeYeCjC1f1FkzSoSip2zHyHr8vBaaDR2B/oiC+9h4Q7PZ/1PsmT57Vu+7BuaPO29YA7p0M0mK49O5CadThh7ZhMU3PBPX/ekE/r1QOd/7SB2WUpUDN/yb5YL3b2LxfnSeYLF1dVAHwkFFPqdR9tUd/4WGhh53PoMVYx1DzJT5YDUidf2xIR8mxAZE5guQtOgL1TRlM7y3aLwJ7rOBPAp7Jdo8Az03MpygRKyQ6uqlbGmWVHQ1B6jb1ozTtFy4Qx7+X0dpLK18qvwGAzJCM0jaEb1K+k5VSYAShqLHSG0ngzoks5TjZlCi9IReaGp2D4JsOpWhRF4vyqEMGZBjQ3b4sMiJIaKf1PCItwHzlWx+Zt7mxsHzf+V+vUwSjWQK5Bk=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(396003)(39860400002)(186009)(1800799009)(451199024)(55016003)(45080400002)(66899024)(41300700001)(33656002)(38100700002)(38070700005)(966005)(26005)(76116006)(110136005)(83380400001)(66556008)(66446008)(66476007)(66946007)(64756008)(316002)(478600001)(71200400001)(2906002)(52536014)(122000001)(86362001)(5660300002)(9686003)(8936002)(8676002)(7696005)(6506007)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Va9AdCwTorI6WfLJh9E3N3ghxUjTYwyQAFQxFWm81WphwDfB8RazK/o/Lsun?=
 =?us-ascii?Q?jOMcj38Lx9vICVEv76fMCU4pD8xLy7X1L0O/TChxISsY7jr/wQ1euk9Amo9N?=
 =?us-ascii?Q?qJu74wHL2gahE81S7Y/R6es60u7kK50kpKjJjlCS9JlI4Ijy2fk9yIOxsQ6h?=
 =?us-ascii?Q?O5lgAPOqiIVY2R4Z92npRVeQkmmVs6/+zBtOzpYb5agEMZ6xwdTaqnXXmmLg?=
 =?us-ascii?Q?c3D28q7U4YlEL7WoBI4h9cWDOudh5pMSZL0rc0qEIX1G/eQYerOsbMUE+L2r?=
 =?us-ascii?Q?uN1hHMlZ/kI+ozlCX2GteNPWUWSYWomjM+L2NJYtUKEGSvJhxEC8Yb+9cCwg?=
 =?us-ascii?Q?rIj/VzcAKaM3BxPW7DG8HlwByGBlnwSES9mf9LxkwJl+NB1oiuaF3xkD8vdq?=
 =?us-ascii?Q?g2E+pIYsy7gTAQwLWjqODpS5SzEbqr1/vSlMzF39g6JjGP36KinT29apxV4s?=
 =?us-ascii?Q?5LuU9K20vVFywT3SiWfq07FT3vla/R/wLOHFYj+rsgMZIMZy29ecRkk7yLuq?=
 =?us-ascii?Q?41UVq8XlGrFxd2xYM9dyka60lYql7mJwTbV8uPd29icE13yAU/MnAyYC/3i+?=
 =?us-ascii?Q?SXSgmUc1xZUKlzTSkfCMpcmzJHDfpEoP13yBSIulM7hIQQLvV6KJHI9R86Gg?=
 =?us-ascii?Q?zwMDOe9zffaKsTtbttR3FD5H9L71BTR6M98EHkTqEYDkKR01DhK4XFNtE2/u?=
 =?us-ascii?Q?pNl6g8m1CcqpiKxEvz6G8i7WfPk6E/u4hBVFxls/dvybLTluwzUWDhKiydEn?=
 =?us-ascii?Q?MI9yZScK1feMf1mjDBWg21s3XSj3EWZ6qRk2Kej+zl6zkZwImFCLVxbi21d8?=
 =?us-ascii?Q?XdcP+eKQBJq3cNjUHEfrjoBFWatR79sBWWNjZAgtUbsGFTJ8FegCWwIW9Tzx?=
 =?us-ascii?Q?1D5fMcR4EddqNy9g04EThNapO0e7JR/whqxNBvWLdtIuA0DfEG5ARCNYNwE3?=
 =?us-ascii?Q?/IXshsqa2BHT8G2+de8ieVEnnIGymKwds5ws2A2dL6IzVtYXKhD4PZPOvck8?=
 =?us-ascii?Q?tdP5BsxJiR2YXocUHoT6YCYAKUvkGN5+YuP1CjvakKITTmK+Fgx78WkXf9eg?=
 =?us-ascii?Q?oJP/g5fkmcXUaOT3u88LyRh7u7NNWkeFazos+iwvZ81MVr261PVPygBT69n3?=
 =?us-ascii?Q?YXMYf6TIhF4xGFSY3Uwa2XqoWymogYxCs6wLt8esBO/TXed3u6AFQYm4es6j?=
 =?us-ascii?Q?hXXHL+vpHnYeNh4XBlDtrUO5Cuwz+2hHWgDNZ9VZhaNG+elqCmuBwsiGlqa2?=
 =?us-ascii?Q?ZE50KeLzb1XP45e0zC6L2+0BCetZWJEE2sTiMqTeAYdU4VlwToXaZ1dq7V1p?=
 =?us-ascii?Q?ktnMeB/s/lfGaiJ3I7NMrmtLyjaBW6OoSuNFZor+kFO4YjMPA4VnfbqK/QIo?=
 =?us-ascii?Q?VvlVi5ldleNZGlIrX6B/HxzjpSVNICl5jgeZO2VF/e2XEEzUTh3zBJaQhv4m?=
 =?us-ascii?Q?+dk4FIs//SbAv4M0M0e9K07mlBOFCAcQTTyM39dOkv2y8PXrby/fBcjkC4di?=
 =?us-ascii?Q?47gkjmDVAqWPm+hMwSB7wsDOUq8wzF95dAuuxyWhT+x6N8QGqQYWysux47V/?=
 =?us-ascii?Q?nqFDkTaTuRPjs+fZl9nPLhpQggwig0FdNgsE+kTL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3ec755-e953-40ec-326f-08dbaa3a90d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2023 15:54:31.7638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iVIegbNkmg9OF6wsGRzy1YD99EqmTo7UU0aiFs/5uedoF+s4uZXNuV9QsTr4ZnEPVvymhRKqXeAtTkR4lRq8YP6Uk4nwFq8vMUO9LXkno1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5850
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 31 Aug 2023 15:54:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15001

Hi Joshua, all,

> Ok.... I think I understand this now (maybe...). My gut instinct is to us=
e a tree
> based approach here; basically use the requested variable name (e.g.
> "RDEPENDS:${PN}") to find the starting node in the tree, then recurse dow=
n
> the branches, efficiently culling out ones that don't apply and accountin=
g for
> priority as we go.
>
> I've written a little demonstration script in
> https://git.yoc/
> toproject.org%2Fpoky-contrib%2Flog%2F%3Fh%3Djpew%2Foverride-
> cache&data=3D05%7C01%7Cchris.laplante%40agilent.com%7C093557944d2849
> 8e646008daff2b6637%7Ca9c0bc098b46420693512ba12fb4a5c0%7C0%7C0%7
> C638102859137208260%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%
> 7C&sdata=3DdpmfZo0rf5r4bjuxiKTvi34jAqXXoMT%2FErOPGM8S%2Bn8%3D&res
> erved=3D0
> to sort of give the idea; maybe look it over (especially the test cases a=
t the
> bottom!) to see if it makes sense.

I find this idea very compelling.

Has anyone put any work into implementing the datastore itself as some kind=
 of graph/tree? It "feels" like it should be possible.

I think it would be most similar to the task of implementing a spreadsheet =
formula evaluation engine. Spreadsheets deal with expanding arbitrarily com=
plex formulas. The expansions can involve non-deterministic procedures (suc=
h as getting the current date/time). Seems highly applicable to DataSmart.

My testbed would probably be bytebraise (https://github.com/agilent/bytebra=
ise). But as it says on the tin, the goal of that project is just so that I=
 can better understand bitbake internals by reimplementing them, then ultim=
ately feeding any improvements to upstream bitbake.

Thanks
Chris

