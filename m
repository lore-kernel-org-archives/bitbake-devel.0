Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79837CCD193
	for <webhook@archiver.kernel.org>; Sat, 18 Oct 2025 10:17:16 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.66])
 by mx.groups.io with SMTP id smtpd.web11.5467.1759989503163022143
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Oct 2025 22:58:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@leica-geosystems.com header.s=selector1 header.b=ja9N1Wh/;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: leica-geosystems.com, ip: 52.101.83.66, mailfrom: johannes.schneider@leica-geosystems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WI4Ikof43BIVa/qK45ALdADQEALHz8Ipaup/vODtQBWWTFn0nvwj9HJEIArMdlKP9g5PVNchR4qYkmdNFzxszNZ+7L12sKm2z2Vztuf7Wn2DFOHEsOnPwthAaGLU79GwpEhXbqgfqK+htW+fOsk+q3ShTZc6wKcGHg4HXZy8K/1xprscnBqQGA2VeHz96Iiu2KhkeLQnCaxic/0AMqYt6r8Pj8OadNztqC1eTdA0t2KGVBY2vuOZvb/WCv9M+RAhJRLDOdsjdTY03wA9EsNuUOp0JMgWwppjPHlmIeiVIcx93ZLZkVpXU7EgWRtF4huGFP8ezpBzsRsPM2FXHjaWjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MaRlV7r50Qh8Po07GbcO7XC2Xa4QXBViK0/2OUa43g=;
 b=T8am4DvAzV0z8qf8asEzlBAo5WaWDEZ89mdebMM6Bo8t9uWrwca44WkRGuC4SLBx8q46czGj8pHqa4RGQhA3mcOU4T7aRlj1LDxWXxqNT4Po0pPzvGwrw7FH7bliD0PEf6clveZjUyZpcC0wjci9VLTLi/Tb1Qr8xFDwDL00cx3oqfuRGlYUCgal9QGMOPJ8yp68qmImE6a0VdEp2EI6wC8ryRQADiWFwtPkxYCHSqS+1nwkNMeTDhhLy48+R7JGLts9gELNarW6liQDkjXocxx0rM20+zwgRMLrvGg7/Cor8Q5BK5O9MSC5XjoI65btRg/1gxkyUdtyq9qo2sNE6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MaRlV7r50Qh8Po07GbcO7XC2Xa4QXBViK0/2OUa43g=;
 b=ja9N1Wh/dD3kgLudx7LilbPFSNi7l2B0xv9ESjnYMBQgue3ySXXCtOMyDpLIoCiw7ZcD0QJTeFbUYaPDOtV91P6n7iYCbxPGIe1KJoCQxEp3yA55UkLYde6uMlcM2EdkpS93GEtwJMSD4PH7Azly7JY9PFgdcblnFZZygR3uPYc=
Received: from AM8PR06MB7521.eurprd06.prod.outlook.com (2603:10a6:20b:355::8)
 by VE1PR06MB7071.eurprd06.prod.outlook.com (2603:10a6:800:1a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 05:58:16 +0000
Received: from AM8PR06MB7521.eurprd06.prod.outlook.com
 ([fe80::1797:2a6b:ecc5:f7b8]) by AM8PR06MB7521.eurprd06.prod.outlook.com
 ([fe80::1797:2a6b:ecc5:f7b8%6]) with mapi id 15.20.9160.017; Thu, 9 Oct 2025
 05:58:15 +0000
From: "Johannes Schneider" <johannes.schneider@leica-geosystems.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 1/4] bitbake-setup: support adding environment-passthroughs to the init-build-env
Thread-Topic: [PATCH 1/4] bitbake-setup: support adding
 environment-passthroughs to the init-build-env
Thread-Index: AQHcOHSZDB4am6NEIEmLdEmDrRyEUbS5UVC5
Date: Thu, 9 Oct 2025 05:58:15 +0000
Message-ID: 
 <AM8PR06MB752121E45584057207D685CEBCEEA@AM8PR06MB7521.eurprd06.prod.outlook.com>
References: <20251008165659.1884881-1-alex.kanavin@gmail.com>
In-Reply-To: <20251008165659.1884881-1-alex.kanavin@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR06MB7521:EE_|VE1PR06MB7071:EE_
x-ms-office365-filtering-correlation-id: 8e3833ef-dd12-4659-1f28-08de06f8d666
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?C0IfKH0zr2fhGYu1G+3orjtwczLabFXjvC97+NOJzBiR4U6CaZ8x6Ci8Nm?=
 =?iso-8859-1?Q?qjgsvwIGYgHAsxlaQ9DUhw+hH+s0wRAMwT8u7SEHQp/PkKoUp0flp1dE0M?=
 =?iso-8859-1?Q?Lle18kkBKis/A5WbdMGUrDSQZ7HiOfj3qr5+Tat6LfgZt/FQrxR7JDTbMo?=
 =?iso-8859-1?Q?qlVMIgm4YEcczOKyn05oMKhKcwrGrsR4WbEis6GIb99mPTnSHmitoBR3fC?=
 =?iso-8859-1?Q?w604+cS95xxs9H3KW7z+8wIpQDHAdzzv7yPobI5JpOe168gy42VTGkwRsw?=
 =?iso-8859-1?Q?zMl3x4R3kDI0FvHADOD/jyqoX8Zl67s+LChlxP3mSK/okO0hEZRZs6pVXD?=
 =?iso-8859-1?Q?8gOeKAgz4zZvi6oOTM/+V/H0AHaWlvtET1+JRqfYhXCWM8PLjritjbLN2h?=
 =?iso-8859-1?Q?7CJVnNb8P5XHDGJM18x1VxTZhgq53KL2mYIJHdhixkStFghtBLT3XjMTVo?=
 =?iso-8859-1?Q?9KwFP89QRUxOwveYsqRIk545IXCZoqT2do48Ws7axPgc26T3pknXQvIHEw?=
 =?iso-8859-1?Q?amOWNXeo5UeAWAPmMWDb8Ut/5opw4QqQ4/BrnGPFOu4PyMtnSoTH3kmsl3?=
 =?iso-8859-1?Q?A67h1NdbAETLfMDsQtF5HBh40zVGCwiivCvDzlMzsBKEVmlzF0rLTqMpYI?=
 =?iso-8859-1?Q?KjYz8isK1pM6SPpI6ymw3zi0cGQ+irhk0fS/uzizfmx3ytFFGl9lyYPz0j?=
 =?iso-8859-1?Q?GqEsR867l9Dq7WkItHYgkgATQyzUoQIfKkVyZOL5huBlK+GuNjW2PQGZDf?=
 =?iso-8859-1?Q?YFdn+hhvWEo18GwbGvSeUw7YowopTmoKlCqVkfRWvMaLxyugO5pA0C+EFn?=
 =?iso-8859-1?Q?86dHLWVGpq7ySBrEBrD3eD9vb4h99Rs6AIzSdjhGLy9WoibQCp8ssyjvXj?=
 =?iso-8859-1?Q?7mN0sD8mzLHFH8MPt1ucMQrmPxMCGR0akKPA/vgsOQRMV9SJNRf8/8m8lN?=
 =?iso-8859-1?Q?VqhkUPVrRXc4jq5rVErN4+/j87URrBl0ZN6JMY67hh84941zRKYyYsOC1o?=
 =?iso-8859-1?Q?VfrOZ1hv56u2jnQyVB5KrDMTiZ8i5tOy/OHOE+Wu21cY/+0jHXb1Ok/Wke?=
 =?iso-8859-1?Q?CKwShtYByi2ebvhZxYvtcHMtWFkYbOv0GNcUJdD4TViDjYiqQhE0ozAssB?=
 =?iso-8859-1?Q?etY8vyh57X6+EEJp6W9OSAucETtvlrcsLFxY96IPPkhWe744Yy3VlOAQZT?=
 =?iso-8859-1?Q?oWrk8yS60x1VfQ6k+P0Rl12z1pPz9RTuI0nPchQW70Xibkgn/6kIp6ViFc?=
 =?iso-8859-1?Q?Y+szsH85FBYMeeEdsnVH2lgHOTE4Pxyb6nInKfFylyMG60ZQpbVmyOcDZY?=
 =?iso-8859-1?Q?OjjIEcK9yoJfqWnhod72jXzHnIM77EYjhIhZ/C7r1DtweRNXFr+cJgKv9d?=
 =?iso-8859-1?Q?jTVHX7u3bvMB4Yv0FNxDzuKwI7cMYMLkhQpCM8iTUWZ7hINKkCdhCWC4c8?=
 =?iso-8859-1?Q?3at/qZaRWGFMK70b988e59jZfY/2aD061kY6EHcDgDo1l+pj9gZGZepMvB?=
 =?iso-8859-1?Q?cj3GF781NBeYq642wegoDD/B193dabgtn0kCM7jfUNdomRa3JVOUFvLRqR?=
 =?iso-8859-1?Q?p3ah5L7DqNwHrClJwPssMdPi0CE5?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR06MB7521.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?WKIk8rhKj05d4OfSqXaIZi3lNp3nzVUPbsJ7nQSm7VV0x+temnsTbVaIGD?=
 =?iso-8859-1?Q?WPEcHxQ78enrldhhb/t8Xobt7kbN5CFpkngT0XrO7CYBQkOSs5KhG48VVS?=
 =?iso-8859-1?Q?LJcM9KKdq+L+TcQ9JKWFwOTfihVGOHrEfYv5bn6UPp29UT/or6DSpcEOQ0?=
 =?iso-8859-1?Q?x0Z6zvzgAbL6pvBMPrUTyZ4X7hoVXI8zhqM1T+gIek6rcy7JucesG5teix?=
 =?iso-8859-1?Q?q2ggpMg1O9aWY3BYEum1bxVHVCdhfBuzQoWlJ/EmKeFWSK2XTudY1vXdaM?=
 =?iso-8859-1?Q?nqYqiaOuvwCZSB8/tldhEjgyu4VGQnNduEP5y86F/mulRai0pqpxDMknGW?=
 =?iso-8859-1?Q?wGAGN6CBn8qhUHg/yt9wFoE4Db28kMQM2YzJupF4j3z+uJ6jqpRErjekJP?=
 =?iso-8859-1?Q?rXuU3w0t2cFMFJQQGSCoJGIFdFKbpOfcQQzx8STA4x08OwR1VVt0nZ4HnH?=
 =?iso-8859-1?Q?3Uf5Qs9fclNwcfdCZXwpayrjVOEXZqJj+0tMjukveGWwNjzgdZlW5Vbaw4?=
 =?iso-8859-1?Q?6tenXZ+fUnN6wAS1cbCc3v7KgM01muu7NXqGTtzp3tvvoIE/93aeUcqZ6I?=
 =?iso-8859-1?Q?jMWFntg4KaZCyZc7tQDNg0ZbPZI/9W0hKLZCpVAfSq5o0/DAnzTKWm2g8n?=
 =?iso-8859-1?Q?gPw4GNFFyBKzIhKhnVH23BsHHQP7ZBEnZuvjywt5DT2wkLkrtwNmDupqHE?=
 =?iso-8859-1?Q?JYQCuBOaZ+NMzNwsDeCJ5fbSaPD+3REyIvjulw1qtn4X6woH8s073idEBb?=
 =?iso-8859-1?Q?UNjl4ay0K8rZo610baqvZg4KXfwWB3pOJlTREheODsag+ApUvwA7G3IMPa?=
 =?iso-8859-1?Q?Cx1WKT4VNSizHnZCu7dlAKwWu+BcZRp/DEgpf5i7zYU8jghz6j71z6LkSw?=
 =?iso-8859-1?Q?2UbBtf2Hi3NMQVjaEwXHItN2iZQ/+1bAni4Ojavu9fxWI51XQoVINFVzUj?=
 =?iso-8859-1?Q?FSuUprdjcQNELpCckeaiO1WKw1GQOZLkeG3G/LNk4aIRBBRIeN0rADSqvX?=
 =?iso-8859-1?Q?OyPKF86dLW07TTPTApdPWpGKHQLKIPru/TZtvUxRSxIeQh9vf9Dtsp4fEa?=
 =?iso-8859-1?Q?eL4RLyJG1aR/vJxH6p27wBStFUZNmhOoO45pgJUyY6QUxDrwPprs2+ESv3?=
 =?iso-8859-1?Q?aoh7PEgGoFPB0H3Vb3399jXJPZy0TfDQ7Y/oDW/jgJGWloYrQ3H3u0ZgW9?=
 =?iso-8859-1?Q?0KONW/oLbxiav/U4L/BtQhhlW0zuTDK3YKM78p+/11rJONqo4PF4/zepkr?=
 =?iso-8859-1?Q?0SsRzBpyzbRuEJrImILVCys952ikL+5UhD8K7rreRpOStJ6W4j0xFf6298?=
 =?iso-8859-1?Q?82qog22vdfXwYXxLKqAUpY0PIBszuSpi/3jXp6xvY9VGnICw11XP1tEQA2?=
 =?iso-8859-1?Q?IncYjq1jJ1/VzjqsumvT9znAdTYbpkumcKCkDb+laylfrvi3Ft1RMvHEBZ?=
 =?iso-8859-1?Q?rnzSGeS80m2uBPqS2GxsP4x80Xf8AbbaOZen6zzcYkpBZmbRQ8bDCmkPAh?=
 =?iso-8859-1?Q?MXwZG2ZS5ShrWEnTo+mJlruBtJ0feTV/xOBcZfU9SmcqdeCoazieeUb8XE?=
 =?iso-8859-1?Q?3X/ck3Hpuulcaz+ol/gqw2WfV4pOYqbF2BmIEPxKHhulv2KddOa6/EVSvr?=
 =?iso-8859-1?Q?sMGUIzuLKsrbTnfEdRTEEGRwYh5nbjn1JyBUN0RDCPfsT/+JrR2xnK+2Lw?=
 =?iso-8859-1?Q?45c30CsNMizFKifwAiGQ2Xqrf4achcXIbDkqy0dt2CRU3eulkfL0vox5cy?=
 =?iso-8859-1?Q?RXa+zNCc13DKCYylNMiKr1jk8=3D?=
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR06MB7521.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e3833ef-dd12-4659-1f28-08de06f8d666
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2025 05:58:15.1616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hL3eeebUGUx3GL/8PQSFpOJInlGfPkgVc1yhdsqnmTyQ/mULY9SdZwxfbIkLu3zS8HM1KcyhBiEezgw/0eucTAxX8YFC1sfvHqFwb7kn9b0X8IrcEXm9XHmPuvUYq4zn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR06MB7071
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 18 Oct 2025 10:17:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18193

Hoi,=0A=
=0A=
=0A=
and thanks for porting/pushing this from github to the upstream mailing lis=
t :-)=0A=
=0A=
=0A=
gru=DF=0A=
Johannes=0A=

