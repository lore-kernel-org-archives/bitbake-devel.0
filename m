Return-Path: <kergoth@gmail.com>
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com
	[209.85.218.68])
	by mail.openembedded.org (Postfix) with ESMTP id 591C77326D
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 16 Aug 2016 14:59:07 +0000 (UTC)
Received: by mail-oi0-f68.google.com with SMTP id s207so7079490oie.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 16 Aug 2016 07:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=OD8azxbdet4HOMfwKCVMJR73+AOms4cd86BYcUrTOMg=;
	b=0U3suZd7e/WsUIw79KjD+TJRThogT2/7bu2PcTJlMFJ06Nz1GF+jjATxK03vzQR71/
	IHHLicHZsBvIOy3AtitVr9Nr88k3p7CsnG7TsEYIUnpvtWa+MkuRNPD7gnq3F9xGiJmc
	WQL23uIpjMzXQmrTdl/upWTqrTM7bdJItt4fbfroBhf2k4we4XnlTpLLTzIveIf9c7Ct
	jzjp+Y28X4bNZBqxvV5bb8Rk9FNXMQeIs2jZNFhmkIgIaDLWMsePhJBR5Ibbf7Ga+jUG
	r8wtQeLFBenJd2zF+W7HGN5EZz14AMtHKUCT74DSwzwOEXyYRmK3HGe1ela15PMdHBYF
	HvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=OD8azxbdet4HOMfwKCVMJR73+AOms4cd86BYcUrTOMg=;
	b=ZuhDRaYUlD23QULBh5rJwUqc1PTl3YP80YiZ9+m4GALJ8aQXpqVR0/c+3Dg4vGQ3IE
	UEUkRMNq6YYihg6Mu2weoO7sikAME6/by3VgMYYjpmhv4rIbJqMdYk2Q1RQL4A0zdCfJ
	K12pKzcv0e7Djb0DABz2N91PZRGUsCw2zsPb3HPU5iE1zPVWZBSgLsAB7IBOEhcjRadU
	qdiDQ70nlLgVwLryBuRn61h8gjuRda+3ChvJl3r4xlsO7U06JuMAPPkCTPRRhInR6XSn
	1eqlr/9qo2IMwf7VUKqIeRQE+nBq4hyv3Tr1+fLinI7/dXBJ0dX5RLIyKy1XknBjDxN6
	VEEQ==
X-Gm-Message-State: AEkoousZRsJy79nZbFIkftMWvIR5qse8gOJTe7IWSBEY10IzPjU6GJp+vkJM6JpvpLKvCX46g6a1lQ+6BzhOhw==
X-Received: by 10.202.56.85 with SMTP id f82mr20072715oia.33.1471359547649;
	Tue, 16 Aug 2016 07:59:07 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.157.20.3 with HTTP; Tue, 16 Aug 2016 07:58:47 -0700 (PDT)
In-Reply-To: <1471355194.20391.108.camel@linuxfoundation.org>
References: <1471280319.20391.93.camel@linuxfoundation.org>
	<CABcZANnCFXP4vS70_qitWWHru_RoC1uDzpKNU-Zy5D6JGhXxAQ@mail.gmail.com>
	<1471355194.20391.108.camel@linuxfoundation.org>
From: Christopher Larson <clarson@kergoth.com>
Date: Tue, 16 Aug 2016 07:58:47 -0700
X-Google-Sender-Auth: C8arsPrNhJMkfKWNg0uuzCirxQM
Message-ID: <CABcZAN=atN2AiH2m5Am+Cjw_e6dphtM6RX8A1JF+0qDoWN5P=Q@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] runqueue: Abstract worker functionality to an object/array
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
X-List-Received-Date: Tue, 16 Aug 2016 14:59:07 -0000
Content-Type: multipart/alternative; boundary=001a113cc2662cb4f2053a319793

--001a113cc2662cb4f2053a319793
Content-Type: text/plain; charset=UTF-8

On Tue, Aug 16, 2016 at 6:46 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Mon, 2016-08-15 at 10:16 -0700, Christopher Larson wrote:
> >
> > On Mon, Aug 15, 2016 at 9:58 AM, Richard Purdie <
> > richard.purdie@linuxfoundation.org> wrote:
> > > +                    if w in self.rq.worker:
> > > +                        name = "Worker"
> > > +                    elif w in self.rq.fakeworker:
> > > +                        name = "Fakeroot"
> > >
> > The concept seems sound, but there's still a fair bit of handling
> > which is do this thing for workers and that thing for fake workers,
> > makes me think we might want to split out objects to bind the
> > workers, their names, and their logic.
>
> I agree and there is certainly room for improvement. I think the patch
> as it stands is probably a good first step and there are more that can
> be made on top of it, I'm open to them or may get around to it myself
> eventually if nobody else does. Part of the trouble I've had in doing
> this is not to get distracted from the multi-config work which
> necessitated it in the first place!


Agreed. This is a step in the right direction.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a113cc2662cb4f2053a319793
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Aug 16, 2016 at 6:46 AM, Richard Purdie <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.=
purdie@linuxfoundation.org</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex"><span class=3D"">On Mon, 2016-08-15 at 10:16 -0700, Christopher Lar=
son wrote:<br>
&gt;<br>
&gt; On Mon, Aug 15, 2016 at 9:58 AM, Richard Purdie &lt;<br>
&gt; <a href=3D"mailto:richard.purdie@linuxfoundation.org">richard.purdie@<=
wbr>linuxfoundation.org</a>&gt; wrote:<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if w in self.rq.worker:<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 name =3D &quot;Worker&quot;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 elif w in self.rq.fakeworker:<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 name =3D &quot;Fakeroot&quot;<br>
&gt; &gt;<br>
&gt; The concept seems sound, but there&#39;s still a fair bit of handling<=
br>
&gt; which is do this thing for workers and that thing for fake workers,<br=
>
&gt; makes me think we might want to split out objects to bind the<br>
&gt; workers, their names, and their logic.<br>
<br>
</span>I agree and there is certainly room for improvement. I think the pat=
ch<br>
as it stands is probably a good first step and there are more that can<br>
be made on top of it, I&#39;m open to them or may get around to it myself<b=
r>
eventually if nobody else does. Part of the trouble I&#39;ve had in doing<b=
r>
this is not to get distracted from the multi-config work which<br>
necessitated it in the first place!</blockquote></div><br>Agreed. This is a=
 step in the right direction.<br>-- <br><div class=3D"gmail_signature" data=
-smartmail=3D"gmail_signature">Christopher Larson<br>clarson at kergoth dot=
 com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<b=
r>Senior Software Engineer, Mentor Graphics</div>
</div></div>

--001a113cc2662cb4f2053a319793--
