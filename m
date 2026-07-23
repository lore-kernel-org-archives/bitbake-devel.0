Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7DBC4453E
	for <webhook@archiver.kernel.org>; Thu, 23 Jul 2026 06:06:28 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17766.1784786778298853119
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Jul 2026 23:06:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=CFOsdkoq;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4798bea72f9so133100f8f.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 22 Jul 2026 23:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1784786776; x=1785391576; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u23gj8qlKECEjihf5vrqmcdU6FD9eP6uIeBqoC0kX30=;
        b=CFOsdkoquVeDfZ0H4r1Tk9CvPV+SO3BSayRUAQkPy2/093hOTXM/ypFp/Id03xcbc+
         jSZUfUXAKkvD8trZPE9eyco7C0GxsUJHCcwhwf1jK0JNsPE0nuenAQzriitDLmA4osJT
         vUgwdjb+0M4zAQ4AnXn598TUaH4RdCT/uFsAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784786776; x=1785391576;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u23gj8qlKECEjihf5vrqmcdU6FD9eP6uIeBqoC0kX30=;
        b=SCyek4a8zTt4f5aJBP3JZlHIuq7NbaNQ94Y7WZOpJ7ltO/qtIszJn69oQsVKJZvjY5
         FhUOHAxwaeyv9YR/K/q26K2aM2q6qAre+YB/Sb5tI53c5X90pL5zY+BmhqnuDYF8kKHW
         tCqnt31R4vCNxYQ27CrE0x6QZN3cQ3JMg2xV7vaTPUMVZTK0ses4AplcE8zeufeTpUKm
         lguARSx6FihTGCR5NcM37T4BX42fvIU/lytAVG1AIMaTBftEgbo2eu7pN7wyi5Ab8jWA
         S+SlX8Ajne+BxqLzerl+z6JbxhNg+tFNLX4uKPcZ7mwkkvHKML2dRaEXoXUau0mYS5MK
         HtUA==
X-Forwarded-Encrypted: i=1; AHgh+RocRGWMtInVu4512+0Q5osq8jfsBJJhpPuVb3UGZ8wcSvTNrY7RqO4gRofKmkhuDmTrJJwmRxvS6jtxo46/@lists.openembedded.org
X-Gm-Message-State: AOJu0Yz+2gTY5zrnYFVbSiujeaWfglKlYBNpI2a2jrcKuX1ij9cYl202
	m/ZFEQNTXsw6tkE4SC380YQs4BDAQmqN9yXTCJ5yeCEayvomaFUzCvvrm3hZuC6bm5dBRCOd6oU
	WXjM9UNI=
X-Gm-Gg: AR+sD10nSRjuzMexKh8EENwsxplf3wQ7jFRSWfdw6XdnduOFp+t7XeFwEYz6aLiJG1S
	9XFC1Z4cMceMgIHM284v9K5OBylMn9azIsnIVexZms/yD8EVnognuOEeSfeSR1IOZtHqDnmYEdP
	RQCsA2TouvJqNNyJ8vU0bTh9vtsVwE046xeEF7KAWeXTuItdWhcVpALyW/aBGBNTI5sdSfbKoKQ
	o3vAXHD4WPcqG2x/jpcIzRV2P8stvrW3qeT0dOByy4+31EZoB+Hiqq42JIZj0G0xmMrxncx/CVv
	rWw++Q/JeAWP6o3IAx29xf6KSaX8jq4sOOXs+ok4hDRELMWW7IHHIy4GQGpYx2HNWFi+QfJbnA5
	Cc0yIia0oYIchPYR/jkLKGj4xoprWuftc9bsQpyeH1uMHMVPFfYHFEdbrbQ3MYE4GTGR5YKztfW
	zMHyBNa0btoFsMORUZjKBITF31xo1/dihIoSnzlraLt+0XqHZz7+MLCieRWP3G+o+uX+Y=
X-Received: by 2002:a05:6000:288a:b0:462:e086:35f with SMTP id ffacd0b85a97d-47f8da6663fmr1844960f8f.21.1784786776039;
        Wed, 22 Jul 2026 23:06:16 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:2205:d253:2df6:b9d5? ([2001:8b0:aba:5f3c:2205:d253:2df6:b9d5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f8fd04192sm3352575f8f.26.2026.07.22.23.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 23:06:15 -0700 (PDT)
Message-ID: <859e14e2c6da1c914ae3ec7f2c2065424cde8f10.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [2.18][PATCH] bitbake-worker: Evaluate
 exported_vars() before emptying the environment
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: amery@apptly.co, bitbake-devel@lists.openembedded.org
Date: Thu, 23 Jul 2026 07:06:13 +0100
In-Reply-To: <20260720195834.2496647-1-amery@apptly.co>
References: <20260720195834.2496647-1-amery@apptly.co>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 23 Jul 2026 06:06:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19848

On Mon, 2026-07-20 at 19:58 +0000, Alejandro Mery via lists.openembedded.or=
g wrote:
> exported_vars() returns a lazy generator. It was bound before
> empty_environment() cleared the process environment and only iterated
> afterwards, so any datastore expansion deferred until iteration ran with
> PATH already wiped.
>=20
> Recipes whose exported variables expand a command during that loop hit
> this. A gitver-style PV such as "${@get_git_pv(d, ...)}" runs git while
> PATH is empty, so the git wrapper on PATH is bypassed and the real git
> runs directly. Under pseudo this fakes uid 0 against a repository owned
> by the real user, and git aborts with "detected dubious ownership",
> failing do_package intermittently (only on reparse, when the value is
> re-expanded rather than served from cache).
>=20
> Materialise the generator into a list before emptying the environment so
> every expansion happens while PATH is still intact.
>=20
> Signed-off-by: Alejandro Mery <amery@apptly.co>
> ---
> =C2=A0bin/bitbake-worker | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/bin/bitbake-worker b/bin/bitbake-worker
> index aa14ef191..0db1531e0 100755
> --- a/bin/bitbake-worker
> +++ b/bin/bitbake-worker
> @@ -290,7 +290,7 @@ def fork_off_task(cfg, data, databuilder, workerdata,=
 extraconfigdata, runtask):
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 # exported_vars() returns a generator which *canno=
t* be passed to os.environ.update()=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 # successfully. We also need to unset anything fro=
m the environment which shouldn't be there=20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 exports =3D bb.data.exported_vars(the_data)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 exports =3D list(bb.data.exported_vars(the_data))
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 bb.utils.empty_environment()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 for e, v in exports:

Thanks for this. Nice work in tracking it down!

I think in this case we need a couple of things, firstly will be a bit
more explination in the code with a comment about why we need a list
there.

The failure case is so unusual we should also probably write a test
case to make sure we test for and don't regress that issue which we'd
add to the existing tests in bitbake-selftest.

Help with that would be welcome or we'll get to it when we can...

Cheers,

Richard


