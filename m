Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA227C48295
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 15:49:37 +0000 (UTC)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
 by mx.groups.io with SMTP id smtpd.web10.66224.1707148169074287983
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 05 Feb 2024 07:49:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=X/VQxuk+;
 spf=pass (domain: gmail.com, ip: 209.85.215.180, mailfrom: martin.jansa@gmail.com)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so4179230a12.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 05 Feb 2024 07:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707148168; x=1707752968; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B5m1CgJAMOKsr19uagd18SS3wirrPMPgS0t3eQ8WQkw=;
        b=X/VQxuk+8NLBa0sUF2xF8P+UhcJ7O4NkJ+shZrozab1rrVgWZDLBoyKnRgvpl4Veg/
         VVslqWH/RXzTEOz6ko6sEqkaVw0Q+m2/i72eSDp9fG3lkj3lHc5Gc5uOUv9z9CT5q34S
         V5U9QtN3ysHVSo6nKuZSsObrvKbCn9gPSxr3tZHt39pYgJPP9rrmRC4GiEBxX9Jc+SGj
         9sDMqMUQjrNmSJCmZ/72WgAhZ4B7IS8OIjsToG6AtT9PhgQTkqa5w7lDKCWFjTOKtZQe
         Y8AhjmBaZzjBubK5Y1TBIlaT3ZsRL39VTM9W6+sdOw1cyDUFG2KElRtxIHNKh7DBr901
         2h2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707148168; x=1707752968;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B5m1CgJAMOKsr19uagd18SS3wirrPMPgS0t3eQ8WQkw=;
        b=qjY/DxY0yLLKnUSazTwVD/MVp+iA29Vef1DgVL+8DTPIbOEyBTByHWHhGE4/zUBCSu
         tvU6HJ4gAIpuGWAvnGAU9KfqvHZ/ifPy2zredeVP2JoX9X6hG8gAvajebIJBPCuJEB/n
         9MuY7befrw7WZcyUNAYwK9BGhM2lrJ922CBrWzuVQgjt22LQG00KjWW8R5wAvtybpLRD
         h7EidtBKpkyu8q/35hS9EjroBBvBsPLgzULvnW7YZT5JczE2d3AkkYRtlR4pdl+TMOf+
         uX6DOSmiFe8KtuePOiUbnwr1cZdwRH+tjRjg5GpBolmiyv5dHdZaCoLHu5VMymDIM8iz
         srKw==
X-Gm-Message-State: AOJu0YwFzvJu9jTlEaRN0TsGZXRXKxSiWL2degmyAvcEtGntWh58EY27
	RSbu88QH3CPv9qOhseRS9MekHrBa7x5z7o+qt14JMLl8l+6CMh8VMiiVv6pmcebuPMw424Nhta7
	h1AnuUywp9LDvxJbhJlqQIzdoFss=
X-Google-Smtp-Source: AGHT+IGV8mt/jWGTvx1aYJq1bAvRgp53kQ/dZt7Cb6I8A3VP/JijwOEAxXq18u05RgtK5FdtR5GE48CHxq5pNtwQXe8=
X-Received: by 2002:a05:6a20:2a26:b0:19c:8ed9:7b94 with SMTP id
 e38-20020a056a202a2600b0019c8ed97b94mr14994829pzh.51.1707148168273; Mon, 05
 Feb 2024 07:49:28 -0800 (PST)
MIME-Version: 1.0
References: <17B101D76AF3A4FE.13964@lists.openembedded.org>
In-Reply-To: <17B101D76AF3A4FE.13964@lists.openembedded.org>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Mon, 5 Feb 2024 16:48:54 +0100
Message-ID: <CA+chaQe2amHEKYNv78Az5pfDBmvcoVY7BtCCcr+7tpfBgC6mSQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-diffsigs: fix walking the task
 dependencies and show better error
To: martin.jansa@gmail.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000002628ee0610a468d0"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 05 Feb 2024 15:49:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15826

--0000000000002628ee0610a468d0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The bitbake-diffsigs issue was introduced in:
https://git.openembedded.org/openembedded-core/commit/?id=3D8721c52041e910b=
d4d8a9235b52f274f4f02c8a3
other parts of the code were adapted to new find_siginfo code long time
ago, not sure why this one kept hiding.

On Mon, Feb 5, 2024 at 4:42=E2=80=AFPM Martin Jansa via lists.openembedded.=
org
<martin.jansa=3Dgmail.com@lists.openembedded.org> wrote:

> * when comparing 2 tmp/stamps/*do_configure.sigdata* I got
>   TypeError("filename must be a str or bytes object, or a file")
>   but both files I was comparing were
>   Zstandard compressed data (v0.8+), Dictionary ID: None
>   according to "file"
>
>   with TypeError catched to show which file it failed to open I got bette=
r
>   error which shows it was trying to read
> "do_prepare_recipe_sysroot.sigdata"
>   file now and after a while you might notice that it's not just the
> expected
>   file, but a dict with 'path', 'sstate', 'time'.
>
>   Fix that in bitbake-diffsigs but keep the TypeError and add OSError
>   in case it will eventually walk on file which isn't zstd compressed
>   pipecompress throws CompressionError.
>
> ERROR: Failed to open {'path':
> '5.15.do_prepare_recipe_sysroot.sigdata.99b12a401341a0df7c3553cb00c87a767=
4295496bd5c25ed71764ee0d0fb8eb8',
> 'sstate': False, 'time': 1707136354.991718}: filename must be a str or
> bytes object, or a file
> Traceback (most recent call last):
>   File "bitbake/bin/bitbake-diffsigs", line 192, in <module>
>     output =3D bb.siggen.compare_sigfiles(options.sigdatafile1,
> options.sigdatafile2, recursecb, color=3Dcolor)
>
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^
>   File "bitbake/lib/bb/siggen.py", line 1039, in compare_sigfiles
>     recout =3D recursecb(dep, a[dep], b[dep])
>              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "bitbake/bin/bitbake-diffsigs", line 102, in recursecb
>     out2 =3D bb.siggen.compare_sigfiles(hashfiles[hash1], hashfiles[hash2=
],
> recursecb, color=3Dcolor)
>
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^
>   File "bitbake/lib/bb/siggen.py", line 857, in compare_sigfiles
>     raise err
>   File "bitbake/lib/bb/siggen.py", line 853, in compare_sigfiles
>     with bb.compress.zstd.open(a, "rt", encoding=3D"utf-8", num_threads=
=3D1)
> as f:
>          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "bitbake/lib/bb/compress/zstd.py", line 12, in open
>     return bb.compress._pipecompress.open_wrap(ZstdFile, *args, **kwargs)
>            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "bitbake/lib/bb/compress/_pipecompress.py", line 59, in open_wrap
>     raise TypeError("filename must be a str or bytes object, or a file")
> TypeError: filename must be a str or bytes object, or a file
>
> * if I replace zstd file with just plaintext it fails with:
>   $ echo foo > foo
>   $ echo foo > bar
>   $ bitbake-diffsigs foo bar
>   zstd: /*stdin*\: unsupported format
>   ERROR: Process died with 1
>   sys:1: ResourceWarning: unclosed file <_io.BufferedReader name=3D'foo'>
>
>   with this change it shows the name of the file which it failed to
> uncompress:
>
>   $ bitbake-diffsigs foo bar
>   zstd: /*stdin*\: unsupported format
>   ERROR: Failed to open sigdata file 'foo': Process died with 1
>   ERROR: Process died with 1
>   sys:1: ResourceWarning: unclosed file <_io.BufferedReader name=3D'foo'>
> ---
>  bin/bitbake-diffsigs |  2 +-
>  lib/bb/siggen.py     | 24 ++++++++++++++++++------
>  2 files changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/bin/bitbake-diffsigs b/bin/bitbake-diffsigs
> index a8f49191b..8202c7862 100755
> --- a/bin/bitbake-diffsigs
> +++ b/bin/bitbake-diffsigs
> @@ -99,7 +99,7 @@ def recursecb(key, hash1, hash2):
>      elif hash2 not in hashfiles:
>          recout.append("Unable to find matching sigdata for %s with hash
> %s" % (key, hash2))
>      else:
> -        out2 =3D bb.siggen.compare_sigfiles(hashfiles[hash1],
> hashfiles[hash2], recursecb, color=3Dcolor)
> +        out2 =3D bb.siggen.compare_sigfiles(hashfiles[hash1]['path'],
> hashfiles[hash2]['path'], recursecb, color=3Dcolor)
>          for change in out2:
>              for line in change.splitlines():
>                  recout.append('    ' + line)
> diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
> index 5a584cadf..58854aee7 100644
> --- a/lib/bb/siggen.py
> +++ b/lib/bb/siggen.py
> @@ -849,10 +849,18 @@ def compare_sigfiles(a, b, recursecb=3DNone,
> color=3DFalse, collapsed=3DFalse):
>          formatparams.update(values)
>          return formatstr.format(**formatparams)
>
> -    with bb.compress.zstd.open(a, "rt", encoding=3D"utf-8", num_threads=
=3D1)
> as f:
> -        a_data =3D json.load(f, object_hook=3DSetDecoder)
> -    with bb.compress.zstd.open(b, "rt", encoding=3D"utf-8", num_threads=
=3D1)
> as f:
> -        b_data =3D json.load(f, object_hook=3DSetDecoder)
> +    try:
> +        with bb.compress.zstd.open(a, "rt", encoding=3D"utf-8",
> num_threads=3D1) as f:
> +            a_data =3D json.load(f, object_hook=3DSetDecoder)
> +    except (TypeError, OSError) as err:
> +        bb.error("Failed to open sigdata file '%s': %s" % (a, str(err)))
> +        raise err
> +    try:
> +        with bb.compress.zstd.open(b, "rt", encoding=3D"utf-8",
> num_threads=3D1) as f:
> +            b_data =3D json.load(f, object_hook=3DSetDecoder)
> +    except (TypeError, OSError) as err:
> +        bb.error("Failed to open sigdata file '%s': %s" % (b, str(err)))
> +        raise err
>
>      for data in [a_data, b_data]:
>          handle_renames(data)
> @@ -1090,8 +1098,12 @@ def calc_taskhash(sigdata):
>  def dump_sigfile(a):
>      output =3D []
>
> -    with bb.compress.zstd.open(a, "rt", encoding=3D"utf-8", num_threads=
=3D1)
> as f:
> -        a_data =3D json.load(f, object_hook=3DSetDecoder)
> +    try:
> +        with bb.compress.zstd.open(a, "rt", encoding=3D"utf-8",
> num_threads=3D1) as f:
> +            a_data =3D json.load(f, object_hook=3DSetDecoder)
> +    except (TypeError, OSError) as err:
> +        bb.error("Failed to open sigdata file '%s': %s" % (a, str(err)))
> +        raise err
>
>      handle_renames(a_data)
>
> --
> 2.43.0
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15824):
> https://lists.openembedded.org/g/bitbake-devel/message/15824
> Mute This Topic: https://lists.openembedded.org/mt/104178376/3617156
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> martin.jansa@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--0000000000002628ee0610a468d0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">The bitbake-diffsigs issue was introduced in:<div><a href=
=3D"https://git.openembedded.org/openembedded-core/commit/?id=3D8721c52041e=
910bd4d8a9235b52f274f4f02c8a3">https://git.openembedded.org/openembedded-co=
re/commit/?id=3D8721c52041e910bd4d8a9235b52f274f4f02c8a3</a><br></div><div>=
other parts of the code were adapted to new=C2=A0find_siginfo code long tim=
e ago, not sure why this one kept hiding.</div></div><br><div class=3D"gmai=
l_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Feb 5, 2024 at 4:42=
=E2=80=AFPM Martin Jansa via <a href=3D"http://lists.openembedded.org">list=
s.openembedded.org</a> &lt;martin.jansa=3D<a href=3D"mailto:gmail.com@lists=
.openembedded.org">gmail.com@lists.openembedded.org</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">* when comparing 2 tmp/s=
tamps/*do_configure.sigdata* I got<br>
=C2=A0 TypeError(&quot;filename must be a str or bytes object, or a file&qu=
ot;)<br>
=C2=A0 but both files I was comparing were<br>
=C2=A0 Zstandard compressed data (v0.8+), Dictionary ID: None<br>
=C2=A0 according to &quot;file&quot;<br>
<br>
=C2=A0 with TypeError catched to show which file it failed to open I got be=
tter<br>
=C2=A0 error which shows it was trying to read &quot;do_prepare_recipe_sysr=
oot.sigdata&quot;<br>
=C2=A0 file now and after a while you might notice that it&#39;s not just t=
he expected<br>
=C2=A0 file, but a dict with &#39;path&#39;, &#39;sstate&#39;, &#39;time&#3=
9;.<br>
<br>
=C2=A0 Fix that in bitbake-diffsigs but keep the TypeError and add OSError<=
br>
=C2=A0 in case it will eventually walk on file which isn&#39;t zstd compres=
sed<br>
=C2=A0 pipecompress throws CompressionError.<br>
<br>
ERROR: Failed to open {&#39;path&#39;: &#39;5.15.do_prepare_recipe_sysroot.=
sigdata.99b12a401341a0df7c3553cb00c87a7674295496bd5c25ed71764ee0d0fb8eb8&#3=
9;, &#39;sstate&#39;: False, &#39;time&#39;: 1707136354.991718}: filename m=
ust be a str or bytes object, or a file<br>
Traceback (most recent call last):<br>
=C2=A0 File &quot;bitbake/bin/bitbake-diffsigs&quot;, line 192, in &lt;modu=
le&gt;<br>
=C2=A0 =C2=A0 output =3D bb.siggen.compare_sigfiles(options.sigdatafile1, o=
ptions.sigdatafile2, recursecb, color=3Dcolor)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^<br>
=C2=A0 File &quot;bitbake/lib/bb/siggen.py&quot;, line 1039, in compare_sig=
files<br>
=C2=A0 =C2=A0 recout =3D recursecb(dep, a[dep], b[dep])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^<br>
=C2=A0 File &quot;bitbake/bin/bitbake-diffsigs&quot;, line 102, in recursec=
b<br>
=C2=A0 =C2=A0 out2 =3D bb.siggen.compare_sigfiles(hashfiles[hash1], hashfil=
es[hash2], recursecb, color=3Dcolor)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^<br>
=C2=A0 File &quot;bitbake/lib/bb/siggen.py&quot;, line 857, in compare_sigf=
iles<br>
=C2=A0 =C2=A0 raise err<br>
=C2=A0 File &quot;bitbake/lib/bb/siggen.py&quot;, line 853, in compare_sigf=
iles<br>
=C2=A0 =C2=A0 with bb.compress.zstd.open(a, &quot;rt&quot;, encoding=3D&quo=
t;utf-8&quot;, num_threads=3D1) as f:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^<br>
=C2=A0 File &quot;bitbake/lib/bb/compress/zstd.py&quot;, line 12, in open<b=
r>
=C2=A0 =C2=A0 return bb.compress._pipecompress.open_wrap(ZstdFile, *args, *=
*kwargs)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^^^^^^^<br>
=C2=A0 File &quot;bitbake/lib/bb/compress/_pipecompress.py&quot;, line 59, =
in open_wrap<br>
=C2=A0 =C2=A0 raise TypeError(&quot;filename must be a str or bytes object,=
 or a file&quot;)<br>
TypeError: filename must be a str or bytes object, or a file<br>
<br>
* if I replace zstd file with just plaintext it fails with:<br>
=C2=A0 $ echo foo &gt; foo<br>
=C2=A0 $ echo foo &gt; bar<br>
=C2=A0 $ bitbake-diffsigs foo bar<br>
=C2=A0 zstd: /*stdin*\: unsupported format<br>
=C2=A0 ERROR: Process died with 1<br>
=C2=A0 sys:1: ResourceWarning: unclosed file &lt;_io.BufferedReader name=3D=
&#39;foo&#39;&gt;<br>
<br>
=C2=A0 with this change it shows the name of the file which it failed to un=
compress:<br>
<br>
=C2=A0 $ bitbake-diffsigs foo bar<br>
=C2=A0 zstd: /*stdin*\: unsupported format<br>
=C2=A0 ERROR: Failed to open sigdata file &#39;foo&#39;: Process died with =
1<br>
=C2=A0 ERROR: Process died with 1<br>
=C2=A0 sys:1: ResourceWarning: unclosed file &lt;_io.BufferedReader name=3D=
&#39;foo&#39;&gt;<br>
---<br>
=C2=A0bin/bitbake-diffsigs |=C2=A0 2 +-<br>
=C2=A0lib/bb/siggen.py=C2=A0 =C2=A0 =C2=A0| 24 ++++++++++++++++++------<br>
=C2=A02 files changed, 19 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/bin/bitbake-diffsigs b/bin/bitbake-diffsigs<br>
index a8f49191b..8202c7862 100755<br>
--- a/bin/bitbake-diffsigs<br>
+++ b/bin/bitbake-diffsigs<br>
@@ -99,7 +99,7 @@ def recursecb(key, hash1, hash2):<br>
=C2=A0 =C2=A0 =C2=A0elif hash2 not in hashfiles:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0recout.append(&quot;Unable to find matchi=
ng sigdata for %s with hash %s&quot; % (key, hash2))<br>
=C2=A0 =C2=A0 =C2=A0else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 out2 =3D bb.siggen.compare_sigfiles(hashfiles[=
hash1], hashfiles[hash2], recursecb, color=3Dcolor)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 out2 =3D bb.siggen.compare_sigfiles(hashfiles[=
hash1][&#39;path&#39;], hashfiles[hash2][&#39;path&#39;], recursecb, color=
=3Dcolor)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for change in out2:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for line in change.splitlin=
es():<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0recout.append=
(&#39;=C2=A0 =C2=A0 &#39; + line)<br>
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py<br>
index 5a584cadf..58854aee7 100644<br>
--- a/lib/bb/siggen.py<br>
+++ b/lib/bb/siggen.py<br>
@@ -849,10 +849,18 @@ def compare_sigfiles(a, b, recursecb=3DNone, color=3D=
False, collapsed=3DFalse):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0formatparams.update(values)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return formatstr.format(**formatparams)<b=
r>
<br>
-=C2=A0 =C2=A0 with bb.compress.zstd.open(a, &quot;rt&quot;, encoding=3D&qu=
ot;utf-8&quot;, num_threads=3D1) as f:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 a_data =3D json.load(f, object_hook=3DSetDecod=
er)<br>
-=C2=A0 =C2=A0 with bb.compress.zstd.open(b, &quot;rt&quot;, encoding=3D&qu=
ot;utf-8&quot;, num_threads=3D1) as f:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 b_data =3D json.load(f, object_hook=3DSetDecod=
er)<br>
+=C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with bb.compress.zstd.open(a, &quot;rt&quot;, =
encoding=3D&quot;utf-8&quot;, num_threads=3D1) as f:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 a_data =3D json.load(f, object_h=
ook=3DSetDecoder)<br>
+=C2=A0 =C2=A0 except (TypeError, OSError) as err:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.error(&quot;Failed to open sigdata file &#3=
9;%s&#39;: %s&quot; % (a, str(err)))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise err<br>
+=C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with bb.compress.zstd.open(b, &quot;rt&quot;, =
encoding=3D&quot;utf-8&quot;, num_threads=3D1) as f:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 b_data =3D json.load(f, object_h=
ook=3DSetDecoder)<br>
+=C2=A0 =C2=A0 except (TypeError, OSError) as err:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.error(&quot;Failed to open sigdata file &#3=
9;%s&#39;: %s&quot; % (b, str(err)))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise err<br>
<br>
=C2=A0 =C2=A0 =C2=A0for data in [a_data, b_data]:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0handle_renames(data)<br>
@@ -1090,8 +1098,12 @@ def calc_taskhash(sigdata):<br>
=C2=A0def dump_sigfile(a):<br>
=C2=A0 =C2=A0 =C2=A0output =3D []<br>
<br>
-=C2=A0 =C2=A0 with bb.compress.zstd.open(a, &quot;rt&quot;, encoding=3D&qu=
ot;utf-8&quot;, num_threads=3D1) as f:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 a_data =3D json.load(f, object_hook=3DSetDecod=
er)<br>
+=C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with bb.compress.zstd.open(a, &quot;rt&quot;, =
encoding=3D&quot;utf-8&quot;, num_threads=3D1) as f:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 a_data =3D json.load(f, object_h=
ook=3DSetDecoder)<br>
+=C2=A0 =C2=A0 except (TypeError, OSError) as err:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.error(&quot;Failed to open sigdata file &#3=
9;%s&#39;: %s&quot; % (a, str(err)))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise err<br>
<br>
=C2=A0 =C2=A0 =C2=A0handle_renames(a_data)<br>
<br>
-- <br>
2.43.0<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#15824): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/15824" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/15824</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/104178376/361=
7156" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/104178376/3617156</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:martin.jansa@gmail.com" target=3D"=
_blank">martin.jansa@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--0000000000002628ee0610a468d0--

