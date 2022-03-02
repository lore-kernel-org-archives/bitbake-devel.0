Return-Path: <stefnexter@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA10C433EF
	for <webhook@archiver.kernel.org>; Wed,  2 Mar 2022 19:55:09 +0000 (UTC)
Subject: Re: access to bitbake arguments
To: bitbake-devel@lists.openembedded.org
From: stefnexter@gmail.com
X-Originating-Location: Spanga, Stockholm County, SE (81.170.142.70)
X-Originating-Platform: Windows Chrome 98
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 02 Mar 2022 11:55:08 -0800
References: 
 <73584559cd1f88812f3ebdd516ed468ab32edb8a.camel@linuxfoundation.org>
In-Reply-To: 
 <73584559cd1f88812f3ebdd516ed468ab32edb8a.camel@linuxfoundation.org>
Message-ID: <30834.1646250908639032259@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="lRWP7qpUzc9UGSkXWliY"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 02 Mar 2022 19:55:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13407

--lRWP7qpUzc9UGSkXWliY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,
What we do is change a environment variable if the recipe name ends with un=
ittest and then

require "conf/${FOO}.conf

Foo could be provided on command line like this

FOO=3Dbar=C2=A0 bitbake something_unittest

and based on recipe name it is either unchanged or appends an "u"

when recipe ends with unittest the resulting FOO should be baru,=C2=A0 vari=
able is also used as override.

I am basically looking list of recipes provided on command line or the depe=
ndencies, like pkgs_to_build.

I hope it made sense. It is complicated=C2=A0since we are trying to avoid t=
oo big changes to legacy CI engine.

//Stef

--lRWP7qpUzc9UGSkXWliY
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<p style=3D"line-height: 1.42857;">Hi,<br />What we do is change a environm=
ent variable if the recipe name ends with unittest and then</p>
<p style=3D"line-height: 1.42857;">require "conf/${FOO}.conf<br /><br />Foo=
 could be provided on command line like this</p>
<p style=3D"line-height: 1.42857;">FOO=3Dbar&nbsp; bitbake something_unitte=
st</p>
<p style=3D"line-height: 1.42857;">and based on recipe name it is either un=
changed or appends an "u"</p>
<p style=3D"line-height: 1.42857;">when recipe ends with unittest the resul=
ting FOO should be baru,&nbsp; variable is also used as override.</p>
<p style=3D"line-height: 1.42857;">I am basically looking list of recipes p=
rovided on command line or the dependencies, like pkgs_to_build.</p>
<p style=3D"line-height: 1.42857;">I hope it made sense. It is complicated&=
nbsp;since we are trying to avoid too big changes to legacy CI engine.</p>
<p style=3D"line-height: 1.42857;"><br />//Stef</p>

--lRWP7qpUzc9UGSkXWliY--

