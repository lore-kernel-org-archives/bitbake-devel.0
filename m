Return-Path: <frederic.martinsons@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AFFC77B60
	for <webhook@archiver.kernel.org>; Sat, 29 Apr 2023 06:48:33 +0000 (UTC)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
 by mx.groups.io with SMTP id smtpd.web10.41885.1682750911988449658
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Apr 2023 23:48:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@gmail.com header.s=20221208 header.b=bpZvHnC5;
 spf=pass (domain: gmail.com, ip: 209.85.167.52, mailfrom: frederic.martinsons@gmail.com)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-4f00d3f98deso13966256e87.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 28 Apr 2023 23:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682750910; x=1685342910;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hgnqplv7A3dLt1MoNJtEgFAxL8saOA9QAh6514l15m0=;
        b=bpZvHnC5gQQ0yQG1Nwv0613wo++DyPpgnvjMM/Co4oYy1P9g7DcYN22Di6Jq0u+dsQ
         C5Gf5H6/X4QabrpxrDjJuOR62b/mGYS3GM/Gkj3eYxRdi2KwIgUbNMHwv60nOyCbjxAY
         uvik2VNoeGmtlI9qNBxPZo+lP5f6aYCRuj4BRiiyYTZDaQxDINruC495CFGmspa/M08z
         8xEwcCgcnBk4A+VXVxk4by1PowhXdscxKuRRwEmuuUPh6l3eSUwP05OeiGg9P/qZzXZq
         0ZKKK9oBUVDQAO9+4JB9aU/amgP8TEf/9jQbS9GFwrj2XUwtih9w0EDx/S+7yjntLbRt
         A3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682750910; x=1685342910;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hgnqplv7A3dLt1MoNJtEgFAxL8saOA9QAh6514l15m0=;
        b=C/LP6+gRI7Wz5Cp77uDsr4UB9Chb0rdsQvbauD6ypfD8EsjFWX0bdbLc2SywqD6Aiw
         KSccUJQe3DUNaKOE6mP4Rz0pMO0r8S4KVxOOZqLWN/AabFFrYutZ3RX8kr59p4nwSXFm
         04taOUDLRAqAJrBmX3AIJSxoJh/iZjc5BdIXS7txJ09yoTTRaZD7fILKdd7rdoPK1gec
         4QZyY0z8dMrJlFuGTMmdaDdne1JtuKLw/V3GB7+7Mvwo/wPf6c3ktOXiVj0BOIZjg5J7
         zy4tUpD2/tF215FmXGeRCbcjna6LQwVJZuVRCGMRUNsa4lvIqsiA+07oUeGloPz5132T
         87Ig==
X-Gm-Message-State: AC+VfDxxtz60G3OSYX+VnT3f8sC0qT5E2ckOd8wJBjPqpyC1P3Ag2Ovl
	ae63nDTrtM9RgHfVcQwp+dACJhh8JuF8Fchjt2k=
X-Google-Smtp-Source: ACHHUZ629FjMHeHcgWAQkZYvGS2EYZeBjd/uV0MS2G819Ccj95rtRO/b7iirjX73YqB/xTIaTzZQKpN3bWGHDzNtAPo=
X-Received: by 2002:a05:6512:32c1:b0:4ef:ef1d:a987 with SMTP id
 f1-20020a05651232c100b004efef1da987mr2875135lfg.25.1682750909544; Fri, 28 Apr
 2023 23:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230429012329.1799116-1-pkj@axis.com> <20230429012329.1799116-2-pkj@axis.com>
In-Reply-To: <20230429012329.1799116-2-pkj@axis.com>
From: =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= <frederic.martinsons@gmail.com>
Date: Sat, 29 Apr 2023 08:48:18 +0200
Message-ID: <CA+cAkepCzOPBQ8a_KrJcDyJycBcuX-b=ybSTLuGERWcrQ710Kg@mail.gmail.com>
Subject: Re: [bitbake-devel] [master][mickledore][PATCH 2/2] fetch2/crate:
 Correct unpack for a crate that matches the recipe name
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000357c5a05fa73fa18"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 29 Apr 2023 06:48:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14760

--000000000000357c5a05fa73fa18
Content-Type: text/plain; charset="UTF-8"

Hello Peter,

Do you think it will solve the issue I mentioned there
<https://bugzilla.yoctoproject.org/show_bug.cgi?id=15012#c4> ?

On Sat, 29 Apr 2023 at 03:23, Peter Kjellerstedt <
peter.kjellerstedt@axis.com> wrote:

> The crate fetcher handles a crate with a name that matches the recipe's
> name specially by placing the unpacked code in the current directory
> (which typically is ${S}) rather than together with the sources for the
> other crates. This broke when the URI names for all crates were changed
> recently to include the version in the name.
>
> Correct the crate fetcher to test against ${BP} instead of ${BPN}.
> Also add a test case to the selftests to avoid this breaking again.
>
> Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> ---
>  bitbake/lib/bb/fetch2/crate.py |  4 ++--
>  bitbake/lib/bb/tests/fetch.py  | 25 +++++++++++++++++++++++++
>  2 files changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/bitbake/lib/bb/fetch2/crate.py
> b/bitbake/lib/bb/fetch2/crate.py
> index 2b8b6bc7a1..3310ed0050 100644
> --- a/bitbake/lib/bb/fetch2/crate.py
> +++ b/bitbake/lib/bb/fetch2/crate.py
> @@ -98,8 +98,8 @@ class Crate(Wget):
>          save_cwd = os.getcwd()
>          os.chdir(rootdir)
>
> -        pn = d.getVar('BPN')
> -        if pn == ud.parm.get('name'):
> +        bp = d.getVar('BP')
> +        if bp == ud.parm.get('name'):
>              cmd = "tar -xz --no-same-owner -f %s" % thefile
>          else:
>              cargo_bitbake = self._cargo_bitbake_path(rootdir)
> diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
> index 6ef0836f2b..23bfa788db 100644
> --- a/bitbake/lib/bb/tests/fetch.py
> +++ b/bitbake/lib/bb/tests/fetch.py
> @@ -2391,6 +2391,31 @@ class CrateTest(FetcherTest):
>          self.assertTrue(os.path.exists(self.tempdir +
> "/cargo_home/bitbake/glob-0.2.11/.cargo-checksum.json"))
>          self.assertTrue(os.path.exists(self.tempdir +
> "/cargo_home/bitbake/glob-0.2.11/src/lib.rs"))
>
> +    @skipIfNoNetwork()
> +    def test_crate_url_matching_recipe(self):
> +
> +        self.d.setVar('BP', 'glob-0.2.11')
> +
> +        uri = "crate://crates.io/glob/0.2.11"
> +        self.d.setVar('SRC_URI', uri)
> +
> +        uris = self.d.getVar('SRC_URI').split()
> +        d = self.d
> +
> +        fetcher = bb.fetch2.Fetch(uris, self.d)
> +        ud = fetcher.ud[fetcher.urls[0]]
> +
> +        self.assertIn("name", ud.parm)
> +        self.assertEqual(ud.parm["name"], "glob-0.2.11")
> +        self.assertIn("downloadfilename", ud.parm)
> +        self.assertEqual(ud.parm["downloadfilename"], "glob-0.2.11.crate")
> +
> +        fetcher.download()
> +        fetcher.unpack(self.tempdir)
> +        self.assertEqual(sorted(os.listdir(self.tempdir)), ['download',
> 'glob-0.2.11', 'unpacked'])
> +        self.assertEqual(sorted(os.listdir(self.tempdir + "/download")),
> ['glob-0.2.11.crate', 'glob-0.2.11.crate.done'])
> +        self.assertTrue(os.path.exists(self.tempdir + "/glob-0.2.11/src/
> lib.rs"))
> +
>      @skipIfNoNetwork()
>      def test_crate_url_params(self):
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14758):
> https://lists.openembedded.org/g/bitbake-devel/message/14758
> Mute This Topic: https://lists.openembedded.org/mt/98571257/6213388
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> frederic.martinsons@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

--000000000000357c5a05fa73fa18
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello Peter,</div><div><br></div><div>Do you think it=
 will solve the issue I mentioned=C2=A0<a href=3D"https://bugzilla.yoctopro=
ject.org/show_bug.cgi?id=3D15012#c4">there</a>=C2=A0?</div><div><br></div><=
div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, 29 =
Apr 2023 at 03:23, Peter Kjellerstedt &lt;<a href=3D"mailto:peter.kjellerst=
edt@axis.com">peter.kjellerstedt@axis.com</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">The crate fetcher handles a crate =
with a name that matches the recipe&#39;s<br>
name specially by placing the unpacked code in the current directory<br>
(which typically is ${S}) rather than together with the sources for the<br>
other crates. This broke when the URI names for all crates were changed<br>
recently to include the version in the name.<br>
<br>
Correct the crate fetcher to test against ${BP} instead of ${BPN}.<br>
Also add a test case to the selftests to avoid this breaking again.<br>
<br>
Signed-off-by: Peter Kjellerstedt &lt;<a href=3D"mailto:peter.kjellerstedt@=
axis.com" target=3D"_blank">peter.kjellerstedt@axis.com</a>&gt;<br>
---<br>
=C2=A0bitbake/lib/bb/fetch2/crate.py |=C2=A0 4 ++--<br>
=C2=A0bitbake/lib/bb/tests/fetch.py=C2=A0 | 25 +++++++++++++++++++++++++<br=
>
=C2=A02 files changed, 27 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/bitbake/lib/bb/fetch2/crate.py b/bitbake/lib/bb/fetch2/crate.p=
y<br>
index 2b8b6bc7a1..3310ed0050 100644<br>
--- a/bitbake/lib/bb/fetch2/crate.py<br>
+++ b/bitbake/lib/bb/fetch2/crate.py<br>
@@ -98,8 +98,8 @@ class Crate(Wget):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0save_cwd =3D os.getcwd()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0os.chdir(rootdir)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 pn =3D d.getVar(&#39;BPN&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if pn =3D=3D ud.parm.get(&#39;name&#39;):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bp =3D d.getVar(&#39;BP&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if bp =3D=3D ud.parm.get(&#39;name&#39;):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmd =3D &quot;tar -xz --no-=
same-owner -f %s&quot; % thefile<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cargo_bitbake =3D self._car=
go_bitbake_path(rootdir)<br>
diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py<=
br>
index 6ef0836f2b..23bfa788db 100644<br>
--- a/bitbake/lib/bb/tests/fetch.py<br>
+++ b/bitbake/lib/bb/tests/fetch.py<br>
@@ -2391,6 +2391,31 @@ class CrateTest(FetcherTest):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertTrue(os.path.exists(self.tempd=
ir + &quot;/cargo_home/bitbake/glob-0.2.11/.cargo-checksum.json&quot;))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertTrue(os.path.exists(self.tempd=
ir + &quot;/cargo_home/bitbake/glob-0.2.11/src/<a href=3D"http://lib.rs" re=
l=3D"noreferrer" target=3D"_blank">lib.rs</a>&quot;))<br>
<br>
+=C2=A0 =C2=A0 @skipIfNoNetwork()<br>
+=C2=A0 =C2=A0 def test_crate_url_matching_recipe(self):<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.d.setVar(&#39;BP&#39;, &#39;glob-0.2.11&#=
39;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uri =3D &quot;crate://<a href=3D"http://crates=
.io/glob/0.2.11" rel=3D"noreferrer" target=3D"_blank">crates.io/glob/0.2.11=
</a>&quot;<br>
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
uot;glob-0.2.11&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertIn(&quot;downloadfilename&quot;, ud=
.parm)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(ud.parm[&quot;downloadfilenam=
e&quot;], &quot;glob-0.2.11.crate&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fetcher.download()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fetcher.unpack(self.tempdir)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(sorted(os.listdir(self.tempdi=
r)), [&#39;download&#39;, &#39;glob-0.2.11&#39;, &#39;unpacked&#39;])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(sorted(os.listdir(self.tempdi=
r + &quot;/download&quot;)), [&#39;glob-0.2.11.crate&#39;, &#39;glob-0.2.11=
.crate.done&#39;])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(os.path.exists(self.tempdir + =
&quot;/glob-0.2.11/src/<a href=3D"http://lib.rs" rel=3D"noreferrer" target=
=3D"_blank">lib.rs</a>&quot;))<br>
+<br>
=C2=A0 =C2=A0 =C2=A0@skipIfNoNetwork()<br>
=C2=A0 =C2=A0 =C2=A0def test_crate_url_params(self):<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#14758): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/14758" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/14758</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/98571257/6213=
388" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/98571257/6213388</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:frederic.martinsons@gmail.com" tar=
get=3D"_blank">frederic.martinsons@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--000000000000357c5a05fa73fa18--

