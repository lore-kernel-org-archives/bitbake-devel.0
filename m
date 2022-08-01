Return-Path: <kergoth@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796BCC00144
	for <webhook@archiver.kernel.org>; Mon,  1 Aug 2022 21:05:46 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by mx.groups.io with SMTP id smtpd.web08.2860.1659387939842330492
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Aug 2022 14:05:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=a/PsLATG;
 spf=pass (domain: gmail.com, ip: 209.85.208.46, mailfrom: kergoth@gmail.com)
Received: by mail-ed1-f46.google.com with SMTP id z22so15324791edd.6
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Aug 2022 14:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2MV1wgVECXegcMDYuNyhx0x5/l0T08FpcWRxZhRHRLI=;
        b=a/PsLATGGfj3E0S7odD6/QH36znqbeq7Ripeoq+dGWgS/MMXWPITpusrVqPWOPktrE
         C61mjiNDaiK+6fcvWOaU598x+KoiPxg3QgL4f1wftL8gicwrtPB5udgYgrGpB87TCvX0
         aFlq970ESX5b1VcNieKRbggHW7GasC27lEGmBD3taJRd4cERdBgV3ANuD5HAtwS8Bicx
         EZYzAytPhqVGo5DPy/HxNhamTeXKU8r5ig63ft/f5aGP7uedu7CjpSLczaEsGCm1/SLl
         KBzi0qioOjRzrEJNG03VcxRJfDm6LPZUtP14HFR0CVY/v9wDPq6JxPHleRnZcI/vThUF
         t0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2MV1wgVECXegcMDYuNyhx0x5/l0T08FpcWRxZhRHRLI=;
        b=F9uReRcuWLc9E2B/iCwRJcqqVsSj2bOwYPb30GcyZT+I6O2ZqkTaVcvpV8cOULQEPp
         JrrWDMOSzr4EAYYA283xeYgT19NiKq1d9zFYfkMTFVfBqVHpjkUogknCWHBWJ4OZXRHL
         iDHhGaT7EALhTr4CA1G879sAGsZD3K8TBbFl2HtWeU9Ucnqk5RHqbN0XFPNp6ZfQPqG5
         W22I+VuaNuT7zf0L+iGVLaE9Q9ugOd64nfbemNO9OLKMnLkBQVax93pA/7AnRWMMUqy1
         J3sZmpa0cLly5YULP628R3sa/TffslGLVW2KmYOdBK0+Nsm2r+YkF7BCnu6558DQWB9N
         SgHQ==
X-Gm-Message-State: ACgBeo1cX8EYqsOYSHeCOUzEkTTytaFrxvo6cIhUUTLLDaAPVG8Tj1Pf
	NGPK/0vBI5yPMJZWABeqq/X8v7pBC3BGfRP8M+Q=
X-Google-Smtp-Source: 
 AA6agR597h++OOApEyZowJkivwQG5886nLG8nVnQI8DN0QGKj2UMAtuzTELujkLZGuCUzbox/FFeDZf3k6jsRCUimgw=
X-Received: by 2002:a05:6402:3220:b0:43d:ca4f:d2b9 with SMTP id
 g32-20020a056402322000b0043dca4fd2b9mr3980207eda.177.1659387938196; Mon, 01
 Aug 2022 14:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220801203418.57677-1-JPEWhacker@gmail.com>
In-Reply-To: <20220801203418.57677-1-JPEWhacker@gmail.com>
From: Christopher Larson <kergoth@gmail.com>
Date: Mon, 1 Aug 2022 14:05:27 -0700
Message-ID: 
 <CABcZANktQz6Lq0ou4mCFizyfanzabqOxhanr5NREb_rg-2o0dQ@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] siggen: Fix sigtask data not being renamed
 atomically
To: Joshua Watt <JPEWhacker@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000099d28905e5345c5b"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 01 Aug 2022 21:05:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13863

--00000000000099d28905e5345c5b
Content-Type: text/plain; charset="UTF-8"

Hmm, would it be better to os.chmod(fd, mode) rather than by filename,
since it's still open?

On Mon, Aug 1, 2022 at 1:34 PM Joshua Watt <JPEWhacker@gmail.com> wrote:

> Signature generation uses mkstemp() to get a file descriptor to a unique
> file and then write the signature into it, however it closed the file
> before doing the chmod() and rename() operations. Closing the file means
> that other mkstemp() could potentially open the same file and race with
> the chmod() and rename(), causing a error. While it may not sound like
> this would be very likely, glibc (at least) generates the filename for
> mkstemp() using the system clock, meaning that it is much more likely
> for highly parallel builds sharing sstate over NFS to encounter the race
> condition.
>
> To fix the problem, perform the chmod() and rename() while the file is
> still open, since this prevents other mkstemp() calls from being able to
> open the file (due to the O_EXCL flag).
>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>  bitbake/lib/bb/siggen.py | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
> index 3f3d6df54d..55f25235df 100644
> --- a/bitbake/lib/bb/siggen.py
> +++ b/bitbake/lib/bb/siggen.py
> @@ -426,18 +426,18 @@ class SignatureGeneratorBasic(SignatureGenerator):
>                  sigfile = sigfile.replace(self.taskhash[tid],
> computed_taskhash)
>
>          fd, tmpfile = tempfile.mkstemp(dir=os.path.dirname(sigfile),
> prefix="sigtask.")
> -        try:
> -            with bb.compress.zstd.open(fd, "wt", encoding="utf-8",
> num_threads=1) as f:
> +        with bb.compress.zstd.open(fd, "wt", encoding="utf-8",
> num_threads=1) as f:
> +            try:
>                  json.dump(data, f, sort_keys=True, separators=(",", ":"),
> cls=SetEncoder)
>                  f.flush()
> -            os.chmod(tmpfile, 0o664)
> -            bb.utils.rename(tmpfile, sigfile)
> -        except (OSError, IOError) as err:
> -            try:
> -                os.unlink(tmpfile)
> -            except OSError:
> -                pass
> -            raise err
> +                os.chmod(tmpfile, 0o664)
> +                bb.utils.rename(tmpfile, sigfile)
> +            except (OSError, IOError) as err:
> +                try:
> +                    os.unlink(tmpfile)
> +                except OSError:
> +                    pass
> +                raise err
>
>      def dump_sigfn(self, fn, dataCaches, options):
>          if fn in self.taskdeps:
> --
> 2.33.0
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13862):
> https://lists.openembedded.org/g/bitbake-devel/message/13862
> Mute This Topic: https://lists.openembedded.org/mt/92757646/3617123
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> kergoth@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

-- 
Christopher Larson
chris_larson@mentor.com, chris.larson@siemens.com, kergoth@gmail.com
Principal Software Engineer, Embedded Linux Solutions, Siemens Digital
Industries Software

--00000000000099d28905e5345c5b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hmm, would it be better to os.chmod(fd, mode) rather =
than by filename, since it&#39;s still open?</div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Aug 1, 2022 at 1:34 PM =
Joshua Watt &lt;<a href=3D"mailto:JPEWhacker@gmail.com">JPEWhacker@gmail.co=
m</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>Signature generation uses mkstemp() to get a file descriptor to a unique<b=
r>
file and then write the signature into it, however it closed the file<br>
before doing the chmod() and rename() operations. Closing the file means<br=
>
that other mkstemp() could potentially open the same file and race with<br>
the chmod() and rename(), causing a error. While it may not sound like<br>
this would be very likely, glibc (at least) generates the filename for<br>
mkstemp() using the system clock, meaning that it is much more likely<br>
for highly parallel builds sharing sstate over NFS to encounter the race<br=
>
condition.<br>
<br>
To fix the problem, perform the chmod() and rename() while the file is<br>
still open, since this prevents other mkstemp() calls from being able to<br=
>
open the file (due to the O_EXCL flag).<br>
<br>
Signed-off-by: Joshua Watt &lt;<a href=3D"mailto:JPEWhacker@gmail.com" targ=
et=3D"_blank">JPEWhacker@gmail.com</a>&gt;<br>
---<br>
=C2=A0bitbake/lib/bb/siggen.py | 20 ++++++++++----------<br>
=C2=A01 file changed, 10 insertions(+), 10 deletions(-)<br>
<br>
diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py<br>
index 3f3d6df54d..55f25235df 100644<br>
--- a/bitbake/lib/bb/siggen.py<br>
+++ b/bitbake/lib/bb/siggen.py<br>
@@ -426,18 +426,18 @@ class SignatureGeneratorBasic(SignatureGenerator):<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sigfile =3D s=
igfile.replace(self.taskhash[tid], computed_taskhash)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fd, tmpfile =3D tempfile.mkstemp(dir=3Dos=
.path.dirname(sigfile), prefix=3D&quot;sigtask.&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 with bb.compress.zstd.open(fd, &=
quot;wt&quot;, encoding=3D&quot;utf-8&quot;, num_threads=3D1) as f:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with bb.compress.zstd.open(fd, &quot;wt&quot;,=
 encoding=3D&quot;utf-8&quot;, num_threads=3D1) as f:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0json.dump(dat=
a, f, sort_keys=3DTrue, separators=3D(&quot;,&quot;, &quot;:&quot;), cls=3D=
SetEncoder)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.flush()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.chmod(tmpfile, 0o664)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.utils.rename(tmpfile, sigfile=
)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 except (OSError, IOError) as err:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.unlink(tmpfile)=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 except OSError:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pass<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise err<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.chmod(tmpfile, =
0o664)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.utils.rename(tm=
pfile, sigfile)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 except (OSError, IOError) as err=
:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.u=
nlink(tmpfile)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 except OSError:<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pass=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise err<br>
<br>
=C2=A0 =C2=A0 =C2=A0def dump_sigfn(self, fn, dataCaches, options):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if fn in self.taskdeps:<br>
-- <br>
2.33.0<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#13862): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/13862" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/13862</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/92757646/3617=
123" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/92757646/3617123</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:kergoth@gmail.com" target=3D"_blan=
k">kergoth@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div dir=3D"ltr"><font color=3D=
"#333333">Christopher Larson<br><a>chris_larson@mentor.com</a>,=C2=A0<a>chr=
is.larson@siemens.com</a>,=C2=A0<a>kergoth@gmail.com</a><br>Principal Softw=
are Engineer,=C2=A0Embedded Linux Solutions,=C2=A0Siemens Digital Industrie=
s Software</font><br></div></div></div></div>

--00000000000099d28905e5345c5b--

