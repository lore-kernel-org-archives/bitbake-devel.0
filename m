Return-Path: <kergoth@gmail.com>
Received: from mail-io0-f174.google.com (mail-io0-f174.google.com
	[209.85.223.174])
	by mail.openembedded.org (Postfix) with ESMTP id A334B60124
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Jul 2016 18:36:40 +0000 (UTC)
Received: by mail-io0-f174.google.com with SMTP id t74so107570399ioi.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 01 Jul 2016 11:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=fdkOa/8ODfXPT5UGtyvWTPKn8wEHA/UAIWdMwuoseyY=;
	b=B01rDuaOpvR0+mYB9IFUbDOktjNxs1TIqj9XVyV2vlGmSOuWI62NhFak4xakESQTSt
	6/y3Z6ojKE4yX10onw+p/FBQfBi34rv1r/r5/oreTaTnA5H3Dx4BUOARaGYq+3QSqVl0
	3ZZY+dMRaTbEfI8qJtIqMo0DuAblC5ZoG/tTmEzze2GvEoxfMnbmwB1ZNshReFZHE7c1
	W++KA/LqBLwp7y3vVYlYiOps3UhLOi8McBC8NJ/HuSpdNRIbK9MX4q1HgonRnH3cXIqv
	pr+WYgcIImdZDVWwmKLZbF4IC39D72DQLMyrAtJcWVPCFUFzZX5zwT4aaeqd3WYg+kck
	0fww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=fdkOa/8ODfXPT5UGtyvWTPKn8wEHA/UAIWdMwuoseyY=;
	b=B+WbuHT6+4lV0zyjijw8htvnUCQ20iCyNKlN58tRJ5LYJE7EFWBG3eBXANtr9SuORw
	JdBL5hBos7I45cjjvmJL7wfrvb8cvzpSc9gbdIkdb1Bi2Gk+hBRO6D6C+RCtIvlrt/Vj
	LEzQZFRpWqnWXkd57xgImlIgjHltGV4yFwcgqeJXPA0AC7LPYAOSvl1ysyA7R9sbpOOU
	pRr15NrPkFZneAvD5/rdYj4gw6iBNlXq3aKgP33gK3O7fBpUTXJ6Wbj6MHfev4Evxx7m
	9Koh0Xatl89l8uyLA3Wpl5dTJYfiE1nsYrJ+dMI6kxZnfSnlxmUrvLchy2HVj3x4WWqs
	YWRQ==
X-Gm-Message-State: ALyK8tKlZgWz9qRoh3N9qLe3MN9vhkeD/uxRlbSbwmlIfpyTyqr9We94m68jknlOFnmtH5IbUlFcr4auf5PxGw==
X-Received: by 10.107.175.83 with SMTP id y80mr21915938ioe.70.1467398200955;
	Fri, 01 Jul 2016 11:36:40 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.19.70 with HTTP; Fri, 1 Jul 2016 11:36:21 -0700 (PDT)
In-Reply-To: <cover.1462040903.git.chris_larson@mentor.com>
References: <cover.1462040903.git.chris_larson@mentor.com>
From: Christopher Larson <chris_larson@mentor.com>
Date: Fri, 1 Jul 2016 11:36:21 -0700
X-Google-Sender-Auth: InGFWCK7CVW227Lv17fEMfIRmEY
Message-ID: <CABcZAN=GDHWSX-piPYT0X2SqkizRVgAYU7YNvw81BD1zO_Pk8g@mail.gmail.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: Re: [master][PATCH 0/3] Implement support for shallow git mirror tarballs
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
X-List-Received-Date: Fri, 01 Jul 2016 18:36:42 -0000
Content-Type: multipart/alternative; boundary=001a11448a04831db60536974439

--001a11448a04831db60536974439
Content-Type: text/plain; charset=UTF-8

On Sat, Apr 30, 2016 at 12:44 PM, Christopher Larson <kergoth@gmail.com>
wrote:

> From: Christopher Larson <chris_larson@mentor.com>
>
> This adds support to the git fetcher for fetching and generating mirror
> tarballs of shallow git repositories, with the specified revisions /
> depths.
>
> This implements support for shallow mirror tarballs, not shallow clones.
> Supporting shallow clones directly would be rather more problematic, as
> we'd
> need to hardcode the depth between branch HEAD and the SRCREV, and that
> depth
> would change as the branch is updated. Sadly, git's remote protocol is
> extremely limited.
>
> When BB_GIT_SHALLOW is enabled, we will always attempt to fetch a shallow
> mirror tarball. If the shallow mirror tarball cannot be fetched, it will
> try
> to fetch the full mirror tarball and use that.
>
> Multiple variables exist to exert control over what revisions and refs are
> kept at what are not.
>
> BB_GIT_SHALLOW: enable/disable shallow support as a whole, boolean
> BB_GIT_SHALLOW_DEPTH: specify commit depth for the included refs. defaults
> to 1 (the top commit alone). This can be set to 0 or the empty string.
> BB_GIT_SHALLOW_DEPTH_<name>: specify commit depth for a specific named
> url/branch
> BB_GIT_SHALLOW_REVS: specific revisions whose history should be removed,
> beyond that specified by refs+depth
> BB_GIT_SHALLOW_TRIM_REFS: by default, unused refs/branches are removed.
> set this to 0 or the empty string to keep all refs around. this is required
> for linux-yocto kernel repositories, otherwise the branch checking done by
> the kernel scripts will fail
> BB_GIT_SHALLOW_EXTRA_REFS: additional refs to keep beyond those referenced
> in SRC_URI, when TRIM_REFS is enabled
> BB_GENERATE_SHALLOW_TARBALLS: explicitly control creation of shallow
> mirror tarballs. this defaults to enabled when BB_GENERATE_MIRROR_TARBALLS
> is enabled
>
> Example usage:
>
>     BB_GIT_SHALLOW ?= "1"
>     BB_GIT_SHALLOW_DEPTH ?= "1"
>
>     # Usage in a recipe with multiple named uris or multiple named branches
>     BB_GIT_SHALLOW_DEPTH_doc = ""
>
>     # Remove the upstream history from our kernel repo, keeping our own
>     BB_GIT_SHALLOW_REVS_pn-linux-mel_mx6 = "v3.14"
>     BB_GIT_SHALLOW_DEPTH_pn-linux-mel_mx6 = ""
>
>     # Keep the branches in linux-yocto repositories
>     BB_GIT_SHALLOW_TRIM_REFS_pn-linux-yocto = "0"
>
>
> Please review the following changes for suitability for inclusion. If you
> have
> any objections or suggestions for improvement, please respond to the
> patches. If
> you agree with the changes, please provide your Acked-by.
>
> The following changes since commit
> 309f5907a3661821e041ed14645b5d165007b058:
>
>   bitbake: Switch to post release version (2016-04-29 07:41:34 +0100)
>
> are available in the git repository at:
>
>   https://github.com/kergoth/bitbake shallow-simplify
>   https://github.com/kergoth/bitbake/tree/shallow-simplify
>

This branch has been updated after rebasing post-python3-switch, so should
be ready for potential merge again. A couple things worth noting that I
failed to mention in the original post:

The shallow mirror tarballs are never unpacked into DL_DIR -- I didn't want
to create another dir structure there when there wouldn't be much benefit,
and I definitely didn't want anything shallow inside of ${DL_DIR}/git2/ to
avoid confusion and state problems, so when a shallow tarball is in play,
the download() method will return early and do nothing beyond the fetch of
the shallow tarball, and then the unpack method will extract it directly.

It's also worth noting that a current clone is preferred to either tarball,
a shallow tarball is preferred to an out of date clone, and a missing clone
will use either tarball.

I'd also like to clarify the usage of BB_GIT_SHALLOW_REVS. In a normal use
of shallow, the history removed is that beyond a certain depth of a certain
branch, so you end up with N commits left over, and everything else
removed. If BB_GIT_SHALLOW_DEPTH isn't set and BB_GIT_SHALLOW_REVS is set,
instead of only keeping a certain depth of history, we're only *removing* a
particular subset of the history. The main use case is to get more control
over what history is available to a customer when shipping sources, so e.g.
you can strip out the bits available in public repositories and just keep
the bits they can't easily re-fetch.

Richard, think you'll be able to find time to take a look at this? As long
as BB_GIT_SHALLOW isn't set, there's almost no impact at all. The only
change that isn't conditional upon this is the change in logic in bb.fetch
to simplify the tarball handling, so the risk is actually quite low.
-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a11448a04831db60536974439
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Sat, Apr 30, 2016 at 12:44 PM, Christopher Larson <span dir=3D"ltr">=
&lt;<a href=3D"mailto:kergoth@gmail.com" target=3D"_blank">kergoth@gmail.co=
m</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-le=
ft-color:rgb(204,204,204);padding-left:1ex">From: Christopher Larson &lt;<a=
 href=3D"mailto:chris_larson@mentor.com">chris_larson@mentor.com</a>&gt;<br=
>
<br>
This adds support to the git fetcher for fetching and generating mirror<br>
tarballs of shallow git repositories, with the specified revisions / depths=
.<br>
<br>
This implements support for shallow mirror tarballs, not shallow clones.<br=
>
Supporting shallow clones directly would be rather more problematic, as we&=
#39;d<br>
need to hardcode the depth between branch HEAD and the SRCREV, and that dep=
th<br>
would change as the branch is updated. Sadly, git&#39;s remote protocol is<=
br>
extremely limited.<br>
<br>
When BB_GIT_SHALLOW is enabled, we will always attempt to fetch a shallow<b=
r>
mirror tarball. If the shallow mirror tarball cannot be fetched, it will tr=
y<br>
to fetch the full mirror tarball and use that.<br>
<br>
Multiple variables exist to exert control over what revisions and refs are<=
br>
kept at what are not.<br>
<br>
BB_GIT_SHALLOW: enable/disable shallow support as a whole, boolean<br>
BB_GIT_SHALLOW_DEPTH: specify commit depth for the included refs. defaults =
to 1 (the top commit alone). This can be set to 0 or the empty string.<br>
BB_GIT_SHALLOW_DEPTH_&lt;name&gt;: specify commit depth for a specific name=
d url/branch<br>
BB_GIT_SHALLOW_REVS: specific revisions whose history should be removed, be=
yond that specified by refs+depth<br>
BB_GIT_SHALLOW_TRIM_REFS: by default, unused refs/branches are removed. set=
 this to 0 or the empty string to keep all refs around. this is required fo=
r linux-yocto kernel repositories, otherwise the branch checking done by th=
e kernel scripts will fail<br>
BB_GIT_SHALLOW_EXTRA_REFS: additional refs to keep beyond those referenced =
in SRC_URI, when TRIM_REFS is enabled<br>
BB_GENERATE_SHALLOW_TARBALLS: explicitly control creation of shallow mirror=
 tarballs. this defaults to enabled when BB_GENERATE_MIRROR_TARBALLS is ena=
bled<br>
<br>
Example usage:<br>
<br>
=C2=A0 =C2=A0 BB_GIT_SHALLOW ?=3D &quot;1&quot;<br>
=C2=A0 =C2=A0 BB_GIT_SHALLOW_DEPTH ?=3D &quot;1&quot;<br>
<br>
=C2=A0 =C2=A0 # Usage in a recipe with multiple named uris or multiple name=
d branches<br>
=C2=A0 =C2=A0 BB_GIT_SHALLOW_DEPTH_doc =3D &quot;&quot;<br>
<br>
=C2=A0 =C2=A0 # Remove the upstream history from our kernel repo, keeping o=
ur own<br>
=C2=A0 =C2=A0 BB_GIT_SHALLOW_REVS_pn-linux-mel_mx6 =3D &quot;v3.14&quot;<br=
>
=C2=A0 =C2=A0 BB_GIT_SHALLOW_DEPTH_pn-linux-mel_mx6 =3D &quot;&quot;<br>
<br>
=C2=A0 =C2=A0 # Keep the branches in linux-yocto repositories<br>
=C2=A0 =C2=A0 BB_GIT_SHALLOW_TRIM_REFS_pn-linux-yocto =3D &quot;0&quot;<br>
<br>
<br>
Please review the following changes for suitability for inclusion. If you h=
ave<br>
any objections or suggestions for improvement, please respond to the patche=
s. If<br>
you agree with the changes, please provide your Acked-by.<br>
<br>
The following changes since commit 309f5907a3661821e041ed14645b5d165007b058=
:<br>
<br>
=C2=A0 bitbake: Switch to post release version (2016-04-29 07:41:34 +0100)<=
br>
<br>
are available in the git repository at:<br>
<br>
=C2=A0 <a href=3D"https://github.com/kergoth/bitbake" rel=3D"noreferrer" ta=
rget=3D"_blank">https://github.com/kergoth/bitbake</a> shallow-simplify<br>
=C2=A0 <a href=3D"https://github.com/kergoth/bitbake/tree/shallow-simplify"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/kergoth/bitbake/tr=
ee/shallow-simplify</a><span class=3D""><font color=3D"#888888"><br>
</font></span></blockquote></div><br><div>This branch has been updated afte=
r rebasing post-python3-switch, so should be ready for potential merge agai=
n. A couple things worth noting that I failed to mention in the original po=
st:</div><div><br></div><div>The shallow mirror tarballs are never unpacked=
 into DL_DIR -- I didn&#39;t want to create another dir structure there whe=
n there wouldn&#39;t be much benefit, and I definitely didn&#39;t want anyt=
hing shallow inside of ${DL_DIR}/git2/ to avoid confusion and state problem=
s, so when a shallow tarball is in play, the download() method will return =
early and do nothing beyond the fetch of the shallow tarball, and then the =
unpack method will extract it directly.</div><div><br></div><div>It&#39;s a=
lso worth noting that a current clone is preferred to either tarball, a sha=
llow tarball is preferred to an out of date clone, and a missing clone will=
 use either tarball.</div><div><br></div><div>I&#39;d also like to clarify =
the usage of BB_GIT_SHALLOW_REVS. In a normal use of shallow, the history r=
emoved is that beyond a certain depth of a certain branch, so you end up wi=
th N commits left over, and everything else removed. If BB_GIT_SHALLOW_DEPT=
H isn&#39;t set and BB_GIT_SHALLOW_REVS is set, instead of only keeping a c=
ertain depth of history, we&#39;re only *removing* a particular subset of t=
he history. The main use case is to get more control over what history is a=
vailable to a customer when shipping sources, so e.g. you can strip out the=
 bits available in public repositories and just keep the bits they can&#39;=
t easily re-fetch.</div><div><br></div><div>Richard, think you&#39;ll be ab=
le to find time to take a look at this? As long as BB_GIT_SHALLOW isn&#39;t=
 set, there&#39;s almost no impact at all. The only change that isn&#39;t c=
onditional upon this is the change in logic in bb.fetch to simplify the tar=
ball handling, so the risk is actually quite low.</div>-- <br><div class=3D=
"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr">Chris=
topher Larson<br>kergoth at gmail dot com<br>Founder - BitBake, OpenEmbedde=
d, OpenZaurus<br>Maintainer - Tslib<br>Senior Software Engineer, Mentor Gra=
phics</div></div>
</div></div>

--001a11448a04831db60536974439--
