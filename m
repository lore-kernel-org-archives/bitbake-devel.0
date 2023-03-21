Return-Path: <frederic.martinsons@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44206C74A5B
	for <webhook@archiver.kernel.org>; Tue, 21 Mar 2023 17:02:28 +0000 (UTC)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
 by mx.groups.io with SMTP id smtpd.web10.19508.1679418145206845070
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Mar 2023 10:02:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=lHv5lvXx;
 spf=pass (domain: gmail.com, ip: 209.85.208.180, mailfrom: frederic.martinsons@gmail.com)
Received: by mail-lj1-f180.google.com with SMTP id a11so5722820lji.6
        for <bitbake-devel@lists.openembedded.org>; Tue, 21 Mar 2023 10:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679418143;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9c6WL/zzyX7xFokzymHNDdtlIwUtTVLxcmjOSDnM240=;
        b=lHv5lvXxGyoNxlWyRutU6mKWyGrBxTvKd1bM7Vh0WDrWzFiFt9siJVxUN81xVgDgb9
         zCSAeXnBtwc8h1b7I9CHET5J3uSWhd3wlD7aXzSCjMFBaFHcRP0f+bLCEkYHqRMloW3u
         2mec3oYgggaNeKuu7bezS0iikZ7KTalz86YFxNB+ISWGbPj42Tpe0CatCoLd3JUS0GGO
         mGVqy2b4UiXPNDjZIgKT6DuHd2bjfXWe3Q51r4WJwaEfrrSuqFOkjRa5SjOs8ddu4SkA
         gbKOQ1zYk22O8NKszzDVH8l8jlFRpZp6/DUN3kjmWm1mCptSZK/FEfypzZ55HEpVSP20
         Q4sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679418143;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9c6WL/zzyX7xFokzymHNDdtlIwUtTVLxcmjOSDnM240=;
        b=XALYEtCbM9bJxv3PzTNxQStrJUX8Y42Oh8gthJLQ3iMxeXM/vwpbsr2o3DlMt73jLf
         e78J46bnigvt+7dRL5vPzX3wnz8jy/c/VmHHBhdbDEKklGJ3mQYes231kAHU8FXf2HCy
         bXPmWzGm4eb3HjE0DAA2LBrTaiV2pYFcwqfJk5AnkV3bCQOmNfcL1/inxrsJP0myMmm5
         8EDkWDi3yr3W/Ihg0so/B5hknzr6J4EEpxUaBYSjU8/WMeLls2ZkrLSMrje0GnKNtPUG
         74Sc8TEkgtThcp189RkdSHB0XWoFBuhU7Z2x2xHLhWDt2RXbRFYyVMKnw7AxIGCFqhkx
         0pyg==
X-Gm-Message-State: AO0yUKWHTlfHNu3BS5Hnlo5g6S+gQVfjSiFXXleIZvpoGK2y0wDVBgDD
	qG8+3IT1+49K5co460QJh+e77epd50YPRkmroDWDCLOH
X-Google-Smtp-Source: AK7set8M5wfsvodp+Hk9UX0eU5n6VB98spOq8kEkIBx7PFcCKzOdg6tUs0gYcxw5l4NkkWnJBkHDxOVaA526g0tSIwU=
X-Received: by 2002:a2e:8703:0:b0:29a:9053:ed1b with SMTP id
 m3-20020a2e8703000000b0029a9053ed1bmr1106197lji.3.1679418142375; Tue, 21 Mar
 2023 10:02:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230317081916.1857201-1-frederic.martinsons@gmail.com>
In-Reply-To: <20230317081916.1857201-1-frederic.martinsons@gmail.com>
From: =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= <frederic.martinsons@gmail.com>
Date: Tue, 21 Mar 2023 18:02:10 +0100
Message-ID: <CA+cAkep0W_Jjvvpg2OEm+DE6SDUB98-OnghOyytijbU1qC1B2A@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH v2 1/3] fetch2: Add checksum capability for
 crate fetcher
To: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000ce41ab05f76c019a"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Mar 2023 17:02:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14608

--000000000000ce41ab05f76c019a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Should I verify something more for this series?
I understood that it is a useful development to have in bitbake fetcher
(but will break things if series in oe-core and meta-oe are not applied
after this one) and I'm wondering if something block the review / apply ?

Please tell me, I'll do all my best to secure this.

Have a good day.

Le ven. 17 mars 2023, 09:19, <frederic.martinsons@gmail.com> a =C3=A9crit :

> From: Frederic Martinsons <frederic.martinsons@gmail.com>
>
> This change brings checksum verification of each crate
> in a recipe, e.g
>
> | SRC_URI +=3D " \
> |     crate://crates.io/aho-corasick/0.7.20 \
> |     crate://crates.io/atomic-waker/1.1.0 \
> |     crate://crates.io/cc/1.0.79 \
> | "
> |
> | SRC_URI[aho-corasick.sha256sum] =3D
> "cc936419f96fa211c1b9166887b38e5e40b19958e5b895be7c1f93adec7071ac"
> | SRC_URI[atomic-waker.sha256sum] =3D
> "debc29dde2e69f9e47506b525f639ed42300fc014a3e007832592448fa8e4599"
> | SRC_URI[cc.sha256sum] =3D
> "50d30906286121d95be3d479533b458f87493b30a4b5f79a607db8f5d11aa91f"
>
> That will require to move the checksum initialization
> after the possible call to urldata_init method in order
> for the crate fetcher to parse the url.
>
> Another way of doing could have been implementing a decodeurl
> method that would have been specific for each fetcher class.
>
> Signed-off-by: Frederic Martinsons <frederic.martinsons@gmail.com>
> ---
>  lib/bb/fetch2/__init__.py | 12 ++++++------
>  lib/bb/tests/fetch.py     | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+), 6 deletions(-)
>
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index cf65727a..3ae83fa8 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -1291,18 +1291,13 @@ class FetchData(object):
>
>              if checksum_name in self.parm:
>                  checksum_expected =3D self.parm[checksum_name]
> -            elif self.type not in ["http", "https", "ftp", "ftps",
> "sftp", "s3", "az"]:
> +            elif self.type not in ["http", "https", "ftp", "ftps",
> "sftp", "s3", "az", "crate"]:
>                  checksum_expected =3D None
>              else:
>                  checksum_expected =3D d.getVarFlag("SRC_URI", checksum_n=
ame)
>
>              setattr(self, "%s_expected" % checksum_id, checksum_expected=
)
>
> -        for checksum_id in CHECKSUM_LIST:
> -            configure_checksum(checksum_id)
> -
> -        self.ignore_checksums =3D False
> -
>          self.names =3D self.parm.get("name",'default').split(',')
>
>          self.method =3D None
> @@ -1324,6 +1319,11 @@ class FetchData(object):
>          if hasattr(self.method, "urldata_init"):
>              self.method.urldata_init(self, d)
>
> +        for checksum_id in CHECKSUM_LIST:
> +            configure_checksum(checksum_id)
> +
> +        self.ignore_checksums =3D False
> +
>          if "localpath" in self.parm:
>              # if user sets localpath for file, use it instead.
>              self.localpath =3D self.parm["localpath"]
> diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
> index 73eefc59..fd089bc8 100644
> --- a/lib/bb/tests/fetch.py
> +++ b/lib/bb/tests/fetch.py
> @@ -2377,6 +2377,13 @@ class CrateTest(FetcherTest):
>          d =3D self.d
>
>          fetcher =3D bb.fetch2.Fetch(uris, self.d)
> +        ud =3D fetcher.ud[fetcher.urls[0]]
> +
> +        self.assertIn("name", ud.parm)
> +        self.assertEqual(ud.parm["name"], "glob")
> +        self.assertIn("downloadfilename", ud.parm)
> +        self.assertEqual(ud.parm["downloadfilename"], "glob-0.2.11.crate=
")
> +
>          fetcher.download()
>          fetcher.unpack(self.tempdir)
>          self.assertEqual(sorted(os.listdir(self.tempdir)), ['cargo_home'=
,
> 'download' , 'unpacked'])
> @@ -2394,6 +2401,19 @@ class CrateTest(FetcherTest):
>          d =3D self.d
>
>          fetcher =3D bb.fetch2.Fetch(uris, self.d)
> +        ud =3D fetcher.ud[fetcher.urls[0]]
> +
> +        self.assertIn("name", ud.parm)
> +        self.assertEqual(ud.parm["name"], "glob")
> +        self.assertIn("downloadfilename", ud.parm)
> +        self.assertEqual(ud.parm["downloadfilename"], "glob-0.2.11.crate=
")
> +
> +        ud =3D fetcher.ud[fetcher.urls[1]]
> +        self.assertIn("name", ud.parm)
> +        self.assertEqual(ud.parm["name"], "time")
> +        self.assertIn("downloadfilename", ud.parm)
> +        self.assertEqual(ud.parm["downloadfilename"], "time-0.1.35.crate=
")
> +
>          fetcher.download()
>          fetcher.unpack(self.tempdir)
>          self.assertEqual(sorted(os.listdir(self.tempdir)), ['cargo_home'=
,
> 'download' , 'unpacked'])
> @@ -2403,6 +2423,18 @@ class CrateTest(FetcherTest):
>          self.assertTrue(os.path.exists(self.tempdir +
> "/cargo_home/bitbake/time-0.1.35/.cargo-checksum.json"))
>          self.assertTrue(os.path.exists(self.tempdir +
> "/cargo_home/bitbake/time-0.1.35/src/lib.rs"))
>
> +    @skipIfNoNetwork()
> +    def test_crate_incorrect_cksum(self):
> +        uri =3D "crate://crates.io/aho-corasick/0.7.20"
> +        self.d.setVar('SRC_URI', uri)
> +        self.d.setVarFlag("SRC_URI", "aho-corasick.sha256sum",
> hashlib.sha256("Invalid".encode("utf-8")).hexdigest())
> +
> +        uris =3D self.d.getVar('SRC_URI').split()
> +
> +        fetcher =3D bb.fetch2.Fetch(uris, self.d)
> +        with self.assertRaisesRegexp(bb.fetch2.FetchError, "Fetcher
> failure for URL"):
> +            fetcher.download()
> +
>  class NPMTest(FetcherTest):
>      def skipIfNoNpm():
>          import shutil
> --
> 2.34.1
>
>

--000000000000ce41ab05f76c019a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hello,<div dir=3D"auto"><br></div><div dir=3D"auto">Shoul=
d I verify something more for this series?=C2=A0</div><div dir=3D"auto">I u=
nderstood that it is a useful development to have in bitbake fetcher (but w=
ill break things if series in oe-core and meta-oe are not applied after thi=
s one) and I&#39;m wondering if something block the review / apply ?</div><=
div dir=3D"auto"><br></div><div dir=3D"auto">Please tell me, I&#39;ll do al=
l my best to secure this.</div><div dir=3D"auto"><br></div><div dir=3D"auto=
">Have a good day.=C2=A0</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">Le ven. 17 mars 2023, 09:19,  &lt;<a href=3D"=
mailto:frederic.martinsons@gmail.com">frederic.martinsons@gmail.com</a>&gt;=
 a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">From: Frederic=
 Martinsons &lt;<a href=3D"mailto:frederic.martinsons@gmail.com" target=3D"=
_blank" rel=3D"noreferrer">frederic.martinsons@gmail.com</a>&gt;<br>
<br>
This change brings checksum verification of each crate<br>
in a recipe, e.g<br>
<br>
| SRC_URI +=3D &quot; \<br>
|=C2=A0 =C2=A0 =C2=A0crate://<a href=3D"http://crates.io/aho-corasick/0.7.2=
0" rel=3D"noreferrer noreferrer" target=3D"_blank">crates.io/aho-corasick/0=
.7.20</a> \<br>
|=C2=A0 =C2=A0 =C2=A0crate://<a href=3D"http://crates.io/atomic-waker/1.1.0=
" rel=3D"noreferrer noreferrer" target=3D"_blank">crates.io/atomic-waker/1.=
1.0</a> \<br>
|=C2=A0 =C2=A0 =C2=A0crate://<a href=3D"http://crates.io/cc/1.0.79" rel=3D"=
noreferrer noreferrer" target=3D"_blank">crates.io/cc/1.0.79</a> \<br>
| &quot;<br>
|<br>
| SRC_URI[aho-corasick.sha256sum] =3D &quot;cc936419f96fa211c1b9166887b38e5=
e40b19958e5b895be7c1f93adec7071ac&quot;<br>
| SRC_URI[atomic-waker.sha256sum] =3D &quot;debc29dde2e69f9e47506b525f639ed=
42300fc014a3e007832592448fa8e4599&quot;<br>
| SRC_URI[cc.sha256sum] =3D &quot;50d30906286121d95be3d479533b458f87493b30a=
4b5f79a607db8f5d11aa91f&quot;<br>
<br>
That will require to move the checksum initialization<br>
after the possible call to urldata_init method in order<br>
for the crate fetcher to parse the url.<br>
<br>
Another way of doing could have been implementing a decodeurl<br>
method that would have been specific for each fetcher class.<br>
<br>
Signed-off-by: Frederic Martinsons &lt;<a href=3D"mailto:frederic.martinson=
s@gmail.com" target=3D"_blank" rel=3D"noreferrer">frederic.martinsons@gmail=
.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/fetch2/__init__.py | 12 ++++++------<br>
=C2=A0lib/bb/tests/fetch.py=C2=A0 =C2=A0 =C2=A0| 32 +++++++++++++++++++++++=
+++++++++<br>
=C2=A02 files changed, 38 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py<br>
index cf65727a..3ae83fa8 100644<br>
--- a/lib/bb/fetch2/__init__.py<br>
+++ b/lib/bb/fetch2/__init__.py<br>
@@ -1291,18 +1291,13 @@ class FetchData(object):<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if checksum_name in self.pa=
rm:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0checksum_expe=
cted =3D self.parm[checksum_name]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif self.type not in [&quot;htt=
p&quot;, &quot;https&quot;, &quot;ftp&quot;, &quot;ftps&quot;, &quot;sftp&q=
uot;, &quot;s3&quot;, &quot;az&quot;]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif self.type not in [&quot;htt=
p&quot;, &quot;https&quot;, &quot;ftp&quot;, &quot;ftps&quot;, &quot;sftp&q=
uot;, &quot;s3&quot;, &quot;az&quot;, &quot;crate&quot;]:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0checksum_expe=
cted =3D None<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0checksum_expe=
cted =3D d.getVarFlag(&quot;SRC_URI&quot;, checksum_name)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0setattr(self, &quot;%s_expe=
cted&quot; % checksum_id, checksum_expected)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for checksum_id in CHECKSUM_LIST:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 configure_checksum(checksum_id)<=
br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.ignore_checksums =3D False<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.names =3D self.parm.get(&quot;name&q=
uot;,&#39;default&#39;).split(&#39;,&#39;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.method =3D None<br>
@@ -1324,6 +1319,11 @@ class FetchData(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if hasattr(self.method, &quot;urldata_ini=
t&quot;):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.method.urldata_init(se=
lf, d)<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for checksum_id in CHECKSUM_LIST:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 configure_checksum(checksum_id)<=
br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.ignore_checksums =3D False<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if &quot;localpath&quot; in self.parm:<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# if user sets localpath fo=
r file, use it instead.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.localpath =3D self.par=
m[&quot;localpath&quot;]<br>
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py<br>
index 73eefc59..fd089bc8 100644<br>
--- a/lib/bb/tests/fetch.py<br>
+++ b/lib/bb/tests/fetch.py<br>
@@ -2377,6 +2377,13 @@ class CrateTest(FetcherTest):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0d =3D self.d<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fetcher =3D bb.fetch2.Fetch(uris, self.d)=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud =3D fetcher.ud[fetcher.urls[0]]<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertIn(&quot;name&quot;, ud.parm)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(ud.parm[&quot;name&quot;], &q=
uot;glob&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertIn(&quot;downloadfilename&quot;, ud=
.parm)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(ud.parm[&quot;downloadfilenam=
e&quot;], &quot;glob-0.2.11.crate&quot;)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fetcher.download()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fetcher.unpack(self.tempdir)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertEqual(sorted(os.listdir(self.t=
empdir)), [&#39;cargo_home&#39;, &#39;download&#39; , &#39;unpacked&#39;])<=
br>
@@ -2394,6 +2401,19 @@ class CrateTest(FetcherTest):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0d =3D self.d<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fetcher =3D bb.fetch2.Fetch(uris, self.d)=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud =3D fetcher.ud[fetcher.urls[0]]<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertIn(&quot;name&quot;, ud.parm)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(ud.parm[&quot;name&quot;], &q=
uot;glob&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertIn(&quot;downloadfilename&quot;, ud=
.parm)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(ud.parm[&quot;downloadfilenam=
e&quot;], &quot;glob-0.2.11.crate&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud =3D fetcher.ud[fetcher.urls[1]]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertIn(&quot;name&quot;, ud.parm)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(ud.parm[&quot;name&quot;], &q=
uot;time&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertIn(&quot;downloadfilename&quot;, ud=
.parm)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(ud.parm[&quot;downloadfilenam=
e&quot;], &quot;time-0.1.35.crate&quot;)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fetcher.download()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fetcher.unpack(self.tempdir)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertEqual(sorted(os.listdir(self.t=
empdir)), [&#39;cargo_home&#39;, &#39;download&#39; , &#39;unpacked&#39;])<=
br>
@@ -2403,6 +2423,18 @@ class CrateTest(FetcherTest):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertTrue(os.path.exists(self.tempd=
ir + &quot;/cargo_home/bitbake/time-0.1.35/.cargo-checksum.json&quot;))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertTrue(os.path.exists(self.tempd=
ir + &quot;/cargo_home/bitbake/time-0.1.35/src/<a href=3D"http://lib.rs" re=
l=3D"noreferrer noreferrer" target=3D"_blank">lib.rs</a>&quot;))<br>
<br>
+=C2=A0 =C2=A0 @skipIfNoNetwork()<br>
+=C2=A0 =C2=A0 def test_crate_incorrect_cksum(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uri =3D &quot;crate://<a href=3D"http://crates=
.io/aho-corasick/0.7.20" rel=3D"noreferrer noreferrer" target=3D"_blank">cr=
ates.io/aho-corasick/0.7.20</a>&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.d.setVar(&#39;SRC_URI&#39;, uri)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.d.setVarFlag(&quot;SRC_URI&quot;, &quot;a=
ho-corasick.sha256sum&quot;, hashlib.sha256(&quot;Invalid&quot;.encode(&quo=
t;utf-8&quot;)).hexdigest())<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uris =3D self.d.getVar(&#39;SRC_URI&#39;).spli=
t()<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fetcher =3D bb.fetch2.Fetch(uris, self.d)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with self.assertRaisesRegexp(bb.fetch2.FetchEr=
ror, &quot;Fetcher failure for URL&quot;):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fetcher.download()<br>
+<br>
=C2=A0class NPMTest(FetcherTest):<br>
=C2=A0 =C2=A0 =C2=A0def skipIfNoNpm():<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0import shutil<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div>

--000000000000ce41ab05f76c019a--

