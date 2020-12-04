Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
 by mx.groups.io with SMTP id smtpd.web10.11730.1607073205304321999
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 04 Dec 2020 01:13:25 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="unable to parse pub key" header.i=@blade-group.com header.s=google header.b=oQv14sxA;
 spf=pass (domain: blade-group.com, ip: 209.85.167.173, mailfrom: yann.dirson@blade-group.com)
Received: by mail-oi1-f173.google.com with SMTP id l207so2533574oib.4
        for <bitbake-devel@lists.openembedded.org>; Fri, 04 Dec 2020 01:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blade-group.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h0Luj0T5mLa05HDPcXSSS5f2m3mwEJS1Z7NgBJVpwaI=;
        b=oQv14sxAn/g5lXzzRR8gRSqeeavvJsVYDHy1iuvlXasNRzwVIYj/j19xmtbmukFQqm
         sBCgqf4w3nPqgO+DyDFqRDqJVlA7yXGECxDzslh2lT2S5WMEh0+Eqs2VE7+s4s1SDSSw
         3Aj3FJEKsbczkqgkAfzGZxtC/KhgbKg2sVN4HDH5HMuFUyDm8gI/dCw8wxXmEoVhDimU
         Qd5JWJ+MtzCTYUn3hPeQhj1GdqCSY2o5/KR0GikNDczGgbXbbNcnOcDy4O2451YgC5Dc
         l2tFbTy7PHscZj5YitQ7WQ+abQ7xANfS4M3K+02ZQGUqOCygAsj+zUQFhwAnggZLAJYv
         TfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h0Luj0T5mLa05HDPcXSSS5f2m3mwEJS1Z7NgBJVpwaI=;
        b=hMOSaTNVQEvK/WRvNbx0ga3IArYd8BKXzJZkgn/hWdYk5yk2fFan7r8BrWJ+TMrPTt
         6qSMuOmBMdySR6NnDGSEMF9wuSxhZZZ4PaSywDgMgSjUkMsJ1AP8unLOyA+J0qjImiCk
         F0OVAPlSowUpNaU/Pt+rALTcVyAMFxPTXG1Mn7aCcxLxB6QlXPkFpDLuekyznxw/CWNi
         akXGiHGrFFf09EHtUbfgfsVOB6HOvR/BOr+M+n9nsG1hk6PAXwUlEsr8lMXEEMH1/APH
         fOO9nNNt+901f6fNVLIJLFO3QBhJxU/4jKzxA/Wpft9pNZDQm3HLx2/vVujR1UbNaCNv
         Q5PQ==
X-Gm-Message-State: AOAM533h+Gvm2ZqnI5Vc+WcEAxJuDLFPqHnAdFkTf/AbA0w50Uod/7Lm
	5U1pRdyEl0gfHE3o/S3p/sI5LSl++uVWQEO38648zQ==
X-Google-Smtp-Source: ABdhPJyaE8SWqEcF6RdV4DLsIH/5ccmsLR3p64NEdIuaIt5B2ntHSHoEPSyC2nPPaJb8VS7iHZN8d2Kf82LQmSqQy8s=
X-Received: by 2002:aca:53d2:: with SMTP id h201mr2512143oib.168.1607073204662;
 Fri, 04 Dec 2020 01:13:24 -0800 (PST)
MIME-Version: 1.0
References: <20201202095020.1439530-1-yann@blade-group.com>
 <CA+4=imaDYQ0XT=04cOrymvBeia=qYB2-PuWAfTYCdtRpqGKEhA@mail.gmail.com> <abb376b42320bb2b3f7f2980caa060b9c09f9d3d.camel@linuxfoundation.org>
In-Reply-To: <abb376b42320bb2b3f7f2980caa060b9c09f9d3d.camel@linuxfoundation.org>
From: "Yann Dirson" <yann.dirson@blade-group.com>
Date: Fri, 4 Dec 2020 10:13:13 +0100
Message-ID: <CA+4=imZyUGNB9faMcZy95YwfYNrwPwpssuNw3fdR06e2MWQYMw@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC][PATCH] fetch2.wget: add support for per-source download flags
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org, Yann Dirson <yann@blade-group.com>
Content-Type: multipart/alternative; boundary="0000000000007e09b805b59fe3ab"

--0000000000007e09b805b59fe3ab
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 4 d=C3=A9c. 2020 =C3=A0 00:09, Richard Purdie <
richard.purdie@linuxfoundation.org> a =C3=A9crit :

> On Wed, 2020-12-02 at 11:50 +0100, Yann Dirson wrote:
> > An alternative I thought about would be to:
> >
> > 1. expose all the FETCHCMD_$method vars with their default values
> > through setVar,
> > so we can _append them, as today it is only possible to fully
> > override them
> >
> > 2. use something like FETCHCMD_$method_append_srcuri-$name=3D"--foo".
> > However that
> > would require to add "srcuri-$name" to overrides temporarily for each
> > file fetched, and I don't
> > quite see how that could fit in the current codebase
>
> FETCHCMD was never a nice fit and we've tried to back away from using
> that. That is particularly true give you want to do it on a per url
> basis. The hope was we could add things to the urls as parameters if/as
> needed. The strings you're trying to add are fairly complex to encode
> into urls though, I'm not sure if there is a good way we could make
> that work, could we encode it somehow?
>

My first attempt _was_  using parameters: I added an authz_bearer parameter
and
patched Wget.download() to append '--header=3D"Authorization: Bearer $value=
"
'.

Other than the problem of it requiring patching Wget.download() for each
feature we'd
want to use, it was quite annoying to use in combination to the yarn
support sent to
openembedded-core the same day: there the SRC_URI are generated and the
script is not smart enough to detect on which SRC_URI it would have to add
this
parameter.

Rather than adding more ad-hoc guessing from npm config, I prefered
to go the explicit route and find a way to specify such things separately.

The alternative would have been digging the information in the package's
.npmrc
(which it is an envvar reference that was added there specifically to ease
the integration
with our previous yarn fetcher, which probably does not say anything about
the general
case) and teach yarn-v1-mkbbinc to find the info.  I just have no idea
whether a general
solution to that problem even exists :)

Best regards,
--=20
Yann Dirson <yann@blade-group.com>
Blade / Shadow -- http://shadow.tech

--0000000000007e09b805b59fe3ab
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">Le=C2=A0ven. 4 d=C3=A9c. 2020 =C3=A0=C2=A000:09, Richard Pu=
rdie &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org">richard.purd=
ie@linuxfoundation.org</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">On Wed, 2020-12-02 at 11:50 +0100, Yann =
Dirson wrote:<br>
&gt; An alternative I thought about would be to:<br>
&gt; <br>
&gt; 1. expose all the FETCHCMD_$method vars with their default values<br>
&gt; through setVar,<br>
&gt; so we can _append them, as today it is only possible to fully<br>
&gt; override them<br>
&gt; <br>
&gt; 2. use something like FETCHCMD_$method_append_srcuri-$name=3D&quot;--f=
oo&quot;. <br>
&gt; However that<br>
&gt; would require to add &quot;srcuri-$name&quot; to overrides temporarily=
 for each<br>
&gt; file fetched, and I don&#39;t<br>
&gt; quite see how that could fit in the current codebase<br>
<br>
FETCHCMD was never a nice fit and we&#39;ve tried to back away from using<b=
r>
that. That is particularly true give you want to do it on a per url<br>
basis. The hope was we could add things to the urls as parameters if/as<br>
needed. The strings you&#39;re trying to add are fairly complex to encode<b=
r>
into urls though, I&#39;m not sure if there is a good way we could make<br>
that work, could we encode it somehow?<br></blockquote><div><br></div><div>=
My first attempt _was_=C2=A0 using parameters: I added an authz_bearer para=
meter and</div><div>patched Wget.download() to append &#39;--header=3D&quot=
;Authorization: Bearer $value&quot; &#39;.</div><div><br></div><div>Other t=
han the problem of it requiring patching Wget.download() for each feature w=
e&#39;d</div><div>want to use, it was quite annoying to use in combination =
to the yarn support sent to</div><div>openembedded-core the same day: there=
 the SRC_URI are generated and the</div><div>script is not smart enough to =
detect on which SRC_URI it would have to add this</div><div>parameter.</div=
><div><br></div><div>Rather than adding more ad-hoc guessing from npm confi=
g, I prefered</div><div>to go the explicit route and find a way to specify =
such things separately.</div><div><br></div><div>The alternative would have=
 been digging the information in the package&#39;s .npmrc</div><div>(which =
it is an envvar reference that was added there specifically to ease the int=
egration</div><div>with our previous yarn fetcher, which probably does not =
say anything about the general</div><div>case) and teach yarn-v1-mkbbinc to=
 find the info.=C2=A0 I just have no idea whether a general</div><div>solut=
ion to that problem even exists :)<br></div></div><br clear=3D"all"></div>B=
est regards,<br><div>-- <br><div dir=3D"ltr" class=3D"gmail_signature">Yann=
 Dirson &lt;<a href=3D"mailto:yann@blade-group.com" target=3D"_blank">yann@=
blade-group.com</a>&gt;<br>Blade / Shadow -- <a href=3D"http://shadow.tech"=
 target=3D"_blank">http://shadow.tech</a><br><br></div></div></div>

--0000000000007e09b805b59fe3ab--
