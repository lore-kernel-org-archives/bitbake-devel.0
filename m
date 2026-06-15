Return-Path: <jaipaul.cheernam@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EC7CD98C5
	for <webhook@archiver.kernel.org>; Mon, 15 Jun 2026 14:59:27 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.14])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.131717.1781535556966463141
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Jun 2026 07:59:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@est.tech header.s=selector1 header.b=Sk5sZUOy;
 spf=pass (domain: est.tech, ip: 52.101.72.14, mailfrom: jaipaul.cheernam@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RCUQk8ug65pFYdFJdjqd67LEC9czVa/RXGBpdiTsHLn0qSWjIdue4uaX1rOSuyM3j0SbBjocpX+F9IxELMHizjs/wHcRzIxed5kde6hBHA9g/16HWlcMhAd8+U03asWnsnOhPWkzHiwZFTRVj8AtYMKf4mDUVMcLKrdHTxKsi3Z/rvMPzzte87C53egsJGd3LVFabjzsPNbLjPfuhU2xt6s5VyCivY/HR8bLq09GJBG9VB9NBNsEOjHjbHNlEXWUVIKUC/Ebf1B0T82sO4KJGKw3l63gx6q2GwJSwsQCM8ca9vznchkj5uv1k17Hq+GIWSmYHs/mblXSos0HjFy3Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1Kk//TgGYPYrDG9P+7M35v2bmSHBLX+aOWtZTcn0y4=;
 b=qa/LJNFQIjTJtoedXjNP3gmX1hjn0O8l7fkQ3mNXcDfijCmwpBxTQ/ugcxBTHDc6O8tGj2sLaATjrSnusAXrEAAT7c2EpNhEek1shvu2TbyemdloDH/dTpUxm61qDnBUS9FLeFc98GdZN4faxJpNCPfx/7LoSMl1blZNabPI/cAX2qmywv0pmCmkNPbc9dDB/d6ARZ3xNC3yWNOg03bDRqWm8DpE46x7tjKhU6mtnj8RMbr5ZWcQF7Pslmb4ym1fIvlafIAwaBUsND8b6DYlCOcQHkfMexe0Q7a22ZMz2RYmEJ+ObQ0DJRwmAAMwL1vsfQItTmhh25P6zdXQnYE7AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1Kk//TgGYPYrDG9P+7M35v2bmSHBLX+aOWtZTcn0y4=;
 b=Sk5sZUOyVydRstn7WiLuykBf5wt+rO0rpXva9oYypP54tDy2urkWCCK7w8Pp0nKjgMyQE7qCkG9t940xVuoaN0Ms5pJ7Nb/rTvvzVLWVn3152rLO0o1kF3gmtm7syweygOk0FvLvtPprjwLl8s1Tw1BiSwwlPHIEtCkG1p7xMEHHuXmEStA1hhHSz29Y1P62+2skf4ryYA3WygIHNr7uFqFLLZG/1I87ooRcooJfKs1N49UFaTVDPwJcw2fCApyl9xD4x9mzJu/AqPWjBD9Hqljb1NrF3dI2XNQMUYU9bwhEnWlDLYPz+r1/5ZjjEqhdX5bthtvp6OGKqkKqJEPuag==
Received: from DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM (2603:10a6:18:3::ad4)
 by AM7P189MB0631.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:11f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 14:59:12 +0000
Received: from DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM
 ([fe80::566d:7425:a795:5560]) by DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM
 ([fe80::566d:7425:a795:5560%7]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 14:59:12 +0000
From: Jaipaul Cheernam <jaipaul.cheernam@est.tech>
To: Alexander Kanavin <alex.kanavin@gmail.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: pass install-buildtools
 options from config and CLI
Thread-Topic: [bitbake-devel] [PATCH] bitbake-setup: pass install-buildtools
 options from config and CLI
Thread-Index: AQHc/MEmemh0KfEkr0iryPC9iD+ZPrY/nSkAgAAPReo=
Date: Mon, 15 Jun 2026 14:59:12 +0000
Message-ID: 
 <DU7PPF66507B2D70622D4334AF9DC0F3C7BF3E62@DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM>
References: <20260615121856.96250-1-jaipaul.cheernam@est.tech>
 <CANNYZj8ggqRPVgpnnX1Qtn5-c-b6=xE=FbdSsnrPt-hMUVKGng@mail.gmail.com>
In-Reply-To: 
 <CANNYZj8ggqRPVgpnnX1Qtn5-c-b6=xE=FbdSsnrPt-hMUVKGng@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU7PPF66507B2D7:EE_|AM7P189MB0631:EE_
x-ms-office365-filtering-correlation-id: bf1f4e2b-17da-4d3a-b0bd-08decaeea979
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|38070700021|22082099003|18002099003|13003099007|8096899003|56012099006|4143699003|11063799006|6133799003;
x-microsoft-antispam-message-info: 
 KboTZps3gkxlL+DSwdStvDu1xyLSE2gIqt+oFmtbzCvk6IWfr+lgbzgMU1dM1vWuw2RwIlWTcDGvaOzanUSnO6K8bRQ9go9GgaAkLdI/R0c3WpxUJlOZ11yP2d3FQzc3ZC/85j/M3oRRCI7g/uYP9ZDHMwuI2IdoUXgXIrtnZKg5/Dibc69zg3JmlMvJ4rbdOqb+vdiekjlVcwqRAArg+25lXffkW80ueBqttjuLR72QizilKVwLx7Od5AO/FYplBP7Zy5dnzmlI+w6fFaj0bJdPorfCZU0eyMdsC2cKuieW2wP+hncnmkbkSY8qAaf8HB7GDIcE2qeBvQ/GVl00BuTW4M2b4pP3hNesSpeep6pyBq4AY+F4fb88tDjXzXbOzCPxdLK3fGVi8XyOuUv3rigwH8H8r+Y247/KvZDvegRu3SXhhNG0SG145qSIWG9fbm3i9yxFdyAdT2SBc2sUBBMDZ8MBxYT+4APpzlYdeGBeLV64//BUdS76GcWbB2Ss7o9k1/Hw5HCUJhoT80wlT5ZtbO6/ESY/RxSjfVrmtWNh+/6SHV7s1beYz2Rh9xHqA/Grc/M8a1uUeDowe1o4Dk5lrEbvWdQEr5Qf5cxlAa8auYA+Rkor2FvHB5T7cVS6JXXOaPuKKEs4AgT5HS945OO/mh/3nvw1jAU/Y31FIgwXkctge07SpIyFSrrrHOXvvEXPuz45ilcySN2zRtPgQEKjYXVxYbhQcT/167gd/MBaFRUBLfxPXK55AvHAsReC
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(22082099003)(18002099003)(13003099007)(8096899003)(56012099006)(4143699003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?ixswXDoO5p6lP0qDCNtHQVSEQMJeWs5CKrbJ23uvywfUdTGIBjqfa5oh?=
 =?Windows-1252?Q?BeN3i6c26mfg2A4AqdOvMGre9rwAi8XAYp3vpJbSKNw4tWqd1C/PmGnt?=
 =?Windows-1252?Q?Vo3kjYAlT7/5XY5gaOIF414Yo+zztRITYI9HsX3aBk6YRCxsOY8qjPlO?=
 =?Windows-1252?Q?28nDIEQtic2w7MUAUqc4mcQNfL5+1MAVBEy+4ZLfkPePDLf0S2WMcpWK?=
 =?Windows-1252?Q?gya+5WDvm2jbOJlyFmLzx7HrXyIHNu4d6Hc+V5LS+ILUEVN9cxdVUfy6?=
 =?Windows-1252?Q?JfkA9147Zyrkufdpo3Ki8hhx1wNInofnS3HFXQzDIBMpwICQ0Yc+zgna?=
 =?Windows-1252?Q?mpwGaHv6edb2u2M+LTwuLBugF7AmmDa8vKJMw41B4pZpq+gTckN3W95x?=
 =?Windows-1252?Q?/qt8ixCcpUuCRHAtPbLQ5MOC34qPv1kilOB6nIGHZ9JAEeHL9Puiwku1?=
 =?Windows-1252?Q?vIwaz+NGXVzSPZmT8eMZnlQ12hm07xGEZ9TZ1kh76A1ocSApxWVwufco?=
 =?Windows-1252?Q?Sx3xBAmBjTOCCxgEfGJjWoyGyA7aOn8mtKTdJmqCgCDxWvB7A2JeRqCb?=
 =?Windows-1252?Q?8SFYpYmApdLteWj6T2RvSyEg46ku9lo11gidX8wdgXUC1F4qkILqvABS?=
 =?Windows-1252?Q?Uoz7HPmeMqDPWbBxfD26QOyodTPuwnUXYR3FkiHbcC+KzK/xC1c/j6q4?=
 =?Windows-1252?Q?lGESK+I0AYEkmkhchQLv1ZuOUz99lTR5YEEHpsildVEavX+tQsPu2gii?=
 =?Windows-1252?Q?geSLWlbNv7RYaDXJtum0CNEABCO0gqQYPIm6I6LZsrX7hkazNJZei6dd?=
 =?Windows-1252?Q?G8BGw8jjxfxUYN1cVqoHHW5ZP4Cuih09p7LiHShIPBJDhlU8hgSUx+V5?=
 =?Windows-1252?Q?ophCNkPOV5FD/a3jArwQo8iVGrLOCNSBrFqi5uqdGLB3/GLnRJOhf54Z?=
 =?Windows-1252?Q?FkYHdVYNeZkKijJDyI9S3G6A2a5WcEhwelXQK8uMWBvOdrV0PHHIiD3+?=
 =?Windows-1252?Q?4xZ5595we2iuvny5mtQDwlAkwotG16YPTxDAqREmnGrTMCZZ1n9pINYX?=
 =?Windows-1252?Q?wHxVnxJ+0U9VoSdjAoXjBuZWZ8QY+1r9nbQXM+78cWGQ94nk208eRUGT?=
 =?Windows-1252?Q?3N4DRrLqiU+ZbsvpZPav/AKk3ZLRs04BlrNKPM6wj2n5M/EBOIO8o4Q5?=
 =?Windows-1252?Q?T9o1nBqqg057yUFeMS42vsQYKSdUYke5nBQXm0tuWXhJLdELaHKaqVL5?=
 =?Windows-1252?Q?97SSQPcCv4jGhnb0VUrH3DZVRUB2Yijr3GjO9F+D66qqMQacL7yOwLkA?=
 =?Windows-1252?Q?ZL8TqSs9sVzjdIrzTLxlqGR66NOXVrZNrGgR2E1yOwV6AuVrwLzlMlGN?=
 =?Windows-1252?Q?7qzaoXtHCGmK1xJodJ7lyBCL7qwdV0BrgW6dnrH31rhuGzZQd0ze/4uT?=
 =?Windows-1252?Q?1NY/CTLUyYJZKu3rUS+BPjEhUlu9w3gwXuD+D9Pd5aMYjOK5Nxp3kidj?=
 =?Windows-1252?Q?kErlVeNw2rR/gKhmpQf7/jIuGVEmVbnbmJQHHbsw/ICKFV8KAuvh5wmz?=
 =?Windows-1252?Q?PwC6rWzV+ictcUmbVxnJG3fewqRdfQ58a0tUhjcOl8W0NHKx5wp4Z5Hg?=
 =?Windows-1252?Q?rWCeo0vexT2Pxf0N4byOD9w6MZdFgU5O7g3G2PDxQvEN2SYnB4Zqd7H6?=
 =?Windows-1252?Q?69AVttELXckf1XAaZq3XuP6/FWfIhggRvLmUn5bNUFqQ2xNWCJ8xmezT?=
 =?Windows-1252?Q?bi19SXWlCr4TaojekuLjrFgydZl+LJ7QgereYuW2FE9RyqhIjGGtmLFu?=
 =?Windows-1252?Q?f8mqp6Ne686OGTQ4S6lZlVxCgSPNGxZjAsxfnCz36CXvCYoDuolZaPKV?=
 =?Windows-1252?Q?KjS5xeNSKe+4D2WBLfXE4MUtj1GVZFdnIH0=3D?=
Content-Type: multipart/alternative;
	boundary="_000_DU7PPF66507B2D70622D4334AF9DC0F3C7BF3E62DU7PPF66507B2D7_"
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1f4e2b-17da-4d3a-b0bd-08decaeea979
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2026 14:59:12.7031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Iphxosif4BO74GSEZUJy6DKUS57qwV4intf2mIYP/EuCd+TCeEcS1VjLnil1pkfxw3h6TMDBJIvMJzwdGPBl+jA8vQ38S7FsQh8EmHZyRpw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P189MB0631
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Jun 2026 14:59:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19687

--_000_DU7PPF66507B2D70622D4334AF9DC0F3C7BF3E62DU7PPF66507B2D7_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

Any downstream distro that builds its own extended buildtools tarball under=
 a non-Poky distro name hits a FileNotFoundError because install-buildtools
hardcodes pokysdk when looking for environment-setup-<arch>-pokysdk-linux. =
The --sdk-name option fixes that hardcoded assumption.

The archive itself contains the same tools as upstream extended buildtools =
=97 it can't be provided via recipes because buildtools exist specifically =
to
bootstrap the host environment before BitBake can run.

The --url and --filename options are needed for projects that host their bu=
ildtools on an internal server rather than yoctoproject.org, and want to pi=
n a
specific version across the team without requiring manual arguments on ever=
y invocation.

The workaround today is to pass arguments manually or modify wrapper script=
s, which is probably why this hasn't surfaced as a bug report before.

The --sdk-name option itself is introduced in a companion patch to oe-scrip=
ts/install-buildtools in openembedded-core:
https://lists.openembedded.org/g/openembedded-core/topic/patch_install_buil=
dtools/119814299

Thanks,
Jaipaul Cheernam


From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Monday, 15 June 2026 at 15:32
To: Jaipaul Cheernam <jaipaul.cheernam@est.tech>
Cc: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembedded.=
org>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: pass install-buildtools=
 options from config and CLI

On Mon, 15 Jun 2026 at 14:19, Jaipaul Cheernam via
lists.openembedded.org
<jaipaul.cheernam=3Dest.tech@lists.openembedded.org> wrote:
> Allow distro-specific buildtools to be configured with a custom URL,
> filename, and SDK name via an install-buildtools section in
> config-upstream.json. Expose the same options as CLI arguments: --url,
> --filename, --sdk-name, --no-check. CLI arguments take precedence over
> config values.
>
> This requires the --sdk-name option to be available in
> oe-scripts/install-buildtools from openembedded-core.

Can you please describe the use case? Presumably this is useful in
your environment, I'd like to understand the specifics of what you put
in the custom buildtools archive and why it has to be there and not
built via recipes.

Alex

--_000_DU7PPF66507B2D70622D4334AF9DC0F3C7BF3E62DU7PPF66507B2D7_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
</head>
<body>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
Hi Alex,</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
Any downstream distro that builds its own extended buildtools tarball under=
 a non-Poky distro name hits a FileNotFoundError because install-buildtools=
</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
hardcodes pokysdk when looking for environment-setup-&lt;arch&gt;-pokysdk-l=
inux. The --sdk-name option fixes that hardcoded assumption.</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
The archive itself contains the same tools as upstream extended buildtools =
=97 it can't be provided via recipes because buildtools exist specifically =
to</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
bootstrap the host environment before BitBake can run.</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
The --url and --filename options are needed for projects that host their bu=
ildtools on an internal server rather than yoctoproject.org, and want to pi=
n a</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
specific version across the team without requiring manual arguments on ever=
y invocation.</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
The workaround today is to pass arguments manually or modify wrapper script=
s, which is probably why this hasn't surfaced as a bug report before.</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
The --sdk-name option itself is introduced in a companion patch to oe-scrip=
ts/install-buildtools in openembedded-core:</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
<a href=3D"https://lists.openembedded.org/g/openembedded-core/topic/patch_i=
nstall_buildtools/119814299" data-outlook-id=3D"9d349569-d889-473b-b429-326=
f468ef19c">https://lists.openembedded.org/g/openembedded-core/topic/patch_i=
nstall_buildtools/119814299</a></div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
Thanks,</div>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);">
Jaipaul Cheernam</div>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"ltr">
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
</div>
<div id=3D"mail-editor-reference-message-container">
<div class=3D"ms-outlook-mobile-reference-message skipProofing">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
</div>
<div style=3D"padding: 3pt 0in 0in; border-width: 1pt medium medium; border=
-style: solid none none; border-color: rgb(181, 196, 223) currentcolor curr=
entcolor;">
<div class=3D"ms-outlook-mobile-reference-message skipProofing" style=3D"te=
xt-align: left; font-family: Aptos; font-size: 12pt; color: black;">
<b>From: </b>Alexander Kanavin &lt;alex.kanavin@gmail.com&gt;<br>
<b>Date: </b>Monday, 15 June 2026 at 15:32<br>
<b>To: </b>Jaipaul Cheernam &lt;jaipaul.cheernam@est.tech&gt;<br>
<b>Cc: </b>bitbake-devel@lists.openembedded.org &lt;bitbake-devel@lists.ope=
nembedded.org&gt;<br>
<b>Subject: </b>Re: [bitbake-devel] [PATCH] bitbake-setup: pass install-bui=
ldtools options from config and CLI<br>
<br>
</div>
</div>
<div class=3D"PlainText" style=3D"font-size: 11pt;">On Mon, 15 Jun 2026 at =
14:19, Jaipaul Cheernam via<br>
lists.openembedded.org<br>
&lt;jaipaul.cheernam=3Dest.tech@lists.openembedded.org&gt; wrote:<br>
&gt; Allow distro-specific buildtools to be configured with a custom URL,<b=
r>
&gt; filename, and SDK name via an install-buildtools section in<br>
&gt; config-upstream.json. Expose the same options as CLI arguments: --url,=
<br>
&gt; --filename, --sdk-name, --no-check. CLI arguments take precedence over=
<br>
&gt; config values.<br>
&gt;<br>
&gt; This requires the --sdk-name option to be available in<br>
&gt; oe-scripts/install-buildtools from openembedded-core.<br>
<br>
Can you please describe the use case? Presumably this is useful in<br>
your environment, I'd like to understand the specifics of what you put<br>
in the custom buildtools archive and why it has to be there and not<br>
built via recipes.<br>
<br>
Alex<br>
</div>
</div>
</body>
</html>

--_000_DU7PPF66507B2D70622D4334AF9DC0F3C7BF3E62DU7PPF66507B2D7_--

