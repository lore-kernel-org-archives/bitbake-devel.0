Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
 by mx.groups.io with SMTP id smtpd.web08.17895.1611357572506062411
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 22 Jan 2021 15:19:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=QzzW8G7c;
 spf=pass (domain: gmail.com, ip: 209.85.167.46, mailfrom: katutxakurra@gmail.com)
Received: by mail-lf1-f46.google.com with SMTP id a8so9822969lfi.8
        for <bitbake-devel@lists.openembedded.org>; Fri, 22 Jan 2021 15:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xKwbcm6ilMCDX6um8ZDrU8qqW6XRzIUsAWX25HW/Xbs=;
        b=QzzW8G7cAnoG7QchqFv99wWOkga+feXrv/rRSEbAGWqK4QwuLSEn/vRanrvQ2n2C37
         rnFKARe8n3wAmTJgQyBok9MVKHNRGtAqXxMCtWTch05JYNTX+j7qGUsGEL22dr+LMzDL
         4x0zvBWGPcwk/nofiwIp3W3s40Q8w01VSlYNr7DOi5+bFvpOvmnSvdEo18m2zXjKK+IC
         Ort4En3CJfpLS/BxKd/YoyPW+LDH+zawUWBXe9Wi0R8DpNx1/EKLoVESnHP7uRvmzR9I
         6fDhbsiXOhS/CB0BDFaDhw0r4uqd7xngvT36f/NMghcKRqLm5JWvEs+jP5UHFtfVNM4A
         4Umw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xKwbcm6ilMCDX6um8ZDrU8qqW6XRzIUsAWX25HW/Xbs=;
        b=qF/fLsAuDoEWxBjR5Lqz+56DymbT1BWFM+wx0TSCayk0Cq4hutqarhwCEtc2S8iXsK
         x/JbNgwTPyXdJVLtsd6yeVl1Av187S5TwkPz+4XH95GVkpiYBp3/TgWh1ym9i6H2V22D
         gAJKksKDgQRViXlcurDdqO+iOBmaYexExn62ZiRCBThcIOTVJugv+L6mfqPPsaoy4oSr
         a3v2Yq/inj4rUC3Cv2clcVnpM4tyL8HKtJJ2dLltwTmLW4FU1gszvnf5EXMuMAa/z8Pi
         XbbI1FgyeWJMNgXBydvmcpxEeMTWBSOKiWiAA+8oN0VgU8xyjj6q1BEamMjBe+KssubY
         MkPw==
X-Gm-Message-State: AOAM531Tp3XT2NuFiYICPgfkvH3K46KhbU9selSwwUXipCaBmjKmqIIV
	j/BYUW+klktLQVwIUqitFLz++kqw8MgsUdIt7M4=
X-Google-Smtp-Source: ABdhPJwh5ZANxg1nALyLUpQeqHLfm42aIfK6eWJaJihQgeUUrJS9P7chsJXHUJ2gYgRUDK0jLH8/2kdfiW4jmMlYuK0=
X-Received: by 2002:a05:6512:3090:: with SMTP id z16mr68029lfd.44.1611357570675;
 Fri, 22 Jan 2021 15:19:30 -0800 (PST)
MIME-Version: 1.0
References: <CAM1ZcoWA6pT9iVunDREWGNMCY8DbbF_diUB_O_epnDLQsQspbg@mail.gmail.com>
 <1965f946aa345b7a820c94194c8011de0cd64bdc.camel@linuxfoundation.org>
In-Reply-To: <1965f946aa345b7a820c94194c8011de0cd64bdc.camel@linuxfoundation.org>
From: "Katu Txakur" <katutxakurra@gmail.com>
Date: Fri, 22 Jan 2021 23:19:19 +0000
Message-ID: <CAM1ZcoVB1FnY+fDyw53iPSWhaFduwH8G-1R7U-EU+pCqNuFQFQ@mail.gmail.com>
Subject: Re: [bitbake-devel] Perforce.py tar filename
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000009b371b05b9856b7b"

--0000000000009b371b05b9856b7b
Content-Type: text/plain; charset="UTF-8"

Sorry for the late reply Richard, I should have sent a patch with my first
email. I've seen that you've fixed it. Thank you!

Cheers,
Katu

On Fri, 15 Jan 2021 at 18:05, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Fri, 2021-01-15 at 15:38 +0000, Katu Txakur wrote:
> > Hi,
> >
> > The file
> >
> https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/bitbake/lib/bb/fetch2/perforce.py
> > that fetches code from Perforce repositories sets the name of the tar
> > file stored in the downloads folder in line 136:
> >     ud.localfile = d.expand('%s_%s_%s.tar.gz' % (cleanedhost,
> > cleanedpath, ud.revision))
> > It only cares about the path but not the 'module' where it will be
> > mapped. I had two recipes that map the same folder, but each had a
> > destination folder with a different name. When building an image
> > containing both recipes, the second one took the tar file in the
> > downloads folder created by the first one. As a consequence, the
> > mapping was wrong and the image failed to build.
> >
> > I fixed it by adding the module to the name of the path. Is this a
> > bug or a design decision?
>
> Sounds like a bug to me, a patch to fix it would be welcome.
>
> Cheers,
>
> Richard
>
>

--0000000000009b371b05b9856b7b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Sorry for=C2=A0the late reply Richard, I should have =
sent a patch with my first email. I&#39;ve seen that you&#39;ve fixed it. T=
hank you!</div><div><br></div><div>Cheers,</div><div>Katu<br></div><br><div=
 class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 15 Jan=
 2021 at 18:05, Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfo=
undation.org">richard.purdie@linuxfoundation.org</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">On Fri, 2021-01-15 at 15:38=
 +0000, Katu Txakur wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; The file <br>
&gt; <a href=3D"https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/bitbak=
e/lib/bb/fetch2/perforce.py" rel=3D"noreferrer" target=3D"_blank">https://g=
it.yoctoproject.org/cgit/cgit.cgi/poky/tree/bitbake/lib/bb/fetch2/perforce.=
py</a><br>
&gt; that fetches code from Perforce repositories sets the name of the tar<=
br>
&gt; file stored in the downloads folder in line 136:<br>
&gt; =C2=A0=C2=A0=C2=A0 ud.localfile =3D d.expand(&#39;%s_%s_%s.tar.gz&#39;=
 % (cleanedhost,<br>
&gt; cleanedpath, ud.revision))<br>
&gt; It only cares about the path but not the &#39;module&#39; where it wil=
l be<br>
&gt; mapped. I had two recipes that map the same folder, but each had a<br>
&gt; destination folder with a different name. When building an image<br>
&gt; containing both recipes, the second one took the tar file in the<br>
&gt; downloads folder created by the first one. As a consequence, the<br>
&gt; mapping was wrong and the image failed to build.<br>
&gt; <br>
&gt; I fixed it by adding the module to the name of the path. Is this a<br>
&gt; bug or a design decision?<br>
<br>
Sounds like a bug to me, a patch to fix it would be welcome.<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
</blockquote></div></div>

--0000000000009b371b05b9856b7b--
