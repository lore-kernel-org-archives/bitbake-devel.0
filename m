Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
 by mx.groups.io with SMTP id smtpd.web10.135597.1598020167796718646
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Aug 2020 07:29:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=dO1oQkvE;
 spf=pass (domain: gmail.com, ip: 209.85.208.41, mailfrom: maxime.roussinbelanger@gmail.com)
Received: by mail-ed1-f41.google.com with SMTP id df16so1571885edb.9
        for <bitbake-devel@lists.openembedded.org>; Fri, 21 Aug 2020 07:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u1X65eXT1aSIUTMR37fSLuYSKf89EO8XV3CilGDVXUU=;
        b=dO1oQkvEdWoRtHwuZtkH6htvzPbrRxvK9Gt3jiNbprmNz9EhHSzI76OINuxfn1z7mI
         B5BKm41FOIgFJHkJtis8SP+LxJXGTNZqE7LfXNJ3KKcIJhHuSqdVAfPDOsHkSpk8rVTN
         ESU1/6A1hddDqhR+FFL6Kl6NcH7HuHwn8XGYQyDTfI+vZYeFC4WIMwcUK3gL6VeR93Kw
         sRtDC4rtx11yhlGVPvgimPTdYNUyZDmSJC43yGTu+1F/lDXQHhnnipg2A5UYuTClTpzM
         HkJTfJBbTL6mBHTp55h8FuOjBNISZm3IMsRQMh6q7NVf0yHU5xWRUv/yf1p0jjUW3yMo
         k3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u1X65eXT1aSIUTMR37fSLuYSKf89EO8XV3CilGDVXUU=;
        b=Hp2PZn+kj9qnuZPF7U1QBel5PX6sWbwTrQL//DJuQqF4mpSzlm8khy5xc41QFWkpH/
         yoONJ7SxLzwZbCxhcdPg/bDNvKGX8yYBSsnCZadB7vHz1ytKV+0fiSFWNUInRVEFdnRM
         NNYkk7KZPaWr7a0eepQzNww7A5Jauso7rr0vGul27dd6GWAyiVZbv2zzyx/8A07WV2La
         OsPT4AkAxspzK4codqdZSih5Dw7aTbj1eylClxZVvzcj6qwgMenbKhhx/QlJKh0igOdB
         /D+O94UpLLe0HBMsFwWoUg6OYO/Woh+IfFvKfCoQtM1CXuMiRrY2WjZIzHZILFDz+EBd
         rSyA==
X-Gm-Message-State: AOAM5333Flac1uR0s23YcV3T5cIagIJH7NZHfNBxr5dssLYOK4kJESlK
	dbQE/z0fwNr2lWkRg7mNo5Rxom/DBMaz/W/jlx0=
X-Google-Smtp-Source: ABdhPJxMQea5/pryZPtSLo8U9yqIrhZSQ+TjPDPkUMyE+rgDxmkUL6Ut5ygRM74zeiej7eU0VCRD85V/HiZs99crlL8=
X-Received: by 2002:a05:6402:1758:: with SMTP id v24mr3144010edx.274.1598020166009;
 Fri, 21 Aug 2020 07:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200820215000.30818-1-jeff.dagenais@gmail.com>
 <162D4E42F9CDE339.12673@lists.openembedded.org> <606c29630870cb03b87171f1b57e3cfb2c9206ed.camel@linuxfoundation.org>
In-Reply-To: <606c29630870cb03b87171f1b57e3cfb2c9206ed.camel@linuxfoundation.org>
From: =?UTF-8?B?TWF4aW1lIFJvdXNzaW4tQsOpbGFuZ2Vy?= <maxime.roussinbelanger@gmail.com>
Date: Fri, 21 Aug 2020 10:28:59 -0400
Message-ID: <CAE=T-s4c_k541ARhoZ+ny1d5m_C6o8LaL+J9fL+zh2XHH=oDog@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC] siggen: clean_basepath leaks full recipe file path
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Jean-Francois Dagenais <jeff.dagenais@gmail.com>, bitbake-devel@lists.openembedded.org, 
	guillaume.champagne@sonatest.com
Content-Type: multipart/alternative; boundary="00000000000056c69105ad6410ce"

--00000000000056c69105ad6410ce
Content-Type: text/plain; charset="UTF-8"

Hello!

On Fri, Aug 21, 2020 at 10:20 AM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:
>
> On Fri, 2020-08-21 at 15:18 +0100, Richard Purdie via
> lists.openembedded.org wrote:
> > Hi,
> >
> > On Thu, 2020-08-20 at 17:49 -0400, Jean-Francois Dagenais wrote:
> > > While investigating constant mismatches of hashes from our
> > > SSTATE_MIRROR depot,
> > > Maxime and I came across a bitbake-diffsigs which showed a
> > > suspicious
> > > cause for
> > > the mismatch. It appeared to be an underlying taskdeptasks which
> > > contains the
> > > full path of the recipe, which is totally a local build thing.
> > >
> > > After searching for a little while. We came accross the
> > > `clean_basepath(a)`
> > > function in siggen.py. We added prints on it:
> > >
> > > def clean_basepath(a):
> > >     mc = None print('a: ' + a) if a.startswith("mc:"):
> > >         _, mc, a = a.split(":", 2)
> > >     b = a.rsplit("/", 2)[1] + '/' + a.rsplit("/", 2)[2] print('b: '
> > > +
> > > b) if
> > >     a.startswith("virtual:"):
> > >         b = b + ":" + a.rsplit(":", 1)[0]
> > >     if mc:
> > >         b = b + ":mc:" + mc
> > >     print('b+: ' + b) return b
> > >
> > > Sure enough, this looks like the culprit. Consider the following
> > > trace:
> > > a: virtual:native:/full/path/to/poky/meta/recipes-devtools/gnu-
> > > config/gnu-config_git.bb:do_populate_sysroot
> > > b: gnu-config/gnu-config_git.bb:do_populate_sysroot
> > > b+: gnu-config/gnu-
> > > config_git.bb:do_populate_sysroot:virtual:native:/full/path/to/poky
> > > /m
> > > eta/recipes-devtools/gnu-config/gnu-config_git.bb
> > >
> > > Looking at this, it really seems like the intent of the `if
> > > a.startswith("virtual:")` case is to insert only the
> > > `:virtual:native` at the
> > > end.
> > >
> > > The simplest fix we suggest is simply changing `a.rsplit(":",
> > > 1)[0]`
> > > to
> > > `a.rsplit(":", 2)[0]` and causes b+ to become:
> > >
> > > b+: gnu-config/gnu-config_git.bb:do_populate_sysroot:virtual:native
> > >
> > > Since this is so profound and core to the way signatures work,
> > > coupled with the
> > > fact that this code hasn't changed in years, we feel being the ones
> > > to find and
> > > fix this is unlikely.
> > >
> > > Perpahps the content/format of the passed `a` variable has changed
> > > recently?
> > >
> > > The following email is a patch which could be applied if deemed
> > > correct. But please
> > > consider this re-written version:
> > >
> > > def clean_basepath(basepath):
> > >     # basepath is a string like '/full/path/to/recipes-
> > > whatever/helloworld/helloworld_0.1.2.bb:do_compile'
> > >     # or 'virtual:native:/full/path/to/recipes-
> > > whatever/helloworld/helloworld_0.1.2.bb:do_compile'
> > >     # or 'mc:somemachine:/full/path/to/recipes-
> > > whatever/helloworld/helloworld_0.1.2.bb:do_compile'
> > >
> > >     _, parent_dir, recipe_task = basepath.rsplit("/", 2)
> > >     # drop what is left of the second slash, searching from right
> > > to
> > > left
> > >     cleaned = parent_dir + '/' + recipe_task
> > >
> > >     # if there was a 'abc:xyz' prefix, add it to the end
> > >     if not basepath.startswith('/'):
> > >         cleaned += ':' + basepath.split('/', 1)[0].rstrip(':')
> > >
> > >     return cleaned
> > >
> > > Both simple fix and this rewrite were tested with `oe-selftest -r
> > > sstatetests`.
> > >
> > > We feel this version has these advantages:
> > > * improved readablility
> > > * improved efficiency (the split is not repeated twice and function
> > > it has fewer `if`s)
> > > * honours the open/close principle better by not hardcoding
> > > "virtual:" nor "mc:"
> > >
> > > Thanks for your feedback! I will submit this version as a patch if
> > > it
> > > is positive.
> >
> > Well done finding this, the bug has clearly been there a while! I've
> > had a feeling there was something going on somewhere but never found
> > it.
> >
> > I've taken the opportunity to make the code slightly clearer so have
> > written and sent a modified version of your patch. I hope that is ok!
> > Please take a look and let me know if I've missed anything too.
>
> Of course as soon as I send that I realised my patch is wrong since
> virtuals can have multiple entries, which is why this is written
> searching backwards.

Is there a way to add test cases for this? We would like to be able to
write tests for this.

Thanks,
Maxime.

>
> Your patch is therefore the correct one!
>
> Cheers,
>
> Richard

--00000000000056c69105ad6410ce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello!<br><br>On Fri, Aug 21, 2020 at 10:20 AM Richard Pur=
die &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org">richard.purdi=
e@linuxfoundation.org</a>&gt; wrote:<br>&gt;<br>&gt; On Fri, 2020-08-21 at =
15:18 +0100, Richard Purdie via<br>&gt; <a href=3D"http://lists.openembedde=
d.org">lists.openembedded.org</a> wrote:<br>&gt; &gt; Hi,<br>&gt; &gt;<br>&=
gt; &gt; On Thu, 2020-08-20 at 17:49 -0400, Jean-Francois Dagenais wrote:<b=
r>&gt; &gt; &gt; While investigating constant mismatches of hashes from our=
<br>&gt; &gt; &gt; SSTATE_MIRROR depot,<br>&gt; &gt; &gt; Maxime and I came=
 across a bitbake-diffsigs which showed a<br>&gt; &gt; &gt; suspicious<br>&=
gt; &gt; &gt; cause for<br>&gt; &gt; &gt; the mismatch. It appeared to be a=
n underlying taskdeptasks which<br>&gt; &gt; &gt; contains the<br>&gt; &gt;=
 &gt; full path of the recipe, which is totally a local build thing.<br>&gt=
; &gt; &gt;<br>&gt; &gt; &gt; After searching for a little while. We came a=
ccross the<br>&gt; &gt; &gt; `clean_basepath(a)`<br>&gt; &gt; &gt; function=
 in siggen.py. We added prints on it:<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; d=
ef clean_basepath(a):<br>&gt; &gt; &gt; =C2=A0 =C2=A0 mc =3D None print(&#3=
9;a: &#39; + a) if a.startswith(&quot;mc:&quot;):<br>&gt; &gt; &gt; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 _, mc, a =3D a.split(&quot;:&quot;, 2)<br>&gt; &gt; &g=
t; =C2=A0 =C2=A0 b =3D a.rsplit(&quot;/&quot;, 2)[1] + &#39;/&#39; + a.rspl=
it(&quot;/&quot;, 2)[2] print(&#39;b: &#39;<br>&gt; &gt; &gt; +<br>&gt; &gt=
; &gt; b) if<br>&gt; &gt; &gt; =C2=A0 =C2=A0 a.startswith(&quot;virtual:&qu=
ot;):<br>&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 b =3D b + &quot;:&quot;=
 + a.rsplit(&quot;:&quot;, 1)[0]<br>&gt; &gt; &gt; =C2=A0 =C2=A0 if mc:<br>=
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 b =3D b + &quot;:mc:&quot; + mc<=
br>&gt; &gt; &gt; =C2=A0 =C2=A0 print(&#39;b+: &#39; + b) return b<br>&gt; =
&gt; &gt;<br>&gt; &gt; &gt; Sure enough, this looks like the culprit. Consi=
der the following<br>&gt; &gt; &gt; trace:<br>&gt; &gt; &gt; a: virtual:nat=
ive:/full/path/to/poky/meta/recipes-devtools/gnu-<br>&gt; &gt; &gt; config/=
gnu-config_git.bb:do_populate_sysroot<br>&gt; &gt; &gt; b: gnu-config/gnu-c=
onfig_git.bb:do_populate_sysroot<br>&gt; &gt; &gt; b+: gnu-config/gnu-<br>&=
gt; &gt; &gt; config_git.bb:do_populate_sysroot:virtual:native:/full/path/t=
o/poky<br>&gt; &gt; &gt; /m<br>&gt; &gt; &gt; eta/recipes-devtools/gnu-conf=
ig/<a href=3D"http://gnu-config_git.bb">gnu-config_git.bb</a><br>&gt; &gt; =
&gt;<br>&gt; &gt; &gt; Looking at this, it really seems like the intent of =
the `if<br>&gt; &gt; &gt; a.startswith(&quot;virtual:&quot;)` case is to in=
sert only the<br>&gt; &gt; &gt; `:virtual:native` at the<br>&gt; &gt; &gt; =
end.<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; The simplest fix we suggest is sim=
ply changing `a.rsplit(&quot;:&quot;,<br>&gt; &gt; &gt; 1)[0]`<br>&gt; &gt;=
 &gt; to<br>&gt; &gt; &gt; `a.rsplit(&quot;:&quot;, 2)[0]` and causes b+ to=
 become:<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; b+: gnu-config/gnu-config_git.=
bb:do_populate_sysroot:virtual:native<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; S=
ince this is so profound and core to the way signatures work,<br>&gt; &gt; =
&gt; coupled with the<br>&gt; &gt; &gt; fact that this code hasn&#39;t chan=
ged in years, we feel being the ones<br>&gt; &gt; &gt; to find and<br>&gt; =
&gt; &gt; fix this is unlikely.<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; Perpahp=
s the content/format of the passed `a` variable has changed<br>&gt; &gt; &g=
t; recently?<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; The following email is a p=
atch which could be applied if deemed<br>&gt; &gt; &gt; correct. But please=
<br>&gt; &gt; &gt; consider this re-written version:<br>&gt; &gt; &gt;<br>&=
gt; &gt; &gt; def clean_basepath(basepath):<br>&gt; &gt; &gt; =C2=A0 =C2=A0=
 # basepath is a string like &#39;/full/path/to/recipes-<br>&gt; &gt; &gt; =
whatever/helloworld/helloworld_0.1.2.bb:do_compile&#39;<br>&gt; &gt; &gt; =
=C2=A0 =C2=A0 # or &#39;virtual:native:/full/path/to/recipes-<br>&gt; &gt; =
&gt; whatever/helloworld/helloworld_0.1.2.bb:do_compile&#39;<br>&gt; &gt; &=
gt; =C2=A0 =C2=A0 # or &#39;mc:somemachine:/full/path/to/recipes-<br>&gt; &=
gt; &gt; whatever/helloworld/helloworld_0.1.2.bb:do_compile&#39;<br>&gt; &g=
t; &gt;<br>&gt; &gt; &gt; =C2=A0 =C2=A0 _, parent_dir, recipe_task =3D base=
path.rsplit(&quot;/&quot;, 2)<br>&gt; &gt; &gt; =C2=A0 =C2=A0 # drop what i=
s left of the second slash, searching from right<br>&gt; &gt; &gt; to<br>&g=
t; &gt; &gt; left<br>&gt; &gt; &gt; =C2=A0 =C2=A0 cleaned =3D parent_dir + =
&#39;/&#39; + recipe_task<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; =C2=A0 =C2=A0=
 # if there was a &#39;abc:xyz&#39; prefix, add it to the end<br>&gt; &gt; =
&gt; =C2=A0 =C2=A0 if not basepath.startswith(&#39;/&#39;):<br>&gt; &gt; &g=
t; =C2=A0 =C2=A0 =C2=A0 =C2=A0 cleaned +=3D &#39;:&#39; + basepath.split(&#=
39;/&#39;, 1)[0].rstrip(&#39;:&#39;)<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; =
=C2=A0 =C2=A0 return cleaned<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; Both simpl=
e fix and this rewrite were tested with `oe-selftest -r<br>&gt; &gt; &gt; s=
statetests`.<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; We feel this version has t=
hese advantages:<br>&gt; &gt; &gt; * improved readablility<br>&gt; &gt; &gt=
; * improved efficiency (the split is not repeated twice and function<br>&g=
t; &gt; &gt; it has fewer `if`s)<br>&gt; &gt; &gt; * honours the open/close=
 principle better by not hardcoding<br>&gt; &gt; &gt; &quot;virtual:&quot; =
nor &quot;mc:&quot;<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; Thanks for your fee=
dback! I will submit this version as a patch if<br>&gt; &gt; &gt; it<br>&gt=
; &gt; &gt; is positive.<br>&gt; &gt;<br>&gt; &gt; Well done finding this, =
the bug has clearly been there a while! I&#39;ve<br>&gt; &gt; had a feeling=
 there was something going on somewhere but never found<br>&gt; &gt; it.<br=
>&gt; &gt;<br>&gt; &gt; I&#39;ve taken the opportunity to make the code sli=
ghtly clearer so have<br>&gt; &gt; written and sent a modified version of y=
our patch. I hope that is ok!<br>&gt; &gt; Please take a look and let me kn=
ow if I&#39;ve missed anything too.<br>&gt;<br>&gt; Of course as soon as I =
send that I realised my patch is wrong since<br>&gt; virtuals can have mult=
iple entries, which is why this is written<br>&gt; searching backwards.<div=
><br></div><div>Is there a way to add test cases for this? We would like to=
 be able to write tests for this.</div><div><br></div><div>Thanks,</div><di=
v>Maxime.</div><div><br>&gt;<br>&gt; Your patch is therefore the correct on=
e!<br>&gt;<br>&gt; Cheers,<br>&gt;<br>&gt; Richard</div></div>

--00000000000056c69105ad6410ce--
