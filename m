Return-Path: <frederic.martinsons@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9892AC6FD1F
	for <webhook@archiver.kernel.org>; Thu, 16 Mar 2023 10:27:06 +0000 (UTC)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
 by mx.groups.io with SMTP id smtpd.web11.8890.1678962424354600430
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Mar 2023 03:27:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=DC8KSWsL;
 spf=pass (domain: gmail.com, ip: 209.85.167.53, mailfrom: frederic.martinsons@gmail.com)
Received: by mail-lf1-f53.google.com with SMTP id g17so1670981lfv.4
        for <bitbake-devel@lists.openembedded.org>; Thu, 16 Mar 2023 03:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678962422;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K0UzzRK1HBPuYPbS0DDWpUl2BEAYd8tx/uZ6XcExbQY=;
        b=DC8KSWsLcHOFyPb3PhxECSOc2tcLUhMB0/FwSSV5K3zsNcXQkyanBZ4jWQ5hCAE/K6
         7XqraPg/47wmvHh/cFYOx8XtyLGrXGVPyl+WECX+m0m0yNOohxgPbQmj6IABHCN2Tr54
         Xs+Z27VsjRrKe4QcPgDdCcQkT4raRCnDCZdfxH6HOQcA8XqESFRpCUD4mDcKCkZ/ceyG
         /jLpXZBHyp6z8IT54/NnuRb1AzUTV13US/WkFF/LfoxJlxEOmGxKSXN3JIypKU8PoDyl
         SKH8lOBcevPkaK039usZMufMOwAausbiLwVdJIj2+tUl5R0NRVzeOtPXDbrJFccPoGi9
         RqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678962422;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K0UzzRK1HBPuYPbS0DDWpUl2BEAYd8tx/uZ6XcExbQY=;
        b=ADQPlSeiwAWeYHqrNGKoifAxu86mU+DKngM+2r1CLD+H7s0n0xW8qq8pGc5l2xdmYp
         njWmu2uL/K+CQlirzfkCMuMMu2VQ6ISp6N9Qe/B9aLkl8/zNP9ZpvSFYODNhDOyRTmg3
         +fcdepx4fUcr4PpWFRrNuD/LDZagThnHuR6DWeRg5ObTicx0FvbC4jzzKlTXMPfEBNwF
         Bi+5/1IXBcecwDwNdfHDKrSMptne95Xfk8+TD9lyDiv4+A2ioI5Q8Xvz4ctmTz6QQEzv
         nFkJu67i7ztGj8fyYXb5XRT4cjl0/UyIhntKjFsk80VdIu963rUusAlnjscNaD/mU31K
         Dsng==
X-Gm-Message-State: AO0yUKXnPYlXHYkIjobGubl1k6lN6Gk7gSg+acLXHuyZYGhjCgJJkNpV
	oL5ciq2jZwfLXXKSi7u6ZzDHAJbl5Xw3qi6LVSI=
X-Google-Smtp-Source: AK7set9DfMvjA3fdQqz4Bdfj+WZVRfN2gLlPRwLtDP29mAHw4mOwEDXNSaMJdmWaCn582K+nS/er/uNY2r60CgAg2qs=
X-Received: by 2002:ac2:5102:0:b0:4e8:45d5:53cd with SMTP id
 q2-20020ac25102000000b004e845d553cdmr2913542lfb.12.1678962422302; Thu, 16 Mar
 2023 03:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <174C9B68833254B6.10695@lists.openembedded.org>
In-Reply-To: <174C9B68833254B6.10695@lists.openembedded.org>
From: =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= <frederic.martinsons@gmail.com>
Date: Thu, 16 Mar 2023 11:26:50 +0100
Message-ID: <CA+cAkepJbPRv_2-vvM=wCSPuUG4NkXupSJ4dMm1oTDM-pNU+tw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] crate.py: authorize crate url with parameters
To: frederic.martinsons@gmail.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000c5ccd805f701e691"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Mar 2023 10:27:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14580

--000000000000c5ccd805f701e691
Content-Type: text/plain; charset="UTF-8"

Hello, note that this one will become mandatory for checksum verification
of crates.

I didn't foresee that but it seems that having multiple version of crate in
the same
project is common (I have that with zbus based project) and we can see also
that for uutils-coreutils (e.g here
<https://github.com/openembedded/meta-openembedded/blob/master/meta-oe/recipes-core/uutils-coreutils/uutils-coreutils_0.0.17.bb#L146>
 or here
<https://github.com/openembedded/meta-openembedded/blob/master/meta-oe/recipes-core/uutils-coreutils/uutils-coreutils_0.0.17.bb#L204>
 )

So we must be able to rename the package via its url, to retake the example
above, we
will have something like:

SRC_URI = " \
crate://crates.io/memoffset/0.6.5;name=remove_dir_all-0.6.5 \
crate://crates.io/memoffset/0.7.1;name=remove_dir_all-0.7.1 \
crate://crates.io/remove_dir_all/0.5.3;name=remove_dir_all-0.5.3 \
crate://crates.io/remove_dir_all/0.7.0;name=remove_dir_all-0.7.0 \
"
SRC_URI[memoffset-0.6.5.sha256sum] =
"5aa361d4faea93603064a027415f07bd8e1d5c88c9fbf68bf56a285428fd79ce"
SRC_URI[memoffset-0.7.1.sha256sum] =
"5de893c32cde5f383baa4c04c5d6dbdd735cfd4a794b0debdb2bb1b421da5ff4"
SRC_URI[remove_dir_all-0.5.3.sha256sum] =
"3acd125665422973a33ac9d3dd2df85edad0f4ae9b00dafb1a05e43a9f5ef8e7"
SRC_URI[remove_dir_all-0.7.0.sha256sum] =
"882f368737489ea543bc5c340e6f3d34a28c39980bd9a979e47322b26f60ac40"

On Wed, 15 Mar 2023 at 14:40, Frederic Martinsons via lists.openembedded.org
<frederic.martinsons=gmail.com@lists.openembedded.org> wrote:

> From: Frederic Martinsons <frederic.martinsons@gmail.com>
>
> This allow to have classic fetch parameters
> (like destsuffix, sha256, name ...) not being
> considered by crate fetcher itself (and so mess
> up its download)
>
> Moreover, it allow to overload the name of the downloaded
> crate (maybe usefull if there is a naming clash between
> two crates coming from different repositories)
>
> Signed-off-by: Frederic Martinsons <frederic.martinsons@gmail.com>
> ---
>  lib/bb/fetch2/crate.py |  9 ++++++---
>  lib/bb/tests/fetch.py  | 24 ++++++++++++++++++++++++
>  2 files changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
> index f091200d..2889e39c 100644
> --- a/lib/bb/fetch2/crate.py
> +++ b/lib/bb/fetch2/crate.py
> @@ -56,8 +56,10 @@ class Crate(Wget):
>          if len(parts) < 5:
>              raise bb.fetch2.ParameterError("Invalid URL: Must be
> crate://HOST/NAME/VERSION", ud.url)
>
> -        # last field is version
> -        version = parts[len(parts) - 1]
> +        # version is expected to be the last token
> +        # but ignore possible url parameters which will be used
> +        # by the top fetcher class
> +        version, _, _ = parts[len(parts) -1].partition(";")
>          # second to last field is name
>          name = parts[len(parts) - 2]
>          # host (this is to allow custom crate registries to be specified
> @@ -69,7 +71,8 @@ class Crate(Wget):
>
>          ud.url = "https://%s/%s/%s/download" % (host, name, version)
>          ud.parm['downloadfilename'] = "%s-%s.crate" % (name, version)
> -        ud.parm['name'] = name
> +        if 'name' not in ud.parm:
> +            ud.parm['name'] = name
>
>          logger.debug2("Fetching %s to %s" % (ud.url,
> ud.parm['downloadfilename']))
>
> diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
> index fd089bc8..85cf25e7 100644
> --- a/lib/bb/tests/fetch.py
> +++ b/lib/bb/tests/fetch.py
> @@ -2423,6 +2423,30 @@ class CrateTest(FetcherTest):
>          self.assertTrue(os.path.exists(self.tempdir +
> "/cargo_home/bitbake/time-0.1.35/.cargo-checksum.json"))
>          self.assertTrue(os.path.exists(self.tempdir +
> "/cargo_home/bitbake/time-0.1.35/src/lib.rs"))
>
> +    @skipIfNoNetwork()
> +    def test_crate_url_params(self):
> +
> +        uri = "crate://
> crates.io/aho-corasick/0.7.20;name=aho-corasick-renamed"
> +        self.d.setVar('SRC_URI', uri)
> +
> +        uris = self.d.getVar('SRC_URI').split()
> +        d = self.d
> +
> +        fetcher = bb.fetch2.Fetch(uris, self.d)
> +        ud = fetcher.ud[fetcher.urls[0]]
> +
> +        self.assertIn("name", ud.parm)
> +        self.assertEqual(ud.parm["name"], "aho-corasick-renamed")
> +        self.assertIn("downloadfilename", ud.parm)
> +        self.assertEqual(ud.parm["downloadfilename"],
> "aho-corasick-0.7.20.crate")
> +
> +        fetcher.download()
> +        fetcher.unpack(self.tempdir)
> +        self.assertEqual(sorted(os.listdir(self.tempdir)), ['cargo_home',
> 'download' , 'unpacked'])
> +        self.assertEqual(sorted(os.listdir(self.tempdir + "/download")),
> ['aho-corasick-0.7.20.crate', 'aho-corasick-0.7.20.crate.done'])
> +        self.assertTrue(os.path.exists(self.tempdir +
> "/cargo_home/bitbake/aho-corasick-0.7.20/.cargo-checksum.json"))
> +        self.assertTrue(os.path.exists(self.tempdir +
> "/cargo_home/bitbake/aho-corasick-0.7.20/src/lib.rs"))
> +
>      @skipIfNoNetwork()
>      def test_crate_incorrect_cksum(self):
>          uri = "crate://crates.io/aho-corasick/0.7.20"
> --
> 2.34.1
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14564):
> https://lists.openembedded.org/g/bitbake-devel/message/14564
> Mute This Topic: https://lists.openembedded.org/mt/97627476/6213388
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> frederic.martinsons@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

--000000000000c5ccd805f701e691
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello, note that this one will become mandatory for checks=
um verification of crates.<div><br></div><div>I didn&#39;t foresee that but=
 it seems that having multiple version of crate in the same</div><div>proje=
ct is common (I have that with zbus based project) and we can see also</div=
><div>that for uutils-coreutils (e.g=C2=A0<a href=3D"https://github.com/ope=
nembedded/meta-openembedded/blob/master/meta-oe/recipes-core/uutils-coreuti=
ls/uutils-coreutils_0.0.17.bb#L146">here</a>=C2=A0or=C2=A0<a href=3D"https:=
//github.com/openembedded/meta-openembedded/blob/master/meta-oe/recipes-cor=
e/uutils-coreutils/uutils-coreutils_0.0.17.bb#L204">here</a>=C2=A0)</div><d=
iv><br></div><div>So we must be able to rename the package via its url, to =
retake the example above, we</div><div>will have something like:</div><div>=
<br></div><div>SRC_URI =3D &quot; \</div><div><div>crate://<a href=3D"http:=
//crates.io/memoffset/0.6.5;name=3Dremove_dir_all-0.6.5">crates.io/memoffse=
t/0.6.5;name=3Dremove_dir_all-0.6.5</a> \</div><div>crate://<a href=3D"http=
://crates.io/memoffset/0.7.1;name=3Dremove_dir_all-0.7.1">crates.io/memoffs=
et/0.7.1;name=3Dremove_dir_all-0.7.1</a> \</div></div><div>crate://<a href=
=3D"http://crates.io/remove_dir_all/0.5.3;name=3Dremove_dir_all-0.5.3">crat=
es.io/remove_dir_all/0.5.3;name=3Dremove_dir_all-0.5.3</a> \</div><div>crat=
e://<a href=3D"http://crates.io/remove_dir_all/0.7.0;name=3Dremove_dir_all-=
0.7.0">crates.io/remove_dir_all/0.7.0;name=3Dremove_dir_all-0.7.0</a> \<br>=
&quot;</div><div>SRC_URI[memoffset-0.6.5.sha256sum] =3D &quot;5aa361d4faea9=
3603064a027415f07bd8e1d5c88c9fbf68bf56a285428fd79ce&quot;<br>SRC_URI[memoff=
set-0.7.1.sha256sum] =3D &quot;5de893c32cde5f383baa4c04c5d6dbdd735cfd4a794b=
0debdb2bb1b421da5ff4&quot;<br></div><div>SRC_URI[remove_dir_all-0.5.3.sha25=
6sum] =3D &quot;3acd125665422973a33ac9d3dd2df85edad0f4ae9b00dafb1a05e43a9f5=
ef8e7&quot;<br>SRC_URI[remove_dir_all-0.7.0.sha256sum] =3D &quot;882f368737=
489ea543bc5c340e6f3d34a28c39980bd9a979e47322b26f60ac40&quot;<br></div></div=
><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On We=
d, 15 Mar 2023 at 14:40, Frederic Martinsons via <a href=3D"http://lists.op=
enembedded.org">lists.openembedded.org</a> &lt;frederic.martinsons=3D<a hre=
f=3D"mailto:gmail.com@lists.openembedded.org">gmail.com@lists.openembedded.=
org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">From: Frederic Martinsons &lt;<a href=3D"mailto:frederic.martinsons@gmai=
l.com" target=3D"_blank">frederic.martinsons@gmail.com</a>&gt;<br>
<br>
This allow to have classic fetch parameters<br>
(like destsuffix, sha256, name ...) not being<br>
considered by crate fetcher itself (and so mess<br>
up its download)<br>
<br>
Moreover, it allow to overload the name of the downloaded<br>
crate (maybe usefull if there is a naming clash between<br>
two crates coming from different repositories)<br>
<br>
Signed-off-by: Frederic Martinsons &lt;<a href=3D"mailto:frederic.martinson=
s@gmail.com" target=3D"_blank">frederic.martinsons@gmail.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/fetch2/crate.py |=C2=A0 9 ++++++---<br>
=C2=A0lib/bb/tests/fetch.py=C2=A0 | 24 ++++++++++++++++++++++++<br>
=C2=A02 files changed, 30 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py<br>
index f091200d..2889e39c 100644<br>
--- a/lib/bb/fetch2/crate.py<br>
+++ b/lib/bb/fetch2/crate.py<br>
@@ -56,8 +56,10 @@ class Crate(Wget):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if len(parts) &lt; 5:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise bb.fetch2.ParameterEr=
ror(&quot;Invalid URL: Must be crate://HOST/NAME/VERSION&quot;, ud.url)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 # last field is version<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 version =3D parts[len(parts) - 1]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # version is expected to be the last token<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # but ignore possible url parameters which wil=
l be used<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # by the top fetcher class<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 version, _, _ =3D parts[len(parts) -1].partiti=
on(&quot;;&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# second to last field is name<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0name =3D parts[len(parts) - 2]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# host (this is to allow custom crate reg=
istries to be specified<br>
@@ -69,7 +71,8 @@ class Crate(Wget):<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ud.url =3D &quot;https://%s/%s/%s/downloa=
d&quot; % (host, name, version)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ud.parm[&#39;downloadfilename&#39;] =3D &=
quot;%s-%s.crate&quot; % (name, version)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.parm[&#39;name&#39;] =3D name<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &#39;name&#39; not in ud.parm:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.parm[&#39;name&#39;] =3D name=
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.debug2(&quot;Fetching %s to %s&quo=
t; % (ud.url, ud.parm[&#39;downloadfilename&#39;]))<br>
<br>
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py<br>
index fd089bc8..85cf25e7 100644<br>
--- a/lib/bb/tests/fetch.py<br>
+++ b/lib/bb/tests/fetch.py<br>
@@ -2423,6 +2423,30 @@ class CrateTest(FetcherTest):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertTrue(os.path.exists(self.tempd=
ir + &quot;/cargo_home/bitbake/time-0.1.35/.cargo-checksum.json&quot;))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertTrue(os.path.exists(self.tempd=
ir + &quot;/cargo_home/bitbake/time-0.1.35/src/<a href=3D"http://lib.rs" re=
l=3D"noreferrer" target=3D"_blank">lib.rs</a>&quot;))<br>
<br>
+=C2=A0 =C2=A0 @skipIfNoNetwork()<br>
+=C2=A0 =C2=A0 def test_crate_url_params(self):<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uri =3D &quot;crate://<a href=3D"http://crates=
.io/aho-corasick/0.7.20;name=3Daho-corasick-renamed" rel=3D"noreferrer" tar=
get=3D"_blank">crates.io/aho-corasick/0.7.20;name=3Daho-corasick-renamed</a=
>&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.d.setVar(&#39;SRC_URI&#39;, uri)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uris =3D self.d.getVar(&#39;SRC_URI&#39;).spli=
t()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 d =3D self.d<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fetcher =3D bb.fetch2.Fetch(uris, self.d)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud =3D fetcher.ud[fetcher.urls[0]]<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertIn(&quot;name&quot;, ud.parm)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(ud.parm[&quot;name&quot;], &q=
uot;aho-corasick-renamed&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertIn(&quot;downloadfilename&quot;, ud=
.parm)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(ud.parm[&quot;downloadfilenam=
e&quot;], &quot;aho-corasick-0.7.20.crate&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fetcher.download()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fetcher.unpack(self.tempdir)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(sorted(os.listdir(self.tempdi=
r)), [&#39;cargo_home&#39;, &#39;download&#39; , &#39;unpacked&#39;])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(sorted(os.listdir(self.tempdi=
r + &quot;/download&quot;)), [&#39;aho-corasick-0.7.20.crate&#39;, &#39;aho=
-corasick-0.7.20.crate.done&#39;])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(os.path.exists(self.tempdir + =
&quot;/cargo_home/bitbake/aho-corasick-0.7.20/.cargo-checksum.json&quot;))<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(os.path.exists(self.tempdir + =
&quot;/cargo_home/bitbake/aho-corasick-0.7.20/src/<a href=3D"http://lib.rs"=
 rel=3D"noreferrer" target=3D"_blank">lib.rs</a>&quot;))<br>
+<br>
=C2=A0 =C2=A0 =C2=A0@skipIfNoNetwork()<br>
=C2=A0 =C2=A0 =C2=A0def test_crate_incorrect_cksum(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uri =3D &quot;crate://<a href=3D"http://c=
rates.io/aho-corasick/0.7.20" rel=3D"noreferrer" target=3D"_blank">crates.i=
o/aho-corasick/0.7.20</a>&quot;<br>
-- <br>
2.34.1<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#14564): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/14564" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/14564</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/97627476/6213=
388" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/97627476/6213388</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:frederic.martinsons@gmail.com" tar=
get=3D"_blank">frederic.martinsons@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--000000000000c5ccd805f701e691--

