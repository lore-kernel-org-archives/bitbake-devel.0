Return-Path: <bruce.ashfield@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526A0C02198
	for <webhook@archiver.kernel.org>; Wed, 12 Feb 2025 14:11:17 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web10.16557.1739369473047513500
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Feb 2025 06:11:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=IyiCc0Kt;
 spf=pass (domain: gmail.com, ip: 209.85.216.54, mailfrom: bruce.ashfield@gmail.com)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fc0026eb79so716773a91.0;
        Wed, 12 Feb 2025 06:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739369472; x=1739974272; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u/+c6huT6aUQ4zdfi5U8tkQpKRBJl9KkUJJWfmUf5PU=;
        b=IyiCc0KtuiwLcpqlv/rSmBNfkn/rhX4KDZBaK3SfH2P40US1NLsBhl1pAYikInGkM0
         jpYJ4GW1OY2UEUSZ2b9h1r3RhZ3uR+gKAcVR2kOMVhkYOBBFBqh/f9qwCP3OJFFpfl75
         lf4GIQE396pZ+0aT9RjVGxdn3SETYHYW2JkFHWbH3Zp5mqlBpQbqMRQPiixjTnzfSa/T
         7Jfc7P5u0rFFiMkaN03MPlYRO8t6JT/GbDmT8YLhTVC2T3NrYv6l0CKsuYcTWuGjDDMW
         TErVaxIUX9wuJUXLDtHSpwSllsHEua5VMEjV2WUSWkjMxmj6quInHOWB78K+g6koGMb8
         SMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739369472; x=1739974272;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u/+c6huT6aUQ4zdfi5U8tkQpKRBJl9KkUJJWfmUf5PU=;
        b=i+lFVdXTC/DQIKIREB1AtSodPYbBc3hYV6e/Fu2/A6V/YHm07L7VQDf5ZW4CnwOWMw
         bF+G6H1Lz9cTtaO4E6SwdIrmMesYuslh2EwbcIbqFhz4upRZTLoXoMrQwx0/tTqFHo/Y
         v3CSJwQoqufMm8PyeEsTIYQVaiJAI/4YRwQ0t+O98tQfySI89Mmto411vdq3WpQxufbX
         ZYMeIgjka6sVoNI/MUElkyMp65ivo5WBn+0sv43aeKpqC3K9WBB6Fu2BQ+XQ+ZiPTPSM
         Myl0v3/Cpfyz8MXXIBBg0ZbjiCx+OIgqZo2P3ZWYZKsm39l2wvc89mnGVoLdjOpJDqCG
         pfRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO0J9+wXHzq3yh66tVyilNY6pRpru0rGb7q/TA96vvEUgHTuGeL72zfaKt5WotqrSntR1kP4Mflfz7ep79@lists.openembedded.org
X-Gm-Message-State: AOJu0YytFrw0stXCSndn/rrSbLIkaxUx6vififfN5aJbgVG4U68whzrt
	9hXbTayz9taAwUkuG94CaJoBbpUD3q0BUoffwtSnAuiX+yWA3QmDFm3gk3umvNcXfC+hA5n2gHj
	gd4+/728zH4b3Qwo7kCDOev5zf4E=
X-Gm-Gg: ASbGncvVaw12uxgZUhuVVa3btbylNd0eV6cSWbuoHWbrKXv2xHOS+3aIiK24ASPjYvZ
	E4yVrKbLhYcere5fI2vEuCdionSkjVmyNVXY8d4RL/u2Qm0NtmCw60euUq8DxK1Gb6Alw1riW8A
	==
X-Google-Smtp-Source: AGHT+IFpF4ltbd2HilxgAmz2UVG/fNOi8DUGOX9vqTFQR6gbFLHcX9n4Lb3h8vVzzeiIXdK6ge1GeVapOXWZxNbjePs=
X-Received: by 2002:a17:90b:2541:b0:2ee:a4f2:b307 with SMTP id
 98e67ed59e1d1-2fbf5bc1de9mr5171096a91.4.1739369472280; Wed, 12 Feb 2025
 06:11:12 -0800 (PST)
MIME-Version: 1.0
References: <20250211150034.18696-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <Z6vZ8m8zZLgQKyVg@gmail.com> <40f8d1d9-5bd3-4ac6-a107-32482d06d17b@weidmueller.com>
In-Reply-To: <40f8d1d9-5bd3-4ac6-a107-32482d06d17b@weidmueller.com>
From: Bruce Ashfield <bruce.ashfield@gmail.com>
Date: Wed, 12 Feb 2025 09:11:00 -0500
X-Gm-Features: AWEUYZk_e4W3EWUf5kw4AqZIj6hsiiMyrYPDybnE0rEWJvXkkcoD30e1JuH3WB4
Message-ID: <CADkTA4OA8VkQk=FVD=hMDaH+TU2567zLduVfYHSqkR_C4fpjOw@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC PATCH 00/30] Add vendor support for go, npm
 and rust
To: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
Cc: openembedded-core@lists.openembedded.org, 
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, 
	bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000008754b3062df283ff"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Feb 2025 14:11:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17206

--0000000000008754b3062df283ff
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 3:41=E2=80=AFAM Stefan Herbrechtsmeier <
stefan.herbrechtsmeier-oss@weidmueller.com> wrote:

> Am 12.02.2025 um 00:14 schrieb Bruce Ashfield via lists.openembedded.org:
>
> In message: [bitbake-devel] [RFC PATCH 00/30] Add vendor support for go, =
npm and rust
> on 11/02/2025 Stefan Herbrechtsmeier via lists.openembedded.org wrote:
>
>
> From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com> <st=
efan.herbrechtsmeier@weidmueller.com>
>
> The series adds on-the-fly support for package manager specific
> dependencies and vendor directories. It contains the following changes:
> 1. Adds an early fetch, unpack and patch task to unpack and patch source
>    code with an embedded lock file for dependencies.
> 2. Parse the go.sum, Cargo.lock and package-lock.json lock files and
>    resolve the dependencies to SRC_URIs.
> 3. Save the SRC_URIs in a file and adapt all SRC_URIs users to handle
>    the SRC_URI files beside the SRC_URIs in the recipe.
>
> I made a few comments, and will have another / better look at the
> series tomorrow. There's a lot here, and it is hard to wrap my head
> around everything that is changing.
>
> I have one specific question below (from the point of view of go).
>
> I've been looking through the series, and can't pick out where #3 is
> done.
>
> The files are created in the package manager specific vendor classes (17 =
-
> 19) in the do_vendor_resolve task. The parsing is implemented in the
> package manager specific modules in the vendor package (6-8).
>
>
aha. I'll have a closer look in a bit!



>  I see patch 14 using SRC_URI_FILES, but where are those files
> written ? Is that in patch 18 (vendor_go_do_vendor_resolve ?)  What is
> written to those files ?
>
> The file is written into the vendor directory below WORKDIR. The approach
> is similar to other classes which need to share data between tasks.
>
> The files contain individual SRC_URIs per line.
>
I may have missed that in the patches, but if that isn't described in the
commit logs, then
that description would be a nice addition. Along with a high level
description for each
supported language package manager about what is in the files and what uses
it to
resolve the dependencies.


> The concept that I'm not understanding (and that's just me not being
> familiar with things, I'll continue reading the series) is that when
> we suggested we'd like to have a mode where the dependencies could
> clearly be listed in the SRC_URI, at least I was just thinking about a
> way run the fetch/module elements that you were adding, write them to
> a file and then have the recipe include it.
>
> The additional SRC_URIs are dynamically added to the recipe without the
> indirection over an include file. The generated SRC_URIs could be inspect=
ed
> via the SRC_URI_FILES and manipulated via patches for the lock files or a=
n
> separated lock file.
>
The issue with patching those dynamic files .. is just that, they are
dynamic and
they could be regenerated (but hopefully without a SRCREV change they are
identically
generated each time, so maybe it isn't a big deal) and patching could fail.
Much like we
don't patch generated automake files, we patch the .am and .in files that
generate the
outputs.

>
> I can't tell if in the series those files are written each time, and
> that there would be no way to edit those SRC_URI_FILES .. but I'll
> look again tomorrow.
>
> The files are written if the do_vendor_resolve task need to be rerun. It
> isn't possible to edit the generated SRC_URIs. Instead the lock file coul=
d
> be patched.
>

ok. So they are really just a way to dump what is being built to disk and
out of "memory",
it really isn't what I was looking for, but at least I understand what you
were trying to
do with the writing and later use of the files now.

I was hoping for something that I could include "statically" (for lack of a
better term) in my
recipes, and then have the handlers for the protocols do the fetching ..
again, much like
the crate:// fetches in the .inc files.

To be clear, I'm not suggesting that mode would be the only mode, just that
the way the
generation of the fetches -> actual fetching was constructed such that I
could avoid
"short circuit" the handling of the lock file and simply list the
dependencies for fetching
(much like how I can go get all of the SRCREVS for a gitsm:// fetch, and
put them into
my recipes as pure git:// fetches if I'm having issues with the git
submodles).

That file would manipulate the standard SRC_URI. In other words still
> support a mode that is like the .inc files with crate://. So someone
> could either have the lockfile parsed and fetched, or have a way to
> run the parsing and fetching via a task, write a file and include the
> file in their recipe to short circuit the processing of the lockfile.
> (meaning the expanded and end fetches that are done once you've
> processed the file are simply listed as a series of fetches that are
> carried out without extra processing .. and "unrolled" dependency
> file pointing at the "sources" git, crate, mod, whatever)
>
> What is the motivation "to short circuit the processing of the lockfile"?
> Like any task the processing and its output are cached via the sstate cac=
he.
>

See above. It isn't about re-running it a later time and re-using the
artifacts, it is about
having a way to make sure nothing is dynamically resolved when bitbake
<foo> is called,
just fetch and the rest of the standard tasks.

>
> It is possible to use the vendor package to create a include file but we
> should have good reasons to support two solutions for the same problem.
>
> If that just doesn't make sense, then if there was a way to copy
> the lockfile out of the recipe and have it overlayed onto the fetched
> one .. maybe breaking out the individual fetch lines isn't required,
> since they could be individually manipulated in that lockfile.
>
> I haven't test it but this should be possible. You can place a lock file
> beside the recipe, add it to the SRC_URI and change the XXX_LOCK_PATH.
>

Something like that is a big step towards having that finer grained control
in a recipe that
I'm looking for. I'd still like some sort of line by line "dumped
dependency list" if there's a
lower level protocol at play (but the lock file really also is just that
line by line list for many
of the languages).

Bruce

> Regards Stefan
>


--=20
- Thou shalt not follow the NULL pointer, for chaos and madness await thee
at its end
- "Use the force Harry" - Gandalf, Star Trek II

--0000000000008754b3062df283ff
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote gmail_quote_con=
tainer"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 12, 2025 at 3:41=
=E2=80=AFAM Stefan Herbrechtsmeier &lt;<a href=3D"mailto:stefan.herbrechtsm=
eier-oss@weidmueller.com">stefan.herbrechtsmeier-oss@weidmueller.com</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><u></u>

 =20
  <div>
    <div>Am 12.02.2025 um 00:14 schrieb Bruce
      Ashfield via <a href=3D"http://lists.openembedded.org" target=3D"_bla=
nk">lists.openembedded.org</a>:<br>
    </div>
    <blockquote type=3D"cite">
      <pre>In message: [bitbake-devel] [RFC PATCH 00/30] Add vendor support=
 for go, npm and rust
on 11/02/2025 Stefan Herbrechtsmeier via <a href=3D"http://lists.openembedd=
ed.org" target=3D"_blank">lists.openembedded.org</a> wrote:

</pre>
      <blockquote type=3D"cite">
        <pre>From: Stefan Herbrechtsmeier <a href=3D"mailto:stefan.herbrech=
tsmeier@weidmueller.com" target=3D"_blank">&lt;stefan.herbrechtsmeier@weidm=
ueller.com&gt;</a>

The series adds on-the-fly support for package manager specific
dependencies and vendor directories. It contains the following changes:
1. Adds an early fetch, unpack and patch task to unpack and patch source
   code with an embedded lock file for dependencies.
2. Parse the go.sum, Cargo.lock and package-lock.json lock files and
   resolve the dependencies to SRC_URIs.
3. Save the SRC_URIs in a file and adapt all SRC_URIs users to handle
   the SRC_URI files beside the SRC_URIs in the recipe.
</pre>
      </blockquote>
      <pre>I made a few comments, and will have another / better look at th=
e
series tomorrow. There&#39;s a lot here, and it is hard to wrap my head
around everything that is changing.

I have one specific question below (from the point of view of go).

I&#39;ve been looking through the series, and can&#39;t pick out where #3 i=
s
done.</pre>
    </blockquote>
    <p>The files are created in the package manager specific vendor
      classes (17 - 19) in the do_vendor_resolve task. The parsing is
      implemented in the package manager specific modules in the vendor
      package (6-8).<br>
      <br></p></div></blockquote><div><br></div><div><div class=3D"gmail_de=
fault" style=3D"font-size:small">aha. I&#39;ll have a closer look in a bit!=
</div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex"><p>
    </p>
    <blockquote type=3D"cite">
      <pre> I see patch 14 using SRC_URI_FILES, but where are those files
written ? Is that in patch 18 (vendor_go_do_vendor_resolve ?)  What is
written to those files ?</pre>
    </blockquote>
    <p>The file is written into the vendor directory below WORKDIR. The
      approach is similar to other classes which need to share data
      between tasks.<br>
      <br>
      The files contain individual SRC_URIs per line.<br></p></blockquote><=
div><div class=3D"gmail_default" style=3D"font-size:small">I may have misse=
d that in the patches, but if that isn&#39;t described in the commit logs, =
then</div><div class=3D"gmail_default" style=3D"font-size:small">that descr=
iption would be a nice addition. Along with a high level description for ea=
ch</div><div class=3D"gmail_default" style=3D"font-size:small">supported la=
nguage package manager about what is in the files and what uses it to</div>=
<div class=3D"gmail_default" style=3D"font-size:small">resolve the dependen=
cies.</div></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex"><div><p>
      <br>
    </p>
    <blockquote type=3D"cite">
      <pre>The concept that I&#39;m not understanding (and that&#39;s just =
me not being
familiar with things, I&#39;ll continue reading the series) is that when
we suggested we&#39;d like to have a mode where the dependencies could
clearly be listed in the SRC_URI, at least I was just thinking about a
way run the fetch/module elements that you were adding, write them to
a file and then have the recipe include it.</pre>
    </blockquote>
    <p>The additional SRC_URIs are dynamically added to the recipe
      without the indirection over an include file. The generated
      SRC_URIs could be inspected via the SRC_URI_FILES and manipulated
      via patches for the lock files or an separated lock file.=C2=A0</p></=
div></blockquote><div><span class=3D"gmail_default" style=3D"font-size:smal=
l">The issue with patching those dynamic files .. is just that, they are dy=
namic and</span></div><div class=3D"gmail_default" style=3D"font-size:small=
">they could be regenerated (but hopefully without a SRCREV change they are=
 identically</div><div class=3D"gmail_default" style=3D"font-size:small">ge=
nerated each time, so maybe it isn&#39;t a big deal) and patching could fai=
l. Much like we</div><div class=3D"gmail_default" style=3D"font-size:small"=
>don&#39;t patch generated automake files, we patch the .am and .in files t=
hat generate the</div><div class=3D"gmail_default" style=3D"font-size:small=
">outputs.</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div><p>
      <br>
      <span style=3D"white-space:pre-wrap">
</span></p>
    <blockquote type=3D"cite">
      <pre>I can&#39;t tell if in the series those files are written each t=
ime, and
that there would be no way to edit those SRC_URI_FILES .. but I&#39;ll
look again tomorrow.</pre>
    </blockquote>
    <p>The files are written if the do_vendor_resolve task need to be
      rerun. It isn&#39;t possible to edit the generated SRC_URIs. Instead
      the lock file could be patched.<br>
      <span style=3D"white-space:pre-wrap"></span></p></div></blockquote><d=
iv><br></div><div><div class=3D"gmail_default" style=3D"font-size:small">ok=
. So they are really just a way to dump what is being built to disk and out=
 of &quot;memory&quot;,</div><div class=3D"gmail_default" style=3D"font-siz=
e:small">it really isn&#39;t what I was looking for, but at least I underst=
and what you were trying to</div><div class=3D"gmail_default" style=3D"font=
-size:small">do with the writing and later use of the files now.</div></div=
><div><br></div><div><div class=3D"gmail_default" style=3D"font-size:small"=
>I was hoping for something that I could include &quot;statically&quot; (fo=
r lack of a better term) in my</div><div class=3D"gmail_default" style=3D"f=
ont-size:small">recipes, and then have the handlers for the protocols do th=
e fetching .. again, much like</div><div class=3D"gmail_default" style=3D"f=
ont-size:small">the crate:// fetches in the .inc files.</div><div class=3D"=
gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmail_defa=
ult" style=3D"font-size:small">To be clear, I&#39;m not suggesting that mod=
e would be the only mode, just that the way the</div><div class=3D"gmail_de=
fault" style=3D"font-size:small">generation of the fetches -&gt; actual fet=
ching was constructed such that I could avoid</div><div class=3D"gmail_defa=
ult" style=3D"font-size:small">&quot;short circuit&quot; the handling of th=
e lock file and simply list the dependencies for fetching</div><div class=
=3D"gmail_default" style=3D"font-size:small">(much like how I can go get al=
l of the SRCREVS for a gitsm:// fetch, and put them into</div><div class=3D=
"gmail_default" style=3D"font-size:small">my recipes as pure git:// fetches=
 if I&#39;m having issues with the git submodles).</div><div class=3D"gmail=
_default" style=3D"font-size:small"><br></div></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex"><div><p><span style=3D"white-space:pre-wrap">

</span></p>
    <blockquote type=3D"cite">
      <pre>That file would manipulate the standard SRC_URI. In other words =
still
support a mode that is like the .inc files with crate://. So someone
could either have the lockfile parsed and fetched, or have a way to
run the parsing and fetching via a task, write a file and include the
file in their recipe to short circuit the processing of the lockfile.
(meaning the expanded and end fetches that are done once you&#39;ve
processed the file are simply listed as a series of fetches that are
carried out without extra processing .. and &quot;unrolled&quot; dependency
file pointing at the &quot;sources&quot; git, crate, mod, whatever)
</pre>
    </blockquote>
    <p>What is the motivation &quot;to short circuit the processing of the
      lockfile&quot;? Like any task the processing and its output are cache=
d
      via the sstate cache.<br></p></div></blockquote><div><br></div><div c=
lass=3D"gmail_default" style=3D"font-size:small">See above. It isn&#39;t ab=
out re-running it a later time and re-using the artifacts, it is about</div=
><div class=3D"gmail_default" style=3D"font-size:small">having a way to mak=
e sure nothing is dynamically=C2=A0resolved when bitbake &lt;foo&gt; is cal=
led,</div><div class=3D"gmail_default" style=3D"font-size:small">just fetch=
 and the rest of the standard tasks.</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex"><div><p>
      <br>
      It is possible to use the vendor package to create a include file
      but we should have good reasons to support two solutions for the
      same problem.<br>
      <br>
    </p>
    <blockquote type=3D"cite">
      <pre>If that just doesn&#39;t make sense, then if there was a way to =
copy
the lockfile out of the recipe and have it overlayed onto the fetched
one .. maybe breaking out the individual fetch lines isn&#39;t required,
since they could be individually manipulated in that lockfile.</pre>
    </blockquote>
    <p>I haven&#39;t test it but this should be possible. You can place a
      lock file beside the recipe, add it to the SRC_URI and change the
      XXX_LOCK_PATH.<br></p></div></blockquote><div><br></div><div class=3D=
"gmail_default" style=3D"font-size:small">Something like that is a big step=
 towards having that finer grained control in a recipe that</div><div class=
=3D"gmail_default" style=3D"font-size:small">I&#39;m looking for. I&#39;d s=
till like some sort of line by line &quot;dumped dependency list&quot; if t=
here&#39;s a</div><div class=3D"gmail_default" style=3D"font-size:small">lo=
wer level protocol at play (but the lock file really also is just that line=
 by line list for many</div><div class=3D"gmail_default" style=3D"font-size=
:small">of the languages).</div><div class=3D"gmail_default" style=3D"font-=
size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:small=
">Bruce</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div><p>
      <span style=3D"white-space:pre-wrap">
Regards
  Stefan


</span></p>
  </div>

</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature">- Thou shalt not follow the NULL pointer, for chaos and madness a=
wait thee at its end<br>- &quot;Use the force Harry&quot; - Gandalf, Star T=
rek II<br><br></div></div>

--0000000000008754b3062df283ff--

