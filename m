Return-Path: <zizuzacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C355E64012
	for <webhook@archiver.kernel.org>; Sun,  5 Apr 2026 05:29:52 +0000 (UTC)
Subject: Re: [PATCH] bitbake: Resolve symlink duplicates in layer paths
To: bitbake-devel@lists.openembedded.org
From: "Zk47T" <zizuzacker@gmail.com>
X-Originating-Location: Hanoi, VN (14.177.124.140)
X-Originating-Platform: Linux Chrome 143
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Sat, 04 Apr 2026 22:29:42 -0700
References: <20260403153327.64044-1-zizuzacker@gmail.com> <112696b9cf819c10a162830a2e7759cf188ba216.camel@linuxfoundation.org>
In-Reply-To: <112696b9cf819c10a162830a2e7759cf188ba216.camel@linuxfoundation.org>
Message-ID: <275547.1775366982271565372@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="lwYwqkMnqyLK3l8SPLu1"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 05 Apr 2026 05:29:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19322

--lwYwqkMnqyLK3l8SPLu1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The user doesn't intentionally add the same layer twice =E2=80=94 this happ=
ens when the working directory uses a symlink path (e.g., /home/pokybuild =
=E2=86=92 /srv/ pokybuild ). Running bitbake-layers add-layer /srv/pokybuil=
d/.../meta-mingw resolves to a different string than what's already in bbla=
yers.conf (which was set via the symlink path), causing ERROR: Found duplic=
ated BBFILE_COLLECTIONS.

The main fix is using os.path.realpath() inste ad of os.path.abspath() in d=
o_ add_layer() and canonicalise_ path() , which prevents the duplicate from=
 being added in the first place.

Regarding the warning in cookerdata.py =E2=80=94 I can remove it if you pre=
fer silent deduplication. I added it for visibility when users have manuall=
y edited bblayers.conf with symlink paths. Would you prefer it to silently =
resolve duplicates instead?

This behavior as you shared in root ticket bugzilla https://bugzilla.yoctop=
roject. org/show_bug.cgi?id=3D15591 ( https://bugzilla.yoctoproject.org/sho=
w_bug.cgi?id=3D15591 )

I try to implement the fix

--lwYwqkMnqyLK3l8SPLu1
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>
<p style=3D"color: #222222; font-family: Arial, Helvetica, sans-serif; font=
-size: small; font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-=
color: #ffffff; text-decoration-thickness: initial; text-decoration-style: =
initial; text-decoration-color: initial;">The user doesn't intentionally ad=
d the same layer twice &mdash; this happens when the working directory uses=
 a symlink path (e.g.,<span>&nbsp;</span><code>/home/pokybuild</code><span>=
&nbsp;</span>&rarr;<span>&nbsp;</span><code>/srv/<wbr />pokybuild</code>). =
Running<span>&nbsp;</span><code>bitbake-layers add-layer /srv/pokybuild/...=
/meta-mingw</code><span>&nbsp;</span><wbr />resolves to a different string =
than what's already in bblayers.conf (which was set via the symlink path), =
causing<span>&nbsp;</span><code>ERROR: Found duplicated BBFILE_COLLECTIONS<=
/code>.</p>
<p style=3D"color: #222222; font-family: Arial, Helvetica, sans-serif; font=
-size: small; font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-=
color: #ffffff; text-decoration-thickness: initial; text-decoration-style: =
initial; text-decoration-color: initial;">The main fix is using<span>&nbsp;=
</span><code>os.path.realpath()</code><span>&nbsp;</span>inste<wbr />ad of<=
span>&nbsp;</span><code>os.path.abspath()</code><span>&nbsp;</span>in<span>=
&nbsp;</span><code>do_<wbr />add_layer()</code><span>&nbsp;</span>and<span>=
&nbsp;</span><code>canonicalise_<wbr />path()</code>, which prevents the du=
plicate from being added in the first place.</p>
<p style=3D"color: #222222; font-family: Arial, Helvetica, sans-serif; font=
-size: small; font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-=
color: #ffffff; text-decoration-thickness: initial; text-decoration-style: =
initial; text-decoration-color: initial;">Regarding the warning in<span>&nb=
sp;</span><code>cookerdata.py</code><span>&nbsp;</span>&mdash; I can remove=
 it if you prefer silent deduplication. I added it for visibility when user=
s have manually edited bblayers.conf with symlink paths. Would you prefer i=
t to silently resolve duplicates instead?</p>
<p style=3D"color: #222222; font-family: Arial, Helvetica, sans-serif; font=
-size: small; font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-=
color: #ffffff; text-decoration-thickness: initial; text-decoration-style: =
initial; text-decoration-color: initial;">&nbsp;</p>
<p style=3D"color: #222222; font-family: Arial, Helvetica, sans-serif; font=
-size: small; font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-=
color: #ffffff; text-decoration-thickness: initial; text-decoration-style: =
initial; text-decoration-color: initial;">This behavior as you shared in ro=
ot ticket bugzilla<span>&nbsp;</span><a style=3D"color: #1155cc;" href=3D"h=
ttps://bugzilla.yoctoproject.org/show_bug.cgi?id=3D15591" target=3D"_blank"=
 rel=3D"noopener" data-saferedirecturl=3D"https://www.google.com/url?q=3Dht=
tps://bugzilla.yoctoproject.org/show_bug.cgi?id%3D15591&amp;source=3Dgmail&=
amp;ust=3D1775453193778000&amp;usg=3DAOvVaw2ZyPQXBFEts-3mwIo2GPCl">https://=
bugzilla.yoctoproject.<wbr />org/show_bug.cgi?id=3D15591</a>&nbsp;</p>
<p style=3D"color: #222222; font-family: Arial, Helvetica, sans-serif; font=
-size: small; font-style: normal; font-variant-ligatures: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; tex=
t-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-=
color: #ffffff; text-decoration-thickness: initial; text-decoration-style: =
initial; text-decoration-color: initial;">I try to implement the fix</p>
</div>

--lwYwqkMnqyLK3l8SPLu1--

