Return-Path: <raj.khem@gmail.com>
Received: from mail-qg0-f46.google.com (mail-qg0-f46.google.com
	[209.85.192.46])
	by mail.openembedded.org (Postfix) with ESMTP id AED1B6FEE0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Apr 2016 06:08:31 +0000 (UTC)
Received: by mail-qg0-f46.google.com with SMTP id j35so35597749qge.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Apr 2016 23:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc; bh=4amKvYVUdLRYhyK+CxSZ0Pil5R7eL41bjTR3VAiA4xc=;
	b=MJhRXfoq2rXVpdrRuadezirkn5UiFxrimEu0gNdsnu0dd6+6GOm6bA8GJz5azu9rAi
	6fVuhKu66r7Dqtpu0ZVtr2Tbbydt/MfJXbykxBIwVGPHtzyXUctFDmDhI7RaTcruM+Hp
	DCuUZCfua+7xnXp8sELiGim6aBruM6Jb+Tb87KurLIDSs4GNVEfthN29i956y84La2mL
	avJ6ah9HwNnraUKD630x1g7E/ligkzdDZjqrDz/0cC7Srrcy4dZrCsTo/QbZCiXSnjVQ
	72+4GzwSnIcYeHN+0X9WgwhFPsoqBwFZ0tR4WjLiG0Dy01S6UTtaLaiezxVxYj8HBCf0
	C7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:date
	:message-id:subject:from:to:cc;
	bh=4amKvYVUdLRYhyK+CxSZ0Pil5R7eL41bjTR3VAiA4xc=;
	b=XqxS+hAp65eV4gPPJCy3vhtjT2njuQZCB+LH31SW1qbXX6/8z8kgUaNEfK6B/dBcfu
	TNQYonzfawooSqStLuE//P45aS4JhUR2stAoa17nlWDEjeZNf3d8acvixaMUR7BeoV+7
	BosTqWL0hTVEnUScj7Z7BLKQaBqZSOqkmIWXBXwWS5WFJlZAIOnrLeGhtZqyjnZo2Ags
	310540VwD+qzkAC8rbAakMhHQsZ8mxU/9/yiisFsbGHGf8NbrvcAvWqW4TvmqOrw2v39
	qURS4Cq7E4eSGbi4evnVX22ej6YSaJt2ubx9PfDdy6w53r8GCMm76G0abeiT8gR3OOuT
	Mt7g==
X-Gm-Message-State: AOPr4FV0fULDNDaPM8I51ljyNM6kChjPKvWYIHEndT+yNvqzHEhX0eVdJmx3WGASpi/cDNZasNTSCpyqYPyG1w==
MIME-Version: 1.0
X-Received: by 10.140.254.9 with SMTP id z9mr9277959qhc.5.1460527711624; Tue,
	12 Apr 2016 23:08:31 -0700 (PDT)
Received: by 10.55.130.196 with HTTP; Tue, 12 Apr 2016 23:08:31 -0700 (PDT)
Received: by 10.55.130.196 with HTTP; Tue, 12 Apr 2016 23:08:31 -0700 (PDT)
In-Reply-To: <570DE199.3010802@mlbassoc.com>
References: <570DE199.3010802@mlbassoc.com>
Date: Wed, 13 Apr 2016 02:08:31 -0400
Message-ID: <CAMKF1soC0Yy13GyVVoe3KY3SjP26MvrHSbr3WS6x=dRW0uy=0Q@mail.gmail.com>
From: Khem Raj <raj.khem@gmail.com>
To: Gary Thomas <gary@mlbassoc.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: Analyzing dependencies
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
X-List-Received-Date: Wed, 13 Apr 2016 06:08:34 -0000
Content-Type: multipart/alternative; boundary=001a113a74f66fa5ab0530579b23

--001a113a74f66fa5ab0530579b23
Content-Type: text/plain; charset=UTF-8

Use any program that reads dotty files
On Apr 12, 2016 11:05 PM, "Gary Thomas" <gary@mlbassoc.com> wrote:

> If I generate the dependency files (-g => *.dot files) for
> my target recipe, is there a way to view/analyze them "off line"
> much the same way as using "bitbake -u depexp"?
>
> --
> ------------------------------------------------------------
> Gary Thomas                 |  Consulting for the
> MLB Associates              |    Embedded world
> ------------------------------------------------------------
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

--001a113a74f66fa5ab0530579b23
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Use any program that reads dotty files</p>
<div class=3D"gmail_quote">On Apr 12, 2016 11:05 PM, &quot;Gary Thomas&quot=
; &lt;<a href=3D"mailto:gary@mlbassoc.com">gary@mlbassoc.com</a>&gt; wrote:=
<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">If I generate the d=
ependency files (-g =3D&gt; *.dot files) for<br>
my target recipe, is there a way to view/analyze them &quot;off line&quot;<=
br>
much the same way as using &quot;bitbake -u depexp&quot;?<br>
<br>
-- <br>
------------------------------------------------------------<br>
Gary Thomas=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 Consulting for the<br>
MLB Associates=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A0 Embedded world<br>
------------------------------------------------------------<br>
-- <br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blank">b=
itbake-devel@lists.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/mailman/li=
stinfo/bitbake-devel</a><br>
</blockquote></div>

--001a113a74f66fa5ab0530579b23--
