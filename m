Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA3AC61DB9
	for <webhook@archiver.kernel.org>; Tue, 25 Aug 2026 18:56:16 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com (BL0PR03CU003.outbound.protection.outlook.com [52.101.53.24])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.29430.1787684165821789801
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Aug 2026 11:56:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=a8UrIYfc;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 52.101.53.24, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMcv9cUA5+kynIbWmDEN+WF0h4b+R02S6GG6P7nt8U4tYqXV4B3AVPGO/U54AxOS004iYaSVlQHlkLrvNjX6iIxcWXjCMJuSEnVq0pZoURcjne2/AObl8GT1hf0Lo1S+IzekdcihCipbT4c4BKixO4RlvFM3I4BZ4Jlp3LYx86zJfeD7YZ0tSoyKMhLXoOxU7/69hBoVsDbgAWYQzTxxGES92HvgcKYwYr1kZ7N+TRDJfdD9U5TJkzQS/uxHIDKqE0QzlKRQcxE5DWvQsm0rDQkHn48MwBeiIW4Gitj8TCwOHinE34WFwdEZqpK6XOsotiSNqTv+IjO7m/26MdEzZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEPsrG3dtuc3Cxw9/Y9LGYfQPvrhfU89ZftLhoDGkHg=;
 b=Z8jM8wVeHtM/9pyD5on2t0pd36FEUXodrTO28c/4xNDxXdwjrW1E7FqtPxEw7rg3I/obY2Fji7dd5BdYHn8vMZhUE7qUBF8fsh+P6mOtetfkMtoyK413rcZoiqiwuIz4rPUZenAkszEdvzJA/b7L8lwtlPn9F9+pRM8gQKf+KR5Iyv875+4bNzbxMvEX3OTaSUmo0BaNAEbm1tEgfYojUsJb5TG3yp4+fIPagKYykQo3yl/ELsyeJei8Bybwn0RryiMMDklZepzSsnilDBAwjz94hyx70H0q7Tlwuj2PaVZnMvOQE5mglyQnLauQAEcQqdyGh8mfeCht6IpbRQZhCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEPsrG3dtuc3Cxw9/Y9LGYfQPvrhfU89ZftLhoDGkHg=;
 b=a8UrIYfcUJyxsGvhgxAYau01sVVcR6UKKYFYeQzJzBHNmLRVY8ToSg0D4IjMwT1h4l3dQ78vrBcFs+9ETrj986GFhG8eQWmOxpzjiCBZLZOuX5j+KC08LCwqYAkQS0oHQ68ARzb9AsbfdN1USy6WV3/KSu8B8Dy+yGGlEGU4LeVlcPMkZYwvRoQZekqvKRMgRheGPwjxMoxnieCrjU2+v6e16oCqogG1GNCqj4T597ehEJ/6uMgMKtFdV+enY8N0g0Z25IEMVwDB4dIMm2y4i9QQTYM6Wx5oWUlLmhauZG3T6aocbmdzQLtsGSJVar7MwF36T8l96kQD7QOafhDyJg==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 BY5PR12MB4131.namprd12.prod.outlook.com (2603:10b6:a03:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 18:55:56 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::152b:7346:321d:4a2]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::152b:7346:321d:4a2%6]) with mapi id 15.21.0360.006; Tue, 25 Aug 2026
 18:55:56 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "peter.kjellerstedt@axis.com" <peter.kjellerstedt@axis.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH 3/3] lib: remove bb.fetch shim module;
 cleanup fallout
Thread-Topic: [bitbake-devel] [PATCH 3/3] lib: remove bb.fetch shim module;
 cleanup fallout
Thread-Index: AQHdMY96b7k/tzWQW0W/TmDkBQeZsbavF1IAgAAL/tA=
Date: Tue, 25 Aug 2026 18:55:56 +0000
Message-ID: 
 <DM8PR12MB5430D033816F4121D4BB00E38BAF2@DM8PR12MB5430.namprd12.prod.outlook.com>
References: <20260821170624.436725-1-chris.laplante@agilent.com>
 <20260821170624.436725-4-chris.laplante@agilent.com>
 <DB5PR02MB102134543E3418DA8C1C06E4FEFAF2@DB5PR02MB10213.eurprd02.prod.outlook.com>
In-Reply-To: 
 <DB5PR02MB102134543E3418DA8C1C06E4FEFAF2@DB5PR02MB10213.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=22348d46-684e-4df6-84e7-c3399a48c65f;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2026-08-25T18:54:55Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|BY5PR12MB4131:EE_
x-ms-office365-filtering-correlation-id: 7fc6380f-1359-4928-347d-08df02da7ecc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|11063799006|56012099006|38070700021|6133799003|4143699003|10067099003;
x-microsoft-antispam-message-info: 
 ZflcmpwYb9LNcVji2UcrBAYtWKqmtys9f4VVweldF+6lHhdgobD3mv5T/Xt4q8Qp+os7m08NqE+IYzrmINEbOaPLTtg3a3TiR68Ippx5VVk4r0qcX50RgSSzqp0tY8SZEKX230tZnIYbIZhssPy1JoegF9ggYc0Z5LEwxE+PHzseE0R4/3KxHcbERZ8Gc4Mi3ibaM/LwbTvqv0EndkJTvi6uLBlDK30ngr0OEXZCDVtIuElGizgEsEWskHi2gD7UbNJBXyB7COqU0M85+rohusTUhet/qdyZ2QsWTIYnj3urN93W0JlMXGLuGxtO7RKPQ44p3llgkF2GMIBy1V/Ky8/ecc3jFLsNW95fsdNhDd694Av7AixEDwuCU21VPF5BV5Ex4NaTq3t3jc+JufKhALIy5oo5vGvI1kvZ7+zD0AWwVYJf1Odj6TuR6Y2az7ELu2OlcqS97UktAq3qzaGBLQO1tkGDQD1223wdJG1nH1paUuVJN6HU8qqrqpJgnxTTqBKPLlrWskwTa4fpAwylbwcE+T1FavHeL20uUDPyEAELAZMr9ILYGVwcQzfkRULZtJIh6jkZCjsJ3a9Ec6o9ubA3B1veoUcmo45Ly/Y5Rxl7ZCrbJ7h6JNuD36y/hTGzBrjZZJetWfeAZng4RcNBjfzilyp+LLK91uBtWWtEwUdI2Wk6J+NVuZ0dRbOKU0NsPuOesl/ZEd7LbH4+8eT753OvcMGepApypPL5DReAppU=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(38070700021)(6133799003)(4143699003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?km3+d7sk9jKX/Ed87Gj38LTZPl022arflSMb8Wn7UfqKxojyFgjjtpCT6Kaz?=
 =?us-ascii?Q?9kWZdZ5N+ZzuRRm5nfVq9uT4/G4eOtK35Ew0R2BjCDSIdW0ICURnKHFWs6T+?=
 =?us-ascii?Q?yFvV1To+iOuzvWMz/iiOOL586sDZitKm3SgVvSPh2gSKGBKAEJENowAIxhTS?=
 =?us-ascii?Q?tEBCL8GusywsvbcpW7HX1z+flxClwS5ttSoGCez1oq9FYZt0COBz7TbhVkIR?=
 =?us-ascii?Q?KafYWDCvSDZK2XniRBVJQDWsLMDQ3cTDlV9Helr1YO940uKkfhn7ktqVGm9t?=
 =?us-ascii?Q?9KCX/Qm7jRdsiGXUMMc5wtjZ4wy8FnpCFSXtE3WkMj77H/ZkMSI5WXYcQDS1?=
 =?us-ascii?Q?whVHTnhjallMjJpETkhT1oXQ/Xa3a5GJFRKDpEv2e46AsQjRVI1TQFM8JQHD?=
 =?us-ascii?Q?DTXnqvPRz30gBXs6WL2zPl4P+gCgeVqGZfNldntMSkhVvmD8r4A4riVR/gv4?=
 =?us-ascii?Q?77T/58wJs7ocTmO2bjlNK9GUQpOXdvE9i8JUnNR3ApwHSG2UUlk7USMpilrf?=
 =?us-ascii?Q?aC3+UdZ/i2VXaVn+05ztF0eiDjOD5Go7sV/qlIZGkL+PVE+WYwve5CmAb5oe?=
 =?us-ascii?Q?d4hjv9pd+C7oRlUUzXp1r4KUaGfSIB90rl1tieiQ8QniJNZJE5Doro5cKNwL?=
 =?us-ascii?Q?dgktt1IBHqLIoLL5ZsOCuYga0vMEmaciDs23ieUlbOPnR+a3YwIlzAOUxRj3?=
 =?us-ascii?Q?x3znMxJaub/7/9WQfE/1zWg8UU/dpVIHWjs9fmZnbrqjZSqGb3oBf7JoCZaf?=
 =?us-ascii?Q?aaunq+i2HGTSXgs5cqHnvZZDRZKjGBQjw0EGJcRJ+dt+gkhMq2CqfFhtmip2?=
 =?us-ascii?Q?1Ji8FQwVREc/eEdfKyZk0XGYK8l7R+ujGL5YK1wSY7QmwTVsXz7gTgMzWB5M?=
 =?us-ascii?Q?D/aSfRmA7cYIbIxoKEqMksSM+gsQ6gUhalL/5Mhmf8+LMxONdbpRkd+fbRxk?=
 =?us-ascii?Q?NVS9i1VR09ECszBb2lZ7pNUHHL/TSnnnWaUIqAp7zLN8EKhivqQ0Uml27kM0?=
 =?us-ascii?Q?KG6vbnNlgzuojL6McrBTpTLv4cJXZr/30O4T34ni7xfP/3wXo8RNiylmB3Ap?=
 =?us-ascii?Q?ulAq8aUVe7dJDHE+1ya4mDWJ3aPcnfUVtV5hD//1Kwj7LSJO4vd/9K1n6cFe?=
 =?us-ascii?Q?srao+ZI6hSDCK/vaY9hP4i4C7lxD5nH4AWISZNLpjfKRNc1dMjNeXCaNaBgX?=
 =?us-ascii?Q?VuqigJfHtNaWzT7ry996cs3NbEG6+x04fuW0IUtXviIIpElHo/pJv/OPcEpd?=
 =?us-ascii?Q?OTFAJJmQGmWB46QQhH34TaiCPb5vhRTe/G763V4ppgG7qgN+cV6pfAW6ibaN?=
 =?us-ascii?Q?fuYTu6nc0EyXVGXhJkqv4aiXvupylHcQPysa32Ak40DDBGQzTZTswbYlGuyo?=
 =?us-ascii?Q?NRPcn20u+cU0o6dpPhfUP7Ro82Vo09/0heP7BwCCkvUbBrhD+q1QYFfSps+J?=
 =?us-ascii?Q?Dd7iS+Oz0OVZo6H28FVfOC7mGwZTIzPOsGUpJkJkI/lPnZOqV70tU/+ulHLK?=
 =?us-ascii?Q?kq1aK28K2oNiWE+AadgWH9BExLveIZshp+JGzJqARFNCXUTygRHI2Pib4Tzg?=
 =?us-ascii?Q?LZ6BxWMi1mcbExP4f4NLOIO0rzO1HIdRuIVwTaTNJbBjtbZG7uKnT7g+hYGr?=
 =?us-ascii?Q?0SOljraxet6uwEDsJ8gwC9xOMjLjDkNGUxzGFlwSk72U7gXRVZ8yMMaz/Xpz?=
 =?us-ascii?Q?642u9PbKOSlUNz11ZOnRWE1u6/6TT+nMnmDhqkV7RIy1RmPMqd9DJHQjQyda?=
 =?us-ascii?Q?YPc/ltoqPg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc6380f-1359-4928-347d-08df02da7ecc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 18:55:56.3172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O8w5HgCzcs+uL2AscWmuc9YMCJUkUyMp9q/0l0bKwF5iU+CjURH+nRzPBg3KuHODRUAyjgllmItLj565IkDNNto89iUh1LT1xNgdUB6tEi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4131
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Aug 2026 18:56:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20040

> > diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py index
> > c5fcd71be..eedfd5406 100644
> > --- a/lib/bb/cookerdata.py
> > +++ b/lib/bb/cookerdata.py
> > @@ -16,9 +16,16 @@ import re
> >  import sys
> >  import hashlib
> >  from functools import wraps
> > -import bb
> > -from bb import data
> > +
> > +import bb.cache
> > +import bb.codeparser
> > +import bb.data
> > +import bb.data
>=20
> Double import of bb.data.

Good catch, thanks. Though I think we are not going with this patchset.=20

Thanks,
Chris

