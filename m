Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CB2C433F5
	for <webhook@archiver.kernel.org>; Mon,  7 Mar 2022 23:18:03 +0000 (UTC)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com
 [209.85.167.42])
 by mx.groups.io with SMTP id smtpd.web10.2377.1646695082225206925
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Mar 2022 15:18:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=MxbNwh14;
 spf=pass (domain: gmail.com, ip: 209.85.167.42,
 mailfrom: quaresma.jose@gmail.com)
Received: by mail-lf1-f42.google.com with SMTP id h14so4052412lfk.11
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Mar 2022 15:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VNtbvJ2QtTpqXcnQl9GHnndjdWWQVVthCWGVPt0j7Nk=;
        b=MxbNwh14vqOc/ByREGdXIP8RkW+f/xj3sCrT24HdFQ+qwHX64vAZkSRU4oBLMWaEiE
         6DCRRZcV/sTBEyUU9p/c8rn139DTtB9uy+Ccu5QsPa9HH++XEM4K9b6HelD4JLRvpCtp
         ZjT1fz2MFV3XziExi9W/lCCDFDVpdSeYiRP65x75o09wq+KFTcN7r/dPEXVsmCAkIa02
         uUcuTBCvNb5cmN0dNKroBivHFV4/9Q2wOL7OBr3hOQ5jKWdF5+4VUrOWbvnMviQn2pKf
         Mmtbg2iJh0GxE2DyF5iqhN6OLzubwE5UrrRfuAh//wYqPf5Owc3GYnQCYF2l1Mj5W4CK
         Zl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VNtbvJ2QtTpqXcnQl9GHnndjdWWQVVthCWGVPt0j7Nk=;
        b=7/hQsEqJeX9GyDTA406YsE5flyVRES72a1pSPITrDIwF9kBDCQcZO7QEgTH/akKe8E
         rSlfPcKZJw7Hb4UZWzSVqtJTz8ThBiLQpLdwAPw3y9iWGFKIVdd9HvhXjuq/5oqCTblV
         d5Z3CHivSiUBbjL0T/0c/92ZEyro7V7dDRfAgsZdUHw+5SsAH0NzOHrBxV57kV+mBiRX
         GftlMAqMeb6t2BA3KJommVW7axwbRK5wwhd979ykFB4DQ+WpkGtB3qNXaNMRgwW6v391
         QLe+itFOg96cU22ypiN03V7yHNX3E8x4zjYXLmbv7zuvyTz0yOffub37SGaTHuIFonAc
         KFeQ==
X-Gm-Message-State: AOAM5316wZQEwWOh9pFbiWCqimEBQUF+geJ5PsunqGAxHhHVSAywQxD1
	s/fEERyTL3mTREWRYhoGtZt+E8CKjGlQWODvTfY=
X-Google-Smtp-Source: 
 ABdhPJyQ9pNz8NXaODG2nJvlOALc/uxtx3U6Tmxx7MWXKXlXisKtnH3RUAmY9jGlOAYkymJr408gY/j/A9q9lL5uNXs=
X-Received: by 2002:ac2:4855:0:b0:443:888e:5982 with SMTP id
 21-20020ac24855000000b00443888e5982mr9191721lfy.447.1646695079928; Mon, 07
 Mar 2022 15:17:59 -0800 (PST)
MIME-Version: 1.0
References: <20220306133526.442843-1-richard.purdie@linuxfoundation.org>
 <20220306133526.442843-2-richard.purdie@linuxfoundation.org>
In-Reply-To: <20220306133526.442843-2-richard.purdie@linuxfoundation.org>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Mon, 7 Mar 2022 23:17:48 +0000
Message-ID: 
 <CANPvuR=7K5bit7WQdNnGqfH4XjWZmNwayht7cKziY1FskFXCsw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/2] knotty: Improve setscene task display
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000004ae79505d9a913d4"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Mar 2022 23:18:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13438

--0000000000004ae79505d9a913d4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

The following patch on master next is very different from this one
https://git.yoctoproject.org/poky/commit/?h=3Dmaster-next&id=3D4639952adfe1=
39d91899cf9a58a9f165bfbfef58

Jose

Richard Purdie <richard.purdie@linuxfoundation.org> escreveu no dia
domingo, 6/03/2022 =C3=A0(s) 13:35:

> There is general agreement the current display of the total setscene and
> executed full tasks is confusing. Fixing it is tricky to be clear to new
> users whilst not wasting screen real estate for experienced users and not
> compromisng features like the progress bar.
>
> As a compromise, move the setscene total to the previous line making
> the status display a two line summary for interactive terminals. This
> makes it clear what two of the numbers represent (setscene task) whilst
> separating this out from the other items.
>
> Also tweak the non-interactive output to use a comma as a separator,
> the use of the forward slash was a poor choice.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/ui/knotty.py | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
> index 1bcdc0023a..b02e59c1fe 100644
> --- a/lib/bb/ui/knotty.py
> +++ b/lib/bb/ui/knotty.py
> @@ -276,11 +276,11 @@ class TerminalFilter(object):
>              print(content)
>          else:
>              if self.quiet:
> -                content =3D "Running tasks (%s of %s/%s of %s)" %
> (self.helper.setscene_current, self.helper.setscene_total,
> self.helper.tasknumber_current, self.helper.tasknumber_total)
> +                content =3D "Running tasks (%s of %s, %s of %s)" %
> (self.helper.setscene_current, self.helper.setscene_total,
> self.helper.tasknumber_current, self.helper.tasknumber_total)
>              elif not len(activetasks):
> -                content =3D "No currently running tasks (%s of %s/%s of
> %s)" % (self.helper.setscene_current, self.helper.setscene_total,
> self.helper.tasknumber_current, self.helper.tasknumber_total)
> +                content =3D "Setscene tasks: %s of %s\nNo currently runn=
ing
> tasks (%s of %s)" % (self.helper.setscene_current,
> self.helper.setscene_total, self.helper.tasknumber_current,
> self.helper.tasknumber_total)
>              else:
> -                content =3D "Currently %2s running tasks (%s of %s/%s of
> %s)" % (len(activetasks), self.helper.setscene_current,
> self.helper.setscene_total, self.helper.tasknumber_current,
> self.helper.tasknumber_total)
> +                content =3D "Setscene tasks: %s of %s\nCurrently %2s
> running tasks (%s of %s)" % (self.helper.setscene_current,
> self.helper.setscene_total, len(activetasks),
> self.helper.tasknumber_current, self.helper.tasknumber_total)
>              maxtask =3D self.helper.tasknumber_total
>              if not self.main_progress or self.main_progress.maxval !=3D
> maxtask:
>                  widgets =3D [' ', progressbar.Percentage(), ' ',
> progressbar.Bar()]
> --
> 2.32.0
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13417):
> https://lists.openembedded.org/g/bitbake-devel/message/13417
> Mute This Topic: https://lists.openembedded.org/mt/89588749/5052612
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> quaresma.jose@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--=20
Best regards,

Jos=C3=A9 Quaresma

--0000000000004ae79505d9a913d4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Richard,</div><div><br></div><div>The following pa=
tch on master next is very different=C2=A0from this one<br></div><div><div>=
<a href=3D"https://git.yoctoproject.org/poky/commit/?h=3Dmaster-next&amp;id=
=3D4639952adfe139d91899cf9a58a9f165bfbfef58">https://git.yoctoproject.org/p=
oky/commit/?h=3Dmaster-next&amp;id=3D4639952adfe139d91899cf9a58a9f165bfbfef=
58</a><br></div></div><div><br></div><div>Jose</div><div><br></div><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Richard Purdie &lt=
;<a href=3D"mailto:richard.purdie@linuxfoundation.org">richard.purdie@linux=
foundation.org</a>&gt; escreveu no dia domingo, 6/03/2022 =C3=A0(s) 13:35:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">There is general=
 agreement the current display of the total setscene and<br>
executed full tasks is confusing. Fixing it is tricky to be clear to new<br=
>
users whilst not wasting screen real estate for experienced users and not<b=
r>
compromisng features like the progress bar.<br>
<br>
As a compromise, move the setscene total to the previous line making<br>
the status display a two line summary for interactive terminals. This<br>
makes it clear what two of the numbers represent (setscene task) whilst<br>
separating this out from the other items.<br>
<br>
Also tweak the non-interactive output to use a comma as a separator,<br>
the use of the forward slash was a poor choice.<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<b=
r>
---<br>
=C2=A0lib/bb/ui/knotty.py | 6 +++---<br>
=C2=A01 file changed, 3 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py<br>
index 1bcdc0023a..b02e59c1fe 100644<br>
--- a/lib/bb/ui/knotty.py<br>
+++ b/lib/bb/ui/knotty.py<br>
@@ -276,11 +276,11 @@ class TerminalFilter(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print(content)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.quiet:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 content =3D &quot;=
Running tasks (%s of %s/%s of %s)&quot; % (self.helper.setscene_current, se=
lf.helper.setscene_total, self.helper.tasknumber_current, self.helper.taskn=
umber_total)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 content =3D &quot;=
Running tasks (%s of %s, %s of %s)&quot; % (self.helper.setscene_current, s=
elf.helper.setscene_total, self.helper.tasknumber_current, self.helper.task=
number_total)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0elif not len(activetasks):<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 content =3D &quot;=
No currently running tasks (%s of %s/%s of %s)&quot; % (self.helper.setscen=
e_current, self.helper.setscene_total, self.helper.tasknumber_current, self=
.helper.tasknumber_total)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 content =3D &quot;=
Setscene tasks: %s of %s\nNo currently running tasks (%s of %s)&quot; % (se=
lf.helper.setscene_current, self.helper.setscene_total, self.helper.tasknum=
ber_current, self.helper.tasknumber_total)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 content =3D &quot;=
Currently %2s running tasks (%s of %s/%s of %s)&quot; % (len(activetasks), =
self.helper.setscene_current, self.helper.setscene_total, self.helper.taskn=
umber_current, self.helper.tasknumber_total)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 content =3D &quot;=
Setscene tasks: %s of %s\nCurrently %2s running tasks (%s of %s)&quot; % (s=
elf.helper.setscene_current, self.helper.setscene_total, len(activetasks), =
self.helper.tasknumber_current, self.helper.tasknumber_total)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0maxtask =3D self.helper.tas=
knumber_total<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not self.main_progress o=
r self.main_progress.maxval !=3D maxtask:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0widgets =3D [=
&#39; &#39;, progressbar.Percentage(), &#39; &#39;, progressbar.Bar()]<br>
-- <br>
2.32.0<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#13417): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/13417" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/13417</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/89588749/5052=
612" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/89588749/5052612</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:quaresma.jose@gmail.com" target=3D=
"_blank">quaresma.jose@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr">Best regards,<div><br>Jos=C3=A9=
 Quaresma</div></div></div></div>

--0000000000004ae79505d9a913d4--

