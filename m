Return-Path: <kergoth@gmail.com>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
	[209.85.218.67])
	by mail.openembedded.org (Postfix) with ESMTP id C0B5C7710C
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 17:16:36 +0000 (UTC)
Received: by mail-oi0-f67.google.com with SMTP id b22so4885020oii.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 10:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=G4+0kkuDEF/Iy/zvA6ciQSF0SG71zyqka4bSrqL5b5Q=;
	b=a/MuBCeXSv4yF4ttuApOca8lYC1nAhP8aGgQ+T1Xn24Rj+jQEZ2Ng2lVAzRoREB0Kt
	Y/FtDGo5ibOMENckEerF0I8k6FXGrN+SotcoG3X3+n4iGe5XbRZZvfcvBoGobCejmbfj
	riT3GzsD5w26m9sCToTxp+PtxeGILb4GmS0W2bvImjUI23Yq89uNNe2Fl4Rpq7Zy5xY/
	PUfEAIbtJoeYgdHCcVY3VTF37EmR8Td0eH6JaMZ+NA0TKz2VwnqeVVAeRsZmHDcD6JWC
	n0y6TPYGLLCJDa96zKMy2aSGJYhlOGSBMOAd455zRv4dRhanMAPVnOJkoxDV7JJXczhX
	IZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=G4+0kkuDEF/Iy/zvA6ciQSF0SG71zyqka4bSrqL5b5Q=;
	b=TsGbTfaHgIIz32MmiJOMNkdAFPHlo+0h+03QoJyhL9oKItXEeiBOISBy0xvUWcujuM
	ihHvXKnXYlsIo++iIBJBIkfTqiRbfELtRmiboXc+0chS31/SIoRYnnLg9yGSeiN8pSPZ
	Utplj1J0QbbXxhpAeIIHs5InsM4pMU+IaX0jsPIBAIxUCT2NKaLEBCiAdq8EOZKzrCQ6
	CxAb3EmSoecr606EiwfMD4FMGg/LOVAC4CNrswwqxcvsPMJrtiOpHYv5l5ZfNM19GHsU
	SJa3LrJPiLyVpBLNW5MfZQlCg8kw/nvC1VQ6yJMBRWM2qxyn52TkBErMkQ0W0hGlIipS
	IZMA==
X-Gm-Message-State: AEkooutEBj0KoH44ziSslpMsDVxjth+bXWV2jnIHnNcsZIwPpmagrJOU3dmtEwlGZ/ZflBldPwqvaDTDEC2z+Q==
X-Received: by 10.202.223.132 with SMTP id w126mr1534052oig.20.1471281397206; 
	Mon, 15 Aug 2016 10:16:37 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.157.20.3 with HTTP; Mon, 15 Aug 2016 10:16:16 -0700 (PDT)
In-Reply-To: <1471280319.20391.93.camel@linuxfoundation.org>
References: <1471280319.20391.93.camel@linuxfoundation.org>
From: Christopher Larson <clarson@kergoth.com>
Date: Mon, 15 Aug 2016 10:16:16 -0700
X-Google-Sender-Auth: lbdzFP0WYy2H_qxj8smy6mU26S4
Message-ID: <CABcZANnCFXP4vS70_qitWWHru_RoC1uDzpKNU-Zy5D6JGhXxAQ@mail.gmail.com>
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
X-List-Received-Date: Mon, 15 Aug 2016 17:16:38 -0000
Content-Type: multipart/alternative; boundary=001a113d40be0b9acc053a1f6583

--001a113d40be0b9acc053a1f6583
Content-Type: text/plain; charset=UTF-8

On Mon, Aug 15, 2016 at 9:58 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> +                    if w in self.rq.worker:
> +                        name = "Worker"
> +                    elif w in self.rq.fakeworker:
> +                        name = "Fakeroot"
>

The concept seems sound, but there's still a fair bit of handling which is
do this thing for workers and that thing for fake workers, makes me think
we might want to split out objects to bind the workers, their names, and
their logic.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a113d40be0b9acc053a1f6583
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Mon, Aug 15, 2016 at 9:58 AM, Richard Purdie <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.=
purdie@linuxfoundation.org</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex"><div id=3D":395" class=3D"a3s aXjCH m1568f2430c1fbae9">+=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if w in self.rq=
.worker:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 name =3D &quot;Worker&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif=
 w in self.rq.fakeworker:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 name =3D &quot;Fakeroot&quot;</div></blockquote></div><br>The co=
ncept seems sound, but there&#39;s still a fair bit of handling which is do=
 this thing for workers and that thing for fake workers, makes me think we =
might want to split out objects to bind the workers, their names, and their=
 logic.<br>-- <br><div class=3D"gmail_signature" data-smartmail=3D"gmail_si=
gnature">Christopher Larson<br>clarson at kergoth dot com<br>Founder - BitB=
ake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Software Engi=
neer, Mentor Graphics</div>
</div></div>

--001a113d40be0b9acc053a1f6583--
