Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64042C25B7E
	for <webhook@archiver.kernel.org>; Thu, 30 May 2024 17:11:56 +0000 (UTC)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
 by mx.groups.io with SMTP id smtpd.web11.2400.1717089114399707531
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 May 2024 10:11:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=SdvtLHCM;
 spf=pass (domain: gmail.com, ip: 209.85.167.42, mailfrom: ticotimo@gmail.com)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52ab1d7243fso1692005e87.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 30 May 2024 10:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717089112; x=1717693912; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+6Du4MFOUeiS2gKvxP9hH4vzMZJGY8Ka5AXZe7QDeRU=;
        b=SdvtLHCMHl+wwkyR//R67ECd9Tmp946VzMgtapJWcMTjDjU9VXY8DBg8SgXpSYaj4z
         u/AFneP9I5VkqpSXsxJki8RlBb2ZHROgYtRJTxwf0R5pS8I7aJlM9ZerdrvCyBDDX6x5
         t2lNsJlWEIAGZsfCkxO5wjicThHKrpu+WJHYFPUaAPA1YLcI3CdXMY8ud/ULz51mugBC
         LK4O50wvyVROyAgyk6ZaE+1fHurYS204srB+/h/Q1Vaf1XDnojd3SUrL/MLCWS31hVl3
         /TfdSUWstyKQJRlLWC9SNsxn+8GwLm/LTMBeW+JstulgChdXYMny+Bo8d/7WeXKQDb2f
         t4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717089112; x=1717693912;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+6Du4MFOUeiS2gKvxP9hH4vzMZJGY8Ka5AXZe7QDeRU=;
        b=W2RQenL0xnb4b8RVE6xuNsZmhBangxl2owmRJ0+jRwb8jpbtZ2KY80PuUmUAceKI2l
         lAc/3L9+KEQHvX1deN3bk3QDmrhDSZBkHrRzsZeQT/1UUTvf9vP8maNNOiTa8BwKioD+
         zGHCCoMDT1OcvH5fOEDgiOPGCvtx5btZobShlypJtoUDwYdaKBB02lz3j5KOjWoN/7w+
         T5iZWFad7aUAra74eTekm76STWzjg9iOoxW5OwAN0NBqXGJ2eJWh/u7pzLH+IpEWwDjx
         MhDRutRQ9eMyiGzPVIRcWQagv9yOkIzqyLxaVRqakZ01qMQTxbDhKRWWojccz39mCnie
         s6rg==
X-Gm-Message-State: AOJu0Yz1rO0gXy1z/Ssu6ekZS4lLl49lBDRIV530ehUgLKb1ApbwNJ9+
	x+Wfikju6jeW0z+bjwfqpGfo4Ld3PKF4tvdWHKD8qR+IvXwW23cZcvqAzskbFHQKO4dgEmF6Coc
	cfHKMZT1fcHtzGOcxRYPzIXkg6pM=
X-Google-Smtp-Source: AGHT+IH+binkEt+j1r00GOB+t8QBpXLTJdcZBfEj/C5fW40ihcAHVo0B7ZXPIVJMHbAGvumyHa5jCz1jmZts6I9ss+c=
X-Received: by 2002:ac2:4c23:0:b0:52b:796f:8af5 with SMTP id
 2adb3069b0e04-52b7d428a90mr1768997e87.34.1717089112236; Thu, 30 May 2024
 10:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240530165719.3115747-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20240530165719.3115747-1-richard.purdie@linuxfoundation.org>
From: Tim Orling <ticotimo@gmail.com>
Date: Thu, 30 May 2024 10:11:39 -0700
Message-ID: <CANx9H-CNpuKK6u8ALOaUDdD02DpqmyyT1qO9kp5Es2EYxCyQ7A@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2/wget: Fix failure path for files
 that are empty or don't exist
To: richard.purdie@linuxfoundation.org
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000952f3f0619aef6dc"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 30 May 2024 17:11:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16294

--000000000000952f3f0619aef6dc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 9:57=E2=80=AFAM Richard Purdie via lists.openembedd=
ed.org
<richard.purdie=3Dlinuxfoundation.org@lists.openembedded.org> wrote:

> When we intercepted the file download to a temp file, we broke the
> exist/size checks which need to happen before the rename. Correct
> the ordering.
>
> For some reason, python 3.12 exposes this problem in the selftests
> differently to previous versions.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/fetch2/wget.py | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
> index fbfa6938ac..3c213370b5 100644
> --- a/lib/bb/fetch2/wget.py
> +++ b/lib/bb/fetch2/wget.py
> @@ -139,19 +139,19 @@ class Wget(FetchMethod):
>          # source, one with an incorrect checksum)
>          bb.fetch2.verify_checksum(ud, d, localpath=3Dlocalpath,
> fatal_nochecksum=3DFalse)
>
> -        # Remove the ".tmp" and move the file into position atomically
> -        # Our lock prevents multiple writers but mirroring code may grab
> incomplete files
> -        os.rename(localpath, localpath[:-4])
> -
>          # Sanity check since wget can pretend it succeed when it didn't
>          # Also, this used to happen if sourceforge sent us to the mirror
> page
> -        if not os.path.exists(ud.localpath):
> +        if not os.path.exists(localpath):
>              raise FetchError("The fetch command returned success for url
> %s but %s doesn't exist?!" % (uri, ud.localpath), uri)
>

Do we also want to change 'ud.localpath' to 'localpath' in the FetchError
message?


>
> -        if os.path.getsize(ud.localpath) =3D=3D 0:
> -            os.remove(ud.localpath)
> +        if os.path.getsize(localpath) =3D=3D 0:
> +            os.remove(localpath)
>              raise FetchError("The fetch of %s resulted in a zero size
> file?! Deleting and failing since this isn't right." % (uri), uri)
>
> +        # Remove the ".tmp" and move the file into position atomically
> +        # Our lock prevents multiple writers but mirroring code may grab
> incomplete files
> +        os.rename(localpath, localpath[:-4])
> +
>          return True
>
>      def checkstatus(self, fetch, ud, d, try_again=3DTrue):
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16293):
> https://lists.openembedded.org/g/bitbake-devel/message/16293
> Mute This Topic: https://lists.openembedded.org/mt/106392412/924729
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> ticotimo@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000952f3f0619aef6dc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, May 30, 2024 at 9:57=E2=80=AF=
AM Richard Purdie via <a href=3D"http://lists.openembedded.org">lists.opene=
mbedded.org</a> &lt;richard.purdie=3D<a href=3D"mailto:linuxfoundation.org@=
lists.openembedded.org">linuxfoundation.org@lists.openembedded.org</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">When we i=
ntercepted the file download to a temp file, we broke the<br>
exist/size checks which need to happen before the rename. Correct<br>
the ordering.<br>
<br>
For some reason, python 3.12 exposes this problem in the selftests<br>
differently to previous versions.<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<b=
r>
---<br>
=C2=A0lib/bb/fetch2/wget.py | 14 +++++++-------<br>
=C2=A01 file changed, 7 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py<br>
index fbfa6938ac..3c213370b5 100644<br>
--- a/lib/bb/fetch2/wget.py<br>
+++ b/lib/bb/fetch2/wget.py<br>
@@ -139,19 +139,19 @@ class Wget(FetchMethod):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# source, one with an incorrect checksum)=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.fetch2.verify_checksum(ud, d, localpat=
h=3Dlocalpath, fatal_nochecksum=3DFalse)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Remove the &quot;.tmp&quot; and move the fil=
e into position atomically<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Our lock prevents multiple writers but mirro=
ring code may grab incomplete files<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 os.rename(localpath, localpath[:-4])<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Sanity check since wget can pretend it =
succeed when it didn&#39;t<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Also, this used to happen if sourceforg=
e sent us to the mirror page<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not os.path.exists(ud.localpath):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not os.path.exists(localpath):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise FetchError(&quot;The =
fetch command returned success for url %s but %s doesn&#39;t exist?!&quot; =
% (uri, ud.localpath), uri)<br></blockquote><div><br></div><div>Do we also =
want to change &#39;ud.localpath&#39; to &#39;localpath&#39; in the FetchEr=
ror message?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if os.path.getsize(ud.localpath) =3D=3D 0:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.remove(ud.localpath)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if os.path.getsize(localpath) =3D=3D 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.remove(localpath)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise FetchError(&quot;The =
fetch of %s resulted in a zero size file?! Deleting and failing since this =
isn&#39;t right.&quot; % (uri), uri)<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Remove the &quot;.tmp&quot; and move the fil=
e into position atomically<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Our lock prevents multiple writers but mirro=
ring code may grab incomplete files<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 os.rename(localpath, localpath[:-4])<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return True<br>
<br>
=C2=A0 =C2=A0 =C2=A0def checkstatus(self, fetch, ud, d, try_again=3DTrue):<=
br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#16293): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/16293" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/16293</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/106392412/924=
729" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/106392412/924729</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:ticotimo@gmail.com" target=3D"_bla=
nk">ticotimo@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--000000000000952f3f0619aef6dc--

