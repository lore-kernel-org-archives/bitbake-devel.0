Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6C5C636D4
	for <webhook@archiver.kernel.org>; Mon, 13 Feb 2023 15:50:08 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (NAM11-CO1-obe.outbound.protection.outlook.com [40.107.220.82])
 by mx.groups.io with SMTP id smtpd.web10.17801.1676303401502025171
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 13 Feb 2023 07:50:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=wDGF8dpk;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.220.82, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pf+ZtKrD//0Pm5eeMPVtWoDF2wjgdjdgieIMeDo945276zBjkrp3CN2Jm6zq/dm833Wmvl2vv6abza73vXPk/m2l626InKEFurX9CXzH470IHlZvlfnMocJnTnH/BheN5c8Z+2p5D2jSrRUEWi6WRyo52ATxiZlty5vRKi1/XSBAfYshYDMWr3d5bx+l8Rp2CJFK0wry0MJtdXkAu8L+58ywkR21v/DS/xelHoUlNBiv3Z51iEM6iTh0ve37WrRqsW7BYp0SZEbpfSVDLtydSxpJwOs5F8zLI9YGDsHZ5sGH7hIBsyHOVPg5gmj91Y0ynNlgBjqFDtOcfd1nw6VuIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyXXv3M89Rw5+b429n3r1HWhI5zJqllVwwXaZb1FIOo=;
 b=fjrpR6fdMb+W9dk/t6mxkKgVjQxqODJZuUmBvJlcXDGzZvQ2X5nkodr0HypfeMx+P5uw3oJhp3gBGKXI+f48pyCnAXvOUHg+0LES/2+RChY9pGL/Eq9nUR6dolgZSvCxJWN+nTj3s58irBRFsUF9afzvjsQpbi2R8lLw9bStvtDDnIhVE/Ht5oFNQ4nhtmfIvGDpHx7ROGxbet0tcrQKHbO6r/yXAkrOXzWNxWc1H3H8lAALod+xbOK1fP6aLC8j8Aa0FkCKWBK9nDTv1zvY99R9SuDXnqjWs16wkpPYZTldEy7kBmxnhWDp/kQYG0UPDn7DLX0PUSvw2KVCvviJZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyXXv3M89Rw5+b429n3r1HWhI5zJqllVwwXaZb1FIOo=;
 b=wDGF8dpkfYpMwBU5Cz6/AS2DBWr/Rt0Mu8ddNBtfmfEFVCqbUYBBajQLP2kGgZwWaTggydDhPQJcCG2opxS+DuYbxoO0V6S4U94z/imMuPhjlbNf3x1AwWIjqc6uVTzV2+7dHGOuuo7IEs9vuG3qw1u7+fNLN3yI+Y/KcFBkb+efws8adu2rn/XzGyzyig8ckEpr92L9hODOK99gqvAgEzz1QjM+0ihoE4LufbkXsEO3/jA9/x2oXdYgnfvOlz9NcwRswW0EPmKAHkGrVoVzzciza50AZ9fiXkLA+BTpp6+vPkLVnHY+rVgj0hv1qpArMcxW/MTs0BG2whhZL1wvMA==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 BN9PR12MB5384.namprd12.prod.outlook.com (2603:10b6:408:105::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 15:49:58 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::b856:1ad9:66fa:9560]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::b856:1ad9:66fa:9560%8]) with mapi id 15.20.6086.024; Mon, 13 Feb 2023
 15:49:58 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "chwprzem@amazon.com" <chwprzem@amazon.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: Custom event handler does not work
Thread-Topic: Custom event handler does not work
Thread-Index: AQHZP7RYyoxRvoWPbU626qqFDdT3lK7NBfOw
Date: Mon, 13 Feb 2023 15:49:58 +0000
Message-ID: 
 <DM8PR12MB543087393CEA69A61F5860CA8BDD9@DM8PR12MB5430.namprd12.prod.outlook.com>
References: <1dd67709f24d4a02b9597a7c7ef30b49@amazon.com>
In-Reply-To: <1dd67709f24d4a02b9597a7c7ef30b49@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=c16f04d3-e158-4ed7-b14a-3cfa85e47935;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2023-02-13T15:48:56Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|BN9PR12MB5384:EE_
x-ms-office365-filtering-correlation-id: 33b0d5e0-4426-4b09-8c07-08db0dd9f582
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 cgR0jyN8PuoP1aG3QHAOItchDoQWmK5co7LcmLvU8SkLRl3t55323P0GxnBGItz6i2J+2Le7r1sSsWRm2CB/OseJ5L541vua28DlVV7r9HgNtEIIRbA/PmFdRlyL7OQvdYNDsECqv4bVdjdxOouhaabO24rytTJD7riMZNyIoG5PgBGaKNOd6ir/MM1F4dLCL/LckpmL87EbNGrocSiAwF8co9ZzLB4nsDt/ZEKb5SUbd9ba0HapF2O5RrT2aTdCYq/hz/OU9Z27ywqROG3RS85Ef/FpoIWBFC0XTwe9SQzJaPgHtPRQZJmOzj8yNBGUMTFDALw28vTg+sawiNBCg1Mf9mSI6yKt/2BQnOHZu+risHrMM6+P8UX8q/nxcFWHlSjPvJmnRDRw0PnA4NeLyo6WdXEKgAV3y/Q584iV498gcianCtlwUprtrG05ajhVQ/3g13RDTouWxmKY1EWvvAOIttKQDFAt0uy/c0ocBYClAXBBnS6nPGPpMEsZW3v8GDDnRVa/OlWD4HJQhukejDpIeFskRalANIxYULfnVl1IPVTtDr+vvBW+znqxbrdEs4QCBy2+TO+sYZkJAPwxX15PJsBRy1DsvOkGb3bKTeaD2bF9hbcSRSEwxLiVakmYDIsSD/s5Bjlfsj8asAq9I/931adaDQHPW7/c42bB8xo0gwslN9DhvUcQKYuHlYMVPcsydk0JK76TJOXYJCU6ag==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(29502001)(451199018)(8676002)(122000001)(316002)(45080400002)(38070700005)(55016003)(41300700001)(110136005)(38100700002)(66476007)(66556008)(66446008)(76116006)(66946007)(64756008)(478600001)(33656002)(2906002)(71200400001)(8936002)(4744005)(5660300002)(52536014)(9686003)(7696005)(6506007)(186003)(86362001)(966005)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?M8SGKvZnO64C1O0dek3IYivydOaZQGqCI/utzd9+z0J5tJN+4EQ5/dQ0qU?=
 =?iso-8859-1?Q?djCXSdc1QsM9m8lfv5IDlvwVo77m4BF3LCqwexAxvyp0GjmOIP2EO3iUAL?=
 =?iso-8859-1?Q?lrwHU7Il1ZDTF4EPK/7Cah0igVDeANweYkiC7VzjPxwKzPBHxHXWtGB4Rl?=
 =?iso-8859-1?Q?xZgm3K5TapVnZ4W+dVO+luK+ZrppfVUm2Nd+p86muqAaraQBkrDEKmWSye?=
 =?iso-8859-1?Q?z32Y+HeEsDYUnlvtIEG3pqiaautvVHYrlO1s2x65+PVnJS+7j1LoilOFJz?=
 =?iso-8859-1?Q?plSis4KQPXQVJ8vpvFRBU3cz4RMVD8svmlA7dhzZ8vh85quqp4HRxljnrs?=
 =?iso-8859-1?Q?Fm0SMXHyvpaXYepPRqNTZUKsT/Xs2d8MVz7atyytO6+7eqOjzr50+wsx0Q?=
 =?iso-8859-1?Q?GLl7zrrDaR9wyzdlq/W82Nqm6d4AUCUdGSGFPvLPOjqAdnJfEdl/54mmU/?=
 =?iso-8859-1?Q?kcfQVPBjx1nox8cckCMyZW9SPtNF/WsIXyfu5UHH8hwWGocYPHM37jwNOn?=
 =?iso-8859-1?Q?bTVMxdkmMHecFvxxt0l4W2L4rW6U3vDB/8Gx59hhEIC8ap/jYyzQ4YyJbi?=
 =?iso-8859-1?Q?WrSrBdAZPlzrt27GmdabwrIsybo4y4Onb/qzMQFeyjrps6SdsMXITAXF/T?=
 =?iso-8859-1?Q?D6AbyKsWzjN9R9KTciLDzGsydFXV6VtccdYabCCMIoiqhkzdIqydUmcPmt?=
 =?iso-8859-1?Q?HEI5IJzFBdsvr3JBBZ8XL/nYcM6wr09yf76QlqPq+V0w7vU81W908kB+Az?=
 =?iso-8859-1?Q?elGYOTrht4GjRzUsl97j1wT08iQBBYOJPC6StTPjnLgfEOFX0lAj8zbsZv?=
 =?iso-8859-1?Q?Z5h8J1S5ooKVzcF2NfXTEzi93oKAHqdFkgxFRx/XrRWxbDwOyhEjQKknFT?=
 =?iso-8859-1?Q?2nCWkNLCcaC0ceU63jjVFSWn7H8OLwidphNVNY/eaA8bzMZq4FG9AaGuUj?=
 =?iso-8859-1?Q?RHbLolH88QXfB+xAoMkDPrDAbebEGHpsavZ3rONH1YdbKj2v8toj8lreBc?=
 =?iso-8859-1?Q?RaDW5uQFABJbVcpg+LJonQ6OPPs4BF4ZPjAUvLMSsd3TT7QDPUI5DhDhkg?=
 =?iso-8859-1?Q?TJFemd3QQGuvOp5fgRx4Rtwo8C/ZvFxyGEEOZoub03IKo5s/s8pQpQ7bPM?=
 =?iso-8859-1?Q?Qkop4YmMsT6ik2rDIe5AbPGeELBWa7KayB9SvPb5aUvBOoJHzaFQGX8849?=
 =?iso-8859-1?Q?LI/ZyYqD8GSQGQn84ybRrJ8nC7WjP0FIa57X/bPINeq+kUXANg/F6msIvc?=
 =?iso-8859-1?Q?3dBu83mo2zdltkuT6LLO+KHC5IEtsyMncYlq/pskK40DvoAIrXvE+i9MaO?=
 =?iso-8859-1?Q?73Q9azwq8zOIm+ibNYo27O+Yz9Gh/4P3ndc4ItL6d+NpgGGjaXcRWH/BhY?=
 =?iso-8859-1?Q?QMY0XYpIUICCaGwZ1HB3E2wYGf1ci2DmfDfqi5gDOyi+0vabg1dnnmVvBA?=
 =?iso-8859-1?Q?QhN2cIYoX16erxgFVDRuTAAJGYrGq+N3HIcTSsB7GImpsFejeKt11weX3b?=
 =?iso-8859-1?Q?EB549jx+tkgCj4rIWcKLn2XSK5iYuhsDECQU3xq3al5kwTxgNooJ5kcBWo?=
 =?iso-8859-1?Q?JIeHJw3xpZPbkV9ZZdjRW52A6p6qXrqR9TlVFXHpZ2fhsOJ4COKb6wQVgy?=
 =?iso-8859-1?Q?MmeLEoRbjFRRupG6mkh4MEXHL8S2y+SaKeIH7zZhPnVzhF3Qu+vQBq+Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b0d5e0-4426-4b09-8c07-08db0dd9f582
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 15:49:58.0782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 36CCI6EnfXppQit61TPZw6Avf4ovcyyjLG9rB5CYI5pdFZR0Gbk4aGvdlwNottocK3fk0sNOFMsYhhUEuwe9AxNFHUou+BH1cLeWtqcHlKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5384
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 13 Feb 2023 15:50:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14402

> I'm working on Yocto image based on=A0Kirkstone relese. I'm=A0trying to a=
dd a
> custom event handler to my image, to be able to catch=A0BuildCompleted
> or=A0CookerExit event. Unfortunately I'm not able to catch those events a=
s well
> as any other event from list in
> the=A0documentation=A0https://nam12.safelinks.protection.outlook.com/?url=
=3Dhtt
> ps%3A%2F%2Fdocs.yoctoproject.org%2Fbitbake%2F2.2%2Fbitbake-user-
> manual%2Fbitbake-user-manual-
> metadata.html%23events&data=3D05%7C01%7Cchris.laplante%40agilent.com%
> 7C54cb5a85a0a141a4ce2d08db0dcc7ca0%7Ca9c0bc098b46420693512ba12f
> b4a5c0%7C0%7C0%7C638118945468553260%7CUnknown%7CTWFpbGZsb3
> d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D%7C3000%7C%7C%7C&sdata=3DlAYX30mAIMLWWaPWINyzQBDF%2FJ4SjB
> EWpfeaqHF7oB8%3D&reserved=3D0

IIRC those events need to be caught in a bbclass that you install globally =
(e.g. using INHERIT in local.conf). They won't work at a per-recipe level.

Thanks,
Chris

