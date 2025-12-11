Return-Path: <david.partain@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15A1D3E79C
	for <webhook@archiver.kernel.org>; Thu, 11 Dec 2025 07:02:30 +0000 (UTC)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2003.1765430165378225879
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Dec 2025 21:16:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=DzyWlkoL;
 spf=pass (domain: gmail.com, ip: 209.85.160.179, mailfrom: swami310@gmail.com)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4f1b4bb40aaso2814441cf.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 10 Dec 2025 21:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765430164; x=1766034964; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UGSu0k+HVHkQFYV8pEM8s9wK0PpYgp27jGMj2Xexkyo=;
        b=DzyWlkoLKWFDc3rAeJpXazYgntRY/DxKMHpCHNEDYOtUy9lOMajI5shQpnsB4XrUF/
         fS1lbells026Bxxfus6tzYxQHn6GBwfZRhD91FR+bdZN/FjaiEAkThG+BWiFqMrHvBZ3
         /j0ABmE6qzYWHF+BPt0UEvJekd+e11MxBJBz4VsCrhIjLaG8C9Z3Q64ZG3ziK36X1v3f
         FLnNT36nrm08afdFTnHrmN+Mz2ASeYHdcyl5ptZQlcaV+9b9CnAsqxiSIdrIIH8zhNTe
         G5eCZ2tbIa30vq+M6nAqHXbKzenngxAt5Us47zer23IpyY0MuQPgYakOdcw1QZfuVUvq
         Urcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765430164; x=1766034964;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UGSu0k+HVHkQFYV8pEM8s9wK0PpYgp27jGMj2Xexkyo=;
        b=xOkS6mI9tX6XWPg6yh7294MD1wxs4y7uvaIUAuj+4yFrji5pURciKelZm6yOPz24VC
         TZZOg5oMZUo/fVFW7mdGFz8hD1/AEnq+IPhkMrjhyR4yzCwDkxTOUy+pbOOzpZ+xejRr
         3kESikm+NnTSwI2/RFZARWUrjM1cpo7rzafBEfMrLozdNsw0l6qosgkeotr8r/xhjm0n
         1CKfZW9A8pkeR/wLfJWlsMFUS85aFPXDPrF0y/A0VjxcGpXKP0a3YFsWqnwDj1WTW6Jv
         wHqX5YQLdyy2WWJy9zlnc1JDpUKijOZz/9r7Yo2eSY/Ci4UQDPi2aezqCJPrQ+bOB3EU
         pv2Q==
X-Gm-Message-State: AOJu0Yy5L7beJ28rzOMiBAKlD87GtNEGi81uWIEtoQZrthnT8meQEmT9
	VWHnlVLmUbhlTl3IhJfHImexWjANSjaXiNeSqHBdgyQp42LcBjNQBUpg9ncvE6AfjKFeZ2IO7PM
	psosy8+hTW424Xq6wrrvj3jNjTyxilBFczQ==
X-Gm-Gg: AY/fxX6SmIqbdw3/lk+6Clp5CL26n6kRUZEEEvx4MEB9wqsNtePZXY0yG3/kZ+qUCd4
	jISpN+xlsbXBYFUP4W0xUnxi6zMnbxezhitxWL1Ypk9C08cvVHFTSNqJig9zk3RnSHhudCtiqpi
	vaElZZdWXJ1zs/e0aGwgTn8BIDUisSn2gwkMdIao8SM1ivziL2Z8Do7DI6iS3rEADUDkt/C7Pyh
	NdMJOPYb7qkBjdq58p3c7JxACfwMKhOHk8wpJvsznIeUzR1T9VMVcUIoa/BmiuIAnjxQc8pxt9H
	NYa/jg==
X-Google-Smtp-Source: AGHT+IErmHyHF4/qWTnH6V7fOMaD9U7CantQf3qDjPRUX2u7aCVR97UN6dkyNdn+2bS1UEuhipvDgDkHVXewyPcMw5c=
X-Received: by 2002:a05:622a:546:b0:4ee:4128:bebb with SMTP id
 d75a77b69052e-4f1b19f537fmr68947201cf.24.1765430163992; Wed, 10 Dec 2025
 21:16:03 -0800 (PST)
MIME-Version: 1.0
References: <20251205234033.6363-1-swami310@gmail.com>
In-Reply-To: <20251205234033.6363-1-swami310@gmail.com>
From: "Swami" <swami310@gmail.com>
Date: Thu, 11 Dec 2025 10:45:52 +0530
X-Gm-Features: AQt7F2quirkFNbB4U3b-cLwG5R3vtzULA99zci4DjQRncPMpIxtZNJgSZ-nzJQA
Message-ID: <CA+-_CqnqT4roapfisF_6gt2P-OJ8gkw9GvRNEnWh9FQX6HU7Sw@mail.gmail.com>
Subject: Re: [PATCH v7] bitbake-user-manual: Document BB_CMDLINE
To: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org
Cc: michael.opdenacker@rootcommit.com
Content-Type: multipart/alternative; boundary="000000000000ccf35b0645a63d38"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Dec 2025 07:02:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18561

--000000000000ccf35b0645a63d38
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
I have not heard anything after I submitted Patch V7. Is it accepted ?
How can I know the latest status ?
Please help me understand.

regards
Swami

On Sat, Dec 6, 2025 at 5:11=E2=80=AFAM Swami <swami310@gmail.com> wrote:

> Add documentation for the internal read-only variable :term:`BB_CMDLINE`.
>
> Fixes [YOCTO #15746]
>
> Signed-off-by: Swaminathan K <swami310@gmail.com>
> ---
>  doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rs=
t
> b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index 734c7858a..32860ec0c 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -116,6 +116,10 @@ overview of their function and contents.
>        Specifies if SSL certificates should be checked when fetching. The
> default
>        value is ``1`` and certificates are not checked if the value is se=
t
> to ``0``.
>
> +   :term:`BB_CMDLINE`
> +      :term:`BB_CMDLINE` is an internal variable and is read-only. It
> captures
> +      the exact command line used for the current invocation of BitBake.
> +
>     :term:`BB_HASH_CODEPARSER_VALS`
>        Specifies values for variables to use when populating the
> codeparser cache.
>        This can be used selectively to set dummy values for variables to
> avoid
>

--000000000000ccf35b0645a63d38
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi,</div><div>I have not heard anyth=
ing after I submitted Patch V7. Is it accepted ?=C2=A0 How=C2=A0can I know =
the latest status ?</div><div>Please help me understand.</div><div><br></di=
v><div>regards</div><div>Swami</div></div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Dec 6, 20=
25 at 5:11=E2=80=AFAM Swami &lt;<a href=3D"mailto:swami310@gmail.com">swami=
310@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">Add documentation for the internal read-only variable :term:`B=
B_CMDLINE`.<br>
<br>
Fixes [YOCTO #15746]<br>
<br>
Signed-off-by: Swaminathan K &lt;<a href=3D"mailto:swami310@gmail.com" targ=
et=3D"_blank">swami310@gmail.com</a>&gt;<br>
---<br>
=C2=A0doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 4 +++=
+<br>
=C2=A01 file changed, 4 insertions(+)<br>
<br>
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst =
b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst<br>
index 734c7858a..32860ec0c 100644<br>
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst<br>
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst<br>
@@ -116,6 +116,10 @@ overview of their function and contents.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Specifies if SSL certificates should be checked =
when fetching. The default<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0value is ``1`` and certificates are not checked =
if the value is set to ``0``.<br>
<br>
+=C2=A0 =C2=A0:term:`BB_CMDLINE`<br>
+=C2=A0 =C2=A0 =C2=A0 :term:`BB_CMDLINE` is an internal variable and is rea=
d-only. It captures<br>
+=C2=A0 =C2=A0 =C2=A0 the exact command line used for the current invocatio=
n of BitBake.<br>
+<br>
=C2=A0 =C2=A0 :term:`BB_HASH_CODEPARSER_VALS`<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Specifies values for variables to use when popul=
ating the codeparser cache.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0This can be used selectively to set dummy values=
 for variables to avoid<br>
</blockquote></div></div>

--000000000000ccf35b0645a63d38--

