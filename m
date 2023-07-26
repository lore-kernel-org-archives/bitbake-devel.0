Return-Path: <dit.kozmaj@kynetics.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED46C001E0
	for <webhook@archiver.kernel.org>; Wed, 26 Jul 2023 08:10:58 +0000 (UTC)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
 by mx.groups.io with SMTP id smtpd.web11.6461.1690359054673769791
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 26 Jul 2023 01:10:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kynetics.com header.s=google header.b=dqyP0xUX;
 spf=pass (domain: kynetics.com, ip: 209.85.219.170, mailfrom: dit.kozmaj@kynetics.com)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-d124309864dso2722385276.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 26 Jul 2023 01:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kynetics.com; s=google; t=1690359053; x=1690963853;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pc+zBqzAVwS8LHORQ7ggPn32x5QqCfXE97M9z3EkEDo=;
        b=dqyP0xUXeDF+O6TKlsCQcKqSvQQcDBddgZXCmTgZvcW5IelHpr/hpgLsHw6fibIbDS
         BZ3wZhpivPBjLiS5M1u7lD8y09OtR8tC6sVHMaBePuoULud3EBsh6QfPrDrpK1exnAxY
         rIpwQf0Z9KN9ZxvXCNF+fcwYXPtB8GaM58vKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690359053; x=1690963853;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pc+zBqzAVwS8LHORQ7ggPn32x5QqCfXE97M9z3EkEDo=;
        b=Epkkk28Vp12MN6Nzkqqhij3l9xWGxh3XLTu4anN00God/1StWLFIfsSHGYpyMo7Qty
         uz+BI+SU88bxg4m0G1/9tfMObRHMqKk3qEtYd8h4K4FItJ7sl7phbJPUGVf56eD8/zzN
         0/drFIVt9Ac7fB2H+3YD3JJ16toATecZlHHOh5gBqzXsG3OotPKll5jLMdTFbRo6W8Pz
         2aLwTo9S2WrixSb0E+6qbzvBOI9zPTj22n+dNSyfWxPUpTVtj0w36qjS6kjV0sI0URt8
         fbI/pPQG9tpw38FuN+Utj29ToXPNMorNNHX3bee+JUWP56gMboHwN1li+beTAkYLj6aS
         Dh6g==
X-Gm-Message-State: ABy/qLYuzwyOZwrGx7j5E7wyd6gmljKftuRhNCDk7XUetds1ElzpGeg4
	nPMs/71SDPxMk2vW7dz7ssinC/QmbEdubul8TH/F3YGZ+q/pozPEzpM=
X-Google-Smtp-Source: APBJJlFTz1rKfkNWZy7I4tmaQNNApbvta10GCrcEyQZTf+jciGZAmDDfP+qZROBmLXRosoGADchIIbWN7O9xtVHXlKk=
X-Received: by 2002:a0d:f285:0:b0:577:3c17:5b2c with SMTP id
 b127-20020a0df285000000b005773c175b2cmr1250570ywf.27.1690359053550; Wed, 26
 Jul 2023 01:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230725134710.85784-1-dit.kozmaj@kynetics.com> <202307251639147fff30ad@mail.local>
In-Reply-To: <202307251639147fff30ad@mail.local>
From: Dit Kozmaj <dit.kozmaj@kynetics.com>
Date: Wed, 26 Jul 2023 10:10:42 +0200
Message-ID: <CABU0hBLW7BAzpTUAwC0pTV54RuBQ95AEL+OcDDPN55TpWPymZQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Set maxsplit to match expected variables
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000ee25c006015f62d4"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 26 Jul 2023 08:10:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14891

--000000000000ee25c006015f62d4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, I was using the Dunfell branch.
I forget to move to the master branch to apply the patch. Sorry about that.
However I send a new Patch v2 that applies on the master branch and
obviously test it.

Thanks.



On Tue, Jul 25, 2023 at 6:39=E2=80=AFPM Alexandre Belloni <
alexandre.belloni@bootlin.com> wrote:

> Hello,
>
> On 25/07/2023 13:47:10+0000, Dit Kozmaj wrote:
> > From: Dit Kozmaj <dit.kozmaj@kynetics.com>
> >
> > Set the maxsplit value to match the expected number of variables.
> > This also avoids an unnecessary split as the parameters are in the form
> 'key=3Dvalue'
> > and the 'value' could contain the '=3D' character.
> >
> > Signed-off-by: Dit Kozmaj <dit.kozmaj@kynetics.com>
> > ---
> >  bitbake/lib/bb/fetch2/__init__.py | 2 +-
> >  bitbake/lib/bb/tests/fetch.py     | 1 +
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
>
> This doesn't apply one master, which branch did you use? Can you rebase?
>
> > diff --git a/bitbake/lib/bb/fetch2/__init__.py
> b/bitbake/lib/bb/fetch2/__init__.py
> > index 3e6555bd67..79b289eaec 100644
> > --- a/bitbake/lib/bb/fetch2/__init__.py
> > +++ b/bitbake/lib/bb/fetch2/__init__.py
> > @@ -388,7 +388,7 @@ def decodeurl(url):
> >              if s:
> >                  if not '=3D' in s:
> >                      raise MalformedUrl(url, "The URL: '%s' is invalid:
> parameter %s does not specify a value (missing '=3D')" % (url, s))
> > -                s1, s2 =3D s.split('=3D')
> > +                s1, s2 =3D s.split('=3D', 1)
> >                  p[s1] =3D s2
> >
> >      return type, host, urllib.parse.unquote(path), user, pswd, p
> > diff --git a/bitbake/lib/bb/tests/fetch.py
> b/bitbake/lib/bb/tests/fetch.py
> > index 61dd5cccaf..a261ad69d8 100644
> > --- a/bitbake/lib/bb/tests/fetch.py
> > +++ b/bitbake/lib/bb/tests/fetch.py
> > @@ -1197,6 +1197,7 @@ class URLHandle(unittest.TestCase):
> >         "cvs://
> anoncvs:anonymous@cvs.handhelds.org/cvs;tag=3DV0-99-81;module=3Dfamiliar/=
dist/ipkg"
> : ('cvs', 'cvs.handhelds.org', '/cvs', 'anoncvs', 'anonymous',
> collections.OrderedDict([('tag', 'V0-99-81'), ('module',
> 'familiar/dist/ipkg')])),
> >         "git://git.openembedded.org/bitbake;branch=3D@foo" : ('git', '
> git.openembedded.org', '/bitbake', '', '', {'branch': '@foo'}),
> >         "file://somelocation;someparam=3D1": ('file', '', 'somelocation=
',
> '', '', {'someparam': '1'}),
> > +       "https://somesite.com/somerepo.git;user=3DanyUser:idtoken=3D123=
4" :
> ('https', 'somesite.com', '/somerepo.git', '', '', {'user':
> 'anyUser:idtoken=3D1234'}),
> >      }
> >      # we require a pathname to encodeurl but users can still pass such
> urls to
> >      # decodeurl and we need to handle them
> > --
> > 2.25.1
> >
>
> >
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#14887):
> https://lists.openembedded.org/g/bitbake-devel/message/14887
> > Mute This Topic: https://lists.openembedded.org/mt/100350479/3617179
> > Group Owner: bitbake-devel+owner@lists.openembedded.org
> > Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> alexandre.belloni@bootlin.com]
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> >
>
>
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>

--000000000000ee25c006015f62d4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hello, I was using the Dunfell branch. <br></div=
>I forget to move to the master branch to apply the patch. Sorry about that=
.<br></div><div>However I send a new Patch v2 that applies on the master br=
anch and obviously test it. <br><br></div><div>Thanks.<br></div><div><br></=
div><div><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cl=
ass=3D"gmail_attr">On Tue, Jul 25, 2023 at 6:39=E2=80=AFPM Alexandre Bellon=
i &lt;<a href=3D"mailto:alexandre.belloni@bootlin.com">alexandre.belloni@bo=
otlin.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Hello,<br>
<br>
On 25/07/2023 13:47:10+0000, Dit Kozmaj wrote:<br>
&gt; From: Dit Kozmaj &lt;<a href=3D"mailto:dit.kozmaj@kynetics.com" target=
=3D"_blank">dit.kozmaj@kynetics.com</a>&gt;<br>
&gt; <br>
&gt; Set the maxsplit value to match the expected number of variables.<br>
&gt; This also avoids an unnecessary split as the parameters are in the for=
m &#39;key=3Dvalue&#39;<br>
&gt; and the &#39;value&#39; could contain the &#39;=3D&#39; character.<br>
&gt; <br>
&gt; Signed-off-by: Dit Kozmaj &lt;<a href=3D"mailto:dit.kozmaj@kynetics.co=
m" target=3D"_blank">dit.kozmaj@kynetics.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 bitbake/lib/bb/fetch2/__init__.py | 2 +-<br>
&gt;=C2=A0 bitbake/lib/bb/tests/fetch.py=C2=A0 =C2=A0 =C2=A0| 1 +<br>
&gt;=C2=A0 2 files changed, 2 insertions(+), 1 deletion(-)<br>
&gt; <br>
<br>
This doesn&#39;t apply one master, which branch did you use? Can you rebase=
?<br>
<br>
&gt; diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2=
/__init__.py<br>
&gt; index 3e6555bd67..79b289eaec 100644<br>
&gt; --- a/bitbake/lib/bb/fetch2/__init__.py<br>
&gt; +++ b/bitbake/lib/bb/fetch2/__init__.py<br>
&gt; @@ -388,7 +388,7 @@ def decodeurl(url):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if s:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not &=
#39;=3D&#39; in s:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 raise MalformedUrl(url, &quot;The URL: &#39;%s&#39; is invalid: para=
meter %s does not specify a value (missing &#39;=3D&#39;)&quot; % (url, s))=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s1, s2 =3D s.=
split(&#39;=3D&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s1, s2 =3D s.=
split(&#39;=3D&#39;, 1)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p[s1] =
=3D s2<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 return type, host, urllib.parse.unquote(path), use=
r, pswd, p<br>
&gt; diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetc=
h.py<br>
&gt; index 61dd5cccaf..a261ad69d8 100644<br>
&gt; --- a/bitbake/lib/bb/tests/fetch.py<br>
&gt; +++ b/bitbake/lib/bb/tests/fetch.py<br>
&gt; @@ -1197,6 +1197,7 @@ class URLHandle(unittest.TestCase):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;cvs://<a href=3D"http://anoncvs=
:anonymous@cvs.handhelds.org/cvs;tag=3DV0-99-81;module=3Dfamiliar/dist/ipkg=
" rel=3D"noreferrer" target=3D"_blank">anoncvs:anonymous@cvs.handhelds.org/=
cvs;tag=3DV0-99-81;module=3Dfamiliar/dist/ipkg</a>&quot; : (&#39;cvs&#39;, =
&#39;<a href=3D"http://cvs.handhelds.org" rel=3D"noreferrer" target=3D"_bla=
nk">cvs.handhelds.org</a>&#39;, &#39;/cvs&#39;, &#39;anoncvs&#39;, &#39;ano=
nymous&#39;, collections.OrderedDict([(&#39;tag&#39;, &#39;V0-99-81&#39;), =
(&#39;module&#39;, &#39;familiar/dist/ipkg&#39;)])),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;git://<a href=3D"http://git.ope=
nembedded.org/bitbake;branch=3D@foo" rel=3D"noreferrer" target=3D"_blank">g=
it.openembedded.org/bitbake;branch=3D@foo</a>&quot; : (&#39;git&#39;, &#39;=
<a href=3D"http://git.openembedded.org" rel=3D"noreferrer" target=3D"_blank=
">git.openembedded.org</a>&#39;, &#39;/bitbake&#39;, &#39;&#39;, &#39;&#39;=
, {&#39;branch&#39;: &#39;@foo&#39;}),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;file://somelocation;someparam=
=3D1&quot;: (&#39;file&#39;, &#39;&#39;, &#39;somelocation&#39;, &#39;&#39;=
, &#39;&#39;, {&#39;someparam&#39;: &#39;1&#39;}),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;<a href=3D"https://somesite.com/some=
repo.git;user=3DanyUser:idtoken=3D1234" rel=3D"noreferrer" target=3D"_blank=
">https://somesite.com/somerepo.git;user=3DanyUser:idtoken=3D1234</a>&quot;=
 : (&#39;https&#39;, &#39;<a href=3D"http://somesite.com" rel=3D"noreferrer=
" target=3D"_blank">somesite.com</a>&#39;, &#39;/somerepo.git&#39;, &#39;&#=
39;, &#39;&#39;, {&#39;user&#39;: &#39;anyUser:idtoken=3D1234&#39;}),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 # we require a pathname to encodeurl but users can=
 still pass such urls to <br>
&gt;=C2=A0 =C2=A0 =C2=A0 # decodeurl and we need to handle them<br>
&gt; -- <br>
&gt; 2.25.1<br>
&gt; <br>
<br>
&gt; <br>
&gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt; Links: You receive all messages sent to this group.<br>
&gt; View/Reply Online (#14887): <a href=3D"https://lists.openembedded.org/=
g/bitbake-devel/message/14887" rel=3D"noreferrer" target=3D"_blank">https:/=
/lists.openembedded.org/g/bitbake-devel/message/14887</a><br>
&gt; Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/10035047=
9/3617179" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.=
org/mt/100350479/3617179</a><br>
&gt; Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedde=
d.org" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
&gt; Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel=
/unsub" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org=
/g/bitbake-devel/unsub</a> [<a href=3D"mailto:alexandre.belloni@bootlin.com=
" target=3D"_blank">alexandre.belloni@bootlin.com</a>]<br>
&gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt; <br>
<br>
<br>
-- <br>
Alexandre Belloni, co-owner and COO, Bootlin<br>
Embedded Linux and Kernel engineering<br>
<a href=3D"https://bootlin.com" rel=3D"noreferrer" target=3D"_blank">https:=
//bootlin.com</a><br>
</blockquote></div>

--000000000000ee25c006015f62d4--

