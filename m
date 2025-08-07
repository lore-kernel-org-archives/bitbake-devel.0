Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8EAC87FCF
	for <webhook@archiver.kernel.org>; Thu,  7 Aug 2025 12:52:40 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (NAM11-DM6-obe.outbound.protection.outlook.com [40.107.223.67])
 by mx.groups.io with SMTP id smtpd.web11.51538.1754571158688644371
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Aug 2025 05:52:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=po4aJLEs;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.223.67, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9skU/RdNlbChjx3xP+r2xJp8e2oP9/VRbWysTGZ0o6cHel8dnr1EpmqD0rIK+yFgHW0nX9/vU+e4HR/4iiMiJUVKkYwnbEeETdV1vkLRm6g3WLKg5gCHGtlKBLaEXcqOVmXaiinSzMMlcehaU7OyG9c3AXfjtHqOOYjhO9oHoq+KpCHDnOGjLs2OsDz7tg0ngKzlE/7eMU7HYxuiXz3ctFjR/J/Sro23MDevLw+huCgYb0nFiEH5dkZTKkYoIVPg0dEhXKfHT4gERhVWC5eRlzJeD2ZsRnRJQa4ATzn24Ds8ivJVkgAfZ1WrMkhmUa3bo9TpOuaUTYkI70fDFfwEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMpeAAZRyKBsGBWTkSH11B02Sb87KEiYkenW6BquPW0=;
 b=nYPnhSHKtOwj2kRPs5x2qlXF0xWafRygdzyslDnBxC2EpaFPPBtNVYOYMKW9UA/R/PfhiAtsFZoBsxQggB6WRrg9uK0G4pDEtMxVHU8wQW9HckE/MQo+sLuT9i2s+uau4g+6mhCupyasFWR38znrjgDCxtsUCgCIDVesKaLrJSMKd6r17orqY18bGYEhmn4HSkjOwk3pw8zrfFWjOFM54+o5RhlakrPP+gFRV+se/mzbiJ/qamWrAjfkixiqEkGiNXAGmCYaH381r9UH0RqDfWQkT3lSXOvzIezapvotMGDoWOXFM4uYtdzZ42h0lX+kLNcUPIR3gvuUCykrG70A1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMpeAAZRyKBsGBWTkSH11B02Sb87KEiYkenW6BquPW0=;
 b=po4aJLEs503RnNfuk70vAm5i7eK7MxAI9Z/NeMkIJT3a0AU1dsTDwQwJDul2no5fv4WZzAvO4GMQBw/60icy7t+AKGxTCH/Z6SOnRkGWTC8ZKaWnVrkwMAm/+ysI44Gz+YYUxIRSCrG86In/dXUruNGdIx8Bt195pmDIzu6vvwwyVU40z81daLrp+Y0ZnyfLIZRQ+OSIh+rgUuBkRilJCj9z0/G+fW0KJMi3mhchCoad0pRjH55+ACwwUkORCuABuS0MzFqKvPNOVkizCoJUpM+u25+ylkpiq5ktgkrvYY4kvq7FdgFvI/YA3VL1TGOdU3exbM3oZRCjJxbDF6lqQw==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 IA0PPF64A94D5DF.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Thu, 7 Aug
 2025 12:52:36 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7%4]) with mapi id 15.20.8989.015; Thu, 7 Aug 2025
 12:52:35 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "mathieu.dubois-briand@bootlin.com" <mathieu.dubois-briand@bootlin.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH 2/3] event/runqueue: remove unused 'd' arg
 from check_for_interrupts
Thread-Topic: [bitbake-devel] [PATCH 2/3] event/runqueue: remove unused 'd'
 arg from check_for_interrupts
Thread-Index: AQHcBuHhvp7hYqECbkKF0bUxeHKY8rRWxoEAgAAAf4CAAF9D4A==
Date: Thu, 7 Aug 2025 12:52:35 +0000
Message-ID: 
 <DM8PR12MB543077160D85EADD9D5654358B2CA@DM8PR12MB5430.namprd12.prod.outlook.com>
References: <20250806145308.2052128-1-chris.laplante@agilent.com>
 <20250806145308.2052128-2-chris.laplante@agilent.com>
 <DBW0984EY1IE.31I0NJ43GU7N7@bootlin.com>
 <DBW0AL5OM8CZ.1J05XYFYPMZ20@bootlin.com>
In-Reply-To: <DBW0AL5OM8CZ.1J05XYFYPMZ20@bootlin.com>
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
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|IA0PPF64A94D5DF:EE_
x-ms-office365-filtering-correlation-id: 5c18134d-6abf-48b2-d6ba-08ddd5b14871
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?tcyaaIExteKvJxnwyS8FgNrAGaKiJKrtsurBz8uk0BIV5+EYqc4tELxtX1uX?=
 =?us-ascii?Q?ZoK+Hcqvf3EGtupnSxTwes56xuxt9QM48GNVCf/+uDy/G5eavJZwrnZq9lVj?=
 =?us-ascii?Q?ndeKU5edHm/oqJP6wF2B9gaJR+pcliMlYlM8XaTTQlR2C3qFQkqHvQQw2eg/?=
 =?us-ascii?Q?aUZn6w6Fygnss/iKDVjUtcNmJpBB+cJCTN0WseZFPcJoalp6nCB8dUCI2X8k?=
 =?us-ascii?Q?A5HAbIRC37+EX4iHfb42CvMWSI/98z66ZDVJfPZ+zKAV4KGDe4vWPge6kvia?=
 =?us-ascii?Q?vdFSopMu4ugIVUS+zNKHte89tiDN1xF/xDY//7+HfYLgK95kP0gHtB0dEeVF?=
 =?us-ascii?Q?55jbZrKpKtDRsI87lMJbElCs/18Vd5Tn+7XtRXTa+0iol4/nvL8H1QdDqO9x?=
 =?us-ascii?Q?ulj6bJTloEW6IP1Z94idw6MUcwAD/CQtgw9O3EbhACVuROVbzSIlRaXVtRbF?=
 =?us-ascii?Q?dlBcYGJ2ECoKnL1QTV7nFTXP6q/p+bM2gCfelf0+vBzbblzJj1IDubxDNHjo?=
 =?us-ascii?Q?zVnJQVKSRC5/kTIhTxqKTpll8NQHXoNPMuSO6pKFCQP/5vTAMwgs6vbW3wqe?=
 =?us-ascii?Q?Dkdv8RbW1ruT3aSKa70L0c5bpAasgwoqqUBrFKCMdfrzBu8J/3NnnQplYuBd?=
 =?us-ascii?Q?xt+rfK53pHf8JjGszO9/MkUKOltDwwY6yTIvju3tJZrH5XkF6hNONfKOcOwN?=
 =?us-ascii?Q?JKqIp5u47KbeKnFR3nmoU21kYTr4ik4YZLk8k5vPTZd3oV/CrRhXMWq0iCkO?=
 =?us-ascii?Q?8tN1D6YDbp8WsgCfkUKsr93267XEjDv1DcuRRP+gOYS51EKbSeiIcPVNh59d?=
 =?us-ascii?Q?qIpHYqbNkRxTUR5iUaXm4sYCSr4lhXk95HcMXPCx1zQONXOf6Shd28uWrFPY?=
 =?us-ascii?Q?hJ5+1AIAPX6kvCz52uALqli326CbzWKyDzMVs1DrrN0V8XGKRo9PSBJamoDW?=
 =?us-ascii?Q?5RVHrSzA42VynuT9ThnI/TgIoZxKYbdVnCfDoCA/6sluy1Yi/qdcRcPObn+v?=
 =?us-ascii?Q?jsP6+Db4/nQPi+9iULIGAe4c0TtRKZOaLXP2QvnlSffl8PFPyHYhdD1pcrVn?=
 =?us-ascii?Q?7iZS1ftZDRXAaaf0NXiNuy0euloQtIe3acPAvzhBQ60A7tbzRC6sVRX5j3oQ?=
 =?us-ascii?Q?Yysrwp1DnIDZb7JiqiLoFTjGj4UPcWxH3K6YPJulfBpo5i/5Qm3LPLPzNLxE?=
 =?us-ascii?Q?kB00R0Gwa9+XoXOYUXd4D30tRELcUoT3z0jK9u7TC8nBWShnTzS+vnsiU4mq?=
 =?us-ascii?Q?eutw87gIBWYS9y0IP+zd88QgXe4o49IDk+JAYrHxUNf/2hdY1i0isrJqOo0R?=
 =?us-ascii?Q?fahkHwuPvcPkYp+m2iPFX9HvvzLQxVuZE4sfSRbCQFQjs1YZ8/HqzA8DJsG0?=
 =?us-ascii?Q?SnGwmP1RmID8c0rOx2YuQ2Nkyh+/uBUl7p9Y29VMSIxkj51UCUVOUt4MoKeW?=
 =?us-ascii?Q?+iG4rNeinz8bg1MOkU+uq/PuWLLO7Mf5yzMKqhcNq/zXQGhv9LS78A=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?ZI3bbFCNgePhNfmtnwH3AN+RDYloSYOPgqqBG1kpTD0idhxDbYz8Sg53UMn0?=
 =?us-ascii?Q?OJXbqenYjCBhhB3IxAOjYdXmC4ck4QJ4t977RBIz1olKzmmcqnaCxOxPMBMm?=
 =?us-ascii?Q?XiiC9mXAvBw721yDcvCE3SU8AAsRGxNJeRjB7Dz3ErkCMBC6+SYunz1s+9cW?=
 =?us-ascii?Q?kH1JOnx1anV9OKMB5uF4FCW9hP9LiCi7a0P/HL3VIKSYUujhQGq9ZU9aVnc3?=
 =?us-ascii?Q?RjqJydZlgzUrT1itLnlMOpCvCBhKVM98BIMUkSIJ2Ya7Ju0zXuDyr3HtYYVM?=
 =?us-ascii?Q?9gcJjEJh4lwxNCmBzDsvdnSdrJJlnQ0I/0Sgy/BqTivo17NMNWcUU9jrfw98?=
 =?us-ascii?Q?IfGxy/OIWRMvmIUyJDT9TnZ8WyrWYp6BvsXF84tv9wCE6b4E7s9jD3Tr5ATX?=
 =?us-ascii?Q?5gkIRkgRgBuB1JeFgekcyPrMBksu95FBRbHBQXdfGj5J1ONHIqvHdHXuqG/5?=
 =?us-ascii?Q?QPG6w1Fgi5p8qGqTIH53CesraYA/H4d5tNPZxG6pSUw/aNNUDewE/P7bgsy/?=
 =?us-ascii?Q?SSlRCtIwwuiLnCB8Ttm9Z4++k8K+xCngUkLaSeEnTrBKRMWnCQ496JfYQ2bt?=
 =?us-ascii?Q?lZzcbEx5HDox8fH1VsOTYWWlbyD95LbGZvUBYe4A9ZTfyjhwPsSZflqwH19X?=
 =?us-ascii?Q?EFWdB0fbqMLfoHxUCp3pTj4F/yy6ys0YEqKTqiQhXougqp38Ipcuh+iOATbS?=
 =?us-ascii?Q?JeyARMGiwnoVxAzvi6u6xxKdSWpAMpi2c6sjgOBed82EUO+j27pz9xoGtbrB?=
 =?us-ascii?Q?SDrppQWCa/703TbSRYKE9FFq73LaC25xL8eQn7hvuUYDxMlQaMaIg0TdzpvS?=
 =?us-ascii?Q?bNbxA3Wl+EU0Ep0w8BVxKAZARBWr5GkzopQB9J8D7b1PHOZOmPMAvoqb61VN?=
 =?us-ascii?Q?vReMHwDDz1YxQC+eTYii6GhWZApWbY2fYPvrvO2r7aVUVRTlBh696Nf2+Ts9?=
 =?us-ascii?Q?r/rjDeYbl+1Yh1O4b/MBb/rcJyHNcFbycuzm7Zanhm0sm0jY8Ac0mw4kTlFP?=
 =?us-ascii?Q?RY6T4EkwrwEp8F+yEi7jSQI5ySYGe28zi8CIFg1SsBoFvLJuMmuf97lM10JO?=
 =?us-ascii?Q?TXkBohssV2PLkWeY28AjA13bNMUTOOXNdoTHGz+KA1cvGbsdTZSR0ieU5y/n?=
 =?us-ascii?Q?5X2GsZ7p6R+vbsquDVFqSKRSPAKAiWyZEKU1icueoqJzEwljnKfnbUYp0Y/K?=
 =?us-ascii?Q?mmEkVxERrfuImNJE+RL5fJ0oNAUNzLKBoaDa2zLgnPRtkS7aPJkOsKfpm7tw?=
 =?us-ascii?Q?kGeEyXb8pHcnuzsafBOCvT2s/IXFbbSaGOA7kAkt70Aq5H8H+x7qYj2Tcse2?=
 =?us-ascii?Q?wuEo/PNqF+3OqBpKPBNVJlELle+bXjz6QssebNFdqPBmtkJtu9w0eoiQyeE9?=
 =?us-ascii?Q?W9GIG7/VBUvTfdJtNoipberzq4ir17IeTRDwRYmbsKexDAkn7xvQPB2eCOOM?=
 =?us-ascii?Q?n1GMvInzsx/hHOG825c7y4E5gn7Hd/vINBNJWgxomxjzr6vMKhitSgr6IV3n?=
 =?us-ascii?Q?rDcQHP2VJKLR1AsIsYt00+qhNhpZiLeLY+KrCkexALm5eqiFJGgAEmGlQfmS?=
 =?us-ascii?Q?kerFP1hr2ezQI31YAFdZnp/vt8yor3qS3bVbnIak?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c18134d-6abf-48b2-d6ba-08ddd5b14871
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2025 12:52:35.7445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1fJOBOp9mDA4b51uoTv3cRV2Wk5GPDjgdBhJIuDnw2onnsTpV1n9loYW1ANLTmpJfgvCLkOb877M1CsaaUe8AjUsAyK7BxMSAZs1rF1nSlE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF64A94D5DF
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 Aug 2025 12:52:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17845

Hi Mathieu,

> > Hi Chris,
> >
> > Thanks for your patches.
> >
> > It looks like this is breaking several builds on the autobuilder, with
> > the following error:
> >
> > Removing 12 recipes from the aarch64 sysroot...ERROR: Execution of
> > event handler 'sstate_eventhandler_reachablestamps' failed Traceback (m=
ost
> recent call last):
> >   File "/srv/pokybuild/yocto-worker/qemuarm64-
> armhost/build/meta/classes-global/sstate.bbclass", line 1301, in
> sstate_eventhandler_reachablestamps
> >     bb.event.check_for_interrupts(d)
> > TypeError: check_for_interrupts() takes 0 positional arguments but 1
> > was given
> >
> > ERROR: Command execution failed: Traceback (most recent call last):
> >   File "/srv/pokybuild/yocto-worker/qemuarm64-
> armhost/build/bitbake/lib/bb/command.py", line 123, in runAsyncCommand
> >     self.cooker.updateCache()
> >   File "/srv/pokybuild/yocto-worker/qemuarm64-
> armhost/build/bitbake/lib/bb/cooker.py", line 1653, in updateCache
> >     bb.event.fire(event, self.databuilder.mcdata[mc])
> >   File "/srv/pokybuild/yocto-worker/qemuarm64-
> armhost/build/bitbake/lib/bb/event.py", line 232, in fire
> >     fire_class_handlers(event, d)
> >   File "/srv/pokybuild/yocto-worker/qemuarm64-
> armhost/build/bitbake/lib/bb/event.py", line 131, in fire_class_handlers
> >     execute_handler(name, handler, event, d)
> >   File "/srv/pokybuild/yocto-worker/qemuarm64-
> armhost/build/bitbake/lib/bb/event.py", line 102, in execute_handler
> >     ret =3D handler(event, d)
> >   File "/srv/pokybuild/yocto-worker/qemuarm64-
> armhost/build/meta/classes-global/sstate.bbclass", line 1301, in
> sstate_eventhandler_reachablestamps
> >     bb.event.check_for_interrupts(d)
> > TypeError: check_for_interrupts() takes 0 positional arguments but 1
> > was given
> >
> > Can you have a look, please?
> >
> > Best regards,
> > Mathieu

Thanks for catching that. I forgot to check for usages in bbclasses.=20

I'll work on a v2.

Thanks,
Chris

