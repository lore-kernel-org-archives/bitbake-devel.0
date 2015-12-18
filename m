Return-Path: <just4tech83@gmail.com>
Received: from mail-oi0-f53.google.com (mail-oi0-f53.google.com
	[209.85.218.53])
	by mail.openembedded.org (Postfix) with ESMTP id 8C7DF731B7;
	Fri, 18 Dec 2015 07:40:05 +0000 (UTC)
Received: by mail-oi0-f53.google.com with SMTP id o124so55730174oia.1;
	Thu, 17 Dec 2015 23:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:content-type; bh=evyG0jPUnWJUgWLa0Yf3BLk8G18iJ5kNOISs7fW8xAg=;
	b=m68CqeeRU6qeqxWHrl7TZfZFLB2bgMDNvxprO7BqpWH4vy0ehgbpNZ9T72oQsnIvqF
	J0GLrr34K7Z9jeUCeVr7dwphwocQZObG4G0+fyeNLtYeRQrvAko4Yv4XB7xA/8yn+2pD
	eOYY992q0wc+pR7nhffSMbifuFaRLSGWO4qa5RtWYMUDytSm2PT/ruutSjDK/aBokjDt
	hDkrYt/zCcOSfanRbsXagEuhJyBymRYFpPqt/x0von+NgNof5ByfiBq1X+SdK/WPgnsP
	28uklb+6m+Twk0giyHrEckLs5ItcpAT09MAZu4Hc/pHQ6S88AywsNJvWVJY+4n9oPuTc
	1qjQ==
MIME-Version: 1.0
X-Received: by 10.202.49.9 with SMTP id x9mr896086oix.75.1450424406440; Thu,
	17 Dec 2015 23:40:06 -0800 (PST)
Received: by 10.202.0.204 with HTTP; Thu, 17 Dec 2015 23:40:06 -0800 (PST)
Received: by 10.202.0.204 with HTTP; Thu, 17 Dec 2015 23:40:06 -0800 (PST)
In-Reply-To: <CAD2C2VSOXLTPM-yu6JFajf0LMHoE1t3utWG0vLFUzERcZs+7HA@mail.gmail.com>
References: <CAD2C2VSOXLTPM-yu6JFajf0LMHoE1t3utWG0vLFUzERcZs+7HA@mail.gmail.com>
Date: Fri, 18 Dec 2015 13:10:06 +0530
Message-ID: <CAD2C2VQYkHC_ZOj-EjXe+x+AqEqeB-ZXbPkaM-76=Owb4bqpVg@mail.gmail.com>
From: Bryan <just4tech83@gmail.com>
To: linux-yocto@yoctoproject.org, poky@yoctoproject.org, 
	bitbake-devel@lists.openembedded.org, 
	openembedded-devel@lists.openembedded.org, 
	openembedded-core@lists.openembedded.org
Subject: korean/chinese keyboard layout support on yocto
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
X-List-Received-Date: Fri, 18 Dec 2015 07:40:06 -0000
Content-Type: multipart/alternative; boundary=001a113ca3268502220527273f88

--001a113ca3268502220527273f88
Content-Type: text/plain; charset=UTF-8

---------- Forwarded message ----------
From: "Bryan" <just4tech83@gmail.com>
Date: Dec 18, 2015 1:03 PM
Subject: korean/chinese keyboard layout support on yocto
To: <openembedded-core@lists.openembedded.org>
Cc:

Hi,
>     I am working on yocto poky-dizzy 1.7.1 and have developed some
> application on top of customized os image. I have a reqirement to support
> korean/chinese keyboard layout for application.
> I have added cross complied libraries for  ibus-hangul pckages. Can
> somebody suggest me how can i add support for keyboart layout and how to
> enable automatically.
>
> Is there any bitbake recipe available to support these keyboard layout.
>
>
> regards
> Bryan
>

--001a113ca3268502220527273f88
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">---------- Forwarded message ----------<br>From:=
 &quot;Bryan&quot; &lt;<a href=3D"mailto:just4tech83@gmail.com">just4tech83=
@gmail.com</a>&gt;<br>Date: Dec 18, 2015 1:03 PM<br>Subject: korean/chinese=
 keyboard layout support on yocto<br>To:  &lt;<a href=3D"mailto:openembedde=
d-core@lists.openembedded.org">openembedded-core@lists.openembedded.org</a>=
&gt;<br>Cc: <br><br type=3D"attribution"><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><p =
dir=3D"ltr">Hi, <br>
=C2=A0=C2=A0=C2=A0 I am working on yocto poky-dizzy 1.7.1 and have develope=
d some application on top of customized os image. I have a reqirement to su=
pport korean/chinese keyboard layout for application. <br>
I have added cross complied libraries for=C2=A0 ibus-hangul pckages. Can so=
mebody suggest me how can i add support for keyboart layout and how to enab=
le automatically. </p>
<p dir=3D"ltr">Is there any bitbake recipe available to support these keybo=
ard layout. </p>
<p dir=3D"ltr"> <br>
regards<br>
Bryan</p>
</blockquote></div>

--001a113ca3268502220527273f88--
