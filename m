Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43A8CCD18D
	for <webhook@archiver.kernel.org>; Thu,  9 Oct 2025 17:58:08 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web10.7145.1760032678813206199
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Oct 2025 10:57:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=o6qvsKeW;
 spf=pass (domain: smile.fr, ip: 209.85.221.42, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso1290926f8f.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 09 Oct 2025 10:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1760032677; x=1760637477; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vgEzIiw4PMrBJA+GAv95nBKs2MY3G9kNGKO8iYt5zEA=;
        b=o6qvsKeWFDdmYFPOCmhvMc7Eg/AD6zkcOmRDZJ+nANUBHGgJ3vC8+Gnt4cWXJrfxsw
         F4qe0YPJcLOG9Jq3ZY5qWH4gbuKrIppcKuFdO+9OAJK1liwWRmkIHfn1R4EJBB/na1kD
         WkmdrbPchdBVYPHUakFJDOEnry6crsRjdU6IQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760032677; x=1760637477;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vgEzIiw4PMrBJA+GAv95nBKs2MY3G9kNGKO8iYt5zEA=;
        b=WuejwLbM8d0hAemRn8nTL7uMVw3gfVYN0iuaK10ct0c/VhwscIug7A6szqOSHu3rTz
         KuP/o4MSTu/Um/WXB+yXjzRR2aRWD7t8qkX0sdDgfsDxxv+u3M64MxcJyTw8fT+tzNJg
         9QEhkGs10HMVVuW7c5MjCW+9FPvfWo+zNjYlRV2wg0bUO4NHv5ixaC92kluPJ2Q8HaGA
         FI00/qVzJ6A7M8Jucm6aFj2XUBqtXbX+rz63op/9h0AHoqG7VspSHQyKuEBOje77Ux3N
         PfgVzgFWL2g121N9cM81jVp4Pkd7CVnaCVRKphl0Rij3qAsAVWh0bW2p0uC23JSNscwb
         dEJQ==
X-Gm-Message-State: AOJu0Yxsjg0swX6Xo83dLE5iY59NB+txR/+CWgDMnzc3Xg1A7fcLE0sw
	C/8HwdmWRw+w9Io49WLhg9axRakJUh2hQrylVnYQsCK8Cq24J1r7ZBQIiZ+BLG/1j0VSp9NSZOv
	ddBqMf1LXDF027kHzqUboRYrWm/Ojikpcy9vMHU3202QT8QizwLGq
X-Gm-Gg: ASbGncuBO/T/Z2hBSZKtyARRV4P3QFUXi+F0FYW5Fqq4mjwvvsA7SEdgnqW3b1kj+Nz
	cjYCNcnib4o60J6ueuZ9r5TPRecgzLZW4J2aIpeIRp+1krn0Qw6MGbcTZuJh3I2ibVXOw5WtQnq
	6kgu2EXs3kQ43TsPZ7sUbU+vMBTAPV4xDumGJxqRZPWx2L09K5t+gkbn7nZPUHQmZ2WMdkchY6q
	mqwMSkk6br8rZWilDOS7yvtxfL+1f6YvwFMLKcQUvgAbt7Alqc5Z5weGtQ7/A==
X-Google-Smtp-Source: AGHT+IEIArC+iJ2/ax+UvfhB9DDRyCd4hjb0RAKjUJDegE3WUm40OSrQ0lvrbBMBd7KXFIHuTj8La/Ykq9pyJg6nQfY=
X-Received: by 2002:a05:6000:2285:b0:3ec:8c8:7b79 with SMTP id
 ffacd0b85a97d-4266e8e0bdfmr5942253f8f.61.1760032677178; Thu, 09 Oct 2025
 10:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <20251009175300.7480-1-bhstalel@gmail.com>
In-Reply-To: <20251009175300.7480-1-bhstalel@gmail.com>
From: Yoann Congal <yoann.congal@smile.fr>
Date: Thu, 9 Oct 2025 19:57:30 +0200
X-Gm-Features: AS18NWDl2GgiH26-F674wpRDtLQ8HVQhqEZhXSs9m1keuMAjRJoec5VrWNgbJqI
Message-ID: <CAMSfU+7iRzDoCTAnYQFhCju+tVVhiEXoyWceQjX7ReceegDoDg@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] lib/bb/data_smart: add removeFromVar method
To: bhstalel@gmail.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000843ffb0640bd8a4a"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Oct 2025 17:58:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18157

--000000000000843ffb0640bd8a4a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 9 oct. 2025 =C3=A0 19:53, BELHADJ SALEM Talel via lists.openembedde=
d.org
<bhstalel=3Dgmail.com@lists.openembedded.org> a =C3=A9crit :

> Tested with:
>
> MY_VARIABLE =3D "foo hello foo world"
> python () {
>     d.removeFromVar('MY_VARIABLE', 'foo')
> }
>
> $ bitbake-getvar -r example --value MY_VARIABLE
>  hello  world
>

Out of curiosity, what does the variable history look like? (same command
without the --value)


> Signed-off-by: Talel BELHAJ SALEM <bhstalel@gmail.com>
> ---
>  lib/bb/data_smart.py | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
> index 2e0d30858..554255f3d 100644
> --- a/lib/bb/data_smart.py
> +++ b/lib/bb/data_smart.py
> @@ -714,6 +714,11 @@ class DataSmart(MutableMapping):
>          self.varhistory.record(**loginfo)
>          self.setVar(var + ":prepend", value, ignore=3DTrue, parsing=3DTr=
ue)
>
> +    def removeFromVar(self, var, value, **loginfo):
> +        loginfo['op'] =3D 'remove'
> +        self.varhistory.record(**loginfo)
> +        self.setVar(var + ":remove", value, ignore=3DTrue, parsing=3DTru=
e)
> +
>      def delVar(self, var, **loginfo):
>          self.expand_cache =3D {}
>
> --
> 2.51.0
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18156):
> https://lists.openembedded.org/g/bitbake-devel/message/18156
> Mute This Topic: https://lists.openembedded.org/mt/115676008/4316185
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> yoann.congal@smile.fr]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--=20
Yoann Congal
Smile ECS

--000000000000843ffb0640bd8a4a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Le=C2=A0jeu. 9 =
oct. 2025 =C3=A0=C2=A019:53, BELHADJ SALEM Talel via <a href=3D"http://list=
s.openembedded.org">lists.openembedded.org</a> &lt;bhstalel=3D<a href=3D"ma=
ilto:gmail.com@lists.openembedded.org">gmail.com@lists.openembedded.org</a>=
&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Tested with:<br>
<br>
MY_VARIABLE =3D &quot;foo hello foo world&quot;<br>
python () {<br>
=C2=A0 =C2=A0 d.removeFromVar(&#39;MY_VARIABLE&#39;, &#39;foo&#39;)<br>
}<br>
<br>
$ bitbake-getvar -r example --value MY_VARIABLE<br>
=C2=A0hello=C2=A0 world<br></blockquote><div><br></div><div>Out of curiosit=
y, what does the variable history look like? (same command without the --va=
lue)</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
Signed-off-by: Talel BELHAJ SALEM &lt;<a href=3D"mailto:bhstalel@gmail.com"=
 target=3D"_blank">bhstalel@gmail.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/data_smart.py | 5 +++++<br>
=C2=A01 file changed, 5 insertions(+)<br>
<br>
diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py<br>
index 2e0d30858..554255f3d 100644<br>
--- a/lib/bb/data_smart.py<br>
+++ b/lib/bb/data_smart.py<br>
@@ -714,6 +714,11 @@ class DataSmart(MutableMapping):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.varhistory.record(**loginfo)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.setVar(var + &quot;:prepend&quot;, v=
alue, ignore=3DTrue, parsing=3DTrue)<br>
<br>
+=C2=A0 =C2=A0 def removeFromVar(self, var, value, **loginfo):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 loginfo[&#39;op&#39;] =3D &#39;remove&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.varhistory.record(**loginfo)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.setVar(var + &quot;:remove&quot;, value, =
ignore=3DTrue, parsing=3DTrue)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0def delVar(self, var, **loginfo):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.expand_cache =3D {}<br>
<br>
-- <br>
2.51.0<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#18156): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/18156" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/18156</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/115676008/431=
6185" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/115676008/4316185</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:yoann.congal@smile.fr" target=3D"_=
blank">yoann.congal@smile.fr</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"Raleway, regular">Yoann Congal</font><div><fon=
t face=3D"Raleway, regular">Smile ECS</font></div></div></div></div>

--000000000000843ffb0640bd8a4a--

