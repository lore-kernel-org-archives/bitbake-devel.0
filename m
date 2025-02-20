Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45266C021B2
	for <webhook@archiver.kernel.org>; Thu, 20 Feb 2025 12:21:52 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web10.47845.1740054110531377644
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Feb 2025 04:21:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=OlvB+OFs;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38f2b7ce2e5so475613f8f.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 20 Feb 2025 04:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740054108; x=1740658908; darn=lists.openembedded.org;
        h=mime-version:user-agent:references:in-reply-to:date:to:from:subject
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=o7+THAysiL3eSldwiT1nfB1keCEMb6F4Hh6o+0QWtVw=;
        b=OlvB+OFs6Z5VRe5fgosRuVP1aWZRHtGcGQgs+CpdEHinYyNS+EOlItSx9zkEHpKx0Y
         uA7Cq47j6CW9DRU/swZ+9KKMn+MOtc7pc1jrbcgPTnJen+4bDaCMR5t825wsjoPRUzMx
         c5cW375tsdc8iiwCX55HLAizKuAkO3//Wu6/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740054108; x=1740658908;
        h=mime-version:user-agent:references:in-reply-to:date:to:from:subject
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o7+THAysiL3eSldwiT1nfB1keCEMb6F4Hh6o+0QWtVw=;
        b=ZSXTp4FG4CefcWF8New5I9opn6hXu5Yp5NvQUin+FzEDxkXdPatdzTvbnrKt5reFDQ
         Oqf8MHsS56w0xRlpfB2fiD1jdZ0ujgwLC9HDsDECa3GwHP8FAQ7F39kENOeUHKYQAzFa
         figanZXCddPgUvkHS1iRTVZDATTjlZKeWSDnKeJviwfBb2j3yBl9I6w+kDhfxDl34pxO
         aQ8UpWG/5+7Ef+s604qV34JRUqckpuQ/InfjQSbSirCZM0iR5QMR/cF/pk3gpvja91I5
         QFU0Lc0Uigr2suwididAAA0ZGHt6oqNwPs7w15HnhcDR4kZmyzWeuwMXusXv9/97PrnN
         ZODg==
X-Forwarded-Encrypted: i=1; AJvYcCWEUkkAbyHFNlvbbglo2W4GRdLtFhTYJhnNL9EfWrduQ7qEA2mGZAGwyzfwEJFF8W/jPX/CxxeNPiN2TURa@lists.openembedded.org
X-Gm-Message-State: AOJu0Yw9o9g8Hg39C7ft9fDL4YKYuJBmyX39TLS7sMPs/71mSVI5QL0F
	s0+RvdcUUC/euzp+yTvyslBEKm/DovP1uavVt6jwlE9zhkMo+4mIhyu7gMwkUHc=
X-Gm-Gg: ASbGncsmih3817Fb7fAggAj0lWpgWq9cHwjK74n57APj1yNHPXYkDMuK6IidoeEX0FK
	k78GLK6YZtwVvrCf+nBuLEluYysarEn7Y3gI5xoeHBdht3nW0gW2WWGh6WVsXSAp7yb3/Mrv28T
	GlouK9RkFbh3gBDpcWjOo1QHFm7zIVHQsZMmPc5oqXPgAQasD0yU+Avby8x19Emam5+hcRPw0WB
	t4Oo41J/UYbNBEy1nykzFMqzLVQ0rNADoZHLXZBHMKZxUBZdvnSbVXdKtiwFwqFmB2ftgos20qU
	AwogQYrrQG0imD+J6mBWD+k6y8chxNvs07acFHWT3Hvq/iZ6pvUxlia/nOd5usnEMe4ohL3KMbg
	VR1PQ
X-Google-Smtp-Source: AGHT+IF+1Pq6anWPrxHDqqr21RnzSCiA9tL7PDGRlb7iwmTBJ/nsbhgCd5tFmCUmnZttGu8jKNgDGA==
X-Received: by 2002:a5d:5cc4:0:b0:38d:daf3:be60 with SMTP id ffacd0b85a97d-38f34171493mr19102608f8f.48.1740054108331;
        Thu, 20 Feb 2025 04:21:48 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:9d6e:bfd3:acd1:cbdb? ([2001:8b0:aba:5f3c:9d6e:bfd3:acd1:cbdb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5655sm20482530f8f.77.2025.02.20.04.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 04:21:47 -0800 (PST)
Message-ID: <9ecb0289143f35037902a569de8a7f048262f779.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [RFC PATCH 00/15] Make mirror replacement
 syntax explicit
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: stefan.herbrechtsmeier-oss@weidmueller.com, 
	bitbake-devel@lists.openembedded.org
Date: Thu, 20 Feb 2025 12:21:46 +0000
In-Reply-To: <6d445c40-5f24-47d1-a71a-1060e9b9da16@weidmueller.com>
References: 
	<20250205071538.2681-1-stefan.herbrechtsmeier-oss@weidmueller.com>
	 <f4533bb6d41d4011219cae737907015018a08ca9.camel@linuxfoundation.org>
	 <027ed1ac-02ae-420b-a65f-d4e48bc86136@weidmueller.com>
	 <d971d67321a2d43666885004f7ff9a479f4d1855.camel@linuxfoundation.org>
	 <6d445c40-5f24-47d1-a71a-1060e9b9da16@weidmueller.com>
Content-Type: multipart/alternative; boundary="=-Hkym/imNWDlCJqCPmWqw"
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Feb 2025 12:21:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17254

--=-Hkym/imNWDlCJqCPmWqw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-02-20 at 12:45 +0100, Stefan Herbrechtsmeier via
lists.openembedded.org wrote:
> =20
> Am 20.02.2025 um 11:22 schrieb Richard Purdie via
> lists.openembedded.org:
> > On Wed, 2025-02-05 at 13:12 +0100, Stefan Herbrechtsmeier wrote:
> > > =C2=A0Am 05.02.2025 um 11:34 schrieb Richard Purdie:
> > > =C2=A0On Wed, 2025-02-05 at 08:15 +0100, Stefan Herbrechtsmeier via l=
ists.openembedded.org wrote:
> > > I=E2=80=99m open for suggestions. Even ARCHIVE or TARBALL are hard to
> > > understand because it is only a relative path on the download mirror.
> > > Alternative we can mark the lines as upstream or download mirror and
> > > give the replacement different meanings. The path could be the
> > > original PATH for an upstream mirror or the relative path of the
> > > downloaded file for the download mirror.
> > > =20
> > =20
> > I've been giving this topic some thought. One idea I wondered about was
> > to instead markup the mirror urls with how they're expected to work
> > with a new parameter. For example:
> >=20
> > git://.*/.*  http://downloads.yoctoproject.org/mirror/sources/?mirrorfo=
rmat=3Dmirrortarball
> > =20
> The ? could be problematic because it is the separator for the query.
> It is unlikely that the user really use this query parameter but it
> could complicate the code because we have to handle additional query
> parameters.
> What does the "?mirrorformat=3Dmirrortarball" mean? Will it work like a
> MIRRORTARBALL replacement?

The mirrorformat parameter would be used by the mirroring code itself
to understand how to handle the url. It would be dropped from the
modified url so is only therefore our code's use. If there are
additional parameters they would be passed through as they are now.

> How does a simple replacement should look like?
>=20
> http://=C2=A0 https://
>=20
> Because of the backward compatible this will replace the basename of
> the path.

It would depend how the mirror is laid out. Some mirrors flatten the
urls like DL_DIR is laid out, some potentially don't. The standard
usage would likely have a mirrorformat=3Ddldir parameter added.


> > The possible options would be something like:
> >=20
> > mirrortarball - mirror tarballs taken from DL_DIR
> > flattened - copy of DL_DIR so DL_DIR layout (maybe call it dldir?)
> > upstream - layout is the same as the upstream directory structure so a =
direct url replacement
> > =20
> Do you think we have to handle the mirror tarball explicit? The
> mirror tarball is required for a scheme change.

If we do that, we can avoid having to guess at too many urls to test to
figure out a mirror format so I think it would be an improvement on
where we are today.

> > If using a mirrortarball mirror url, we'd know to use the values from
> > urldata.mirrortarballs. We could add parameters to the fetcher to have
> > two parameters, one will be the DL_DIR path and the other would be the
> > upstream url path.
> > =20
> I don't understand where this is needed, because the mirror tarball
> and downloadfilename are used by different fetchers.

Please keep in mind that downloadfilename is pretty much a misfeature.
It was added as we couldn't control collisions inside dl_dir but it
creates all kind of other problems. I think we do need to handle that
problem case but it does then mean we have to indicate whether any
given mirror uses "dldir" or "upstream" names and paths.

> > One key question I have is how we might need to
> > shorted the url path for some mirror urls to add/remove a path prefix
> > in the mirroring.
> > =20
> What do you mean by this? The downloadfilename could contain a path
> without any problem after my change.

See above, downloadfilename is not something I'm keen to promote and is
creating several of the problems we have by badly trying to hack extra
functionality onto the fetcher without thinking through all the issues
like mirroring.

This is about the fact that you could have:

htttps://some.server/some/deep/multi/level/path/

and a mirror of things there at:

htttps://some.server/shortpath/path/

so the mirror urls need to be able to map

htttps://some.server/some/deep/multi/level/path/a/b/c.tgz

to

htttps://some.server/shortpath/path/a/b/c.tgz

but also:

htttps://some.server/shortpath/path/c.tgz

or possibly

htttps://some.server/shortpath/path.d.tgz

if downloadfilename is in action.

> > =20
> > I think that would cover most of our scenarios and make the mirror urls
> > much more useful/explicit.
> >=20
> > It also would give us a migration path as the code can simply error if
> > it sees a mirror url without a mirrorformat parameter. This may mean we
> > could have a clean slate for the mirror urls and switch to one clear
> > format. I think we can make a case for such a breaking architecture
> > change.
> > =20
> Does this means we doesn't need a backward compatibility?

If we can come up with sufficient justification to break things and can
detect and error correctly for old usage and get this signed off by the
TSC/community, potentially, yes.

> Alternative we could make some replacement mandatory if a wildcard is
> used to detect obsolete entries.

I don't understand that.=C2=A0

I do think we have too many problems in the existing mirroring url
mapping and we probably need to rework this rather than try and pile
more patches into it and complicate it further.

The question is whether the proposal fixes the issues it needs to and
has enough simplification and benefit to justify making the change.

Cheers,

Richard

--=-Hkym/imNWDlCJqCPmWqw
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
  <body><div>On Thu, 2025-02-20 at 12:45 +0100, Stefan Herbrechtsmeier via =
lists.openembedded.org wrote:</div><blockquote type=3D"cite" style=3D"margi=
n:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex"><div> </div><=
div class=3D"moz-cite-prefix">Am 20.02.2025 um 11:22 schrieb Richard Purdie=
 via lists.openembedded.org:<br> </div><blockquote type=3D"cite" cite=3D"mi=
d:d971d67321a2d43666885004f7ff9a479f4d1855.camel@linuxfoundation.org" style=
=3D"margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex"><pre=
>On Wed, 2025-02-05 at 13:12 +0100, Stefan Herbrechtsmeier wrote:</pre><blo=
ckquote type=3D"cite" style=3D"margin:0 0 0 .8ex; border-left:2px #729fcf s=
olid;padding-left:1ex"><pre>&nbsp;Am 05.02.2025 um 11:34 schrieb Richard Pu=
rdie:</pre><pre>&nbsp;On Wed, 2025-02-05 at 08:15 +0100, Stefan Herbrechtsm=
eier via lists.openembedded.org wrote:</pre><div>I=E2=80=99m open for sugge=
stions. Even ARCHIVE or TARBALL are hard to</div><pre>understand because it=
 is only a relative path on the download mirror.</pre><pre>Alternative we c=
an mark the lines as upstream or download mirror and</pre><pre>give the rep=
lacement different meanings. The path could be the</pre><pre>original PATH =
for an upstream mirror or the relative path of the</pre><pre>downloaded fil=
e for the download mirror.</pre><div> </div></blockquote><div> </div><pre>I=
've been giving this topic some thought. One idea I wondered about was</pre=
><pre>to instead markup the mirror urls with how they're expected to work</=
pre><pre>with a new parameter. For example:</pre><pre><br></pre><pre>git://=
.*/.*  <a class=3D"moz-txt-link-freetext" href=3D"http://downloads.yoctopro=
ject.org/mirror/sources/?mirrorformat=3Dmirrortarball">http://downloads.yoc=
toproject.org/mirror/sources/?mirrorformat=3Dmirrortarball</a></pre><div> <=
/div></blockquote><div> The ? could be problematic because it is the separa=
tor for the query. It is unlikely that the user really use this query param=
eter but it could complicate the code because we have to handle additional =
query parameters.<br> What does the "?mirrorformat=3Dmirrortarball" mean? W=
ill it work like a MIRRORTARBALL replacement?</div></blockquote><div><br></=
div><div>The mirrorformat parameter would be used by the mirroring code its=
elf to understand how to handle the url. It would be dropped from the modif=
ied url so is only therefore our code's use. If there are additional parame=
ters they would be passed through as they are now.</div><div><br></div><blo=
ckquote type=3D"cite" style=3D"margin:0 0 0 .8ex; border-left:2px #729fcf s=
olid;padding-left:1ex"><div>How does a simple replacement should look like?=
<br> <br> http://&nbsp; https://<br> <br> Because of the backward compatibl=
e this will replace the basename of the path.</div></blockquote><div><br></=
div><div>It would depend how the mirror is laid out. Some mirrors flatten t=
he urls like DL_DIR is laid out, some potentially don't. The standard usage=
 would likely have a mirrorformat=3Ddldir parameter added.</div><div><br></=
div><div><br></div><blockquote type=3D"cite" style=3D"margin:0 0 0 .8ex; bo=
rder-left:2px #729fcf solid;padding-left:1ex"><blockquote type=3D"cite" cit=
e=3D"mid:d971d67321a2d43666885004f7ff9a479f4d1855.camel@linuxfoundation.org=
" style=3D"margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1e=
x"><pre>The possible options would be something like:</pre><pre><br></pre><=
pre>mirrortarball - mirror tarballs taken from DL_DIR</pre><pre>flattened -=
 copy of DL_DIR so DL_DIR layout (maybe call it dldir?)</pre><pre>upstream =
- layout is the same as the upstream directory structure so a direct url re=
placement</pre><div> </div></blockquote><div> Do you think we have to handl=
e the mirror tarball explicit? The mirror tarball is required for a scheme =
change.</div></blockquote><div><br></div><div>If we do that, we can avoid h=
aving to guess at too many urls to test to figure out a mirror format so I =
think it would be an improvement on where we are today.</div><div><br></div=
><blockquote type=3D"cite" style=3D"margin:0 0 0 .8ex; border-left:2px #729=
fcf solid;padding-left:1ex"><blockquote type=3D"cite" cite=3D"mid:d971d6732=
1a2d43666885004f7ff9a479f4d1855.camel@linuxfoundation.org" style=3D"margin:=
0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex"><pre>If using a=
 mirrortarball mirror url, we'd know to use the values from</pre><pre>urlda=
ta.mirrortarballs. We could add parameters to the fetcher to have</pre><pre=
>two parameters, one will be the DL_DIR path and the other would be the</pr=
e><pre>upstream url path.</pre><div> </div></blockquote><div> I don't under=
stand where this is needed, because the mirror tarball and downloadfilename=
 are used by different fetchers.</div></blockquote><div><br></div><div>Plea=
se keep in mind that downloadfilename is pretty much a misfeature. It was a=
dded as we couldn't control collisions inside dl_dir but it creates all kin=
d of other problems. I think we do need to handle that problem case but it =
does then mean we have to indicate whether any given mirror uses "dldir" or=
 "upstream" names and paths.</div><div><br></div><blockquote type=3D"cite" =
style=3D"margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex"=
><blockquote type=3D"cite" cite=3D"mid:d971d67321a2d43666885004f7ff9a479f4d=
1855.camel@linuxfoundation.org" style=3D"margin:0 0 0 .8ex; border-left:2px=
 #729fcf solid;padding-left:1ex"><pre>One key question I have is how we mig=
ht need to</pre><pre>shorted the url path for some mirror urls to add/remov=
e a path prefix</pre><pre>in the mirroring.</pre><div> </div></blockquote><=
div> What do you mean by this? The downloadfilename could contain a path wi=
thout any problem after my change.</div></blockquote><div><br></div><div>Se=
e above, downloadfilename is not something I'm keen to promote and is creat=
ing several of the problems we have by badly trying to hack extra functiona=
lity onto the fetcher without thinking through all the issues like mirrorin=
g.</div><div><br></div><div>This is about the fact that you could have:</di=
v><div><br></div><div>htttps://some.server/some/deep/multi/level/path/</div=
><div><br></div><div>and a mirror of things there at:</div><div><br></div><=
div><div>htttps://some.server/shortpath/path/</div></div><div><br></div><di=
v>so the mirror urls need to be able to map</div><div><br></div><div><div>h=
tttps://some.server/some/deep/multi/level/path/a/b/c.tgz</div></div><div><b=
r></div><div>to</div><div><br></div><div><div>htttps://some.server/shortpat=
h/path/a/b/c.tgz</div></div><div><br></div><div>but also:</div><div><br></d=
iv><div><div>htttps://some.server/shortpath/path/c.tgz</div></div><div><br>=
</div><div>or possibly</div><div><br></div><div><div>htttps://some.server/s=
hortpath/path.d.tgz</div></div><div><br></div><div>if downloadfilename is i=
n action.</div><div><br></div><blockquote type=3D"cite" style=3D"margin:0 0=
 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex"><blockquote type=
=3D"cite" cite=3D"mid:d971d67321a2d43666885004f7ff9a479f4d1855.camel@linuxf=
oundation.org" style=3D"margin:0 0 0 .8ex; border-left:2px #729fcf solid;pa=
dding-left:1ex"><div> </div><pre>I think that would cover most of our scena=
rios and make the mirror urls</pre><pre>much more useful/explicit.</pre><pr=
e><br></pre><pre>It also would give us a migration path as the code can sim=
ply error if</pre><pre>it sees a mirror url without a mirrorformat paramete=
r. This may mean we</pre><pre>could have a clean slate for the mirror urls =
and switch to one clear</pre><pre>format. I think we can make a case for su=
ch a breaking architecture</pre><pre>change.</pre><div> </div></blockquote>=
<div> Does this means we doesn't need a backward compatibility?</div></bloc=
kquote><div><br></div><div>If we can come up with sufficient justification =
to break things and can detect and error correctly for old usage and get th=
is signed off by the TSC/community, potentially, yes.</div><div><br></div><=
blockquote type=3D"cite" style=3D"margin:0 0 0 .8ex; border-left:2px #729fc=
f solid;padding-left:1ex"><div>Alternative we could make some replacement m=
andatory if a wildcard is used to detect obsolete entries.</div></blockquot=
e><div><br></div><div>I don't understand that.&nbsp;</div><div><br></div><d=
iv>I do think we have too many problems in the existing mirroring url mappi=
ng and we probably need to rework this rather than try and pile more patche=
s into it and complicate it further.</div><div><br></div><div>The question =
is whether the proposal fixes the issues it needs to and has enough simplif=
ication and benefit to justify making the change.</div><div><br></div><div>=
Cheers,</div><div><br></div><div>Richard</div><div><span></span></div></bod=
y></html>

--=-Hkym/imNWDlCJqCPmWqw--

