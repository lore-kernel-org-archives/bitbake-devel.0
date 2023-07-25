Return-Path: <dit.kozmaj@kynetics.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E528C0015E
	for <webhook@archiver.kernel.org>; Tue, 25 Jul 2023 13:55:04 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
 by mx.groups.io with SMTP id smtpd.web11.20969.1690293302155020514
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Jul 2023 06:55:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kynetics.com header.s=google header.b=Wlgprr3i;
 spf=pass (domain: kynetics.com, ip: 209.85.128.173, mailfrom: dit.kozmaj@kynetics.com)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-583f036d50bso28605107b3.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 25 Jul 2023 06:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kynetics.com; s=google; t=1690293301; x=1690898101;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wg63MezjEVfRLizcjvz1aOt0dDFwnGICfg03s51M7u4=;
        b=Wlgprr3iUVhPDPFAm2njQ0mkkexdgyByM1qw10HP6lQd9+SzR3NESYIV2Q0LL7EBWD
         RArRTOO2CnWUo7AtfzoOCv2rUK3nZ5jTNGWXULYi8WS2Zkd2ZV1se9AtcDvn3jOmfMBs
         YKPMf21/SaagGUd0ZvZbNzMG4Hneeq8csaBX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690293301; x=1690898101;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wg63MezjEVfRLizcjvz1aOt0dDFwnGICfg03s51M7u4=;
        b=jYczT3b7jQsBPY+Eve14AYs7hfeCCjGdfOLSdB6OoC8GrlRIIKxmVw4XzxSzOZqpRp
         ZLzeaUAiTyuW6v7KO3/PSkgulALuFLTmmg6TLhSkWhfroRh4bYOoSdPtcMnnyKCcSV0H
         4mJOuWByX2l3a/LrRV+xPNutyz/9Ihve3SX2uASHbApm8s9lkrNB6cWISrJSQH7I9z2q
         odnBc9DFBo8vXMjC+ZJ21sRcGJm8k9iCP3790njURmxmZDEls16BJJ5u3mC5xQtAEzub
         9HAc24sSQ95rNCMz8Dsr40BhIZEtgrYWc73T4/l193TGjj2Cn5DmXnaRbQ1NxKNOPHmV
         3l+g==
X-Gm-Message-State: ABy/qLYHkHwaaENzKjIEfJIzG3Z17N2DHCCgiehIJ3z8CNMcaKZrdsVg
	3cv0+xAlXF3BRCl5w3uQEupbx8H2SOy4sH/8VCkyFA==
X-Google-Smtp-Source: APBJJlH/500f5TqMwABpAIxYd7sVSbK7A0B/3a5gPYZ5Qvi2i0xd3lWxh0aJgBwD27rDBL/6ZFFFiqhCc73V7dwLzqI=
X-Received: by 2002:a0d:d98f:0:b0:57a:6df7:5ccd with SMTP id
 b137-20020a0dd98f000000b0057a6df75ccdmr12543060ywe.13.1690293301251; Tue, 25
 Jul 2023 06:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <1775206198E7C996.23395@lists.openembedded.org>
In-Reply-To: <1775206198E7C996.23395@lists.openembedded.org>
From: Dit Kozmaj <dit.kozmaj@kynetics.com>
Date: Tue, 25 Jul 2023 15:54:50 +0200
Message-ID: <CABU0hB+dQVPxehonE2FvNa2O__mK61LQ9iqGTYcrY1M1JYTw2w@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Set maxsplit to match expected variables
To: dit.kozmaj@kynetics.com
Cc: bitbake-devel@lists.openembedded.org, 
	Diego Rondini <diego.rondini@kynetics.com>
Content-Type: multipart/alternative; boundary="000000000000c9bca20601501339"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Jul 2023 13:55:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14888

--000000000000c9bca20601501339
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Bitbucket added a new feature that provides limited access to a specific
repository using a Repository Access Tokens. This token comes in the form
token-auth:key.

https://support.atlassian.com/bitbucket-cloud/docs/repository-access-tokens=
/
https://support.atlassian.com/bitbucket-cloud/docs/using-access-tokens/#Inc=
lude-the-Repository-Access-Token-in-the-URL

The token can be used in the user parameter of SRC_URI as this parameter is
in the form user=3Duserid:password, and works correctly excluding the cases
when the password contains a "=3D" symbol.
The error comes from the split logic, which doesn't manage the case when
the value contains the symbol "=3D".
The proposed change guarantees that only two variables will be returned,
splitted in "key" and "value" and the value can contain, especially in
cases when it is a password, the "=3D" character.
As requested, we also add a test case , run the test with bitbake-selftest
bb.tests.fetch. The result is successful.



On Tue, Jul 25, 2023 at 3:47=E2=80=AFPM Dit Kozmaj via lists.openembedded.o=
rg
<dit.kozmaj=3Dkynetics.com@lists.openembedded.org> wrote:

> From: Dit Kozmaj <dit.kozmaj@kynetics.com>
>
> Set the maxsplit value to match the expected number of variables.
> This also avoids an unnecessary split as the parameters are in the form
> 'key=3Dvalue'
> and the 'value' could contain the '=3D' character.
>
> Signed-off-by: Dit Kozmaj <dit.kozmaj@kynetics.com>
> ---
>  bitbake/lib/bb/fetch2/__init__.py | 2 +-
>  bitbake/lib/bb/tests/fetch.py     | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/bitbake/lib/bb/fetch2/__init__.py
> b/bitbake/lib/bb/fetch2/__init__.py
> index 3e6555bd67..79b289eaec 100644
> --- a/bitbake/lib/bb/fetch2/__init__.py
> +++ b/bitbake/lib/bb/fetch2/__init__.py
> @@ -388,7 +388,7 @@ def decodeurl(url):
>              if s:
>                  if not '=3D' in s:
>                      raise MalformedUrl(url, "The URL: '%s' is invalid:
> parameter %s does not specify a value (missing '=3D')" % (url, s))
> -                s1, s2 =3D s.split('=3D')
> +                s1, s2 =3D s.split('=3D', 1)
>                  p[s1] =3D s2
>
>      return type, host, urllib.parse.unquote(path), user, pswd, p
> diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.p=
y
> index 61dd5cccaf..a261ad69d8 100644
> --- a/bitbake/lib/bb/tests/fetch.py
> +++ b/bitbake/lib/bb/tests/fetch.py
> @@ -1197,6 +1197,7 @@ class URLHandle(unittest.TestCase):
>         "cvs://
> anoncvs:anonymous@cvs.handhelds.org/cvs;tag=3DV0-99-81;module=3Dfamiliar/=
dist/ipkg"
> : ('cvs', 'cvs.handhelds.org', '/cvs', 'anoncvs', 'anonymous',
> collections.OrderedDict([('tag', 'V0-99-81'), ('module',
> 'familiar/dist/ipkg')])),
>         "git://git.openembedded.org/bitbake;branch=3D@foo" : ('git', '
> git.openembedded.org', '/bitbake', '', '', {'branch': '@foo'}),
>         "file://somelocation;someparam=3D1": ('file', '', 'somelocation',
> '', '', {'someparam': '1'}),
> +       "https://somesite.com/somerepo.git;user=3DanyUser:idtoken=3D1234"=
 :
> ('https', 'somesite.com', '/somerepo.git', '', '', {'user':
> 'anyUser:idtoken=3D1234'}),
>      }
>      # we require a pathname to encodeurl but users can still pass such
> urls to
>      # decodeurl and we need to handle them
> --
> 2.25.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14887):
> https://lists.openembedded.org/g/bitbake-devel/message/14887
> Mute This Topic: https://lists.openembedded.org/mt/100350479/7542774
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> dit.kozmaj@kynetics.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000c9bca20601501339
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Bitbucket added a new feature that provides limited access=
 to a specific repository using a Repository Access Tokens. This token come=
s in the form<span style=3D"font-family:monospace"> token-auth:key</span>.<=
br><br><span style=3D"color:rgb(0,0,255)"><a href=3D"https://support.atlass=
ian.com/bitbucket-cloud/docs/repository-access-tokens/">https://support.atl=
assian.com/bitbucket-cloud/docs/repository-access-tokens/</a><br><a href=3D=
"https://support.atlassian.com/bitbucket-cloud/docs/using-access-tokens/#In=
clude-the-Repository-Access-Token-in-the-URL">https://support.atlassian.com=
/bitbucket-cloud/docs/using-access-tokens/#Include-the-Repository-Access-To=
ken-in-the-URL</a></span><br><br>The token can be used in the user paramete=
r of SRC_URI as this parameter is in the form user=3Duserid:password, and w=
orks correctly excluding the cases when the password contains a &quot;=3D&q=
uot; symbol.<br>The error comes from the split logic, which doesn&#39;t man=
age the case when the value contains the symbol &quot;=3D&quot;.<br>The pro=
posed change guarantees that only two variables will be returned, splitted =
in &quot;key&quot; and &quot;value&quot; and the value can contain, especia=
lly in cases when it is a password, the &quot;=3D&quot; character.<br><div>=
As requested, we also add a test case , run the test with<span style=3D"fon=
t-family:monospace"> bitbake-selftest bb.tests.fetch</span>. The result is =
successful.</div><div><br></div><div><br></div></div><br><div class=3D"gmai=
l_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 25, 2023 at 3:47=
=E2=80=AFPM Dit Kozmaj via <a href=3D"http://lists.openembedded.org">lists.=
openembedded.org</a> &lt;dit.kozmaj=3D<a href=3D"mailto:kynetics.com@lists.=
openembedded.org">kynetics.com@lists.openembedded.org</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">From: Dit Kozmaj &lt;<=
a href=3D"mailto:dit.kozmaj@kynetics.com" target=3D"_blank">dit.kozmaj@kyne=
tics.com</a>&gt;<br>
<br>
Set the maxsplit value to match the expected number of variables.<br>
This also avoids an unnecessary split as the parameters are in the form &#3=
9;key=3Dvalue&#39;<br>
and the &#39;value&#39; could contain the &#39;=3D&#39; character.<br>
<br>
Signed-off-by: Dit Kozmaj &lt;<a href=3D"mailto:dit.kozmaj@kynetics.com" ta=
rget=3D"_blank">dit.kozmaj@kynetics.com</a>&gt;<br>
---<br>
=C2=A0bitbake/lib/bb/fetch2/__init__.py | 2 +-<br>
=C2=A0bitbake/lib/bb/tests/fetch.py=C2=A0 =C2=A0 =C2=A0| 1 +<br>
=C2=A02 files changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__in=
it__.py<br>
index 3e6555bd67..79b289eaec 100644<br>
--- a/bitbake/lib/bb/fetch2/__init__.py<br>
+++ b/bitbake/lib/bb/fetch2/__init__.py<br>
@@ -388,7 +388,7 @@ def decodeurl(url):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if s:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not &#39;=
=3D&#39; in s:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0raise MalformedUrl(url, &quot;The URL: &#39;%s&#39; is invalid: paramete=
r %s does not specify a value (missing &#39;=3D&#39;)&quot; % (url, s))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s1, s2 =3D s.split=
(&#39;=3D&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s1, s2 =3D s.split=
(&#39;=3D&#39;, 1)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p[s1] =3D s2<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0return type, host, urllib.parse.unquote(path), user, ps=
wd, p<br>
diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py<=
br>
index 61dd5cccaf..a261ad69d8 100644<br>
--- a/bitbake/lib/bb/tests/fetch.py<br>
+++ b/bitbake/lib/bb/tests/fetch.py<br>
@@ -1197,6 +1197,7 @@ class URLHandle(unittest.TestCase):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;cvs://<a href=3D"http://anoncvs:anonymous=
@cvs.handhelds.org/cvs;tag=3DV0-99-81;module=3Dfamiliar/dist/ipkg" rel=3D"n=
oreferrer" target=3D"_blank">anoncvs:anonymous@cvs.handhelds.org/cvs;tag=3D=
V0-99-81;module=3Dfamiliar/dist/ipkg</a>&quot; : (&#39;cvs&#39;, &#39;<a hr=
ef=3D"http://cvs.handhelds.org" rel=3D"noreferrer" target=3D"_blank">cvs.ha=
ndhelds.org</a>&#39;, &#39;/cvs&#39;, &#39;anoncvs&#39;, &#39;anonymous&#39=
;, collections.OrderedDict([(&#39;tag&#39;, &#39;V0-99-81&#39;), (&#39;modu=
le&#39;, &#39;familiar/dist/ipkg&#39;)])),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;git://<a href=3D"http://git.openembedded.=
org/bitbake;branch=3D@foo" rel=3D"noreferrer" target=3D"_blank">git.openemb=
edded.org/bitbake;branch=3D@foo</a>&quot; : (&#39;git&#39;, &#39;<a href=3D=
"http://git.openembedded.org" rel=3D"noreferrer" target=3D"_blank">git.open=
embedded.org</a>&#39;, &#39;/bitbake&#39;, &#39;&#39;, &#39;&#39;, {&#39;br=
anch&#39;: &#39;@foo&#39;}),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;file://somelocation;someparam=3D1&quot;: =
(&#39;file&#39;, &#39;&#39;, &#39;somelocation&#39;, &#39;&#39;, &#39;&#39;=
, {&#39;someparam&#39;: &#39;1&#39;}),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;<a href=3D"https://somesite.com/somerepo.=
git;user=3DanyUser:idtoken=3D1234" rel=3D"noreferrer" target=3D"_blank">htt=
ps://somesite.com/somerepo.git;user=3DanyUser:idtoken=3D1234</a>&quot; : (&=
#39;https&#39;, &#39;<a href=3D"http://somesite.com" rel=3D"noreferrer" tar=
get=3D"_blank">somesite.com</a>&#39;, &#39;/somerepo.git&#39;, &#39;&#39;, =
&#39;&#39;, {&#39;user&#39;: &#39;anyUser:idtoken=3D1234&#39;}),<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0# we require a pathname to encodeurl but users can stil=
l pass such urls to <br>
=C2=A0 =C2=A0 =C2=A0# decodeurl and we need to handle them<br>
-- <br>
2.25.1<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#14887): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/14887" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/14887</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/100350479/754=
2774" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/100350479/7542774</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:dit.kozmaj@kynetics.com" target=3D=
"_blank">dit.kozmaj@kynetics.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--000000000000c9bca20601501339--

