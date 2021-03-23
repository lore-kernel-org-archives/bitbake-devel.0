Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
 by mx.groups.io with SMTP id smtpd.web08.2006.1616459147401352315
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Mar 2021 17:25:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=eqovWw7c;
 spf=pass (domain: gmail.com, ip: 209.85.222.171, mailfrom: paulswirhun@gmail.com)
Received: by mail-qk1-f171.google.com with SMTP id q26so7431383qkm.6
        for <bitbake-devel@lists.openembedded.org>; Mon, 22 Mar 2021 17:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=TP93x72e8NjDwlgMHoVtV+EcBak2D9T7/QmUOFFonk0=;
        b=eqovWw7cWvTTddGALYTgCddAb8h7k392B3pd6CvNxWHhEwxn/PnVjgdV7DjW53nCme
         AFBrNpphoODupIxFER5+WvcK24s52xlTNhaGSRwslzwl2dNgGX+NbRRhxr5XFKDRzzkJ
         9HyA19GKnesSW9VLyLBSjj4+KGtwxIG0Gku3GOmdl+QJLXj6w+IktVblMoFoAR2oWNwn
         Dnpw0MuQ0NWTmXO9VVIXyk82w3wZRA6uYpcKOLET8j/BUgeEvV8X+2lBIe+OOBUrsr2k
         kaqVbRvf0+EaWcRd8VzA93SaeGepZ0H/I/0UnPFH+8buxz/9yRXs3JQgRWHgYes98avX
         uNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=TP93x72e8NjDwlgMHoVtV+EcBak2D9T7/QmUOFFonk0=;
        b=k8+j30bWfwecct93WjKcvl7qgssIEU3fRaqeZQCXuKNvjzZkWtKdGItarVuLoDP8Js
         tYG72cxk9m/pyF6rbyH4lPEG/ZPYADSoor7wJ2vKDPwxitiT9YSu8mSIw8nH6YCV64yA
         FfqEDY5I4AUpg3l1GgNlgNgqQur0dEkjDmkcKl5D3GY4mclMjtmFytP59n6mPZGV5PVf
         UwHMKKHXwiPw4hUGB+nhqNMfjBjs/PQarPdMiwis+5MPF34bgLuW84+JrVLTdCChnEsP
         oqN3XR3fUBFZPDi4SH+oipaSb5HRcNU0LWhZfX/bnIjV0oL5YsV3BmQP2jV2epoij3Ay
         iu/Q==
X-Gm-Message-State: AOAM531sK5ewtzGmF9Ouf0Xp/FP1FvnxgstgIrDPcSz8UVy3c7AHY/vS
	lgVvlgXk7VPazBdNLQa59nO0UGZsD5NhzvuU5GnaPDuqbwc=
X-Google-Smtp-Source: ABdhPJx2aod+Wc2BfTDYvAyWVmcwAFyOhSRE0fKTogtQCY1SVClsX1aWO6Rkhdg7ADmHBG9RRY9Bm433nQvkPbpl0ns=
X-Received: by 2002:a37:a016:: with SMTP id j22mr2924227qke.486.1616459146308;
 Mon, 22 Mar 2021 17:25:46 -0700 (PDT)
MIME-Version: 1.0
References: <166EC7B0F4B394EE.24466@lists.openembedded.org>
In-Reply-To: <166EC7B0F4B394EE.24466@lists.openembedded.org>
From: "Paul Swirhun" <paulswirhun@gmail.com>
Date: Mon, 22 Mar 2021 17:25:35 -0700
Message-ID: <CADOqROxW9BvdcNpmcg6UDYjGMH9ejTauEVqE=eYOMwYurvmwAw@mail.gmail.com>
Subject: Re: [bitbake-devel] Patching recipe from pypi
To: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000035b0ef05be29390f"

--00000000000035b0ef05be29390f
Content-Type: text/plain; charset="UTF-8"

Update: I found instructions on page 146 of Xilinx UG1144 which worked.
This is for Petalinux and may not be directly applicable to bitbake but is
probably just some wrapper around bitbake commands.

On Mon, Mar 22, 2021 at 2:34 PM Paul Swirhun via lists.openembedded.org
<paulswirhun=gmail.com@lists.openembedded.org> wrote:

> Hello,
>
> This is my first visit to this group, so my apologies if this is not the
> appropriate way to ask a question.
>
> I would like to patch or overwrite a .py file from a pypi library which
> had a bug. The problem has been fixed at its source but I need the fixed
> version integrated into our version of Yocto (Zeus). Can someone point me
> to an example .bbappend recipe to replace a file populated by pip / pypi?
> Specifically, devtools/python/python-periphery/mmio.py has a bug which has
> been fixed in its top of tree but the old version remains and probably will
> remain in Zeus for some time.
>
> Thanks,
> Paul
>
> 
>
>

--00000000000035b0ef05be29390f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Update: I found instructions on page 146 of Xilinx UG1144 =
which worked. This is for Petalinux and may not be directly applicable to b=
itbake but is probably just some wrapper around bitbake commands.</div><br>=
<div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Ma=
r 22, 2021 at 2:34 PM Paul Swirhun via <a href=3D"http://lists.openembedded=
.org">lists.openembedded.org</a> &lt;paulswirhun=3D<a href=3D"mailto:gmail.=
com@lists.openembedded.org">gmail.com@lists.openembedded.org</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left-width:1px;border-left-style:solid;border-left-color:rgb(204,=
204,204);padding-left:1ex"><div dir=3D"ltr">Hello,<div><br></div><div>This =
is my first visit to this group, so my apologies=C2=A0if this is not the ap=
propriate way to ask a question.</div><div><br></div><div>I would like to p=
atch or overwrite a .py file from a pypi library which had a bug. The probl=
em has been fixed at its source but I need the fixed version integrated int=
o our version of Yocto (Zeus). Can someone point me to an example .bbappend=
 recipe to replace a file populated by pip / pypi? Specifically, devtools/p=
ython/python-periphery/mmio.py has a bug which has been fixed in its top of=
 tree but the old version remains and probably will remain in Zeus for some=
 time.</div><div><br></div><div>Thanks,</div><div>Paul</div></div>
<br>
<br>
<br>
</blockquote></div>

--00000000000035b0ef05be29390f--
