Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84F0C71153
	for <webhook@archiver.kernel.org>; Mon,  4 Sep 2023 09:49:42 +0000 (UTC)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web11.44923.1693820978400896375
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 04 Sep 2023 02:49:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=ONhgowMZ;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=TsrbCjai;
 spf=pass (domain: axis.com, ip: 195.60.68.18, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1693820979;
  x=1725356979;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=JsN3nd2Xze33jdrAUDPNi02C9WvrHFOzSKOBgWeDOCc=;
  b=ONhgowMZ1fgaLGWZWRXwYbmKrFU6G9n9HOAhlAIE3p/KWcKIIm1sOLpr
   5VWUBqHmvQ2l9VcIf2q9wtS1c5BuDHIfbyrsiujFHh9kketHk06bIZfV4
   6Vs6kyVanacb2wYoRrbO3BBxr6C8rQiOi3dX5kZ+C2QDYquvQU4lpXGrN
   A9Q8Qp+aV0zcdBcWL4Tc8rHX6Qsnk0Y3Yc3sI4jwy2UrthmlbpdUogsKA
   EevAmiQ3+oRulx/znwPK1AqK8yiuchRYWf9zE1VAtXH9I5K67iCrGAFCL
   UghmgwlEdpgTu/5kaoYHoJyGKh3urdQPhBBjYIUx7z0PQgujlP3QPuBE0
   A==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlBOylFcE41/ZHWY3sdUETvF/olDlb6tpraTO/Xxxwna4iLW8gnVn8bdn1pTugNJ2uxNMbLurri250NvDyup3+b9FgpdQ2e9Ppfx9CdK4k/OoZIEZJBuPzxtTtNVAne5AmEl9kM3q7dUQYK+G6mH1OOSpxyv9hJpauGXTVVk5hNVMu7W6bgaQOPJQ51V6X2Gs37JVlL6aN7qG8glfS882aJySeB9G+Brs5RKa+njrlK4m+YwS85MlVR3eW86MPbzap6BSXDFIPJ8tLR2WAOzlqOiK8Mpvw4nvDb7szhNpwsvH+6BbUNkeHpo/R/+eBZTIGuCn2IH4CMGfowmZVgxww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsN3nd2Xze33jdrAUDPNi02C9WvrHFOzSKOBgWeDOCc=;
 b=K7LSAZEU/G1FXpLe/U3mBIIV4dOEkBXimtT2wDn7S2I7MUvw4W5Co7CrOxuoJsDpsAHlmx42d98XpP3/CTWWULJanbcQUN/gKG0X3Kxag71fuPiJnOpKhTMaZvzvgtBuRFTE14S29t26+4kdpCMChCrn5w87NVc97U/v3zdXBvpF2bZC6JfntxzxvC4kcXxymn3ZJCMksTNnyOL0F65Kjb43YQiilOzEsI6kZW998LxaSe6ZN6rIZnCqBrzhjvHr2+f1gZYGSmx5V1xlCNNUPv4TUd8x7UpIxzX4JGLmXJAyX9R9muvaxO4904BTlM1CsAKxkygfykfafFz7u6LIZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsN3nd2Xze33jdrAUDPNi02C9WvrHFOzSKOBgWeDOCc=;
 b=TsrbCjai610pLyGJH0gL7Fs4BzLsLwpL0JEbmVqmY8iyn3gp0OKLFyDHXZEl9KMdvCyttv8SUviwC0vv/zmw+t4eSOJ63axh14bygznKBhnEUfRFnl8DqZtDRiiKaDUdPCjS4WmPt8+QMzRtYTpma7luBqxL8I1zbeRHi/76m90=
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH v2] doc: Document challenges of tags with
 git fetcher
Thread-Topic: [bitbake-devel] [PATCH v2] doc: Document challenges of tags with
 git fetcher
Thread-Index: AQHZ3xGWfN2wi95AXUW/z79+GSslLLAKaiHw
Date: Mon, 4 Sep 2023 09:49:33 +0000
Message-ID: <DB5PR02MB10213AEBFE4ED63F5628E52AEEFE9A@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20230904092405.2671456-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20230904092405.2671456-1-richard.purdie@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|AS8PR02MB7335:EE_
x-ms-office365-filtering-correlation-id: e9f2b540-f817-4c94-50f6-08dbad2c3e1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HIfCKsfTzC7aI5Ddq8q3J2oFx2CdVqrBDPFRuWe11X91Wren89VL/PXgdUitBSavuQksK9hzeME3satLblm0F4yy/XZYZNi3WDsJ+QLoUj0aKInU3Nti3kt32cUFnkjhL7RRORIL00Z4KMWvM6dYoaSo5AtFOq5CAe0faOR5sbrLW5IRNmFwzUoVsRGYL3Sd6HXezEw2ijhMQmzqTtzEWg0mUGxKZK8m4EgCQs3rmZlUjpDDYGiVhDJ8Kblq3YcyedHqYuZe0WfIrYPXQ8x4wP8M7y5nddjGXyk10thnEo3nzyAni+wo77PTnfdo4fUyGQABZAIK2GSe7WfNVFah4UbR0JPrdFgsOJFudzFSVZ+BLIcjByUHs332j1XDH4ay2XqAZqj8s5ND8lpQtB5BLDTzEuVDHFTnYopmy2FyYsqdWj/txpxjNUAVMqlpIrx3nj3PSdZFYCV+wnoPuVov2eRQfV2QNahxj5PwAdPt0UMDDm+Uiyds3h7di0EChzz11U06BfTec/uSFtt3dUT7bgh9i3fz9DEAG8+astnpqOXsrixkupbgP+klanMT+EvNo+vKS1jTVMP4RQ5JqYJeJL1zndcGdVY3Pnt+dDHvdt9JWr0cJRNekAcmlWfUN8Sf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39860400002)(136003)(376002)(186009)(1800799009)(451199024)(41300700001)(71200400001)(6506007)(7696005)(53546011)(478600001)(122000001)(38070700005)(83380400001)(26005)(9686003)(38100700002)(55016003)(110136005)(76116006)(66946007)(2906002)(66476007)(66446008)(64756008)(316002)(33656002)(86362001)(66556008)(5660300002)(52536014)(44832011)(8936002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Oco04eWqWlHUzVFGizvUVFPIaWJcOLeGPAxkd9hZlP0oCTrMiL7QObOF9vsN?=
 =?us-ascii?Q?5NB38V/uNbW/taheXDBs05SCyN61zYNzrCoDi/xW8W/0wxlMZfw4WbtfTXia?=
 =?us-ascii?Q?InwkMF7A7W3Ef4n5PSgnjZBzr+XRXODcjA+oI43r3NQSm2ow+zp81SSiMLCV?=
 =?us-ascii?Q?QZ9HMrRICrKgPII4jjaZK6BdJ55MKUSdQA9/wFzv9Kk/jYdWNtXqpXDiCjTZ?=
 =?us-ascii?Q?rXKtRAOOTyA/f3TjxWbLC4sfgYE6BswCaaPJQDJcvXvDpVCE+at90RbFGaPj?=
 =?us-ascii?Q?a/RSoRID9k82tmwt7cBGyxOno7YNwr7h98ysYwbQJTl/5cHU90XoWrulhwcQ?=
 =?us-ascii?Q?k2nlRAsy7DJBXEKLmGSkma5OoiZFDptxuS8kMttZ+n96/9sQ6z6lC6f2v7o5?=
 =?us-ascii?Q?HAmYB5n2bCmVYCDRXNRQlHznyeyNmq5R9mNgC61Ur7QNrWmcuXcCyrHMichH?=
 =?us-ascii?Q?KGFUOBl4JP4lFjkp91tFrjJ/qwMvhw/I1Jt9ENDvskGZN8h71wdRdeOoL2Ll?=
 =?us-ascii?Q?/cFtHrCNHRULXfMZZR2ord/wDbzkjmbxygAKth2WrSwug57hJ6p28teizUcy?=
 =?us-ascii?Q?VFGtRuMUxvYAYwsJZpf+fwFZgl/13XF2yV2+gAI9qquhG6HlEIolWdLc1TeP?=
 =?us-ascii?Q?eTk6TCAsUS5n9v/xGJc3yBoKi2BRiRsxVQ/lJQi+XeoXmKcBBL7cN+awOrAV?=
 =?us-ascii?Q?egifzGfM/qhaE0jkxZfyCf4zCJi2t262+qBqk02jPP7ph4Vs7lcCwz+1BiaW?=
 =?us-ascii?Q?DdCWF1c/FnCYBUv2Vv0A4F61Fkgjnk/S7d71DURt+2UlhLV1yOs9qHpbcVLI?=
 =?us-ascii?Q?q5M3FaihnFfehdUCsazpje6E2ArKpVq9Q8j6k7Nn6NzHvjoomFRVvQtRYm7G?=
 =?us-ascii?Q?gZYxxMFBGRNgnRPfFqk2aHfZTbHKJ+sBkNmzUpD64YIRGYmhgGNI5DXXHmq/?=
 =?us-ascii?Q?Tg57lYHi6VbutMIxIRASwr/St92edLepJ0QzXWKaRvwWlTkFrI5evKtHYTHF?=
 =?us-ascii?Q?ov9CKWcddXiKGt86e8hcmck1mJfJcrQmHNSflELqpEIgjMfkSyNMpnApsD6x?=
 =?us-ascii?Q?oSbn6sAuZmlwNSyObVCxk+hHihWB+cyzT9YBBvhXCPozUZea+mCnfcHwA9Zg?=
 =?us-ascii?Q?rEfuaIps+jJoHl+uV12nqc7VrPWxALAXsyD9rlSsuNdeI7xm2nJMA2ZfTyD3?=
 =?us-ascii?Q?uSwILh93VudAzVlORzHBS4U7uDDJuHdSIo7Z5ravIHw1dOUYU2lRuin6lz34?=
 =?us-ascii?Q?p3yN9zwt3lyhLwtEhkIZ3L56R3CNgMbdpDDHjIllKz3GqqYVxGt8RVBi3Q+F?=
 =?us-ascii?Q?rHFhY0yTEgDJhk/e9VGPIr6TGlFB7kcFa6deTWu9TF/JVt0WrmkHDrARdRD7?=
 =?us-ascii?Q?PchkxrmoAdq53xHW+5qL/l95n5biOjhPpv/kkwZ1k+ti5GwP0/zpJrZ/ZcfG?=
 =?us-ascii?Q?6QsFZF/nJxTNExgwiHWWt7bIqb+AhGYEBq6RPf8zlKBJxAkNI9mH5Loo+Mlx?=
 =?us-ascii?Q?tljuP3ftIdHHxBF9F7XSr/rLmVWnecCSPgmYNXIaomku7J/Cf0RhMW1e12iL?=
 =?us-ascii?Q?oIjCNLSnKSmskUTqkqE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f2b540-f817-4c94-50f6-08dbad2c3e1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2023 09:49:33.4880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 15bPLUadxib6k05hTHFO3n3a+IoNDgtLDktv/9+qIPyYaPcONvQC9k4EhXtE2Rxk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB7335
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 04 Sep 2023 09:49:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15010

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembed=
ded.org> On Behalf Of Richard Purdie
> Sent: den 4 september 2023 11:24
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH v2] doc: Document challenges of tags with=
 git fetcher
>=20
> Using tags with the git fetcher may cause surprising behaviour. There
> are reasons for this, document them.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
> v2 - add tweaks requested in review
>=20
>  doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> index f5723d6767..dc125509ff 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> @@ -476,6 +476,14 @@ Here are some example URLs::
>     easy to share metadata without removing passwords. SSH keys,
> ``~/.netrc``
>     and ``~/.ssh/config`` files can be used as alternatives.
>=20
> +Using tags with the git fetcher may cause surprising behaviour. Bitbake =
needs to
> +resolve the tag to a specific revision and to do that, it has to connect=
 to and use
> +the upstream repository. This is because the revision tags point at can =
change and

I suggest changing "the revision tags" to "the revision the tags" because=20
the first time I read it, I read it as "revision tags" rather than "revisio=
n"=20
"tags", which did not make any sense.

> +we've seen cases of this happening in well known public repositories. Th=
is can mean

"well known" -> "well-known".

> +many more network connections than expected and recipes may reparsed at =
every build.

"may reparsed" -> "may be reparsed"

> +Source mirrors will also be bypassed as the upstream repository is the o=
nly source
> +of truth to resolve the revision accurately. For these reasons, whilst t=
he fetcher
> +can support tags, we recommend being specific about revisions in recipes=
.
>=20
>  .. _gitsm-fetcher:
>=20
> --
> 2.39.2

//Peter


