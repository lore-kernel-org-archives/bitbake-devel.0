Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCA8D5B84E
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 16:18:26 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com (SN4PR2101CU001.outbound.protection.outlook.com [40.93.195.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.52887.1765815496210902043
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Dec 2025 08:18:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=XylQaFbC;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.93.195.47, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9EORmwptQ/vgj08+qNRAH7iUHWbef3IW5WkAHGIJW3quNzEerGHB3blZpuwDlQdR1gt9j+7Bi7k9aG2CU2T+rxlXE9H8Dj3LJbXOZZmE6I9fOnxWq63UV5kYfonI5Vwwp4Ib+MEuV22lXiNpezxmnU8MEIiApF0ZY9sDyyHecRwTzUPbnYVK4FWuYJgPXoQvJFn5yCnwV3WcPi4UxlyFIzo6S7Yon05xHcZmDk7cH4Emft3ovqA4fbCB1+h7IeVoc97gYX6zVuCPHLniAk3oEuQ5uM72iwJ+4jYkQzQ493GB6zlhWGhLeFLcKj9g+aOEkAzEa+Gp7w1dXLMcvXi8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyg+/VYKpG7Y7BfqqucS4RRpiDPw2ZNI6J+RKRqwUj8=;
 b=e2TBETbdWZAJyuWV2LTXFNUYipaWoDVhxYNPGvBlIGNlqUSnC7ycjMvIASPPG91zTiS5Wbv7QR3kabV+zsBQHkg59lQ28zd6oE2fhrT8dLej23Lnwgel0dpJxutSjZ4OavvoJVpsaZLZLiM0zTbIPqKMHqVF0SgV5NvTh2ixuIylDFeG6CICsi3AE+R7yzluUn3yP9NlZh3hHyzwP3YCej0OC6RW6ckgB1t0ntVxrHByRHanIXRtUx/Ih/cdHnxaE3kyBtB1SVqTlNR7vQINtXuwbRn1J5AT00vVm0HoCg/b48vkQTGU1182ihovolFdvNN5Ss6gy56nOPkPOuC9+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyg+/VYKpG7Y7BfqqucS4RRpiDPw2ZNI6J+RKRqwUj8=;
 b=XylQaFbCBHq1pGmp3WSoHc7L8ImbHSeh/jHTIu5Bh1ltQ/lwPMa5DlOpPPiR1NUfbaGfSJ63BXMKlmThQdPXqrEbaqfDZ0T3xDx+pfei9eeuSay0rqI0K3aH79z2LhT6+X9XpjOC9/JdN+1KLE8lK6iOlXh4amtGLk4xbfoXqvS2hq9kXDg3hn7ECGcFXjEWZLB60kFf+dAAl8qA4GZtx27bqV/kNDpfJt84b7rCcaZ2nC+rvMfEdb2Jc0P2r4TnV2FwQfbOe9q0reAchVbLCvRWwUe2YW2+UlzNxCm5KmOGqjJGusFPnIflmQBdZCCSa0lZ7yiHvZeKG7p6mxv3rw==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 PH8PR12MB7376.namprd12.prod.outlook.com (2603:10b6:510:214::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Mon, 15 Dec
 2025 16:18:12 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::152b:7346:321d:4a2]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::152b:7346:321d:4a2%6]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 16:18:11 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
CC: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"mhalstead@linuxfoundation.org" <mhalstead@linuxfoundation.org>
Subject: Online tool for playing with BitBake syntax - BB Datastore Playground
Thread-Topic: Online tool for playing with BitBake syntax - BB Datastore
 Playground
Thread-Index: Adxt1M9tqjjru1mwToaVgCG1qYgiHw==
Date: Mon, 15 Dec 2025 16:18:11 +0000
Message-ID: 
 <DM8PR12MB54308CA1D2D7682799DE625C8BADA@DM8PR12MB5430.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=3eeb73c4-f008-48f7-8607-b1534276bb94;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2025-12-15T15:09:20Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|PH8PR12MB7376:EE_
x-ms-office365-filtering-correlation-id: fcd4e0f2-7e64-4b76-4adb-08de3bf58ac7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|13003099007|38070700021|8096899003;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?a35OyiKX0PpCg+FNxxRFQJBqaceic8BhSqu1BshfRcinVliZ5KJU3VXtTrrc?=
 =?us-ascii?Q?VTJDvwkIT9kz2ernSbuujDDrJfqS28K8hq6C+13g9J3Pqg+on5KtmXyCpwr4?=
 =?us-ascii?Q?cHQxiDtwW6dsDv+FAhlbuW+/JddR3wX8j/+h5R7JIrpyhlIikfJdH8c+R0YD?=
 =?us-ascii?Q?UZTVdd74UXZ1LA+zPDH8scNuw/OtWCne0o2INbJWS/DTiiXOU6Tny6qRwpCw?=
 =?us-ascii?Q?ctrqEnD1mWiOUe2L0IcLhNhNJ6amVKuXIxBhdkEMQ8jqMzDsivfCTUIZFutD?=
 =?us-ascii?Q?vakLSMnTh/qNPJ3BE67OWiy7YuR5ligvqr5JdY6SuluUTsJBp/3mQs/aDHEQ?=
 =?us-ascii?Q?rTTWCgHIFg0tFw9sj4TWcXFTa/ZTRrMnbymHNr3cILW0gWTEbmc9Q1CU9koH?=
 =?us-ascii?Q?PP9B3JtExqWLE7eM1JG8iwQ1m4ATE9DMM3ewoIUf5TK72XV97DQWdOU49REy?=
 =?us-ascii?Q?An5/UUUjAnapjXGFUeAlaKV2I+yL1JtN88mgtX4E58XPiwmJo0+/fF+46KiI?=
 =?us-ascii?Q?+fxe4u5caYuH8nwdMh4uQQfQpVfy5uCT4Y1b5JfEuR6ZnW45qBLr60s7S1Ic?=
 =?us-ascii?Q?mbNVvnJDk6gG02OIFxWWhA8Y2e/e8QvmQnDcIAqnd1i6DsLGd21ZEdS0UxC6?=
 =?us-ascii?Q?TY69NAY8hVB1KWx1N1C2U4GmhdQKnx3D2kXHWfU7axdFw1zOfdAc++Tv7PYA?=
 =?us-ascii?Q?wpEZG0PP5/9dZ13B4ov+QHcV4porhoJQyGssDaFiOP7OerXUqneDmwUyirOj?=
 =?us-ascii?Q?ZTYOIz5LHl2rvrUec90mGWzFSEhXff8/grpwN9bQzCMc9qf9jxf8hkG82x0h?=
 =?us-ascii?Q?srbLSnvOIQGFF+TaG0to+1NyUIW66Xn8X5mPP6AzdQ/bDmMeMAJZxrDNv84n?=
 =?us-ascii?Q?gEwxcEtPzzwAFgaBgwf4r3Tpnri4c6+fLZL9aFy98GwK5DEdnASApgdQIXQd?=
 =?us-ascii?Q?bsmF46TS206hlto9Eyi1B/21qce62CVuZfl7kQNMvLHXdB6VXB/XR5Enm7F4?=
 =?us-ascii?Q?2darfNwiWvVt0m+Yg1tDK6WhEU9PguXMWUoUPG3uHeSc/uBt25PBuvi0AmK4?=
 =?us-ascii?Q?bzuSAVcBUiOuylYBgdxfH2qY7dlk435RVgIWldSJ7l4uFnFzAnFZm3nzyyEv?=
 =?us-ascii?Q?1EriVbbit8QGfI84hcTOumgtrJnhbk5ZDBvXDH3IvVj28jaayLfiDf0vpSfA?=
 =?us-ascii?Q?pKw39/jsGeuas1fPwShqpStrH9kNIMHenymimnKjNg+4+7qQhuZIdt+4a2z3?=
 =?us-ascii?Q?1zu2bDGru9Skf/SwFX3ZurkGAns/FKs60RHBLGrYruvMz6TOboVuOl/6+WB9?=
 =?us-ascii?Q?ogsdVpOxJDYP2y4YbxX3wIE/JDfucx8FQT5tC+3F89WkE9Z3VZSYBjXbc0RH?=
 =?us-ascii?Q?Rs9CdDfkvrCylIgcw1P8WgUDPyPc3noTwwUGI2E54jo38RNudoPG8TUzuyNW?=
 =?us-ascii?Q?VN0/BStH+QHSN2+8dQzctLyKB+NtejngRsgvu7bMicMvdaVTxWhykw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(13003099007)(38070700021)(8096899003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?l4bHUo0mqg1imJRjLNXTYXeY+WL3l1bHjM7uLfv0fLzNAs1J3kXiLWB+rRqx?=
 =?us-ascii?Q?BPcmFyGlInFcRuXP2SuNIeQ3CZRg/3IWZNlX5s3a6NdkxGwxkNn26Gzbb5HO?=
 =?us-ascii?Q?+dSijR6vBUwmpE/CK8ZT1+RI/OOi5zxrfB9IiB5nwl5dHkq/34PFp/UPUk/b?=
 =?us-ascii?Q?UA3C/PvXegRdCE23Um69TSxYUdz7cGnkOYfc/T4dteDW1Ew5DlWqQOV5fk1j?=
 =?us-ascii?Q?sk1Uyt8NMvPCTQ9f1YNidJadxmCUrUlt/Bp/Dl6W0VZpCsji1RnZT0UWdJbL?=
 =?us-ascii?Q?BBuAjjK77uVtC3XLqFVQzDHHeKm3SaFKzqs7wlT6T6XP7G7RHhOEwJI9vRYo?=
 =?us-ascii?Q?v1ZZWmrtbqWefhZ4Eogz6Jw5XaxizkaaQlh4sqT1ctHpb+7hNMctJiZM4Sjj?=
 =?us-ascii?Q?WJpL22hRAc3/USPsmIeR4w3mCi2mxUSqrA+RvXDSYOUbqaz+MAzjNSe2gL4W?=
 =?us-ascii?Q?yZJHAp4/WCq1geUppYP3aHfy+YhPVDLCU3veR7Y3T9X5pw/PF6RmgD4tYN0y?=
 =?us-ascii?Q?UiD32kddRgrFPsDkR+yKnWoihJi8IsMKqFXpozIdWQjnsZ6Ou7iQWTZAbmvU?=
 =?us-ascii?Q?/G6DVc79DmjLlCWHxXSnI/+OkgfTPf0N019kuJUfRsdF7xP2YRjJWdWKWoY5?=
 =?us-ascii?Q?459sI3m0TbgYg47gWaAIxPNzAPnRAp7qOWGvIJNLmi1ZaZ9Yvbbx+a5dO88n?=
 =?us-ascii?Q?UUMyqxD7jxkxKXQWaNXC4w1B0iwCqLgQnbPnIgFyYpZIzUXKN2RMUj1TXBvX?=
 =?us-ascii?Q?fQgDlAvH+bcqfu9DRi70c6qajzkg2JfoqcXIBgqQXvVPzs4r1oYiX722mjoZ?=
 =?us-ascii?Q?9mElJIa+TDqD+TfA/F35t/1XTbIS7GbCY8u0/cDPATwHXTkCnK2adTymHNOh?=
 =?us-ascii?Q?y/mo9Kof1HIuOlNl6vbQQMXR5mleB/wGIWsb4I/H1GE2+m0Yg5kIdN/+5XWT?=
 =?us-ascii?Q?Acf4NKa1JoXe39VogSo/p3LAUK8LUokyj8fUwF4zQnMT5++UyKT+XdyFRpIu?=
 =?us-ascii?Q?7E/HsXBAY3oBWZxK8Gz0t5JfJbLf9uZNhPtyGsjT4027y9YuZF2XRfR5w13R?=
 =?us-ascii?Q?J2+aIxyePoBfRH7//nqtzKdrU4WZMrBo5EAxZZg012mPoyUhBhDbd70dbCAo?=
 =?us-ascii?Q?8OkldpfFMbe4nMt5zfMxlsVn2hBbDKe3bKHtY9RdIGspTyjU/K0u9VWxaRjF?=
 =?us-ascii?Q?D7pgpdma1ts+9aSkyu1OrpgHnca/V9U48UY9E6PI4uC2Xg3+uvr3WDRU8QYd?=
 =?us-ascii?Q?Qsxq4iecd7O6IlXgxOyO2kEXJ2PPwR/YJEh5c8suf0csMO4mQEezXjudzs5V?=
 =?us-ascii?Q?rPHqOdb2eQ6T0sOUEOqx4Pa1aNrKbLtYj+8fAUppvlFn9hg/B+WFN5KG/IbV?=
 =?us-ascii?Q?mQhsGWubAYQJNytkgZFsAq31bWtTZQ81PyvAssnRyTmr8moaHYRbIUSKabh3?=
 =?us-ascii?Q?vyfw+G9rhqT56sR9vS7V4WWFHLcJrE2PSDV9G+uwLQmjD4EZ5T6z94hPSDbx?=
 =?us-ascii?Q?7xdEcRJnogGYntWT4QQp+TUMPB1qTZYc45JfNB6ycE6KIRHJSYJPN+edM1fI?=
 =?us-ascii?Q?HaZKCIsvZYW7J2MLvx4j6EHk4ZzuQCDrCrmMpWtk?=
Content-Type: multipart/alternative;
	boundary="_000_DM8PR12MB54308CA1D2D7682799DE625C8BADADM8PR12MB5430namp_"
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd4e0f2-7e64-4b76-4adb-08de3bf58ac7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2025 16:18:11.4013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jxbm6iCgtAKpvovwH5LKRTOq16/AaWV0mvsp2lUiMpNJR1IX0UUU+NZXwlzSz24kyPFbePcBl7Gzqs9+diL7CNKxSCMpKoKJ0/M6EI8u8Do=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7376
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Dec 2025 16:18:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18598

--_000_DM8PR12MB54308CA1D2D7682799DE625C8BADADM8PR12MB5430namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

A little over a year ago, I started working on this bug to develop a BitBak=
e variable expansion playground: https://bugzilla.yoctoproject.org/show_bug=
.cgi?id=3D14805.

I'm happy to report that finally, it is working and in a useful state. Try =
it out here:   https://yoctoproject.github.io/bb-datastore-playground/?code=
=3Dz%3AIIAgvCBECMkFBwMQgMoAcCmBjAlgQwBsQcA7A0jEABQE8AXACwHsSQBnGkuvADwC4kAA=
TQ0QaAE6k6ACgAmAOgDmGOgDU846ZGCQAlLoQAhcFABM8AMInIAEgDeARQC%2BIe4ZcBmeA%2Bs=
AVeHDAfHhomCSy1iAA7nh08KAA1BCQAPIA0gFwIows0rogdnAgxSAKIWGy6prakAA0UCAAfHgkL=
DQAtkwArmxi9MysdExMAIQAPFAGTgjIpOQklBxcvCBYLSAMLbIElKSyGFwYEQBGBExYANa9TABm=
q0z7IENMAojCojdM4iAAbhrErAA2jV6pBDHUoBZIABdV7vErFCRSaQ3SB2P7iJx8AoKZRqDTSDG=
6Jx6OBAA

(The URL is ugly because the code is encoded as part of the URL.)

The goal is to make it easy to tinker with BitBake syntax and with DataSmar=
t. It's one thing to read about how OVERRIDES works, but it's another to ha=
ve an easy environment to experiment with it yourself.

Here's another handful of demos (hopefully the URLs don't get mangled):


  1.  :append vs +=3D operators: https://yoctoproject.github.io/bb-datastor=
e-playground/?code=3Dz%3AMQAgIgpgtg9gdgZwC4CcCGSCW8QwGYgBcaADiRHACYgBuCIA1A=
LwBQboxZF1CAnnEjQAPEJRgR6cGEhCYBKGJQCuAYwggA7gAtMSCSTRqWAQRBMQAIiQ76mesYsnO=
5KmcukX1GOXRIYKAEJHYAABEl4QEhQ5JAAKSgA6AHMIJAA1NBRYiwcASlz2EAAhJRlmXB8Mf1Fx=
BBYitysbWXoixwbyixIAGyV6CABHJTRu4LCIqJj45NSMrIs2-JYgA
  2.  An OVERRIDES example, from the BitBake manual: https://yoctoproject.g=
ithub.io/bb-datastore-playground/?code=3Dz%3AMQAgogHghgtgDgGwKYgGYCcD2MQBcA=
WKAQgJa5FQDWKMUAdgK5QICwAUKPrrnAM4BcAekEATTAGNeAOgCeE3JjhYAVknG4pmdAHNBAIzJ=
6qSfYeMBaBryTpztRs1O4j1S9dv2mCO0lxQRUH5SXDAIwOKYdCJkJJHMPn4BfuzsAPIAamAASlk=
AkgAiYADKIAC8IABEUOji%2BGRquAzoSPyYArS1JHRIFewAKsV9ZZUiSKhQDAi4vWwDRX2tvMMV=
bbxwaiSoJOIzcwt0mJgAbjboJKPLmAQ2EVFHzAw9KRwAAnAyIEpduAAUIlJICBwegiH4VAAkAG8=
9gBfCoASnhQA
  3.  The set of 'worked examples' from the BitBake manual, demonstrating i=
nteractions between different operators: https://yoctoproject.github.io/bb-=
datastore-playground/?code=3Dz%3AMQAgKgFgpiDOUBcQHsBmIDkB3ZAnA1lACYhQAeAhgL=
YAOANlLBiKrslSAtCFRQHYBXCnQCwAKFAQECGrABcAegVFkAY1gA6AJ5qEyGmwBWUVQg14A5goB=
GASwTWKhG-ceEAtAPi53vQcJcHJyhPb19%2BITpfRAoiCgQKDSkqOmAANwpcWwprBndbPgQoXAp=
TW2Q%2BdxwCYndyanpGcXEAeQA1AFEAJS6ASQARDoBlEABeEAAiVGRkCfEAQTHJgC05sXm5aeQ5=
ChoaKD4ScYmADTXQMBb%2BlrkQa0Qi3BAsCi0UdFxGB4KLOASi8TAAACNDeBgKCAAFEQNBZEG1M=
pCJvMJgBKVGAkFvI4gfrxChDXi4KEYsStTo9AbDJZTGZrRbHVYLHZ7A5ETYzGlnTGgkDgwrQ2Hw=
xHItGk4G8nF4hKEzIk5pidrdPqDEbHLb0mkATXpHO2u32hxpTPWepZhpxp3OWL5WQFMLhCARuCR=
KPRPOxS2lBKJ8rJ6xpAEZdQa2TSAEwh1lG44AZk1AGpjgAWTUaY4AVmtvP5UIdwpdovd-qAA

Source code for the site is available here: https://github.com/yoctoproject=
/bb-datastore-playground/.

Some technical details: The site uses Pyodide to execute Python in the brow=
ser, via WebAssembly (Wasm). I use a Web Worker to push all the processing =
into a background thread, to keep the UI responsive. Frontend is TypeScript=
, with React as the framework.

There is also a Terminal tab, which is a Python REPL with BitBake already i=
mported. You can use the 'd' variable from the terminal, which is the insta=
nce of DataSmart used for parsing code entered into the editor.


Next steps and possible future directions (help appreciated on any and all!=
):


  1.  Investigate whether any sandboxing is possible/needed. Obviously, the=
 ability to run arbitrary Python (and JavaScript, via the Pyodide bridge) r=
aises some alarm bells. I'm fairly certain we're OK, for a few reasons:
     *   Pyodide is running in a Web Worker, which has no access to the 'wi=
ndow' global or DOM.
     *   Although Web Workers can use the Fetch API, and Pyodide exposes th=
e 'pyfetch' module (https://pyodide.org/en/stable/usage/api/python-api/http=
.html#pyfetch-asynchronous-http-client), I haven't figured out a way to do =
any network requests whatsoever: https://yoctoproject.github.io/bb-datastor=
e-playground/?code=3Dz%3AMQAgKgTgniAuD2IIFcB2IBWBDAblgzgMYQCWADrCCerABYCmIA=
7vBANb0QiHyqz0APWADpRAWABQk0AGV69ALb4QAGxIcQAchSoA%2Bhnyaqy1PEoATevhIBzVPXN=
xELdlXRYQAdXoAjL6w4IABppEGtUQkYSSlhSKyctEgUyVkoDTVDaWFgyfAAuAHoCsih4cxJLYVY=
bAvpUAoAGYQBGADYWgtgoMnpdHlQcTmtefGEshRVgZHCbAFpsPCJSCln4Hwx6Qlh8WYAzCHgFWZ=
K6XklpAAESqmTUkBKyivpL66SUiEoH8sqeSxeYL5PYS-ejCHT6fAACgARP18JQPABeEDNADc0IA=
lOcpBJQAB5OicOC0ag2ZQASTgcXMeVCIHpzWE9ygAloXEhWRy%2BSKgMq1Vq9XhWB8KnoBWmWBs=
YqwZBIxSgp1Qsxlcs5ZDGsAmwBKrIgs3wUAibN48GmszVs0IajqsCxuPpDvpABF4FZUJpKC42EE=
QD4CA4QLwQAANACyABkABLZMgAJXoAEdkFZPSTCLRjCBTAi8CQVMLRQlPAEhsI6fSAExMgCq%2B=
EYJV29Fg6ZA5Qgm1gKhgHJj3Pljz5EBqdQKQpFYolUoKKvliuVsoKao1WobTfTyoNRoOpjNFqtJ=
BtdtAjvpOBIHgIhsIJHgYLQZftJ5ALrdHuYAR94UiIAACqVvmKngEAoBRMLQWD8IMXCEFg7qUDY=
iD7IcYRXiAiIAHwgJeETcLw-BCA%2BkhAA
     *   Worst case, we could serve the web worker script from (e.g. Cloudf=
lare) with connect-src CSP set to disallow network. https://developer.mozil=
la.org/en-US/docs/Web/API/WorkerGlobalScope/fetch
     *   I think the worst you could do is write an infinite loop or someth=
ing and crash the Web Worker.
  2.  Improve the Output and Status panes. They are pretty much just proof-=
of-concept for now.
  3.  Implement local document saving in localStorage
  4.  Implement some server-side document saving (perhaps using Cloudflare =
Workers + R2 or KV for persistence), to remove need for ugly URLs.
  5.  Enhance syntax highlighting (see BitBakeMode.ts) to support the speci=
al inline-Python syntax
  6.  Enhance syntax highlighting to support BitBake syntax features introd=
uced since I first wrote the highlighter.
  7.  Maybe add a toolbar and/or custom keybindings to automatically genera=
te snippets of inline Python, e.g. to print(d.getVar(...)) for the variable=
 name that is under cursor.
  8.  Perhaps a cleaner logo.

See previous discussions:
https://lists.openembedded.org/g/bitbake-devel/message/15894 and https://li=
sts.openembedded.org/g/bitbake-devel/topic/106074317

Many thanks to Michael Halstead for setting up the github.io site, and to R=
P for his help and feedback!

Thanks,
Chris

--_000_DM8PR12MB54308CA1D2D7682799DE625C8BADADM8PR12MB5430namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:1077560039;
	mso-list-type:hybrid;
	mso-list-template-ids:-145482362 593379474 67698713 67698715 67698703 6769=
8713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ascii-font-family:Aptos;
	mso-fareast-font-family:"Times New Roman";
	mso-hansi-font-family:Aptos;
	mso-bidi-font-family:"Times New Roman";}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1
	{mso-list-id:1197356631;
	mso-list-type:hybrid;
	mso-list-template-ids:1458845750 67698703 67698713 67698715 67698703 67698=
713 67698715 67698703 67698713 67698715;}
@list l1:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Hi all,<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">A little over a yea=
r ago, I started working on this bug to develop a BitBake variable expansio=
n playground:
<a href=3D"https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D14805">https=
://bugzilla.yoctoproject.org/show_bug.cgi?id=3D14805</a>.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">I&#8217;m happy to =
report that finally, it is working and in a useful state. Try it out here: =
&nbsp;&nbsp;<a href=3D"https://yoctoproject.github.io/bb-datastore-playgrou=
nd/?code=3Dz%3AIIAgvCBECMkFBwMQgMoAcCmBjAlgQwBsQcA7A0jEABQE8AXACwHsSQBnGkuv=
ADwC4kAATQ0QaAE6k6ACgAmAOgDmGOgDU846ZGCQAlLoQAhcFABM8AMInIAEgDeARQC%2BIe4Zc=
BmeA%2BsAVeHDAfHhomCSy1iAA7nh08KAA1BCQAPIA0gFwIows0rogdnAgxSAKIWGy6prakAA0U=
CAAfHgkLDQAtkwArmxi9MysdExMAIQAPFAGTgjIpOQklBxcvCBYLSAMLbIElKSyGFwYEQBGBExY=
ANa9TABmq0z7IENMAojCojdM4iAAbhrErAA2jV6pBDHUoBZIABdV7vErFCRSaQ3SB2P7iJx8AoK=
ZRqDTSDG6Jx6OBAA">https://yoctoproject.github.io/bb-datastore-playground/?c=
ode=3Dz%3AIIAgvCBECMkFBwMQgMoAcCmBjAlgQwBsQcA7A0jEABQE8AXACwHsSQBnGkuvADwC4=
kAATQ0QaAE6k6ACgAmAOgDmGOgDU846ZGCQAlLoQAhcFABM8AMInIAEgDeARQC%2BIe4ZcBmeA%=
2BsAVeHDAfHhomCSy1iAA7nh08KAA1BCQAPIA0gFwIows0rogdnAgxSAKIWGy6prakAA0UCAAfH=
gkLDQAtkwArmxi9MysdExMAIQAPFAGTgjIpOQklBxcvCBYLSAMLbIElKSyGFwYEQBGBExYANa9T=
ABmq0z7IENMAojCojdM4iAAbhrErAA2jV6pBDHUoBZIABdV7vErFCRSaQ3SB2P7iJx8AoKZRqDT=
SDG6Jx6OBAA</a>
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">(The URL is ugly be=
cause the code is encoded as part of the URL.)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">The goal is to make=
 it easy to tinker with BitBake syntax and with DataSmart. It&#8217;s one t=
hing to read about how OVERRIDES works, but it&#8217;s another to have an e=
asy environment to experiment with it yourself.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Here&#8217;s anothe=
r handful of demos (hopefully the URLs don&#8217;t get mangled):<br>
<br>
<o:p></o:p></span></p>
<ol style=3D"margin-top:0in" start=3D"1" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level1 =
lfo1"><span style=3D"font-size:11.0pt">:append vs +=3D operators:
<a href=3D"https://yoctoproject.github.io/bb-datastore-playground/?code=3Dz=
%3AMQAgIgpgtg9gdgZwC4CcCGSCW8QwGYgBcaADiRHACYgBuCIA1ALwBQboxZF1CAnnEjQAPEJR=
gR6cGEhCYBKGJQCuAYwggA7gAtMSCSTRqWAQRBMQAIiQ76mesYsnO5KmcukX1GOXRIYKAEJHYAA=
BEl4QEhQ5JAAKSgA6AHMIJAA1NBRYiwcASlz2EAAhJRlmXB8Mf1FxBBYitysbWXoixwbyixIAGy=
V6CABHJTRu4LCIqJj45NSMrIs2-JYgA">
https://yoctoproject.github.io/bb-datastore-playground/?code=3Dz%3AMQAgIgpg=
tg9gdgZwC4CcCGSCW8QwGYgBcaADiRHACYgBuCIA1ALwBQboxZF1CAnnEjQAPEJRgR6cGEhCYBK=
GJQCuAYwggA7gAtMSCSTRqWAQRBMQAIiQ76mesYsnO5KmcukX1GOXRIYKAEJHYAABEl4QEhQ5JA=
AKSgA6AHMIJAA1NBRYiwcASlz2EAAhJRlmXB8Mf1FxBBYitysbWXoixwbyixIAGyV6CABHJTRu4=
LCIqJj45NSMrIs2-JYgA</a><o:p></o:p></span></li><li class=3D"MsoListParagrap=
h" style=3D"margin-left:0in;mso-list:l0 level1 lfo1"><span style=3D"font-si=
ze:11.0pt">An OVERRIDES example, from the BitBake manual:
<a href=3D"https://yoctoproject.github.io/bb-datastore-playground/?code=3Dz=
%3AMQAgogHghgtgDgGwKYgGYCcD2MQBcAWKAQgJa5FQDWKMUAdgK5QICwAUKPrrnAM4BcAekEAT=
TAGNeAOgCeE3JjhYAVknG4pmdAHNBAIzJ6qSfYeMBaBryTpztRs1O4j1S9dv2mCO0lxQRUH5SXD=
AIwOKYdCJkJJHMPn4BfuzsAPIAamAASlkAkgAiYADKIAC8IABEUOji%2BGRquAzoSPyYArS1JHR=
IFewAKsV9ZZUiSKhQDAi4vWwDRX2tvMMVbbxwaiSoJOIzcwt0mJgAbjboJKPLmAQ2EVFHzAw9KR=
wAAnAyIEpduAAUIlJICBwegiH4VAAkAG89gBfCoASnhQA">
https://yoctoproject.github.io/bb-datastore-playground/?code=3Dz%3AMQAgogHg=
hgtgDgGwKYgGYCcD2MQBcAWKAQgJa5FQDWKMUAdgK5QICwAUKPrrnAM4BcAekEATTAGNeAOgCeE=
3JjhYAVknG4pmdAHNBAIzJ6qSfYeMBaBryTpztRs1O4j1S9dv2mCO0lxQRUH5SXDAIwOKYdCJkJ=
JHMPn4BfuzsAPIAamAASlkAkgAiYADKIAC8IABEUOji%2BGRquAzoSPyYArS1JHRIFewAKsV9ZZ=
UiSKhQDAi4vWwDRX2tvMMVbbxwaiSoJOIzcwt0mJgAbjboJKPLmAQ2EVFHzAw9KRwAAnAyIEpdu=
AAUIlJICBwegiH4VAAkAG89gBfCoASnhQA</a><o:p></o:p></span></li><li class=3D"M=
soListParagraph" style=3D"margin-left:0in;mso-list:l0 level1 lfo1"><span st=
yle=3D"font-size:11.0pt">The set of &#8216;worked examples&#8217; from the =
BitBake manual, demonstrating interactions between different operators:
<a href=3D"https://yoctoproject.github.io/bb-datastore-playground/?code=3Dz=
%3AMQAgKgFgpiDOUBcQHsBmIDkB3ZAnA1lACYhQAeAhgLYAOANlLBiKrslSAtCFRQHYBXCnQCwA=
KFAQECGrABcAegVFkAY1gA6AJ5qEyGmwBWUVQg14A5goBGASwTWKhG-ceEAtAPi53vQcJcHJyhP=
b19%2BITpfRAoiCgQKDSkqOmAANwpcWwprBndbPgQoXApTW2Q%2BdxwCYndyanpGcXEAeQA1AFE=
AJS6ASQARDoBlEABeEAAiVGRkCfEAQTHJgC05sXm5aeQ5ChoaKD4ScYmADTXQMBb%2BlrkQa0Qi=
3BAsCi0UdFxGB4KLOASi8TAAACNDeBgKCAAFEQNBZEG1MpCJvMJgBKVGAkFvI4gfrxChDXi4KEY=
sStTo9AbDJZTGZrRbHVYLHZ7A5ETYzGlnTGgkDgwrQ2HwxHItGk4G8nF4hKEzIk5pidrdPqDEbH=
Lb0mkATXpHO2u32hxpTPWepZhpxp3OWL5WQFMLhCARuCRKPRPOxS2lBKJ8rJ6xpAEZdQa2TSAEw=
h1lG44AZk1AGpjgAWTUaY4AVmtvP5UIdwpdovd-qAA">
https://yoctoproject.github.io/bb-datastore-playground/?code=3Dz%3AMQAgKgFg=
piDOUBcQHsBmIDkB3ZAnA1lACYhQAeAhgLYAOANlLBiKrslSAtCFRQHYBXCnQCwAKFAQECGrABc=
AegVFkAY1gA6AJ5qEyGmwBWUVQg14A5goBGASwTWKhG-ceEAtAPi53vQcJcHJyhPb19%2BITpfR=
AoiCgQKDSkqOmAANwpcWwprBndbPgQoXApTW2Q%2BdxwCYndyanpGcXEAeQA1AFEAJS6ASQARDo=
BlEABeEAAiVGRkCfEAQTHJgC05sXm5aeQ5ChoaKD4ScYmADTXQMBb%2BlrkQa0Qi3BAsCi0UdFx=
GB4KLOASi8TAAACNDeBgKCAAFEQNBZEG1MpCJvMJgBKVGAkFvI4gfrxChDXi4KEYsStTo9AbDJZ=
TGZrRbHVYLHZ7A5ETYzGlnTGgkDgwrQ2HwxHItGk4G8nF4hKEzIk5pidrdPqDEbHLb0mkATXpHO=
2u32hxpTPWepZhpxp3OWL5WQFMLhCARuCRKPRPOxS2lBKJ8rJ6xpAEZdQa2TSAEwh1lG44AZk1A=
GpjgAWTUaY4AVmtvP5UIdwpdovd-qAA</a><o:p></o:p></span></li></ol>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Source code for the=
 site is available here:
<a href=3D"https://github.com/yoctoproject/bb-datastore-playground/">https:=
//github.com/yoctoproject/bb-datastore-playground/</a>.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Some technical deta=
ils: The site uses Pyodide to execute Python in the browser, via WebAssembl=
y (Wasm). I use a Web Worker to push all the processing into a background t=
hread, to keep the UI responsive. Frontend
 is TypeScript, with React as the framework. <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">There is also a Ter=
minal tab, which is a Python REPL with BitBake already imported. You can us=
e the &#8216;d&#8217; variable from the terminal, which is the instance of =
DataSmart used for parsing code entered into the
 editor.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Next steps and poss=
ible future directions (help appreciated on any and all!):<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<ol style=3D"margin-top:0in" start=3D"1" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l1 level1 =
lfo2"><span style=3D"font-size:11.0pt">Investigate whether any sandboxing i=
s possible/needed. Obviously, the ability to run arbitrary Python (and Java=
Script, via the Pyodide bridge) raises
 some alarm bells. I&#8217;m fairly certain we&#8217;re OK, for a few reaso=
ns:<o:p></o:p></span></li><ol style=3D"margin-top:0in" start=3D"1" type=3D"=
a">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l1 level2 =
lfo2"><span style=3D"font-size:11.0pt">Pyodide is running in a Web Worker, =
which has no access to the &#8216;window&#8217; global or DOM.<o:p></o:p></=
span></li><li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:=
l1 level2 lfo2"><span style=3D"font-size:11.0pt">Although Web Workers can u=
se the Fetch API, and Pyodide exposes the &#8216;pyfetch&#8217; module (<a =
href=3D"https://pyodide.org/en/stable/usage/api/python-api/http.html#pyfetc=
h-asynchronous-http-client">https://pyodide.org/en/stable/usage/api/python-=
api/http.html#pyfetch-asynchronous-http-client</a>),
 I haven&#8217;t figured out a way to do any network requests whatsoever: <=
a href=3D"https://yoctoproject.github.io/bb-datastore-playground/?code=3Dz%=
3AMQAgKgTgniAuD2IIFcB2IBWBDAblgzgMYQCWADrCCerABYCmIA7vBANb0QiHyqz0APWADpRAW=
ABQk0AGV69ALb4QAGxIcQAchSoA%2Bhnyaqy1PEoATevhIBzVPXNxELdlXRYQAdXoAjL6w4IABp=
pEGtUQkYSSlhSKyctEgUyVkoDTVDaWFgyfAAuAHoCsih4cxJLYVYbAvpUAoAGYQBGADYWgtgoMn=
pdHlQcTmtefGEshRVgZHCbAFpsPCJSCln4Hwx6Qlh8WYAzCHgFWZK6XklpAAESqmTUkBKyivpL6=
6SUiEoH8sqeSxeYL5PYS-ejCHT6fAACgARP18JQPABeEDNADc0IAlOcpBJQAB5OicOC0ag2ZQAS=
TgcXMeVCIHpzWE9ygAloXEhWRy%2BSKgMq1Vq9XhWB8KnoBWmWBsYqwZBIxSgp1Qsxlcs5ZDGsA=
mwBKrIgs3wUAibN48GmszVs0IajqsCxuPpDvpABF4FZUJpKC42EEQD4CA4QLwQAANACyABkABLZ=
MgAJXoAEdkFZPSTCLRjCBTAi8CQVMLRQlPAEhsI6fSAExMgCq%2BEYJV29Fg6ZA5Qgm1gKhgHJj=
3Pljz5EBqdQKQpFYolUoKKvliuVsoKao1WobTfTyoNRoOpjNFqtJBtdtAjvpOBIHgIhsIJHgYLQ=
ZftJ5ALrdHuYAR94UiIAACqVvmKngEAoBRMLQWD8IMXCEFg7qUDYiD7IcYRXiAiIAHwgJeETcLw=
-BCA%2BkhAA">
https://yoctoproject.github.io/bb-datastore-playground/?code=3Dz%3AMQAgKgTg=
niAuD2IIFcB2IBWBDAblgzgMYQCWADrCCerABYCmIA7vBANb0QiHyqz0APWADpRAWABQk0AGV69=
ALb4QAGxIcQAchSoA%2Bhnyaqy1PEoATevhIBzVPXNxELdlXRYQAdXoAjL6w4IABppEGtUQkYSS=
lhSKyctEgUyVkoDTVDaWFgyfAAuAHoCsih4cxJLYVYbAvpUAoAGYQBGADYWgtgoMnpdHlQcTmte=
fGEshRVgZHCbAFpsPCJSCln4Hwx6Qlh8WYAzCHgFWZK6XklpAAESqmTUkBKyivpL66SUiEoH8sq=
eSxeYL5PYS-ejCHT6fAACgARP18JQPABeEDNADc0IAlOcpBJQAB5OicOC0ag2ZQASTgcXMeVCIH=
pzWE9ygAloXEhWRy%2BSKgMq1Vq9XhWB8KnoBWmWBsYqwZBIxSgp1Qsxlcs5ZDGsAmwBKrIgs3w=
UAibN48GmszVs0IajqsCxuPpDvpABF4FZUJpKC42EEQD4CA4QLwQAANACyABkABLZMgAJXoAEdk=
FZPSTCLRjCBTAi8CQVMLRQlPAEhsI6fSAExMgCq%2BEYJV29Fg6ZA5Qgm1gKhgHJj3Pljz5EBqd=
QKQpFYolUoKKvliuVsoKao1WobTfTyoNRoOpjNFqtJBtdtAjvpOBIHgIhsIJHgYLQZftJ5ALrdH=
uYAR94UiIAACqVvmKngEAoBRMLQWD8IMXCEFg7qUDYiD7IcYRXiAiIAHwgJeETcLw-BCA%2BkhA=
A</a><o:p></o:p></span></li><li class=3D"MsoListParagraph" style=3D"margin-=
left:0in;mso-list:l1 level2 lfo2"><span style=3D"font-size:11.0pt">Worst ca=
se, we could serve the web worker script from (e.g. Cloudflare) with connec=
t-src CSP set to disallow network.
<a href=3D"https://developer.mozilla.org/en-US/docs/Web/API/WorkerGlobalSco=
pe/fetch">
https://developer.mozilla.org/en-US/docs/Web/API/WorkerGlobalScope/fetch</a=
><o:p></o:p></span></li><li class=3D"MsoListParagraph" style=3D"margin-left=
:0in;mso-list:l1 level2 lfo2"><span style=3D"font-size:11.0pt">I think the =
worst you could do is write an infinite loop or something and crash the Web=
 Worker.<o:p></o:p></span></li></ol>
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l1 level1 =
lfo2"><span style=3D"font-size:11.0pt">Improve the Output and Status panes.=
 They are pretty much just proof-of-concept for now.
<o:p></o:p></span></li><li class=3D"MsoListParagraph" style=3D"margin-left:=
0in;mso-list:l1 level1 lfo2"><span style=3D"font-size:11.0pt">Implement loc=
al document saving in localStorage
<o:p></o:p></span></li><li class=3D"MsoListParagraph" style=3D"margin-left:=
0in;mso-list:l1 level1 lfo2"><span style=3D"font-size:11.0pt">Implement som=
e server-side document saving (perhaps using Cloudflare Workers + R2 or KV =
for persistence), to remove need for ugly URLs.<o:p></o:p></span></li><li c=
lass=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l1 level1 lfo2"=
><span style=3D"font-size:11.0pt">Enhance syntax highlighting (see BitBakeM=
ode.ts) to support the special inline-Python syntax<o:p></o:p></span></li><=
li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l1 level1 l=
fo2"><span style=3D"font-size:11.0pt">Enhance syntax highlighting to suppor=
t BitBake syntax features introduced since I first wrote the highlighter.<o=
:p></o:p></span></li><li class=3D"MsoListParagraph" style=3D"margin-left:0i=
n;mso-list:l1 level1 lfo2"><span style=3D"font-size:11.0pt">Maybe add a too=
lbar and/or custom keybindings to automatically generate snippets of inline=
 Python, e.g. to print(d.getVar(&#8230;)) for the variable name that
 is under cursor.<o:p></o:p></span></li><li class=3D"MsoListParagraph" styl=
e=3D"margin-left:0in;mso-list:l1 level1 lfo2"><span style=3D"font-size:11.0=
pt">Perhaps a cleaner logo.<o:p></o:p></span></li></ol>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">See previous discus=
sions:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><a href=3D"https://=
lists.openembedded.org/g/bitbake-devel/message/15894">https://lists.openemb=
edded.org/g/bitbake-devel/message/15894</a> and
<a href=3D"https://lists.openembedded.org/g/bitbake-devel/topic/106074317">=
https://lists.openembedded.org/g/bitbake-devel/topic/106074317</a><o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Many thanks to Mich=
ael Halstead for setting up the github.io site, and to RP for his help and =
feedback!<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Thanks,<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Chris<o:p></o:p></s=
pan></p>
</div>
</body>
</html>

--_000_DM8PR12MB54308CA1D2D7682799DE625C8BADADM8PR12MB5430namp_--

