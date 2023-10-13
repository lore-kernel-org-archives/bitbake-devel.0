Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A45BCDB47E
	for <webhook@archiver.kernel.org>; Fri, 13 Oct 2023 20:41:33 +0000 (UTC)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
 by mx.groups.io with SMTP id smtpd.web10.49569.1697229687850452321
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 13 Oct 2023 13:41:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=V4EHSR6D;
 spf=pass (domain: gmail.com, ip: 209.85.219.182, mailfrom: ticotimo@gmail.com)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-d9a6b21d1daso2844587276.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 13 Oct 2023 13:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697229687; x=1697834487; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k5cxmYF6LnPBV81F/sEdS3dLcFP0tPLEr232MlStCWM=;
        b=V4EHSR6D4z4jdvHnQAzYXItyjYOTgIv612oMaAQvZOhNQQyVuSVqPaQp3Dmzv8oz8v
         iuRP0ljs4GwNEZ1A+hloPupXtFvOxYcV1B8z7M5BHn6NpsDnTVKmCRZ3YXIR+/FhHVRg
         TCnrJAVCsKcmF/4iM/lLkgU78DcsRBZccYYdan60DwOwYJzqoCBidJURsXE6yvk1xuNx
         XjBkDL2wqs1idg7vl625A6pfhEhuIRfuKpjGqLhx6pG2x0V4NGKPbauEohhk90+jAwms
         VBSORJ/7LlDMLlKTeVM3/wIYlqW9dY/kzo5+EtHp7ZQmAdxgRl4pGxux3wGW/aO51If4
         zumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697229687; x=1697834487;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k5cxmYF6LnPBV81F/sEdS3dLcFP0tPLEr232MlStCWM=;
        b=MGWwQnDqBPVkFxcyRjiYeEXn5tGiocUOyzV6cj834Zvs4Kbr+Cd954rVad436yaGal
         KoP/19szGub+oPRIxDMJD8gMQE+WzV7+1toYxNjFjN9Jathnd+1kfAylNLEwUQwG6Qpz
         jCiZ4nKXplXnuJks3MNLJTOp/HqBwto1RV68eBZzTEoBBE6TX/sjbEIBXuXEALfEUQTG
         +J4M0l4l8GGOlACOn/2wIRwMM+XKVv0o7qpBYgyOSUclG3NiTMG+/hB6iqMBdS6e2tI/
         w7j6+N7MoLbqIXKkVmGCWfRhHcLnkBSdkPWWK5DTId/9921pq1+tGxs/6qC/gY10b1PG
         D3JA==
X-Gm-Message-State: AOJu0Yxv4uMhFeoHEIGVXj4rXvEZETPDzayXcldz34dBXOp+SdiTNZtr
	2z3YLWT9TKuoSWSQFel9DoqReZxskONIqj0v8KmFiehguvw=
X-Google-Smtp-Source: AGHT+IGSMMMAd7MBejkFraNPvVQo6maToZcLGoeolZsUrjBSrSJ4gAADX20DIOWsAsd5YM/OF66bQSOgo6RcRTFTKHo=
X-Received: by 2002:a05:6902:348:b0:d89:5638:8bb7 with SMTP id
 e8-20020a056902034800b00d8956388bb7mr24686589ybs.20.1697229686861; Fri, 13
 Oct 2023 13:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20231012233918.1209234-1-alassane.yattara@savoirfairelinux.com>
In-Reply-To: <20231012233918.1209234-1-alassane.yattara@savoirfairelinux.com>
From: Tim Orling <ticotimo@gmail.com>
Date: Fri, 13 Oct 2023 13:41:15 -0700
Message-ID: <CANx9H-Andnpj5Ni=6JO44McrTU5QPt=APfL0fPB2RtVYUKs4EA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] Update toaster-requirements to add django-log-viewer==1.1.7
To: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000096773406079f1422"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 13 Oct 2023 20:41:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15241

--00000000000096773406079f1422
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

In the future, for a follow on patch, please use [PATCH v2]
https://docs.yoctoproject.org/contributor-guide/submit-changes.html#taking-=
patch-review-into-account


On Thu, Oct 12, 2023 at 4:39=E2=80=AFPM Alassane Yattara <
alassane.yattara@savoirfairelinux.com> wrote:

> Django Log Viewer allows us to read & download log files
> in the admin page by using DataTables
>
> Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
>
Reviewed-by: Tim Orling <tim.orling@konsulko.com>
Tested-by: Tim Orling <tim.orling@konsulko.com>

> ---
>  toaster-requirements.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/toaster-requirements.txt b/toaster-requirements.txt
> index c1f433f9..d8e48b7f 100644
> --- a/toaster-requirements.txt
> +++ b/toaster-requirements.txt
> @@ -1,3 +1,4 @@
>  Django>4.2,<4.3
>  beautifulsoup4>=3D4.4.0
>  pytz
> +django-log-viewer=3D=3D1.1.7
> --
> 2.34.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15237):
> https://lists.openembedded.org/g/bitbake-devel/message/15237
> Mute This Topic: https://lists.openembedded.org/mt/101927305/924729
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> ticotimo@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--00000000000096773406079f1422
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">In the future, for a follow on patch, ple=
ase use [PATCH v2]</div><div dir=3D"ltr"><a href=3D"https://docs.yoctoproje=
ct.org/contributor-guide/submit-changes.html#taking-patch-review-into-accou=
nt">https://docs.yoctoproject.org/contributor-guide/submit-changes.html#tak=
ing-patch-review-into-account</a><br></div><div dir=3D"ltr"><br></div><br><=
div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct=
 12, 2023 at 4:39=E2=80=AFPM Alassane Yattara &lt;<a href=3D"mailto:alassan=
e.yattara@savoirfairelinux.com">alassane.yattara@savoirfairelinux.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Django=
 Log Viewer allows us to read &amp; download log files<br>
in the admin page by using DataTables<br>
<br>
Signed-off-by: Alassane Yattara &lt;<a href=3D"mailto:alassane.yattara@savo=
irfairelinux.com" target=3D"_blank">alassane.yattara@savoirfairelinux.com</=
a>&gt;<br></blockquote><div>Reviewed-by: Tim Orling &lt;<a href=3D"mailto:t=
im.orling@konsulko.com">tim.orling@konsulko.com</a>&gt;</div><div>Tested-by=
: Tim Orling &lt;<a href=3D"mailto:tim.orling@konsulko.com">tim.orling@kons=
ulko.com</a>&gt;=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
---<br>
=C2=A0toaster-requirements.txt | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/toaster-requirements.txt b/toaster-requirements.txt<br>
index c1f433f9..d8e48b7f 100644<br>
--- a/toaster-requirements.txt<br>
+++ b/toaster-requirements.txt<br>
@@ -1,3 +1,4 @@<br>
=C2=A0Django&gt;4.2,&lt;4.3<br>
=C2=A0beautifulsoup4&gt;=3D4.4.0<br>
=C2=A0pytz<br>
+django-log-viewer=3D=3D1.1.7<br>
-- <br>
2.34.1<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#15237): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/15237" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/15237</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/101927305/924=
729" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/101927305/924729</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:ticotimo@gmail.com" target=3D"_bla=
nk">ticotimo@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--00000000000096773406079f1422--

