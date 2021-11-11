Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E88DC433EF
	for <webhook@archiver.kernel.org>; Thu, 11 Nov 2021 11:00:01 +0000 (UTC)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com
 [209.85.167.41])
 by mx.groups.io with SMTP id smtpd.web12.8956.1636628399894198069
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Nov 2021 03:00:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=ShzX0POS;
 spf=pass (domain: gmail.com, ip: 209.85.167.41,
 mailfrom: quaresma.jose@gmail.com)
Received: by mail-lf1-f41.google.com with SMTP id n12so3595570lfe.1;
        Thu, 11 Nov 2021 02:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HC/mz+LVjEIkR05QYL9Ok49aAo4tKm+Wrs09qAZhs9k=;
        b=ShzX0POSPwInySHSCgA5pe2eDO9w8mCq95uew8OT47vDa/NLpJUnX2e7BjeWgNt4/Q
         96Sb1wOqSnhr5YnNvOGN1pg3PwZZ1JMWDDqKCr3QZ7IgI7wDTTwfzuqhS4HyOKzBzZG4
         agT5Fn8FJp4NZ3DkdlxpgrXZwSI9CvHQj+Prdmfh6eH+JBCaQbtKPk5OEEbVFUxZg6xK
         iafRqmQ9hXnoO43PYIfkspSinvUp83E88cZi1eD2uDkheccZ7kmNJT6mW7EzW56yIwRf
         ys4dyqf4C4+2YbBXru0qlXBYUGnQL40ih2wBu3gZol6mqrPNKYV4jZPXvCHp1u5GL7Jy
         cq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HC/mz+LVjEIkR05QYL9Ok49aAo4tKm+Wrs09qAZhs9k=;
        b=s5dbj+LhZ9J+fHJK85yXvXpeHTVk6on1c7rcTx3AYdvTS65VixclS9SanPW7lqodS4
         ulKeWZjqvT5sdphseHzncSej2CdOT7fOdSWB6ThU4F7o6VuYdYxxANEQtPv79P3mftSL
         X6L7IjpEqaFQEMca7TXS87qGEL4rkbJAadc1ZTxYfCjbI682xEv2XJy34BqfhllJsff4
         RvoYFP2XfbFpo80mRsOcdBOSE1770v3tXb7n4GmXtaOAMfOlr+zLTfwuyzQdcAfhXiAC
         mkq5tBp1NcxpeAmnxHUHCsCfL7uxIbqkdN6lANCMGJaukNP2e/98RrWq9CNkxYn65V5P
         PtrQ==
X-Gm-Message-State: AOAM532GjrcCMBo7NvhvsJ0uUWHU+0GFh4YzCwAh1YFBSb2i5sTbxe7r
	0RwRxCT2bwJn/MmMhgrkFgRkItG0asPJLVunSDY=
X-Google-Smtp-Source: 
 ABdhPJytVu59v0L+cCCZrhpCNr+Gy+/Y13j/FUihKjmZHqfVYRppqClNax6DxMQjBx8B9sDl5WbJDzvkt03Bx2xzoTM=
X-Received: by 2002:a05:6512:3cf:: with SMTP id
 w15mr5823078lfp.555.1636628397770;
 Thu, 11 Nov 2021 02:59:57 -0800 (PST)
MIME-Version: 1.0
References: <20211111102124.7661-1-jasper@fancydomain.eu>
 <20211111102124.7661-2-jasper@fancydomain.eu>
In-Reply-To: <20211111102124.7661-2-jasper@fancydomain.eu>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Thu, 11 Nov 2021 10:59:46 +0000
Message-ID: 
 <CANPvuRkVr0c7Nm3_WFU86Ep6Lum0Vf70ajmeUaXOr2DTQbzJjQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [oe-core][PATCH v5 2/2] base.bbclass: Add sysroot
 deps for repo fetcher
To: jasper@fancydomain.eu
Cc: OE-core <openembedded-core@lists.openembedded.org>, martin@mko.dev,
	Daniel.Baumgart@iris-sensing.com, bitbake-devel@lists.openembedded.org,
	Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
Content-Type: multipart/alternative; boundary="000000000000474d1305d0813ebf"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Nov 2021 11:00:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13006

--000000000000474d1305d0813ebf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jasper Orschulko via lists.openembedded.org <jasper=3D
fancydomain.eu@lists.openembedded.org> escreveu no dia quinta, 11/11/2021
=C3=A0(s) 10:22:

> From: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
>
> Add git-native and repo-native as prerequisite for the repo fetcher.
>
> Signed-off-by: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
> ---
>  meta/classes/base.bbclass | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/meta/classes/base.bbclass b/meta/classes/base.bbclass
> index a65fcc6c1d..3298bd1952 100644
> --- a/meta/classes/base.bbclass
> +++ b/meta/classes/base.bbclass
> @@ -665,6 +665,11 @@ python () {
>          elif uri.scheme =3D=3D "npm":
>              d.appendVarFlag('do_fetch', 'depends', '
> nodejs-native:do_populate_sysroot')
>
> +        elif uri.scheme =3D=3D "repo":
> +            needsrcrev =3D True
> +            d.appendVarFlag('do_fetch', 'depends', '
> repo-native:do_populate_sysroot')
> +            d.appendVarFlag('do_fetch', 'depends', '
> git-native:do_populate_sysroot')
>

Please remove git and add it as a runtime dependency of the repo.

Jose

+
>          # *.lz4 should DEPEND on lz4-native for unpacking
>          if path.endswith('.lz4'):
>              d.appendVarFlag('do_unpack', 'depends', '
> lz4-native:do_populate_sysroot')
> --
> 2.33.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13004):
> https://lists.openembedded.org/g/bitbake-devel/message/13004
> Mute This Topic: https://lists.openembedded.org/mt/86978424/5052612
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> quaresma.jose@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--=20
Best regards,

Jos=C3=A9 Quaresma

--000000000000474d1305d0813ebf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Jasper Orschulko via <a href=3D"http:=
//lists.openembedded.org" target=3D"_blank">lists.openembedded.org</a> &lt;=
jasper=3D<a href=3D"mailto:fancydomain.eu@lists.openembedded.org" target=3D=
"_blank">fancydomain.eu@lists.openembedded.org</a>&gt; escreveu no dia quin=
ta, 11/11/2021 =C3=A0(s) 10:22:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">From: Jasper Orschulko &lt;<a href=3D"mailto:Jasper.Orschul=
ko@iris-sensing.com" target=3D"_blank">Jasper.Orschulko@iris-sensing.com</a=
>&gt;<br>
<br>
Add git-native and repo-native as prerequisite for the repo fetcher.<br>
<br>
Signed-off-by: Jasper Orschulko &lt;<a href=3D"mailto:Jasper.Orschulko@iris=
-sensing.com" target=3D"_blank">Jasper.Orschulko@iris-sensing.com</a>&gt;<b=
r>
---<br>
=C2=A0meta/classes/base.bbclass | 5 +++++<br>
=C2=A01 file changed, 5 insertions(+)<br>
<br>
diff --git a/meta/classes/base.bbclass b/meta/classes/base.bbclass<br>
index a65fcc6c1d..3298bd1952 100644<br>
--- a/meta/classes/base.bbclass<br>
+++ b/meta/classes/base.bbclass<br>
@@ -665,6 +665,11 @@ python () {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0elif uri.scheme =3D=3D &quot;npm&quot;:<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0d.appendVarFlag(&#39;do_fet=
ch&#39;, &#39;depends&#39;, &#39; nodejs-native:do_populate_sysroot&#39;)<b=
r>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif uri.scheme =3D=3D &quot;repo&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 needsrcrev =3D True<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d.appendVarFlag(&#39;do_fetch&#3=
9;, &#39;depends&#39;, &#39; repo-native:do_populate_sysroot&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d.appendVarFlag(&#39;do_fetch&#3=
9;, &#39;depends&#39;, &#39; git-native:do_populate_sysroot&#39;)<br></bloc=
kquote><div><br></div><div>Please remove git and add it as a runtime depend=
ency=C2=A0of the repo.</div><div><br></div><div>Jose</div><div><br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# *.lz4 should DEPEND on lz4-native for u=
npacking<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if path.endswith(&#39;.lz4&#39;):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0d.appendVarFlag(&#39;do_unp=
ack&#39;, &#39;depends&#39;, &#39; lz4-native:do_populate_sysroot&#39;)<br>
-- <br>
2.33.1<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#13004): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/13004" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/13004</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/86978424/5052=
612" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/86978424/5052612</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:quaresma.jose@gmail.com" target=3D=
"_blank">quaresma.jose@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
><div dir=3D"ltr">Best regards,<div><br>Jos=C3=A9 Quaresma</div></div></div=
></div>

--000000000000474d1305d0813ebf--

