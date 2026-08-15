Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421D9C5CFC1
	for <webhook@archiver.kernel.org>; Sat, 15 Aug 2026 21:39:56 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.421.1786829991319875117
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 15 Aug 2026 14:39:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=SW6W4Xkl;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4994c49f588so18232645e9.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 15 Aug 2026 14:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1786829989; x=1787434789; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=K8Kqho6itnjH6ckfsAMJ+1VHrBkxUaOak+ISLnB6Zc8=;
        b=SW6W4XklSMqnfCe0uda/FEfygOkTOP+Hd5wHOjaKMyRsdCDqScSU1vyYuth0bLUTqm
         IBnxsdAZFz2wkeCukfP5T28PRTDP60em54lO050WOm3FSTPnCD5HVHnFpPJ/61JZErmY
         hlwkFyKGuvHdBsKSFrHxwTFNsV8cmNXX1zb64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786829989; x=1787434789;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K8Kqho6itnjH6ckfsAMJ+1VHrBkxUaOak+ISLnB6Zc8=;
        b=cvm3U6p/TkeYUVJjEZeFeJEUtjZ4UsJAyoxhb66tqJYHuoE+Ci83jwhHIgpLpmCI1A
         YNPOxegmfBuJ21UnBnthA3XkIahYsDUPLC0tUvdIn8K0QcpVlK8xX3pzHPA4IMxvxc4v
         tS9uC6oushz+6rcqD8Yay4zIHHLNTxmjym9p1ynssOkxE7ZgQRqmRd5ItPa+8LXpaQhI
         bLyIm9GrQgEw5m6ySDLamW1w2P5qe8EAOaqdr3b3lliXaENO5Wg3QpgJHPeosKJlE0je
         nTicck6RsAS6YrJPEoszorPKH36iNbt8/cuH59UkhbsA4k5ncWrGFSgBfoVMVx2EW1qC
         AROA==
X-Forwarded-Encrypted: i=1; AHgh+RrJpLKD6RBaAFj8GWTNf5Q5eMAt9sG+IzoNTW2M4qRyVPO7E6TD2Y/5R8QS+jmgfzpYV+p8Re6axHoc5GHv@lists.openembedded.org
X-Gm-Message-State: AOJu0Yw4JXGZ2XlcqD/2je6qA1tOpRY/i+nI0nW2c+u33PVC6VwvaCGM
	+3XPuJi2UhfMVjfzghrHoEqzju8YIyuvFbp6EQDWqhdi8hQqTvOR365XKA4/nwx1FeI=
X-Gm-Gg: AR+sD12R+9MAiacwYC2mdHHeMUz47wdVLKEedx8aHmiE2kEs0pAZnD8BOMTbQGKM4S3
	dbT3361efBypOldU+CK9kFz6SjzpAjpFTGmWbnm2jKfgw+LWbMvxZ3PZK2J62XjaxiRu1FBNnQ9
	ACBbMiEwBCRbLCXjHdxf3mScpyvQUtEJddxjffvvfF6e4jcaQ22m3JPRv6yW/c5q4lYFefJfICC
	rvLiTaBLDuXAtfWKONQ7ZIR9YFQ/9Tk/mXqUfuGQmbzLCeQUv+6kzZ9Yby3juq0SO1EvDODuTpv
	/silteFuGA7WbZRVd0Nlmv3IGx5OyeRJ7xe/lAWq0ZDAz92Um76g2Opp9HTMTtHj74vO/Fnk4gK
	CLux3/viWPlIYFQUadmxxEsnIXzYJ5tddZlxd09ZQ1BPhj56TXamfWL1ILcUiqVr0hUISN29JYP
	UQegia1eYNSN5z7ucFNDok0fMh345tnF3QzRWLSYhOV+Usix3zCF8BCWbtnnawh23ebpJxjGF6b
	UjohsOlTAMH/XfUtkbVZ+AeRWG9ZB6McNN5WjTuldcTCekP1cZs1A==
X-Received: by 2002:a05:600c:8119:b0:499:596b:2e91 with SMTP id 5b1f17b1804b1-49987a58078mr218907125e9.3.1786829989427;
        Sat, 15 Aug 2026 14:39:49 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:d120:1e80:5c08:16c3? ([2001:8b0:aba:5f3c:d120:1e80:5c08:16c3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49988af0aabsm150474845e9.7.2026.08.15.14.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 14:39:48 -0700 (PDT)
Message-ID: <79d9178d92f476b3571cc8038b2ebbf7583a03aa.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/7] cooker: fix bitbake -b silently
 ignoring bbappends
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: adrian.freihofer@siemens.com, bitbake-devel@lists.openembedded.org
Date: Sat, 15 Aug 2026 22:39:47 +0100
In-Reply-To: <20260815134722.497586-2-adrian.freihofer@siemens.com>
References: <20260815134722.497586-1-adrian.freihofer@siemens.com>
	 <20260815134722.497586-2-adrian.freihofer@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 15 Aug 2026 21:39:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19957

On Sat, 2026-08-15 at 15:46 +0200, Adrian Freihofer via lists.openembedded.=
org wrote:
> From: Adrian Freihofer <adrian.freihofer@siemens.com>
>=20
> "bitbake -b <recipe.bb>" builds the recipe without applying any of its
> .bbappend files.
>=20
> buildFileInternal() resolves appends via
> self.collections[mc].get_file_appends(fn), but self.collections[mc] is
> only ever filled in by collect_bbfiles(), called from updateCache() -
> a path -b deliberately skips. matchFiles(), the one -b-path function
> that does call collect_bbfiles(), built a fresh CookerCollectFiles into
> a throwaway local instead of self.collections[mc], so the append list
> stayed empty (or, on a memory-resident server, stale from the last
> full parse - e.g. missing a devtool/externalsrc workspace .bbappend
> added since). Nothing warns that the built metadata differs from disk.
>=20
> Make matchFiles() refresh self.collections[mc] itself so the later
> append lookup for the same fn sees the same fresh collection.
>=20
> AI-Generated: Uses GitHub Copilot
>=20
> Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
> ---
> =C2=A0lib/bb/cooker.py | 6 ++++--
> =C2=A01 file changed, 4 insertions(+), 2 deletions(-)

I've not checked but doesn't this only add limited collections data so
whilst it fixes -b, it potentially corrupts the cache for the non -b
cases?

This is definitely something we should fix, I just want to make sure
this doesn't corrupt something else. I suspect it deliberately doesn't
write to self...

Cheers,

Richard

