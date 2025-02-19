Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B9EC021B0
	for <webhook@archiver.kernel.org>; Wed, 19 Feb 2025 17:33:45 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web11.28460.1739986424131609962
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Feb 2025 09:33:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=bvZjfYWW;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-439950a45daso14159215e9.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 19 Feb 2025 09:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1739986422; x=1740591222; darn=lists.openembedded.org;
        h=mime-version:user-agent:references:in-reply-to:date:to:from:subject
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1yil3Nt3sZDuuFPH9NGhtC0v4zjgLSfAFZ042tIZnT0=;
        b=bvZjfYWWoauSN/HIq0j2ejCUq2kL202UIaICXnNYtLoMpexAJhKwPrsoiCdo55sL9+
         evMg0AzeWcFKVjuTQmOhF0xCqyle5Vds9wM5SZf2QqlkeUAn5Z9+1RQ7nASrVEU3on8B
         M7a+A6LIHEQGi3C6cKLkR/MsCqFj+hlX1aO3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739986422; x=1740591222;
        h=mime-version:user-agent:references:in-reply-to:date:to:from:subject
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1yil3Nt3sZDuuFPH9NGhtC0v4zjgLSfAFZ042tIZnT0=;
        b=qUKM5PGjm92h8E05BJQ3kNzas00wd/yOy4/hJYRNdY491c26afv9du8aysjvhgUtiQ
         7gfpg//GXCqxgtcZeTjMHy+Q00byh9DI/DKE81TnTMyBfc/pf+Ln/nOgkbxiaXvOCwfi
         /y1YMyMxKbZ0aSPHZsHR0fk4ursR+DKiokUzJK6CbBSiorWV8HIsT9jjUaDwHIKY9NEe
         MWC8IiKuuOXlsXvFXDamDCaa+cGrTO9D3r8LlOHLb1gwWaXC5T3rvmJCI5T0yGaSFSca
         AnlmR1pSnsBBBf60SshaURdhcfIl+01k68lzG1HwnwQyTldaMLxOFWk+1F0XhPeJubyg
         cIwA==
X-Forwarded-Encrypted: i=1; AJvYcCVtccoTMIA6OerCYTodKEGcYuioUZzUZwWaI4fMoUfvDmjgq8U77voyrGHUAHdqqMkeyM6IzcIFWtL1tDUm@lists.openembedded.org
X-Gm-Message-State: AOJu0Yz9VM0ysfOhwRC822qlq4q5AI4trVJIC0efg3PDEkvB7qtxpLFR
	/6WBCd76vrgafeuX1Ee6zbT53TMsl4KItE0iAxsjb9123kixA6rBUkz2QtuXgC0=
X-Gm-Gg: ASbGncuLtEIjBR79hdX4Q6QyCLbMOD/v7DKGNO7kGRD4oUL0scAYCyJKGdxfuwvuKu3
	rq+JVOenlygNyYCJzyrOhz0WfLuQGzPG8iu2UB8kQTQNQeAdQ+IealYpAlEkn5Zef+xIPNHjt1C
	rZPCKC+wlEfNsMYtMCagkrFKvomBtH3ed93575nqAd72yCVUGAXro8mMfg+MIVLHKTqgnhQsojk
	YRPzhQeq8Da+Tk+6zwOPKG6KP8k+x78gRv5b0bjeknlJHE3KLC/HiXUwFd79RZgO18SwVg8kcYV
	zL87yWiDx6YcfZ8EDsU7Oxw9k1PFJiMabf7SI1w0DZ6L4I5MVtxKmadTdYk/YniDlJzLXHqoOj/
	0RX+B
X-Google-Smtp-Source: AGHT+IF/zuSYph+JYG6atRtHJFhvorP86o+V7pRDVZpdkBFkjPrEnXZUIYTewUrPE5e4NeN4peKN8A==
X-Received: by 2002:a05:600c:190b:b0:439:a1ad:6851 with SMTP id 5b1f17b1804b1-439a1ad6abfmr9306155e9.23.1739986422272;
        Wed, 19 Feb 2025 09:33:42 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:4146:2030:963a:7035? ([2001:8b0:aba:5f3c:4146:2030:963a:7035])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4398937341csm81699545e9.24.2025.02.19.09.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 09:33:40 -0800 (PST)
Message-ID: <e145b324f19953f80163dbfe8c403607e297bad0.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] 'vendor' fetching discussion cont.
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>, 
	openembedded-core@lists.openembedded.org, Bruce Ashfield	
 <bruce.ashfield@gmail.com>, bitbake-devel
 <bitbake-devel@lists.openembedded.org>
Date: Wed, 19 Feb 2025 17:33:38 +0000
In-Reply-To: <c2f481ae-327e-43c5-92f5-9753bd5c0138@weidmueller.com>
References: 
	<4cea4488ef3181471373f3dca26ac390203a90cb.camel@linuxfoundation.org>
	 <55925709-d3e9-49c8-a6fc-f97c611146cc@weidmueller.com>
	 <d30c619392f62f2d40320b01da5ca95369f3e7c2.camel@linuxfoundation.org>
	 <9668ba9a-4029-4600-abd1-0f32215aaedd@weidmueller.com>
	 <7537c9d9305dd3c7d05cbf36bccfe47c1858f822.camel@linuxfoundation.org>
	 <c2f481ae-327e-43c5-92f5-9753bd5c0138@weidmueller.com>
Content-Type: multipart/alternative; boundary="=-kfxGgEbfZhDPphS37CLb"
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Feb 2025 17:33:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17249

--=-kfxGgEbfZhDPphS37CLb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-02-19 at 17:48 +0100, Stefan Herbrechtsmeier wrote:
> =20
> I don't change the exception. The exceptions are the reason for the
> state of the series.
>=20
> The missing point is that the expectation is related to the end of a
> dependency chain and not to a task itself. In any case the real
> expectation isn't clear. What happens if the configuration need a
> compiled source and it isn't feasible to create a native package. My
> series satisfy the following expectations:
>=20
> * All sources are downloaded after the do_fetch
> * All sources are unpacked after the do_unpack
> * All sources are patched after the do_patch
I could try and reply to all your points but this one jumps out as a
really fundamental thing we disagree on. All our existing code assumes
that:

"All sources are downloaded during do_fetch"

which means once do_fetch runs, we have all the sources. That is quite
different to what you say above. I fully appreciate it imposes quite
some constraints but it doesn't change the fact that this is the
situation.

> WIP:
>=20
> do_fetch : run_fetch,
> run_early_fetch,=C2=A0run_early_unpack,=C2=A0run_early_patch,=C2=A0run_re=
solve,
> run_vendor_fetch
> do_unpack: run_unpack, run_early_unpack, run_vendor_fetch
> do_patch: run_patch, run_early_patch, run_vendor_patch=20
>=20
> The bitbake approach looks like the WIP but makes the run_early_patch
> complicated or impossible.

Which is why I'm saying that I'd prefer to do this in bitbake and if we
have to drop that patching as a result, so be it.


> >  whether we need to have some kind of
> > checksum to verify the "lockfile" is correct as originally intended in
> > the recipe and probably more.
> > =20
> I want to prevent us from having the wrong motivation due to a lack
> of understanding of the lock file. Why don't we add a look file
> across all expanded URIs, regardless of the source of the URI,
> because we could have the same problems in the other fetchers.
>=20
>=20
> > =20
> > I'm in the position of trying to mediate things (i.e. see the different
> > viewpoints and bring people together, trying to find common ground) and
> > yet at the same time, express views as someone who as spent a lot of
> > years trying to maintain and improve this code.
> > =20
> I appreciate your work.
>=20
> But I sometimes have the feeling that the code is a patchwork quilt
> and every attempt to replace several patches with something common is
> met with rejection.


We have a patchwork where people trust the current boundaries between
the different pieces. You want to change the boundaries, and the
assumptions made about those boundaries and replace it with something
that isn't going to be easily understood by most of the userbase as the
concepts are complex and break the existing models people work with.
I'm doing my best to explain the problem but either I'm failing at that
or we simply disagree on them.

> > I have tried to seek help from the people who effectively oversee me as
> > a maintainer (i.e. the TSC) with limited success. I'm not sure what to
> > do from here.
> > =20
> =20
> I really like to upstream my work because I think it would simplify
> the package manager support, but there doesn't seem to be much
> interest in the community for it.
> =20
People are too focused in their own problems to be able to spend enough
time on these architectural type pieces. We do badly need this kind of
work which is why I'm trying to help this move forward but equally we
have to do it in a way which doesn't destablise our existing userbase,
in other words we may have to make some compromises. I'd like to hope
we pick the right ones. I'm worried as we have tried solutions for this
space before and the fact we're discussing them again shows we haven't
got it right yet.

Cheers,

Richard



--=-kfxGgEbfZhDPphS37CLb
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
  <body><div>On Wed, 2025-02-19 at 17:48 +0100, Stefan Herbrechtsmeier wrot=
e:</div><blockquote type=3D"cite" style=3D"margin:0 0 0 .8ex; border-left:2=
px #729fcf solid;padding-left:1ex"><div> </div><div class=3D"moz-cite-prefi=
x">I don't change the exception. The exceptions are the reason for the stat=
e of the series.</div><p> <br> The missing point is that the expectation is=
 related to the end of a dependency chain and not to a task itself. In any =
case the real expectation isn't clear. What happens if the configuration ne=
ed a compiled source and it isn't feasible to create a native package. My s=
eries satisfy the following expectations:<br> <br> * All sources are downlo=
aded after the do_fetch<br> * All sources are unpacked after the do_unpack<=
br> * All sources are patched after the do_patch</p></blockquote><div>I cou=
ld try and reply to all your points but this one jumps out as a really fund=
amental thing we disagree on. All our existing code assumes that:</div><div=
><br></div><div>"All sources are downloaded during do_fetch"</div><div><br>=
</div><div>which means once do_fetch runs, we have all the sources. That is=
 quite different to what you say above. I fully appreciate it imposes quite=
 some constraints but it doesn't change the fact that this is the situation=
.</div><div><br></div><blockquote type=3D"cite" style=3D"margin:0 0 0 .8ex;=
 border-left:2px #729fcf solid;padding-left:1ex"><p>WIP:<br> <br> do_fetch =
: run_fetch, run_early_fetch,&nbsp;run_early_unpack,&nbsp;run_early_patch,&=
nbsp;run_resolve, run_vendor_fetch<br> do_unpack: run_unpack, run_early_unp=
ack, run_vendor_fetch<br> do_patch: run_patch, run_early_patch, run_vendor_=
patch <br> <br> The bitbake approach looks like the WIP but makes the run_e=
arly_patch complicated or impossible.</p></blockquote><div><br></div><div>W=
hich is why I'm saying that I'd prefer to do this in bitbake and if we have=
 to drop that patching as a result, so be it.</div><div><br></div><div><br>=
</div><blockquote type=3D"cite" style=3D"margin:0 0 0 .8ex; border-left:2px=
 #729fcf solid;padding-left:1ex"><blockquote type=3D"cite" cite=3D"mid:7537=
c9d9305dd3c7d05cbf36bccfe47c1858f822.camel@linuxfoundation.org" style=3D"ma=
rgin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex"><pre> whet=
her we need to have some kind of</pre><pre>checksum to verify the "lockfile=
" is correct as originally intended in</pre><pre>the recipe and probably mo=
re.</pre><div> </div></blockquote><div> I want to prevent us from having th=
e wrong motivation due to a lack of understanding of the lock file. Why don=
't we add a look file across all expanded URIs, regardless of the source of=
 the URI, because we could have the same problems in the other fetchers.<br=
> <br> <br></div><blockquote type=3D"cite" cite=3D"mid:7537c9d9305dd3c7d05c=
bf36bccfe47c1858f822.camel@linuxfoundation.org" style=3D"margin:0 0 0 .8ex;=
 border-left:2px #729fcf solid;padding-left:1ex"><div> </div><pre>I'm in th=
e position of trying to mediate things (i.e. see the different</pre><pre>vi=
ewpoints and bring people together, trying to find common ground) and</pre>=
<pre>yet at the same time, express views as someone who as spent a lot of</=
pre><pre>years trying to maintain and improve this code.</pre><div> </div><=
/blockquote><div> I appreciate your work.<br> <br> But I sometimes have the=
 feeling that the code is a patchwork quilt and every attempt to replace se=
veral patches with something common is met with rejection.</div></blockquot=
e><div><br></div><div><br></div><div>We have a patchwork where people trust=
 the current boundaries between the different pieces. You want to change th=
e boundaries, and the assumptions made about those boundaries and replace i=
t with something that isn't going to be easily understood by most of the us=
erbase as the concepts are complex and break the existing models people wor=
k with. I'm doing my best to explain the problem but either I'm failing at =
that or we simply disagree on them.</div><div><br></div><blockquote type=3D=
"cite" style=3D"margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-le=
ft:1ex"><blockquote type=3D"cite" cite=3D"mid:7537c9d9305dd3c7d05cbf36bccfe=
47c1858f822.camel@linuxfoundation.org" style=3D"margin:0 0 0 .8ex; border-l=
eft:2px #729fcf solid;padding-left:1ex"><pre>I have tried to seek help from=
 the people who effectively oversee me as</pre><pre>a maintainer (i.e. the =
TSC) with limited success. I'm not sure what to</pre><pre>do from here.</pr=
e><div> </div></blockquote><div> </div><p>I really like to upstream my work=
 because I think it would simplify the package manager support, but there d=
oesn't seem to be much interest in the community for it.</p><div> </div></b=
lockquote><div>People are too focused in their own problems to be able to s=
pend enough time on these architectural type pieces. We do badly need this =
kind of work which is why I'm trying to help this move forward but equally =
we have to do it in a way which doesn't destablise our existing userbase, i=
n other words we may have to make some compromises. I'd like to hope we pic=
k the right ones. I'm worried as we have tried solutions for this space bef=
ore and the fact we're discussing them again shows we haven't got it right =
yet.</div><div><br></div><div>Cheers,</div><div><br>Richard</div><div><br><=
/div><div><br></div><div><span></span></div></body></html>

--=-kfxGgEbfZhDPphS37CLb--

