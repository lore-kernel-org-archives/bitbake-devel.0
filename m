Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC272C4829E
	for <webhook@archiver.kernel.org>; Thu, 15 Feb 2024 15:29:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (NAM12-DM6-obe.outbound.protection.outlook.com [40.107.243.88])
 by mx.groups.io with SMTP id smtpd.web11.16686.1708010981771007477
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Feb 2024 07:29:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=m5IRta1Q;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.243.88, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5en6Rcb4w/dDhRx0LuBUFItdYBwnYntgMnZfl2+gAH2KwQ/uJz5QhLe37S1rhlvqk5GlCV99/rLev3HMmfCSvlihbaNziPrOnVZQZQR3iT80p50vIQg6+wCqwzvjmfC6e+gXIZ2xvsMk0TDM2o0MxX/RYqiYraz8U7CKZf8AF5nZNPxAO59Nmk4Hyzpb8PzkfxnytCkFpqd1zc/zV8jS2WyjgJCMTLo8918E/Ti1DTQ1DM+jo0hS0ov1/w5/Y5+nxUBFMZ7NdWwEnHBP8WV0ejA1or+fEKumPFdVJEfd9+582rQ9P+VBb8K365a9LK2lS67+95+k/61mKGPsLdmxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TmW7SoawLnE4EK8wFXhXertknPx2e5T4QxlwFj6NXag=;
 b=Cv8+3szjx9+2e0MfI7Ju1cZniDuNmPmA4iXLa3FkjtyZi1bP6NFX7zSsVHP3Vpc60d+tviVmElPDxDfNFlOxIy2H5XF6/trn2dY1kmMs+1mQoFpQGKIz7DwPWm6Uc5czv2X7YL6222A9XVRAk5bKO30pGfZFLuLFPGtOcID5j4ItEAwkvhymYy5QN+wyG75w0VGXq+Tl5FuJ4GqtD+S8J67LcjNVtbOqg7FpzwZ36Tty7PMF0hIT/Jdgn3+kJ/gtGn1V+lxhwMqwyPDoT1+QCrFcgb7YY6dO4hmzd/xDduuDDPP0l/8gaU3vW2bl+wOvd6GY8WTSE9KIUVN94Uj7KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmW7SoawLnE4EK8wFXhXertknPx2e5T4QxlwFj6NXag=;
 b=m5IRta1QnmiITrmiKJ7iQ7q1YzKSj2bs30x0dnIswb8l/+RCk2lcL8x+x8mCr0qBktqFETBXPPPvxNPRTVqvTv+6oJytACmPLET15UQ79/XQad6uwSFNR69r+azYBNQfhla1zj1K+Wra0G4+pcJ9y0ZW2q7l6K+dZHyRYRQYvZVbA8/DiMzQ6JdSM1quZaiWPTlIiNNpeHM6rL0gkLbX2RFNpfTCgRXN/nJjyIFHfPCBvY3a29+s06oQWErfjre5ItQuxdsQqDh/llahV3FX0mqWu9KZo+Qqz9LRCk3aWifSbcR06WX7suZuhYlW0ewCjXXjs/P80h/pj0CCXnw1Pg==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 MW6PR12MB8951.namprd12.prod.outlook.com (2603:10b6:303:244::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Thu, 15 Feb
 2024 15:29:39 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::a0e9:1e42:58af:ba95]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::a0e9:1e42:58af:ba95%6]) with mapi id 15.20.7292.029; Thu, 15 Feb 2024
 15:29:39 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: "behanw@converseincode.com" <behanw@converseincode.com>
Subject: RE: [bitbake-devel] Online tool for playing with variable expansion -
 first steps and where to host it
Thread-Topic: [bitbake-devel] Online tool for playing with variable expansion
 - first steps and where to host it
Thread-Index: AdpfZydm5aBLa/+zQN6kD8lbigwWlgAu00QAAAAV4sA=
Date: Thu, 15 Feb 2024 15:29:39 +0000
Message-ID: 
 <DM8PR12MB5430121AAE8FABC5D834CF8F8B4D2@DM8PR12MB5430.namprd12.prod.outlook.com>
References: 
 <DM8PR12MB54305F122A263BB3B7AD10B68B4E2@DM8PR12MB5430.namprd12.prod.outlook.com>
 <4ab357d878fad09b44149179e532608a1c329e81.camel@linuxfoundation.org>
In-Reply-To: 
 <4ab357d878fad09b44149179e532608a1c329e81.camel@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=2845fc03-b6b0-4bb2-a59e-ab4a86d71b13;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2024-02-15T15:22:32Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|MW6PR12MB8951:EE_
x-ms-office365-filtering-correlation-id: 5b050299-47c8-466a-5d56-08dc2e3aec7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 2cDNDeIdgf84e8tn+Jt9NT429nMtQGrN5j5NTLKrNJ43RiDvz7yR6fNJNi2tT9E+HUFX2AafOd4LDRlY5BEjcN5SytoddEC0HwojzSNo1Bv4AFqDXtf4EDd/kZ5tei80XdRTmuLmCT4er3Z0YDdoTEKJ2VHWWmDOxcAtaf2682fP99ApIoOuL7XEXhnAk29fv3OhpQFGv6z9ZOeoFgmElyobh2jxMnqayJDviq8znzq5NJ3nBquu6BHs6NIeP7g2JAyfw1mIswsmdYHfvKJrf+LuQZyWAqbcecySWKsnrFuiUiXHcIJfemm2dCaKvMmNzlK6Q1Hg/o+buXPvTMPrOd1yvk6w1E2Pm7X/kOvradibLPDcTY3TxzEPhyTeznSOm7Y0s1vmWSRCUQpj1ucvH/PMZ5vPJizzCcl0Uqz9Lrzqd55Gd/PoSNz0b3jtW7WemVDVnV76DMbrI9SGw1CcQ5wkrAb5xW/Xs4vx2LnBmNHxumeoTp/8EUzqZHL85bnVyXzXRTIPRFS4dXPnh5UKH1qeoh2kXXtiA2UvEyb0iUHynbbmujnyIUb9mvXQDoeyxEE+l+3tP5cudoQhvt6bILKpT+m4ITSwp5k+tp8YLobIJKknKoeIRem2tryQZkiT
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(39860400002)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(2906002)(8676002)(38070700009)(5660300002)(52536014)(4326008)(8936002)(33656002)(38100700002)(26005)(122000001)(86362001)(7696005)(66446008)(316002)(110136005)(64756008)(66556008)(66946007)(6506007)(66476007)(76116006)(478600001)(9686003)(71200400001)(55016003)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?ze53kv/kbHfx7WcAk8T/WphELODe2z980JoA5NGx8fz8omi76KCXgjrulyT6?=
 =?us-ascii?Q?DtlKAbsfap7TlVicKKzEzdTohxiz1LZKMBAIE7UbF5SDZSbeI0sqbr9zmyEB?=
 =?us-ascii?Q?Y3iNTqlW/Z07+ti7M1cz2xxlbYkBqUuNuqTHxGKqG50ESv53oExNdN6OkijN?=
 =?us-ascii?Q?8rUSnX8CGQfJxUKNqbvNCxAAfQJ2aMZIKsXQvsWe4bfWgZvoQLuV57e0NPC0?=
 =?us-ascii?Q?aedHJeB+vAQgFCGvRUzCep905sp2scKiZW/LTCsGaoJsbaNNwswL84791Zsg?=
 =?us-ascii?Q?cxg5RshqWZdpfQZsXdvKEsmwQwEGgoymx8qAdJ2LT2SVWL/58Aws7iaDKlRq?=
 =?us-ascii?Q?O0zaGS6y2CMsXp3aKTa3EZ5igXeEVbHjK/V+ziWq+4f+xnnIANpQFmFqEC0p?=
 =?us-ascii?Q?MHUKEvnmNXhAt6YnjwMCnTpbDIbWe0kscHi62zdq+TFUxLMdj3veBxe5b8Jf?=
 =?us-ascii?Q?3YeXclVW7CYwNM/9QFL1CW6XvNkUM/be52jm63/ikFqwXJlkrfLGxnULfZ4g?=
 =?us-ascii?Q?P2RnIC5GugCdgZxEdSpPWmSA0TxOv+3IEN1KZZkAqPTpQVLoRHtosj1iO/15?=
 =?us-ascii?Q?L4iUcZVFaBlz0uHuQ2hOoULBgY7NlWmzrrp1ShoVPmZmveNuwthch7NPvxWn?=
 =?us-ascii?Q?NWL8HsMfQoBtUkU/lK8m6LCYNIuljT3St1MdRfQRhyF1loXbDzKN+yQ+PDhh?=
 =?us-ascii?Q?JBUst4CTM/roEROa1H0b4sbmT7uJgYyRBxh42b1wjWgL4+H5uJwaoH+SSACz?=
 =?us-ascii?Q?wvYZLSAnkQs2nUDV+UK8aP4MiXr8bpj5IHbGOnIspmqWIheHoY+OJ89J9iXZ?=
 =?us-ascii?Q?vYWmYgO8A2bP2afkPKyMurP4MERy0/I+8/AKn6szA0t/ejwWcKOdykxuReXG?=
 =?us-ascii?Q?73vNY+iuSOigWhS3Co5ZG7JgoUsR/TwqMmeQJ36+wQKlOvK8m3ZUpBfs458e?=
 =?us-ascii?Q?PAd/mhKyLZVUxz/61jHXQ8ztTmIqOzc64psLvsK4mCuQXKWT6dGts7rNAOqq?=
 =?us-ascii?Q?eTR0GGkl0AgGpZXPPx/ckqwDC66FuiUGW9OVR+qqYE48bzEBQzUowPWKaE9G?=
 =?us-ascii?Q?WEZsoZhrH7TAmDe4yCMLgWA+QfCO1Gatmax4B43PJ3nxoGaeuD88WzPZq4uw?=
 =?us-ascii?Q?EUkzI2DGjHZ5WHk3DUqoBv7LQhEiDAdIWVIXTOHQUACWBnBtA1V8kK1TiDDM?=
 =?us-ascii?Q?w0S/hh6q0ILG5vmgtGVEhJRvmyiD/eJRwrI4EuxYPd12m4+3BORo89jooaP0?=
 =?us-ascii?Q?Xg1BVzqc0AYrfvj/hSbmiVfVS5fM92hhv0IUOZxoVakcXTufRCKdVLgwdkcW?=
 =?us-ascii?Q?8kY9nQhG5NsHS7WfDX46MY3uXbIHPfWuiDP4sp+JuHHywZf7QKhcmuccjh9v?=
 =?us-ascii?Q?/UwHSiYBvnTz4eN7Ctzts6gEI04EVtFeoqgWF9sfHwOWUcMyDRR3/ggic+5Z?=
 =?us-ascii?Q?6eI1RbL4qeCiFhiP/e13BP1vPRUx4QKPZiW5jCCs0FV4JIqXv+N0Zy4nAQNy?=
 =?us-ascii?Q?ES/7QemRh5Hmb2E58k6D6mYYVK5Ji92T9vsX9xv99A2ID/QId59GIfSd/HUm?=
 =?us-ascii?Q?rjdWjdjMXG6qVzY3dHZmK7fFK7a5Dscmy0KhmXx7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b050299-47c8-466a-5d56-08dc2e3aec7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 15:29:39.0204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YCxvNZGXdD1N7r53jxgi+yMbPvO5Z64m9FrN+chgo7mV5SRqcu4ozgvoej98kMv96M1l0Z8G4dtUI50A3NJ7/yAjLumHXX1FUdgMgySrgjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8951
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Feb 2024 15:29:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15896

> > I'll do unless people feel strongly otherwise. (I'd rather not put it
> > in BitBake itself since due to CORS restrictions I'll probably need to
> > keep tar.gz copies of BitBake in the repo so the client can fetch it
> > (*3). I also don't think we want all the webpack and TypeScript
> > clutter in BitBake)
>=20
> I agree it doesn't belong in bitbake itself. I did wonder about something=
 like the
> yoctoproject github if you wanted more exposure there but I don't have a =
strong
> preference either way.

I also don't have a strong preference. I envision eventually I'll add littl=
e "Run" links in the BitBake manual next to code samples, especially in the=
 chapter on variable overrides, which will take the reader directly to the =
playground. So I think no matter where we host it, people will eventually f=
ind it.=20

>=20
> No objection, I mainly wanted to reply to show someone read it and though=
t it
> sounds fun :)

Thank you :)!=20

One more question - what to name it? I was tentatively calling it bitodide,=
 but I kind of hate the name. I think "BitBake Playground" is the obvious c=
hoice. Could also do "BitBake Explorer" (ala Compiler Explorer). But I thin=
k I like Playground better...

Chris


