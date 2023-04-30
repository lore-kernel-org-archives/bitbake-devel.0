Return-Path: <frederic.martinsons@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EA5C77B60
	for <webhook@archiver.kernel.org>; Sun, 30 Apr 2023 10:01:11 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.web11.65698.1682848862752454761
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 30 Apr 2023 03:01:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@gmail.com header.s=20221208 header.b=pU8dzTvw;
 spf=pass (domain: gmail.com, ip: 209.85.167.45, mailfrom: frederic.martinsons@gmail.com)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-4ec8149907aso1945278e87.1
        for <bitbake-devel@lists.openembedded.org>; Sun, 30 Apr 2023 03:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682848861; x=1685440861;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BW82cv+vFgNwUXbMuDfl9G+i/pjK4Nxg8Q8aqeC2mZE=;
        b=pU8dzTvwZJL3H5yWb76L5EigGyfqmiI0V9pVk/U4k4Asn4zR9VICDZDtlZCjOfi20U
         6520yECfSat1dzmdBa1ArF+JgRB9i6w/gzhrs6M/xQ1dgwI2N5twkyYf7dUbRzl+g4vH
         qamrKeVCzQZB8Y0eoPHHCXCcQ2cNK0glC00b7qlj3u1ZRGFmU9IGBAcK7ejm68iPMBa+
         eM/Fv727k9K59MXacorSeq67jYQgLyo19Px9FOOm7m1O4Q0zILEbbFqQJOWEudRSvjpW
         6bBZJQZtr2Qk4nJ4w+N1ht1vk+BFFClNq4PuFPsImL3VVRrr9R4BWD5SXwJeaHkQPC91
         cgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682848861; x=1685440861;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BW82cv+vFgNwUXbMuDfl9G+i/pjK4Nxg8Q8aqeC2mZE=;
        b=h+/m/Pc8VX6+Il7EaUCVKQHYTkyQFN9UHIKbLOke2RNRHv8vNz66aogxZeAy082jEX
         ZhPj3zVW6zmEen9z/7ASJy10P28+6E0gZSFH1C9oBRqugm4WKXJObJ3KhWqwqHwbEa9y
         4P7jYNwNAsGSPNPJOQas6LSa5E27l9+0p+awui5AOnCoQ5GE1xMilpvZF+d4HZZXPuig
         hGvFvgG7JcRm8HI786RhEy/Jwq694hgkh6SHK28DuhkngvGApQt2AqZJGrzamRM9uAbs
         816STDHJz+hp4fPK4CvwPwi8DkTRbPJuXfJnCuLgCPik5FQTEk3/wVzCAcdlg/fHrK/q
         tklQ==
X-Gm-Message-State: AC+VfDzfvYKoe8v4P9XyoM9XV7qpBKCYgSZ5S1L/9yCqUYGPgEP/brCp
	0U+TSRaitBUtIaSw4ey8dYpwXsdjh8pT4qzOj78=
X-Google-Smtp-Source: ACHHUZ7Zx4MWIkP8IcQTGjlT2f6q21QD5KSMUjN0ib1TXAw2t3qeuEHfiJroZzVJVSGFc6R41Umf29wzm0pEAOaEGl8=
X-Received: by 2002:ac2:5edd:0:b0:4eb:336c:f10 with SMTP id
 d29-20020ac25edd000000b004eb336c0f10mr3176424lfq.57.1682848860500; Sun, 30
 Apr 2023 03:01:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230429012329.1799116-1-pkj@axis.com> <20230429012329.1799116-2-pkj@axis.com>
 <CA+cAkepCzOPBQ8a_KrJcDyJycBcuX-b=ybSTLuGERWcrQ710Kg@mail.gmail.com> <DB5PR02MB102131AD2DC5782665B7B4DCEEF689@DB5PR02MB10213.eurprd02.prod.outlook.com>
In-Reply-To: <DB5PR02MB102131AD2DC5782665B7B4DCEEF689@DB5PR02MB10213.eurprd02.prod.outlook.com>
From: =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= <frederic.martinsons@gmail.com>
Date: Sun, 30 Apr 2023 12:00:48 +0200
Message-ID: <CA+cAkeo=yT-P0Q4z5Tya7nrszu0a3Zs-KSZpmjtWO0qH044h_A@mail.gmail.com>
Subject: Re: [bitbake-devel] [master][mickledore][PATCH 2/2] fetch2/crate:
 Correct unpack for a crate that matches the recipe name
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000008a782e05fa8ac88e"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 30 Apr 2023 10:01:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14762

--0000000000008a782e05fa8ac88e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Great, thanks Peter for the confirmation!

Le sam. 29 avr. 2023, 22:22, Peter Kjellerstedt <peter.kjellerstedt@axis.co=
m>
a =C3=A9crit :

> Yes. While the original issue was written about missing checksuming, whic=
h
> was fixed by requiring checksums for the crate URIs in the SRC_URI, the
> additional concern you raised is fixed by my patch. It restores the suppo=
rt
> for using a crate as the main component for the recipe. This was in the
> bbclass all along, it just broke when the names were changed to include t=
he
> crate versions.
>
>
>
> You can actually workaround the problem by setting S =3D
> "${CARGO_VENDORING_DIRECTORY}/${BP}", but I believe it is better to
> restore the intended functionality of the bbclass. It also makes things
> much more intuitive when using devtool modify for such a recipe since the
> source is where you expect it to be.
>
>
>
> @Alexandre Belloni: Since I assume it will be you that pulls this into
> testing, feel free to add the following to the commit message:
>
>
>
> [Yocto #15012]
>
>
>
> //Peter
>
>
>
> *From:* Fr=C3=A9d=C3=A9ric Martinsons <frederic.martinsons@gmail.com>
> *Sent:* den 29 april 2023 08:48
> *To:* Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> *Cc:* bitbake-devel@lists.openembedded.org
> *Subject:* Re: [bitbake-devel] [master][mickledore][PATCH 2/2]
> fetch2/crate: Correct unpack for a crate that matches the recipe name
>
>
>
> Hello Peter,
>
>
>
> Do you think it will solve the issue I mentioned there
> <https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D15012#c4> ?
>
>
>
> On Sat, 29 Apr 2023 at 03:23, Peter Kjellerstedt <
> peter.kjellerstedt@axis.com> wrote:
>
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
>          save_cwd =3D os.getcwd()
>          os.chdir(rootdir)
>
> -        pn =3D d.getVar('BPN')
> -        if pn =3D=3D ud.parm.get('name'):
> +        bp =3D d.getVar('BP')
> +        if bp =3D=3D ud.parm.get('name'):
>              cmd =3D "tar -xz --no-same-owner -f %s" % thefile
>          else:
>              cargo_bitbake =3D self._cargo_bitbake_path(rootdir)
> diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.p=
y
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
> +        uri =3D "crate://crates.io/glob/0.2.11"
> +        self.d.setVar('SRC_URI', uri)
> +
> +        uris =3D self.d.getVar('SRC_URI').split()
> +        d =3D self.d
> +
> +        fetcher =3D bb.fetch2.Fetch(uris, self.d)
> +        ud =3D fetcher.ud[fetcher.urls[0]]
> +
> +        self.assertIn("name", ud.parm)
> +        self.assertEqual(ud.parm["name"], "glob-0.2.11")
> +        self.assertIn("downloadfilename", ud.parm)
> +        self.assertEqual(ud.parm["downloadfilename"], "glob-0.2.11.crate=
")
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
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14758):
> https://lists.openembedded.org/g/bitbake-devel/message/14758
> Mute This Topic: https://lists.openembedded.org/mt/98571257/6213388
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> frederic.martinsons@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--0000000000008a782e05fa8ac88e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Great, thanks Peter for the confirmation!=C2=A0</div><br>=
<div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Le sam. 29=
 avr. 2023, 22:22, Peter Kjellerstedt &lt;<a href=3D"mailto:peter.kjellerst=
edt@axis.com">peter.kjellerstedt@axis.com</a>&gt; a =C3=A9crit=C2=A0:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">





<div lang=3D"SV" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:break-wo=
rd">
<div class=3D"m_1773404062454036438WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#943634">Yes. Wh=
ile the original issue was written about missing checksuming, which was fix=
ed by requiring checksums for the crate URIs in the SRC_URI, the additional=
 concern you
 raised is fixed by my patch. It restores the support for using a crate as =
the main component for the recipe. This was in the bbclass all along, it ju=
st broke when the names were changed to include the crate versions.<u></u><=
u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#943634"><u></u>=
=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#943634">You can=
 actually workaround the problem by setting
</span><span lang=3D"EN-US" style=3D"font-family:Consolas;color:#943634">S =
=3D &quot;${CARGO_VENDORING_DIRECTORY}/${BP}&quot;</span><span lang=3D"EN-U=
S" style=3D"color:#943634">, but I believe it is better to restore the inte=
nded
 functionality of the bbclass. It also makes things much more intuitive whe=
n using
</span><span lang=3D"EN-US" style=3D"font-family:Consolas;color:#943634">de=
vtool modify</span><span lang=3D"EN-US" style=3D"color:#943634"> for such a=
 recipe since the source is where you expect it to be.<u></u><u></u></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#943634"><u></u>=
=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#943634">@Alexan=
dre Belloni: Since I assume it will be you that pulls this into testing, fe=
el free to add the following to the commit message:<u></u><u></u></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#943634"><u></u>=
=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#943634">[Yocto =
#15012]<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#943634"><u></u>=
=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#943634">//Peter=
<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#943634"><u></u>=
=C2=A0<u></u></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #e1e1e1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US">From:</span></b><span lang=
=3D"EN-US"> Fr=C3=A9d=C3=A9ric Martinsons &lt;<a href=3D"mailto:frederic.ma=
rtinsons@gmail.com" target=3D"_blank" rel=3D"noreferrer">frederic.martinson=
s@gmail.com</a>&gt;
<br>
<b>Sent:</b> den 29 april 2023 08:48<br>
<b>To:</b> Peter Kjellerstedt &lt;<a href=3D"mailto:peter.kjellerstedt@axis=
.com" target=3D"_blank" rel=3D"noreferrer">peter.kjellerstedt@axis.com</a>&=
gt;<br>
<b>Cc:</b> <a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=
=3D"_blank" rel=3D"noreferrer">bitbake-devel@lists.openembedded.org</a><br>
<b>Subject:</b> Re: [bitbake-devel] [master][mickledore][PATCH 2/2] fetch2/=
crate: Correct unpack for a crate that matches the recipe name<u></u><u></u=
></span></p>
</div>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<div>
<p class=3D"MsoNormal">Hello Peter,<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Do you think it will solve the issue I mentioned=C2=
=A0<a href=3D"https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D15012#c4"=
 target=3D"_blank" rel=3D"noreferrer">there</a>=C2=A0?<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<div>
<p class=3D"MsoNormal">On Sat, 29 Apr 2023 at 03:23, Peter Kjellerstedt &lt=
;<a href=3D"mailto:peter.kjellerstedt@axis.com" target=3D"_blank" rel=3D"no=
referrer">peter.kjellerstedt@axis.com</a>&gt; wrote:<u></u><u></u></p>
</div>
<blockquote style=3D"border:none;border-left:solid #cccccc 1.0pt;padding:0c=
m 0cm 0cm 6.0pt;margin-left:4.8pt;margin-right:0cm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">The crate fetcher han=
dles a crate with a name that matches the recipe&#39;s<br>
name specially by placing the unpacked code in the current directory<br>
(which typically is ${S}) rather than together with the sources for the<br>
other crates. This broke when the URI names for all crates were changed<br>
recently to include the version in the name.<br>
<br>
Correct the crate fetcher to test against ${BP} instead of ${BPN}.<br>
Also add a test case to the selftests to avoid this breaking again.<br>
<br>
Signed-off-by: Peter Kjellerstedt &lt;<a href=3D"mailto:peter.kjellerstedt@=
axis.com" target=3D"_blank" rel=3D"noreferrer">peter.kjellerstedt@axis.com<=
/a>&gt;<br>
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
ir + &quot;/cargo_home/bitbake/glob-0.2.11/src/<a href=3D"http://lib.rs" ta=
rget=3D"_blank" rel=3D"noreferrer">lib.rs</a>&quot;))<br>
<br>
+=C2=A0 =C2=A0 @skipIfNoNetwork()<br>
+=C2=A0 =C2=A0 def test_crate_url_matching_recipe(self):<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.d.setVar(&#39;BP&#39;, &#39;glob-0.2.11&#=
39;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uri =3D &quot;crate://<a href=3D"http://crates=
.io/glob/0.2.11" target=3D"_blank" rel=3D"noreferrer">crates.io/glob/0.2.11=
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
&quot;/glob-0.2.11/src/<a href=3D"http://lib.rs" target=3D"_blank" rel=3D"n=
oreferrer">lib.rs</a>&quot;))<br>
+<br>
=C2=A0 =C2=A0 =C2=A0@skipIfNoNetwork()<br>
=C2=A0 =C2=A0 =C2=A0def test_crate_url_params(self):<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#14758): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/14758" target=3D"_blank" rel=3D"noreferrer">
https://lists.openembedded.org/g/bitbake-devel/message/14758</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/98571257/6213=
388" target=3D"_blank" rel=3D"noreferrer">
https://lists.openembedded.org/mt/98571257/6213388</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank" rel=3D"noreferrer">
bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" target=3D"_blank" rel=3D"noreferrer">
https://lists.openembedded.org/g/bitbake-devel/unsub</a> [<a href=3D"mailto=
:frederic.martinsons@gmail.com" target=3D"_blank" rel=3D"noreferrer">freder=
ic.martinsons@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<u></u><u></u></p>
</blockquote>
</div>
</div>
</div>
</div>
</div>

</blockquote></div>

--0000000000008a782e05fa8ac88e--

