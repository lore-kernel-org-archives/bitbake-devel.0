Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
 by mx.groups.io with SMTP id smtpd.web10.3801.1587155097500246259
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Apr 2020 13:24:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=jNAEcNCA;
 spf=pass (domain: gmail.com, ip: 209.85.221.179, mailfrom: alex.kanavin@gmail.com)
Received: by mail-vk1-f179.google.com with SMTP id q200so693448vka.13
        for <bitbake-devel@lists.openembedded.org>; Fri, 17 Apr 2020 13:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HpVDMVf6FlwG4ic6Fn7jQDAaDnZcAuZTURnedtSLpPk=;
        b=jNAEcNCA8+0kGJbcAlYaD+va0pflQ/aYgn7fze6jb5iNwd3CUnPJrEiz8SQbulafi6
         t4TVIts0/DcKl1zq7Z1PFXeAXLvEI66ZqghlulYB2VfZcj6qdJvAZBV2ej+phR7Fumr+
         GCNCm2s7N2fA4MvtA0XMpTdr92Xax3zFmTdIoS8kSGBiQysmEvT7FO8JxxRL9oEUUsPm
         PtsPPQF+ybVYBXpMZWZlktlEa9trvknTbJsu8NvOzYlgcpVFglVr34HWjAZgxQET1+s8
         0A/D5HY6XOKCK/zkyuYwbOKy5+eKbkphUtFrFPb89EGPClgQ/t4iPrjbuinYCb8TC++Q
         JvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HpVDMVf6FlwG4ic6Fn7jQDAaDnZcAuZTURnedtSLpPk=;
        b=JJWJFb527T9yJrt+qzbaDSEr5aSHmre2m2sL2K0ykCiRAODIJ53qxSPDGy9BwpJpub
         E7I1bY5jo0gCaiBD/17Wmx1cwyyfM9nfSIYzFpox/EChQiEYs2F9+/shxoZPwiv7RRcz
         /t698Sh9Jr44aOnRbBhoRUZ8ZFRF3N7kY0GVkaKjF6uJCDnTozUvSdIv6sZBfI/uteS4
         LM5Q56451OyjIejBGVMHeycVvR86PXD5dFzBZOAFOTAr+36blPh/RkYuLcnvZpVPQ/bQ
         vKv+fKbHMRfjE4bBGYraTFumY6A9vU1jGDA47twqnAR4StkVav1+TnzvoJz+CyvKfGet
         l4DA==
X-Gm-Message-State: AGi0PuYu45dsLzzPhIfdZZ0T5lGXf6yjXkTKHhRXq+lOIkyiP2W4BFCr
	Rpu5HicLC/DkbuQI7qXfUwK9eUOGImjc0LzudDY=
X-Google-Smtp-Source: APiQypKE6sTPzXcGEB2k0OsKUXSIMX8z3xy8bMhACQ2MbJiLWMsUZ6Ejm7/6kMVobeRzFDsu3PTkIv1zuCrDGej0c8A=
X-Received: by 2002:a1f:e182:: with SMTP id y124mr4346642vkg.0.1587155096666;
 Fri, 17 Apr 2020 13:24:56 -0700 (PDT)
MIME-Version: 1.0
References: <CANNYZj8E3O9D1m6nVoizgmWp_szadiSRGnjTfCXFxWJ9j2TZxg@mail.gmail.com>
 <10537.1587154291554351877@lists.openembedded.org>
In-Reply-To: <10537.1587154291554351877@lists.openembedded.org>
From: "Alexander Kanavin" <alex.kanavin@gmail.com>
Date: Fri, 17 Apr 2020 22:24:45 +0200
Message-ID: <CANNYZj_xP2UtR5Ohx5ufGv5UZHQjR51+iTashoPckm-C3BWHkw@mail.gmail.com>
Subject: Re: [bitbake-devel] Significance of "SRCREV_FORMAT" variable for multiple sources fetch
To: abhishek.shah@broadcom.com
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000bd85e005a38257af"

--000000000000bd85e005a38257af
Content-Type: text/plain; charset="UTF-8"

I think you should fix the code you're building so that it creates a
relative symlink.

Dropping SRCREV_FORMAT is a workaround to make the path shorter, not a real
fix for the actual problem.

Alex

On Fri, 17 Apr 2020 at 22:11, Abhishek Shah via lists.openembedded.org
<abhishek.shah=broadcom.com@lists.openembedded.org> wrote:

> I just checked that we have mentioned commit in yocto we are using.
>
> Could you please confirm, with this in place, is there no need to keep on
> updating SRCREV_FORMAT
> when new SRC_URI is added in the recipe?
> Rather, can we just skip setting this variable for multiple source bitbake
> recipe? 
>

--000000000000bd85e005a38257af
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I think you should fix the code you&#39;re building s=
o that it creates a relative symlink. <br></div><div><br></div><div>Droppin=
g SRCREV_FORMAT is a workaround to make the path shorter, not a real fix fo=
r the actual problem.<br></div><div><br></div><div>Alex<br></div></div><br>=
<div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 17=
 Apr 2020 at 22:11, Abhishek Shah via <a href=3D"http://lists.openembedded.=
org">lists.openembedded.org</a> &lt;abhishek.shah=3D<a href=3D"mailto:broad=
com.com@lists.openembedded.org">broadcom.com@lists.openembedded.org</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">I just c=
hecked that we have mentioned commit in yocto we are using.<br><br>Could yo=
u please confirm, with this in place, is there no need to keep on updating =
SRCREV_FORMAT<br>when new SRC_URI is added in the recipe?<br>Rather, can we=
 just skip setting this variable for multiple source bitbake recipe?
<br>
</blockquote></div>

--000000000000bd85e005a38257af--
