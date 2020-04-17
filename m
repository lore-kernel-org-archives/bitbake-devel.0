Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
 by mx.groups.io with SMTP id smtpd.web12.1804.1587149627671429271
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Apr 2020 11:53:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=JyBuSfNM;
 spf=pass (domain: gmail.com, ip: 209.85.217.54, mailfrom: alex.kanavin@gmail.com)
Received: by mail-vs1-f54.google.com with SMTP id g184so1847998vsc.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 17 Apr 2020 11:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wJzKB7B0sphezWmJEWbmMJJDzC4IBKKHWexZaH8Q5Hs=;
        b=JyBuSfNMLGGqONvg5naFHovpKWiBPaGzCHfFsnxD03uUK93do7fBmGMiJz1unW7Sb3
         LW608YgFsVIzKuIs3vLVLiZWgEx8RzSnMtf2mwXr3FoYImTsDUrTJaOt5lriK4BmY0s1
         UTASiB18CVO6ADuGt1X/825f/nHcrM4G7vv6SAkmbQtKkK0JXy7DKMqFbKHux2xztoz9
         UO78r456aQyqHi7vNDV2xnb1mTeNCZuNuTA8LvyMMXlY+0eAS74znXFfcd8tD1za6XGX
         7ov/0dh4Qe4SoQmDx0rr3PAELKKoLbUKRpeKwtjMLQXTJiD6MVBuVcXCHe4D/XYdy6UH
         Y34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wJzKB7B0sphezWmJEWbmMJJDzC4IBKKHWexZaH8Q5Hs=;
        b=nBO5Geniu+Yu5nFxh0GukzSgIWsgMa2UIjfz0if3RXCGtnB0T26r+WQO6aL6910ZMa
         46CM6A+GtXFtl9CaeOByUQ07el6x83tj60FkJoVuuNWj/YhBMdsFs9josXeNqNpmUt3l
         xHVfDGqbDsFaEPFzVt0avYF7DlxJwzz+OsuAJ85eFag3MRmEPHHiMqIJa0uwn02/vjDC
         k4562KDnWPMV8THcNOOM66enlrSgm2n8x/eu2j1G36RfPe617n4kaPxlTVn0ykPqYW2D
         3yiRxo61nwzyJ5F3fohBUHpZfiPIRb9LIIlzTbeFnSxjn+5Qwnk9E87Vn7SfmLJOWbwB
         zxhQ==
X-Gm-Message-State: AGi0PuYHqArnZcNZQ+G3ERi7zT68fvOJaTzCnqaEZEX/f5AnTg+PtEnd
	GYRFCMXgRK6DcAs1zde7WrMLJ5BeyI1fOPtFUhw=
X-Google-Smtp-Source: APiQypIgJDixZOXDeFAocLoFwWtl8aFfj0u4k+3+XIfbIeSZ3/4u7szBFAFphirzjL80a7w+V6VsGAsmosOtyM1VIIw=
X-Received: by 2002:a67:7d10:: with SMTP id y16mr3849892vsc.23.1587149626841;
 Fri, 17 Apr 2020 11:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <Gw3N.1587149101751917659.pi0R@lists.openembedded.org>
In-Reply-To: <Gw3N.1587149101751917659.pi0R@lists.openembedded.org>
From: "Alexander Kanavin" <alex.kanavin@gmail.com>
Date: Fri, 17 Apr 2020 20:53:34 +0200
Message-ID: <CANNYZj_NSKqs6E6sR1yMgFBohCg1W-Wdbh20rcJHEsQuJrt8ig@mail.gmail.com>
Subject: Re: [bitbake-devel] Significance of "SRCREV_FORMAT" variable for multiple sources fetch
To: abhishek.shah@broadcom.com
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000b69f6405a3811165"

--000000000000b69f6405a3811165
Content-Type: text/plain; charset="UTF-8"

Which Yocto version are you on? Zeus and later is probably ok, earlier
versions is not, as do_fetch task hash in the older versions does not
include all the SRCREV variations, only the combined SRCPV. So if you
change one of the SRCREV, it will erroneously not rebuild.

Alex

On Fri, 17 Apr 2020 at 20:45, Abhishek Shah via lists.openembedded.org
<abhishek.shah=broadcom.com@lists.openembedded.org> wrote:

> Hi,
>
> We have a recipe, which has multiple SRC_URI. For each SRC_URI, we have
> specified SRCREV using SRCREV_name.
>
> I am facing issue when trying to add one more SRC_URI:
>
> While adding new source, I am updating SRCREV_FORMAT variable.
> This causea lengthening of PATH where all the fetched source are
> downloaded.
> For example, if earlier location was
>
> tmp/yocto_build/poky/build/tmp/work/aarch64-poky-linux/xxx/gitAUTOINC+a20a30cd86_dbbf7c9b30_f3635d87f4_90d93a11ba_ae871b61ae_5ba575618e-r0/git/
> new location would be elongated something like:
>
> tmp/yocto_build/poky/build/tmp/work/aarch64-poky-linux/xxx/gitAUTOINC+a20a30cd86_
> bfa48a337e_dbbf7c9b30_f3635d87f4_90d93a11ba_ae871b61ae_5ba575618e-r0/git/
>
> One of the source is using a Python script, which is using absolute PATH
> to create a symlink.
> Because of elongated PATH, I get below error:
> os.symlink(directory, symlink)
> OSError: [Errno 36] File name too long
>
> If I don't update SRCREV_FORMAT variable even after adding new source, I
> do not see above issue.
>
> So, the question is, is that okay if we do not update SRCREV_FORMAT  when
> adding new SRC_URI in the bitbake recipe? 
>

--000000000000b69f6405a3811165
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Which Yocto version are you on? Zeus and later is pro=
bably ok, earlier versions is not, as do_fetch task hash in the older versi=
ons does not include all the SRCREV variations, only the combined SRCPV. So=
 if you change one of the SRCREV, it will erroneously not rebuild.<br></div=
><div><br></div><div>Alex<br></div></div><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Fri, 17 Apr 2020 at 20:45, Abhishek S=
hah via <a href=3D"http://lists.openembedded.org">lists.openembedded.org</a=
> &lt;abhishek.shah=3D<a href=3D"mailto:broadcom.com@lists.openembedded.org=
">broadcom.com@lists.openembedded.org</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">Hi,<br><br>We have a recipe, which has=
 multiple SRC_URI. For each SRC_URI, we have specified=C2=A0SRCREV using SR=
CREV_name.<br><br>I am facing issue when trying to add one more SRC_URI:<br=
><br>While adding new source, I am updating=C2=A0SRCREV_FORMAT variable.<br=
>This causea lengthening of PATH where all the fetched source are downloade=
d.<br>For example, if earlier location was<br><span style=3D"color:rgb(0,0,=
0);font-family:&quot;Courier New&quot;,Courier,monospace;font-size:11.2px;w=
hite-space:pre-wrap">tmp/yocto_build/poky/build/tmp/work/aarch64-poky-linux=
/xxx/gitAUTOINC+a20a30cd86_dbbf7c9b30_f3635d87f4_90d93a11ba_ae871b61ae_5ba5=
75618e-r0/git/</span><br>new location would be elongated something like:<br=
><span style=3D"color:rgb(0,0,0);font-family:&quot;Courier New&quot;,Courie=
r,monospace;font-size:11.2px;white-space:pre-wrap">tmp/yocto_build/poky/bui=
ld/tmp/work/aarch64-poky-linux/xxx/gitAUTOINC+a20a30cd86_</span><span style=
=
=3D"color:rgb(0,0,0);font-family:&quot;Courier New&quot;,Courier,monospace=
;font-size:11.2px;white-space:pre-wrap">bfa48a337e_</span><span style=3D"co=
lor:rgb(0,0,0);font-family:&quot;Courier New&quot;,Courier,monospace;font-s=
ize:11.2px;white-space:pre-wrap">dbbf7c9b30_f3635d87f4_90d93a11ba_ae871b61a=
e_5ba575618e-r0/git/<br></span><br>One of the source is using a Python scri=
pt, which is using absolute PATH to create a symlink.<br>Because of elongat=
ed PATH, I get below error:<br><span style=3D"color:rgb(0,0,0);font-family:=
&quot;Courier New&quot;,Courier,monospace;font-size:11.2px;white-space:pre-=
wrap">os.symlink(directory, symlink)</span><br style=3D"color:rgb(0,0,0);fo=
nt-family:&quot;Courier New&quot;,Courier,monospace;font-size:11.2px;white-=
space:pre-wrap"><span style=3D"color:rgb(0,0,0);font-family:&quot;Courier N=
ew&quot;,Courier,monospace;font-size:11.2px;white-space:pre-wrap">OSError: =
[Errno 36] File name too long<br><br></span>If I don&#39;t update SRCREV_FO=
RMAT=C2=A0variable even after adding new source, I do not see above issue.<=
br><br>So, the question is, is that okay if we do not update SRCREV_FORMAT=
=C2=A0 when adding new SRC_URI in the bitbake recipe?
<br>
</blockquote></div>

--000000000000b69f6405a3811165--
