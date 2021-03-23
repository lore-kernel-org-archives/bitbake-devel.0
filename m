Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
 by mx.groups.io with SMTP id smtpd.web08.5990.1616490134640248352
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 23 Mar 2021 02:02:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=oMiGFD/G;
 spf=pass (domain: gmail.com, ip: 209.85.208.47, mailfrom: martin.jansa@gmail.com)
Received: by mail-ed1-f47.google.com with SMTP id e7so22468783edu.10
        for <bitbake-devel@lists.openembedded.org>; Tue, 23 Mar 2021 02:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gW95LvPDtZ+qd5kafY3bfkvQ6XRC17RBOFYRU7PGDE0=;
        b=oMiGFD/GZLUE/dC/62UNtqemcgmy+dwn6jRs2EHeFJ993zS30FTiA0izClSy3x3018
         2Kx7E4UiIeLLf6zpcIDPUS+O2I7JvXlgheEiGsZ5OcIPV27v1oNBWHd3Qr8/5nuqD7Cq
         eyuQ/DFRHI37rzsKlN/dNnwMkJRlZNCpkMSLGU7nB2IkueIm47izHrnB0fpa35Zl8wx7
         qzuRWe8MjQMkC7dN8+W86in8hX/Ur9CtEoeXTym6NvC82PaWr/CwUNjnOKxGi0qmcZwk
         I5gk2D8moRxTu19pD08sVcxYhVSfjvdO7ebhd/HBsnbUDoC+mD3mKYg9pkrZEqG3bJV5
         wbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gW95LvPDtZ+qd5kafY3bfkvQ6XRC17RBOFYRU7PGDE0=;
        b=cIRPwLojzRjOk4VHfNfPcqtHYmL9RSIL+A94M082qCqrxtjF/iKB/78BF2yaxfgpTR
         EKOTg2cOkJMQM8R2JklDYsTsrOwffOSzelDbvXoEOpT6dAtzxT81AM/3yP3fAqpjQ8V3
         dLVgJZnB1RZwvKsRHQTbRZ+S4hLgYJS+B5GYIq7Fv7hmHLm1uRRLH8s5X/j7L9VGbGfz
         oghrnMvluMnuQOa6lgKM6xtmlWh5OSezg8jWgcAL9TjH+myaTfO0cchTbAhrsVIL3K8e
         Yk1iCA6FjFZqUzEa+xAkeJNdtcKJf1ewJ/4TlOtAn5gipOju9zwkLx1n8YV4nTyd+lB2
         EbUg==
X-Gm-Message-State: AOAM5331WOJjPNbV8uTAfl5CFPkQ3K+MmvdLbAj5VZy//MbHrfQ7EC43
	983ygS3VN7+QNaXGcGEw8ROVdK/7AoXk/jmMAck=
X-Google-Smtp-Source: ABdhPJz8DskxOAnZT28yY8jo/HorotAM7JaqNnKbR9rlgex4Yn26MwOcm7HnLyO12mbaUi5XDaoqXz15GC3ue5reiWE=
X-Received: by 2002:aa7:d4ca:: with SMTP id t10mr3508517edr.388.1616490133000;
 Tue, 23 Mar 2021 02:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210323085039.168551-1-amikan@ilbers.de>
In-Reply-To: <20210323085039.168551-1-amikan@ilbers.de>
From: "Martin Jansa" <Martin.Jansa@gmail.com>
Date: Tue, 23 Mar 2021 10:02:01 +0100
Message-ID: <CA+chaQcdTJJTLWePvrfF-ZGK=t0s0oi+7fuDX54JGV4-Jo2gOQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2/__init__.py: Use relative symlink for mirrors
To: Anton Mikanovich <amikan@ilbers.de>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="00000000000029164d05be3070ed"

--00000000000029164d05be3070ed
Content-Type: text/plain; charset="UTF-8"

Is this really different from

https://lists.openembedded.org/g/bitbake-devel/topic/78342988#11853

which got reverted in
https://git.openembedded.org/bitbake/commit/?id=5775d9463ecedf8681cb6c919b240b80fe70f5a3
?

On Tue, Mar 23, 2021 at 9:50 AM Anton Mikanovich <amikan@ilbers.de> wrote:

> When running bitbake in chroot with external DL_DIR mounted to other
> location symlink for repo obtained from MIRRORS point to wrong location.
> There is no need in absolute path here, because destination will always
> be in the same directory. So it is better to use relative symlink.
>
> Signed-off-by: Anton Mikanovich <amikan@ilbers.de>
> ---
>  lib/bb/fetch2/__init__.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index cf0201c4..ac7a6748 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -1066,7 +1066,7 @@ def ensure_symlink(target, link_name):
>          # same time, in which case we do not want the second task to
>          # fail when the link has already been created by the first task.
>          try:
> -            os.symlink(target, link_name)
> +            os.symlink(os.path.basename(target), link_name)
>          except FileExistsError:
>              pass
>
> --
> 2.25.1
>
>
> 
>
>

--00000000000029164d05be3070ed
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Is this really different from<div><br></div><div><a href=
=3D"https://lists.openembedded.org/g/bitbake-devel/topic/78342988#11853">h=
ttps://lists.openembedded.org/g/bitbake-devel/topic/78342988#11853</a><br><=
/div><div><br></div><div>which got reverted in</div><div><a href=3D"https:/=
/git.openembedded.org/bitbake/commit/?id=3D5775d9463ecedf8681cb6c919b240b80=
fe70f5a3">https://git.openembedded.org/bitbake/commit/?id=3D5775d9463ecedf8=
681cb6c919b240b80fe70f5a3</a><br></div><div>?</div></div><br><div class=3D"=
gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 23, 2021 at =
9:50 AM Anton Mikanovich &lt;<a href=3D"mailto:amikan@ilbers.de">amikan@ilb=
ers.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">When running bitbake in chroot with external DL_DIR mounted to other<=
br>
location symlink for repo obtained from MIRRORS point to wrong location.<b=
r>
There is no need in absolute path here, because destination will always<br=
>
be in the same directory. So it is better to use relative symlink.<br>
<br>
Signed-off-by: Anton Mikanovich &lt;<a href=3D"mailto:amikan@ilbers.de" ta=
rget=3D"_blank">amikan@ilbers.de</a>&gt;<br>
---<br>
=C2=A0lib/bb/fetch2/__init__.py | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py<br>
index cf0201c4..ac7a6748 100644<br>
--- a/lib/bb/fetch2/__init__.py<br>
+++ b/lib/bb/fetch2/__init__.py<br>
@@ -1066,7 +1066,7 @@ def ensure_symlink(target, link_name):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# same time, in which case we do not wan=
t the second task to<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# fail when the link has already been cr=
eated by the first task.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.symlink(target, link_name)<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.symlink(os.path.basename(tar=
get), link_name)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except FileExistsError:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br>
<br>
-- <br>
2.25.1<br>
<br>
<br>
<br>
<br>
</blockquote></div>

--00000000000029164d05be3070ed--
