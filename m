Return-Path: <bhstalel@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D78CCD183
	for <webhook@archiver.kernel.org>; Thu,  9 Oct 2025 18:03:08 +0000 (UTC)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
 by mx.groups.io with SMTP id smtpd.web10.7307.1760032988464310405
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Oct 2025 11:03:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=FCku/Idg;
 spf=pass (domain: gmail.com, ip: 209.85.222.172, mailfrom: bhstalel@gmail.com)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-863762d794cso27036085a.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 09 Oct 2025 11:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760032987; x=1760637787; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BD2qBUhtwoVCdU08sl6B/bj8ZGn/H+tQuxkeHQpjLCQ=;
        b=FCku/IdgUZbWoqEtl8AstMMq/HL6YQjH5JQ3n4XYEf7bixwtNP6F1ksgNBt45LlHsU
         WXlOPrFO4EoG5HHXGJXwlvO6Q0sGW+qLsYgAGLqtwrXw8eE7J+0f9fuy7Gh4DaSbUvB4
         xvCkN6mWEnWB5N8MP4jvN8Wpvy4FWlrSaEAuASiTOhbPXCR7Ux74cDGZEW66zrCe0QCq
         hve/HMLnZg3C0s6lAll/UnkR4JOjUxtaOikdSUsmEFnNYtvlgnMDtMiguOCQb9DRux2x
         6my0VGyCx19zaEPzn34msqk4qyzGtWxlrtSiBJJGR84CzAKzvnvE+l89kX++misf+UU6
         ADow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760032987; x=1760637787;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BD2qBUhtwoVCdU08sl6B/bj8ZGn/H+tQuxkeHQpjLCQ=;
        b=JJB/VZCoE/H+nqK/l51hsIVkavRx0LXUEiJDsfgQCfYBG+k0lcCxDaGN8bExCRjsuZ
         hDIwit/BD3N+bGB8CTdGYEWmhwHSsIbjjFt7DH389n5yoNZfxuu/hrkVx14EIqjIpqb3
         xM1trWCWpx4QWYSkKDsui0/JCapTWsBC3FhhmC8Bw1Lr9jKVpxR7baFbbiw9/RYeRqDB
         QJVO6+hbxjVuTp3WtXdtvKPCJpnPJULoJMuh3YPpd5wKEAVA8CPAWJCZAg6wfqRhXr5f
         oPXvoL9s1nsUFz5aICdSamIh6BYAFssEulfe7Mid4cQremWNaWR3P0TYHSY/waup0Um7
         cNzQ==
X-Gm-Message-State: AOJu0Yw+3p0LxAEJ1XJCwuPio2WytLprw6CJ294zfSR2h6vxNDZxU5Nt
	4uqX38feCXNIq+Jh+m58e/yHLFFlOdf9WFuvLYhSbqtvxscU7R9pjInZMv4ksABUuhzMY0J00nx
	5lfod+fIIrN8DmT3Au6UN6EXXQRfjRV+wfjpUGbU=
X-Gm-Gg: ASbGncu9/UJfdHgRanKua/n/kDyeHy4AwkrmozxL7fp5tor40/PqKnlUAVEZL6oxvQ6
	eUPLvOZ1vrytuQcOow5tiGOGmwUvFSnBX1sChyKjkql7GAFlmwgM5B/L4KW5NnerOY430ZrHftn
	ZzpOeWjoGKSEE4k3vwmS+rR2Egyn1+692d1NkxZY1D93TeFQ2j1c7T5+h6ucErYgBcSM81zzvT/
	tXtD8l7BgZHDm8IgFm21Euvk48QYQn2
X-Google-Smtp-Source: AGHT+IGsCW3CfY1cdIZwnkpGwQo7pwO5s5V1I+/+cFJjtej6xNSa7OOQQ3x0F2vf/vBJp7AlNdPdPd31A+kDRLUT448=
X-Received: by 2002:a05:620a:372c:b0:86b:12e2:28d1 with SMTP id
 af79cd13be357-88352d954aemr819159585a.7.1760032987087; Thu, 09 Oct 2025
 11:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <20251009175300.7480-1-bhstalel@gmail.com> <CAMSfU+7iRzDoCTAnYQFhCju+tVVhiEXoyWceQjX7ReceegDoDg@mail.gmail.com>
In-Reply-To: <CAMSfU+7iRzDoCTAnYQFhCju+tVVhiEXoyWceQjX7ReceegDoDg@mail.gmail.com>
From: Talel BELHADJ SALEM <bhstalel@gmail.com>
Date: Thu, 9 Oct 2025 19:02:55 +0100
X-Gm-Features: AS18NWAILdmwW5-UgDOluBOwOa6LgdPOAlPLyUV5OtC-trMvo60gl5EiHF17hBA
Message-ID: <CAOgG7m3BeXJ6Fha_onKa5HRZwX4=vsy4542jvJ50wzR8-NzNjw@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] lib/bb/data_smart: add removeFromVar method
To: Yoann Congal <yoann.congal@smile.fr>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000fd08e70640bd9c19"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Oct 2025 18:03:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18158

--000000000000fd08e70640bd9c19
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It has two actions on it : set and remove:

$ bitbake-getvar -r example MY_VARIABLE
> #
> # $MY_VARIABLE [2 operations]
> #   set /work/meta-test/recipes-example/example/example_0.1.bb:5
> #     "foo hello foo world"
> #   remove example_0.1.bb:8
> [__anon_9__work_meta_test_recipes_example_example_example_0_1_bb]
> #     "foo"
> # pre-expansion value:
> #   "foo hello foo world"
> MY_VARIABLE=3D" hello  world"


On Thu, Oct 9, 2025 at 6:57=E2=80=AFPM Yoann Congal <yoann.congal@smile.fr>=
 wrote:

>
>
> Le jeu. 9 oct. 2025 =C3=A0 19:53, BELHADJ SALEM Talel via
> lists.openembedded.org <bhstalel=3Dgmail.com@lists.openembedded.org> a
> =C3=A9crit :
>
>> Tested with:
>>
>> MY_VARIABLE =3D "foo hello foo world"
>> python () {
>>     d.removeFromVar('MY_VARIABLE', 'foo')
>> }
>>
>> $ bitbake-getvar -r example --value MY_VARIABLE
>>  hello  world
>>
>
> Out of curiosity, what does the variable history look like? (same command
> without the --value)
>
>
>> Signed-off-by: Talel BELHAJ SALEM <bhstalel@gmail.com>
>> ---
>>  lib/bb/data_smart.py | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
>> index 2e0d30858..554255f3d 100644
>> --- a/lib/bb/data_smart.py
>> +++ b/lib/bb/data_smart.py
>> @@ -714,6 +714,11 @@ class DataSmart(MutableMapping):
>>          self.varhistory.record(**loginfo)
>>          self.setVar(var + ":prepend", value, ignore=3DTrue, parsing=3DT=
rue)
>>
>> +    def removeFromVar(self, var, value, **loginfo):
>> +        loginfo['op'] =3D 'remove'
>> +        self.varhistory.record(**loginfo)
>> +        self.setVar(var + ":remove", value, ignore=3DTrue, parsing=3DTr=
ue)
>> +
>>      def delVar(self, var, **loginfo):
>>          self.expand_cache =3D {}
>>
>> --
>> 2.51.0
>>
>>
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#18156):
>> https://lists.openembedded.org/g/bitbake-devel/message/18156
>> Mute This Topic: https://lists.openembedded.org/mt/115676008/4316185
>> Group Owner: bitbake-devel+owner@lists.openembedded.org
>> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
>> yoann.congal@smile.fr]
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>
>>
>
> --
> Yoann Congal
> Smile ECS
>

--000000000000fd08e70640bd9c19
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">It has two actions on it : set and remove:<div><br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">$ bitbake-getvar -r exampl=
e MY_VARIABLE<br>#<br># $MY_VARIABLE [2 operations]<br># =C2=A0 set /work/m=
eta-test/recipes-example/example/<a href=3D"http://example_0.1.bb:5">exampl=
e_0.1.bb:5</a><br># =C2=A0 =C2=A0 &quot;foo hello foo world&quot;<br># =C2=
=A0 remove <a href=3D"http://example_0.1.bb:8">example_0.1.bb:8</a> [__anon=
_9__work_meta_test_recipes_example_example_example_0_1_bb]<br># =C2=A0 =C2=
=A0 &quot;foo&quot;<br># pre-expansion value:<br># =C2=A0 &quot;foo hello f=
oo world&quot;<br>MY_VARIABLE=3D&quot; hello =C2=A0world&quot;</blockquote>=
</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Thu, Oct 9, 2025 at 6:57=E2=80=AFPM Yoann Congal &=
lt;<a href=3D"mailto:yoann.congal@smile.fr">yoann.congal@smile.fr</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=
=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">Le=C2=A0jeu. 9 oct. 2025 =C3=A0=C2=A019:53, B=
ELHADJ SALEM Talel via <a href=3D"http://lists.openembedded.org" target=3D"=
_blank">lists.openembedded.org</a> &lt;bhstalel=3D<a href=3D"mailto:gmail.c=
om@lists.openembedded.org" target=3D"_blank">gmail.com@lists.openembedded.o=
rg</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">Tested with:<br>
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

--000000000000fd08e70640bd9c19--

