Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A412C25B10
	for <webhook@archiver.kernel.org>; Mon, 13 May 2024 14:55:30 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (NAM11-DM6-obe.outbound.protection.outlook.com [40.107.223.67])
 by mx.groups.io with SMTP id smtpd.web10.62546.1715612127870899347
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 13 May 2024 07:55:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=ZMnFjK88;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.223.67, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBIr3c5wRsCrulC4Lhedu7btcq5MhXjkSKVhdFicBx3c6BeNbHzCeb8UHf26wqKNFQX4oKVbtmdoQmerx3BG0OV41ujOM624p4bKJjo0PdD7qrBv/NXy4kyu2Jby0lTCQzakwhoZnLBeQPomv7+CdHJHg+6KSJubYJjQQtLFNhNqRol1cUQjKU8JZfaRHil/XGejugoX2Hd4oIflI6BsT63TdxJE5E+/vW3V8qTFxVfms/vUFCmXCtNwjVDKPoMJaUYizvpg7j+OE23Y/Cqn25rqN1LE8eRQTL2U0LCiS5ey5t22FioXVD0TpcNVJL3Nv7hpEUvwOlm8YbfCCL+evQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUsvwMzw93ObRZ3GiWd7H1Rf0x2L+8fKRHGpBEbVahc=;
 b=Up1RCtV86qtwUdR+fXeMb/6kbCIh+QbBRCBqUkmezaZ3HOqQg9spZfG3A1SCb5+jYexAGWTiCtQYpGD1mkAeoIYs8iMqvvVcX5GeQnGKzs98Xw41Y8aUjYszjx/N5Owhj6PTJqjQoqwYENO9DOq1ETUTP3Bwl/CBJhc+MC7/Y0xxxhNE2EgPJagKzhoxZ+s+Rk2RhdlWAypd7USHNGHVWnHlbE2UWPUZG9E+UqH9B2Jfb8jQXBGoFmVro/ZVHp9f37+ZNnu28moA2AZp5XWfJcT0rFmBMgTzAfjF37OkUiYmL1z+fo/r4aQDwnqC7ABVcaW9DS8BvV5zMKN+CPuYzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUsvwMzw93ObRZ3GiWd7H1Rf0x2L+8fKRHGpBEbVahc=;
 b=ZMnFjK88zbpW+Twhc6wfTowYBGfg9xfCGVNfOI9UaaCEa6xaoeS8d5WAIzapY2+YfxD+Vh/d/dIzpI3qQfBn5FwyBaIH1Z5yXQ+oEuiwcgjsK/FXoYrIyKYfAjySFo7qF07blEZvMo7LAtK68kZZ3bXvc+WJYKnVmoXalORmPCE1dj5DSJ5e+5vBf8yWN9+kwOljW4h5oq6KgwtRDrbOJQB9Gx5W5WOVJJx7/w8yLVGRJ63EUczhM2Zsd5uHpTJ+XJ35GaGVOrDuH7fgLezdnrOH4VWLMjj9W+jYY5e7sRSOmMyiiIB6DBXmIoqhZr3jrZVSnaKgUD5u3qGKanjX+Q==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 CY8PR12MB7537.namprd12.prod.outlook.com (2603:10b6:930:94::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.55; Mon, 13 May 2024 14:55:25 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::52e3:4980:d382:6e60]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::52e3:4980:d382:6e60%3]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 14:55:25 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
CC: "behanw@converseincode.com" <behanw@converseincode.com>, Michael Halstead
	<mhalstead@linuxfoundation.org>, Richard Purdie
	<richard.purdie@linuxfoundation.org>
Subject: BB Datastore Playground preview is now live
Thread-Topic: BB Datastore Playground preview is now live
Thread-Index: AQHapUWWn41IqKNp/kuGIX4/Fwdjrw==
Date: Mon, 13 May 2024 14:55:25 +0000
Message-ID: 
 <DM8PR12MB543006B728DBC2C6E7077D7A8BE22@DM8PR12MB5430.namprd12.prod.outlook.com>
References: 
 <DM8PR12MB54305F122A263BB3B7AD10B68B4E2@DM8PR12MB5430.namprd12.prod.outlook.com>
In-Reply-To: 
 <DM8PR12MB54305F122A263BB3B7AD10B68B4E2@DM8PR12MB5430.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=4db4dfb6-63b2-424a-a5eb-d0aa35bc4a87;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2024-02-14T16:13:25Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|CY8PR12MB7537:EE_
x-ms-office365-filtering-correlation-id: 10fd1529-bea5-4dc4-7e10-08dc735cb89d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?wYkTz4f/8736XAM9HJl5tYu5/SLswNUU2dCGgkX8CW7nxAf+aA0OYv66alYy?=
 =?us-ascii?Q?3ljUo2KPxpsT0hxtd5xP8cPIsNN9HJuPQw34wE3MEyULb/UnPjfkdGmTmqwf?=
 =?us-ascii?Q?l1R1MMg7klm24vWKWb6GqagJryyuYVleO8A5V7fwaaYLsSzVypo7dW14HMjd?=
 =?us-ascii?Q?aCUHK5pusq0j2ZE5cc2aYBorfbSd0KoOZCasUkk74/U7ZaVau6JeTtC1VghL?=
 =?us-ascii?Q?DmzqvrCYMBsjnYyIt9H3Ns+4BV42C+t1mOatJTuI+Zd1rCCVyUvH6MtEGG1V?=
 =?us-ascii?Q?tMIYYYOu6fXEo4IDHs27A8qKPdjjutOWpij16NzFqPo6sBP0KqH6OJwlTnFC?=
 =?us-ascii?Q?t68wUn5wezI4SJPYx7bs+vC3K27XDgBMOxMt2YuVzK8c39H1kTOUo1sd/xS6?=
 =?us-ascii?Q?7a12ffj7H3XCJMcUK1E0KQ/FQaX7KiAKeJKn0FfaYtE6jQK8S4pRo3DsJ/hn?=
 =?us-ascii?Q?xyb4qw8wjN+kyoWHtr0wkYCIDwIsm0CXvohB15Jq34R/BfsYTMekC8dQCblw?=
 =?us-ascii?Q?H8YqRURYdODT01m+FWqS4bAzXTXjVelTB8+FPaxzAu8ktVNt/S2lJBjO8g9z?=
 =?us-ascii?Q?HUeG4PecrIn2XuankjZRHuA4uBVzXKXjRRvOLrjXkxDMTYLMS2bljwmajBY/?=
 =?us-ascii?Q?1Qi45cinCKXAkLtof8jaaOCANZIIHWxdk2PCfG67XREzmcKpGwMI1yhEKpb8?=
 =?us-ascii?Q?F/0q1BazDq5iR6aj2otxkM4znv0tMlqDTGN1L4bybbkrhcA6ZW0OFQw8NPiw?=
 =?us-ascii?Q?PKJF8p9/K3kr/a+7BlDhRGHexQL0XaoZH+sa0Kmcd6DqzVj6eUj1CihjdIL9?=
 =?us-ascii?Q?pG7hxSIpTs/SucRR15tlw/A3JkqVrGHWKzs9nB9gmQREB1+MP1wZ84dJuXGy?=
 =?us-ascii?Q?DI6uOku2Vm0tA1krkVHED5NCHPaSxmtv8Vzbc7AHQvdlsdxkRKk2YP9ZJPqr?=
 =?us-ascii?Q?Aof7U2JjflPUDQLgx9T1dJT0X08cS3g+/l0gAVfRTcgdI9Ul78wafqAtN7Sf?=
 =?us-ascii?Q?iAB9bbz3NGme7yP1rQt17PqBHPTlX0V6ZWDyf7vPRfj+hxxZsMqYVfY69xNO?=
 =?us-ascii?Q?4SvksbtIfC4Y89P39SkZ/xMt7IbQLXsrHoNE8HnnOVeESiN/IujqTTUCiE3y?=
 =?us-ascii?Q?eQFNzUBNi+Ls4+gklPm0M8vDrdwZIVcITMU6phxFZv9WTcrLAcgfXzTRd2Xv?=
 =?us-ascii?Q?DI18H1mQEOrzHMVt+w55WrOoEXGCrj+sXU+vYSAZWGQo0XLR1fGOTFQYFJAu?=
 =?us-ascii?Q?NeGROD/ygaXDYp3OLkOEyCtbIOv+0lgbwC0a1Y7fvQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?ugK5iXvkFlQL9cvqNakPO18GbKj7DZno/4018hEGsVu6xvjxm4NveKc9FM4S?=
 =?us-ascii?Q?LVSbi78IJbNnN/+JbqziENBrzKvoTtbDWBoHicflkO+K/EXFnFmHqy6Gfr8W?=
 =?us-ascii?Q?1pOqDehSe7kQwiskksEreRqMP5wBs5MKuZCG01CpJQkBmYeV8RyvTFBYfZHn?=
 =?us-ascii?Q?VPoKxxD0u5NExhZMBZCr18CoJ0UU/ycCnoy2DuushqpusBsSYgdugJNUgiRU?=
 =?us-ascii?Q?rCY2rHAy4SiPh2bDwBDrJdK+Ae502X+ylRv7pIPj6SPm/PMhP+xjuZ/yZt2G?=
 =?us-ascii?Q?Qcu9uvfP8oQ5AXzpDJ2rgNmotJChkZ07Woy2m646+oFsgcJfcMUyswNGt3rk?=
 =?us-ascii?Q?P1h4wDfkCYZ2n3w80rcGzz+CfZkDAl+/3Bfw6DHTisAHtJ+NNweQi8RCiISP?=
 =?us-ascii?Q?Gd7pbqtXNnlI2gI+zyDDM5BeKQFTfn9nNd6iQosyrYtqKR0x9JACogdNi5kT?=
 =?us-ascii?Q?QuWoAM0jqAN8xdXGmyXLDeUHHFV+025vfjTaPjoCyQT5kDcdk71CK8awOwXs?=
 =?us-ascii?Q?hrfIFbMoVRdSKTt2UF07X9NwOhxOAdD+agrgc9qrKb3d4rA9Y4NNC+AUHEiB?=
 =?us-ascii?Q?Vzxy3bcjg1dMZkgSfdkkBBLRRNOhmUuxOk+VlZcaHu+U1D/6rpM0eMMh63Vb?=
 =?us-ascii?Q?oGm8/4rTCio5DAwo3TYuJxqAAyWxRdCM8v892JFC/hx0Ymi0Zns92LUXvwG/?=
 =?us-ascii?Q?zR/YFvV9lSsQUaKrJovbfGBthkusci9pSj4z/gLX+2iSoT8xWi9oKh9bmULO?=
 =?us-ascii?Q?gPF3nTuVUeFiphNQQsV+Tlv+riF8GyXB9jcPIiSfuAZ7cG0UZeOAs6PyKTXp?=
 =?us-ascii?Q?gVmhA4VR1nC39MxpKBsT16WswDSG1qj3Xn4yAZ1Nky86Pfu0MrM9+hk9clGZ?=
 =?us-ascii?Q?ugcjm5XFduxKtBrJRuvIyoo6S3bnpZs0+dqzYsMgakd437r7TLTAVnQkstrM?=
 =?us-ascii?Q?WQP/ZB3z5A/B7jp+DZIMQ09qRVEgAW2l0LtEgLMD/hI5nkAtQZmnwf8/kuAt?=
 =?us-ascii?Q?zD7FBriouaVXee2G25nzZPudSaFer7YSvLYJ9fTYru4Q1p/nOs4JFhDmA1Rh?=
 =?us-ascii?Q?B4q9xDu2zYPQ85Ae3oIn0Jy4v9cjrgpGgonhCfTwrlP/TmcIDSK6WGkM++r8?=
 =?us-ascii?Q?p9uOmdU/xZvzEWEayk5Q5ptoU01eyfSsSEBfSLKfqD5f+Jf8Q3WkHq6CmiyR?=
 =?us-ascii?Q?KqJ/+PWaGBNPI+gGIjoTb//yCbxFgVK1KXDTBwhfxdJ8Xwb9R9atReIuUfU6?=
 =?us-ascii?Q?9s1m/wzFajNSrhX7i0Y9SgySgUa2PcyTqDNE+dg7eGI3P1AOOtnFrpyJ92ak?=
 =?us-ascii?Q?Wa1T3Ht5AorA3bzv/740L8CO+PRvNL83UTKWSpfn5CFjdLRHwwm5SkZbmvuV?=
 =?us-ascii?Q?q5cQ28eoeLiekV4VuCqeiU/6xL7fqqY1duzBohzxpsiwCuOSOtLB+ISpnswf?=
 =?us-ascii?Q?y3QXW6FmQuB8dreGBUPPN5H+C0y1fxEmmbD2ThhftndApaJ/h+CfN/S+yVFX?=
 =?us-ascii?Q?uIyV1LCyC2RwsuVBaZGOzPwKL7enYCa3hkKiS+tkVgkBJTzqabICcZiT3VM7?=
 =?us-ascii?Q?oL0ulTMwDduA2sDMCORK8dP9ppuCMAmbJJtIMPuAeXz/1ZExFnTvzcm+AfiD?=
 =?us-ascii?Q?tw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10fd1529-bea5-4dc4-7e10-08dc735cb89d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 14:55:25.1234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dVoB2KLw1Z2d7g4vlcduiftzrHtWZ7oLk64UsT4Q1t0qJuzhTd+MZAM+Rf3jCoCgFTnKhMH8wvh7e7gmCd32+ioet7vJLxpPv8Gwe8WX2SE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7537
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 13 May 2024 14:55:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16208

Hi all,
=20
> This bug ("A web based playground for experimenting with bitbake variable
> expansion") has been preying on my mind ever since I read it on Bugzilla:
> https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D14805.
>=20
> I'm happy to say that I have a simple proof-of-concept implementation bui=
lt
> using Pyodide. The code needs some cleanup before I feel comfortable shar=
ing
> it, but here are some details:

It took all Saturday, but a very perfunctory version of this tool is now li=
ve :). Check it out here: https://yoctoproject.github.io/bb-datastore-playg=
round. Many thanks to Michael for setting up the GitHub repo for me!

It is basically a Python REPL with added 'bb' goodness.=20

It is very rough - no styling on the page, and it doesn't work on mobile. B=
ut it is already useful so please give it a try. It requires a modern-ish b=
rowser (though I haven't categorized what this actually means).

Next steps are to add a Godbolt-like editor and 'Run' button.

Thanks,
Chris

