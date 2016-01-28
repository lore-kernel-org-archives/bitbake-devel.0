Return-Path: <just4tech83@gmail.com>
Received: from mail-io0-f172.google.com (mail-io0-f172.google.com
	[209.85.223.172])
	by mail.openembedded.org (Postfix) with ESMTP id 8D8D36057B;
	Thu, 28 Jan 2016 17:56:05 +0000 (UTC)
Received: by mail-io0-f172.google.com with SMTP id 1so62661901ion.1;
	Thu, 28 Jan 2016 09:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:content-type; bh=IcmsSd8d17sygP9KZR4gSkGTqx25dCe2dRCVzw5ZNr0=;
	b=Nfl9vZh4rrwP3+dSMzvFSWj4Wg8lVdudOXtQVHH3ZmJ4i90kaI5bbRzQq0LSxl49fV
	WJxzF+g5qq0ag8Ajt3Yh1BOidQCMY2VEAZaZ1uZYjo7kUYXjq//S+acfclLbRCgJRZjW
	xEyTU29nDPOyRYYhEAVZ98BebWyUsi4WAu+5xf3OwUiTkiyf52eq8ClUf4AItOc6wYry
	AxNGXeYkApPfIoNXYHCTsQ4gV0qu37bHbRVfkFswQKCawALJlhTpc9HjRgIrZVJLgxEJ
	Ix4uVlyu2s9HwghBJZfBFoS+0GKudrIZuqu/Eb6Fp3v1Ds8tcsW0SaPNkksouA4jCoxA
	ywAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:date
	:message-id:subject:from:to:content-type;
	bh=IcmsSd8d17sygP9KZR4gSkGTqx25dCe2dRCVzw5ZNr0=;
	b=DqfOt2oYct64pBMJJ/WIy3p97LM43uYbv3mCpt68RIWUBjhzCmYMyvXPPB4tXXhdBD
	/DMNzPRdwS07TUxV9LcYcWnsTaib/LCeOh+V0vZoSN+hgCv6pxkFhuyTiovli8YpekZW
	ziy+DaF/bNg79ScbtsEzpUTelCbknLUjr0t+9OA9SP9SOeiSVcUyDQN4ERhwBKQWfPNl
	4eraBGJ6Y38ovRowgDzc1+xpELpI7/Kh/PFZGIMk2aPfXRYd+qDaHKqa8/oHNPW4mVLy
	SlNVZb1k6yMC8c+lZqah0VlNS0VGLanriK6FnTewGOuM2q0We1grERCh7JQ8sAylpc6j
	LhAg==
X-Gm-Message-State: AG10YOQWVmnGPR0GCcbZ/yUu/66Kzer6tVa4EUcpmzoW9Av92BcCWHFKIHxUSjf44bk874vDroxvK2tceEqOGQ==
MIME-Version: 1.0
X-Received: by 10.107.16.17 with SMTP id y17mr2085533ioi.119.1454003765976;
	Thu, 28 Jan 2016 09:56:05 -0800 (PST)
Received: by 10.36.196.133 with HTTP; Thu, 28 Jan 2016 09:56:05 -0800 (PST)
Received: by 10.36.196.133 with HTTP; Thu, 28 Jan 2016 09:56:05 -0800 (PST)
In-Reply-To: <CAD2C2VTQ9A3hDM7eXUbs4AWqSuGLkPD9=h3K6V+-Hhju2=1vHQ@mail.gmail.com>
References: <CAD2C2VTQ9A3hDM7eXUbs4AWqSuGLkPD9=h3K6V+-Hhju2=1vHQ@mail.gmail.com>
Date: Thu, 28 Jan 2016 23:26:05 +0530
Message-ID: <CAD2C2VRFV7RDGLJZV0-WYHagM_MRfViG46HgGTAZ5N8ztNhP7A@mail.gmail.com>
From: Bryan <just4tech83@gmail.com>
To: openembedded-devel@lists.openembedded.org, linux-yocto@yoctoproject.org, 
	bitbake-devel@lists.openembedded.org, poky@yoctoproject.org, 
	openembedded-core@lists.openembedded.org
Subject: dual monitor supprt
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
X-List-Received-Date: Thu, 28 Jan 2016 17:56:05 -0000
Content-Type: multipart/alternative; boundary=001a113ff328f9237f052a68a143

--001a113ff328f9237f052a68a143
Content-Type: text/plain; charset=UTF-8

Hi,
i want pslash during boot with dual monitors. both monitors have different
resolution. how can i display psplash properly on both monitors
thanks in advance.
Brian
On Dec 18, 2015 1:10 PM, "Bryan" <just4tech83@gmail.com> wrote:

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

--001a113ff328f9237f052a68a143
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Hi, <br>
i want pslash during boot with dual monitors. both monitors have different =
resolution. how can i display psplash properly on both monitors<br>
thanks in advance.<br>
Brian</p>
<div class=3D"gmail_quote">On Dec 18, 2015 1:10 PM, &quot;Bryan&quot; &lt;<=
a href=3D"mailto:just4tech83@gmail.com">just4tech83@gmail.com</a>&gt; wrote=
:<br type=3D"attribution"><blockquote class=3D"quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"elided-tex=
t"><div class=3D"gmail_quote">---------- Forwarded message ----------<br>Fr=
om: &quot;Bryan&quot; &lt;<a href=3D"mailto:just4tech83@gmail.com" target=
=3D"_blank">just4tech83@gmail.com</a>&gt;<br>Date: Dec 18, 2015 1:03 PM<br>=
Subject: korean/chinese keyboard layout support on yocto<br>To:  &lt;<a hre=
f=3D"mailto:openembedded-core@lists.openembedded.org" target=3D"_blank">ope=
nembedded-core@lists.openembedded.org</a>&gt;<br>Cc: <br><br type=3D"attrib=
ution"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex"><p dir=3D"ltr">Hi, <br>
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
</div></blockquote></div>

--001a113ff328f9237f052a68a143--
