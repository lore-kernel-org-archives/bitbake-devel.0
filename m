Return-Path: <jaipaul.cheernam@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BA1C5CFCF
	for <webhook@archiver.kernel.org>; Thu, 13 Aug 2026 16:54:25 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.26])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23729.1786640055631717152
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Aug 2026 09:54:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@est.tech header.s=selector1 header.b=PNUSNLzI;
 spf=pass (domain: est.tech, ip: 52.101.70.26, mailfrom: jaipaul.cheernam@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrEhx3EpqgmPIuro9WahXPBGZAHbnTC03zpuNl2Pd0Lo8HubVx+hGEXtNG9F2oJ108BuUZnhD5/WtMbRAIq4Qfgxt7jW7wtjLUAQa7EL3/3hUzjENz7xJuEdcvWyPVA4qjGkU4HCPQMq3DXXPcywn65JOlHMGm+xGjF5mSjFljzNTPuKpNJO+dOZIt03p5BwJDLiPuDdUas+8ppkvBl8gPhg7eFu2dsg9hZqhvEygkIJS5u2Uj++ZqQ0AlifiNej7CGohhNJI5EVQM2J3rTlyfU/02dc3o3UoxupWz2BDCMJ/Ls37ltlHdc1rlHNvgIy1f33zj1iiWlANfvrHlYnUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfd6s53UN9N+xpaGkVH1htN2CozS/Woxatd0+XJ2MPg=;
 b=xIMEj+ZjiCFSNHYNkwOHlWzphu2uRIdwaCVMA1gdORSC5FYtBgiMl+e/4q+qUODRm4KTIVQLxipczxlINNLrUgCLicd+ocPXpUhbcxkzneASau+LANGUEaa/5bYYkkQY7Sdt+Y9+NzMq5njLNXY1AVZzH8yhf6gWJ1XNHes0TwjPZBkMUpCWo59HR5dcg5UK6FTck5TdbS0ycM/nkCa3Gjn8ObyV1y85EWCmT6b2AwhQXXrywP6/WQFNhTNbXPcim+VZV5/kY4UG4U/DakfN7bFY4DYW8Ww7jq+hth7X9O50hid+yVRxv16/I5ZO0LucAdFSQIHiJYmj7s+r6nuSqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfd6s53UN9N+xpaGkVH1htN2CozS/Woxatd0+XJ2MPg=;
 b=PNUSNLzIqyUCITdkwkFK7eYUwQ3EZIGKMyAXDf9fu5Os8QDcHzCo8I3KD664aytxxORy5A0vE2eZPNCsPFp7QHJxpsMtelzbZ5FFvaWNB9DhXJFHSxk/+O9CTqmIhXf3/loXvIAyZU3EY3phxRdItjjqhL8PI8TSZFHgt0d8Z+v6kNZgWQ75wdQq5XniGyiAINZY/AtkWIjsVwpdO25noXzQIsGABm4rjP8jP9l1iongOrN5T+5rlNgXLcJPDVlg9M2LKyGvO84mAtI8d14yH+Pz6IP8FgvqXjzWX8niklfhTMXfBppIw4Q2oM39VuoA9mymUiiAS+kMSti1tk2hKA==
Received: from DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM (2603:10a6:18:3::ad4)
 by DB8P189MB0811.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:12b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.4; Thu, 13 Aug
 2026 16:54:11 +0000
Received: from DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM
 ([fe80::7ab2:c6af:6760:5c85]) by DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM
 ([fe80::7ab2:c6af:6760:5c85%7]) with mapi id 15.21.0339.002; Thu, 13 Aug 2026
 16:54:11 +0000
From: Jaipaul Cheernam <jaipaul.cheernam@est.tech>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v2] parse: warn on trailing whitespace in
 parsed lines
Thread-Topic: [bitbake-devel] [PATCH v2] parse: warn on trailing whitespace in
 parsed lines
Thread-Index: AQHdJZYq4OH5AlzAMUCwdlT/mgvVNbacH8MAgAAdHW0=
Date: Thu, 13 Aug 2026 16:54:11 +0000
Message-ID: 
 <DU7PPF66507B2D7DF3AD4504715A950243CF3DB2@DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM>
References: <20260804090834.99906-1-jaipaul.cheernam@est.tech>
 <20260806112435.25128-1-jaipaul.cheernam@est.tech>
 <DKNWRTWPZT8T.1ZLGV8S99L5N9@bootlin.com>
In-Reply-To: <DKNWRTWPZT8T.1ZLGV8S99L5N9@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU7PPF66507B2D7:EE_|DB8P189MB0811:EE_
x-ms-office365-filtering-correlation-id: 864914f6-c414-45ad-ba80-08def95b7fbc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|10070799003|376014|23010399003|366016|13003099007|38070700021|22082099003|18002099003|56012099006|8096899003|4143699003|11063799006|10067099003;
x-microsoft-antispam-message-info: 
 gOKbGjuc6hJxjU7B38n5Ro3bORkXYYmWtfGkHk0GUOLHA4lel4H7ipslGv/mIM/N8ePhjQMmyPvrp7JJlp+vmBgrZoPGvU3KTV4BcrmdmVniIAnl9f0N0NOm2p05t9DA4omk87e58Xn/EmJKooKCGD72tqYtszI/cRAvI7KTqKPrdI5j8Ff0rW4uYixddOTHfeqDPHSwRkohRNgAZpOgNekozBvIb/YMqblCCtCxnEBtl9aEqSVcpklMPlubf3jGJMKBO/rSTQBjAiPRhITfuxyyRr6xpxVMUBysJrV2MK/T+sLfGSpZuBuAZTpSIq2YsYmRyox7YG+MFJioN1OTXu5GJWkBHn9WgY22T5RCliTMKelJdC8Od5uooETKrZptHSFygls3dtaLcXdHw1kyogkgkQoKsPDF7Ro6UbaxrvLJCI7P6HO8bI+p8OMd044J/O4WU5e7CUvKkzD7GPWVdyBmHkz8//G5/446JygH2/rs2PW0U/aCq9639aLooI8iNvA52pP3ozRHgTk43SNBxAo9Yg01D04MfTh0jpv5A08ZMWSNj0E703QCw7SLlX24oBMx4ANKEAg+8gXLTiY8IsbploqmN1Y76esa2xLHfIOGrrhRf3fxoKqYF86Cwol2Z/qwtJIMeYdIqyROWkgAY362SOYW2bZJGIiPlgfY18k=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(23010399003)(366016)(13003099007)(38070700021)(22082099003)(18002099003)(56012099006)(8096899003)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?B0ojkBAejZ5197mIM8DqqeJWz176vKBuJXo7UmgE0V7Oa1qEzAqmzjwplF?=
 =?iso-8859-1?Q?Tvw1cG1XWmjAdRiK6YjSDam+W1+JftI8phXgBnkaPAIAIj7lAQky3Cbom3?=
 =?iso-8859-1?Q?YFdisD2HDGdchfYXz7yaUWSfLrC0qyIENhTTv4QzcDuUiz3SAwiwo0m13T?=
 =?iso-8859-1?Q?w+aCFUWiU5ZTs3pwyao2vAdMc0Re+Xzt+QC0cWEX3mHyncBbE7v4wZtF4D?=
 =?iso-8859-1?Q?v4t6/oTLIvmLjAZ32LLEUm2FXa2dOLwG2K/5Jyhdp7tjliWjhaXVfY937m?=
 =?iso-8859-1?Q?zuhntGj4cCi9qrvGA+OezYFilnwfEp57cIFldIVpN8vcaAnjrFxQc2/Hhv?=
 =?iso-8859-1?Q?+NDPIfbCJFORfpGOOTfKl7S69U050KiLQXXIjVPDusVRYaOEQcS4xHbVYT?=
 =?iso-8859-1?Q?6MST9UBQTnmKLzWjZxwXAwDb3JQndeuHHpwjMmjbJnLRTmD5fwx2HuJsZG?=
 =?iso-8859-1?Q?nTGLiapyvzvJFe+3TR8esm0qehz6uKpa9Ka2e4xUhxhYsW3E5e0dJyusuW?=
 =?iso-8859-1?Q?iGSHPfPb+2YvEqEiqn9zx6pjtVAvG4fqNkTK6Vjengi4LVR9XiTcQZlwZt?=
 =?iso-8859-1?Q?+YFs0ThA56MNK26skOfFy2ikDwQQBxxWVYNUy3m2jtjJeoblfoTQXAz9Sw?=
 =?iso-8859-1?Q?dyHRgYkS+q0j2aKYx4szxY4YWsfp8v88KJMaPGMXRDGTDib5ZouAkUmQ6M?=
 =?iso-8859-1?Q?DlqTI3qRCMuCLX3uiUBxtX1AuSX6qe1PUHu+GeZDCOjfFJ54yn3EekltTq?=
 =?iso-8859-1?Q?v+DJ9Nvqz5/IfbhEU+IN2UgvhpCsttRD13g7iMw1TO2IvoI+RokOXhP2NT?=
 =?iso-8859-1?Q?ORxOh89pKTG3fR3JJz4eIT5EcI8c6TrwPEvBvsQABN211fN9J9+ySIEMZT?=
 =?iso-8859-1?Q?NqON4y0qRL9UNYeu3tESJNMfxdszKGm7336xdZEmO2XreZ9X/ECtIhMztw?=
 =?iso-8859-1?Q?V2w3q5bysSp7AjRXlfyDr4SXQsQEktOXOLWjEQBl9Lmes01xLkguTkR7z2?=
 =?iso-8859-1?Q?piZi4Upb/zjlRDiD1RPz6aR/OcX562May5MHpR5qXY+EOp1XfiIKGAdun0?=
 =?iso-8859-1?Q?csAHjEdjVocP8e60kIH36+MgW7RzIPJuZt0OGXUfvL6KkqrRVGad8+q8eX?=
 =?iso-8859-1?Q?yTzxcm4KFlOKtzO+D437eSn2A1Q3wgrRVof/rWQVSMFl1PkH9BeobRaT7D?=
 =?iso-8859-1?Q?SkrOdB4bvlQcX2NYS4WUA83RXC5f5EjuQ7D/GIarArIB1kL6P9SwW3TCDg?=
 =?iso-8859-1?Q?70NFqg5l36wX5VPSqoMigEuEVx/fT3ypUBQpvPD32lOKniwOqYGvXa8dkU?=
 =?iso-8859-1?Q?U/Nunypu6h/yl7yRiihIdeFl9lyap2BglwUNGyUZQ3X6h9t6qnJ/zJLbC2?=
 =?iso-8859-1?Q?orJh4UxO00xet8Jvosn/MAKm7vTO2PHfXrU9QjseYu9A7650Dhc3vnO4GP?=
 =?iso-8859-1?Q?JqKpD72R24ZKglIG2sj/TvTzu1ZyU4Fj/6uNXuPHLbzpELv2mC4/XicPC8?=
 =?iso-8859-1?Q?aK+d5XppPUE0d/dhc15NqT+/xwkBl2KfM4Ihz9ZmEwrs7Y9oCTci3InYVu?=
 =?iso-8859-1?Q?/YJq5nd+8qZ8DOhrT2IoX3ML4ulhAbtbA2zjhAUewOx50CONJG1TuUBTB+?=
 =?iso-8859-1?Q?WwFaxRzmi2cbxJKSnc6o0hia7hBlfExlYVn3DiKwp1xMBcLkNaLKyj0Mff?=
 =?iso-8859-1?Q?YWCHjFJIJyvnv+aQLHjYA3gTt4Z4etV8nX67rE6T87H/MsmRBRPirOotzq?=
 =?iso-8859-1?Q?0DXIVfpvqLBDn5p9+F2zWVlRuyxLw/3GDi13SNBJYJLlrkhTGDDZ5/t0yY?=
 =?iso-8859-1?Q?T/0K6cGHriJl1jCeKr/nBKrqzqKX6Pd7aV9eD49eiSfHDH3PfVWfmGiZiQ?=
 =?iso-8859-1?Q?ib?=
x-ms-exchange-antispam-messagedata-1: qtU6pmYtvuQVlw==
Content-Type: multipart/alternative;
	boundary="_000_DU7PPF66507B2D7DF3AD4504715A950243CF3DB2DU7PPF66507B2D7_"
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 864914f6-c414-45ad-ba80-08def95b7fbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 16:54:11.3380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3l0HIo0uwARzKCXd2bQlm9jQEHMWWaWhWHvSZzHSsfq9lTxFdks5gC3Gv/eBhbhpCLYcWuCQJ4rVL7KggFSac+TvhUwGLwwlBjvy6eS0698=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P189MB0811
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Aug 2026 16:54:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19932

--_000_DU7PPF66507B2D7DF3AD4504715A950243CF3DB2DU7PPF66507B2D7_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Mathieu,

Yes , if we agree on solution, I will send patch series to oe-core and meta=
openembedded as well .

I will prepare and send them tomorrow .


Regards,
Jaipaul

________________________________
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Sent: Thursday, August 13, 2026 5:07 PM
To: Jaipaul Cheernam <jaipaul.cheernam@est.tech>; bitbake-devel@lists.opene=
mbedded.org <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v2] parse: warn on trailing whitespace =
in parsed lines

On Thu Aug 6, 2026 at 1:24 PM CEST, Jaipaul Cheernam wrote:
> rstrip() silently strips trailing whitespace before processing. This
> hides invisible spaces or tabs that end up in patch context and cause
> patches to fail to apply across branches.
>
> Warn on any line with trailing whitespace so developers can fix it early.
>
> Signed-off-by: Jaipaul Cheernam <jaipaul.cheernam@est.tech>
> ---

Hi Jaipaul,

Thanks for the v2. I forgot to ask: do you plan to provide an oe-core
patch fixing all whitespace issues? As so far, this is adding a lot of
warnings during the build:

https://autobuilder.yoctoproject.org/valkyrie/#/builders/4/builds/4405

Thanks,
Mathieu

--
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


--_000_DU7PPF66507B2D7DF3AD4504715A950243CF3DB2DU7PPF66507B2D7_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<div style=3D"font-family: inherit; font-size: inherit; color: inherit; bac=
kground-color: transparent;">
</div>
<div style=3D"font-family: inherit; font-size: inherit; color: inherit; bac=
kground-color: transparent;">
Hi Mathieu,</div>
<div style=3D"font-family: inherit; font-size: inherit; color: inherit; bac=
kground-color: transparent;">
<br>
</div>
<div style=3D"font-family: inherit; font-size: inherit; color: inherit; bac=
kground-color: transparent;">
Yes , if we agree on solution, I will send patch series to oe-core and meta=
openembedded as well .&nbsp;</div>
<div style=3D"font-family: inherit; font-size: inherit; color: inherit; bac=
kground-color: transparent;">
<br>
</div>
<div style=3D"font-family: inherit; font-size: inherit; color: inherit; bac=
kground-color: transparent;">
I will prepare and send them tomorrow .&nbsp;</div>
<div><br>
</div>
<div><br>
</div>
<div id=3D"editor-signature">
<div>
<div style=3D"font-family:Aptos,&quot;Aptos_EmbeddedFont&quot;,&quot;Aptos_=
MSFontService&quot;,Calibri,Helvetica,sans-serif; font-size:12pt; color:rgb=
(0,0,0)">
Regards,</div>
<div style=3D"font-family:Aptos,&quot;Aptos_EmbeddedFont&quot;,&quot;Aptos_=
MSFontService&quot;,Calibri,Helvetica,sans-serif; font-size:12pt; color:rgb=
(0,0,0)">
Jaipaul</div>
</div>
</div>
<div></div>
<br>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Mathieu Dubois-Briand=
 &lt;mathieu.dubois-briand@bootlin.com&gt;<br>
<b>Sent:</b> Thursday, August 13, 2026 5:07 PM<br>
<b>To:</b> Jaipaul Cheernam &lt;jaipaul.cheernam@est.tech&gt;; bitbake-deve=
l@lists.openembedded.org &lt;bitbake-devel@lists.openembedded.org&gt;<br>
<b>Subject:</b> Re: [bitbake-devel] [PATCH v2] parse: warn on trailing whit=
espace in parsed lines</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Thu Aug 6, 2026 at 1:24 PM CEST, Jaipaul Cheern=
am wrote:<br>
&gt; rstrip() silently strips trailing whitespace before processing. This<b=
r>
&gt; hides invisible spaces or tabs that end up in patch context and cause<=
br>
&gt; patches to fail to apply across branches.<br>
&gt;<br>
&gt; Warn on any line with trailing whitespace so developers can fix it ear=
ly.<br>
&gt;<br>
&gt; Signed-off-by: Jaipaul Cheernam &lt;jaipaul.cheernam@est.tech&gt;<br>
&gt; ---<br>
<br>
Hi Jaipaul,<br>
<br>
Thanks for the v2. I forgot to ask: do you plan to provide an oe-core<br>
patch fixing all whitespace issues? As so far, this is adding a lot of<br>
warnings during the build:<br>
<br>
<a href=3D"https://autobuilder.yoctoproject.org/valkyrie/#/builders/4/build=
s/4405" data-auth=3D"NotApplicable" target=3D"_blank">https://autobuilder.y=
octoproject.org/valkyrie/#/builders/4/builds/4405</a><br>
<br>
Thanks,<br>
Mathieu<br>
<br>
-- <br>
Mathieu Dubois-Briand, Bootlin<br>
Embedded Linux and Kernel engineering<br>
<a href=3D"https://bootlin.com" data-auth=3D"NotApplicable" target=3D"_blan=
k">https://bootlin.com</a><br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DU7PPF66507B2D7DF3AD4504715A950243CF3DB2DU7PPF66507B2D7_--

