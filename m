Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682A0C021B2
	for <webhook@archiver.kernel.org>; Thu, 20 Feb 2025 22:00:59 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web11.9424.1740088850818023939
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Feb 2025 14:00:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=eLE8tGuy;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-439350f1a0bso9221965e9.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 20 Feb 2025 14:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740088849; x=1740693649; darn=lists.openembedded.org;
        h=mime-version:user-agent:references:in-reply-to:date:to:from:subject
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z3lMYyEGSijrf+spPuQ4LDrleN1fNZJXGhYU0v4JY7s=;
        b=eLE8tGuyh1DgiPkZ+SSJ49kN62Jo2KyXya1N5vUrcfMfOvNQMt2jAXcAT6EFEM1HJH
         5CTgd+mEAGovm+9BZww7/n78x/OT/nQ1dSCUChJDb+D6oO84PfKwxyJ6pYy75lxswF6l
         reIk6PLF2iVBuzi/jsYPDKR8d3SaiEBLLo/S8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740088849; x=1740693649;
        h=mime-version:user-agent:references:in-reply-to:date:to:from:subject
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z3lMYyEGSijrf+spPuQ4LDrleN1fNZJXGhYU0v4JY7s=;
        b=TLzkjR4MW1/tKL4IBskTu3byjABGh9Py0Ph26DGp4xggTcO6Dp+0AT5R8pOaG+dkuo
         E7ONcMN9xHi1IziWQTqATE32p88oQmE+9fDb/pCoE/YiTlneBxo0zo4RDabJDzZo6Td6
         M4hzrlGcYkkRv5ujWTP4cXRbmX96OgWhdOwBodwUTJIKtBjWol8aLfk18IUzS9kZ+388
         B55MFMQ4rjgReOwyHUMCnxxViJYl++C3NSoL9OoNK9Xpu76zODCU1MigcZmPULcXBVUB
         fbQvku1dFJhzTrqCeYqHTU5Ir7onwvCJDwVEPY/02izUq9CZJOM6Gyeb+Q9DLL6m46ok
         6sog==
X-Forwarded-Encrypted: i=1; AJvYcCVfbDE1g2UMAB8EpKa93ry0KwwT3rbcuGSwD2BPSlZDXKalJ+MYHuQTHIY65KvKp8sEg8fO2hLaeGapYDYS@lists.openembedded.org
X-Gm-Message-State: AOJu0Yx6P8CYYxMdbuMv186kBr1DtRQ4zmpTW4WRDc3Ymp/wnDHjOJG5
	YLpuWnfgPc8pkng7oVu2DdC00uqoTdMT3QPJ5mBrmYO847vB6syqbEc+Vf2EK2s=
X-Gm-Gg: ASbGncsq3sEtTUBBYYVBmBq/FdkknIe01sOAj9Inbbl4Sl8mTzJx9cUX5eBdcajhoNU
	rNfoXkrX4qcKldCzH1/V7zhifol4tDT9Ukckmss0Gq5wee8nBbcGcP90itt270qh5MeE4zZ0U5H
	NimjJt79Si9YowQtdMud+VV1/Wfp4oW23hFHK5aYz+4X8Cu3NoHoMz0/SoJr4EJ33UC8qosYt9o
	6AV+J6q6AqLz5LS+TnDYbNyH9qk1I7Ub5Zb9mQlbhW1LWt5g+xOuHKUla+XtMzOA4FoEYdN81vO
	mn0oHIqnDY8SBr66MsUUQj4Ltl3hc9rdjL2Q1/wESyN3D/jGs5cQ1N89/vMDO+84zN0iZMd0u5L
	Yo60u
X-Google-Smtp-Source: AGHT+IE2g0Z4XAtqx+2tDaiYYtaPoK3Mvx+7xtnP34vGcWOzn3oEtZWjCTc4MTx76yLegYNfM6Ruhg==
X-Received: by 2002:a05:600c:6d87:b0:439:8a64:db3c with SMTP id 5b1f17b1804b1-439a2eb0ce6mr42364365e9.1.1740088848871;
        Thu, 20 Feb 2025 14:00:48 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:419f:979f:5cd3:2260? ([2001:8b0:aba:5f3c:419f:979f:5cd3:2260])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439a3cc9551sm33231165e9.39.2025.02.20.14.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 14:00:46 -0800 (PST)
Message-ID: <f33e9499466eebc5d421ec2556af47cb5ddfd277.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [RFC PATCH 00/15] Make mirror replacement
 syntax explicit
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>, 
	bitbake-devel@lists.openembedded.org
Date: Thu, 20 Feb 2025 22:00:46 +0000
In-Reply-To: <07c3ebb6-8cdf-416a-bc89-ab930d85e78d@weidmueller.com>
References: 
	<20250205071538.2681-1-stefan.herbrechtsmeier-oss@weidmueller.com>
	 <f4533bb6d41d4011219cae737907015018a08ca9.camel@linuxfoundation.org>
	 <027ed1ac-02ae-420b-a65f-d4e48bc86136@weidmueller.com>
	 <d971d67321a2d43666885004f7ff9a479f4d1855.camel@linuxfoundation.org>
	 <6d445c40-5f24-47d1-a71a-1060e9b9da16@weidmueller.com>
	 <9ecb0289143f35037902a569de8a7f048262f779.camel@linuxfoundation.org>
	 <07c3ebb6-8cdf-416a-bc89-ab930d85e78d@weidmueller.com>
Content-Type: multipart/alternative; boundary="=-u53sVpLDmmfP6qKuVWcy"
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Feb 2025 22:00:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17268

--=-u53sVpLDmmfP6qKuVWcy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-02-20 at 18:37 +0100, Stefan Herbrechtsmeier wrote:
> =20
> Am 20.02.2025 um 13:21 schrieb Richard Purdie:
> > On Thu, 2025-02-20 at 12:45 +0100, Stefan Herbrechtsmeier via
> > lists.openembedded.org wrote:
> > > Am 20.02.2025 um 11:22 schrieb Richard Purdie via
> > > lists.openembedded.org:
> > > > On Wed, 2025-02-05 at 13:12 +0100, Stefan Herbrechtsmeier wrote:
> > > > > =C2=A0Am 05.02.2025 um 11:34 schrieb Richard Purdie:
> > > > > =20
> > > > > =C2=A0On Wed, 2025-02-05 at 08:15 +0100, Stefan Herbrechtsmeier v=
ia lists.openembedded.org wrote:
> > > > > =20
> > > > > I=E2=80=99m open for suggestions. Even ARCHIVE or TARBALL are har=
d to
> > > > > =20
> > > > > understand because it is only a relative path on the download mir=
ror.
> > > > > =20
> > > > > Alternative we can mark the lines as upstream or download mirror =
and
> > > > > =20
> > > > > give the replacement different meanings. The path could be the
> > > > > =20
> > > > > original PATH for an upstream mirror or the relative path of the
> > > > > =20
> > > > > downloaded file for the download mirror.
> > > > > =20
> > > > > =20
> > > > > =20
> > > > =20
> > > > =20
> > > > =20
> > > > I've been giving this topic some thought. One idea I wondered about=
 was
> > > > =20
> > > > to instead markup the mirror urls with how they're expected to work
> > > > =20
> > > > with a new parameter. For example:
> > > >  =20
> > > > git://.*/.*  http://downloads.yoctoproject.org/mirror/sources/?mirr=
orformat=3Dmirrortarball
> > > > =20
> > > > =20
> > > > =20
> > > =20
> > > The ? could be problematic because it is the separator for the
> > > query. It is unlikely that the user really use this query
> > > parameter but it could complicate the code because we have to
> > > handle additional query parameters.
> > > What does the "?mirrorformat=3Dmirrortarball" mean? Will it work
> > > like a MIRRORTARBALL replacement?
> > > =20
> > =20
> >=20
> > =20
> > =20
> > The mirrorformat parameter would be used by the mirroring code
> > itself to understand how to handle the url.
> > =20
> =20
> What is the different to a MIRRORTARBALL replacement? The code will
> replace the word with the content.
Think about this from a usability perspective. We're struggling to even
work out good names for your proposal. Even if we work out the names, I
still don't think users are going to understand how to convert urls
into the new syntax.

The difference with my proposed format is that we're specifying it in a
way which I suspect users will better understand without needing to go
and read the docs every time. We're saying what we're configuring with
the "mirrorformat" key and then the value should be able to describe
the format.=C2=A0

My proposal also gives us both a way to clearly detect when obsolete
formatting is used and a namespace mechanism to extend, with both being
in a way we can easily and clearly describe in the docs.

I appreciate with your proposal we can add more strings and we can add
docs about how to migrate but I suspect users aren't going to be as
readily/easily able to understand it.


> > It would be dropped from the modified url so is only therefore our
> > code's use. If there are additional parameters they would be passed
> > through as they are now.
> > =20
> >=20
> > =20
> > =20
> > > =20
> > > How does a simple replacement should look like?
> > >=20
> > > http://=C2=A0 https://
> > >=20
> > > Because of the backward compatible this will replace the basename
> > > of the path.
> > > =20
> > =20
> >=20
> > =20
> > =20
> > It would depend how the mirror is laid out. Some mirrors flatten
> > the urls like DL_DIR is laid out, some potentially don't. The
> > standard usage would likely have a mirrorformat=3Ddldir parameter
> > added.
> > =20
> =20
> How does the user specify an entry that replace the http scheme with
> https and keeps everything else like it is (upstream mirror)?

http://.*/.* https://.*/.*?mirrorformat=3Dupstream

We need to determine the best value for "upstream". I'd also like to
review whether the .* formatting is the best way to handle this if we
are going to change the format.

> > > > The possible options would be something like:
> > > >  =20
> > > > mirrortarball - mirror tarballs taken from DL_DIR
> > > > =20
> > > > flattened - copy of DL_DIR so DL_DIR layout (maybe call it dldir?)
> > > > =20
> > > > upstream - layout is the same as the upstream directory structure s=
o a direct url replacement
> > > > =20
> > > > =20
> > > > =20
> > > =20
> > > Do you think we have to handle the mirror tarball explicit? The
> > > mirror tarball is required for a scheme change.
> > > =20
> > =20
> >=20
> > =20
> > =20
> > If we do that, we can avoid having to guess at too many urls to
> > test to figure out a mirror format so I think it would be an
> > improvement on where we are today.
> > =20
> =20
> Do you mean we will test if the URL have a mirrortarball and if not
> skip the entry?
Correct.

> > > > If using a mirrortarball mirror url, we'd know to use the values fr=
om
> > > > =20
> > > > urldata.mirrortarballs. We could add parameters to the fetcher to h=
ave
> > > > =20
> > > > two parameters, one will be the DL_DIR path and the other would be =
the
> > > > =20
> > > > upstream url path.
> > > > =20
> > > > =20
> > > > =20
> > > =20
> > > I don't understand where this is needed, because the mirror
> > > tarball and downloadfilename are used by different fetchers.
> > > =20
> > =20
> >=20
> > =20
> > =20
> > Please keep in mind that downloadfilename is pretty much a
> > misfeature. It was added as we couldn't control collisions inside
> > dl_dir but it creates all kind of other problems. I think we do
> > need to handle that problem case but it does then mean we have to
> > indicate whether any given mirror uses "dldir" or "upstream" names
> > and paths.
> > =20
> =20
> I don't understand the problem. The download mirror will use the
> downloadfilename or its default the basename of the localpath. The
> upstream mirror will use the path. The mirrortarball will use the
> mirrortarball. Why the fetcher need two parameters?
You are trying to make downloadfilename a supported parameter of every
fetcher. I'm arguing that I wish we'd never added it at all and that
I'd rather not use it or encourage its use. I don't think you
understand the way the fetcher API was written/used and this is why
some of the patches are still on hold in master-next until I can
convince myself they are actually the right thing to do. There have
been too many other misunderstandings to give me confidence they're
going to do the right thing :(. Sadly, I just don't have the time do
the right level of review and everything else being asked of me.

> > > > One key question I have is how we might need to
> > > > =20
> > > > shorted the url path for some mirror urls to add/remove a path pref=
ix
> > > > =20
> > > > in the mirroring.
> > > > =20
> > > > =20
> > > > =20
> > > =20
> > > What do you mean by this? The downloadfilename could contain a
> > > path without any problem after my change.
> > > =20
> > =20
> >=20
> > =20
> > =20
> > See above, downloadfilename is not something I'm keen to promote
> > and is creating several of the problems we have by badly trying to
> > hack extra functionality onto the fetcher without thinking through
> > all the issues like mirroring.
> > =20
> =20
> What is the desired way to avoid name clashes? The package manager
> fetcher need an generic way to override the basename.
Why does it need that? Usually we've used the directory layout to avoid
problems where we can for example. I've been hoping we could do similar
here rather than use downloadfilename, which causes so many mirroring
issues in the first place.


> > > Alternative we could make some replacement mandatory if a
> > > wildcard is used to detect obsolete entries.
> > > =20
> > =20
> >=20
> > =20
> > =20
> > I don't understand that.
> > =20
> =20
> If we have a wildcard .* in the path we need to know how to replace
> it. This could be the PATH, BASENAME, DOWNLOADFILENAME, MIRRORARCHIVE
> or re group. But in case of the re group this could still be an old
> entry.
I'm not entirely sure we want to keep all the different syntax. One
frustration I have with the current code is the way pattern matches are
restricted to that url component for example and I've wondered if we
could/should do something different instead, if we can make it simpler.

> Do support all cases we need a fix prefix or delimiter:
>=20
> r:http https
> =20
> http#https
> http|https
>=20
> http?://.*/.*|
> http://downloads.yoctoproject.org/mirror/sources/DOWNLOADARCHIVE
> git://.*/.*|
> http://downloads.yoctoproject.org/mirror/sources/MIRRORARCHIVE
>=20
> =20
> > =20
> > I do think we have too many problems in the existing mirroring url
> > mapping and we probably need to rework this rather than try and
> > pile more patches into it and complicate it further.
> > =20
> I have already rework it. If I can remove the backward compatibility
> and replace it with an error this would simplify the code. I only
> need a better name for the DOWNLOADFILENAME (DOWNLOADARCHIVE) and add
> the MIRRORARCHIV.

>=20
> > =20
> > The question is whether the proposal fixes the issues it needs to
> > and has enough simplification and benefit to justify making the
> > change.
> > =20
> My patches support folders in the downloadfilename, upstream mirrors
> and renames. I have to rework the MIRROR strings but therefore the
> commented out tests work.
>=20


You've created a patch, yes. I don't think it improves usability though
and I think you're also pushing concepts like downloadfilename into
places we might not want to use them too. For me to merge patches like
these, there needs to be a sense of trust and shared understanding.
This simply isn't there, you're just saying your patches are fine as
they are, I disagree. I therefore worry we're at an impasse and are
going to struggle to move beyond this. That does make me quite sad.

Regards,

Richard




--=-u53sVpLDmmfP6qKuVWcy
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head>

  <style>pre,code,address {
  margin: 0px;
}
h1,h2,h3,h4,h5,h6 {
  margin-top: 0.2em;
  margin-bottom: 0.2em;
}
ol,ul {
  margin-top: 0em;
  margin-bottom: 0em;
}
blockquote {
  margin-top: 0em;
  margin-bottom: 0em;
}
</style></head>
  <body><div>On Thu, 2025-02-20 at 18:37 +0100, Stefan Herbrechtsmeier wrot=
e:</div><blockquote type=3D"cite" style=3D"margin:0 0 0 .8ex; border-left:2=
px #729fcf solid;padding-left:1ex"><div> </div><div class=3D"moz-cite-prefi=
x">Am 20.02.2025 um 13:21 schrieb Richard Purdie:<br> </div><blockquote typ=
e=3D"cite" cite=3D"mid:9ecb0289143f35037902a569de8a7f048262f779.camel@linux=
foundation.org" style=3D"margin:0 0 0 .8ex; border-left:2px #729fcf solid;p=
adding-left:1ex"><div>On Thu, 2025-02-20 at 12:45 +0100, Stefan Herbrechtsm=
eier via lists.openembedded.org wrote:</div><blockquote type=3D"cite" style=
=3D"margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex"><div=
 class=3D"moz-cite-prefix">Am 20.02.2025 um 11:22 schrieb Richard Purdie vi=
a lists.openembedded.org:<br> </div><blockquote type=3D"cite" cite=3D"mid:d=
971d67321a2d43666885004f7ff9a479f4d1855.camel@linuxfoundation.org" style=3D=
"margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex"><pre>On=
 Wed, 2025-02-05 at 13:12 +0100, Stefan Herbrechtsmeier wrote:</pre><blockq=
uote type=3D"cite" style=3D"margin:0 0 0 .8ex; border-left:2px #729fcf soli=
d;padding-left:1ex"><pre>&nbsp;Am 05.02.2025 um 11:34 schrieb Richard Purdi=
e:</pre><div> </div><pre>&nbsp;On Wed, 2025-02-05 at 08:15 +0100, Stefan He=
rbrechtsmeier via lists.openembedded.org wrote:</pre><div> </div><div>I=E2=
=80=99m open for suggestions. Even ARCHIVE or TARBALL are hard to</div><div=
> </div><pre>understand because it is only a relative path on the download =
mirror.</pre><div> </div><pre>Alternative we can mark the lines as upstream=
 or download mirror and</pre><div> </div><pre>give the replacement differen=
t meanings. The path could be the</pre><div> </div><pre>original PATH for a=
n upstream mirror or the relative path of the</pre><div> </div><pre>downloa=
ded file for the download mirror.</pre><div> </div><div> </div><div> </div>=
</blockquote><div> </div><div> </div><div> </div><pre>I've been giving this=
 topic some thought. One idea I wondered about was</pre><div> </div><pre>to=
 instead markup the mirror urls with how they're expected to work</pre><div=
> </div><pre>with a new parameter. For example:</pre><div>  </div><pre>git:=
//.*/.*  <a class=3D"moz-txt-link-freetext" href=3D"http://downloads.yoctop=
roject.org/mirror/sources/?mirrorformat=3Dmirrortarball" moz-do-not-send=3D=
"true">http://downloads.yoctoproject.org/mirror/sources/?mirrorformat=3Dmir=
rortarball</a></pre><div> </div><div> </div><div> </div></blockquote><div> =
</div><div> The ? could be problematic because it is the separator for the =
query. It is unlikely that the user really use this query parameter but it =
could complicate the code because we have to handle additional query parame=
ters.<br> What does the "?mirrorformat=3Dmirrortarball" mean? Will it work =
like a MIRRORTARBALL replacement?</div><div> </div></blockquote><div> </div=
><div><br> </div><div> </div><div>The mirrorformat parameter would be used =
by the mirroring code itself to understand how to handle the url.<br> </div=
><div> </div></blockquote><div> </div><p>What is the different to a MIRRORT=
ARBALL replacement? The code will replace the word with the content.</p></b=
lockquote><div>Think about this from a usability perspective. We're struggl=
ing to even work out good names for your proposal. Even if we work out the =
names, I still don't think users are going to understand how to convert url=
s into the new syntax.</div><div><br></div><div>The difference with my prop=
osed format is that we're specifying it in a way which I suspect users will=
 better understand without needing to go and read the docs every time. We'r=
e saying what we're configuring with the "mirrorformat" key and then the va=
lue should be able to describe the format.&nbsp;</div><div><br></div><div>M=
y proposal also gives us both a way to clearly detect when obsolete formatt=
ing is used and a namespace mechanism to extend, with both being in a way w=
e can easily and clearly describe in the docs.</div><div><br></div><div>I a=
ppreciate with your proposal we can add more strings and we can add docs ab=
out how to migrate but I suspect users aren't going to be as readily/easily=
 able to understand it.</div><div><br></div><div><br></div><blockquote type=
=3D"cite" style=3D"margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding=
-left:1ex"><blockquote type=3D"cite" cite=3D"mid:9ecb0289143f35037902a569de=
8a7f048262f779.camel@linuxfoundation.org" style=3D"margin:0 0 0 .8ex; borde=
r-left:2px #729fcf solid;padding-left:1ex"><div>It would be dropped from th=
e modified url so is only therefore our code's use. If there are additional=
 parameters they would be passed through as they are now.</div><div> </div>=
<div><br> </div><div> <br></div><blockquote type=3D"cite" style=3D"margin:0=
 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex"><div> </div><div=
>How does a simple replacement should look like?<br> <br> http://&nbsp; htt=
ps://<br> <br> Because of the backward compatible this will replace the bas=
ename of the path.</div><div> </div></blockquote><div> </div><div><br> </di=
v><div> </div><div>It would depend how the mirror is laid out. Some mirrors=
 flatten the urls like DL_DIR is laid out, some potentially don't. The stan=
dard usage would likely have a mirrorformat=3Ddldir parameter added.<br> </=
div><div> </div></blockquote><div> </div><p>How does the user specify an en=
try that replace the http scheme with https and keeps everything else like =
it is (upstream mirror)?</p></blockquote><div><br></div><div>http://.*/.* h=
ttps://.*/.*?mirrorformat=3Dupstream</div><div><br></div><div>We need to de=
termine the best value for "upstream". I'd also like to review whether the =
.* formatting is the best way to handle this if we are going to change the =
format.</div><div><br></div><blockquote type=3D"cite" style=3D"margin:0 0 0=
 .8ex; border-left:2px #729fcf solid;padding-left:1ex"><blockquote type=3D"=
cite" cite=3D"mid:9ecb0289143f35037902a569de8a7f048262f779.camel@linuxfound=
ation.org" style=3D"margin:0 0 0 .8ex; border-left:2px #729fcf solid;paddin=
g-left:1ex"><blockquote type=3D"cite" style=3D"margin:0 0 0 .8ex; border-le=
ft:2px #729fcf solid;padding-left:1ex"><blockquote type=3D"cite" cite=3D"mi=
d:d971d67321a2d43666885004f7ff9a479f4d1855.camel@linuxfoundation.org" style=
=3D"margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex"><pre=
>The possible options would be something like:</pre><div>  </div><pre>mirro=
rtarball - mirror tarballs taken from DL_DIR</pre><div> </div><pre>flattene=
d - copy of DL_DIR so DL_DIR layout (maybe call it dldir?)</pre><div> </div=
><pre>upstream - layout is the same as the upstream directory structure so =
a direct url replacement</pre><div> </div><div> </div><div> </div></blockqu=
ote><div> </div><div> Do you think we have to handle the mirror tarball exp=
licit? The mirror tarball is required for a scheme change.</div><div> </div=
></blockquote><div> </div><div><br> </div><div> </div><div>If we do that, w=
e can avoid having to guess at too many urls to test to figure out a mirror=
 format so I think it would be an improvement on where we are today.<br> </=
div><div> </div></blockquote><div> </div><p>Do you mean we will test if the=
 URL have a mirrortarball and if not skip the entry?</p></blockquote><div>C=
orrect.</div><div><br></div><blockquote type=3D"cite" style=3D"margin:0 0 0=
 .8ex; border-left:2px #729fcf solid;padding-left:1ex"><blockquote type=3D"=
cite" cite=3D"mid:9ecb0289143f35037902a569de8a7f048262f779.camel@linuxfound=
ation.org" style=3D"margin:0 0 0 .8ex; border-left:2px #729fcf solid;paddin=
g-left:1ex"><blockquote type=3D"cite" style=3D"margin:0 0 0 .8ex; border-le=
ft:2px #729fcf solid;padding-left:1ex"><blockquote type=3D"cite" cite=3D"mi=
d:d971d67321a2d43666885004f7ff9a479f4d1855.camel@linuxfoundation.org" style=
=3D"margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex"><pre=
>If using a mirrortarball mirror url, we'd know to use the values from</pre=
><div> </div><pre>urldata.mirrortarballs. We could add parameters to the fe=
tcher to have</pre><div> </div><pre>two parameters, one will be the DL_DIR =
path and the other would be the</pre><div> </div><pre>upstream url path.</p=
re><div> </div><div> </div><div> </div></blockquote><div> </div><div> I don=
't understand where this is needed, because the mirror tarball and download=
filename are used by different fetchers.</div><div> </div></blockquote><div=
> </div><div><br> </div><div> </div><div>Please keep in mind that downloadf=
ilename is pretty much a misfeature. It was added as we couldn't control co=
llisions inside dl_dir but it creates all kind of other problems. I think w=
e do need to handle that problem case but it does then mean we have to indi=
cate whether any given mirror uses "dldir" or "upstream" names and paths.<b=
r> </div><div> </div></blockquote><div> </div><p>I don't understand the pro=
blem. The download mirror will use the downloadfilename or its default the =
basename of the localpath. The upstream mirror will use the path. The mirro=
rtarball will use the mirrortarball. Why the fetcher need two parameters?</=
p></blockquote><div>You are trying to make downloadfilename a supported par=
ameter of every fetcher. I'm arguing that I wish we'd never added it at all=
 and that I'd rather not use it or encourage its use. I don't think you und=
erstand the way the fetcher API was written/used and this is why some of th=
e patches are still on hold in master-next until I can convince myself they=
 are actually the right thing to do. There have been too many other misunde=
rstandings to give me confidence they're going to do the right thing :(. Sa=
dly, I just don't have the time do the right level of review and everything=
 else being asked of me.</div><div><br></div><blockquote type=3D"cite" styl=
e=3D"margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex"><bl=
ockquote type=3D"cite" cite=3D"mid:9ecb0289143f35037902a569de8a7f048262f779=
.camel@linuxfoundation.org" style=3D"margin:0 0 0 .8ex; border-left:2px #72=
9fcf solid;padding-left:1ex"><blockquote type=3D"cite" style=3D"margin:0 0 =
0 .8ex; border-left:2px #729fcf solid;padding-left:1ex"><blockquote type=3D=
"cite" cite=3D"mid:d971d67321a2d43666885004f7ff9a479f4d1855.camel@linuxfoun=
dation.org" style=3D"margin:0 0 0 .8ex; border-left:2px #729fcf solid;paddi=
ng-left:1ex"><pre>One key question I have is how we might need to</pre><div=
> </div><pre>shorted the url path for some mirror urls to add/remove a path=
 prefix</pre><div> </div><pre>in the mirroring.</pre><div> </div><div> </di=
v><div> </div></blockquote><div> </div><div> What do you mean by this? The =
downloadfilename could contain a path without any problem after my change.<=
/div><div> </div></blockquote><div> </div><div><br> </div><div> </div><div>=
See above, downloadfilename is not something I'm keen to promote and is cre=
ating several of the problems we have by badly trying to hack extra functio=
nality onto the fetcher without thinking through all the issues like mirror=
ing.<br> </div><div> </div></blockquote><div> </div><p>What is the desired =
way to avoid name clashes? The package manager fetcher need an generic way =
to override the basename.</p></blockquote><div>Why does it need that? Usual=
ly we've used the directory layout to avoid problems where we can for examp=
le. I've been hoping we could do similar here rather than use downloadfilen=
ame, which causes so many mirroring issues in the first place.</div><div><b=
r></div><div><br></div><blockquote type=3D"cite" style=3D"margin:0 0 0 .8ex=
; border-left:2px #729fcf solid;padding-left:1ex"><blockquote type=3D"cite"=
 cite=3D"mid:9ecb0289143f35037902a569de8a7f048262f779.camel@linuxfoundation=
.org" style=3D"margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-lef=
t:1ex"><blockquote type=3D"cite" style=3D"margin:0 0 0 .8ex; border-left:2p=
x #729fcf solid;padding-left:1ex"><div>Alternative we could make some repla=
cement mandatory if a wildcard is used to detect obsolete entries.</div><di=
v> </div></blockquote><div> </div><div><br> </div><div> </div><div>I don't =
understand that.<br> </div><div> </div></blockquote><div> </div><p>If we ha=
ve a wildcard .* in the path we need to know how to replace it. This could =
be the PATH, BASENAME, DOWNLOADFILENAME, MIRRORARCHIVE or re group. But in =
case of the re group this could still be an old entry.</p></blockquote><div=
>I'm not entirely sure we want to keep all the different syntax. One frustr=
ation I have with the current code is the way pattern matches are restricte=
d to that url component for example and I've wondered if we could/should do=
 something different instead, if we can make it simpler.</div><div><br></di=
v><blockquote type=3D"cite" style=3D"margin:0 0 0 .8ex; border-left:2px #72=
9fcf solid;padding-left:1ex"><p>Do support all cases we need a fix prefix o=
r delimiter:<br> <br> r:http https</p><div> </div><p>http#https<br> http|ht=
tps<br> <br>http?://.*/.*|<a class=3D"moz-txt-link-freetext" href=3D"http:/=
/downloads.yoctoproject.org/mirror/sources/DOWNLOADARCHIVE">http://download=
s.yoctoproject.org/mirror/sources/DOWNLOADARCHIVE</a><br>git://.*/.*|<a cla=
ss=3D"moz-txt-link-freetext" href=3D"http://downloads.yoctoproject.org/mirr=
or/sources/MIRRORARCHIVE">http://downloads.yoctoproject.org/mirror/sources/=
MIRRORARCHIVE</a><br> <br> </p><div> <br></div><blockquote type=3D"cite" ci=
te=3D"mid:9ecb0289143f35037902a569de8a7f048262f779.camel@linuxfoundation.or=
g" style=3D"margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1=
ex"><div> </div><div>I do think we have too many problems in the existing m=
irroring url mapping and we probably need to rework this rather than try an=
d pile more patches into it and complicate it further.<br> </div><div> </di=
v></blockquote><div> I have already rework it. If I can remove the backward=
 compatibility and replace it with an error this would simplify the code. I=
 only need a better name for the DOWNLOADFILENAME (DOWNLOADARCHIVE) and add=
 the MIRRORARCHIV.</div></blockquote><div><br></div><blockquote type=3D"cit=
e" style=3D"margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1=
ex"><div><br></div><blockquote type=3D"cite" cite=3D"mid:9ecb0289143f350379=
02a569de8a7f048262f779.camel@linuxfoundation.org" style=3D"margin:0 0 0 .8e=
x; border-left:2px #729fcf solid;padding-left:1ex"><div> </div><div>The que=
stion is whether the proposal fixes the issues it needs to and has enough s=
implification and benefit to justify making the change.<br> </div><div> </d=
iv></blockquote><div> My patches support folders in the downloadfilename, u=
pstream mirrors and renames. I have to rework the MIRROR strings but theref=
ore the commented out tests work.<br> <br> </div></blockquote><div><br></di=
v><div><br></div><div><div>You've created a patch, yes. I don't think it im=
proves usability though and I think you're also pushing concepts like downl=
oadfilename into places we might not want to use them too. For me to merge =
patches like these, there needs to be a sense of trust and shared understan=
ding. This simply isn't there, you're just saying your patches are fine as =
they are, I disagree. I therefore worry we're at an impasse and are going t=
o struggle to move beyond this. That does make me quite sad.</div><div><br>=
</div><div>Regards,</div><div><br></div><div>Richard</div><div><br></div></=
div><div><br></div><div><br></div><div><span></span></div><style>pre,code,a=
ddress { margin: 0px; }h1,h2,h3,h4,h5,h6 { margin-top: 0.2em; margin-bottom=
: 0.2em; }ol,ul { margin-top: 0em; margin-bottom: 0em; }blockquote { margin=
-top: 0em; margin-bottom: 0em; }</style></body></html>

--=-u53sVpLDmmfP6qKuVWcy--

