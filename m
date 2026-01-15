Return-Path: <rob.woolleywr@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C0AD44C5E
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 14:53:54 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.37519.1768488832631730591
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Jan 2026 06:53:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=K3DHG7nG;
 spf=pass (domain: gmail.com, ip: 209.85.128.174, mailfrom: rob.woolleywr@gmail.com)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-790948758c1so9559347b3.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 06:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768488832; x=1769093632; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3K4tEpAihW5w/4n6SpgO/frrbo5jhG4L7sP5DvAPPpM=;
        b=K3DHG7nGq9p3EC/4Vx3H9XjxeNqQzw59Gvy0Abndwdk+LA0gDA4X7RSQyTZYg9Yhba
         cTEvAamknAxSabbsYjYXw0mbEzW0IcYwB/OGxrqPK49d8/+nnTdTls6D9PdBCjHxKbRJ
         i+LWDG5dF+UX04i+ZuK5JgUR25gwLGOscLDbkMGGnjmB/IYoE86bEnG0DsJ6SQp9IFRE
         G2Oi4oFNarEkbi3L7BwvHKqfezWOgK81SmEvhPvfRjmzFrXzUxAz+ScqED++8Cztbv7b
         fM+L4cbtHCnvU7aerTLWTBES5MxSdOUwNpF6poje0vxl0o2PT+UqV05CM2YH0v7jDQ6a
         NqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768488832; x=1769093632;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3K4tEpAihW5w/4n6SpgO/frrbo5jhG4L7sP5DvAPPpM=;
        b=NywxS8wMZNbR6QObnpZwzwA1hgrlls2LPEPc+BjBCg6xbmlQDM0EfWTjpAXI2zPteJ
         MXsJVfAnsW/m9iBIg5YjLaexmHByvsHtwDi1+P8oJYCi8xJvQ4lRhtUAFsvgQ7W56CXz
         PvABoBFYf0Df61hXy0gtKwBvANCcl7iMCcUgf+BYQ+7RpeQuxvW4zrnb28ii0CGb8OPk
         kXrMbySbZKcAvG2aVqcivdSF8eMnrYB5wOP0jjZexu4Qo5Cqiv2RMPxqjf7b7ZZ6mX30
         Af/Read3Z3MmJ2GcntdvrMsumVG+Iewqw/iIWxteLwNWNXHjiYB62Px+o29K5iD3BIBl
         f6bQ==
X-Gm-Message-State: AOJu0YzUIuqy1fNqDx/1pDClCzZUstdEbuFzjzhKXbLpjgcBiYyGIiFy
	U1vkA5BKxPIRSnM0gpSfvCpamWklwvyf6fkceGMnS0j1mAp+b9DSzrRKKbxT5Euas8NExPBCy7q
	1H1VsJi6AwQSQ9K6y8c9B8km8wgDRaWc=
X-Gm-Gg: AY/fxX6dtjes5Yr4dtQMrpdS2lW6NNYRV0DMfi3s/JFwDYewI+MQRB0Tomtgmqd2avx
	yYL/BHzOImYL/xFbBusvUy0bEAHyN2N+qehJLGxgRNse/iOAK9EmRH5mtVLv7Wrp44BFwm+5W+F
	kwvBm5T3Eplby97Vm3bIEexsGSXlnjei9WOfz5d3r+yClmE+iDQlpcPWvKoP4U93SYs5d3tbZu4
	7vm9YqLqvLfhVosUNjMld4yRbgdXuPtKkOoWwmjz2EqWuO5GWlPm19DUb4kXQd8ljCO6QBF9GtD
	r0rZJ+sYyQVpkBuRagq7r8G5+QU=
X-Received: by 2002:a05:690e:1914:b0:644:7afd:f484 with SMTP id
 956f58d0204a3-64916498e81mr4741d50.40.1768488831293; Thu, 15 Jan 2026
 06:53:51 -0800 (PST)
MIME-Version: 1.0
References: <20260114113348.2991476-1-alex.kanavin@gmail.com>
In-Reply-To: <20260114113348.2991476-1-alex.kanavin@gmail.com>
From: Rob Woolley <rob.woolleywr@gmail.com>
Date: Thu, 15 Jan 2026 09:53:39 -0500
X-Gm-Features: AZwV_QjjHGBhAETswhJexHxs43zUvyYPdwPb3KISSuCGk4fi9gOcwzUJme10udg
Message-ID: <CAGAhMBzeXVJChatJW34mV0KZSuW7oky+X=TmGBUEMdDE2ZELag@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2] bitbake-setup: use internal registry
 if run from git checkout, bitbake repo otherwise
To: alex.kanavin@gmail.com
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: multipart/alternative; boundary="00000000000094204806486e64e5"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 14:53:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18782

--00000000000094204806486e64e5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

Thanks! I will give this a try.

I have a need to be able to use bitbake-setup for air-gapped builds. I will
experiment with how we might make this work for situations where
git.openembedded.org is unavailable.  (In the past I have used git
"insteadof" to accomplish this)

Regards,
Rob

On Wed, Jan 14, 2026 at 6:33=E2=80=AFAM Alexander Kanavin via lists.openemb=
edded.org
<alex.kanavin=3Dgmail.com@lists.openembedded.org> wrote:

> From: Alexander Kanavin <alex@linutronix.de>
>
> If bitbake-setup is packaged and obtained from pypi, or another package
> feed
> it needs to be able to find standard configurations. It is not impossible
> to package configurations into some location inside the package
> and add logic to find them, but it is much easier to just fetch the bitba=
ke
> repo and use that as a configuration registry. The other benefit is that
> such packaged/installed bitbake-setup will not have to be updated in orde=
r
> to obtain latest configurations: it will simply check the registry and
> fetch
> them as needed, which is the original intent of config registries as repo=
s.
>
> Signed-off-by: Alexander Kanavin <alex@linutronix.de>
> ---
>  bin/bitbake-setup | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> index 2c2b6d8ec..4ed06fc62 100755
> --- a/bin/bitbake-setup
> +++ b/bin/bitbake-setup
> @@ -21,8 +21,6 @@ import signal
>  import functools
>  import string
>
> -default_registry =3D os.path.normpath(os.path.dirname(__file__) +
> "/../default-registry")
> -
>  bindir =3D os.path.abspath(os.path.dirname(__file__))
>  sys.path[0:0] =3D [os.path.join(os.path.dirname(bindir), 'lib')]
>
> @@ -37,6 +35,17 @@ GLOBAL_ONLY_SETTINGS =3D (
>      "top-dir-name",
>  )
>
> +# If bitbake is from a release tarball or somewhere like pypi where
> +# updates may not be straightforward, prefer to use the git repo as the
> +# default registry
> +def get_default_registry():
> +    internal_registry =3D os.path.normpath(os.path.dirname(__file__) +
> "/../default-registry")
> +    git_registry =3D "git://
> git.openembedded.org/bitbake;protocol=3Dhttps;branch=3Dmaster;rev=3Dmaste=
r"
> +    if os.path.exists(os.path.dirname(__file__) + "/../.git"):
> +        return internal_registry
> +    else:
> +        return git_registry
> +
>  def cache_dir(top_dir):
>      return os.path.join(top_dir, '.bitbake-setup-cache')
>
> @@ -1084,7 +1093,7 @@ def main():
>          builtin_settings['default'] =3D {
>                           'top-dir-prefix':os.getcwd(),
>                           'top-dir-name':'bitbake-builds',
> -                         'registry':default_registry,
> +                         'registry':get_default_registry(),
>                           'use-full-setup-dir-name':'no',
>                           'common-sstate':'yes',
>                           }
> --
> 2.47.3
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18752):
> https://lists.openembedded.org/g/bitbake-devel/message/18752
> Mute This Topic: https://lists.openembedded.org/mt/117259398/556952
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> rob.woolleywr@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--00000000000094204806486e64e5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Alex,<div><br></div><div>Thanks! I will give this a try=
.</div><div><br></div><div>I have a need to be able to use bitbake-setup fo=
r air-gapped builds. I will experiment with how we might make this work for=
 situations where <a href=3D"http://git.openembedded.org">git.openembedded.=
org</a> is unavailable.=C2=A0 (In the past I have used git &quot;insteadof&=
quot; to accomplish this)</div><div><br>Regards,</div><div>Rob</div></div><=
br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Wed, Jan 14, 2026 at 6:33=E2=80=AFAM Alexander Kanavin v=
ia <a href=3D"http://lists.openembedded.org">lists.openembedded.org</a> &lt=
;alex.kanavin=3D<a href=3D"mailto:gmail.com@lists.openembedded.org">gmail.c=
om@lists.openembedded.org</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">From: Alexander Kanavin &lt;<a href=3D"mailto:alex=
@linutronix.de" target=3D"_blank">alex@linutronix.de</a>&gt;<br>
<br>
If bitbake-setup is packaged and obtained from pypi, or another package fee=
d<br>
it needs to be able to find standard configurations. It is not impossible<b=
r>
to package configurations into some location inside the package<br>
and add logic to find them, but it is much easier to just fetch the bitbake=
<br>
repo and use that as a configuration registry. The other benefit is that<br=
>
such packaged/installed bitbake-setup will not have to be updated in order<=
br>
to obtain latest configurations: it will simply check the registry and fetc=
h<br>
them as needed, which is the original intent of config registries as repos.=
<br>
<br>
Signed-off-by: Alexander Kanavin &lt;<a href=3D"mailto:alex@linutronix.de" =
target=3D"_blank">alex@linutronix.de</a>&gt;<br>
---<br>
=C2=A0bin/bitbake-setup | 15 ++++++++++++---<br>
=C2=A01 file changed, 12 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/bin/bitbake-setup b/bin/bitbake-setup<br>
index 2c2b6d8ec..4ed06fc62 100755<br>
--- a/bin/bitbake-setup<br>
+++ b/bin/bitbake-setup<br>
@@ -21,8 +21,6 @@ import signal<br>
=C2=A0import functools<br>
=C2=A0import string<br>
<br>
-default_registry =3D os.path.normpath(os.path.dirname(__file__) + &quot;/.=
./default-registry&quot;)<br>
-<br>
=C2=A0bindir =3D os.path.abspath(os.path.dirname(__file__))<br>
=C2=A0sys.path[0:0] =3D [os.path.join(os.path.dirname(bindir), &#39;lib&#39=
;)]<br>
<br>
@@ -37,6 +35,17 @@ GLOBAL_ONLY_SETTINGS =3D (<br>
=C2=A0 =C2=A0 =C2=A0&quot;top-dir-name&quot;,<br>
=C2=A0)<br>
<br>
+# If bitbake is from a release tarball or somewhere like pypi where<br>
+# updates may not be straightforward, prefer to use the git repo as the<br=
>
+# default registry<br>
+def get_default_registry():<br>
+=C2=A0 =C2=A0 internal_registry =3D os.path.normpath(os.path.dirname(__fil=
e__) + &quot;/../default-registry&quot;)<br>
+=C2=A0 =C2=A0 git_registry =3D &quot;git://<a href=3D"http://git.openembed=
ded.org/bitbake;protocol=3Dhttps;branch=3Dmaster;rev=3Dmaster" rel=3D"noref=
errer" target=3D"_blank">git.openembedded.org/bitbake;protocol=3Dhttps;bran=
ch=3Dmaster;rev=3Dmaster</a>&quot;<br>
+=C2=A0 =C2=A0 if os.path.exists(os.path.dirname(__file__) + &quot;/../.git=
&quot;):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return internal_registry<br>
+=C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return git_registry<br>
+<br>
=C2=A0def cache_dir(top_dir):<br>
=C2=A0 =C2=A0 =C2=A0return os.path.join(top_dir, &#39;.bitbake-setup-cache&=
#39;)<br>
<br>
@@ -1084,7 +1093,7 @@ def main():<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0builtin_settings[&#39;default&#39;] =3D {=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &#39;top-dir-prefix&#39;:os.getcwd(),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &#39;top-dir-name&#39;:&#39;bitbake-builds&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;registry&#39;:default_registry,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;registry&#39;:get_default_registry(),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &#39;use-full-setup-dir-name&#39;:&#39;no&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &#39;common-sstate&#39;:&#39;yes&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 }<br>
-- <br>
2.47.3<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#18752): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/18752" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/18752</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/117259398/556=
952" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/117259398/556952</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:rob.woolleywr@gmail.com" target=3D=
"_blank">rob.woolleywr@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--00000000000094204806486e64e5--

