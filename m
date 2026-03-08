Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED804FCB63B
	for <webhook@archiver.kernel.org>; Sun,  8 Mar 2026 14:16:20 +0000 (UTC)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39370.1772979377199396495
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 08 Mar 2026 07:16:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=i8y3F/Ki;
 spf=pass (domain: gmail.com, ip: 209.85.160.179, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5090c7e9081so7193211cf.0
        for <bitbake-devel@lists.openembedded.org>; Sun, 08 Mar 2026 07:16:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1772979376; cv=none;
        d=google.com; s=arc-20240605;
        b=ecbdUPyFhvqjfdAFxeXRB81rmAey2ZZxBfiTAUQVTSueaWZTe9BdYMvVYiE7XKIZsn
         uO/uqTsXQYIpUvnB4Y0lEZLTEnF6QKCEL8etVTJFLOJwdpMGmCEw4+2BmIMMzpyQrsn/
         Bfma+Ck+xGIPwgGbx5XQm+vbEXsOaZRnyw2uDoA/lJwm0hQxCQqTejSBTBWbQBoRunav
         59wT9ffYV2tC89F3/gp3IW0Al1oBzkOb4q7gE583rmsTl3kynMUamrRMNwXgfItS6bE8
         THOHm++pN2ru4GO53GuQCt7E7ftvlTHUww5szMIa/wSoaumj6NdyWrA5SsdlteuS5LYX
         sDRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ryR26CuLWiqUAvguGgJLthJZUpskULqHHJDe1ZG6boY=;
        fh=1KDj+K9OrANCknrwOqS3xRhHIOGqxQtlibDmBngdm44=;
        b=J2bfBiUbZREAIxR7s/G7wYGIobc2F29TEwNvgQRoUTK2PGJu0U+TfWUsyIIIbyqYyj
         QGA/3GSi0tlRdZ8xR8L/Annqx5pybhzZGMTsMeAtyI7epBfvESVw4eo1gERqMzzaIfmr
         sdfQe5+k71MKyAQWDwIs+IRKFBTyuY3QCEbcTPqAA3HPT1gwvHIImkmkSJbPXO09Edmg
         T+ldl+wbDY3A7JHA5J3QNiXmi/8sD7atGNdlAc0Nsqv4MQ//a5vlWPMaA3h9jW2I63ul
         VdYkvDiRc11k2zeGryWdXnS6X/6GSiFpyWGnKn66uR3Nv8YKnHfxOt5HJjLKvCKztuF5
         QORA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772979376; x=1773584176; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ryR26CuLWiqUAvguGgJLthJZUpskULqHHJDe1ZG6boY=;
        b=i8y3F/KiRDdHOP+4ya913NQA8tjUEGKwCv8+RVvu9zSogQ4KhT/Dah9977iqQAnde+
         WHYDnl+c/QuyysuUi5EAmy3uhDLTvXZAb9N2Qyu7D6YoYBcsPii+M5mbSuNAJuIgmDcT
         iZQaLZtPovfVZfxA1RO29ImiHyg4GcAEsws9gt1c9zZGmLkG8gJcx/vvDMmZNphfeFZl
         MVtlCm7eDYV7IPWZEgOe7NQSwMIlz4Iz7KLoMPUKa8jQDssJw9ETLVUDtN0ppf+9Rrda
         gkBh37ja7knDClztN8m5JwuRRsEpy7BbHf0DrlO3l1FQ3jsYxDs0+3q84pG9YZIOKMCj
         OoPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772979376; x=1773584176;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ryR26CuLWiqUAvguGgJLthJZUpskULqHHJDe1ZG6boY=;
        b=SIx6uuZHXsp1KPf/gWwaAphT1eMIAAYY8IClzrWkDa1UfLcH7cdoKkU24Tj7WaXaM0
         /o4+tEMuVzQ/CZFXQ6FPr2NpKoQdnj8fLVPxsauIFIh8b26n0AgBjCKM5C9KuhT7A+G7
         RyKzH3RfVNweoQ4weldnSKxjSeHvw6drxnwDk93bai20WsifW5NPDzXNvtmWAjj7rD94
         /eZXUOW8JqdMuP+qa2vF6KTYn13cIepTfqGqRmgSG0Mz74lLkgtWQWmkRq2Il5Z0BuIK
         xEr0mZfKXxTp/9C0720sK4DR67oF/itCJicAgdQPS1QhMYBuEdhaviwZB3Xl11DfVWuV
         Keug==
X-Gm-Message-State: AOJu0YxG/0ebSmpRf0Uvc48fzp7AL1MxcnPYoR+4vwbZ6PxOrQnSxFYV
	poe4eu97z1xM8kv9LZ7DC0R16D9dZtRO3in2dkhQ8uqf64Jj0iByZKSqR6HGTi9Gpc4cqwh3WpV
	KfvyF6Yr4FyjChvQGpLJYq4XfY2L3dqI=
X-Gm-Gg: ATEYQzy2uDga/V9Va1EvAwlteiZocXtVPiFLZ/iyDH9Bh6/ka+t3d5Djnlvhy+NYBZx
	C0sOQlvXymsTNmJ9CQZbv3XsRluBzO0oPK3n8pobsEO8h9N3xh78lGr8E8khJlDPaD+MBm+Oi/W
	9UTIl65ND6rLdtVUqY3wnb31vwH9QUA6wIy24KA/HcBl2ixR48+AJbrrdcU5j/veEg5z0PEbvjc
	frcpJH+CySmMzEX8kd8Nf/jAh+qG4vBveSuwY1j6saIJ99Pa94tZn2V+lSNo5HtLEsOkuBUmgS3
	L4jypZwyoSVqPIOvcYdcXH5pu95hXw320rcStEMm
X-Received: by 2002:a05:622a:1991:b0:509:11c6:d687 with SMTP id
 d75a77b69052e-50911c6e555mr26963871cf.38.1772979376128; Sun, 08 Mar 2026
 07:16:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260305200937.221484-1-alex.kanavin@gmail.com> <189A0AE65037F048.1967085@lists.openembedded.org>
In-Reply-To: <189A0AE65037F048.1967085@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Sun, 8 Mar 2026 16:16:05 +0200
X-Gm-Features: AaiRm53P8Oy3JhU_7EQdE1jc7PU1--btn9B8-o2QlPXvHe-1oK6rQa-M2xsYlww
Message-ID: <CANNYZj8ne7Hi8QFRTt8GSE2gF6-bz_-Y+QJ-Z=qMP1qAoTK-cA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/2] bitbake-setup: correctly determine
 latest revision in status/update when it is fixed to a commit id
To: alex.kanavin@gmail.com
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: multipart/alternative; boundary="000000000000e8860e064c83ed27"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 08 Mar 2026 14:16:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19122

--000000000000e8860e064c83ed27
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please hold this, I=E2=80=99ll develop a better fix.

Alex

On Thu 5. Mar 2026 at 22.09, Alexander Kanavin via lists.openembedded.org
<alex.kanavin=3Dgmail.com@lists.openembedded.org> wrote:

> From: Alexander Kanavin <alex@linutronix.de>
>
> The code was relying on git fetcher's latest_revision() method,
> which works properly if the revision in the json config template
> is set to a branch or a tag, but does not work if it is set to
> a fixed revision (the method will return the latest revision on the
> respective branch, and bitbake-setup will incorrectly determine
> that the layer needs to be updated to that revision).
>
> Add a guard to check if revision is a commit id, and skip the
> check if so.
>
> [YOCTO #16190]
>
> Signed-off-by: Alexander Kanavin <alex@linutronix.de>
> ---
>  bin/bitbake-setup | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> index 1a42aaa51..69362b589 100755
> --- a/bin/bitbake-setup
> +++ b/bin/bitbake-setup
> @@ -741,9 +741,13 @@ def get_diff(file1, file2):
>      return None
>
>  def are_layers_changed(layers, layerdir, d):
> +    from bb.fetch2.git import sha1_re
> +
>      def _is_git_remote_changed(r_remote, repodir):
>          changed =3D False
>          rev =3D r_remote['rev']
> +        if sha1_re.match(rev):
> +            return False
>          branch =3D r_remote.get('branch', None)
>
>          remotes =3D _get_remotes(r_remote)
> --
> 2.47.3
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#19118):
> https://lists.openembedded.org/g/bitbake-devel/message/19118
> Mute This Topic: https://lists.openembedded.org/mt/118158860/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> alex.kanavin@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000e8860e064c83ed27
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Please hold this, I=E2=80=99ll develop a better fix.</div=
><div dir=3D"auto"><br></div><div dir=3D"auto">Alex</div><div><br><div clas=
s=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_att=
r">On Thu 5. Mar 2026 at 22.09, Alexander Kanavin via <a href=3D"http://lis=
ts.openembedded.org">lists.openembedded.org</a> &lt;alex.kanavin=3D<a href=
=3D"mailto:gmail.com@lists.openembedded.org">gmail.com@lists.openembedded.o=
rg</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;padding-l=
eft:1ex;border-left-color:rgb(204,204,204)">From: Alexander Kanavin &lt;<a =
href=3D"mailto:alex@linutronix.de" target=3D"_blank">alex@linutronix.de</a>=
&gt;<br>
<br>
The code was relying on git fetcher&#39;s latest_revision() method,<br>
which works properly if the revision in the json config template<br>
is set to a branch or a tag, but does not work if it is set to<br>
a fixed revision (the method will return the latest revision on the<br>
respective branch, and bitbake-setup will incorrectly determine<br>
that the layer needs to be updated to that revision).<br>
<br>
Add a guard to check if revision is a commit id, and skip the<br>
check if so.<br>
<br>
[YOCTO #16190]<br>
<br>
Signed-off-by: Alexander Kanavin &lt;<a href=3D"mailto:alex@linutronix.de" =
target=3D"_blank">alex@linutronix.de</a>&gt;<br>
---<br>
=C2=A0bin/bitbake-setup | 4 ++++<br>
=C2=A01 file changed, 4 insertions(+)<br>
<br>
diff --git a/bin/bitbake-setup b/bin/bitbake-setup<br>
index 1a42aaa51..69362b589 100755<br>
--- a/bin/bitbake-setup<br>
+++ b/bin/bitbake-setup<br>
@@ -741,9 +741,13 @@ def get_diff(file1, file2):<br>
=C2=A0 =C2=A0 =C2=A0return None<br>
<br>
=C2=A0def are_layers_changed(layers, layerdir, d):<br>
+=C2=A0 =C2=A0 from bb.fetch2.git import sha1_re<br>
+<br>
=C2=A0 =C2=A0 =C2=A0def _is_git_remote_changed(r_remote, repodir):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0changed =3D False<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rev =3D r_remote[&#39;rev&#39;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if sha1_re.match(rev):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return False<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0branch =3D r_remote.get(&#39;branch&#39;,=
 None)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0remotes =3D _get_remotes(r_remote)<br>
-- <br>
2.47.3<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#19118): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/19118" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/19118</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/118158860/168=
6489" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/118158860/1686489</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:alex.kanavin@gmail.com" target=3D"=
_blank">alex.kanavin@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--000000000000e8860e064c83ed27--

