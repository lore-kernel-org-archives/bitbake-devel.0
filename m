Return-Path: <Nicholas.Jackson@zii.aero>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A177C63708
	for <webhook@archiver.kernel.org>; Wed,  7 Dec 2022 21:44:14 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (NAM04-BN8-obe.outbound.protection.outlook.com [40.107.100.48])
 by mx.groups.io with SMTP id smtpd.web10.29834.1670449448676162638
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 07 Dec 2022 13:44:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@zodiacii.onmicrosoft.com header.s=selector2-zodiacii-onmicrosoft-com header.b=ALoO5Hq9;
 spf=pass (domain: zii.aero, ip: 40.107.100.48, mailfrom: nicholas.jackson@zii.aero)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhSMPLIw7RSLCbasdggtb4HYwAy05W6ULOKhAQykaEKuu5ys19IzYjX83ThDbxrzxM7GWzLJVGRDlIBJ7LBTMRdRrYVhTaetcHtLyMwaFOkhv14JyhFcZZVaDL2tTzJihFWuct0hnoQH9Vk55/+PsOhPncjYOoa+CxSJYCZl5SzqbW6LOzU/0qf8r3pS4V7I2u+XmLh3c/vIQevHrQA3zc5nut0VV0/EQOzRtwvVJI/j05XcG7wM5bBXNtYGT7zV/5+XWOEYZLcxMzaFi8nf/NGSIPY9Q7R9S3fjJ+bZz83YnWvdm/MunkNis2Jz5VzQXcz72SScoqGcFJnmpJsuVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZgj9pcb4OxCi/09zyZ6WM8ndH6EM9tX4to1Oi1NPAI=;
 b=OtzRXiNnyhZ1L2tiDfAeJl4sBa80gqJKMjZNCPw4jygqz/3SXk+OXSx+Iybm24ybtmJsYCgl/HOYutGf+262RKBTgVRV1HJgJMPvUUyXtKO/JHyNVQN+Hq800VhEkrs5Kmz8NH59g1897rYv89gyceGEneEH4p1CMCikAZ2OfOvGfJ99QKGzxGgkZENZC5obrP7VPmeQxFttDdwY5Hz9JtDMe+5UVyNUMPEmqYiJqwfYy3HtMARo3lqeEFbYQACdPXwljTfkdJXCGFPG2CUt1nNSfP1nx/d9yRQfF5w7alCVgPcuBNqr59g0EJsDRo+SaC+EupI2rXxA+aJUnGTytw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zii.aero; dmarc=pass action=none header.from=zii.aero;
 dkim=pass header.d=zii.aero; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=zodiacii.onmicrosoft.com; s=selector2-zodiacii-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZgj9pcb4OxCi/09zyZ6WM8ndH6EM9tX4to1Oi1NPAI=;
 b=ALoO5Hq9S0FgQSabr5RjahWPVywK2VAWeArf8xqewIDknu9ow0597SI6tv7t2e5wI1gD+2F484v6lqjzgwyWwSdZpeb8HIKeIc+dOw9bY0JXdq73Lb16RecyfKYWMIzkus9ehRDYBQnCgPJGUULys1hy/SNhcWoHu1whvIVMZ7Y=
Received: from BYAPR12MB2710.namprd12.prod.outlook.com (2603:10b6:a03:68::11)
 by MW3PR12MB4377.namprd12.prod.outlook.com (2603:10b6:303:55::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 21:44:05 +0000
Received: from BYAPR12MB2710.namprd12.prod.outlook.com
 ([fe80::6ec6:f4b2:7631:95b9]) by BYAPR12MB2710.namprd12.prod.outlook.com
 ([fe80::6ec6:f4b2:7631:95b9%6]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 21:44:05 +0000
From: Nicholas Jackson <Nicholas.Jackson@zii.aero>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, Ross Burton
	<ross.burton@arm.com>, Alexander Kanavin <alex.kanavin@gmail.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake: wget: fix netrc with pseudo
Thread-Topic: [bitbake-devel] [PATCH] bitbake: wget: fix netrc with pseudo
Thread-Index: 
 AQHY1PXAIuJAgPf0bUqYJXLo7cYeDK34QvoAgAAAOz2AAB75gIAAAulegAALOIKAAAlZzIAABdWAgAF2y4CAADNiAIAN1gGAgFtgNzk=
Date: Wed, 7 Dec 2022 21:44:05 +0000
Message-ID: 
 <BYAPR12MB271034A16F7929B9ED458515F51A9@BYAPR12MB2710.namprd12.prod.outlook.com>
References: 
 <BYAPR12MB2710069E5D018DBB8F800AECF5569@BYAPR12MB2710.namprd12.prod.outlook.com>
 <CANNYZj_Cr5QO31dqnrNV9051M4fVh79Z3ayq8xF9DxLyRriDgA@mail.gmail.com>
 <BYAPR12MB2710359C1636EC9716B3EB83F5569@BYAPR12MB2710.namprd12.prod.outlook.com>
 <CANNYZj9ETtBH1mY3x3G2Fe4Fjyni7zkRMcA9UsYtpBcTznUQDg@mail.gmail.com>
 <BYAPR12MB2710778AF2346FD1E8FAD51AF5569@BYAPR12MB2710.namprd12.prod.outlook.com>
 <1719BDC7DCD0DABC.17026@lists.openembedded.org>
 <CANNYZj95vsnNLd97LzL7ix=JC9HCReJo7VNa80EymiSRYNgRiQ@mail.gmail.com>
 <BYAPR12MB27105A444B6963892070AE56F5569@BYAPR12MB2710.namprd12.prod.outlook.com>
 <CANNYZj9RuBP-btf5ATGx7pTqiP=-bzeHttY2GM=A9t+HQLo=5A@mail.gmail.com>
 <EE055CF5-FB7C-436B-A526-3A05FE023513@arm.com>
 <9cb6f8f622cfcc8a9fc68846acceb89734889ef2.camel@linuxfoundation.org>
 <171CC81646A2EFF9.4610@lists.openembedded.org>
In-Reply-To: <171CC81646A2EFF9.4610@lists.openembedded.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zii.aero;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB2710:EE_|MW3PR12MB4377:EE_
x-ms-office365-filtering-correlation-id: a3b153e0-d986-4d31-fddc-08dad89c29b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 F8OhC+IFkUI8EinqxPCgiEfw2jLULommPF7xF2yN+mdasttpr10dPuNgbUCzXcJAmF0Mxj7INjAyQg/RTff/l9WmMRCi3rVkECdYacTUVEG+eF+gwchvcSxxkqNKB3eLvkJhbE/Q5AMFKXZMntrHmxXUYLUpSJGy4Utg4hJxG8BzS9P0G4izrmRMR53JR5kM+l6cQsdodueaefNun8qHBvNPobzYIthdbTfRtrp2p6E2/DayayGu/nQkqskTj9DyTKpgRbWhi+NIzg9UVcaHAhSbHksLceNXRCeFKVoJb2dg9YIGzgcKuARAVK5JSJvTy1+7NJejcn2qMsY36zsCnw61b5bCG8K1kKbewMlTMpiML9urjnvxytP5VmHuJqxlSy33EOEvA6XeTcGKxqSVGTfhZsaBZi1b2B0woCFJdCfIWycc2RSKF7eiNYophwva
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2710.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39850400004)(396003)(376002)(366004)(136003)(346002)(451199015)(2906002)(4744005)(478600001)(66476007)(38070700005)(64756008)(33656002)(4326008)(41300700001)(8676002)(66446008)(86362001)(55016003)(8936002)(52536014)(5660300002)(71200400001)(66556008)(91956017)(19627405001)(76116006)(66946007)(9686003)(186003)(132210200001)(83380400001)(122000001)(38100700002)(110136005)(316002)(7696005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?KUQEfs2+hTrFqxwn3duKADrsY5Ze8ESC4jZj2PoXHNkZGCi77SOtMxghAa?=
 =?iso-8859-1?Q?IeV8ALMlGmq20SYhhl05T9yP4plQB2gzjRHngfr3N+hST6sM33pey8qtsS?=
 =?iso-8859-1?Q?1cOvgp1JdG2kEq/RD6wonqsfuc5J/HMg7afm6OF/H7k+YMtgHYFDOMGLRV?=
 =?iso-8859-1?Q?nZ5aTmbrxrDRZFL/nZ0QjxtLueo6GN/Zn41YJEu9gyCVsOIw2ZSHEdIHvL?=
 =?iso-8859-1?Q?0NpIZ32ofv5eoX3pNms+r7dNLWb2R1s6sSOWl8cz5ZykS3jX1Ai274Elng?=
 =?iso-8859-1?Q?eDMpMMfgx5wonwAj4mO/RuCCYzcqeo3bZi3jjArqVfVxnXWw0uSqO+j/Df?=
 =?iso-8859-1?Q?zujMi9Mx2DgO8jYniQf8gxrY1Ta8GPF1VTrKd6h3kU7QB84FQSd1uLRBH5?=
 =?iso-8859-1?Q?p0dU7+yUacEKJNoZAqVhe+wI1VwUKW3caGLT6vQsBkRM8QjGu7SFR9F/Lt?=
 =?iso-8859-1?Q?sk87ToFT4sa4mDEBQQsAeSgLdjFDmsEH8X2Eax5wKs8c8swrsvG4wMgUEZ?=
 =?iso-8859-1?Q?swCq35ESwGVSaUJs2TK/ooWPyqze9Gqt95MLK/8vxFORBe0CKGNax1ZbkC?=
 =?iso-8859-1?Q?GpwnjcVFjdHDdFNxDmt3BcmaMg0bWk/hF9h6t/3/PdymAtu3BR1+9KKU5m?=
 =?iso-8859-1?Q?zePvPYDpa2zy1SEYKPBxLP+joQV0x0wczu71Do6MR+C9ymk5rmod7DE7lX?=
 =?iso-8859-1?Q?9O8xgHwGJ9QcgemqJx+fF7TiWitg9WX0IuM68B1nYwhaY/FT7kpyFodlcr?=
 =?iso-8859-1?Q?Ewz+rRUvJcflaILEtw4u1JUuF/+QUSIiThq6IIiMOp/w3OM59m1Qi5upWt?=
 =?iso-8859-1?Q?7tOXn+yoPjkUwC43mPqcocD/2rhakFCBVbASRBYSSELW66fQmZja21y/0T?=
 =?iso-8859-1?Q?/mJfobLIqokmKuQcZKvOmtzv+xBHN+yzwKxGaOIqbXZuiXq0CQxLc2ul2s?=
 =?iso-8859-1?Q?ez/hKmQJLKUt8eqFxDzrraJnX1LqPUF+S62+jrg9ozs3dDoZyU70zm6oXv?=
 =?iso-8859-1?Q?3/1jAbOrJvdNY39AsojqPH50y46QEcdW9XiA8ftRuQo3pf/1mUx5zbLiRo?=
 =?iso-8859-1?Q?T4WnkEEoS64QEjF9WmXE07XUq9aPgKPu6ZiaHMInSN7lYvsQHk6SnKVghh?=
 =?iso-8859-1?Q?5GZQCh+kWD7xciHeg/YMott7hCDfw+1NVdKXj6ta+Nr0vpJO1p8w1X6oJ9?=
 =?iso-8859-1?Q?GjSn3H/N9ksFInofnc3U5Oe8hDYAdp3gZRbNfg3dhNDGYuIuIoq24p9bNz?=
 =?iso-8859-1?Q?uKI5laTsO00AQZ3iDyLFAo5XjwE3sTur50aJgDNX9rmx+zBqJHZeoK/471?=
 =?iso-8859-1?Q?98QY0ce7fzgNr8jcYCty5I4HDS7toODDUoMhjZjmJGHy6nirZKc9X2NW7h?=
 =?iso-8859-1?Q?BhEJYKxgiYKhwX8Q4Xv4wSM2SSnwfsv6sWOx1OklJbe9CjmkxsPtb0rA/Q?=
 =?iso-8859-1?Q?RXsydRc2ox+e1JAY/FpaKLcDvp4s0zrItWAGIeOmc8sCfG1+Eg/isunBb3?=
 =?iso-8859-1?Q?A4QaAYd3AgbZbvKxs/G/ZfwchqAHTnpEtV7PFMhM0bwsVOyUhTIaU57+FP?=
 =?iso-8859-1?Q?j7ymOmeCn0u/ez/5uEhfRYCGPIRR3Ubp84SdOb73AatlPeAFHScgCOFJT0?=
 =?iso-8859-1?Q?jd2mik7QXOnsOwEhIKDB6zzWUXAdByecSil0tXqI4IQifnaOt9rKAhs3tI?=
 =?iso-8859-1?Q?ytyaTX25R/L/f0NHJhXrAXGHZadeMAhdCfJhvW+7?=
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB271034A16F7929B9ED458515F51A9BYAPR12MB2710namp_"
MIME-Version: 1.0
X-OriginatorOrg: zii.aero
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2710.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b153e0-d986-4d31-fddc-08dad89c29b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2022 21:44:05.2153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe9eec6b-f00c-4ada-ad1a-58bc081dc237
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JMIh53xJ/w0Np4nEklt0QpzKzupF/+YmkUsgPQDr91i+0nh03Hi66VBGgwBdHvx0prtSYpzmukHOpal98weI2TqW4DCjmnfUfelEGDAOsYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4377
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 07 Dec 2022 21:44:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14147

--_000_BYAPR12MB271034A16F7929B9ED458515F51A9BYAPR12MB2710namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Ping

________________________________

This email and any files transmitted with it are confidential & proprietary=
 to Safran Passenger Innovations. This information is intended solely for t=
he use of the individual or entity to which it is addressed. Access or tran=
smittal of the information contained in this e-mail, in full or in part, to=
 any other organization or persons is not authorized.

--_000_BYAPR12MB271034A16F7929B9ED458515F51A9BYAPR12MB2710namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); background-color: rgb=
(255, 255, 255);">
Ping</div>
<br>
<hr>
<font face=3D"Arial" color=3D"Gray" size=3D"1"><br>
This email and any files transmitted with it are confidential &amp; proprie=
tary to Safran Passenger Innovations. This information is intended solely f=
or the use of the individual or entity to which it is addressed. Access or =
transmittal of the information contained
 in this e-mail, in full or in part, to any other organization or persons i=
s not authorized.<br>
</font>
</body>
</html>

--_000_BYAPR12MB271034A16F7929B9ED458515F51A9BYAPR12MB2710namp_--

