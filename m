Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D90C48297
	for <webhook@archiver.kernel.org>; Fri,  9 Feb 2024 15:52:27 +0000 (UTC)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
 by mx.groups.io with SMTP id smtpd.web11.15164.1707493938330504802
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 09 Feb 2024 07:52:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=eamD94gj;
 spf=pass (domain: gmail.com, ip: 209.85.222.41, mailfrom: quaresma.jose@gmail.com)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7d5a6b1dd60so437924241.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 09 Feb 2024 07:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707493937; x=1708098737; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IeYyku7km3lEus0QGS1qqp581SYOlhaEPh+H3Y0xRwU=;
        b=eamD94gjWwmS80L842gOoBk2tBiGNgEIfovHC1G9b5teBHxRSt8RiBRkp07nH8yozj
         YuqDyWu9nowu0/gTy5LgALJXL858qE90QSLyFkDMBF/SQLwevIM30wnIs93WYqQULtYK
         fLeytwVlyBFzWHVqOhsx/wHiVyhSoPpBF8Pww5Gu079v7g8SQOxQgF4t04/SyOMML9pV
         +m+IMy8Nw8BzZFwZygBxthVmcsiCkxEUuEOCrXrjBuC5ElGWLemyO3dzDNuTvoY7c9Pi
         Ad+060K97U91E+EP9+EEGX4CpZouRjrFC4WDeCnd9xAQMp4leZRCLdN0oJBxwWh4no6m
         pfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707493937; x=1708098737;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IeYyku7km3lEus0QGS1qqp581SYOlhaEPh+H3Y0xRwU=;
        b=XR4X/OCmH6kyYFEObPTB37Xo7a6SKh4JsU0+3GGKf8rOS7tnlamWCdf7Hu3Kh5FMjT
         9cPJqSJ6fygESlNWUm9IGnow40Ugxf8EWVP6kV3WfGIOjpPh3VvuEQm93iBDyxlBXy7m
         rqVBEU2ZDKK+Ux0/lY5Z0jPm8N1cXgfzMXrg7HuGLkp7naxRxjbCUj0K6ZTyjZ69rY7U
         Y8uBAPKWxNW9zMS73fuqiWi/JnD4KVlFvtK3wJ1v4Ehbg1OzN1A0Y4JhxT4cOGgxcRVR
         uWNztKDH1LwDB3xuypRj4iqk78Eh70y6GuC02OMk7VejEQZWw9akfK3a38P9KWQDESNV
         Mmwg==
X-Gm-Message-State: AOJu0YwTPtj8pMd9XStuQ4BdmfcEiTqRGVpcTa+fnRaNf/gyDJvqqgV/
	TGRUL9Ua7hxFgcMXEF8WUMaPckKr1bYXnGcPXXn0ASWc8vXVmfgfGFvZvBhW+wMFhdiVtzUhmER
	lTHY3KJvkfu1GLhUaa+zStwHbRmQ=
X-Google-Smtp-Source: AGHT+IElYnDngawfh4S0151QN0yrNwNnB6lWJeC9sO7K8Ak9w7KuH+ufA2DS5YeF0XGlxwoixIwnGq8Ok1+hajzLIGk=
X-Received: by 2002:a05:6102:c8b:b0:46d:5cb3:1657 with SMTP id
 f11-20020a0561020c8b00b0046d5cb31657mr2169183vst.25.1707493935829; Fri, 09
 Feb 2024 07:52:15 -0800 (PST)
MIME-Version: 1.0
References: <20240209152547.2741703-1-thomas.perrot@bootlin.com>
In-Reply-To: <20240209152547.2741703-1-thomas.perrot@bootlin.com>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Fri, 9 Feb 2024 15:52:04 +0000
Message-ID: <CANPvuR=3rtSZfRaZbFUS4J+03o89fiURPzZc+abPSv52aFM-MA@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] wget.py: always use the custom user agent
To: thomas.perrot@bootlin.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000805ad40610f4e947"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 09 Feb 2024 15:52:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15853

--000000000000805ad40610f4e947
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thomas Perrot via lists.openembedded.org <thomas.perrot=3D
bootlin.com@lists.openembedded.org> escreveu (sexta, 9/02/2024 =C3=A0(s) 15=
:25):

> From: Thomas Perrot <thomas.perrot@bootlin.com>
>
> Add the "--user-agent" paramater in the wget base command to
> perform all wget commands with this parameter, because a few
> HTTP servers block requests with the default wget user agent.
>
> For example, "hg.openjdk.org" never send a response to requests
> have been sent with wget:
> wget https://hg.openjdk.org/jdk8u/jdk8u/archive/jdk8u272-ga.tar.bz2
> https://hg.openjdk.org/jdk8u/jdk8u/archive/jdk8u272-ga.tar.bz2
> Resolving hg.openjdk.org (hg.openjdk.org)... 23.54.129.73
> Connecting to hg.openjdk.org (hg.openjdk.org)|23.54.129.73|:443...
> connected.
> HTTP request sent, awaiting response...
>
> Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
> ---
>  lib/bb/fetch2/wget.py | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
> index dc025800e659..e7c4cdd396b3 100644
> --- a/lib/bb/fetch2/wget.py
> +++ b/lib/bb/fetch2/wget.py
> @@ -87,7 +87,8 @@ class Wget(FetchMethod):
>          if not ud.localfile:
>              ud.localfile =3D d.expand(urllib.parse.unquote(ud.host +
> ud.path).replace("/", "."))
>
> -        self.basecmd =3D d.getVar("FETCHCMD_wget") or "/usr/bin/env wget=
 -t
> 2 -T 30 --passive-ftp"
> +        self.basecmd =3D d.getVar("FETCHCMD_wget") \
> +            or "/usr/bin/env wget -t 2 -T 30 --passive-ftp
> --user-agent=3D'%s'" % (self.user_agent)
>
>          if not self.check_certs(d):
>              self.basecmd +=3D " --no-check-certificate"
> @@ -454,7 +455,7 @@ class Wget(FetchMethod):
>          f =3D tempfile.NamedTemporaryFile()
>          with tempfile.TemporaryDirectory(prefix=3D"wget-index-") as
> workdir, tempfile.NamedTemporaryFile(dir=3Dworkdir, prefix=3D"wget-listin=
g-")
> as f:
>              fetchcmd =3D self.basecmd
> -            fetchcmd +=3D " -O " + f.name + " --user-agent=3D'" +
> self.user_agent + "' '" + uri + "'"
> +            fetchcmd +=3D " -O '" + uri + "'"
>

Looks like the file name was removed unintentional.

Jose


>              try:
>                  self._runwget(ud, d, fetchcmd, True, workdir=3Dworkdir)
>                  fetchresult =3D f.read()
> @@ -492,7 +493,7 @@ class Wget(FetchMethod):
>                      valid =3D 1
>                  elif self._vercmp(version, newver) < 0:
>                      version =3D newver
> -
> +
>          pupver =3D re.sub('_', '.', version[1])
>
>          bb.debug(3, "*** %s -> UpstreamVersion =3D %s (CurrentVersion =
=3D
> %s)" %
> --
> 2.43.0
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15851):
> https://lists.openembedded.org/g/bitbake-devel/message/15851
> Mute This Topic: https://lists.openembedded.org/mt/104260370/5052612
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> quaresma.jose@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--=20
Best regards,

Jos=C3=A9 Quaresma

--000000000000805ad40610f4e947
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Thomas Perrot via <a href=3D"http://l=
ists.openembedded.org">lists.openembedded.org</a> &lt;thomas.perrot=3D<a hr=
ef=3D"mailto:bootlin.com@lists.openembedded.org">bootlin.com@lists.openembe=
dded.org</a>&gt; escreveu (sexta, 9/02/2024 =C3=A0(s) 15:25):<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">From: Thomas Perrot &lt;<a hr=
ef=3D"mailto:thomas.perrot@bootlin.com" target=3D"_blank">thomas.perrot@boo=
tlin.com</a>&gt;<br>
<br>
Add the &quot;--user-agent&quot; paramater in the wget base command to<br>
perform all wget commands with this parameter, because a few<br>
HTTP servers block requests with the default wget user agent.<br>
<br>
For example, &quot;<a href=3D"http://hg.openjdk.org" rel=3D"noreferrer" tar=
get=3D"_blank">hg.openjdk.org</a>&quot; never send a response to requests<b=
r>
have been sent with wget:<br>
wget <a href=3D"https://hg.openjdk.org/jdk8u/jdk8u/archive/jdk8u272-ga.tar.=
bz2" rel=3D"noreferrer" target=3D"_blank">https://hg.openjdk.org/jdk8u/jdk8=
u/archive/jdk8u272-ga.tar.bz2</a><br>
<a href=3D"https://hg.openjdk.org/jdk8u/jdk8u/archive/jdk8u272-ga.tar.bz2" =
rel=3D"noreferrer" target=3D"_blank">https://hg.openjdk.org/jdk8u/jdk8u/arc=
hive/jdk8u272-ga.tar.bz2</a><br>
Resolving <a href=3D"http://hg.openjdk.org" rel=3D"noreferrer" target=3D"_b=
lank">hg.openjdk.org</a> (<a href=3D"http://hg.openjdk.org" rel=3D"noreferr=
er" target=3D"_blank">hg.openjdk.org</a>)... 23.54.129.73<br>
Connecting to <a href=3D"http://hg.openjdk.org" rel=3D"noreferrer" target=
=3D"_blank">hg.openjdk.org</a> (<a href=3D"http://hg.openjdk.org" rel=3D"no=
referrer" target=3D"_blank">hg.openjdk.org</a>)|23.54.129.73|:443... connec=
ted.<br>
HTTP request sent, awaiting response...<br>
<br>
Signed-off-by: Thomas Perrot &lt;<a href=3D"mailto:thomas.perrot@bootlin.co=
m" target=3D"_blank">thomas.perrot@bootlin.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/fetch2/wget.py | 7 ++++---<br>
=C2=A01 file changed, 4 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py<br>
index dc025800e659..e7c4cdd396b3 100644<br>
--- a/lib/bb/fetch2/wget.py<br>
+++ b/lib/bb/fetch2/wget.py<br>
@@ -87,7 +87,8 @@ class Wget(FetchMethod):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not ud.localfile:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ud.localfile =3D d.expand(u=
rllib.parse.unquote(ud.host + ud.path).replace(&quot;/&quot;, &quot;.&quot;=
))<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.basecmd =3D d.getVar(&quot;FETCHCMD_wget&=
quot;) or &quot;/usr/bin/env wget -t 2 -T 30 --passive-ftp&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.basecmd =3D d.getVar(&quot;FETCHCMD_wget&=
quot;) \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 or &quot;/usr/bin/env wget -t 2 =
-T 30 --passive-ftp --user-agent=3D&#39;%s&#39;&quot; % (self.user_agent)<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not self.check_certs(d):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.basecmd +=3D &quot; --=
no-check-certificate&quot;<br>
@@ -454,7 +455,7 @@ class Wget(FetchMethod):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f =3D tempfile.NamedTemporaryFile()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0with tempfile.TemporaryDirectory(prefix=
=3D&quot;wget-index-&quot;) as workdir, tempfile.NamedTemporaryFile(dir=3Dw=
orkdir, prefix=3D&quot;wget-listing-&quot;) as f:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fetchcmd =3D self.basecmd<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fetchcmd +=3D &quot; -O &quot; +=
 <a href=3D"http://f.name" rel=3D"noreferrer" target=3D"_blank">f.name</a> =
+ &quot; --user-agent=3D&#39;&quot; + self.user_agent + &quot;&#39; &#39;&q=
uot; + uri + &quot;&#39;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fetchcmd +=3D &quot; -O &#39;&qu=
ot; + uri + &quot;&#39;&quot;<br></blockquote><div><br></div><div>Looks lik=
e the file name was removed unintentional.<br><br>Jose</div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._runwget=
(ud, d, fetchcmd, True, workdir=3Dworkdir)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fetchresult =
=3D f.read()<br>
@@ -492,7 +493,7 @@ class Wget(FetchMethod):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0valid =3D 1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0elif self._ve=
rcmp(version, newver) &lt; 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0version =3D newver<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pupver =3D re.sub(&#39;_&#39;, &#39;.&#39=
;, version[1])<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.debug(3, &quot;*** %s -&gt; UpstreamVe=
rsion =3D %s (CurrentVersion =3D %s)&quot; %<br>
-- <br>
2.43.0<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#15851): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/15851" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/15851</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/104260370/505=
2612" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/104260370/5052612</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:quaresma.jose@gmail.com" target=3D=
"_blank">quaresma.jose@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr">Best regards,<div><br>Jos=C3=A9 Quaresma</div></div></div></=
div>

--000000000000805ad40610f4e947--

