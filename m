Return-Path: <alexandru.damian@intel.com>
Received: from mail-ob0-f170.google.com (mail-ob0-f170.google.com
	[209.85.214.170])
	by mail.openembedded.org (Postfix) with ESMTP id 4A1FA6B523
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Apr 2014 10:11:15 +0000 (UTC)
Received: by mail-ob0-f170.google.com with SMTP id uz6so6374760obc.29
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 07 Apr 2014 03:11:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=n0podK+8PwDUJOVYDAYq2+Fnnm/IRTP1tIlaZgFmaAw=;
	b=Z84v1AA460lQBzv7gjtsPlXObExJG62zG9geos/80+S/nm9jYrZWH2WewVzqhwMIQn
	b6OHqTcFTIRJC0W2DHqm5OeTgIMQ4f+LsnGBD6mBFu/yonpWojj3sqEJ8bqGssv7HznN
	nROV63BNehvm0cx1rmTsMSdXHS3561LaqAjJX+v7HdTQw9pRXM9duoAgIfuJSExoWzY+
	uaT+o0McSzF0aKvVoaQPRJgvL8wH/yC68se9jkslflQo5C0iGi9cNsDE7nBTmeh8Dv89
	jYmAYSn04xF5IOrmW9Pw3RIhtBXkixYhUmTE1U8jf1O12PBafnNJEvNNuhjju6vT5wXe
	J3hw==
X-Gm-Message-State: ALoCoQkVelLUIvjXNvk8uqX0creD+q0L+Bh/waSlTdPMlfeCBXFE11iNUaTGULM9FUotRTY8WDHb
X-Received: by 10.182.66.202 with SMTP id h10mr11533204obt.38.1396865476414;
	Mon, 07 Apr 2014 03:11:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.11.165 with HTTP; Mon, 7 Apr 2014 03:10:56 -0700 (PDT)
In-Reply-To: <2189102.coGc3LNv3A@peggleto-mobl5.ger.corp.intel.com>
References: <c0b41b6763e049cd67b1b8038d85c49482557773.1396620556.git.alexandru.damian@intel.com>
	<8ab63a668e94e4179850e4e8d901e719d071d3bc.1396620556.git.alexandru.damian@intel.com>
	<2189102.coGc3LNv3A@peggleto-mobl5.ger.corp.intel.com>
From: "Damian, Alexandru" <alexandru.damian@intel.com>
Date: Mon, 7 Apr 2014 11:10:56 +0100
Message-ID: <CAJ2CSBuemEO6Sy_K6-uW9hjRCEEdbk5KVogaZY8LKbUVyHZ+zg@mail.gmail.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 03/14] toaster: do not load all available timezones
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
X-List-Received-Date: Mon, 07 Apr 2014 10:11:17 -0000
Content-Type: multipart/alternative; boundary=089e0160c34e8563af04f67116eb

--089e0160c34e8563af04f67116eb
Content-Type: text/plain; charset=UTF-8

Thank you for spotting this,

New patch will be sent with the next submission.

Thanks,
Alex


On Fri, Apr 4, 2014 at 4:20 PM, Paul Eggleton <paul.eggleton@linux.intel.com
> wrote:

> On Friday 04 April 2014 15:10:42 Alex DAMIAN wrote:
> > From: Alexandru DAMIAN <alexandru.damian@intel.com>
> >
> > This patch makes sure that we only load pytz-recognized
> > timezones. Pytz is used to transform the timezone information
> > for the database queries, and needs to be able to deal with
> > the TIME_ZONE value that we set up.
> >
> > [YOCTO #6093]
> >
> > Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
> > ---
> >  lib/toaster/toastermain/settings.py | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/toaster/toastermain/settings.py
> > b/lib/toaster/toastermain/settings.py index e26ee3c..e39b4cb 100644
> > --- a/lib/toaster/toastermain/settings.py
> > +++ b/lib/toaster/toastermain/settings.py
> > @@ -64,7 +64,13 @@ else:
> >      for dirpath, dirnames, filenames in os.walk(ZONEINFOPATH):
> >          for fn in filenames:
> >              filepath = os.path.join(dirpath, fn)
> > -
>  zonefilelist[hashlib.md5(open(filepath).read()).hexdigest()] =
> > filepath.lstrip(ZONEINFOPATH).strip() +            try:
> > +                import pytz
> > +                zonename = filepath.lstrip(ZONEINFOPATH).strip()
> > +                if pytz.timezone(zonename) is not None:
> > +
> > zonefilelist[hashlib.md5(open(filepath).read()).hexdigest()] = zonename
> > +          except Exception:
> > +                pass
>
> Please do not do blanket exception catching like this. You need to catch
> the
> exact class of exception you expect to receive.
>
> Cheers,
> Paul
>
> --
>
> Paul Eggleton
> Intel Open Source Technology Centre
>



-- 
Alex Damian
Yocto Project
SSG / OTC

--089e0160c34e8563af04f67116eb
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:tahoma,s=
ans-serif">Thank you for spotting this,<br><br>New patch will be sent with =
the next submission.<br><br>Thanks,<br>Alex<br></div></div><div class=3D"gm=
ail_extra">

<br><br><div class=3D"gmail_quote">On Fri, Apr 4, 2014 at 4:20 PM, Paul Egg=
leton <span dir=3D"ltr">&lt;<a href=3D"mailto:paul.eggleton@linux.intel.com=
" target=3D"_blank">paul.eggleton@linux.intel.com</a>&gt;</span> wrote:<br>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">

<div class=3D"HOEnZb"><div class=3D"h5">On Friday 04 April 2014 15:10:42 Al=
ex DAMIAN wrote:<br>
&gt; From: Alexandru DAMIAN &lt;<a href=3D"mailto:alexandru.damian@intel.co=
m">alexandru.damian@intel.com</a>&gt;<br>
&gt;<br>
&gt; This patch makes sure that we only load pytz-recognized<br>
&gt; timezones. Pytz is used to transform the timezone information<br>
&gt; for the database queries, and needs to be able to deal with<br>
&gt; the TIME_ZONE value that we set up.<br>
&gt;<br>
&gt; [YOCTO #6093]<br>
&gt;<br>
&gt; Signed-off-by: Alexandru DAMIAN &lt;<a href=3D"mailto:alexandru.damian=
@intel.com">alexandru.damian@intel.com</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0lib/toaster/toastermain/settings.py | 8 +++++++-<br>
&gt; =C2=A01 file changed, 7 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/lib/toaster/toastermain/settings.py<br>
&gt; b/lib/toaster/toastermain/settings.py index e26ee3c..e39b4cb 100644<br=
>
&gt; --- a/lib/toaster/toastermain/settings.py<br>
&gt; +++ b/lib/toaster/toastermain/settings.py<br>
&gt; @@ -64,7 +64,13 @@ else:<br>
&gt; =C2=A0 =C2=A0 =C2=A0for dirpath, dirnames, filenames in os.walk(ZONEIN=
FOPATH):<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for fn in filenames:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0filepath =3D os.path.j=
oin(dirpath, fn)<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0zonefilelist[hashlib.md5(op=
en(filepath).read()).hexdigest()] =3D<br>
&gt; filepath.lstrip(ZONEINFOPATH).strip() + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0try:<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0import pytz<b=
r>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0zonename =3D =
filepath.lstrip(ZONEINFOPATH).strip()<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if pytz.timez=
one(zonename) is not None:<br>
&gt; +<br>
&gt; zonefilelist[hashlib.md5(open(filepath).read()).hexdigest()] =3D zonen=
ame<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except Exception:<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br>
<br>
</div></div>Please do not do blanket exception catching like this. You need=
 to catch the<br>
exact class of exception you expect to receive.<br>
<br>
Cheers,<br>
Paul<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
<br>
Paul Eggleton<br>
Intel Open Source Technology Centre<br>
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br><div dir=
=3D"ltr">Alex Damian<div>Yocto Project<br></div><div>SSG / OTC=C2=A0</div><=
/div>
</div>

--089e0160c34e8563af04f67116eb--
