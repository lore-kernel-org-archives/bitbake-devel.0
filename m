Return-Path: <michalwsieron@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BF6CC6B38
	for <webhook@archiver.kernel.org>; Fri, 16 Oct 2026 07:59:08 +0000 (UTC)
Subject: Re: [docs] [bitbake-devel] [PATCH 3/4] knotty: convert warnings to errors when -W is passed
To: bitbake-devel@lists.openembedded.org
From: "Michal Sieron" <michalwsieron@gmail.com>
X-Originating-Location: PL (31.60.65.118)
X-Originating-Platform: Android Phone Firefox 158
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Fri, 16 Oct 2026 00:59:05 -0700
References: <20261013-warn-as-errors-v1-0-ab3658758ceb@bootlin.com> <20261013-warn-as-errors-v1-3-ab3658758ceb@bootlin.com> <5d6d74ea44bf61549823ccde83e4c4ed1e274dc4.camel@linuxfoundation.org> <DM5C7YSFK5Y8.14E684HX5TS18@bootlin.com> <6563fc5659f06a1a6b1eb72ec05b9109dfe9f64a.camel@linuxfoundation.org> <DM5EQUZ5TIGZ.1KG28FB6KB03G@bootlin.com> <7dbc1fbb0314b61bbc2913aa004f8ebfd968cc03.camel@linuxfoundation.org> <DM5GYBADXEX9.2UOTTZAL4JTT2@bootlin.com>
In-Reply-To: <DM5GYBADXEX9.2UOTTZAL4JTT2@bootlin.com>
Message-ID: <2040945.1792137545176168291@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="3IS1lXyIhXmTdSQAgUqB"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 16 Oct 2026 07:59:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20350

--3IS1lXyIhXmTdSQAgUqB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

two cents from my side. I think that warnings as errors would ideally work =
like normal -Werror in compilers.

1. Regarding name: -W doesn't indicate anything about errors. Only somethin=
g with warnings. I am not sure if having this short option is worth it.

2. This might be controversial, but ability to do -Wno-error, would be grea=
t. Problem is we don't have categorized/named warnings/errors. But I think =
that it could support a syntax where we use file name (or partial match on =
its path) and disable warnings-as-errors for that source file. Or this migh=
t be even easier to implement: regex for warning message. It it matches, it=
 won't be treated as an error.

3. Exit code only change won't force developers to immediately fix their co=
de as it's really easy to ignore in interactive terminals. Sure, later CI w=
ould catch it, but I would prefer early fail if possible.

Br,
Michal

--3IS1lXyIhXmTdSQAgUqB
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Hi,<br /><br />two cents from my side. I think that warnings as errors=
 would ideally work like normal -Werror in compilers.<br /><br />1. Regardi=
ng name: -W doesn't indicate anything about errors. Only something with war=
nings. I am not sure if having this short option is worth it.<br /><br />2.=
 This might be controversial, but ability to do -Wno-error, would be great.=
 Problem is we don't have categorized/named warnings/errors. But I think th=
at it could support a syntax where we use file name (or partial match on it=
s path) and disable warnings-as-errors for that source file. Or this might =
be even easier to implement: regex for warning message. It it matches, it w=
on't be treated as an error.<br /><br />3. Exit code only change won't forc=
e developers to immediately fix their code as it's really easy to ignore in=
 interactive terminals. Sure, later CI would catch it, but I would prefer e=
arly fail if possible.<br /><br />Br,<br />Michal</div>

--3IS1lXyIhXmTdSQAgUqB--

