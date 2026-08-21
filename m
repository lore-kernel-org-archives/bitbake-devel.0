Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EEFC5DF8C
	for <webhook@archiver.kernel.org>; Fri, 21 Aug 2026 21:29:37 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.871.1787347776400442228
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Aug 2026 14:29:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ekVEobpq;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493b966dd74so7029135e9.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 21 Aug 2026 14:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1787347774; x=1787952574; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nbiChZiWjPWabIydsOEx3EAG2l6BVzoi+EZ5H8Q3S04=;
        b=ekVEobpqvEPk75wFumwily3HTM9DnPh+HsFufzplRixIYIXER6+Seeq+BFWlRxyj0K
         BWgnCza/kUG9TnZYeNmvHYL3JsUFRRKWTrz7XARcLgaOio2NvOPhdEoqeUC/x/FtWnz4
         XHMhAiFTy1RkUqT1NZkd9RgsFmbXKJ1ZIk/aI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787347774; x=1787952574;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nbiChZiWjPWabIydsOEx3EAG2l6BVzoi+EZ5H8Q3S04=;
        b=AoBHFqwdkMtBiTMr2hb6yuwt4lrTUILgW/+ocgei/XS+4VJYt8Vq+lwUBvLdCgnJmL
         ShozzucMaYoCIUGXH3MbN5OcOPQuTV/gXHdPtrs08T0tQY1MLu/kb4ZcQpisbeOBtzyH
         AUL0XQMnFc2fspUKuhF7phMqnOD2AzPkEEoCVLJj5H1PNfl3ME3Mx951oGJf3c28qG4r
         TGH7M+lQv3qs39rd0KoraUBOtfQnNjSZtMHvsnkC0RPx3Iv1xcYSZxRg0FWLXiqunwnK
         0RfS+4INSxLazad9nMXxblohMNj36R0FhpsmnDjJwGGhs2/MF84HabyaazOlibqAlFNT
         Kaqg==
X-Forwarded-Encrypted: i=1; AHgh+Rp5UuqQd4FhWNwVL+0X9CfyijnuFqojOv3JGmFthdrr7P3U1XZKgCemg/JeKREJmhi527iM/Yh7/jF5Y4gc@lists.openembedded.org
X-Gm-Message-State: AFuF++n1kUzT0isO5w+ks0W2tmjKe1NBPLkSc2U7odEBh3cHWtKTOvkU
	nGn+fEp/0d2tVr9ueI87oxCx/ClW1LKTg0S3mBTJj9diUg+d3yRRBOye6l7ZfUWjzjQ=
X-Gm-Gg: AR+sD12Ofz6KvluDf0afgGmg5FapLoebcwX0RRIUeqR8iI9Srwk7ejoSI0fX5ZyCY5Y
	MMUOwhytQ2axI3Usqu5MmJKWFrgU82IrSQ34BHqwxmWAYEdLtQyo1UOLNgtTpgSfPjeCVhtH3lS
	hMfDCWcN4/mPRz0kjULNrLWhcON0jkDwfntcrrf7P943HnYGmQUkq7+1++5ChrtnHbi8/2S5EeS
	lp3gFjo1Zp4NcFUk6fPAIrZt+un3fmJO91h4Ir9b5COOqtl2Lw4NWGmPJZ/I6E3m3rJeck5Izc3
	dzjpqaNJGBuASNbYdyuON+Qbwc5a/Nf8Q9ZtOYZzRpn3RguVgdkZEICEk7/Du4KjmrPOl87yJ/G
	31iMBTfLtTStpuImN79OszoxXjvtfsa45aAS/3FqnEbiIqHMhK2xbx83lJXdOKBxbGu30XliVCT
	c0F4hpSlRczC9Wz8rl3mOzl94Sbk/hsv9adugJpaWEFF2uUH4CWt3kuBJ8ByOJHz+XW6ZIbDJYy
	PT3RQWDcGzGw8mlWuY9nTTWJW4Y+WalRID2eSsI+lPJhO150wGUMlTRlV+1uEHM
X-Received: by 2002:a05:600c:1909:b0:493:aa0a:45ad with SMTP id 5b1f17b1804b1-499c19bfd22mr11686525e9.2.1787347774462;
        Fri, 21 Aug 2026 14:29:34 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:e5fd:eed9:eff8:d030? ([2001:8b0:aba:5f3c:e5fd:eed9:eff8:d030])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482c9c0869bsm124290f8f.25.2026.08.21.14.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 14:29:32 -0700 (PDT)
Message-ID: <80f16c343f0b695970c6c93218e67eabd9648914.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] runqueue: Fix pending_hash_index not
 including taskname
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: chris.laplante@agilent.com, bitbake-devel@lists.openembedded.org
Date: Fri, 21 Aug 2026 22:29:30 +0100
In-Reply-To: <20260821204901.48802-1-chris.laplante@agilent.com>
References: <20260821204901.48802-1-chris.laplante@agilent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Aug 2026 21:29:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20016

On Fri, 2026-08-21 at 16:49 -0400, Chris Laplante via
lists.openembedded.org wrote:
> From: Chris Laplante <chris.laplante@agilent.com>
>=20
> The intention was probably not to use the literal string, "taskname"
>=20
> Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
> ---
> =C2=A0lib/bb/runqueue.py | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> index a4689e134..544081053 100644
> --- a/lib/bb/runqueue.py
> +++ b/lib/bb/runqueue.py
> @@ -84,7 +84,7 @@ def pending_hash_index(tid, rqdata):
> =C2=A0=C2=A0=C2=A0=C2=A0 (mc, fn, taskname, taskfn) =3D split_tid_mcfn(ti=
d)
> =C2=A0=C2=A0=C2=A0=C2=A0 pn =3D rqdata.dataCaches[mc].pkg_fn[taskfn]
> =C2=A0=C2=A0=C2=A0=C2=A0 h =3D rqdata.runtaskentries[tid].unihash
> -=C2=A0=C2=A0=C2=A0 return pn + ":" + "taskname" + h
> +=C2=A0=C2=A0=C2=A0 return pn + ":" + taskname + h
> =C2=A0
> =C2=A0class RunQueueStats:
> =C2=A0=C2=A0=C2=A0=C2=A0 """

Yes, that looks like a fun bug. Was that breaking multiconfig?

Cheers,

Richard

