Return-Path: <shibi.cbe@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEE4C54EE9
	for <webhook@archiver.kernel.org>; Tue, 20 Sep 2022 08:18:26 +0000 (UTC)
Subject: Re: [PATCH] fetch2/cooker: Fix source revision handling with floating
 upstreams
To: bitbake-devel@lists.openembedded.org
From: shibi.cbe@gmail.com
X-Originating-Location: Mumbai, Maharashtra, IN (52.95.75.18)
X-Originating-Platform: Mac Chrome 104
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Tue, 20 Sep 2022 01:18:26 -0700
References: <20220210175426.2695614-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20220210175426.2695614-1-richard.purdie@linuxfoundation.org>
Message-ID: <18843.1663661906268649916@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="tuqKxZb7eZZrqhdWUoix"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Sep 2022 08:18:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13982

--tuqKxZb7eZZrqhdWUoix
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello=C2=A0 Richard Purdie

Above patch in lib/bb/fetch2/git.py fails "devtool modify" for the recipe w=
hich uses ${AUTOREV}

Raised a topic on the same(below URL).

https://lists.openembedded.org/g/Openembedded-issues/topic/devtool_fails_if=
_srcrev_is/93705955?p=3D,,,20,0,0,0::recentpostdate/sticky,,,20,2,0,9370595=
5,previd%3D1663264030971523351,nextid%3D1298300470000000000&previd=3D166326=
4030971523351&nextid=3D1298300470000000000

Not expert in complete workflow. To verify it set __BBSEENSRCREV as 1 above=
 your patch( which is totally wrong this is just to check if its the issue)=
. It actually works as expected

d.setVar('__BBSEENSRCREV', '1')

if not d.getVar("__BBSEENSRCREV"):

raise bb.fetch2.FetchError("Recipe uses a floating tag/branch without a fix=
ed SRCREV yet doesn't call bb.fetch2.get_srcrev() (use SRCPV in PV for OE).=
")

Just want to understand how __BBSEENSRCREV is set. is it possible to set th=
is variable/ignore this check for devtool operations

--tuqKxZb7eZZrqhdWUoix
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<p>Hello&nbsp; Richard Purdie</p>
<p>Above patch in&nbsp;<span style=3D"white-space: pre-wrap;"> lib/bb/fetch=
2/git.py fails "devtool modify" for the recipe which uses </span>&nbsp;${AU=
TOREV}</p>
<p>Raised a topic on the same(below URL).</p>
<div>&nbsp;</div>
<p><a href=3D"https://lists.openembedded.org/g/Openembedded-issues/topic/de=
vtool_fails_if_srcrev_is/93705955?p=3D,,,20,0,0,0::recentpostdate/sticky,,,=
20,2,0,93705955,previd%3D1663264030971523351,nextid%3D1298300470000000000&a=
mp;previd=3D1663264030971523351&amp;nextid=3D1298300470000000000" target=3D=
"_blank" rel=3D"noopener">https://lists.openembedded.org/g/Openembedded-iss=
ues/topic/devtool_fails_if_srcrev_is/93705955?p=3D,,,20,0,0,0::recentpostda=
te/sticky,,,20,2,0,93705955,previd%3D1663264030971523351,nextid%3D129830047=
0000000000&amp;previd=3D1663264030971523351&amp;nextid=3D129830047000000000=
0</a>&nbsp;</p>
<p>&nbsp;</p>
<p>Not expert in complete workflow. To verify it set __BBSEENSRCREV as 1 ab=
ove your patch( which is totally wrong this is just to check if its the iss=
ue). It actually works as expected</p>
<p>&nbsp; &nbsp; &nbsp; &nbsp; d.setVar('__BBSEENSRCREV', '1')</p>
<p>&nbsp; &nbsp; &nbsp; &nbsp; if not d.getVar("__BBSEENSRCREV"):</p>
<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; raise bb.fetch2.FetchError("Re=
cipe uses a floating tag/branch without a fixed SRCREV yet doesn't call bb.=
fetch2.get_srcrev() (use SRCPV in PV for OE).")</p>
<p>Just want to understand how __BBSEENSRCREV is set. is it possible to set=
 this variable/ignore this check for devtool operations</p>
<p>&nbsp;</p>

--tuqKxZb7eZZrqhdWUoix--

