Return-Path: <brennan.coslett@bluerivertech.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B562CDE016
	for <webhook@archiver.kernel.org>; Thu, 26 Sep 2024 15:31:57 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
 by mx.groups.io with SMTP id smtpd.web10.46661.1727364711608164749
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Sep 2024 08:31:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bluerivertech.com header.s=google header.b=hNiKH9GU;
 spf=pass (domain: bluerivertech.com, ip: 209.85.215.173, mailfrom: brennan.coslett@bluerivertech.com)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7c1324be8easo1697342a12.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 26 Sep 2024 08:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bluerivertech.com; s=google; t=1727364711; x=1727969511; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pDi4uveucWxZgd0DaKr7hisCvKiJDmmHrD4KZFKYDBY=;
        b=hNiKH9GUdp9f9kmL5OBQbPCHIDKwvS0yOPnTnlugz+A4jp0swhNemvPKQCKjuH1iR6
         O38AjUThx/6XR8vJRCxJko0R/DOn0hjEqB4dUmaNNGztDJiSY3e0XUwrWM8CvmLZETbp
         FaIOEvv4KbVZJzF2kXmqXs1YcpRjdFpqn+qpbQikTopVoVEqx2hDX2Kjf0PXDpFk6XZ3
         sVltLO+SB63FHS1plV8wk5G1xOjvdCwp71B2WzQP7ltOzm5ODdmPNTAZ67Xgsr3Xqd1B
         vAEncsCmR5p1bhxjq5LrgE+AMZuDXpgeC3cpuMROcl3rmT9ydjVihM/+r6n3cuoVDQFr
         vgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727364711; x=1727969511;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pDi4uveucWxZgd0DaKr7hisCvKiJDmmHrD4KZFKYDBY=;
        b=Bgl6YckUuZp2Y2VmDWsuZJK71goKxhiKFU6HfqahLu19BHI665BxZrKZGPFErFqjoG
         LG44GrJBFiDCq2yWau0sQcSJ40X8BwO8wvrINzah1RApTiS/IBgoRF24okbLvU2Wrxdi
         AaFNqe1xQANS1kTh6Q8FnO+bHw5aBvJX5OL6z+ZxqAbJbGY7WDvbh+4EFyONrvIhYLK5
         2PiQOf0vgaMN7LDLYhxVxcEwF9oPli1K2ODuwIrhEiYPbJL+y6Agc/UozEcLkdQOEkvZ
         HVLM+ZbqY/6OrgpsWhgCOMl/MtN7Rv2r0+zvxdkXbps39qfk4RRbzzgOxbtvjNxyfmmi
         Hnhw==
X-Gm-Message-State: AOJu0YxXdmY7zA2ecaOf0kO58OKZ7qTP/eVq1Yx9mh6WvogZWEMS/3FL
	xiOzePI0SS4Wqfuus8xVjJ7WFT1rMq+xkT8PZa6Uo+dZVFeG2A8j7VY+gK+MyBZK3q3w+37f8rE
	3oRdSxcKzmdB7z6LH5DTUDP2bKdBp3V8ZvtUBBw==
X-Google-Smtp-Source: AGHT+IFqGu/41z9Aizlpli63N9BaYu1BWP+SS6N6bUtBslQV2A2Giajl1WHpl2FOketNu2oPu9XyOuiT+W+6TnKsrV0=
X-Received: by 2002:a17:90a:b304:b0:2dd:4f70:1654 with SMTP id
 98e67ed59e1d1-2e0b7125de9mr382966a91.2.1727364710748; Thu, 26 Sep 2024
 08:31:50 -0700 (PDT)
MIME-Version: 1.0
References: <CANNYZj_3XLABQZLYvRuQu+PnQ52gDRS8pXgQDS-SBfp8g9o=sA@mail.gmail.com>
 <29158.1727362658714839430@lists.openembedded.org> <CANNYZj9y7cMMEd__1s5POt64HMhY_xxKrBt38T=uLT2aPRKD4w@mail.gmail.com>
In-Reply-To: <CANNYZj9y7cMMEd__1s5POt64HMhY_xxKrBt38T=uLT2aPRKD4w@mail.gmail.com>
From: Brennan Coslett <brennan.coslett@bluerivertech.com>
Date: Thu, 26 Sep 2024 10:31:39 -0500
Message-ID: <CAAc_J+-b1SPPcy9kZisFWCacmORXbZcKu-7Ab-ZKDywWqy03gg@mail.gmail.com>
Subject: Re: [bitbake-devel] URL encoding/decoding bug with files like
 "serialgetty@.service" or "sshd@.service" with archiver.bbclass #poky
 #bitbake #kirkstone
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000fb7d770623076fba"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Sep 2024 15:31:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16607

--000000000000fb7d770623076fba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Okay I added an additional test case to URLHandle which then tests encoding
and decoding the original patch I sent worked for decoding
but in the encoding test it converted "@" to "%40" which I dont think we
need for local files. The test-case looks like:

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 4e26e38811..dff7780e33 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -1390,6 +1390,7 @@ class URLHandle(unittest.TestCase):
        "file://somelocation;someparam=3D1": ('file', '', 'somelocation', '=
',
'', {'someparam': '1'}),
        "https://somesite.com/somerepo.git;user=3DanyUser:idtoken=3D1234" :
('https', 'somesite.com', '/somerepo.git', '', '', {'user':
'anyUser:idtoken=3D1234'}),
        r'git://s.o-me_ONE:!#$%^&*()-_=3D{}[]\|:?,.<>~`@
git.openembedded.org/bitbake;branch=3Dmain;protocol=3Dhttps': ('git', '
git.openembedded.org', '/bitbake', 's.o-me_ONE',
r'!#$%^&*()-_=3D{}[]\|:?,.<>~`', {'branch': 'main', 'prot
ocol' : 'https'}),
+       "file://serialgetty@.service" : ('file', '', 'serialgetty@.service'=
,
'', '', {}),
     }
     # we require a pathname to encodeurl but users can still pass such
urls to
     # decodeurl and we need to handle them

So adding the encodeurl change I needed:

diff --git a/bitbake/lib/bb/fetch2/__init__.py
b/bitbake/lib/bb/fetch2/__init__.py
index ddee4400bb..4ea561e1f8 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -369,6 +369,11 @@ def decodeurl(url):
         path =3D location[locidx:]
     elif type.lower() =3D=3D 'file':
         host =3D ""
+        # parsing out a user doesn't make sense for
+        # local files?
+        if user:
+            location =3D "%s@%s" % (user, location)
+            user =3D None
         path =3D location
     else:
         host =3D location
@@ -414,7 +419,12 @@ def encodeurl(decoded):
         # Standardise path to ensure comparisons work
         while '//' in path:
             path =3D path.replace("//", "/")
-        url.append("%s" % urllib.parse.quote(path))
+        urllib_parsed =3D urllib.parse.urlparse(path).path
+        if type =3D=3D "file":
+            # Local systemd template file paths don't need the
+            # escaped character.
+            urllib_parsed =3D urllib_parsed.replace('%40', '@')
+        url.append(urllib_parsed)
     if p:
         for parm in p:
             url.append(";%s=3D%s" % (parm, p[parm]))
- Brennan

On Thu, Sep 26, 2024 at 10:03=E2=80=AFAM Alexander Kanavin <alex.kanavin@gm=
ail.com>
wrote:

> On Thu, 26 Sept 2024 at 16:57, Brennan Coslett via
> lists.openembedded.org
> <brennan.coslett=3Dbluerivertech.com@lists.openembedded.org> wrote:
> >
> > I think the bug is in `bb.fetch.decodeurl`, I just noticed it because o=
f
> the archiver.
> > @Alex if that means it should still move over to the oe-core list, let
> me know and I can do that.
>
> Right, let's stay here.
>
> > Steps to replicate:
> > 1. Checkout poky master (just replicated with
> 8634e46b4040b6008410b6d77fecb5cbaec7e90e)
> > 2. source oe-init-build-env
> > 3. append the following to the auto-generated local.conf:
> >     + require conf/distro/include/init-manager-systemd.inc
> >     + INHERIT +=3D "archiver"
> >     + ARCHIVER_MODE[src] =3D "original"
> > 4. Run "bitbake systemd-serialgetty", the source dir will be created bu=
t
> it wont contain anything:
> >     brennan.coslett@lpgt-bcosl001:~/missing-source/poky/build$ ls
> tmp/deploy/sources/x86_64-poky-linux/systemd-serialgetty-1.0-r0/
> >     brennan.coslett@lpgt-bcosl001:~/missing-source/poky/build$
> >
> > I think something in the regex inside the `decodeurl` function in
> `bitbake/lib/bb/fetch2/__init__.py` needs to change to stop it from
> > parsing out `<name>@`  in `<name>@.service` into the `user` field or
> maybe it needs additional logic inside that function when its a
> > local file to put the parsed out `user` group back into the `location`
> group? This appears to fix it but i'm not sure if this is actually valid,
> > if it is I can submit it as an actual patch. I think there should
> probably be a corresponding addition of a fetch test around these types o=
f
> > files?
>
> Let's do test driven development here :) There are tests for fetchers
> in bitbake/lib/bb/tests/fetch.py - if you can check and add a test
> that exposes this issue (e.g. fails without the fix and passes with
> it), then we can discuss what the best fix would be. Run them with
> bitbake-selftest.
>
> Alex
>

--000000000000fb7d770623076fba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Okay I added an additional test case to URLHandle which th=
en tests encoding and decoding the original patch I sent worked for decodin=
g<br><div>but in the encoding test it converted &quot;@&quot; to &quot;%40&=
quot; which I dont think we need for local files. The test-case looks like:=
</div><div><br>diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/=
tests/fetch.py<br>index 4e26e38811..dff7780e33 100644<br>--- a/bitbake/lib/=
bb/tests/fetch.py<br>+++ b/bitbake/lib/bb/tests/fetch.py<br>@@ -1390,6 +139=
0,7 @@ class URLHandle(unittest.TestCase):<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 &=
quot;file://somelocation;someparam=3D1&quot;: (&#39;file&#39;, &#39;&#39;, =
&#39;somelocation&#39;, &#39;&#39;, &#39;&#39;, {&#39;someparam&#39;: &#39;=
1&#39;}),<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;<a href=3D"https://somesite.=
com/somerepo.git;user=3DanyUser:idtoken=3D1234">https://somesite.com/somere=
po.git;user=3DanyUser:idtoken=3D1234</a>&quot; : (&#39;https&#39;, &#39;<a =
href=3D"http://somesite.com">somesite.com</a>&#39;, &#39;/somerepo.git&#39;=
, &#39;&#39;, &#39;&#39;, {&#39;user&#39;: &#39;anyUser:idtoken=3D1234&#39;=
}),<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 r&#39;git://s.o-me_ONE:!#$%^&amp;*()-_=
=3D{}[]\|:?,.&lt;&gt;~`@<a href=3D"http://git.openembedded.org/bitbake;bran=
ch=3Dmain;protocol=3Dhttps">git.openembedded.org/bitbake;branch=3Dmain;prot=
ocol=3Dhttps</a>&#39;: (&#39;git&#39;, &#39;<a href=3D"http://git.openembed=
ded.org">git.openembedded.org</a>&#39;, &#39;/bitbake&#39;, &#39;s.o-me_ONE=
&#39;, r&#39;!#$%^&amp;*()-_=3D{}[]\|:?,.&lt;&gt;~`&#39;, {&#39;branch&#39;=
: &#39;main&#39;, &#39;prot<br>ocol&#39; : &#39;https&#39;}),<br>+ =C2=A0 =
=C2=A0 =C2=A0 &quot;file://serialgetty@.service&quot; : (&#39;file&#39;, &#=
39;&#39;, &#39;serialgetty@.service&#39;, &#39;&#39;, &#39;&#39;, {}),<br>=
=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0# we require a pathname to enc=
odeurl but users can still pass such urls to <br>=C2=A0 =C2=A0 =C2=A0# deco=
deurl and we need to handle them<br><br></div><div>So adding the encodeurl =
change I needed:</div><div><br></div><div>diff --git a/bitbake/lib/bb/fetch=
2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py<br>index ddee4400bb..4ea5=
61e1f8 100644<br>--- a/bitbake/lib/bb/fetch2/__init__.py<br>+++ b/bitbake/l=
ib/bb/fetch2/__init__.py<br>@@ -369,6 +369,11 @@ def decodeurl(url):<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0path =3D location[locidx:]<br>=C2=A0 =C2=A0 =
=C2=A0elif type.lower() =3D=3D &#39;file&#39;:<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0host =3D &quot;&quot;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0# parsing o=
ut a user doesn&#39;t make sense for<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0# loca=
l files?<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if user:<br>+ =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0location =3D &quot;%s@%s&quot; % (user, location)<br>+=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0user =3D None<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0path =3D location<br>=C2=A0 =C2=A0 =C2=A0else:<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host =3D location<br>@@ -414,7 +419,12 @@ de=
f encodeurl(decoded):<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Standardise pa=
th to ensure comparisons work<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while &#=
39;//&#39; in path:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0path=
 =3D path.replace(&quot;//&quot;, &quot;/&quot;)<br>- =C2=A0 =C2=A0 =C2=A0 =
=C2=A0url.append(&quot;%s&quot; % urllib.parse.quote(path))<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0urllib_parsed =3D urllib.parse.urlparse(path).path<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0if type =3D=3D &quot;file&quot;:<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Local systemd template file paths don&#39;=
t need the<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# escaped characte=
r.<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0urllib_parsed =3D urllib_p=
arsed.replace(&#39;%40&#39;, &#39;@&#39;)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0u=
rl.append(urllib_parsed)<br>=C2=A0 =C2=A0 =C2=A0if p:<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0for parm in p:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0url.append(&quot;;%s=3D%s&quot; % (parm, p[parm]))</div><div>- Br=
ennan</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">On Thu, Sep 26, 2024 at 10:03=E2=80=AFAM Alexander Kanavin &lt;<=
a href=3D"mailto:alex.kanavin@gmail.com">alex.kanavin@gmail.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Thu, 26 S=
ept 2024 at 16:57, Brennan Coslett via<br>
<a href=3D"http://lists.openembedded.org" rel=3D"noreferrer" target=3D"_bla=
nk">lists.openembedded.org</a><br>
&lt;brennan.coslett=3D<a href=3D"mailto:bluerivertech.com@lists.openembedde=
d.org" target=3D"_blank">bluerivertech.com@lists.openembedded.org</a>&gt; w=
rote:<br>
&gt;<br>
&gt; I think the bug is in `bb.fetch.decodeurl`, I just noticed it because =
of the archiver.<br>
&gt; @Alex if that means it should still move over to the oe-core list, let=
 me know and I can do that.<br>
<br>
Right, let&#39;s stay here.<br>
<br>
&gt; Steps to replicate:<br>
&gt; 1. Checkout poky master (just replicated with 8634e46b4040b6008410b6d7=
7fecb5cbaec7e90e)<br>
&gt; 2. source oe-init-build-env<br>
&gt; 3. append the following to the auto-generated local.conf:<br>
&gt;=C2=A0 =C2=A0 =C2=A0+ require conf/distro/include/init-manager-systemd.=
inc<br>
&gt;=C2=A0 =C2=A0 =C2=A0+ INHERIT +=3D &quot;archiver&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+ ARCHIVER_MODE[src] =3D &quot;original&quot;<br>
&gt; 4. Run &quot;bitbake systemd-serialgetty&quot;, the source dir will be=
 created but it wont contain anything:<br>
&gt;=C2=A0 =C2=A0 =C2=A0brennan.coslett@lpgt-bcosl001:~/missing-source/poky=
/build$ ls tmp/deploy/sources/x86_64-poky-linux/systemd-serialgetty-1.0-r0/=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0brennan.coslett@lpgt-bcosl001:~/missing-source/poky=
/build$<br>
&gt;<br>
&gt; I think something in the regex inside the `decodeurl` function in `bit=
bake/lib/bb/fetch2/__init__.py` needs to change to stop it from<br>
&gt; parsing out `&lt;name&gt;@`=C2=A0 in `&lt;name&gt;@.service` into the =
`user` field or maybe it needs additional logic inside that function when i=
ts a<br>
&gt; local file to put the parsed out `user` group back into the `location`=
 group? This appears to fix it but i&#39;m not sure if this is actually val=
id,<br>
&gt; if it is I can submit it as an actual patch. I think there should prob=
ably be a corresponding addition of a fetch test around these types of<br>
&gt; files?<br>
<br>
Let&#39;s do test driven development here :) There are tests for fetchers<b=
r>
in bitbake/lib/bb/tests/fetch.py - if you can check and add a test<br>
that exposes this issue (e.g. fails without the fix and passes with<br>
it), then we can discuss what the best fix would be. Run them with<br>
bitbake-selftest.<br>
<br>
Alex<br>
</blockquote></div>

--000000000000fb7d770623076fba--

