Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500A2C433EF
	for <webhook@archiver.kernel.org>; Wed, 30 Mar 2022 17:24:16 +0000 (UTC)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com
 [209.85.167.50])
 by mx.groups.io with SMTP id smtpd.web09.795.1648661055262932774
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 30 Mar 2022 10:24:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=fsAj6tni;
 spf=pass (domain: gmail.com, ip: 209.85.167.50,
 mailfrom: quaresma.jose@gmail.com)
Received: by mail-lf1-f50.google.com with SMTP id k21so37025553lfe.4
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 30 Mar 2022 10:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aHxB2YvkDffbNVi8WbQ6WkdHJNgD/YNvfnAVuzeehjI=;
        b=fsAj6tni8cw/MuCUUoU+MhIk932SJgNCpJ1l7B6mvyCAtwW1U3dg3KZ+SJXAgVZAU7
         44XwV6Ve9uZ6Q/sPAOC1LjE7OKm8qYHeS7G9EKd/AEjWmd0xZBVhoe+D1CoCSt7W/qR6
         x8QaDr0jgP+O9E5MQO7tY7RkVGrR/65iAi4LxTFY1rHw2ZjEXHulaT5hRrT8APtf8yuK
         Z/BehWkRqajINzOMoHc/AH6q/eVSzXXfin0bK6BF+8mD1BC+cvNGjdA1Ee+AE6pLgdPO
         m1hYI6ZELDnjUAu68lLv6Mt/hxzdwn1zoFcAwYUvTycyGLpH8wAmLG4QzKNVZNAJtBQX
         QB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aHxB2YvkDffbNVi8WbQ6WkdHJNgD/YNvfnAVuzeehjI=;
        b=I30WAQheSwnUJVS9EElvQCxwCalAGc0ga8hb0Rz/N2P+dsn4e83//gT34PDcLwcJee
         9pqFJZCbon1OoXTWuxv6Dk7cGeiTcYdc4Tx53cf03MV0+gkyvRM0JVHdkmscJwJBVQ2S
         zbD4EdfpaBLoV7g7pSjqIbicp4doTR4lm4mo6Hfm/cxJWSXBFYP9RrFtb9+uzUyzSSq/
         spNmAHk2f/Onz8pP7P4FLAIFdkAu295VeotLIxIX0a9N5l+g6R12PRXSbO+Qbinx7VF+
         jLnbMASZSd9WTClT+EXpdnFpAu4/NArFVaO0NMOUXSf7AtVpZv7s8Nx7ogP0XPGaaZea
         8igw==
X-Gm-Message-State: AOAM531c+YBcZiigpHy5Hk7J9mvZc4n2UlHVn6DVeuYlGqT5l/zNZikQ
	it/EvOWN4/gmMsXxL6wIVlXTyVh1QLy2Isp4Bmo=
X-Google-Smtp-Source: 
 ABdhPJyYgPbCipDeXFyXf/Mxs9bATMlGEXjyf67/Jp6xec16iDc0kHLKY1is6KQfobioJWHWpCedPxssqCoq19TZLKs=
X-Received: by 2002:a19:6709:0:b0:448:3162:d843 with SMTP id
 b9-20020a196709000000b004483162d843mr7566336lfc.95.1648661053352; Wed, 30 Mar
 2022 10:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648658231.git.steve@sakoman.com>
 <2cfc128b583a6e7f44f095fff0cd1e4e937f3790.1648658231.git.steve@sakoman.com>
In-Reply-To: 
 <2cfc128b583a6e7f44f095fff0cd1e4e937f3790.1648658231.git.steve@sakoman.com>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Wed, 30 Mar 2022 18:24:02 +0100
Message-ID: 
 <CANPvuRkACMYMoQVm_GPNoZ88bdNRk_E0azGv=t9_e1b_A8=PEg@mail.gmail.com>
Subject: Re: [bitbake-devel] [bitbake][dunfell][1.46][PATCH 1/1] fetch2: add
 check for empty SRC_URI hash string
To: Steve Sakoman <steve@sakoman.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000070aef105db72d08a"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 30 Mar 2022 17:24:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13553

--00000000000070aef105db72d08a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steve,

Thanks for that, this will improve some errors reporting on the fetch.

Acked-by: Jose Quaresma <quaresma.jose@gmail.com>

Jose

Steve Sakoman <steve@sakoman.com> escreveu no dia quarta, 30/03/2022 =C3=A0=
(s)
17:39:

> From: Scott Weaver <weaverjs@gmail.com>
>
> No error was being reported when the hash string was set to empty.
> For example: SRC_URI[md5sum] =3D ""
>
> On a related note (not a bug):
> Because whitespace in the string will result in a checksum mismatch, the
> error
> message was updated to make it a little clearer why the error was thrown.
> For example: SRC_URI[md5sum] =3D " " or
> SRC_URI[md5sum] =3D " 209f8326f5137d8817a6276d9577a2f1"
>
> Now creates a message like this:
> File: '/home/scott/yocto-cache/downloads/rsync-3.2.3.tar.gz' has md5
> checksum '209f8326f5137d8817a6276d9577a2f1' when '
> 209f8326f5137d8817a6276d9577a2f1' was expected
>
> [YOCTO #14232]
>
> Signed-off-by: Scott Weaver <weaverjs@gmail.com>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> (cherry picked from commit a13510d0028e234ea2f4744b0d0c38558395c70f)
> Signed-off-by: Steve Sakoman <steve@sakoman.com>
> ---
>  lib/bb/fetch2/__init__.py | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index dc99914c..3e6555bd 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -562,6 +562,9 @@ def verify_checksum(ud, d, precomputed=3D{}):
>
>          checksum_expected =3D getattr(ud, "%s_expected" % checksum_id)
>
> +        if checksum_expected =3D=3D '':
> +            checksum_expected =3D None
> +
>          return {
>              "id": checksum_id,
>              "name": checksum_name,
> @@ -612,7 +615,7 @@ def verify_checksum(ud, d, precomputed=3D{}):
>
>      for ci in checksum_infos:
>          if ci["expected"] and ci["expected"] !=3D ci["data"]:
> -            messages.append("File: '%s' has %s checksum %s when %s was "=
 \
> +            messages.append("File: '%s' has %s checksum '%s' when '%s'
> was " \
>                              "expected" % (ud.localpath, ci["id"],
> ci["data"], ci["expected"]))
>              bad_checksum =3D ci["data"]
>
> --
> 2.25.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13552):
> https://lists.openembedded.org/g/bitbake-devel/message/13552
> Mute This Topic: https://lists.openembedded.org/mt/90135601/5052612
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> quaresma.jose@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--=20
Best regards,

Jos=C3=A9 Quaresma

--00000000000070aef105db72d08a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Steve,</div><div><br></div><div>Thanks=C2=A0for th=
at, this will improve some errors reporting on the fetch.</div><div><br></d=
iv><div>Acked-by: Jose Quaresma &lt;<a href=3D"mailto:quaresma.jose@gmail.c=
om">quaresma.jose@gmail.com</a>&gt;</div><div>=C2=A0<br></div>Jose<div><br>=
<div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Steve Sako=
man &lt;<a href=3D"mailto:steve@sakoman.com">steve@sakoman.com</a>&gt; escr=
eveu no dia quarta, 30/03/2022 =C3=A0(s) 17:39:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">From: Scott Weaver &lt;<a href=3D"mailto:w=
eaverjs@gmail.com" target=3D"_blank">weaverjs@gmail.com</a>&gt;<br>
<br>
No error was being reported when the hash string was set to empty.<br>
For example: SRC_URI[md5sum] =3D &quot;&quot;<br>
<br>
On a related note (not a bug):<br>
Because whitespace in the string will result in a checksum mismatch, the er=
ror<br>
message was updated to make it a little clearer why the error was thrown.<b=
r>
For example: SRC_URI[md5sum] =3D &quot; &quot; or<br>
SRC_URI[md5sum] =3D &quot; 209f8326f5137d8817a6276d9577a2f1&quot;<br>
<br>
Now creates a message like this:<br>
File: &#39;/home/scott/yocto-cache/downloads/rsync-3.2.3.tar.gz&#39; has md=
5<br>
checksum &#39;209f8326f5137d8817a6276d9577a2f1&#39; when &#39; 209f8326f513=
7d8817a6276d9577a2f1&#39; was expected<br>
<br>
[YOCTO #14232]<br>
<br>
Signed-off-by: Scott Weaver &lt;<a href=3D"mailto:weaverjs@gmail.com" targe=
t=3D"_blank">weaverjs@gmail.com</a>&gt;<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<b=
r>
(cherry picked from commit a13510d0028e234ea2f4744b0d0c38558395c70f)<br>
Signed-off-by: Steve Sakoman &lt;<a href=3D"mailto:steve@sakoman.com" targe=
t=3D"_blank">steve@sakoman.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/fetch2/__init__.py | 5 ++++-<br>
=C2=A01 file changed, 4 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py<br>
index dc99914c..3e6555bd 100644<br>
--- a/lib/bb/fetch2/__init__.py<br>
+++ b/lib/bb/fetch2/__init__.py<br>
@@ -562,6 +562,9 @@ def verify_checksum(ud, d, precomputed=3D{}):<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0checksum_expected =3D getattr(ud, &quot;%=
s_expected&quot; % checksum_id)<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if checksum_expected =3D=3D &#39;&#39;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 checksum_expected =3D None<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;id&quot;: checksum_id=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;name&quot;: checksum_=
name,<br>
@@ -612,7 +615,7 @@ def verify_checksum(ud, d, precomputed=3D{}):<br>
<br>
=C2=A0 =C2=A0 =C2=A0for ci in checksum_infos:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ci[&quot;expected&quot;] and ci[&quot;=
expected&quot;] !=3D ci[&quot;data&quot;]:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 messages.append(&quot;File: &#39=
;%s&#39; has %s checksum %s when %s was &quot; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 messages.append(&quot;File: &#39=
;%s&#39; has %s checksum &#39;%s&#39; when &#39;%s&#39; was &quot; \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;expected&quot; % (ud.localpath, ci[&qu=
ot;id&quot;], ci[&quot;data&quot;], ci[&quot;expected&quot;]))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bad_checksum =3D ci[&quot;d=
ata&quot;]<br>
<br>
-- <br>
2.25.1<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#13552): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/13552" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/13552</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/90135601/5052=
612" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/90135601/5052612</a><br>
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
 Quaresma</div></div></div></div></div>

--00000000000070aef105db72d08a--

