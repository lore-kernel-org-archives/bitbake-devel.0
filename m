Return-Path: <frederic.martinsons@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53867C76188
	for <webhook@archiver.kernel.org>; Wed,  5 Apr 2023 12:03:58 +0000 (UTC)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
 by mx.groups.io with SMTP id smtpd.web11.128135.1680696237441753075
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Apr 2023 05:03:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=C7FP96NV;
 spf=pass (domain: gmail.com, ip: 209.85.167.49, mailfrom: frederic.martinsons@gmail.com)
Received: by mail-lf1-f49.google.com with SMTP id k37so46349651lfv.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 05 Apr 2023 05:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680696236;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZR3NhzvNizMYfjCYbnn9FaOZ0KX5JeIvxEzecMVrPhU=;
        b=C7FP96NVz6huD1gsj5g/ws6Gy7O1i7TarH7IXfSQ1FaLL602mSPW6EPoPpMNQPJ4aH
         Jtat6mLI2/Cck9/uG9Uya0FSMpHvfqRv9yvwB+2SIMAYlAbFm6UAzJd0giwTtQvL3A3V
         DGpMaHzD2SmHfQgNhIxesDr2KKSxU4e7hiYbWF1QU6lH+aV6tL4rYf5FZZjAzvKoE2+2
         k6BusYV2AVlJwsPow8KyFHzooRqwdyDmDzXkv1stWxYBcHAUDqOME7HUdLY4Y+1bba+V
         shP+Y7Kv6elY8tYHvEigoAm3PUZQV+heHUnHEeWv+uEgiLfYHWdbqaIsi2VePJqgpgyG
         lVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680696236;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZR3NhzvNizMYfjCYbnn9FaOZ0KX5JeIvxEzecMVrPhU=;
        b=0MV16om0X14oYfagYM7x0Gd/U2a2krT/lp6/IiGY6KqEXoRMCHOZ0l77XkveCzvWcL
         pu3lhTzoyvQq78V192UWT6X3Sq586Y/+4x//G3Y0w1uAps5KThPsBc/lvCfQkOK7/1gC
         hRZokwpaQ8e26gk7o8hULpMmMQSVcUb55s3BrnTgtXNNuUcyvyX7V3ka6dAfcMnrYvaW
         PdLSOVYdo+rhTTjEL5Lek4DVSdTeqULUjFZm+kT9neh+nBhA+5BG4XEvyiWoI0A+0uPp
         8C/69/XWY3VsKfOmwTRbZYWmVoXChtqnHX8QBxDxwI6r79T7vT3jUw6u48DGDNnqhx8S
         0IoQ==
X-Gm-Message-State: AAQBX9f16qLU4YIUkIe8y9DuatqiDq+rRKHqEJ1CYodF3A/keOfrXAUM
	YtU+4n+fAGwodNWU6mpFFCOvBEsCtdB+DwiMm90=
X-Google-Smtp-Source: AKy350YiXlspYLlAZ9gGnwkIugqRlouaIY7xozsAmJVOEuF4auAnMkj0RbPN7ppq4yvPDLLn0x8jDUW6x13UmQmFyOQ=
X-Received: by 2002:ac2:548f:0:b0:4e0:822f:9500 with SMTP id
 t15-20020ac2548f000000b004e0822f9500mr1773944lfk.12.1680696235321; Wed, 05
 Apr 2023 05:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230405101609.3309660-1-enrico.scholz@sigma-chemnitz.de>
In-Reply-To: <20230405101609.3309660-1-enrico.scholz@sigma-chemnitz.de>
From: =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= <frederic.martinsons@gmail.com>
Date: Wed, 5 Apr 2023 14:03:44 +0200
Message-ID: <CA+cAkerT+8E=Td+HEzKw_O7Xa8LSdF1DZvjyf9Kze+XergaCNg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch:crate: create versioned 'name' entries
To: enrico.scholz@sigma-chemnitz.de
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000014ed8405f8959674"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Apr 2023 12:03:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14650

--00000000000014ed8405f8959674
Content-Type: text/plain; charset="UTF-8"

Hello,

There are multiple issues with this patch.

First, this is not compatible with recipes which will override the name
parameter in their crate:// entry like zvariant in meta-selftest layer.

Second, the cargo-update-recipe-crates class already did that modification
for you (it set name parameter to be pkg-vers and it expect bitbake fetcher
to respect that),
by the way, the zavariant I talk about was built with usage of this class

Last, this modification makes the bitbake unit test fail.

To bootstrap a cargo base recipe which have not this checksum list, below
are
the steps to make:
  - make the recipe inherit cargo-update-recipe-crates
  - remove all crate:// from your recipe
  - create an empty ${BPN}-crates.inc file and make your recipe requires it
  - execute "bitbake -c update_crates your_recipe"
  - copy paste the output of bitbake about the missing checksums in your
${BPN}-crates.inc

And you should have a buildable cargo based recipe with these.



On Wed, 5 Apr 2023 at 12:16, Enrico Scholz via lists.openembedded.org
<enrico.scholz=sigma-chemnitz.de@lists.openembedded.org> wrote:

> From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
>
> It is common for rust packages to depend on different versions of the
> same crate.  E.g.
>
> |    crate://crates.io/windows_x86_64_msvc/0.42.2 \
> |    crate://crates.io/windows_x86_64_msvc/0.48.0 \
>
> Identification only by the plain crate name makes the sha256sum
> ambiguous
>
> | SRC_URI[windows_x86_64_msvc.sha256sum] =
> "9aec5da331524158c6d1a4ac0ab1541149c0b9505fde06423b02f5ef0106b9f0"
> | SRC_URI[windows_x86_64_msvc.sha256sum] =
> "1a515f5799fe4961cb532f983ce2b23082366b898e52ffbce459c86f67c8378a"
>
> and requires lot of manual work to fix the SRC_URI list.
>
> Making the 'name' property unique by appending the version allows
> direct copy & paste of reported sha256sum errors to complete the
> crates list.
>
> Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
> ---
>  lib/bb/fetch2/crate.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
> index 590dc9c12681..a7021e5b367c 100644
> --- a/lib/bb/fetch2/crate.py
> +++ b/lib/bb/fetch2/crate.py
> @@ -72,7 +72,7 @@ class Crate(Wget):
>          ud.url = "https://%s/%s/%s/download" % (host, name, version)
>          ud.parm['downloadfilename'] = "%s-%s.crate" % (name, version)
>          if 'name' not in ud.parm:
> -            ud.parm['name'] = name
> +            ud.parm['name'] = '%s-%s' % (name, version)
>
>          logger.debug2("Fetching %s to %s" % (ud.url,
> ud.parm['downloadfilename']))
>
> --
> 2.39.2
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14645):
> https://lists.openembedded.org/g/bitbake-devel/message/14645
> Mute This Topic: https://lists.openembedded.org/mt/98079257/6213388
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> frederic.martinsons@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

--00000000000014ed8405f8959674
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>There are multiple issues with t=
his patch.</div><div><br></div><div>First, this is not compatible with reci=
pes which will override the name</div><div>parameter in their crate:// entr=
y like zvariant in meta-selftest layer.</div><div><br></div><div>Second, th=
e cargo-update-recipe-crates=C2=A0class already did that modification=C2=A0=
</div><div>for you (it set name parameter to be pkg-vers and it expect bitb=
ake fetcher to respect that),</div><div>by the way, the zavariant I talk ab=
out was built with usage of this class</div><div><br></div><div>Last, this =
modification=C2=A0makes the bitbake unit test fail.</div><div><br></div><di=
v>To bootstrap=C2=A0a cargo base recipe which have not this checksum list, =
below are</div><div>the steps to make:</div><div>=C2=A0 - make the recipe i=
nherit cargo-update-recipe-crates</div><div>=C2=A0 - remove all crate:// fr=
om your recipe</div><div>=C2=A0 - create an empty ${BPN}-crates.inc file an=
d make your recipe requires it</div><div>=C2=A0 - execute &quot;bitbake -c =
update_crates your_recipe&quot;</div><div>=C2=A0 - copy paste the output of=
 bitbake about the missing checksums in your ${BPN}-crates.inc</div><div><b=
r></div><div>And you should have a buildable cargo based recipe with these.=
</div><div><br></div><div><br></div></div><br><div class=3D"gmail_quote"><d=
iv dir=3D"ltr" class=3D"gmail_attr">On Wed, 5 Apr 2023 at 12:16, Enrico Sch=
olz via <a href=3D"http://lists.openembedded.org">lists.openembedded.org</a=
> &lt;enrico.scholz=3D<a href=3D"mailto:sigma-chemnitz.de@lists.openembedde=
d.org">sigma-chemnitz.de@lists.openembedded.org</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">From: Enrico Scholz &lt;<a h=
ref=3D"mailto:enrico.scholz@sigma-chemnitz.de" target=3D"_blank">enrico.sch=
olz@sigma-chemnitz.de</a>&gt;<br>
<br>
It is common for rust packages to depend on different versions of the<br>
same crate.=C2=A0 E.g.<br>
<br>
|=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/windows_x86_64_msvc/0.42=
.2" rel=3D"noreferrer" target=3D"_blank">crates.io/windows_x86_64_msvc/0.42=
.2</a> \<br>
|=C2=A0 =C2=A0 crate://<a href=3D"http://crates.io/windows_x86_64_msvc/0.48=
.0" rel=3D"noreferrer" target=3D"_blank">crates.io/windows_x86_64_msvc/0.48=
.0</a> \<br>
<br>
Identification only by the plain crate name makes the sha256sum<br>
ambiguous<br>
<br>
| SRC_URI[windows_x86_64_msvc.sha256sum] =3D &quot;9aec5da331524158c6d1a4ac=
0ab1541149c0b9505fde06423b02f5ef0106b9f0&quot;<br>
| SRC_URI[windows_x86_64_msvc.sha256sum] =3D &quot;1a515f5799fe4961cb532f98=
3ce2b23082366b898e52ffbce459c86f67c8378a&quot;<br>
<br>
and requires lot of manual work to fix the SRC_URI list.<br>
<br>
Making the &#39;name&#39; property unique by appending the version allows<b=
r>
direct copy &amp; paste of reported sha256sum errors to complete the<br>
crates list.<br>
<br>
Signed-off-by: Enrico Scholz &lt;<a href=3D"mailto:enrico.scholz@sigma-chem=
nitz.de" target=3D"_blank">enrico.scholz@sigma-chemnitz.de</a>&gt;<br>
---<br>
=C2=A0lib/bb/fetch2/crate.py | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py<br>
index 590dc9c12681..a7021e5b367c 100644<br>
--- a/lib/bb/fetch2/crate.py<br>
+++ b/lib/bb/fetch2/crate.py<br>
@@ -72,7 +72,7 @@ class Crate(Wget):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ud.url =3D &quot;https://%s/%s/%s/downloa=
d&quot; % (host, name, version)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ud.parm[&#39;downloadfilename&#39;] =3D &=
quot;%s-%s.crate&quot; % (name, version)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if &#39;name&#39; not in ud.parm:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.parm[&#39;name&#39;] =3D name=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.parm[&#39;name&#39;] =3D &#39=
;%s-%s&#39; % (name, version)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.debug2(&quot;Fetching %s to %s&quo=
t; % (ud.url, ud.parm[&#39;downloadfilename&#39;]))<br>
<br>
-- <br>
2.39.2<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#14645): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/14645" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/14645</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/98079257/6213=
388" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/98079257/6213388</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:frederic.martinsons@gmail.com" tar=
get=3D"_blank">frederic.martinsons@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--00000000000014ed8405f8959674--

