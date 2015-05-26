Return-Path: <kergoth@gmail.com>
Received: from mail-qk0-f179.google.com (mail-qk0-f179.google.com
	[209.85.220.179])
	by mail.openembedded.org (Postfix) with ESMTP id A2749608B6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 May 2015 15:26:44 +0000 (UTC)
Received: by qkdn188 with SMTP id n188so91965788qkd.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 May 2015 08:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=jso5L5QabEqMZs+WC4vzS7FAI0njxS81YoCYkz/Ds6E=;
	b=Af2+5dUwqfaLrbrlD5UpcV34Y+9pjHNnZ3A6ePhOLB6Sye4mS3hKwMnER4n58SrGQF
	RPjRuf/srGXqMwqbmiZPN5Y3JscTyeY+hJ2QyEGpGxoapl5AUha600wWpdfIq1/jAiwq
	k/Mu+RweIY/yKhET4+JlD7SqkhMfmYc6NPUyRRLQZCr55bfmy6R3fTTfq8tJlkpiT04i
	O8U0GI4NSfNG0rKKNKhbw7Y9Fuu91v/0u2LHVMObCWypfqJLs6x2kI1lkxCHyXsI6ilu
	VqyJ8B7uwqjVfaYx78PKVG2ydO2T98Uj/IPx+HSocfmb6CqL6Yab53uk94rEiriRT21H
	U7sw==
X-Received: by 10.140.165.150 with SMTP id l144mr34937265qhl.99.1432654005659; 
	Tue, 26 May 2015 08:26:45 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.140.108.117 with HTTP; Tue, 26 May 2015 08:26:25 -0700 (PDT)
In-Reply-To: <1432653462.404.12.camel@linuxfoundation.org>
References: <1432653462.404.12.camel@linuxfoundation.org>
From: Christopher Larson <clarson@kergoth.com>
Date: Tue, 26 May 2015 08:26:25 -0700
X-Google-Sender-Auth: 8m7HULuncG11vORprBydA5wMAes
Message-ID: <CABcZAN=t4OFiwpAYT+CD8heNJVZO4s=Y3XOqxkqRvoakTSx=bQ@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] tests/data: Add log parsing test code
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
X-List-Received-Date: Tue, 26 May 2015 15:26:48 -0000
Content-Type: multipart/alternative; boundary=001a1134effa18050d0516fdc1bb

--001a1134effa18050d0516fdc1bb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2015 at 8:17 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> +class LogRecord():
> +    def __enter__(self):
> +        import logging
> +        logs =3D []
> +        class LogHandler(logging.Handler):
> +            def emit(self, record):
> +                logs.append(record)
> +
> +        logger =3D logging.getLogger("BitBake")
> +        handler =3D LogHandler()
> +        logger.addHandler(handler)
> +        return logs
> +    def __exit__(self, type, value, traceback):
> +        return
>

I realize it probably doesn=E2=80=99t matter in the testing case specifical=
ly, but
this lies to the user of the class. Using a context manager that doesn=E2=
=80=99t
undo what it=E2=80=99s done on exit.. :)
--=20
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a1134effa18050d0516fdc1bb
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, May 26, 2015 at 8:17 AM, Richard Purdie <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.=
purdie@linuxfoundation.org</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex"><div id=3D":2j8" class=3D"a3s" style=3D"overflow:hidden">+<span cla=
ss=3D"il">class</span> LogRecord():<br>
+=C2=A0 =C2=A0 def __enter__(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 import logging<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 logs =3D []<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span class=3D"il">class</span> LogHandler(log=
ging.Handler):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 def emit(self, record):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 logs.append(record=
)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 logger =3D logging.getLogger(&quot;<span class=
=3D"il">BitBake</span>&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 handler =3D LogHandler()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 logger.addHandler(handler)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return logs<br>
+=C2=A0 =C2=A0 def __exit__(self, type, value, traceback):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return</div></blockquote></div><br>I realize i=
t probably doesn=E2=80=99t matter in the testing case specifically, but thi=
s lies to the user of the class. Using a context manager that doesn=E2=80=
=99t undo what it=E2=80=99s done on exit.. :)<br>-- <br><div class=3D"gmail=
_signature">Christopher Larson<br>clarson at kergoth dot com<br>Founder - B=
itBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Software E=
ngineer, Mentor Graphics</div>
</div></div>

--001a1134effa18050d0516fdc1bb--
