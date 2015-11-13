Return-Path: <liu.ming50@gmail.com>
Received: from mail-yk0-f175.google.com (mail-yk0-f175.google.com
	[209.85.160.175])
	by mail.openembedded.org (Postfix) with ESMTP id 9E32A7732B
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Nov 2015 18:24:51 +0000 (UTC)
Received: by ykdr82 with SMTP id r82so160838910ykd.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Nov 2015 10:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=Qi+8Wwm/dFre0tNI9DOcMqwjkxVmI18BggYLY5HXS7s=;
	b=w1ZLrWdRTkUdRzsQ6IQ48xUTp6NHwOw+JX8pYGVxi9hvWYbED35wwn+ChCRhkePMbA
	Epd5byfNonxui5JnaGsUAdZ/LjEUL5n9nePQucdQk0wfKIBC/DM+o7e532Z+osooiG4j
	bfoZJzY8WdK68jPcMKSkIUQS9v2fuM/fMEvC2Dn4GQb6IlXlhROz8Hgc1pHWP1TIyrEG
	z5R8plQcE+ComUKC/8XkeXis3z09cdPPlzAUHWMH6b2k7pHh1sorYe8Tdribj/8kFZ90
	pWteZ7WVgf9N3dLACD8kygruIE1eIdMQB28dooy9uyN7C8d1d2QbzNWV6NrxNntmSRot
	T45w==
MIME-Version: 1.0
X-Received: by 10.129.31.195 with SMTP id f186mr22811612ywf.204.1447439091402; 
	Fri, 13 Nov 2015 10:24:51 -0800 (PST)
Received: by 10.31.30.204 with HTTP; Fri, 13 Nov 2015 10:24:51 -0800 (PST)
In-Reply-To: <1444032447.5118.2.camel@linuxfoundation.org>
References: <1443445902-32608-1-git-send-email-liu.ming50@gmail.com>
	<CABcZANkWo=s5VDpO0nAs42q8Cv+sfhNeu7qsv+XBckEQFQZy7Q@mail.gmail.com>
	<1444032447.5118.2.camel@linuxfoundation.org>
Date: Fri, 13 Nov 2015 19:24:51 +0100
Message-ID: <CALatG=5hzfF2EPCUtjDEPHzjAaY+Z+j470=VQ3wTW80qGGeoQg@mail.gmail.com>
From: Ming Liu <liu.ming50@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	Christopher Larson <clarson@kergoth.com>,
	Peter Liu <peter.x.liu@external.atlascopco.com>
Subject: Re: [OE-core] [PATCH] bitbake: fetch: Extend subdir unpack parameter to local folder
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
X-List-Received-Date: Fri, 13 Nov 2015 18:24:55 -0000
Content-Type: multipart/alternative; boundary=001a1141f0aee0929e0524702c2e

--001a1141f0aee0929e0524702c2e
Content-Type: text/plain; charset=UTF-8

Hi, Christopher, Richard:

Thanks for the reviewing! And sorry to this delayed feedback, I was on a
vacation.
I had send another patch set which tweaked the code like Christopher
suggested, and added a test case for it.

the best,
thank you

2015-10-05 10:07 GMT+02:00 Richard Purdie <
richard.purdie@linuxfoundation.org>:

> On Sat, 2015-10-03 at 11:35 -0700, Christopher Larson wrote:
> >
> > On Mon, Sep 28, 2015 at 6:11 AM, Ming Liu <liu.ming50@gmail.com>
> > wrote:
> >         +                    if urldata.parm.get('subdir') != None:
> >         +                        destdir = urldata.parm.get('subdir')
> >         + "/" + destdir
> >
> > If you really care about the difference between None and the empty
> > string, then this should be 'is not None', not '!= None', but most
> > likely you don't, in which case 'if urldata.parm.get('subdir')' is
> > sufficient, and cleaner. Also you do the parm.get() twice, it may be
> > better to store that in a variable.
>
> Chris is correct, this patch needs tweaking. This area of the code also
> keeps seeing various issues so I'd like to ask that we add a test case
> for this in lib/bb/tests/ so we can ensure this doesn't regress in the
> future please.
>
> Cheers,
>
> Richard
>
>
>

--001a1141f0aee0929e0524702c2e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>Hi, Christopher, Richard:<br><br></div=
>Thanks for the reviewing! And sorry to this delayed feedback, I was on a v=
acation.<br></div>I had send another patch set which tweaked the code like =
Christopher suggested, and added a test case for it.<br><br></div>the best,=
<br></div>thank you<br></div><div class=3D"gmail_extra"><br><div class=3D"g=
mail_quote">2015-10-05 10:07 GMT+02:00 Richard Purdie <span dir=3D"ltr">&lt=
;<a href=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">ri=
chard.purdie@linuxfoundation.org</a>&gt;</span>:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex"><span class=3D"">On Sat, 2015-10-03 at 11:35 -0700, Christopher Lar=
son wrote:<br>
&gt;<br>
&gt; On Mon, Sep 28, 2015 at 6:11 AM, Ming Liu &lt;<a href=3D"mailto:liu.mi=
ng50@gmail.com">liu.ming50@gmail.com</a>&gt;<br>
&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if urldata.parm.get(&#39;subdir&#39;) !=
=3D None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 destdir =3D urldata.parm.g=
et(&#39;subdir&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+ &quot;/&quot; + destdir<br>
&gt;<br>
&gt; If you really care about the difference between None and the empty<br>
&gt; string, then this should be &#39;is not None&#39;, not &#39;!=3D None&=
#39;, but most<br>
&gt; likely you don&#39;t, in which case &#39;if urldata.parm.get(&#39;subd=
ir&#39;)&#39; is<br>
&gt; sufficient, and cleaner. Also you do the parm.get() twice, it may be<b=
r>
&gt; better to store that in a variable.<br>
<br>
</span>Chris is correct, this patch needs tweaking. This area of the code a=
lso<br>
keeps seeing various issues so I&#39;d like to ask that we add a test case<=
br>
for this in lib/bb/tests/ so we can ensure this doesn&#39;t regress in the<=
br>
future please.<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
<br>
</blockquote></div><br></div>

--001a1141f0aee0929e0524702c2e--
