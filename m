Return-Path: <ernstp@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99881C36000
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 08:05:58 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.web11.2817.1742371552079629085
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Mar 2025 01:05:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ljIEwHqK;
 spf=pass (domain: gmail.com, ip: 209.85.218.47, mailfrom: ernstp@gmail.com)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac3b12e8518so137612366b.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 19 Mar 2025 01:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742371550; x=1742976350; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xpHR2IkPD7zu6GjtIrFNiRXerANx3QjWCdmyf+sLrZw=;
        b=ljIEwHqKNNqXStgmx1lEv3UiLzWREiZRyVCh2HRjkkes/vnAU9DSiOG6FZa6VQQn/M
         0DGpjUHmxne4srrF0BW4OseyWQ9xerN507jkMl3mSudLcOYl3vniDvS65D7g0XUc4JsW
         H4s3a01fGypmtLh+orkriCKiq63vIucCQClVeSqmPDTTY20jltk/KLzN65BNqmKxXtwl
         FL6qvrXX17rPj8yoqXOGnlTtW9R+JD2o8lHdhXeia9j7ydZAdPNVknYl/8zSRgAnWXjI
         4XdeN4UZDmILaPoDv+WaCY/TWy+3jIcXAWUaZ57gAzVSvvBlZsXhvKMmpIr+mvwIWO+f
         X0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742371550; x=1742976350;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xpHR2IkPD7zu6GjtIrFNiRXerANx3QjWCdmyf+sLrZw=;
        b=bODxyh82YHORPaDp60nd9Iz4Ma0HKwhJi0jmVtJcLCUZnHybuh/AvUWqu285h6VJ4Z
         wAdn8XF4yjECM3CEcXgkcIpWVQXVlqHhLwK1h2Zk8TowcfjcI6Br8Bg4fK9DAocLAFQo
         fp0shEmFd2nPLm2A+T0Rlldt7reO0oDoQkD/y7uxdgUAxuykQL7n1Vjz59GZ+3jM2Wq5
         G/8N6qmUFEbRVMQEF3zFo4mwKsXQERhsiZXK+2wHkZVmEHUnETvbbEIi72OQFyCpmMST
         EVWRM2E9A2jnnDEypyTwq+qvOvKNLPYeu1lSaW6xjvB4oALsYphNEJVEgtBW+D6uSYQ8
         xsXA==
X-Gm-Message-State: AOJu0Yxs0vwBa0tgqXLvo6CFFrtbvAzQDtB8BDj5hEhtwXoAqdCejDPz
	Ge3WIIO9nMIDopMuLTiRUWx2//W68k3JJ8rL1O25lbCRCzt9bA2kUnAjwiA53Gb+vJ5eJTmUVZt
	hDG7tg+Df6Cum4XeyX+yV+YL34DFji1lm
X-Gm-Gg: ASbGnctkytXf+gSvYpMyydHgWhl2a4w/xR/pAg1NmluvRlVrSWFyH1F6uVId2dNXWv4
	XTUnQr2BnsfJZ4j7WZjtCG5tQ2RNVgicZh5tLChfN5RqQ01CNg9ZPjYtJZf+5zu86ULBoSMET/O
	wqG7TOglbf5b1lTYhxEuXxDf8JZqO2
X-Google-Smtp-Source: AGHT+IE20FIo7zCgk/G1QNLVGZDZYDsC6lKmzNdkF4kbWccgt/fHTtWd7iuOpZdYvoIvBP9u819jpBw1JUt17O6BvcQ=
X-Received: by 2002:a17:907:6ea9:b0:ac3:9587:f2ac with SMTP id
 a640c23a62f3a-ac3b7de18b7mr164355166b.33.1742371549565; Wed, 19 Mar 2025
 01:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1741808747.git.steve@sakoman.com> <da5f41996687e18b78d9c9845e621d832115aa1e.1741808747.git.steve@sakoman.com>
In-Reply-To: <da5f41996687e18b78d9c9845e621d832115aa1e.1741808747.git.steve@sakoman.com>
From: Ernst Persson <ernstp@gmail.com>
Date: Wed, 19 Mar 2025 09:05:38 +0100
X-Gm-Features: AQ5f1JpCePqY4DaMwnPif5Ju9i4dkCB-cMFFjtj02LAObU2zXPauunw7YNFj6Tg
Message-ID: <CAD=4a=Umi_YD9i=FB+412DQJLLi4b_AdDn0MeTWiBMMmZ+WE3w@mail.gmail.com>
Subject: Re: [bitbake-devel] [bitbake][kirkstone][2.0][PATCH 1/1] siggen.py:
 Improve taskhash reproducibility
To: steve@sakoman.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000475d570630ad7d36"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Mar 2025 08:05:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17464

--000000000000475d570630ad7d36
Content-Type: text/plain; charset="UTF-8"

I tried building in an old kirkstone workspace with this patch applied and
I got a lot of taskhash mismatch errors.
After deleting tmp and cache the build was fine, though it did rebuild
everything from scratch.
Does this need bumping of something like HASHEQUIV_HASH_VERSION or
SSTATE_VERSION... ?

Regards
//Ernst

Den ons 12 mars 2025 kl 20:48 skrev Steve Sakoman via lists.openembedded.org
<steve=sakoman.com@lists.openembedded.org>:

> From: Paulo Neves <paulo@myneves.com>
>
> file checksums are part of the data checksummed
> to generate the task hash. The list of file checksums
> was not ordered.
>
> In this commit we make sure the task hash checksum takes
> a list of checksum data that is ordered by unique file name
> thus guaranteeing reproducibility.
>
> Signed-off-by: Paulo Neves <paulo@myneves.com>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
> Signed-off-by: Steve Sakoman <steve@sakoman.com>
> ---
>  lib/bb/siggen.py | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
> index 0a9ce0ede..828729d8b 100644
> --- a/lib/bb/siggen.py
> +++ b/lib/bb/siggen.py
> @@ -331,7 +331,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
>          for dep in self.runtaskdeps[tid]:
>              data += self.get_unihash(dep)
>
> -        for (f, cs) in self.file_checksum_values[tid]:
> +        for (f, cs) in sorted(self.file_checksum_values[tid],
> key=clean_checksum_file_path):
>              if cs:
>                  if "/./" in f:
>                      data += "./" + f.split("/./")[1]
> @@ -393,7 +393,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
>          if runtime and tid in self.taskhash:
>              data['runtaskdeps'] = self.runtaskdeps[tid]
>              data['file_checksum_values'] = []
> -            for f,cs in self.file_checksum_values[tid]:
> +            for f,cs in sorted(self.file_checksum_values[tid],
> key=clean_checksum_file_path):
>                  if "/./" in f:
>                      data['file_checksum_values'].append(("./" +
> f.split("/./")[1], cs))
>                  else:
> @@ -720,6 +720,12 @@ class
> SignatureGeneratorTestMulticonfigDepends(SignatureGeneratorBasicHash):
>      name = "TestMulticonfigDepends"
>      supports_multiconfig_datacaches = True
>
> +def clean_checksum_file_path(file_checksum_tuple):
> +    f, cs = file_checksum_tuple
> +    if "/./" in f:
> +        return "./" + f.split("/./")[1]
> +    return f
> +
>  def dump_this_task(outfile, d):
>      import bb.parse
>      fn = d.getVar("BB_FILENAME")
> --
> 2.43.0
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17438):
> https://lists.openembedded.org/g/bitbake-devel/message/17438
> Mute This Topic: https://lists.openembedded.org/mt/111666877/4947266
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> ernstp@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

--000000000000475d570630ad7d36
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:arial,he=
lvetica,sans-serif">I tried building in an old kirkstone workspace with thi=
s patch applied and I got a lot of=20
<span class=3D"gmail-message"><span class=3D"gmail-content">taskhash mismat=
ch errors</span></span>.</div><div class=3D"gmail_default" style=3D"font-fa=
mily:arial,helvetica,sans-serif">After deleting tmp and cache the build was=
 fine, though it did rebuild everything from scratch.</div><div class=3D"gm=
ail_default" style=3D"font-family:arial,helvetica,sans-serif">Does this nee=
d bumping of something like=20
<span class=3D"gmail-message"><span class=3D"gmail-content">HASHEQUIV_HASH_=
VERSION or SSTATE_VERSION</span></span>... ?</div><div class=3D"gmail_defau=
lt" style=3D"font-family:arial,helvetica,sans-serif"><br></div><div class=
=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif">Regards=
</div><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,san=
s-serif">//Ernst</div></div><br><div class=3D"gmail_quote gmail_quote_conta=
iner"><div dir=3D"ltr" class=3D"gmail_attr">Den ons 12 mars 2025 kl 20:48 s=
krev Steve Sakoman via <a href=3D"http://lists.openembedded.org">lists.open=
embedded.org</a> &lt;steve=3D<a href=3D"mailto:sakoman.com@lists.openembedd=
ed.org">sakoman.com@lists.openembedded.org</a>&gt;:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">From: Paulo Neves &lt;<a href=3D"mailto=
:paulo@myneves.com" target=3D"_blank">paulo@myneves.com</a>&gt;<br>
<br>
file checksums are part of the data checksummed<br>
to generate the task hash. The list of file checksums<br>
was not ordered.<br>
<br>
In this commit we make sure the task hash checksum takes<br>
a list of checksum data that is ordered by unique file name<br>
thus guaranteeing reproducibility.<br>
<br>
Signed-off-by: Paulo Neves &lt;<a href=3D"mailto:paulo@myneves.com" target=
=3D"_blank">paulo@myneves.com</a>&gt;<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<b=
r>
Signed-off-by: Martin Jansa &lt;<a href=3D"mailto:martin.jansa@gmail.com" t=
arget=3D"_blank">martin.jansa@gmail.com</a>&gt;<br>
Signed-off-by: Steve Sakoman &lt;<a href=3D"mailto:steve@sakoman.com" targe=
t=3D"_blank">steve@sakoman.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/siggen.py | 10 ++++++++--<br>
=C2=A01 file changed, 8 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py<br>
index 0a9ce0ede..828729d8b 100644<br>
--- a/lib/bb/siggen.py<br>
+++ b/lib/bb/siggen.py<br>
@@ -331,7 +331,7 @@ class SignatureGeneratorBasic(SignatureGenerator):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for dep in self.runtaskdeps[tid]:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data +=3D self.get_unihash(=
dep)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (f, cs) in self.file_checksum_values[tid]:=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (f, cs) in sorted(self.file_checksum_value=
s[tid], key=3Dclean_checksum_file_path):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if cs:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if &quot;/./&=
quot; in f:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0data +=3D &quot;./&quot; + f.split(&quot;/./&quot;)[1]<br>
@@ -393,7 +393,7 @@ class SignatureGeneratorBasic(SignatureGenerator):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if runtime and tid in self.taskhash:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data[&#39;runtaskdeps&#39;]=
 =3D self.runtaskdeps[tid]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data[&#39;file_checksum_val=
ues&#39;] =3D []<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for f,cs in self.file_checksum_v=
alues[tid]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for f,cs in sorted(self.file_che=
cksum_values[tid], key=3Dclean_checksum_file_path):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if &quot;/./&=
quot; in f:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0data[&#39;file_checksum_values&#39;].append((&quot;./&quot; + f.split(&q=
uot;/./&quot;)[1], cs))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
@@ -720,6 +720,12 @@ class SignatureGeneratorTestMulticonfigDepends(Signatu=
reGeneratorBasicHash):<br>
=C2=A0 =C2=A0 =C2=A0name =3D &quot;TestMulticonfigDepends&quot;<br>
=C2=A0 =C2=A0 =C2=A0supports_multiconfig_datacaches =3D True<br>
<br>
+def clean_checksum_file_path(file_checksum_tuple):<br>
+=C2=A0 =C2=A0 f, cs =3D file_checksum_tuple<br>
+=C2=A0 =C2=A0 if &quot;/./&quot; in f:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;./&quot; + f.split(&quot;/./&quot=
;)[1]<br>
+=C2=A0 =C2=A0 return f<br>
+<br>
=C2=A0def dump_this_task(outfile, d):<br>
=C2=A0 =C2=A0 =C2=A0import bb.parse<br>
=C2=A0 =C2=A0 =C2=A0fn =3D d.getVar(&quot;BB_FILENAME&quot;)<br>
-- <br>
2.43.0<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#17438): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/17438" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/17438</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/111666877/494=
7266" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/111666877/4947266</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:ernstp@gmail.com" target=3D"_blank=
">ernstp@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--000000000000475d570630ad7d36--

