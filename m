Return-Path: <Jef.Driesen@niko.eu>
Received: from relay08.secure-mail.be (relay08.secure-mail.be [195.13.7.11])
	by mail.openembedded.org (Postfix) with ESMTP id 6A11478837
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  2 Jul 2018 10:15:39 +0000 (UTC)
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BOAQBx+jlb/7lOx1RcGgEBAQEBAgEBA?=
	=?us-ascii?q?QEIAQEBAYJ1VFQOgScKi3OMO4IHlSSBegslBgGEQAKDLyE0GAECAQECAQECAWw?=
	=?us-ascii?q?cDII1IoJgAQU6TwIBCBgKFBAyJQEBBAESCIMZggADAQqpL4hJgS4JAYdZgQqCF?=
	=?us-ascii?q?YQegxgEGIFGAiqDBoIkAodHQJE/BwKGBopXhAyICYozh1SBQTiBUnODNgmLC4U?=
	=?us-ascii?q?+bwEJcAEBj0cBgRkBAQ?=
X-IPAS-Result: =?us-ascii?q?A2BOAQBx+jlb/7lOx1RcGgEBAQEBAgEBAQEIAQEBAYJ1VFQ?=
	=?us-ascii?q?OgScKi3OMO4IHlSSBegslBgGEQAKDLyE0GAECAQECAQECAWwcDII1IoJgAQU6T?=
	=?us-ascii?q?wIBCBgKFBAyJQEBBAESCIMZggADAQqpL4hJgS4JAYdZgQqCFYQegxgEGIFGAiq?=
	=?us-ascii?q?DBoIkAodHQJE/BwKGBopXhAyICYozh1SBQTiBUnODNgmLC4U+bwEJcAEBj0cBg?=
	=?us-ascii?q?RkBAQ?=
Received: from edge.nikogroup.be ([84.199.78.185])
	by relay08.secure-mail.be with ESMTP; 02 Jul 2018 12:15:40 +0200
Received: from HUB.NIKO.LAN (172.22.10.201) by EDGE.nikogroup.be
	(192.168.22.31) with Microsoft SMTP Server (TLS) id 14.3.389.1;
	Mon, 2 Jul 2018 12:16:34 +0200
Received: from MBX.NIKO.LAN ([::1]) by HUB.NIKO.LAN ([::1]) with mapi id
	14.03.0389.001; Mon, 2 Jul 2018 12:15:39 +0200
From: <Jef.Driesen@niko.eu>
To: <richard.purdie@linuxfoundation.org>,
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] pseudo interfering with git fetcher?
Thread-Index: AdQR0uTHwFwZZOBAT6GLxsUtv6PFvQ==
Date: Mon, 2 Jul 2018 10:15:39 +0000
Message-ID: <FAB9E48578194042BE5C63B8BE47610339DDDBB4@MBX.NIKO.LAN>
References: <FAB9E48578194042BE5C63B8BE47610339DD77AC@MBX.NIKO.LAN>
	<5a7291cc2b09594f618088148ea31d18354f157a.camel@linuxfoundation.org>
Accept-Language: en-US, nl-BE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.10.222]
x-endpointsecurity-0xde81-ev: v:6.6.2.49, d:out, a:y, w:t, t:16,
	sv:1530515039, ts:1530526540
x-exclaimer-md-config: ea9a6d46-d5fe-4ddc-9ba9-49fab8e88ad4
MIME-Version: 1.0
Subject: Re: pseudo interfering with git fetcher?
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 02 Jul 2018 10:15:40 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On 07/02/2018 11:33 AM, Richard Purdie wrote:
> On Mon, 2018-07-02 at 07:04 +0000, Jef.Driesen@niko.eu wrote:
>> I'm occasionally experiencing problems when fetching code from git
>> repositories over ssh. The error is always this one:
>
> Which version of bitbake are you using?
>
> I think this change may help you:
>
> http://git.yoctoproject.org/cgit.cgi/poky/commit/bitbake?id=3D205cfd70219=
0026e64eed9cae27c05ff62d1637e

We are using pyro (and about to upgrade to rocko). But it looks like
that commit is only available in later versions (sumo).

Jef
Disclaimer

This e-mail and its attachments is intended only for the person(s) or entit=
y to which it is addressed. If you receive this e-mail by mistake, please d=
elete this e-mail from your system and destroy all copies of it. It may con=
tain confidential and/or privileged information. You should not copy it or =
use it for any purpose nor disclose its contents to any person unless allow=
ed by a written document between the sender and the addressee.

