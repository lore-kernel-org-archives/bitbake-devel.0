Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D846AC05027
	for <webhook@archiver.kernel.org>; Tue, 14 Feb 2023 10:57:03 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web11.3775.1676372218486620867
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Feb 2023 02:56:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=aCDluL7j;
 spf=pass (domain: gmail.com, ip: 209.85.128.50, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f50.google.com with SMTP id bg5-20020a05600c3c8500b003e00c739ce4so11218809wmb.5
        for <bitbake-devel@lists.openembedded.org>; Tue, 14 Feb 2023 02:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sbzYoaekG8i4miKIRU43JlqV//RujnxxYzTXyaebm2o=;
        b=aCDluL7jiKWgt+SScuE5H1WiKd9aDS9bXKf5ZtNd/EN+qH8+5jfwPzMDbpRuObecZu
         V58aVpqduBDq4TIltBcrtvaL0TD+16nkJ5BpPlDPkh65WjgawaTN3774PB5zrcxgELuS
         xTzgdGr9pODAiqttv1bSdBCoLdz3woIOSie9o4bo0bjIe6mUTAbkTNbXlIUgHZqx/Xio
         PFqfj5oF83khJ1s0QY2G/Sg4sJbyDuNRLgE90E3J4kRvCDqPY9wE9AuqEQPrH2ify6eP
         ovPt62W3DGThJ7eO7YkvlIjWn0dYqs/GEO5tn4Pzx6tDLpNfMhaloeVDox2NZD2xrZ/M
         1FGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sbzYoaekG8i4miKIRU43JlqV//RujnxxYzTXyaebm2o=;
        b=t/fka3ZuJAHRN/5/DiCYClH/4Em8sYeQpGftc9ZxRX4Z2uTFljNkbKQEUPI/wzqpKz
         F8IRRwlsfsciFCZAyuyzy1Q45j38Hgk8Tsq5YAXhemBpjVTiEJdo0zZc9HQfMCmIgB8L
         2wqEZVlVo0gafAQi86q8o7REajckeUXXx10FMo1QBx0zCYRexoOBAnAReljxm0VLEyda
         c91TPTXyZshfpzb2UfPQkzYGyscmop4nBMJV2rtCd2R0RD9YAPcYxpMCPEx4I+7/0uAc
         Jllm5WRUCEYh2qhb18POP3tcUiElAG8Xh48zw6SXNPVoPJ/I5sQX9KW3xkMs8d2fniBA
         eQxg==
X-Gm-Message-State: AO0yUKW+JeHo/skYqbaZVgGiMAhLBaxgWxiI8eF1umr9nrUMPXxbMJ0A
	PnqKbYwrbyFSBNlOfZPa6aNAra6qcpsZMuO8BbE=
X-Google-Smtp-Source: AK7set+8DhKAd1i1x8GusBqSBLz7NHxGr/4kso87N2lIn1Z4r7KUJlEAk/krD6RdpYoSGQrzrczY0rSwSt7uWIRs0jM=
X-Received: by 2002:a05:600c:3c8e:b0:3df:fc66:254 with SMTP id
 bg14-20020a05600c3c8e00b003dffc660254mr1640915wmb.2.1676372216662; Tue, 14
 Feb 2023 02:56:56 -0800 (PST)
MIME-Version: 1.0
References: <20230214103441.1516378-1-ecordonnier@snap.com>
In-Reply-To: <20230214103441.1516378-1-ecordonnier@snap.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Tue, 14 Feb 2023 11:56:45 +0100
Message-ID: <CA+chaQcDfmRif6AEN-jAtBYy=fzXhnn6tNOVK7NmROG9k3XNdg@mail.gmail.com>
Subject: Re: [bitbake-devel] [kirkstone][2.0][PATCH] siggen: fix inefficient
 string concatenation
To: ecordonnier@snap.com
Cc: bitbake-devel@lists.openembedded.org, JJ Robertson <jrobertson@snap.com>
Content-Type: multipart/alternative; boundary="0000000000007c4de205f4a6d286"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 Feb 2023 10:57:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14405

--0000000000007c4de205f4a6d286
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This might help with:
https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D14942

will test it on my testcase with 380227 paths and update the ticket if this
helps.

On Tue, Feb 14, 2023 at 11:35 AM ecordonnier via lists.openembedded.org
<ecordonnier=3Dsnap.com@lists.openembedded.org> wrote:

> From: Etienne Cordonnier <ecordonnier@snap.com>
>
> As discussed in https://stackoverflow.com/a/4435752/1710392 , CPython
> has an optimization for statements in the form "a =3D a + b" or "a +=3D b=
".
> It seems that this line does not get optimized, because it has a form a =
=3D
> a + b + c:
> data =3D data + "./" + f.split("/./")[1]
>
> For that reason, it does a copy of data for each iteration, potentially
> copying megabytes
> of data for each iteration.
>
> Changing this line causes SignatureGeneratorBasic::get_taskhash to take
> 0.06 seconds
> instead of 45 seconds on my test setup where SRC_URI points to a big
> directory.
>
> Note that PEP8 recommends explicitely not to use this optimization which
> is specific to CPython:
> "do not rely on CPython=E2=80=99s efficient implementation of in-place st=
ring
> concatenation for statements in the form a +=3D b or a =3D a + b"
>
> However, the PEP8 recommended form using "join()" also does not avoid the
> copy and takes 45 seconds in my test setup:
> data =3D ''.join((data, "./", f.split("/./")[1]))
>
> I have changed the other lines to also use +=3D for consistency only,
> however those were in the form a =3D a + b
> and were optimized already.
>
> Co-authored-by: JJ Robertson <jrobertson@snap.com>
> Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
> ---
>  lib/bb/siggen.py | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
> index 130b38d8..2381edd2 100644
> --- a/lib/bb/siggen.py
> +++ b/lib/bb/siggen.py
> @@ -328,19 +328,19 @@ class SignatureGeneratorBasic(SignatureGenerator):
>
>          data =3D self.basehash[tid]
>          for dep in self.runtaskdeps[tid]:
> -            data =3D data + self.get_unihash(dep)
> +            data +=3D self.get_unihash(dep)
>
>          for (f, cs) in self.file_checksum_values[tid]:
>              if cs:
>                  if "/./" in f:
> -                    data =3D data + "./" + f.split("/./")[1]
> -                data =3D data + cs
> +                    data +=3D "./" + f.split("/./")[1]
> +                data +=3D cs
>
>          if tid in self.taints:
>              if self.taints[tid].startswith("nostamp:"):
> -                data =3D data + self.taints[tid][8:]
> +                data +=3D self.taints[tid][8:]
>              else:
> -                data =3D data + self.taints[tid]
> +                data +=3D self.taints[tid]
>
>          h =3D hashlib.sha256(data.encode("utf-8")).hexdigest()
>          self.taskhash[tid] =3D h
> --
> 2.36.1.vfs.0.0
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14404):
> https://lists.openembedded.org/g/bitbake-devel/message/14404
> Mute This Topic: https://lists.openembedded.org/mt/96957072/3617156
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> Martin.Jansa@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--0000000000007c4de205f4a6d286
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">This might help with:<div><a href=3D"https://bugzilla.yoct=
oproject.org/show_bug.cgi?id=3D14942">https://bugzilla.yoctoproject.org/sho=
w_bug.cgi?id=3D14942</a><br></div><div><br></div><div>will test it on my te=
stcase with=C2=A0380227 paths and update the ticket if this helps.</div></d=
iv><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On =
Tue, Feb 14, 2023 at 11:35 AM ecordonnier via <a href=3D"http://lists.opene=
mbedded.org">lists.openembedded.org</a> &lt;ecordonnier=3D<a href=3D"mailto=
:snap.com@lists.openembedded.org">snap.com@lists.openembedded.org</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: Etie=
nne Cordonnier &lt;<a href=3D"mailto:ecordonnier@snap.com" target=3D"_blank=
">ecordonnier@snap.com</a>&gt;<br>
<br>
As discussed in <a href=3D"https://stackoverflow.com/a/4435752/1710392" rel=
=3D"noreferrer" target=3D"_blank">https://stackoverflow.com/a/4435752/17103=
92</a> , CPython<br>
has an optimization for statements in the form &quot;a =3D a + b&quot; or &=
quot;a +=3D b&quot;.<br>
It seems that this line does not get optimized, because it has a form a =3D=
 a + b + c:<br>
data =3D data + &quot;./&quot; + f.split(&quot;/./&quot;)[1]<br>
<br>
For that reason, it does a copy of data for each iteration, potentially cop=
ying megabytes<br>
of data for each iteration.<br>
<br>
Changing this line causes SignatureGeneratorBasic::get_taskhash to take 0.0=
6 seconds<br>
instead of 45 seconds on my test setup where SRC_URI points to a big direct=
ory.<br>
<br>
Note that PEP8 recommends explicitely not to use this optimization which is=
 specific to CPython:<br>
&quot;do not rely on CPython=E2=80=99s efficient implementation of in-place=
 string concatenation for statements in the form a +=3D b or a =3D a + b&qu=
ot;<br>
<br>
However, the PEP8 recommended form using &quot;join()&quot; also does not a=
void the copy and takes 45 seconds in my test setup:<br>
data =3D &#39;&#39;.join((data, &quot;./&quot;, f.split(&quot;/./&quot;)[1]=
))<br>
<br>
I have changed the other lines to also use +=3D for consistency only, howev=
er those were in the form a =3D a + b<br>
and were optimized already.<br>
<br>
Co-authored-by: JJ Robertson &lt;<a href=3D"mailto:jrobertson@snap.com" tar=
get=3D"_blank">jrobertson@snap.com</a>&gt;<br>
Signed-off-by: Etienne Cordonnier &lt;<a href=3D"mailto:ecordonnier@snap.co=
m" target=3D"_blank">ecordonnier@snap.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/siggen.py | 10 +++++-----<br>
=C2=A01 file changed, 5 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py<br>
index 130b38d8..2381edd2 100644<br>
--- a/lib/bb/siggen.py<br>
+++ b/lib/bb/siggen.py<br>
@@ -328,19 +328,19 @@ class SignatureGeneratorBasic(SignatureGenerator):<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data =3D self.basehash[tid]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for dep in self.runtaskdeps[tid]:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D data + self.get_unihash=
(dep)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data +=3D self.get_unihash(dep)<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (f, cs) in self.file_checksum_values[=
tid]:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if cs:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if &quot;/./&=
quot; in f:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data=
 =3D data + &quot;./&quot; + f.split(&quot;/./&quot;)[1]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D data + cs=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data=
 +=3D &quot;./&quot; + f.split(&quot;/./&quot;)[1]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data +=3D cs<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if tid in self.taints:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.taints[tid].startsw=
ith(&quot;nostamp:&quot;):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D data + se=
lf.taints[tid][8:]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data +=3D self.tai=
nts[tid][8:]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D data + se=
lf.taints[tid]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data +=3D self.tai=
nts[tid]<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0h =3D hashlib.sha256(data.encode(&quot;ut=
f-8&quot;)).hexdigest()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.taskhash[tid] =3D h<br>
-- <br>
2.36.1.vfs.0.0<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#14404): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/14404" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/14404</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/96957072/3617=
156" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/96957072/3617156</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:Martin.Jansa@gmail.com" target=3D"=
_blank">Martin.Jansa@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--0000000000007c4de205f4a6d286--

