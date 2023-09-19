Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7D9CD5BCD
	for <webhook@archiver.kernel.org>; Tue, 19 Sep 2023 15:05:07 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (NAM11-CO1-obe.outbound.protection.outlook.com [40.107.220.78])
 by mx.groups.io with SMTP id smtpd.web11.11847.1695135900968578543
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 Sep 2023 08:05:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=V/IraClZ;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.220.78, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=goh7mt3SCdauUSWvWS52qaBtGV9CNnO5hEGaT/IBAtVYk5vTzM5KFiYm+5FAU869jnDMVdw8+cKIVjhJmr+SJOCW8XcZGdUrSsZ4DbWLOkis6/6FASTKjABoHQahuZwEZAywN/EMRezvRRRB5v6Rvn+9rEYQ+PaT0Ze4H71W8D36CZCEX8Gb2th/RZD73kMn/R8yDcY6aArcKc5QsNMY5jVt9pFe8G6wUzypnKyAafjAwZPKfiifHj6IJyP/aQS1SlydvxcgiIU8+n7/k3Ki1QKSos1R5hw7iIpjR3wx8kUBQV6MN/GROXMX5v2sc7AuAqqDIg5VqJZVyauX/d1AUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdbfPsFRuKhGpyqTzTV7qz7BK3JPBGGbotQ3pV1ResM=;
 b=XuxKLlWXBsu1Nwz7nP+l9RSOduOK0PuqYeQ4kBPqgF4QuLZ0fE55qCo2LuLPB9YWdvhR/mOgyZ7EG4W3Tmdh2WCH/JY8RDC+gL5C7hJ6hMZmSzt64CZCWan8lTqZFitpdqWNcRdnC5Vu7Mc1VHKEvNRdvY7boVjVZmM8NtlcRto9GxuGU1lbVGxEHIsLHJd3aVm3/3GFesSdlKXwewDUttjHB4IXWPPOfweIq2Cgu4/ezyRnoDsTWAoO/FHHwX+9XzfvTK/7/3Jpdw6S9q+5vJ8uNs/mq0hTkF8E9k9lctnek6A9keiaq5tcs/b5sCTGfqH0PhI4+IGnl/wWZWgUpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdbfPsFRuKhGpyqTzTV7qz7BK3JPBGGbotQ3pV1ResM=;
 b=V/IraClZG9CIBP+GZQQMynLd7l310vgdDrd8tx6NDaSPNFnqqO6NM23kvJn+D0VIfWcXGHYXafxkPhr93iZr+rsYUfxFxq+BrSGxaMsbGv1RWpPvdiEwGCOwxxm1k7MhOjXYp3tbW4Ifg0XhazFyOSGNol04HEH9eVqsOwJl0NM5NiOna9/d9JE6gv7P8YGKXrBSeJ3xYO+8/BGLjY1PqHsS/APd3HeH6I7J2UTRm79McD7pKF2PAOZ6ypnQqlvbLww6rxyiG8d2fPug3sa1eniC9xq6sR3xzadhu6xhu7d538dHbVFdNdmlu8zKtHqDNeC7ZDXDWOWv0Gey3u9FUw==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 CY5PR12MB6180.namprd12.prod.outlook.com (2603:10b6:930:23::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.26; Tue, 19 Sep 2023 15:04:58 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::3d4e:d9a8:d060:9ec2]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::3d4e:d9a8:d060:9ec2%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 15:04:58 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "JPEWhacker@gmail.com" <JPEWhacker@gmail.com>, Richard Purdie
	<richard.purdie@linuxfoundation.org>
CC: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] Bitbake overrides optimisation in the datastore
Thread-Topic: [bitbake-devel] Bitbake overrides optimisation in the datastore
Thread-Index: AQHZMOY9sw9KSr3rR0GkjRHBYxrw0a6vxqOAgVYa1jCAHdF28A==
Date: Tue, 19 Sep 2023 15:04:58 +0000
Message-ID: 
 <DM8PR12MB543076EDCFDB6931B7B2BBD58BFAA@DM8PR12MB5430.namprd12.prod.outlook.com>
References: 
 <8f03e675ecb19ea938428c52431cd1fc384b5cb3.camel@linuxfoundation.org>
 <CAJdd5GZKqXyETj4trusWAz2YyXheWeUj3p8ZLCwMz0NhJrnqZA@mail.gmail.com>
 <DM8PR12MB543065CF83FA3B4D5453D11B8BE5A@DM8PR12MB5430.namprd12.prod.outlook.com>
In-Reply-To: 
 <DM8PR12MB543065CF83FA3B4D5453D11B8BE5A@DM8PR12MB5430.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=1603d7a0-72b6-44c1-8a71-f39fe2248d41;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2023-08-31T15:41:40Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|CY5PR12MB6180:EE_
x-ms-office365-filtering-correlation-id: 6a080471-a83c-497a-0994-08dbb921ca4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 zU9aFJbWls4Fec6s2cbYy84V7JQrAAEqKUM4vY6TvZB2L5FKFw6Vswwe+fLa+BwaN1Co0cPWmdrPeGkOCuxc0adWdvOGygnc+X4of1ntnhxgHjd1sJPd4trTWFBp1mjoCQSHpPZAGluXQgQxcL/xBROoUCS3mHeW66hW9LNxRRfmP0gSkOUwg5I9ckAf7U7gWWFVnTPxZILCnYlp8GrJTLZ5RJhOFl9tkiUE43HwClQrGynuNXHZJ0DOEq2AvcBUoX13Nxx/Ys3t9d0TYZSLtu4GCggmNHGroDBJ1TinQ3mPfLn3CfbFhU7+0xyw6H38dGx8sfkhAAAadeoHWaADFxFeyy0nJlhSrDoCpP1B7mKzfbADs0j4qKEYs1rAUxvM1SqMv2AmQOSpsVmNKOktQjOPxjpUUKuYkMMJdUpEf9cX+gfR2/zfjvHCqov3CjpItEQlHx2thOk4Tl8JarNSE9H+XMeOyMrUUhGm4bwFbtwU7siOMHTmqHVznBu3tWQgC/NarMbsOPkeGhspejRp/zeTEp8F4ulupLfFDk1UiQutCaWxncklt7mDuns9r4N3jE3ReLnPAgwJH15X75rDzbNSb6rjOFPMMfeNwjB0iWc=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199024)(186009)(1800799009)(55016003)(5660300002)(7696005)(6506007)(86362001)(9686003)(316002)(64756008)(66446008)(66946007)(38100700002)(66556008)(41300700001)(66476007)(38070700005)(76116006)(110136005)(71200400001)(478600001)(8936002)(8676002)(52536014)(26005)(2906002)(33656002)(66899024)(4326008)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?kb+0s8tMs1YjG47TkVkym5+cQPdxRqBuT697nmBz1x+9QiOyccgLrWSgcodj?=
 =?us-ascii?Q?D8kH4AEgWF1bkAAxbzlIfmey8bvo3hZkcCNi3CE6g1ogXV4EWRaFsiffzbte?=
 =?us-ascii?Q?zDmElD6PEuDaDber4SS0Pv6RLGTdoYVbLID8S7HkzVGwpZZNWKvVjSaa9yMD?=
 =?us-ascii?Q?hi4CGsEQ+TVtDzf+hQw5JwX9wwGv0yJQWJNWdW+whiz2IBXwSdRhJ+TMTBLJ?=
 =?us-ascii?Q?TzDtLx1BD53/sc0gQK/4fosFMPfJ/dfBYdeiW/hUpwnYfX9n3ynzQAWyQ2lD?=
 =?us-ascii?Q?yMJ8k7Jo4snvRHHERjijolBDjtpSSlStD1bT+c8lgGNopZ85wdcssDaAu968?=
 =?us-ascii?Q?lg/Qt+fZO+z9kULGX784FwZs0rx2XUFCYIbfehldx+poO+rjjQn0tUDfP3bb?=
 =?us-ascii?Q?hk4bmLH1uzSp8ERmZ9SM7DD36kRhQjbZP60EcuL1TKXHbdIEj7nDA60sza9I?=
 =?us-ascii?Q?xl753qPC4b8Q7LfgvzUkFgbPdJ4jh+OUd7hTta7ikDVrutzGFChAeu15VGrE?=
 =?us-ascii?Q?kxzbPDwBhi+h/F6VGAWGljeM2JFHPrBWIcz/cnm6FhrSZJC6ogDSMFtwE9RQ?=
 =?us-ascii?Q?xogEjsWkCzuHEvsmW6n/BUm0ajtpatDgWjhmYmTJqd18J3O/9EF/BEgYhL86?=
 =?us-ascii?Q?7xbOGFTjxcADGsoJQAEdBKSJWcwZFWkxivbL6cjnLBbSjx3onmi9LxkmZgNB?=
 =?us-ascii?Q?nhM65FyBzhm2FZGKEkB5ZbRMoPoAGnzSWMyzeb1yROOGqpHMsNmQnodVm2NP?=
 =?us-ascii?Q?joZd3kx/d/V2uEq6HN+WXe9hMcKwnXjPyB8GUBy9sezSBmQ0g/1YTkUcIIv0?=
 =?us-ascii?Q?983/kkaIuJmXh4mi37mBZl4iKNBaHYqvQrKJyTntqHrv+Y8khN0GeaIXRDvQ?=
 =?us-ascii?Q?Mk3E6jjZ6xhLwOWTEdlNZx/aKxjXlc8BywiwpTJRR2N0L2ry66JRmAGKIqdm?=
 =?us-ascii?Q?YfkQQIn+5O6gKtfPqKG5d+6Loh3xombJeS3Mq/DLQxc7LHVXbuWDbuW7TFt5?=
 =?us-ascii?Q?DyAveIy5nKHkFYNhatZULC7LfDMfu6PJQqXykyh2R0RW59ainLJQYoRfjuib?=
 =?us-ascii?Q?MMJ99bABWBpjjLbooIT4hhKSlVgk9mcqlc9ew1eiDmzx0qGNCY9QqziJMmxd?=
 =?us-ascii?Q?Sm8G8+ZrkPjNjEcIj+SQ6cWayove7UrXGk5DUdIg1hffKlYLcusZgN+MhPaB?=
 =?us-ascii?Q?o1GNdI9nH5mcUfKR1O+2cnu4Q8icT1/T3//xGXvfZfgPxr1vSu6ia5SeGHFW?=
 =?us-ascii?Q?GPlKFZ4TuA603SfWXlQVyStmaqtYVq+wfCein1wBMBQRZeWgWqDMHG8Z0meR?=
 =?us-ascii?Q?swI7rGMlDgX2D/Buyk0QSsEZ668hKCh78hJMf0v3bkCfExImAfHQGXIfLRf0?=
 =?us-ascii?Q?V7Ko+Sj3NhVOg1HxSK0pAXYP1zOXCnXVa1uVF16FIFwOIZ/RFH6lJGYDO+3O?=
 =?us-ascii?Q?lGvOpTXtCLcohoXjK4TuclpLoCjXzwnr3n8jJka0rZMWjvSCuKI6p8XjCreR?=
 =?us-ascii?Q?0764SjS5R+M+RB++gp4rujJeUGCA2B9JflqLOOi8yhdlnAOuO8QBxnh03hrB?=
 =?us-ascii?Q?Wk9T0nUHYdHUsLaJjsYnLWVFFAUIHtVE6VcOPHsS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a080471-a83c-497a-0994-08dbb921ca4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 15:04:58.2267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fzq/xpOo8PoOxVX/vLftuy7brXmzWsVN3O/0zLARuFYXqaA9kf3VEkl9O+37sN7pJ5/62SggmCA8bD990QPEL99ss2R4CKi3A6CS4OuNpIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6180
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 19 Sep 2023 15:05:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15084

> I find this idea very compelling.
>=20
> Has anyone put any work into implementing the datastore itself as some ki=
nd of
> graph/tree? It "feels" like it should be possible.
>=20
> I think it would be most similar to the task of implementing a spreadshee=
t
> formula evaluation engine. Spreadsheets deal with expanding arbitrarily
> complex formulas. The expansions can involve non-deterministic procedures
> (such as getting the current date/time). Seems highly applicable to DataS=
mart.
>=20
> My testbed would probably be bytebraise
> (https://github.com/agilent/bytebraise). But as it says on the tin, the g=
oal of
> that project is just so that I can better understand bitbake internals by
> reimplementing them, then ultimately feeding any improvements to upstream
> bitbake.

For posterity: I discussed this with a colleague yesterday and our conclusi=
on was, 'no', it is not feasible.=20

In ByteBraise itself I am planning on removing my own implementation of Dat=
aSmart and just using the Python implementation in BitBake via RustPython.

Thanks,
Chris

