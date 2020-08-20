Received: from NAM11-BN8-obe.outbound.protection.outlook.com (NAM11-BN8-obe.outbound.protection.outlook.com [40.107.236.59])
 by mx.groups.io with SMTP id smtpd.web12.116427.1597948583253070950
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Aug 2020 11:36:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=l5+Onlot;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.236.59, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+08795Th+5Ki03D0G1mlVmX862nKlRwnaFngtf195FK3rTC7ao7b41i6Mxhsm1QzbZvQ+He+NJmYCu7ZYO0/05RYusoeGszsgd+s73ZllrxoAiNEC5EL/lBJ5vK/WSPLEsSa0ixvZFKKvTtBGNx0z/LO5PkM9Re/XybRTwXjunn9lMPMtnc+MUUjfhAOu90XsZxXNsgxiW/EVACFFV2g8cu0WIDlF6ylLTbdG6+j+KiNha24hQjCG82e0dPvuUJthcRKvvVKZOM+VVmNxoQrdFJkMidXEjH6VRTMaVyHRoo0NUcJs2+Gm4Bs5EhXY9YLvbhilMrAh0kduTMwhigpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50hqo0MMAW+tMxresdNLro0AG9RFgq4gOOWBfUASb1I=;
 b=DXB/7QJiafzCkFLEpz+pvsUXvIx5jELdYO8x2B8H74nLfhXmjOv+GJ26q7Y0tq8t3oHasHDR0KJlrHQTQipNLTTKypB4InaIcWS6y9cHlslp/7+ccBIUbOHLtCcKORNVUrSBJSGDuLoRxed02E1NJlEKwiFgUuSNEBNWJJqmKZjcpGDc4U6rtjvXLT0yCqA6AXJGWkLUAJorwUV1R0zZuhvd/NOjz1G/ChFBKpx+Zq99neC53D632gMLkPim+y2yGAn/BlqiPcQankKL70ljqsJA6OfEVbgpfrTLCg9fCMpQCEjOU+c9+ibH6S18KHFFF7EHVmVnCk4L0MtrgH+X9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50hqo0MMAW+tMxresdNLro0AG9RFgq4gOOWBfUASb1I=;
 b=l5+Onlot8iZfy+ZJaFOwunHn7p7APAawwY98GfKrrsisGge2cpfoAFNDEWfc4Aro3jWt88X5NbteR+eUoObItsh688zbor7PdlBnOzRpe3rebHHvyIAybO3dZqKdfhl05jsKVp+2PZZpceQiM3HdiLTSEawnPX/5MTmZ/+UQ5mX0c6NfBdwk8yDl8gJA8Chf9OCaa4dn30Q/VAyLqJGsT+uglL5pRexeXGQu/XTuAg1C4lxN1A2O3z82j3EJwJQb9jicIqIlhUrFH8ke3c7XIxgGOzdSv8/wbwsVDo5rmYpnWNmo9rbfzYf47TO/2/pxbvilSYS86SElzY2spY9XeQ==
Received: from SN1PR12MB2480.namprd12.prod.outlook.com (2603:10b6:802:22::21)
 by SN1PR12MB2576.namprd12.prod.outlook.com (2603:10b6:802:22::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 20 Aug
 2020 18:36:22 +0000
Received: from SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::4c4f:2633:b1bc:c164]) by SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::4c4f:2633:b1bc:c164%6]) with mapi id 15.20.3305.024; Thu, 20 Aug 2020
 18:36:22 +0000
From: "Chris Laplante" <chris.laplante@agilent.com>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, "BitBake Development
 (bitbake-devel@lists.openembedded.org)"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: Problem with shell func backtracing and BB_VERBOSE_LOGS
Thread-Topic: Problem with shell func backtracing and BB_VERBOSE_LOGS
Thread-Index: AdZ3H5kzgzO3bGd5QKaII5Jeb0tgLwAARxoQ
Date: Thu, 20 Aug 2020 18:36:22 +0000
Message-ID: 
 <SN1PR12MB248077C72B0B58D20F366F2A8B5A0@SN1PR12MB2480.namprd12.prod.outlook.com>
References: <a17d670e7def447793bf1db9880ae284@XBOX03.axis.com>
In-Reply-To: <a17d670e7def447793bf1db9880ae284@XBOX03.axis.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: axis.com; dkim=none (message not signed)
 header.d=none;axis.com; dmarc=none action=none header.from=agilent.com;
x-originating-ip: [76.99.179.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8df8a0b-9193-43cc-7a5f-08d84537efc3
x-ms-traffictypediagnostic: SN1PR12MB2576:
x-microsoft-antispam-prvs: 
 <SN1PR12MB25762BBA300C0AC251EED2D48B5A0@SN1PR12MB2576.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 dliKFjZJT0Dx99h6TY1Ph+CvgEiG/MfwQ8xmG10NiSFLamW+KU4mqNwhjEhMxbIfgD3Iow1f2LmnsdSI4n6WF+xryBoLdCxTQJcLjwPPU9Ioic4ZpBY/jzwTS0IMOqMEfLrHS9kd6CT0k+cWMytjrWXLLg12C/KftAdwLyg2Q4PR3Cns5URlTKasaBPtSK4doMaSYzAtGJ6Slv4WiCf67x4+kQLBlMFkrQAHMFOIztavYe+GyYslQLyrGQBtFXW3k3XOOKddZ/H4Q833tMANtgGOaG7QsOys6Xsq0iYlr5RreU3BLJv+A5AJi5HKOyTHP/d9vv70Fs10xGWjBHlITXhC1/dMivpkFadThl3SMDlNzkDU4kqucI7knyY1u+MR
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2480.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(29502001)(71200400001)(26005)(86362001)(6506007)(33656002)(186003)(7696005)(5660300002)(9686003)(316002)(2906002)(110136005)(66946007)(66446008)(66556008)(66476007)(64756008)(8676002)(76116006)(52536014)(8936002)(83380400001)(55016002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 j/fLAyqrI/CEYxtVmRKc/Y4IMHYnJNl12b0z7Fds8GkF45MeRRD5QcOe9SxhfIQ1SluHa33mxAmR4kDpuRL9VvFsnfFbeDNN4eFBpcW7H7uvQfDI4U+GAxpyxkUghELPCAQ453TV/oXDocn++eQN300o/LhYVP3n+GHb2KPZsUT4xc/b36B0zWmW/7vQu3sMpFJuIXevHxnNHlMpjfBDj2uAmEb08+71RfeOuiqOIOUY56RIT+SGdwN9CmgdgZqbbK25cOivqEhMF7Dc9L3xi0EToDFrcZWghcgtMdCYY875lw1XxZ16giqKawmnSeB3eXM5SB1RS6kCy9LKzADDtMp8tpzNZIXv3DQGssfeRGOYUFKZUCrXs15DGOtSGEMpFGLLpyHFmIBf7LiZeI7M29P+gHK7dPV5IcTSxZz6yzL9l1qE77beF/Ard1u4zKVdyzTljKh/yUOmvlc+HS0Gm7z2+ChMehiXG5mxW/jbr7ki73jO/9KGVPoEEAFwzRbiHlg3ulVkc8cS3A/uQCGgZJaK6Wg8Aa0+4lF6vwm7MwkqdYP47otvMt9BOfXGEfMTOukzGhMAcDrwxVmv8YA+HRQc36q+zr5mBlJxZY/m7pgPRWn5VQq1967BAKq6l/UTv+ixffbnBxPrMnqo3rgTBg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2480.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8df8a0b-9193-43cc-7a5f-08d84537efc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2020 18:36:22.0738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9YYCBhRKPMh8vNn2kbUyR5skcg/5LAx/GuhisXeaLrRewHUM5RHY0O15pnRLIxouFwN8PrqdDGWn/K8rKQtiyA0Dr4aptO5sq3hKmVGmwBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2576
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> | Backtrace (metadata-relative locations):
> |       #1: meson_do_compile, <workdir>/meta/classes/meson.bbclass, line =
180
> |       #1: meson_do_compile, <workdir>/meta/classes/meson.bbclass, line =
180
> |       #2: do_compile, autogenerated, line 2
> |       #2: do_compile, autogenerated, line 2
> |       #3: main, <workdir>/meta/classes/meson.bbclass, line 185
>=20
> And the following is the same build failure, but without BB_VERBOSE_LOGS:
>=20
> | ninja: build stopped: subcommand failed.
> | WARNING: <builddir>/tmp/work/cortexa9hf-neon-poky-linux-
> gnueabi/<recipe>/1.1.24-r0/temp/run.do_compile.6232:157 exit 1 from 'ninj=
a
> -v -j 16'
> | WARNING: Backtrace (BB generated script):
> |       #1: meson_do_compile, <builddir>/tmp/work/cortexa9hf-neon-poky-
> linux-gnueabi/<recipe>/1.1.24-r0/temp/run.do_compile.6232, line 157
> |       #2: do_compile, <builddir>/tmp/work/cortexa9hf-neon-poky-linux-
> gnueabi/<recipe>/1.1.24-r0/temp/run.do_compile.6232, line 152
> |       #3: main,
> | <builddir>/tmp/work/cortexa9hf-neon-poky-linux-gnueabi/<recipe>/1.1.24
> | -r0/temp/run.do_compile.6232, line 161
> |
> | Backtrace (metadata-relative locations):
> |       #1: meson_do_compile, <workdir>/meta/classes/meson.bbclass, line =
180
> |       #2: do_compile, autogenerated, line 2
>=20
> As can be seen, the frames are reported twice when BB_VERBOSE_LOGS is
> enabled. Also interesting is that the third frame is reported when
> BB_VERBOSE_LOGS is enabled (though only once).



I definitely am curious about this last bit though. I wonder if my regular =
expression in build.py that looks for backtrace frames needs tweaking.

Chris
