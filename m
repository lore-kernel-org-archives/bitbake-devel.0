Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B597C433F5
	for <webhook@archiver.kernel.org>; Thu, 23 Dec 2021 15:10:20 +0000 (UTC)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com
 [209.85.208.171])
 by mx.groups.io with SMTP id smtpd.web09.34082.1640272218200349187
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 23 Dec 2021 07:10:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=m13Znt90;
 spf=pass (domain: gmail.com, ip: 209.85.208.171,
 mailfrom: quaresma.jose@gmail.com)
Received: by mail-lj1-f171.google.com with SMTP id i63so9567300lji.3
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 23 Dec 2021 07:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I4kb9U5BoOSi/FCjuwooxSHgYX0tDlfoDgA4BEhFp6w=;
        b=m13Znt90WVfeBNFCJsSgphXd9QhGK8UvKClZIHfWXhdZfmilUzCjbYjXUPeRJ/9gPs
         3Xo30NQTbXzVd+yKSTwRuy+XRiG30Ae7f0EFVwKzwuO4f7bHOQOd2T6SXggR05k5gi1Z
         Mv9Fe2Ej54hdJeAvsEnBJn7jQjraImQZSJBdJWc6/WhbzEIFIFt/Qtkw40AiNTzsyYjr
         pZXEzljCCy7VTzjMT9Qeipjqgmabe00ydzCHQGiRpGglsAnozVUYx/zPPST0U/EaQ4KN
         Hp1L+Tg06AYBlsOQhmL/E3AOppbrmmDCQ2E/RMh/NfNA9OvQbJvA+aCUjrxCKTu30f4s
         ZMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I4kb9U5BoOSi/FCjuwooxSHgYX0tDlfoDgA4BEhFp6w=;
        b=UzFARQiHtOar5IwXbRq/GJDHQIH14MUii3JmlDyFYv3+Tb0OAHjA3HLXsPX+WVXQTI
         iRJOC3wm1Sz5o3TWTQYYUwc9DAn9xJOExCKF5fPfdVcggVKYM9fZ2VFTvfIwWtqtVYis
         4p1ZNZFys+FE/OYNGPjYzwc1wkEk0rLfnmQB3VoAezh7kW3/oHXjnL3+Rhx27XgUXWuJ
         jGSmh9yLyNlvLfxOT++u7GDtSLd4vIdSvN3elsPJj6Pd8GIW86Mi/g79yAGe79MJEHUJ
         orDsl5JWFW2i+3gdGdL8VfXk99/I0jBOhwhaSZvIl4YscmIc9pxRycloDC1ydKyRyeeM
         THKQ==
X-Gm-Message-State: AOAM533JXlGcao1vmM78eO3JvK0RO9NAt9PA402zjt2ZpfTjaQsk0l4p
	RKd5TUKeDW7UTk6NPh/fj7ZjpCsaUXm59tjj81g=
X-Google-Smtp-Source: 
 ABdhPJysjKkZ3IfUjCAyAYTWbROkdgFH06BpdeyTQUyLEQdy6j2tQum3WsYEJhGXqrlg0IVYpy3QYbrCsGxK05RMaHI=
X-Received: by 2002:a2e:9750:: with SMTP id f16mr1869140ljj.278.1640272216410;
 Thu, 23 Dec 2021 07:10:16 -0800 (PST)
MIME-Version: 1.0
References: <20211222231907.1036709-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20211222231907.1036709-1-richard.purdie@linuxfoundation.org>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Thu, 23 Dec 2021 15:10:04 +0000
Message-ID: 
 <CANPvuR=EyqMnkSG-niP8GAOnT2jEun63iz4Fpa4RU8isTc-ezg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/2] utils: Add disable_network function
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000cb4f5d05d3d1a2f9"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 23 Dec 2021 15:10:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13202

--000000000000cb4f5d05d3d1a2f9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

First of all, this feature is fantastic.

Richard Purdie <richard.purdie@linuxfoundation.org> escreveu no dia quarta,
22/12/2021 =C3=A0(s) 23:19:

> Add a function which uses the unshare glibc call to disable networking
> in the current process. This doesn't work on older distros/kernels
> but will on more recent ones so for now we simply ignore the cases we
> can't execute on. uid/gid can be passed in externally so this can
> work with pseudo/fakeroot contexts.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/utils.py | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/lib/bb/utils.py b/lib/bb/utils.py
> index d890ea832e..8006f7bd2d 100644
> --- a/lib/bb/utils.py
> +++ b/lib/bb/utils.py
> @@ -26,6 +26,7 @@ import errno
>  import signal
>  import collections
>  import copy
> +import ctypes
>  from subprocess import getstatusoutput
>  from contextlib import contextmanager
>  from ctypes import cdll
> @@ -1594,6 +1595,36 @@ def set_process_name(name):
>      except:
>          pass
>
> +def disable_network(uid=3DNone, gid=3DNone):
> +    """
> +    Disable networking in the current process if the kernel supports it,
> else
> +    just return after logging to debug. To do this we need to create a
> new user
> +    namespace, then map back to the original uid/gid.
> +    """
> +    libc =3D ctypes.CDLL('libc.so.6')
> +
> +    # From sched.h
> +    # New user namespace
> +    CLONE_NEWUSER =3D 0x10000000
> +    # New network namespace
> +    CLONE_NEWNET =3D 0x40000000
> +
> +    if uid is None:
> +        uid =3D os.getuid()
> +    if gid is None:
> +        gid =3D os.getgid()
> +
> +    ret =3D libc.unshare(CLONE_NEWNET | CLONE_NEWUSER)
> +    if ret !=3D 0:
> +        logger.debug("System doesn't suport disabling network without
> admin privs")
> +        return
>

try:


> +    with open("/proc/self/uid_map", "w") as f:
> +        f.write("%s %s 1" % (uid, uid))
> +    with open("/proc/self/setgroups", "w") as f:
> +        f.write("deny")
> +    with open("/proc/self/gid_map", "w") as f:
> +        f.write("%s %s 1" % (gid, gid))
>

except:
 print a warning about the fail

Without that it can fail silently if the user doesn't have permission to
write in /proc/self.
In general, if it runs all the steps, the function can return true/false.

Jose

+
>  def export_proxies(d):
>      """ export common proxies variables from datastore to environment ""=
"
>      import os
> --
> 2.32.0
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13199):
> https://lists.openembedded.org/g/bitbake-devel/message/13199
> Mute This Topic: https://lists.openembedded.org/mt/87909296/5052612
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> quaresma.jose@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--=20
Best regards,

Jos=C3=A9 Quaresma

--000000000000cb4f5d05d3d1a2f9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi=C2=A0Richard,<br><br>First of all, thi=
s feature is fantastic.<br></div><br><div class=3D"gmail_quote"><div dir=3D=
"ltr" class=3D"gmail_attr">Richard Purdie &lt;<a href=3D"mailto:richard.pur=
die@linuxfoundation.org">richard.purdie@linuxfoundation.org</a>&gt; escreve=
u no dia quarta, 22/12/2021 =C3=A0(s) 23:19:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">Add a function which uses the unshare glibc ca=
ll to disable networking<br>
in the current process. This doesn&#39;t work on older distros/kernels<br>
but will on more recent ones so for now we simply ignore the cases we<br>
can&#39;t execute on. uid/gid can be passed in externally so this can<br>
work with pseudo/fakeroot contexts.<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<b=
r>
---<br>
=C2=A0lib/bb/utils.py | 31 +++++++++++++++++++++++++++++++<br>
=C2=A01 file changed, 31 insertions(+)<br>
<br>
diff --git a/lib/bb/utils.py b/lib/bb/utils.py<br>
index d890ea832e..8006f7bd2d 100644<br>
--- a/lib/bb/utils.py<br>
+++ b/lib/bb/utils.py<br>
@@ -26,6 +26,7 @@ import errno<br>
=C2=A0import signal<br>
=C2=A0import collections<br>
=C2=A0import copy<br>
+import ctypes<br>
=C2=A0from subprocess import getstatusoutput<br>
=C2=A0from contextlib import contextmanager<br>
=C2=A0from ctypes import cdll<br>
@@ -1594,6 +1595,36 @@ def set_process_name(name):<br>
=C2=A0 =C2=A0 =C2=A0except:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br>
<br>
+def disable_network(uid=3DNone, gid=3DNone):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 Disable networking in the current process if the kernel supp=
orts it, else<br>
+=C2=A0 =C2=A0 just return after logging to debug. To do this we need to cr=
eate a new user<br>
+=C2=A0 =C2=A0 namespace, then map back to the original uid/gid.<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 libc =3D ctypes.CDLL(&#39;libc.so.6&#39;)<br>
+<br>
+=C2=A0 =C2=A0 # From sched.h<br>
+=C2=A0 =C2=A0 # New user namespace<br>
+=C2=A0 =C2=A0 CLONE_NEWUSER =3D 0x10000000<br>
+=C2=A0 =C2=A0 # New network namespace<br>
+=C2=A0 =C2=A0 CLONE_NEWNET =3D 0x40000000<br>
+<br>
+=C2=A0 =C2=A0 if uid is None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uid =3D os.getuid()<br>
+=C2=A0 =C2=A0 if gid is None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gid =3D os.getgid()<br>
+<br>
+=C2=A0 =C2=A0 ret =3D libc.unshare(CLONE_NEWNET | CLONE_NEWUSER)<br>
+=C2=A0 =C2=A0 if ret !=3D 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 logger.debug(&quot;System doesn&#39;t suport d=
isabling network without admin privs&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br></blockquote><div><br></div><div>try=
:</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 with open(&quot;/proc/self/uid_map&quot;, &quot;w&quot;) as =
f:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(&quot;%s %s 1&quot; % (uid, uid))<br>
+=C2=A0 =C2=A0 with open(&quot;/proc/self/setgroups&quot;, &quot;w&quot;) a=
s f:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(&quot;deny&quot;)<br>
+=C2=A0 =C2=A0 with open(&quot;/proc/self/gid_map&quot;, &quot;w&quot;) as =
f:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(&quot;%s %s 1&quot; % (gid, gid))<br><=
/blockquote><div><br></div><div>except:</div><div>=C2=A0print a warning abo=
ut the fail</div><div><br></div><div>Without that it can fail silently if t=
he user doesn&#39;t have permission=C2=A0to write in /proc/self.</div><div>=
In general, if it runs all the steps, the function can return true/false.</=
div><div><br></div><div>Jose</div><div><br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
+<br>
=C2=A0def export_proxies(d):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot; export common proxies variables from=
 datastore to environment &quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0import os<br>
-- <br>
2.32.0<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#13199): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/13199" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/13199</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/87909296/5052=
612" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/87909296/5052612</a><br>
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

--000000000000cb4f5d05d3d1a2f9--

