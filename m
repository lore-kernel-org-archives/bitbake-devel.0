Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA479C87FCF
	for <webhook@archiver.kernel.org>; Thu,  7 Aug 2025 18:19:42 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (NAM12-BN8-obe.outbound.protection.outlook.com [40.107.237.63])
 by mx.groups.io with SMTP id smtpd.web10.3147.1754590781284833805
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Aug 2025 11:19:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=Sq7nwk+K;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.237.63, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oNROOIDnxWbpjLUDoI5N1ChI3HOHwgVZfH17sdYSJasy5S+M3xqG8A3mbHbYaEwtiYV4ltIVtCfzFs4XpkuCgMCfkKyy5j3ZwuGU0S3FdZobNze/LnxA+iugQje9nBlYDVN1XJ82z1kBi4/RPYiRudLWBlMVs4Ol9IO0DzarKHrSPUVNtRfNdx1QbmBqF/NIcnf9hhravELQrpWuIwBK1GJ4ELnluVGj2yAszqrQuasvYuIVsuiFs+tEwU2makjtRPssv24eWubeIUNq7nGyQSJJt298G1iYA2iOcz7IalFuLbccLw0vClCYKcMckdAlBbdInFFO+DfVk58sCf1JNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LO4GYYPL8BKvdbbobQ7fAt6qSIY0F3kIejgtHDwpJm8=;
 b=UcGgC0QjZ7+LqJ53qy0/PkHRzuwDbc9ZdolFNii2BNhuojj6DImotATsP0D2DPl0DbNVPT/c7HcRTE+GSo6Atm6Q3bq1myb2NQoqvf0NS1SKEH5+ijTuRPz0Oq2tTbwdpqdg4j9fAhT/Z8Wo0eWClnaoflLoN/mAS4FtV+MGZO8YRmSovurPYiBdpr2WBUy7sGeuc9wvzDqWGDCleKR29q+miBl8h75NfZpUPOHnuiwdu+gvdnik2Xy9pQ154f+I2iTft4oVD1eYwHIpzvmL+AxP8xBBxZabzeeGENgO4YPUpoagBCMkiLI4N6hld8uvtXPhoXBN9A+eq6sTlEIACw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LO4GYYPL8BKvdbbobQ7fAt6qSIY0F3kIejgtHDwpJm8=;
 b=Sq7nwk+KFZ0RXbTeazMga5hINZC5I5jz9TN4X6jpGlPlLxCiv/RgfDuiQp2UZI+KaeknMbWTZhUQA2g0ml6bwZK4yQdHMUrkHdyho2dKWnHSvGJBHp65IoCD4xXeh/IwvWdzlJ4Mm0VmjbypKvRXdcfj0Ry1WG/In0FuCoBp7PHRk2ylKLQ5i+0D66KzQDQUlDD9bLtJjdg0g8B4ikolvqeSzl74sHjT0GCb3dmwl9iG7o6wdQ0B2iMvv5N+aovPFQQgA3lgOcj4RXMrWoEnvF+7heNVjXSaDLLyeWgS/G4SVE4qpW/axynyDpAIKiTR9Fe7cwIiR1LYVoqE84UIHw==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 DM4PR12MB6398.namprd12.prod.outlook.com (2603:10b6:8:b5::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.18; Thu, 7 Aug 2025 18:19:38 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7%4]) with mapi id 15.20.8989.015; Thu, 7 Aug 2025
 18:19:38 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "mathieu.dubois-briand@bootlin.com" <mathieu.dubois-briand@bootlin.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH 2/3] event/runqueue: remove unused 'd' arg
 from check_for_interrupts
Thread-Topic: [bitbake-devel] [PATCH 2/3] event/runqueue: remove unused 'd'
 arg from check_for_interrupts
Thread-Index: AQHcBuHhvp7hYqECbkKF0bUxeHKY8rRWxoEAgAAAf4CAAF9D4IAAWiEQ
Date: Thu, 7 Aug 2025 18:19:38 +0000
Message-ID: 
 <DM8PR12MB543086C02A6B4CDD5D6F680E8B2CA@DM8PR12MB5430.namprd12.prod.outlook.com>
References: <20250806145308.2052128-1-chris.laplante@agilent.com>
 <20250806145308.2052128-2-chris.laplante@agilent.com>
 <DBW0984EY1IE.31I0NJ43GU7N7@bootlin.com>
 <DBW0AL5OM8CZ.1J05XYFYPMZ20@bootlin.com>
 <DM8PR12MB543077160D85EADD9D5654358B2CA@DM8PR12MB5430.namprd12.prod.outlook.com>
In-Reply-To: 
 <DM8PR12MB543077160D85EADD9D5654358B2CA@DM8PR12MB5430.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=488fde4a-3945-4955-b78a-c01914099c30;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2025-08-07T12:51:37Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|DM4PR12MB6398:EE_
x-ms-office365-filtering-correlation-id: ce89f78f-6794-4c6c-abed-08ddd5def889
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?FfPytP1cwxMjEsDD2/lQ8Xax4sSVSSNxL+moI3CPfzJBJSK3AWt/Ps+qH/+N?=
 =?us-ascii?Q?XW8UelaDYBqEVy/ZPfdKcSA9KXCEy70l3NsDE/NmerIaKI3FueBTzn7U+Gei?=
 =?us-ascii?Q?cJRyH82GkQHAYy5Tdy/a6QMiOCaOWX4+ZKYh1pthTtHlPAO0inaeSIZQcP+j?=
 =?us-ascii?Q?6JRSITVM/Rt3Eg2qddNC47QuATtDL2lDwTWdgn6xpMlVC1IOFmohXmC3mFQp?=
 =?us-ascii?Q?hBGueLn5sGDdbdtGp0gC2zMVvJ4RAq7l05AYTiMJtpakUlPPOfcfInM/OBeP?=
 =?us-ascii?Q?Ab3CFIVwqA9LrOlRXfoLxS1dFRkHg9FQtqNXJNkujq91MvX0OoZH0uz8IOBD?=
 =?us-ascii?Q?AQ76hZAY6GC2B/iEdczdoMJc4wjMyQ3W+riAYzxhYgDaocm1fnDxOiFzJXGt?=
 =?us-ascii?Q?686yLQP2ScicKqQJcV9N2dPBhoehTLM9hd9HRmOiuT3S+YLxaqN9J79cOGHF?=
 =?us-ascii?Q?qTG891XEriQzQOvwPvT9NJ2HHqfXa2g4/mhFghkhVSzBRh6e1vNPqCexWidD?=
 =?us-ascii?Q?+tKKUSYLOuOUaQimvm5SdgcGB7jjPWTF7ahyERpdMLw+Qix5DErNfYDSxfDN?=
 =?us-ascii?Q?2lK4/pybfDZRBG5Or7ZOFOycCE0o4RkVoWURp5azEfDj/lUwpw4UCPAaNOd8?=
 =?us-ascii?Q?bs3VK03BKa8d0dWtb9iEIzcid5XBBC1jVclPfyQsmtIQh44oModzctO6lCTa?=
 =?us-ascii?Q?QaIG3ETqYvZCSQuCq2r0Kv56tM5SW1/pzzeU5lJ3BlaKQnqpDZ9Sgphwyujx?=
 =?us-ascii?Q?39hzG/9ZyYFPCbaJu7Hjnb9gZHZ2fYxt9C2i+3GHwyeDEwQ/kOzZM5ZDuSM1?=
 =?us-ascii?Q?Shbdy+YrjYFRJrGFpK8tKMFGgQbyGQ6CR4DwtD0UIlSraW1WZA2OkI8+DsMT?=
 =?us-ascii?Q?BYdsmvahKBpZ5Cpyrgjtoi9Fb2z/pESq2e9pWxVjLYIjFVS1uerWqYICWtgm?=
 =?us-ascii?Q?iW32MZ5Y796ao4cU/8IHTWrccbj8wlLz+pcqX4gTyNusSqyV3hEQtvipcNLY?=
 =?us-ascii?Q?ddaGw71MzN01Qd7BTrCfstjQuTyEgIYdWUjylfmnjxlHoxhOMvXdW3BasqOe?=
 =?us-ascii?Q?srkj2uKxAihu2LB5FtqCQZSK1IZzGd7CkSWihQBzuB0KJIgOwl3e32DlmEoo?=
 =?us-ascii?Q?6FEwNlo9rKk+fHCAFQflz6m7PmmaDl0SUbtACQOrzERM9QAHT3rzhjhsVYu5?=
 =?us-ascii?Q?YHE0tYP76aQ3MxF/dVGDuy1umNImVipsCUGDY//7CK5HkpKTvayUfW8K8h+e?=
 =?us-ascii?Q?GP3FMP6hpnr0rvszZoaAF/mlP8FRL595AGaiE+9KVgrM0YXWys9NJd81HNlx?=
 =?us-ascii?Q?MKCn1Is3QUyruFCkSn+AB6mBKd4oA3YqB1ddrQlri491iWWwx7em3DaIoE+a?=
 =?us-ascii?Q?On3Ms6fjDwvGdt28I8VjkI/YkOCT5RjXmZwSxbDJhdcfFbyNMtQ916Pu+Akl?=
 =?us-ascii?Q?UP3DuDAq44E=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?EJDmAq6vfGuCE6vIXTrpCXJui8RSVk8yB3waD4nCzRTFvKm9O97gHZ4oer59?=
 =?us-ascii?Q?SjNibS3qCE9Nio4Tq7ixmBhHkrOpcsr5ATBHuyCO98ib5MF0ixMC3EOh7jvR?=
 =?us-ascii?Q?1YLAnsZAkk6tKpIc0gvWOAizky0OmsbE9dFFiEv9cfT3PFkoLl0zg2nl/eGT?=
 =?us-ascii?Q?6qIFt1Dnzyt3S5SssPPJudoNWXOtjUPHRHQ0iJzbITR122F3yUaVOz5d7oEV?=
 =?us-ascii?Q?73zmFL5A0nhqgW7wOhk1NwJIfEmWyvN1tfJn0NYRrXFbbtHtmYRWG8OGXqUH?=
 =?us-ascii?Q?pI5KUK/E8MAoa0qsTDgfLQ4pGanjARrA0BFWWJ0PUwD3fV/gZ+ttzW6dQ+Pa?=
 =?us-ascii?Q?Y85LfY16Gqv0jm/7c/fLz74xkJO4Bg4zmWqGtx26KnTxIgfpc9IWAk11/UMv?=
 =?us-ascii?Q?od1a+7T3rQo9fsW8VPty5KNPN55vt6UqQhXNNAA/vhfOg7cmNAIdq5BdjIE6?=
 =?us-ascii?Q?O+9WGkok3i/Jz96IIxO43L5uAMvWDksgxWG1tflENsFzRPD0Bt82jfdXiCjK?=
 =?us-ascii?Q?aUK3TXM//LVN8+cOhIyoifYQlO+RLvl21xj4qx4hqALQhRU7qG/nLeFNMrGg?=
 =?us-ascii?Q?zFlh5LSokF9jfKMop0w3PtAvcJJ6IT+lJbVizYBvyYlHBPPhXfhdBc7sSG1z?=
 =?us-ascii?Q?H0+8Gl3/O/o/g82/Mw0nWQZChWW9Ta42VdLjjjvSOOpqEsXeMZr8zo8/IQ73?=
 =?us-ascii?Q?dO1tMQHy0+KPPTixNwDC0F2t3tzJcWDknA2m2cutMDTs6CktMAjKOQfBiAW/?=
 =?us-ascii?Q?RyhsxFpIBeToYoEdJeNAUTxG3I4Sq5oNjyuNBMDlbUOBCMht/4pmQttyoraZ?=
 =?us-ascii?Q?ip802ERaf09UEc5txPDKL8/2FzQpZkAOOpLtrnhUZzArrS8ImFHE8tbJRC7f?=
 =?us-ascii?Q?R9N8qfLj1VICZsYhBla8pM2SjiqaaTmP1m6CNYMxZjKxk+YoD2QzedumcWMn?=
 =?us-ascii?Q?ZjIMmleha9YEHeaUos62WuF5X664SOKD+0sBhmb/+a0mWZeYUPJGzRZcM3HD?=
 =?us-ascii?Q?edpvMEMjdOn1F8o4nRGu3wi9k0yNZ7ULSXpvGHf014XWUgdakPptwFajrLVX?=
 =?us-ascii?Q?3tEAYKil/ZCd6GD48Pum0ahO/sEn4rdIfS2iftqouLktIjTe/jcAvJic3UYG?=
 =?us-ascii?Q?xZZUW+Rx6t2S8dAA8AaQojUtjbfTLO1YaxRFjMpLpmFomH3eMH9OKnoivmPx?=
 =?us-ascii?Q?0YekhaK+NnLUBL4aHwu5ZKoUjuROVqKTqaJB8ErFKhrpZ5N5GB7dBHprJpDI?=
 =?us-ascii?Q?rxszJloh27SW7fZ6rSPFRPa/NInrvUAyeezQp1Qc/C2PDri+hhFdp2BXB2h5?=
 =?us-ascii?Q?sbXcz2nmXxuBR6na5xHgK2W9tTWo6bIVdHSMl69lIhUQNTUJSi1P7XRpBVL+?=
 =?us-ascii?Q?evcJZRcQ6/e++oEKs9DCp7JGocjY54gk9wpyZrNVsGiOjYClKZoJ5qnTXDjC?=
 =?us-ascii?Q?PAdawriyPAUfoQF0EgLC72gZvdcemWLcqUkrZF1Fj1Nfj7KNEbQ5CyABCubN?=
 =?us-ascii?Q?WWHTlcdFJwlgGdO6Zfp9ApeS2N6JgndmbK56m1ylup3vln70/i36nG+o4cht?=
 =?us-ascii?Q?soswuwUjgXv3jpJsuEYlJwCsCXO2Ackiw8yU8apO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce89f78f-6794-4c6c-abed-08ddd5def889
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2025 18:19:38.5640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JzSvGI13ilL/pFvRA8XpnEgUb25bhc4y7XAqPMyiV6fyHcviktJcSYv2RJi9wIXT4VSMSS+/5gP6RP1E1SyG3wYNMP/TyvSKjNkNAKrbbeU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6398
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 Aug 2025 18:19:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17847

Hi all,

> -----Original Message-----
> From: LAPLANTE,CHRIS (Agilent USA)
> Sent: Thursday, August 7, 2025 8:53 AM
> To: mathieu.dubois-briand@bootlin.com; bitbake-
> devel@lists.openembedded.org
> Subject: RE: [bitbake-devel] [PATCH 2/3] event/runqueue: remove unused 'd=
'
> arg from check_for_interrupts
>=20
> Hi Mathieu,
>=20
> > > Hi Chris,
> > >
> > > Thanks for your patches.
> > >
> > > It looks like this is breaking several builds on the autobuilder,
> > > with the following error:
> > >
> > > Removing 12 recipes from the aarch64 sysroot...ERROR: Execution of
> > > event handler 'sstate_eventhandler_reachablestamps' failed Traceback
> > > (most
> > recent call last):
> > >   File "/srv/pokybuild/yocto-worker/qemuarm64-
> > armhost/build/meta/classes-global/sstate.bbclass", line 1301, in
> > sstate_eventhandler_reachablestamps
> > >     bb.event.check_for_interrupts(d)
> > > TypeError: check_for_interrupts() takes 0 positional arguments but 1
> > > was given
> > >
> > > ERROR: Command execution failed: Traceback (most recent call last):
> > >   File "/srv/pokybuild/yocto-worker/qemuarm64-
> > armhost/build/bitbake/lib/bb/command.py", line 123, in runAsyncCommand
> > >     self.cooker.updateCache()
> > >   File "/srv/pokybuild/yocto-worker/qemuarm64-
> > armhost/build/bitbake/lib/bb/cooker.py", line 1653, in updateCache
> > >     bb.event.fire(event, self.databuilder.mcdata[mc])
> > >   File "/srv/pokybuild/yocto-worker/qemuarm64-
> > armhost/build/bitbake/lib/bb/event.py", line 232, in fire
> > >     fire_class_handlers(event, d)
> > >   File "/srv/pokybuild/yocto-worker/qemuarm64-
> > armhost/build/bitbake/lib/bb/event.py", line 131, in
> > fire_class_handlers
> > >     execute_handler(name, handler, event, d)
> > >   File "/srv/pokybuild/yocto-worker/qemuarm64-
> > armhost/build/bitbake/lib/bb/event.py", line 102, in execute_handler
> > >     ret =3D handler(event, d)
> > >   File "/srv/pokybuild/yocto-worker/qemuarm64-
> > armhost/build/meta/classes-global/sstate.bbclass", line 1301, in
> > sstate_eventhandler_reachablestamps
> > >     bb.event.check_for_interrupts(d)
> > > TypeError: check_for_interrupts() takes 0 positional arguments but 1
> > > was given
> > >
> > > Can you have a look, please?
> > >
> > > Best regards,
> > > Mathieu
>=20
> Thanks for catching that. I forgot to check for usages in bbclasses.
>=20
> I'll work on a v2.

No v2 was necessary since nothing else in bitbake had to change. I sent a p=
atch to oe-core to fix the above errors: https://patchwork.yoctoproject.org=
/project/oe-core/patch/20250807181256.2693568-3-chris.laplante@agilent.com/

Thanks,
Chris

