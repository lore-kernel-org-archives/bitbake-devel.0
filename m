Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78557C6379F
	for <webhook@archiver.kernel.org>; Fri, 17 Feb 2023 12:28:13 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web10.5265.1676636888894758486
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Feb 2023 04:28:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=R1PYd9rP;
 spf=pass (domain: gmail.com, ip: 209.85.128.53, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f53.google.com with SMTP id z12-20020a1c4c0c000000b003e21e018039so2319463wmf.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 17 Feb 2023 04:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n7eH85aYn4sMdfQhh02wvtYGrVB9ngn5ArFaVU9uGok=;
        b=R1PYd9rPmIQ2/qF0mleDZ7CObFcJ4xaBRNtwv9uowcHjizqQ1VleqELBZYSbhKlAN8
         GC1qp++TX4XyeE9I5YMJPvawSLL8W+Ywp4kdT5DCkp8h3SpQor/dTjZT20Ti+au+3T8e
         aw+bocKs0lftd0V/RQCLS7MlrkGnvr2tAwpoUgSfvYgvOcVI62tXbs13nSXadDGkF9ys
         0Cow1RlD7mV1JYVUpkEMO2HGrQyUK0Q5ZQJMV735dnlaNITUK5NfDNqhK2/TpuPzN5R7
         6Vb1siLbMJeibUAxi+cmkHU8WudIgxbQCaSENfaICUDIzxFt0m10WNntvHW8Yj33y9zo
         5AEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n7eH85aYn4sMdfQhh02wvtYGrVB9ngn5ArFaVU9uGok=;
        b=f9djLhIpDgRuZF0etNTf/bd6Ote89G/IuCMPvxdkWwRS8m/qUHaJelFKqUFdO9lWa3
         2RjaA8t8gxENjoWPuloEjj0yoOlqCR1TmBtOwM32lU3ytWhZCYdMDRRPGmJT69lvIHeB
         ofj+MP/OAcMLcCKKEiWfUoW6sLS0oCoXq2I5HoVLz+i/x9bgweU9eWW/QI+3wcQEfPuW
         zOaxathJEAPhd7OcAYWbzwQfjGX80n6OyDy3lds7U6jVOZCfYt/+K80w+ENagC5sIgjl
         TrVhjYBWH/T87MD4sx3bTpOcci0+X+gpvd1Ok8/2PeAveXpjeAjdi3nWigQhaZuPN8B5
         2SvA==
X-Gm-Message-State: AO0yUKVUvGb/hFGdlkk4HG8lwPDVv0Uw1jF+kpfhmy3fWna/ZhRkZzRf
	UQDEbcg5Rk70cQbE6O7/OHZVE9WRoIIHDJ4ML2elAK+f
X-Google-Smtp-Source: AK7set9FZO/2RKtNNlu4ZaUrISC4Ur37fF+63+wgRboC9m4Ot+KaPRdCLnBtDBasiapqGFusxXiKnJldzc2ZReC2RzQ=
X-Received: by 2002:a05:600c:1e85:b0:3dc:546c:b2ec with SMTP id
 be5-20020a05600c1e8500b003dc546cb2ecmr537908wmb.32.1676636887093; Fri, 17 Feb
 2023 04:28:07 -0800 (PST)
MIME-Version: 1.0
References: <20230217122725.3637432-1-Martin.Jansa@gmail.com>
In-Reply-To: <20230217122725.3637432-1-Martin.Jansa@gmail.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Fri, 17 Feb 2023 13:27:51 +0100
Message-ID: <CA+chaQcSQmOKSThC=TUkniqMcUri5j4zvN13mRyEBFZtsNYjqg@mail.gmail.com>
Subject: Re: [1.46][PATCH] bitbake-worker: show debug output when network is enabled
To: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000001295b005f4e47274"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Feb 2023 12:28:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14452

--0000000000001295b005f4e47274
Content-Type: text/plain; charset="UTF-8"

Sorry, wrong patch was sent, ignore this one.

On Fri, Feb 17, 2023 at 1:27 PM Martin Jansa <martin.jansa@gmail.com> wrote:

> Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
> ---
>  bin/bitbake-worker | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/bin/bitbake-worker b/bin/bitbake-worker
> index d743ff510..09e486f7e 100755
> --- a/bin/bitbake-worker
> +++ b/bin/bitbake-worker
> @@ -275,6 +275,8 @@ def fork_off_task(cfg, data, databuilder, workerdata,
> extraconfigdata, runtask):
>                          bb.utils.disable_network(uid, gid)
>                      else:
>                          logger.debug("Skipping disable network for %s
> since %s is not a local uid." % (taskname, uid))
> +                else:
> +                    logger.debug("Skipping disable network for %s since
> network varFlag is set to %s." % (taskname, the_data.getVarFlag(taskname,
> 'network')))
>
>                  # exported_vars() returns a generator which *cannot* be
> passed to os.environ.update()
>                  # successfully. We also need to unset anything from the
> environment which shouldn't be there
> --
> 2.39.2
>
>

--0000000000001295b005f4e47274
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Sorry, wrong patch was sent, ignore this one.</div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 1=
7, 2023 at 1:27 PM Martin Jansa &lt;<a href=3D"mailto:martin.jansa@gmail.co=
m">martin.jansa@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">Signed-off-by: Martin Jansa &lt;<a href=3D"mailto:=
Martin.Jansa@gmail.com" target=3D"_blank">Martin.Jansa@gmail.com</a>&gt;<br=
>
---<br>
=C2=A0bin/bitbake-worker | 2 ++<br>
=C2=A01 file changed, 2 insertions(+)<br>
<br>
diff --git a/bin/bitbake-worker b/bin/bitbake-worker<br>
index d743ff510..09e486f7e 100755<br>
--- a/bin/bitbake-worker<br>
+++ b/bin/bitbake-worker<br>
@@ -275,6 +275,8 @@ def fork_off_task(cfg, data, databuilder, workerdata, e=
xtraconfigdata, runtask):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0bb.utils.disable_network(uid, gid)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0logger.debug(&quot;Skipping disable network for %s since %=
s is not a local uid.&quot; % (taskname, uid))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 logg=
er.debug(&quot;Skipping disable network for %s since network varFlag is set=
 to %s.&quot; % (taskname, the_data.getVarFlag(taskname, &#39;network&#39;)=
))<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# exported_va=
rs() returns a generator which *cannot* be passed to os.environ.update() <b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# successfull=
y. We also need to unset anything from the environment which shouldn&#39;t =
be there <br>
-- <br>
2.39.2<br>
<br>
</blockquote></div>

--0000000000001295b005f4e47274--

