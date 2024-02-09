Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B341C4828F
	for <webhook@archiver.kernel.org>; Fri,  9 Feb 2024 22:50:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (NAM11-DM6-obe.outbound.protection.outlook.com [40.107.223.58])
 by mx.groups.io with SMTP id smtpd.web10.1696.1707519045439750531
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 09 Feb 2024 14:50:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=pZ6saM9e;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.223.58, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f9+R4KYbB/tqLvbSZHd3yJbwmria9BP0GhEGVmfdN/RkLhA5TGm4NyzD+ElZYoE6U4jN4Sz8GVYjDvWhp7GUMzIaGCzNEtVAB40zMeQQcUGw4j2kyKg7KCbuYBDa4Z2ZcNP9HHYI6pGF7ruo+S/U4pcif52Neuk4oCdkMLTC/i0uueZD3Gq2xF6qDlUfQwAfqwgleFhT7kV1WACNv70oYHCAfFSYWMSgv4cbnFVyxOl6eeCzVYWG8+IIk8GLkYVozhczspqrBzNZHjOfQhpkG9QL78QrWIg4WooenLfaUeuHOEBOhYkPUeiPaRCfrwIBpX0wVeyoPAGYPPToPkhmdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keWvxOymobdM1RYS7Uki3O+xWUm0F1ASUYpDkW+Zfwc=;
 b=KyQBt5x9BhvU1MrPKN60mXqnTurLfD0/tPdst0rlSJ3TAkmuGVQOoNHcb/GyMDOLo+vj5omgo9/GrevnsClOl4pD7HVYQuYtw2FA2mVzV2rcnCQY9nKNFvEDe56NYrMoHc8SmdncvvoNZHuT6cfbau+7Nm2E7dZRuT//TSeUy635Xbz+7xS8FgGL1jt9lZk7Fnc4OonwDb0krZNDT/Iv+UbOkXZ2s4zYmpuiLBLUa3V4eUCVtvQ4insI+AUl9taZuNLL9W6Y0nFFhkTfYRkMtiEp9iFROqcQogZvA+zoZs/Cjk/VDCJgUeiUvK4TYHU3jb5b4S+4L72jpCbcX5i0lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keWvxOymobdM1RYS7Uki3O+xWUm0F1ASUYpDkW+Zfwc=;
 b=pZ6saM9e7K+0wR1Bu2CXxVkncjc4hqqZE8qIw+tXRa6Fr4WrCR9NsGygcM3wyxfOYXoLI58M52ZqUYhcQcPbYIQoVnf790pk5lJMRFSxaPyTeoSA+U9Y7UQmclY50EzpH8uEPFeqJTQXq9lyYT8dQEWLgKW8U3OGElBI1pr4su5NUS6YRPlutNRWOSa/hiz3/XAxyGsgNgxLjn6FDvqGlJF6Ob26IYxK8NFn+sOA/urQMHybscOHWGXpB6W9M46yeYgq1RKgpfiF1GMBOB0/8EmnYzyj94QAyN/c3E4+bL22tDAbPi6afV9736XGj5HYLF/dTYlWM1L8M3Kx7S7N2Q==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 DS0PR12MB6414.namprd12.prod.outlook.com (2603:10b6:8:cd::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.12; Fri, 9 Feb 2024 22:50:40 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::a0e9:1e42:58af:ba95]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::a0e9:1e42:58af:ba95%6]) with mapi id 15.20.7292.012; Fri, 9 Feb 2024
 22:50:40 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>
CC: Richard Purdie <richard.purdie@linuxfoundation.org>, Khem Raj
	<raj.khem@gmail.com>, bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] regression of 'world' performance?
Thread-Topic: [bitbake-devel] regression of 'world' performance?
Thread-Index: 
 AQHaRUYiPYr/ofNNNkqGs6ZtScLV7LDWFvoAgAAD6gCAAKV9gIArjOUAgAAFtACAAARfgIAAAdiAgAADDICAAAFyAIAASV5ygAAPhqCAABOXwA==
Date: Fri, 9 Feb 2024 22:50:40 +0000
Message-ID: 
 <DM8PR12MB5430763D07979731FDFD7DCB8B4B2@DM8PR12MB5430.namprd12.prod.outlook.com>
References: 
 <CANNYZj86b3GMtSVZMn8744HjMSMQVkzuXBTikLf4dFV0ULsvqg@mail.gmail.com>
 <0186f166a0ded0d97d5e19f64a3dd8e5ad44a92f.camel@linuxfoundation.org>
 <CANNYZj-cqQVJcs3AUvzE=Lw+mYMUWZO8JW1N-Ukz6BK3H2rchQ@mail.gmail.com>
 <CAMKF1soqnpKYkcGzkS1A2UGGiy7_Vbzym06rARRTqCnUc7gsCw@mail.gmail.com>
 <CANNYZj_r2S7b+3r4CEz8cGZSqT_wa785p1BtpZxb60CVvZJcAg@mail.gmail.com>
 <947006112712dcca07c607eb6b49b7e4e475c3d9.camel@linuxfoundation.org>
 <CANNYZj-V_bH-uVUBXmER30GxMLrfKN6g=pY-VSsgEfT6Fm7e_g@mail.gmail.com>
 <829c8fff2e6735297f036fdb878f4d244cf08f91.camel@linuxfoundation.org>
 <CANNYZj-3QDJMcqaVTSj+XRZo140O-hg5K9kM8e0mtF7yp=P9Tg@mail.gmail.com>
 <cf9339c32c0923068f0e4ae81fe1ebdb8153b20a.camel@linuxfoundation.org>
 <17B24084174823DE.15017@lists.openembedded.org>
 <CANNYZj-gbs6UmzcKaBt4DQ7G08EdJUNXZWWu3W8G=YJUub0gKg@mail.gmail.com>
 <DM8PR12MB54300AF8CEE589B8B5CB2E238B4B2@DM8PR12MB5430.namprd12.prod.outlook.com>
In-Reply-To: 
 <DM8PR12MB54300AF8CEE589B8B5CB2E238B4B2@DM8PR12MB5430.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=2e014206-3b8c-4d79-8d68-792ebd1bebb9;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2024-02-09T21:40:12Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|DS0PR12MB6414:EE_
x-ms-office365-filtering-correlation-id: de446e43-852c-4695-286e-08dc29c18a33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 t3TQNa7KAcxlm2u7XWt3PnE/8isZmZvXRFIfmIJoAoAo0sYFUSDpZ8PbX58qO6byj7cDDSDSeMGJjEVsPA+WxcApUPYsA/rfkVgtggHKEtza1w4dVNRkjGwbWGHgTUTG4nJFSNVpevqSgoGyAstEVfcZdFQvG9ylLgBD4j/NBxhDqKeKMUA6YwwZzcWefwKd4D87pxmpIhJGwO4b+OWsNN5IVw81tolsotlAcIMTiFj/DUgkIK162ibQMt/u49ctbf5LuQOy1xNnOuKs3a8MTX3giWPwTppYu8y68pmpnmJKoUm3TUvNCns+2/jW5aBekZTyHsr77mNVjnC9WNbIEz/7kY/pUloNJUIK7jw+syxooDSzCAT4UZzx3oL9WJXN3aGlQf/biY8RwdviJVFm0xgFemuRHWi8Cz9+CKobkWGtKC6Y+gIWAHyMIRD9D+G3UIqWjoPl/7UaWKwaZC1stF1UH3HITPhfo09aChPeaPiW3rGEoZrVbNm97MAx7o/YCp7Z766xG1QqxZkLPnfiIYsL+4Lffp9Krzow3eDUflJohpL4OBVhzTjyfkG2WeiQ2tt3iaBesccyFLVIhlW2l7E6ieJkPA9RCroUhDP1Fu8EgckQcMSm3ZrcSGFlJnTU
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(366004)(136003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(55016003)(33656002)(41300700001)(66556008)(38070700009)(86362001)(66446008)(9686003)(2940100002)(2906002)(7696005)(71200400001)(6506007)(64756008)(478600001)(122000001)(26005)(4326008)(76116006)(8936002)(38100700002)(5660300002)(8676002)(66476007)(316002)(54906003)(6916009)(66946007)(4744005)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?33aKQRyHGhEWJ5Yk3wlDvVr829taNHrTLwRhW1hXkzd2Yoec4B3XeuX1lAby?=
 =?us-ascii?Q?7SscuEOx3kP1iQlhZguGmP5RJxwJtVaeK+m1Aog5iasQtLapkzM906YelKZL?=
 =?us-ascii?Q?7iUDYuukj72pBb9JFGjmOxhJdjIgTz6ZC60WPj3x3hxtaQS0SlwEOoUTwmwv?=
 =?us-ascii?Q?ug3Uvdj7uYG8crazTETd53zgT4FPg03x27ApHdRO/30MAMaeJ9wfp0rnwOFv?=
 =?us-ascii?Q?sQC0Y+H7oM5CMsakdhTQGwhhdhOJXcGxc1G2UrjdpxushwKBaqx4MYd4R+XO?=
 =?us-ascii?Q?COMjomPbnH45Dx+thwIPiNY++N5i+EM29EkSRijjzx9PnDCVe+lJJDuY2KT1?=
 =?us-ascii?Q?FNNvLoGhdMt2X9lrXPWVpZVvjHidPQoK6nbMqMzkj0zQ+GMA8FnCxPGDumk4?=
 =?us-ascii?Q?uXa1k7+Zduf5M5pg5ywObKeiaubrIUdyJyOHmui/y4Kg3u0U85VYM3kgTeu9?=
 =?us-ascii?Q?YVYvL5soIhc5VqaWsPCy08Ea/+0On4sZkRolx5K+09RuBkOxvER6a9HffIud?=
 =?us-ascii?Q?0AFDecC4zQe8sdBA2FAfuqT2IoDZoUwTuQ3LCjWElxtmjRdqwv0fVxZ8cVcZ?=
 =?us-ascii?Q?vD7tEIsARgFNoQ83i8l8FDPuPcndB8VkYUyALa/BFh0Z1QS+geVLYKihDm2R?=
 =?us-ascii?Q?kyfE+TAaenTRvMDWD1S373B3u1cw9C0a7pHsi70rEpswyWXr1C5apYhABd5J?=
 =?us-ascii?Q?XJSpIjr2JAjDb1S8qlF7a9Uli2T1AAEGXzP9pzUHDYqV0mV4bokjxFYilUdJ?=
 =?us-ascii?Q?LWlukd0r+L+ve3zqVp8JizTIu5DXc7eupVNV3T7Tmkiup3hseg54UZWwSxQL?=
 =?us-ascii?Q?QTPqKpyZyVyaLMnA/ikav8iVK0wyFCuTNhyNep63p9zvYQLIKmyulZ88aZ/Z?=
 =?us-ascii?Q?IzTEOeS9UQp5isv+6PjSHpg7SU3I5zasfjyF2WyUfM11DZ7bTfLW0kqwKI5w?=
 =?us-ascii?Q?jIx/hjX0fon+4AU/j++sWNE8OcrLZD6GhiW0a/Pby+9krbspgZJ2lvdOsw63?=
 =?us-ascii?Q?KwIlYbmNYEYzOICObC3DjnmRgbpS4aXqp9u2CwUo6STbl2DoeQQvENkSPjOB?=
 =?us-ascii?Q?KYbs4BUv48ceGMYbQEu1I2nJSXJM4UmsNA+OBcKdsmmFrsZqoEw1C7E+yVzr?=
 =?us-ascii?Q?dA6u+6A2KMVX7PzTt6ERe9mgrScCOKHh+ZPvpPlbv7q1CsSP6oO7Kr0wWDuk?=
 =?us-ascii?Q?BcMo59yXNZonixie4oWweLxsqC6wDKDD3WzqBsMIz8EoX5mkPSPzqFK2Vmfe?=
 =?us-ascii?Q?gCszq3NcMhvxlK6AfY08ceaW1NZTBEV5FqA+jTdC6aAqORFK9B1bnTpqu8kN?=
 =?us-ascii?Q?aByViAK+dVgxENMu2JPcjvJYaMgNv80j58jSziziQszggIyXjOySuOFtndQv?=
 =?us-ascii?Q?1I/FO/DUNxsauL2deN70FsRch6evniwK35AxUGrK8nlmPlKDrF90eykHc2Nf?=
 =?us-ascii?Q?fKMaCieYJRKtxkwSqjLonVAIY82zlY8vperYX3xPluGiP87lpPYhGc4T7tqm?=
 =?us-ascii?Q?qndZIEbjqrYrcT9XOpAdKX6knfsP8H8zvii638rGMIMzUnKdG62MOeiTif+W?=
 =?us-ascii?Q?5FiiPYALUOmc3EKr0dlOaRWSINgQxubXAGH7VyT0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de446e43-852c-4695-286e-08dc29c18a33
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 22:50:40.3502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mTtjMhj5sTkZE/V5Zm+pmXtSgKvUZiqxP8bx1hU+X4xmm7uQ1BZDJpgK6yhqe/97cVpljAJH6zbXDmRdj9+Rjn4C4n1H6uOfbtBKTLSAtT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6414
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 09 Feb 2024 22:50:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15867

> > I pressed ctrl-c after some 20 minutes - I took a look into it then
> > but somehow couldn't find anything related to execute(). The two
> > collected profiles seemingly are just waiting on select().
>=20
> Has anyone tried just using strace? I'm trying it now and will post if I =
get any
> interesting results.
>=20
> For tracing the forks:
> strace -f bitbake world

Actually I didn't have a chance to run it today. Will revisit next week.

Thanks,
Chris

