Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.51.1794412477309265259
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Nov 2026 07:54:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=iLdgrl63;
 spf=pass (domain: gmail.com, ip: 74.125.224.47, mailfrom: jpewhacker@gmail.com)
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-675617e81f9so3395235d50.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 11 Nov 2026 07:54:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794412476; cv=none;
        d=google.com; s=arc-20260327;
        b=G5EOlJW4EbQ2PEkkMVusGY6iEJwRDEJlFi/mB63Y2MxmWf/SHn5zwa2nC7pHbUGEE4
         Z5KAZzxmAVWdq8vqtK446g8ZvGrZXUADbXnBVgPrcxlAfeI6aBtkxXUIP7GotJpM1pME
         aQZQOHKOzW2ELILQ87xmMu/D+v24TEq6/cjUbFsJQggXZ7ZGOHbMXarrVCQ9itsDeME/
         3khfPf8/rxVfTFuYh71V1lWQ9LFgCpSxdwOqSMjZNW7igRo9VRzBxK0Wn6VXS02jCZ/E
         t32J54evb6Rt8ekhNaQEYjb86UaZtK+Pn3F6pqm+f4kyC2EJLqOmyto2/hEO+Zmz0vRp
         oDTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ba6QZfEelwUxTdQebdEaLgwfOvbq8UTorhMuYUOYPug=;
        fh=FKvDimVARmK2rbM1iLZ1cekDbuzpJYcneTKlRG4qWwQ=;
        b=Z3dH4VmG+jXVKwp0DS3ncMUiM50Vn2V3gQ8u8CzyX3cptEli+eJysiWmEARWjt/7JK
         qcxqgciyc7diGzbh4ZBdP92GLv86Qef0ySBbsUqnRSZ+lEBGBIi4VpvzEeCbyEFcvLlh
         vSHc7PEJIiZ0zxnJu066+GmszIxSK80jgRGFs68xIEAakfDcZWfFADaR+uNiEKZLcEtE
         wPMFUBxzKqK3vP0N7eqFiC5sg08D9cjM2+k7Rw0Ggr1toc58cTmjr28jNhZNHVCjGfXU
         iLulg6qCFE8HuRvvPOB5hezRncbbCmSVvJXFiddQUGbOQbfzxEQj4mIzOklg9pskp83W
         8Vhg==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794412476; x=1795017276; darn=lists.openembedded.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ba6QZfEelwUxTdQebdEaLgwfOvbq8UTorhMuYUOYPug=;
        b=iLdgrl63/Hv3Vy5fWmBCh6/7thk0m7lQnmzLH7TrJVC5a2BCwi8eXq1+F4iDxmdO6i
         HzvXd8qD3nouu+n+s+dwX86ZlxI33b1Kn8I9/bECne6zLDXQiqYjQ4Nglnxc1SPkgjZt
         ejpopXjSLwivioymS48jVx2NIBQnzFKjuR0oXzSqbi4otOnbYgh7JOpkSOCcKSI9EjCE
         Cpdnii4qFsBwH1lyb76dU5yPDQoJgKqWM6Di3TQMlMvgqE4SSxQdzE7jzyHfxE3CL91h
         /TMDa6HeM7YvzqFqUJv2upzRJQS9rrYJuEOUbwtoW/mkthJGtafXqlflTicr9CdPdPTu
         qmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794412476; x=1795017276;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ba6QZfEelwUxTdQebdEaLgwfOvbq8UTorhMuYUOYPug=;
        b=Ae5Xg+aa8PKYx/uaaRWq5J9PW4B6qFs0mjBOO6wtrJwOq6SUFhbMAOu9U09dUY9RBZ
         W+QEqviI/rWTlDwQ73+8IkCrwYKeCaeziwu76o9ohHzUmTsdTqEC7ULs5hNAmi7A43b1
         7JoHLwdFSF738q3PcXbggyls4qfIytGJZSyX3cwmPInROUATUVzAyR5QLVTwjFj/AtzR
         dBd3AyZ20fRo3e+TQycyvUTcyqqTJtjfZFAXDoP23Kn/oM50bOF0kQYUldhXRAphjbc+
         ey7bpe62PxmK94kbuLsZ9hviH8a6pf4jRJfJOrj+TuCelGc34SNW2axn+bzN7xWpBqtp
         NrmA==
X-Forwarded-Encrypted: i=1; AL+hErFAUUKRwElbyHE/vi6IaktrLBoVISBMqnXa8R0zg4fxMERlekz3VBs4C1t5qwh8tZHqCPiMiicF+JC2BSvy@lists.openembedded.org
X-Gm-Message-State: APuU4Z+FF0aRbU3M/F2ZPIPIDHNveK8EHER+cprxKeLvfrFacPMjwCL1
	IQN7z4D7KjQwLnT0CvS9KHjRrNrg+1pLuE7YPnFqhbGZckerVqLnPOEALBqF2wJHqvpN+YwExMJ
	IN1HtZtZZf2Y2b+i0de99cbJ0EABre+M=
X-Gm-Gg: AYBFou1TZJM7bQ4QH24pGaVz0yJysaMNQ9RcTAUMNpRfuag6mlGyi5SFRwMZee/7suz
	iChpvXaiKDC+EteKsQWjto5C75d3dG99BbLrD1lTHRHnpA3I2w+1u0orFgyG+tl0xaSI+zyquOW
	PytTwmcSxKnnZSqCCATVSUPWEY2MY5XbCNZMoWvLL3aQ/l9LDllyYQmmNMZvRvHJuOyr9m/yEZl
	N170uGhOJvvZswrtpqbjbNRGwDjntYNcXfEwvb6h7ThgIl+KH1bvsM18TSUwLRVg7eLW+2gYWup
	Z059OKqU476SUoXUsH7DzEQPGEBrWfleKNhxOaBUxPE5BayAlu0qtMa8iSp+H3Qla1A9W86ErpM
	iTnU+Zya/cyHTYwWKso2AiLlPq5xmBWpUJhWwV7NBEvj4oCj5U/2+
X-Received: by 2002:a05:690e:438e:b0:679:b8df:2aa with SMTP id
 956f58d0204a3-67c6802aea4mr1452864d50.82.1794412476349; Wed, 11 Nov 2026
 07:54:36 -0800 (PST)
MIME-Version: 1.0
References: <CAJdd5GZTCwr9VE8OmOw7RAki+Xu+kokCgtOHG+9ghE3frWPbqg@mail.gmail.com>
 <20261111115845.1940227-1-stondo@gmail.com>
In-Reply-To: <20261111115845.1940227-1-stondo@gmail.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Wed, 11 Nov 2026 08:54:25 -0700
X-Gm-Features: AclHuK-O4wqVpqbhwINhG6QHndcjSU522gPjBnYSq5UyJeTr3DpATDVbetLJDG4
Message-ID: <CAJdd5GY0M8hYbRk8ZteztrrXJe01cRaDMT0eTiTqxrp7W7PJWQ@mail.gmail.com>
Subject: Re: [RFC] spdx30: name, version and purl for dependency downloads
To: Stefano Tondo <stondo@gmail.com>
Cc: stefano.tondo.ext@siemens.com, 
	Richard Purdie <richard.purdie@linuxfoundation.org>, 
	Alexander Kanavin <alex.kanavin@gmail.com>, openembedded-core@lists.openembedded.org, 
	bitbake-devel@lists.openembedded.org, 
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, 
	Peter Marko <peter.marko@siemens.com>, Adrian Freihofer <adrian.freihofer@siemens.com>, 
	Patrick Wicki <patrick.wicki@siemens.com>
Content-Type: multipart/alternative; boundary="0000000000003bc2b80660023675"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Wed, 11 Nov 2026 15:54:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20419

--0000000000003bc2b80660023675
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 4:58=E2=80=AFAM Stefano Tondo <stondo@gmail.com> wr=
ote:

> On Tue, 10 Nov 2026 at 23:53, Joshua Watt <JPEWhacker@gmail.com> wrote:
> > Perhaps, the better option would be to propagate the SRC_URI purls to
> > the output packages, but apply some sort of (optional) filter that can
> > remove a SRC_URI if it is not actually present in the output. That way,
> > if we have positive confirmation that some input is not present in the
> > output, we can remove its PURL from the output package (but, barring
> > that, we include it).
>
> Hi Joshua,
>
> Thanks, that model makes sense to me. A purl stays unless there is
> proof that the dependency is not in the output. For vulnerability
> checks, that is the safer side.
>
> The cargo prototype already works as that kind of filter.
> cargo metadata --filter-platform resolves the dependencies for the
> target. For python3-bcrypt, it gives the proof for 17 of the 42
> crates: 5 are not used on the target, and 12 only run at build time
> (build scripts and proc-macros). None of them end up in the binary,
> so they lose their purl, and the 25 runtime crates keep it. For Go,
> go version -m on each binary lists the modules compiled into it, so
> it can give the same proof.
>
> One question about the output side: how do you want the purls on the
> output package? I see two options:
>
> 1. Add them to the externalIdentifier list of the output package, the
>    way set_purls() handles SPDX_PACKAGE_URLS today.
> 2. Link the output package to the source download elements, which
>    carry the purls, with a relationship such as contains.
>
> Option 1 is simpler. But an external identifier says what the package
> itself is, so a scanner can take python3-bcrypt for one of its crates.
>

This one is likely the easiest. Static linking (of any kind) means you
should inherit the PURLs of the libraries you have linked against. The
alternative would be to try and make separate packages for the static
libraries and then link them into the final package with a `contains` or
something, but I don't think we have enough introspection into the build
systems to do that reliably.


> Option 2 keeps each dependency as its own element. I prefer option 2,
> unless you see a reason against it.
>
> Thanks,
> Stefano
>

--0000000000003bc2b80660023675
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Nov 11,=
 2026 at 4:58=E2=80=AFAM Stefano Tondo &lt;<a href=3D"mailto:stondo@gmail.c=
om">stondo@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">On Tue, 10 Nov 2026 at 23:53, Joshua Watt &lt;<a href=
=3D"mailto:JPEWhacker@gmail.com" target=3D"_blank">JPEWhacker@gmail.com</a>=
&gt; wrote:<br>
&gt; Perhaps, the better option would be to propagate the SRC_URI purls to<=
br>
&gt; the output packages, but apply some sort of (optional) filter that can=
<br>
&gt; remove a SRC_URI if it is not actually present in the output. That way=
,<br>
&gt; if we have positive confirmation that some input is not present in the=
<br>
&gt; output, we can remove its PURL from the output package (but, barring<b=
r>
&gt; that, we include it).<br>
<br>
Hi Joshua,<br>
<br>
Thanks, that model makes sense to me. A purl stays unless there is<br>
proof that the dependency is not in the output. For vulnerability<br>
checks, that is the safer side.<br>
<br>
The cargo prototype already works as that kind of filter.<br>
cargo metadata --filter-platform resolves the dependencies for the<br>
target. For python3-bcrypt, it gives the proof for 17 of the 42<br>
crates: 5 are not used on the target, and 12 only run at build time<br>
(build scripts and proc-macros). None of them end up in the binary,<br>
so they lose their purl, and the 25 runtime crates keep it. For Go,<br>
go version -m on each binary lists the modules compiled into it, so<br>
it can give the same proof.<br>
<br>
One question about the output side: how do you want the purls on the<br>
output package? I see two options:<br>
<br>
1. Add them to the externalIdentifier list of the output package, the<br>
=C2=A0 =C2=A0way set_purls() handles SPDX_PACKAGE_URLS today.<br>
2. Link the output package to the source download elements, which<br>
=C2=A0 =C2=A0carry the purls, with a relationship such as contains.<br>
<br>
Option 1 is simpler. But an external identifier says what the package<br>
itself is, so a scanner can take python3-bcrypt for one of its crates.<br><=
/blockquote><div><br></div><div>This one is likely the easiest. Static link=
ing (of any kind) means you should inherit the PURLs of the libraries you h=
ave linked against. The alternative would be to try and make separate packa=
ges for the static libraries and then link them into the final package with=
 a `contains` or something, but I don&#39;t think we have enough introspect=
ion into the build systems to do that reliably.</div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
Option 2 keeps each dependency as its own element. I prefer option 2,<br>
unless you see a reason against it.<br>
<br>
Thanks,<br>
Stefano<br>
</blockquote></div></div>

--0000000000003bc2b80660023675--
