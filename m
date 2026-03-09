Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EC1FCA195
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 21:47:29 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.26396.1773092845679022953
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Mar 2026 14:47:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=NEhvz6Wg;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48541edecf9so3227325e9.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 09 Mar 2026 14:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1773092844; x=1773697644; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CRPPLI1ZHkzlGVi5rVlgr6ds3DUDVquvqPKDMG1SZnQ=;
        b=NEhvz6Wgl15zo1J9fJiILgC2Tl/Sc6Rc4GStfFz2igVD8bESq5wwUU1t7bnyP4Zxn4
         6khGN+MfgFE3ATnmG5Wf71OZW8f5+0n9Jl5MVHHW3jfN1xniYlhoYMZKzJjTav9rSqe2
         1DATd2RorXFirMIOA8BdToXZUIJf+VaJQ1zW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773092844; x=1773697644;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CRPPLI1ZHkzlGVi5rVlgr6ds3DUDVquvqPKDMG1SZnQ=;
        b=gRaPIWrrYAFtPPiG7WA+WaskZcAPU8TSDNUBqEyGJOQxqioN/aJVXwnd0xnPRRbWoK
         Y/Wizdj1AViZ7XDFZXTdpebdcPTsIHRqyhR+w+rTUuX/SKYojbrLjmcq3UOPM2qnXkng
         rPSq3scBXZ6ocb2kUjavr/sal4jXin5iHedrzmYJcB240H2hxxxtIiqw07EenvxS3FjN
         GLAoXfnKpMFIkWxBE3H/uF3mae3KwTRl3YMRfd6zrQqYWoVZvtd6U1RxAwYku+oyOoXB
         RZL3IvdyO0BcHrcQe09qudLjWlAUTr+Ubq4/x8ECR0RuvQGQ2/uGlwtxzRZ10twR8bE1
         K2jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEkMRT7b7ox0L0koolMrmFfzjaSznWxwE8RWVJRjKC8+soHaNt9jVx+LpNowLDpdXOV2JompB8m/RODPGe@lists.openembedded.org
X-Gm-Message-State: AOJu0Yx0jzORExv/POiiOBa/kjwObKO2TuFFyriUKI8OWzokOTn9vyvd
	5jK5g29MT5mGaXh8EqUJf4ZvCPslBPjGytH6yeckAkIOyr4vpdQYcIiORTLkc9XqLOQ=
X-Gm-Gg: ATEYQzz+G+oO/2kfPxlrMiZSfqK11rS40OK4mlSEikCrBmAVSJbm2kMIIz33unBMfmQ
	8x+sPxKnf8L7CSInOQaX+zHffCGQ3Wa+v7XPao+HUr5KH334r6T264J+stksUVZQmTPB/4dWLQX
	cQEINZkFd6szIMpQNqXsWATzr20GOuo2dJ9+zdXroiYVvAclUVOhJTXsnGyLbTfuvcRB8LUyc1B
	vBbVUdTfV8OpDXBj3PSQo6e+Zb7E6OOMS8gkAbydTOa4XXmPho+Sd+E9axbtLYzlFA7m3b8tPzR
	9qctzKxqvdyIpcp1td8M0NI5jcn4CtEeE5nUAgE5jYzckYRK5n6azB5DwYov9Fwtav+vB1kUU0s
	bXByaMsDVR7BO5qb6kViF6okIEV1dQZ02gwN5DNnpL9BMf7323U+E6KU8HdOG3sICe6+JgZvNRa
	3sedFxhE6SYpxdiFndRdS54zgD58EJUlN0Hg0vYm7Y+SPdO5o8icxCAnaD2AzElFqcW1SWX+BA4
	FR2bENvHPey
X-Received: by 2002:a05:600c:8708:b0:485:3a03:ceca with SMTP id 5b1f17b1804b1-4853c39afc4mr59041355e9.23.1773092844034;
        Mon, 09 Mar 2026 14:47:24 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:f0f:27a5:814a:c92a? ([2001:8b0:aba:5f3c:f0f:27a5:814a:c92a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541a6bb86sm19755865e9.1.2026.03.09.14.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 14:47:23 -0700 (PDT)
Message-ID: <0a020414e031e626bc57d61c49e839994202718c.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v2] fetch2: avoid reuse download
 filenames
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: pmi183@gmail.com, bitbake-devel@lists.openembedded.org
Cc: Pedro Ferreira <Pedro.MS.Ferreira@ctw.mbwgroup.com>
Date: Mon, 09 Mar 2026 21:47:22 +0000
In-Reply-To: <20260305151941.835215-1-pedro.ms.ferreira@ctw.bmwgroup.com>
References: <20260305151941.835215-1-pedro.ms.ferreira@ctw.bmwgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1ubuntu0.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Mar 2026 21:47:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19132

On Thu, 2026-03-05 at 15:19 +0000, Pedro Ferreira via lists.openembedded.or=
g wrote:
> From: Pedro Ferreira <pmi183@gmail.com>
>=20
> When fetch task runs and while running checksum validation
> detects that for a source file the checksum mismatches,
> instead of aborting, its allowing to move aside and download again.
> This might allow users to taint the source files instead of acting
> as a safe mechanism to fix some issue occurred on the download stage.
>=20
> Signed-off-by: Pedro Ferreira <Pedro.MS.Ferreira@ctw.mbwgroup.com>
> ---
> =C2=A0lib/bb/fetch2/__init__.py | 11 ++++-------
> =C2=A0lib/bb/tests/fetch.py=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +---
> =C2=A02 files changed, 5 insertions(+), 10 deletions(-)
>=20
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index aaefd8602..1484f5422 100644
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
> diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
> index 74eb73472..8f371234b 100644
> --- a/lib/bb/tests/fetch.py
> +++ b/lib/bb/tests/fetch.py
> @@ -899,10 +899,8 @@ class FetcherNoNetworkTest(FetcherTest):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertTrue(os.path.=
exists(os.path.join(self.dldir, "test-file.tar.gz")))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertFalse(os.path=
.exists(os.path.join(self.dldir, "test-file.tar.gz.done")))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fetcher =3D bb.fetch.Fet=
ch(["http://invalid.yoctoproject.org/test-file.tar.gz"], self.d)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with self.assertRaises(bb.fet=
ch2.NetworkAccess):
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with self.assertRaises(bb.BBH=
andledException):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
fetcher.download()
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # the existing file should no=
t exist or should have be moved to "bad-checksum"
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertFalse(os.path.exis=
ts(os.path.join(self.dldir, "test-file.tar.gz")))
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 def test_nochecksums_missing(self):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertFalse(os.path=
.exists(os.path.join(self.dldir, "test-file.tar.gz")))

I'm afraid this is just making the fetcher behave inconsistently. There
are four places where rename_bad_checksum() can be called and you
simply remove one of them as it suits your use case. I'm not keen to do
that at all.

Cheers,

Richard








