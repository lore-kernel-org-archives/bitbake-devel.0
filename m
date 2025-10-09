Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1670ACCD184
	for <webhook@archiver.kernel.org>; Thu,  9 Oct 2025 18:33:19 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web11.7949.1760034791767376256
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Oct 2025 11:33:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=svr3kZfm;
 spf=pass (domain: smile.fr, ip: 209.85.221.45, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3f0134ccc0cso936603f8f.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 09 Oct 2025 11:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1760034790; x=1760639590; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P9z9KyJ87ciaq02CGNpzg/tt7tZY9Horzn1OKgjQpFQ=;
        b=svr3kZfmMFH1IIpMJhr907C4ujv2gvAxNPnJJpZ389nKjm+7xpJ39cM3WFH0Xg47r6
         V2qXVAjWU+bCngP+Ej5UeUzV3Tw0rPSknua2iXA6in7/nSynHGs88SYOOIC6dK/GyuKp
         fCrHisdWh4KTdOW/2QlUiGJBAzDy63dg/hi8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760034790; x=1760639590;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P9z9KyJ87ciaq02CGNpzg/tt7tZY9Horzn1OKgjQpFQ=;
        b=KfOWZRxAY+HzcL8+NyNZOGUpUCj5yY/INghQw0YvHpe3ixD3+v5wtKJLQGVJsGH9BN
         frGJEW+Gb4wFzO5zbgZxafX6aJgdS/+mIl6StKoO1AExwW4eeGr5rQgrvyZ4OlnZ1Vxg
         eo1Qj+A9yP4mQ3px6cfVY5G5K82EY9G6EnO/t9Xtm3TqiC8XYBnVwdK3wuULT+mp0SkS
         pGo3zB+rA5fJnSAt95Ny0QqnfV5R+3J8X/IHjh3FN/PynmIUzSM3s18JO28RVZcsAm7O
         tuN0DmhSGe/0BPjEfEDfZRMFXknVkPP68cKlUUXPKRiaelExVziq+cFkAWS81Lb6g2fw
         zivA==
X-Gm-Message-State: AOJu0YxKg17Oln0oiYA+npvgUFvpI2MHMKVOiLJQUmJflYIyAhKR1zvV
	sEMCSaZmrCwaJizmiK9EwPEDlt/UJhsbYSDX43pH2ypHEHLuCH8dDq3lRSyDY7KYWPddOQl8/N5
	Zje8NZ+OSbjIc1QQTnwdCenbig9CRhHMuY+p14lq2Og==
X-Gm-Gg: ASbGncvaxq7Hcoz5vStkLIoFA3hxi6oFD4e2Giq5fHjSY0VBxgMt1QCv6yRs3FoCR1e
	ZeK0PRTBhntBXgLSRi5s0JPhWDTqvzQMrzYbrqkoFzD8m0CZ41s2g8nI5s+1x2r75Uio9YR8qb7
	EOaLVayu/uo3gUHjAOsJ4iOwGdjYMqvfXPd4ZntRp7BUgwGMYErcxdTssQfp78rYqXYmjh3H0Zj
	ug5wI4Nst+SxyawpxUc614lqCCqxhpUWVCgFHNS28Ts/U7UAt2YAk+9gQbzGYMdAmoUKceb3VlC
	LUCruDs=
X-Google-Smtp-Source: AGHT+IFqB5Knrv9FFVvr592o9cUr9Kcnhl5UV0QwunMJv5sgWu6z+72nHzkDCL8UaEshQBWTOuHCQJbARtuFOhtNoU8=
X-Received: by 2002:a05:6000:2004:b0:425:769e:515a with SMTP id
 ffacd0b85a97d-4266e8dc000mr5599570f8f.42.1760034790082; Thu, 09 Oct 2025
 11:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <20251009175300.7480-1-bhstalel@gmail.com> <CAMSfU+7iRzDoCTAnYQFhCju+tVVhiEXoyWceQjX7ReceegDoDg@mail.gmail.com>
 <CAOgG7m3BeXJ6Fha_onKa5HRZwX4=vsy4542jvJ50wzR8-NzNjw@mail.gmail.com>
In-Reply-To: <CAOgG7m3BeXJ6Fha_onKa5HRZwX4=vsy4542jvJ50wzR8-NzNjw@mail.gmail.com>
From: Yoann Congal <yoann.congal@smile.fr>
Date: Thu, 9 Oct 2025 20:32:43 +0200
X-Gm-Features: AS18NWCTP_SainEjKDTKg-GUNIbJ6F5lZoomyus5-hwJcERxhWvV-BZOuehFE_s
Message-ID: <CAMSfU+5yzdK-HpAhgAgqaauP+ZAnH_PcL8+O71mswqr2T-mLqA@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] lib/bb/data_smart: add removeFromVar method
To: Talel BELHADJ SALEM <bhstalel@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000074a0cd0640be083c"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Oct 2025 18:33:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18159

--00000000000074a0cd0640be083c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 9 oct. 2025 =C3=A0 20:03, Talel BELHADJ SALEM <bhstalel@gmail.com> =
a
=C3=A9crit :

> It has two actions on it : set and remove:
>
> $ bitbake-getvar -r example MY_VARIABLE
>> #
>> # $MY_VARIABLE [2 operations]
>> #   set /work/meta-test/recipes-example/example/example_0.1.bb:5
>> #     "foo hello foo world"
>> #   remove example_0.1.bb:8
>> [__anon_9__work_meta_test_recipes_example_example_example_0_1_bb]
>> #     "foo"
>> # pre-expansion value:
>> #   "foo hello foo world"
>> MY_VARIABLE=3D" hello  world"
>
>
Thank you. It does look good!


> On Thu, Oct 9, 2025 at 6:57=E2=80=AFPM Yoann Congal <yoann.congal@smile.f=
r> wrote:
>
>>
>>
>> Le jeu. 9 oct. 2025 =C3=A0 19:53, BELHADJ SALEM Talel via
>> lists.openembedded.org <bhstalel=3Dgmail.com@lists.openembedded.org> a
>> =C3=A9crit :
>>
>>> Tested with:
>>>
>>> MY_VARIABLE =3D "foo hello foo world"
>>> python () {
>>>     d.removeFromVar('MY_VARIABLE', 'foo')
>>> }
>>>
>>> $ bitbake-getvar -r example --value MY_VARIABLE
>>>  hello  world
>>>
>>
>> Out of curiosity, what does the variable history look like? (same comman=
d
>> without the --value)
>>
>>
>>> Signed-off-by: Talel BELHAJ SALEM <bhstalel@gmail.com>
>>> ---
>>>  lib/bb/data_smart.py | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
>>> index 2e0d30858..554255f3d 100644
>>> --- a/lib/bb/data_smart.py
>>> +++ b/lib/bb/data_smart.py
>>> @@ -714,6 +714,11 @@ class DataSmart(MutableMapping):
>>>          self.varhistory.record(**loginfo)
>>>          self.setVar(var + ":prepend", value, ignore=3DTrue, parsing=3D=
True)
>>>
>>> +    def removeFromVar(self, var, value, **loginfo):
>>> +        loginfo['op'] =3D 'remove'
>>> +        self.varhistory.record(**loginfo)
>>> +        self.setVar(var + ":remove", value, ignore=3DTrue, parsing=3DT=
rue)
>>> +
>>>      def delVar(self, var, **loginfo):
>>>          self.expand_cache =3D {}
>>>
>>> --
>>> 2.51.0
>>>
>>>
>>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>> Links: You receive all messages sent to this group.
>>> View/Reply Online (#18156):
>>> https://lists.openembedded.org/g/bitbake-devel/message/18156
>>> Mute This Topic: https://lists.openembedded.org/mt/115676008/4316185
>>> Group Owner: bitbake-devel+owner@lists.openembedded.org
>>> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
>>> yoann.congal@smile.fr]
>>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>>
>>>
>>
>> --
>> Yoann Congal
>> Smile ECS
>>
>

--=20
Yoann Congal
Smile ECS

--00000000000074a0cd0640be083c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Le=C2=A0jeu. 9 =
oct. 2025 =C3=A0=C2=A020:03, Talel BELHADJ SALEM &lt;<a href=3D"mailto:bhst=
alel@gmail.com">bhstalel@gmail.com</a>&gt; a =C3=A9crit=C2=A0:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">It has two =
actions on it : set and remove:<div><br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">$ bitbake-getvar -r example MY_VARIABLE<br>#<br># $MY_=
VARIABLE [2 operations]<br># =C2=A0 set /work/meta-test/recipes-example/exa=
mple/<a href=3D"http://example_0.1.bb:5" target=3D"_blank">example_0.1.bb:5=
</a><br># =C2=A0 =C2=A0 &quot;foo hello foo world&quot;<br># =C2=A0 remove =
<a href=3D"http://example_0.1.bb:8" target=3D"_blank">example_0.1.bb:8</a> =
[__anon_9__work_meta_test_recipes_example_example_example_0_1_bb]<br># =C2=
=A0 =C2=A0 &quot;foo&quot;<br># pre-expansion value:<br># =C2=A0 &quot;foo =
hello foo world&quot;<br>MY_VARIABLE=3D&quot; hello =C2=A0world&quot;</bloc=
kquote></div></blockquote><div><br></div><div>Thank=C2=A0you. It does look =
good!</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu,=
 Oct 9, 2025 at 6:57=E2=80=AFPM Yoann Congal &lt;<a href=3D"mailto:yoann.co=
ngal@smile.fr" target=3D"_blank">yoann.congal@smile.fr</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div=
 dir=3D"ltr"><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">Le=C2=A0jeu. 9 oct. 2025 =C3=A0=C2=A019:53, BELHADJ SALEM =
Talel via <a href=3D"http://lists.openembedded.org" target=3D"_blank">lists=
.openembedded.org</a> &lt;bhstalel=3D<a href=3D"mailto:gmail.com@lists.open=
embedded.org" target=3D"_blank">gmail.com@lists.openembedded.org</a>&gt; a =
=C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">Tested with:<br>
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
</blockquote></div>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"Raleway, regular">Yoann Congal</font><div><fon=
t face=3D"Raleway, regular">Smile ECS</font></div></div></div></div>

--00000000000074a0cd0640be083c--

