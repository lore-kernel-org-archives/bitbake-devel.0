Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4DDEA4E2A
	for <webhook@archiver.kernel.org>; Mon,  2 Mar 2026 15:56:56 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.163751.1772467011297421978
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Mar 2026 07:56:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Hny52Z3U;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-482f454be5bso50852595e9.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 02 Mar 2026 07:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1772467010; x=1773071810; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SM2FKAYCuNh2sjlDnf6PSoXGDwxmO4E+Q5AzBXb/pJo=;
        b=Hny52Z3UB+b+bOh6JAQJRAE9gmAHVrOvo6hDuSuN/T5C7zQ+efoASdqhp/S9Vq0gt0
         +1PCYKQdItOlcVdY4qzJFJUWnwloDBBo0MTLhOv0yieM8yZsSgMIAiUOO1sK5P//YYpE
         DY6fr3mfhxotJiI9toIpFdMRDsHi5Vn+vWjJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772467010; x=1773071810;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SM2FKAYCuNh2sjlDnf6PSoXGDwxmO4E+Q5AzBXb/pJo=;
        b=rMmBRtzragJPLKr3TKzRbJsiAwN83Aq6QOtlpwohvwReE2gBP9nRWcXktrGgq6cEQt
         yf4gLEbQKp3Sn8Fh56D5sCbJo7b2mFlxeyASiesNTaWtlen1qK0iaS5XuTSSEu0BoZpX
         qPuQS3kiswXcmIZXL3yjtLgvMJoS6qWAVc1vmd3Ipkl9jKYHxh6nd1mN85izSVM92bjG
         sxItBgNs0Qyd/rIavuYHNq+1fKyufJQfgUNQR95jcY86/CsxwWDdRHi8hmObfGQBkErb
         S84sxumi52C/+xtADZCoim/4+vi07dCLQBGzBo00ak9iyMPw3YYOJXKmwz1xmhnMIFmJ
         Vuig==
X-Forwarded-Encrypted: i=1; AJvYcCXYUQZwVw8OP1tX0bQX3jjjfFkO5AW/UMIYxqkkUx7B8TEfPeQQ3+5/sJnFURcZo6DfGwlG8ncqu/aL0Yiu@lists.openembedded.org
X-Gm-Message-State: AOJu0YyRQP7fTcIjtbKFeVli0iXwg4szPsrtlXeoX3lTSBIMIo7HRvzb
	GzXXyAkcLEXzONnhjU92KHEFpQwD4JhYbEl5AQVrK7dFKqdMXjpnaMfYCSRFYlnCUf8=
X-Gm-Gg: ATEYQzwK+dyiaGn7pJJbOXBW8my54jH69mffBWaBcx+yQseB3Nww/mEwMNwYVpHjv2e
	gIXg2tavblIcQVJP1orVRAGsHBUpRojABkAJtwTkdumW4gW/MWCwrzoY1Y8MC5UFGlYpW/AFsoX
	4/BfM6BSuzLW3Rjok9kN6S2x6LABvgpYo6ZMkg+Y2OKX+r8JXvT9GkGi9CjJ5sq0GIV/vpQTW0i
	Lt/m9/C9XHjpf9G5o9JUEqDxLpbPETdV2FpdAtSkdvnuqx8VS/PYloYqrK8sZ2OyOPHtMTjAvZE
	eU9zOOO7g464gWKxky0Wrj1IBDeHv5AZivU0ZaayLxxARL6OEMXt+ys1epbOk8qiTG2xK8OSRbJ
	45l2X8T+RzcDPcCwPfZsYwIvqcfUIk2fVcYIYLprxMw4aCuOyzr0THusfalGd7Mh43ZCezyOSOu
	5wOvsq+rXYuW5TGidzN2pP8BQgG/741MdFJQuOV+hJeMxYZBTbjJ870iD2TODuo4J5RRF+TPQE0
	M81aa4OJfsf+Go=
X-Received: by 2002:a05:600c:8b5b:b0:481:a662:b3f3 with SMTP id 5b1f17b1804b1-483c990c263mr251407215e9.7.1772467009583;
        Mon, 02 Mar 2026 07:56:49 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:dd78:7aff:8be3:3eb6? ([2001:8b0:aba:5f3c:dd78:7aff:8be3:3eb6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfbb465bsm305510375e9.3.2026.03.02.07.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 07:56:48 -0800 (PST)
Message-ID: <e58fedf42052698a50007bd5d49a70e0b77aa702.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2: avoid reuse download filenames
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: pmi183@gmail.com, bitbake-devel@lists.openembedded.org
Cc: Pedro Ferreira <Pedro.MS.Ferreira@ctw.mbwgroup.com>
Date: Mon, 02 Mar 2026 15:56:47 +0000
In-Reply-To: <20260302151443.256386-1-pedro.ms.ferreira@ctw.bmwgroup.com>
References: <20260302151443.256386-1-pedro.ms.ferreira@ctw.bmwgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1ubuntu0.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 02 Mar 2026 15:56:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19098

On Mon, 2026-03-02 at 15:14 +0000, Pedro Ferreira via lists.openembedded.or=
g wrote:
> When fetch task runs and while running checksum validation
> detects that for a source file the checksum mismatches,
> instead of aborting, its allowing to move aside and download again.
> This might allow users to taint the source files instead of acting
> as a safe mechanism to fix some issue occurred on the download stage.
>=20
> Signed-off-by: Pedro Ferreira <Pedro.MS.Ferreira@ctw.mbwgroup.com>
> ---
> =C2=A0lib/bb/fetch2/__init__.py | 11 ++++-------
> =C2=A01 file changed, 4 insertions(+), 7 deletions(-)

Do you have a bit more information about the issue you ran into?

This behaviour was added so that a "bad" mirror with a broken file
wouldn't stop a build when there were mirrors with the correct file
present. That is beneficial for some scenarios.

Cheers,

Richard


> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index dcf7adc26..b8d8957b0 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -716,13 +716,10 @@ def verify_donestamp(ud, d, origud=3DNone):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 p.dump(checksums)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return True
> =C2=A0=C2=A0=C2=A0=C2=A0 except ChecksumError as e:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Checksums failed to verify,=
 trigger re-download and remove the
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # incorrect stamp file.
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 logger.warning("Checksum mism=
atch for local file %s\n"
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Cleaning and =
trying again." % ud.localpath)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if os.path.exists(ud.localpat=
h):
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 renam=
e_bad_checksum(ud, e.checksum)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb.utils.remove(ud.donestamp)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # If there is a checksum mism=
atch, it is likely because the file
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # is being tainted or some co=
rruption is occurring when downloading.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Download cache should be cl=
eaned up before trying again.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb.fatal("Checksum mismatch f=
or local file %s\n" % ud.localpath)
> =C2=A0=C2=A0=C2=A0=C2=A0 return False
> =C2=A0
> =C2=A0
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#19097): https://lists.openembedded.org/g/bitbake-deve=
l/message/19097
> Mute This Topic: https://lists.openembedded.org/mt/118095154/1686473
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub=C2=A0[r=
ichard.purdie@linuxfoundation.org]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

