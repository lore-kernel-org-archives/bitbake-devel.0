Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890B4C021B2
	for <webhook@archiver.kernel.org>; Thu, 20 Feb 2025 10:00:41 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web10.46006.1740045636928502124
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Feb 2025 02:00:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=cIQxa+Ug;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38f26a82d1dso404614f8f.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 20 Feb 2025 02:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740045635; x=1740650435; darn=lists.openembedded.org;
        h=mime-version:user-agent:references:in-reply-to:date:to:from:subject
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xJvbd7nlTuvdZ5bnUkhwLqqiVAHvRB2mpP5lX6Mikos=;
        b=cIQxa+UgFYvFAJOnHy7mNip4kYYGdOL0wi+aWnfclQniaHMvjLVaC61dJjamKbzzGP
         1y0wyF4Lsksfny4CTqr76ZoF+0v2tiFl/9znRL+Hia4LXCi0807cBTGEdLKQpfaUyH/I
         MYnr+zo8fy+2gKNv40RmGZXHSSWOQ6a1dRAtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740045635; x=1740650435;
        h=mime-version:user-agent:references:in-reply-to:date:to:from:subject
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xJvbd7nlTuvdZ5bnUkhwLqqiVAHvRB2mpP5lX6Mikos=;
        b=ju+fLTKGImgvdHvHdWN5LchkMQuJv5eGAn54KmeJN0ZR/LWSxmHGg2npr1wBdemjjq
         Cis35Gb0qC12svqmR6HR5bABCuccGyqFo2Y7R2Y0qjTL72ZWc98eYuPpglb+DZK6SHbD
         nCCvuv60M+UTE/TsxkHG+welDVHR4bCA9ZEZyYa7fueURHpWbsItNia/MPpsSNShFm8b
         Ag+hVJLHUDf52d+9HbemaBX8liRtOj5sBRzhhzAe7MET/61aCLJc4M56lMxf27ZJpvT1
         Qkigj/By/cY97wjQqsJK6WpeDcS4gemDGQsiR29RA3L4T4kq36hibVSIq3zAklo4uLXC
         3Tfg==
X-Forwarded-Encrypted: i=1; AJvYcCWy4TUkKTCjdA1kPQJqd+xEWac0vVF89N32SKTbEqWFqnh2o0yQWbCLy3sRP6boWDUsfrdh+mM3YGO1bfHY@lists.openembedded.org
X-Gm-Message-State: AOJu0YyTLca5AIohC4uxtBWZQdKXMIHOW+Dlf8MhQd8x0mSzkrKk4Pnt
	CWbir+kwwnv50R/w8eamAcVEwykKksl5K0JmvNBipUj4asDYyqUb8lfrvhdyrh0=
X-Gm-Gg: ASbGnctX/UGwjtLnVHrIZl9tfgXFZs4bzX0R7hGi9pH7yJ91V78agxJZovGkBCkMLFy
	JRPYdP7/ELQK4U4gaeixnliSINkAwfVZwmnGPqpSrwfXCOJ/xETPcOpERotQcjElmNy5vMqvfGg
	2M52rmA2kk70ZyAZtHL2zoard1sNs875bgx1knFlCydBsX1dnwV5Xxq3Dub9lApp6NXXskIPldS
	ERcSZ/FvLE/JEVldJZUj8s7BwRYrvB/dps5xj+U329S2ExCPh4fXzwX9Bk7cnSB+GIzuDGW5GKy
	w3YUnnRGkjuvugCI3xT3/Cmigzal6AFqCNk8Tl5Bla5uKlBVKfKjp6PACZM/NT8yLG5WK18RBpu
	LqFRO
X-Google-Smtp-Source: AGHT+IFrHarUcmtwCDJFeAaxM8qqcXULS1roWmLqpAQJbQBi/ZEJidgnLlqHF1kxPzKkRclXth/CeA==
X-Received: by 2002:adf:e888:0:b0:38d:d932:d9a0 with SMTP id ffacd0b85a97d-38f33f58dc9mr14825233f8f.50.1740045635149;
        Thu, 20 Feb 2025 02:00:35 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:9458:4cb6:ddd6:4840? ([2001:8b0:aba:5f3c:9458:4cb6:ddd6:4840])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5923sm20325315f8f.74.2025.02.20.02.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 02:00:34 -0800 (PST)
Message-ID: <2e219db8aa4ecc884396dbdbf73834ef8317638f.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] 'vendor' fetching discussion cont.
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>, 
	openembedded-core@lists.openembedded.org, Bruce Ashfield	
 <bruce.ashfield@gmail.com>, bitbake-devel
 <bitbake-devel@lists.openembedded.org>
Date: Thu, 20 Feb 2025 10:00:33 +0000
In-Reply-To: <0e604b52-e25b-4dd1-98b0-554af2c743e7@weidmueller.com>
References: 
	<4cea4488ef3181471373f3dca26ac390203a90cb.camel@linuxfoundation.org>
	 <55925709-d3e9-49c8-a6fc-f97c611146cc@weidmueller.com>
	 <d30c619392f62f2d40320b01da5ca95369f3e7c2.camel@linuxfoundation.org>
	 <9668ba9a-4029-4600-abd1-0f32215aaedd@weidmueller.com>
	 <7537c9d9305dd3c7d05cbf36bccfe47c1858f822.camel@linuxfoundation.org>
	 <c2f481ae-327e-43c5-92f5-9753bd5c0138@weidmueller.com>
	 <e145b324f19953f80163dbfe8c403607e297bad0.camel@linuxfoundation.org>
	 <0e604b52-e25b-4dd1-98b0-554af2c743e7@weidmueller.com>
Content-Type: multipart/alternative; boundary="=-iXzvDSlpvusdcAvmelfQ"
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Feb 2025 10:00:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17251

--=-iXzvDSlpvusdcAvmelfQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-02-20 at 10:48 +0100, Stefan Herbrechtsmeier wrote:
> =20
> Am 19.02.2025 um 18:33 schrieb Richard Purdie:
> >=20
> > On Wed, 2025-02-19 at 17:48 +0100, Stefan Herbrechtsmeier wrote:
> > > =20
> > > =20
> > > =20
> > > I don't change the exception. The exceptions are the reason for
> > > the state of the series.
> > > =20
> > >=20
> > > The missing point is that the expectation is related to the end
> > > of a dependency chain and not to a task itself. In any case the
> > > real expectation isn't clear. What happens if the configuration
> > > need a compiled source and it isn't feasible to create a native
> > > package. My series satisfy the following expectations:
> > >=20
> > > * All sources are downloaded after the do_fetch
> > > * All sources are unpacked after the do_unpack
> > > * All sources are patched after the do_patch
> > > =20
> > =20
> > I could try and reply to all your points but this one jumps out as
> > a really fundamental thing we disagree on. All our existing code
> > assumes that:
> > =20
> >=20
> > =20
> > =20
> > "All sources are downloaded during do_fetch"
> >=20
> > =20
> >=20
> > =20
> > =20
> > which means once do_fetch runs, we have all the sources. That is
> > quite different to what you say above. I fully appreciate it
> > imposes quite some constraints but it doesn't change the fact that
> > this is the situation.
> > =20
> =20
> I don't get the point. Do you say that only the do_fetch is allow to
> download anything? So my assumption that I can download something
> outside the do_fetch task as long as the download happens if
> something depend on the fetch task (like bitbake -c fetch ...) is
> wrong?
>=20
> I don't understand that requirement but I can fulfill it. The only
> consequence is a complex do_fetch task.

The fetch task is the only task allowed to access the network and is
the only place where the sources should be being downloaded. Once the
do_fetch task completes, we have everything we need from the network
and no further network access is allowed.

So yes, your assumption is therefore wrong. I'm focusing on this as if
we don't have that common understanding, nothing built upon those
different understandings is going to work.

> > > > =20
> > > > I have tried to seek help from the people who effectively oversee m=
e as
> > > > =20
> > > > a maintainer (i.e. the TSC) with limited success. I'm not sure what=
 to
> > > > =20
> > > > do from here.
> > > > =20
> > > > =20
> > > > =20
> > > =20
> > > =20
> > > =20
> > > I really like to upstream my work because I think it would
> > > simplify the package manager support, but there doesn't seem to
> > > be much interest in the community for it.
> > > =20
> > > =20
> > > =20
> > =20
> > People are too focused in their own problems to be able to spend
> > enough time on these architectural type pieces. We do badly need
> > this kind of work which is why I'm trying to help this move forward
> > but equally we have to do it in a way which doesn't destablise our
> > existing userbase, in other words we may have to make some
> > compromises. I'd like to hope we pick the right ones. I'm worried
> > as we have tried solutions for this space before and the fact we're
> > discussing them again shows we haven't got it right yet.
> > =20
> =20
> I always try my best to not break existing users. Therefore I keep
> the old behavior of the existing tasks or function calls. But we need
> to sharpen the concepts and unify the code base. We have different
> solutions (like go-vendor.bbclass and gomod.py) for the same problem
> and partial integration of features (like expanded_urldata).
>=20
> I think we have to much theoretical discussion and to less code. I
> would like to integrate a Fetcher OE library to remove the redundant
> code, unify the codebase and use the extended URIs where appropriate.
> This would fix some existing problems and could help in the next step
> independence of the solution. Would that be okay with you?

It would not be okay at all, no.=C2=A0

I appreciate theoretical discussion is hard work but we've tried taking
patches in the past and we've ended up making things worse. I can tell
the direction you've been going isn't correct and is going to lead to
patches which are unable to be merged.

I've made it very very clear that the fetch module stays in bitbake and
that we need to find a way to support this in the fetch module, not OE.
Yes, that complicates things unfortunately but I have good reasons for
doing it, whether you understand or agree with them or not. I'm not
changing my mind on this.

I will say your original patch series against bitbake was probably a
lot closer to what I think we probably need. I didn't like the "magic"
going on to extend the data so perhaps if that piece were reworked and
made a more default/simpler/clearer part of the fetcher rather than
hidden, we'd probably reach some code we could agree on.

Cheers,

Richard


> =20


--=-iXzvDSlpvusdcAvmelfQ
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
  <body><div>On Thu, 2025-02-20 at 10:48 +0100, Stefan Herbrechtsmeier wrot=
e:</div><blockquote type=3D"cite" style=3D"margin:0 0 0 .8ex; border-left:2=
px #729fcf solid;padding-left:1ex"><div> </div><div class=3D"moz-cite-prefi=
x">Am 19.02.2025 um 18:33 schrieb Richard Purdie:</div><blockquote type=3D"=
cite" cite=3D"mid:e145b324f19953f80163dbfe8c403607e297bad0.camel@linuxfound=
ation.org" style=3D"margin:0 0 0 .8ex; border-left:2px #729fcf solid;paddin=
g-left:1ex"><div> <style>pre,code,address { margin: 0px; }h1,h2,h3,h4,h5,h6=
 { margin-top: 0.2em; margin-bottom: 0.2em; }ol,ul { margin-top: 0em; margi=
n-bottom: 0em; }blockquote { margin-top: 0em; margin-bottom: 0em; }</style>=
 </div><div>On Wed, 2025-02-19 at 17:48 +0100, Stefan Herbrechtsmeier wrote=
:</div><blockquote type=3D"cite" style=3D"margin:0 0 0 .8ex; border-left:2p=
x #729fcf solid;padding-left:1ex"><div> </div><div> </div><div> </div><div =
class=3D"moz-cite-prefix">I don't change the exception. The exceptions are =
the reason for the state of the series.</div><div> </div><p> <br> The missi=
ng point is that the expectation is related to the end of a dependency chai=
n and not to a task itself. In any case the real expectation isn't clear. W=
hat happens if the configuration need a compiled source and it isn't feasib=
le to create a native package. My series satisfy the following expectations=
:<br> <br> * All sources are downloaded after the do_fetch<br> * All source=
s are unpacked after the do_unpack<br> * All sources are patched after the =
do_patch</p><div> </div></blockquote><div> </div><div>I could try and reply=
 to all your points but this one jumps out as a really fundamental thing we=
 disagree on. All our existing code assumes that:</div><div> </div><div><br=
> </div><div> </div><div>"All sources are downloaded during do_fetch"<br> <=
br> </div><div> </div><div><br> </div><div> </div><div>which means once do_=
fetch runs, we have all the sources. That is quite different to what you sa=
y above. I fully appreciate it imposes quite some constraints but it doesn'=
t change the fact that this is the situation.<br> </div><div> </div></block=
quote><div> </div><p>I don't get the point. Do you say that only the do_fet=
ch is allow to download anything? So my assumption that I can download some=
thing outside the do_fetch task as long as the download happens if somethin=
g depend on the fetch task (like bitbake -c fetch ...) is wrong?<br> <br> I=
 don't understand that requirement but I can fulfill it. The only consequen=
ce is a complex do_fetch task.</p></blockquote><div><br></div><div>The fetc=
h task is the only task allowed to access the network and is the only place=
 where the sources should be being downloaded. Once the do_fetch task compl=
etes, we have everything we need from the network and no further network ac=
cess is allowed.</div><div><br></div><div>So yes, your assumption is theref=
ore wrong. I'm focusing on this as if we don't have that common understandi=
ng, nothing built upon those different understandings is going to work.</di=
v><div><br></div><blockquote type=3D"cite" style=3D"margin:0 0 0 .8ex; bord=
er-left:2px #729fcf solid;padding-left:1ex"><blockquote type=3D"cite" cite=
=3D"mid:e145b324f19953f80163dbfe8c403607e297bad0.camel@linuxfoundation.org"=
 style=3D"margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex=
"><blockquote type=3D"cite" style=3D"margin:0 0 0 .8ex; border-left:2px #72=
9fcf solid;padding-left:1ex"><blockquote type=3D"cite" cite=3D"mid:7537c9d9=
305dd3c7d05cbf36bccfe47c1858f822.camel@linuxfoundation.org" style=3D"margin=
:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex"><div> </div><p=
re>I have tried to seek help from the people who effectively oversee me as<=
/pre><div> </div><pre>a maintainer (i.e. the TSC) with limited success. I'm=
 not sure what to</pre><div> </div><pre>do from here.</pre><div> </div><div=
> </div><div> </div></blockquote><div> </div><div> </div><div> </div><p>I r=
eally like to upstream my work because I think it would simplify the packag=
e manager support, but there doesn't seem to be much interest in the commun=
ity for it.</p><div> </div><div> </div><div> </div></blockquote><div> </div=
><div>People are too focused in their own problems to be able to spend enou=
gh time on these architectural type pieces. We do badly need this kind of w=
ork which is why I'm trying to help this move forward but equally we have t=
o do it in a way which doesn't destablise our existing userbase, in other w=
ords we may have to make some compromises. I'd like to hope we pick the rig=
ht ones. I'm worried as we have tried solutions for this space before and t=
he fact we're discussing them again shows we haven't got it right yet.<br> =
</div><div> </div></blockquote><div> </div><p>I always try my best to not b=
reak existing users. Therefore I keep the old behavior of the existing task=
s or function calls. But we need to sharpen the concepts and unify the code=
 base. We have different solutions (like go-vendor.bbclass and gomod.py) fo=
r the same problem and partial integration of features (like expanded_urlda=
ta).<br> <br> I think we have to much theoretical discussion and to less co=
de. I would like to integrate a Fetcher OE library to remove the redundant =
code, unify the codebase and use the extended URIs where appropriate. This =
would fix some existing problems and could help in the next step independen=
ce of the solution. Would that be okay with you?<br> </p></blockquote><div>=
<br></div><div>It would not be okay at all, no.&nbsp;</div><div><br></div><=
div>I appreciate theoretical discussion is hard work but we've tried taking=
 patches in the past and we've ended up making things worse. I can tell the=
 direction you've been going isn't correct and is going to lead to patches =
which are unable to be merged.</div><div><br></div><div>I've made it very v=
ery clear that the fetch module stays in bitbake and that we need to find a=
 way to support this in the fetch module, not OE. Yes, that complicates thi=
ngs unfortunately but I have good reasons for doing it, whether you underst=
and or agree with them or not. I'm not changing my mind on this.</div><div>=
<br></div><div>I will say your original patch series against bitbake was pr=
obably a lot closer to what I think we probably need. I didn't like the "ma=
gic" going on to extend the data so perhaps if that piece were reworked and=
 made a more default/simpler/clearer part of the fetcher rather than hidden=
, we'd probably reach some code we could agree on.</div><div><br></div><div=
>Cheers,</div><div><br></div><div>Richard</div><div><br></div><div><br></di=
v><blockquote type=3D"cite" style=3D"margin:0 0 0 .8ex; border-left:2px #72=
9fcf solid;padding-left:1ex"><div> </div></blockquote><div><br></div><div><=
span></span></div></body></html>

--=-iXzvDSlpvusdcAvmelfQ--

