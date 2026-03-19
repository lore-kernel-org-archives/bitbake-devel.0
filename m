Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6EB1091924
	for <webhook@archiver.kernel.org>; Thu, 19 Mar 2026 21:05:19 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6456.1773954314870257909
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 19 Mar 2026 14:05:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=WSc1nxob;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43b41b545d9so1508335f8f.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 19 Mar 2026 14:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1773954313; x=1774559113; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbHZ9KmF2UXOQsAVdWtmFn0QKGCKJTopvyJHH2SllWE=;
        b=WSc1nxobuD7kaVQr8OF91Nl4+JXv6R4+8e9mjodeTwZf6+kbHR/OC71ltKgJ9DlQxo
         kifGSGAfvN5ptd/EXizGkD3Z4TAsNxIKOwulALe0Xj6j7jpvS82RX7RJkUjTjrVA/0ga
         wZF2QegFbKF7kLMplgnpiZsX0g9zk7AgDONbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773954313; x=1774559113;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cbHZ9KmF2UXOQsAVdWtmFn0QKGCKJTopvyJHH2SllWE=;
        b=kVhsYsnNWLMmHCzN0qQMSeW/kOU1gcqDK33EOLojaywtniynDnqbz1u2Bubqlx6Lgu
         tA2LzKDE6E9S0p0ysRWT0iehicvEkUTbgm99r5jEY/ME1sFmpA6L8BE4tMR1PML3c7Vj
         3idKv/bKtifdW8/DWDrPXRnnnaKiTZKSWPGevdO2/0ROKyjZ2narAAlywZbUsApZrF4g
         WWUd9Iac5geh5aTvj+ValDaTRCcMg9ys9V05qxEOTmk8zcjMLx/88srTXVNq1STBQ2Ks
         dVeKC8W9wXswy8dunFNDLAsL//OPmbvRuMJySwPbV0aMl5xmvR9Pth0va7l4L87Itu3N
         Ddjg==
X-Gm-Message-State: AOJu0YwY3xRlnivlhYRlGTvLzK6Ugj2BowH9BRNW/xGi7i5w+yVtY8kO
	0UTs1E+CgA8PMABRbQChxKUbXK9yF4WTbIRos3iOFzPfKTjgpDp1qdT4JvLdDDNEouKxJUKbqeC
	GaZNDPw4=
X-Gm-Gg: ATEYQzwobgiN+WjKNUIPMSbmudl13WThJlm9D2/hz//37uiw5cOndzPez/zlhMxd7MY
	bvbiaCfDZ9TBBrwghXpokg6dtDmn4OYOvH+P1BS5Gm5ZvwPbzkTenrcoJP6Ehu7QCFHR4Asw0vN
	jyYVKMfLvPGyyJ/Qm43O3V4Mbs2f0TQ//Hdmk/h7A/Pued570wLaZKuxZeYCJSRmaPPukrkcCOh
	IAYKp/F4JuNwhLpfl7YJJthpCkNyaP+gQrSDte2x4MCUAWoQYr5bLq36dQNRZRWj+AmpUxPbKPz
	Q+k/VroHceAXKnxvNh4GZW+upcvUDuuKclAQIVZvtLkAclX+MSWS/JZDX6CMzTyZCgyBese4klH
	EoObseirT8ALI0N/JLOoOmhhvQ6o3icBK0J1CEdcL09voZ1knnWhPy9CKIXD46+sow7SNobXdNb
	DTkuEQ28vfT7JTAt3R2kfx1WioozjxQTn9xNPqwAhSbVjVYxPtG9MXr0JUS1Qb9AWbSSEcJvWJB
	9kGbiw4LW03gR6l2s0mm9Ek9w==
X-Received: by 2002:a05:6000:24c9:b0:43b:493c:8767 with SMTP id ffacd0b85a97d-43b64265678mr1447415f8f.27.1773954312783;
        Thu, 19 Mar 2026 14:05:12 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:4a9f:30c4:8322:217c? ([2001:8b0:aba:5f3c:4a9f:30c4:8322:217c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64703c7fsm1335660f8f.23.2026.03.19.14.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 14:05:12 -0700 (PDT)
Message-ID: <e551779604af9981640c070e5b9d07cb68f813fd.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch/git: Add an 'update' unpack mode
 to the fetchers (git only for now)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org, Adrian Freihofer
	 <adrian.freihofer@siemens.com>, Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 19 Mar 2026 21:05:10 +0000
In-Reply-To: <189E3DDB9FE2B7C7.1764087@lists.openembedded.org>
References: <189E3DDB9FE2B7C7.1764087@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-4 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 19 Mar 2026 21:05:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19175

On Thu, 2026-03-19 at 12:28 +0000, Richard Purdie via lists.openembedded.or=
g wrote:
> @@ -714,6 +724,32 @@ class Git(FetchMethod):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if not source_found:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
raise bb.fetch2.UnpackError("No up to date source found: " + "; ".join(sour=
ce_error), ud.url)
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if update_mode:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ud=
.shallow:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bb.fetch2.UnpackError("Can't update shallow clones check=
outs without network access, not supported.", ud.url)
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 outpu=
t =3D runfetchcmd("%s status --porcelain" % (ud.basecmd), d, workdir=3Ddest=
dir)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ou=
tput:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 raise bb.fetch2.UnpackError("Repository at %s has uncomm=
itted changes, unable to update:\n%s" % (destdir, output), ud.url)

There is a bit of a debate on this line between Adrian and myself.
Should we use:

git status --porcelain=20

or

git status --untracked-files=3Dno --porcelain=20

?

The difference is untracked files. The rebase will abort if an
untracked file is changed by the changes involved in the rebase so it
will allow untracked files to be untouched and should be safe.

I had thought we should exercise caution but perhaps that is ok...

Any other opinions?

Cheers,

Richard

