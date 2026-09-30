Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5ED4CA5FB1
	for <webhook@archiver.kernel.org>; Wed, 30 Sep 2026 08:36:13 +0000 (UTC)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8973.1790757363550016300
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 30 Sep 2026 01:36:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=L4FCh0S1;
 spf=pass (domain: snapchat.com, ip: 74.125.225.140, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d391aso38440545e9.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 30 Sep 2026 01:36:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790757362; cv=none;
        d=google.com; s=arc-20260327;
        b=pF89BfjkUYn5QvnOnpOXO9B2V9UPgI819z7JYTGwOKA6WOJjcDu7j0QeXXyYGlaT1t
         FHYQuSqUpF64dAFaphz9jLeBu55/dE81vngGviibYnaK5zKRpeLgYlxQmqihfY3dyz5P
         h4I2Ls33xzXWznrq4DV6hHwTeEf/COyLe26Zu2AVsb1CvrABndmTWwycm7CUd0RKuWTQ
         Jj7NeYRm6NVUh7WR6HQVYpECfFIApwk3vUhobLhdiJ8d19iwV5hHIVCIt8+oulvtOWL+
         H4pH7DrSXshUqZl+qwQGC1joIoPG6b9GFv/7Ybfcba4eZCFUuPRPOqL0RtiPkssSBaBe
         +vbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uUMYRkEg0AYk91CYPLSgke3jSQsFtoVDbPStScrLJuw=;
        fh=kwhZ3Li+yPVxdlH3ayfQoAuPa3/pJuSlz2Co5M6h6T8=;
        b=UssP63lyPuIFhaUWyhdA+9NKDk5oUxjr53JiyQpyFgEmfWDxM0dFnYO7xXsUfanNRk
         J9BPD1tuKuFzCE+s5X03M+RL+OGPNMTSsYLfNVpcuYY3PS0/YDhmxaAxmZvg0PeSB281
         dm2t6ni6VIM+niGiyBLq5fRSHsk6FBAprA0S/QyEqRuvvF6/0U1S6FsafDauu+IpoJLR
         I4cXWPqRxaVXA96d5eQ7r2O8NttgvktJbChJloM2y8J7wmPyEelIFDa+VNboXIn1iMEX
         VSFxk7rNsUiDNAQ0AAjl647pD2RrUZ4JWig1UEFq6eudCNUqx9gRObKQN6UZx3yj0edd
         eezQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1790757362; x=1791362162; darn=lists.openembedded.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uUMYRkEg0AYk91CYPLSgke3jSQsFtoVDbPStScrLJuw=;
        b=L4FCh0S1r3btsEhtpd+Nl9ALHJO5DP5X3JiWhCPSub8i+7tsR3KAEC2fND49gtYwnj
         3GmXvpKpZH2OFdqQUitaUEYPK55l3+N70OEkYFbCG3qx1ERbL5ASLwKnVXdUi1Vivjay
         U2ooVavDqCZbU/Pmr4EKxgLwaF4iRsL625fRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790757362; x=1791362162;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uUMYRkEg0AYk91CYPLSgke3jSQsFtoVDbPStScrLJuw=;
        b=05GycIUsGsGZQnlC877T8c6czTdHkkDBrd6fwWSKHB1kzWHtVZofVX4yQ3Q/5blkKf
         vFNjf5LKjRkQBgcpFyqzxTUC6Xqe/JQ9swLvnFYvohJ9pICoAWPi1wI8pZBWfbJVcrrH
         GY7n5Em0vfbZ1O+k5OD5YDt8055CVU2dXijHlEWvsGDCk+LdqQx+LO+g4o7eTojJIARg
         2zeOo2bglG1gggTo5b+no7dC8eUaND1sOKTswkAyWu6OrDNyiDWikVIcXKzkOjbqvodE
         Sr4YJvfcKPS6XB4xe2Zs9UtpeHDxgG9Qj5ekww6NTd1J//k9SosT0MjvSW50F/k72Mvn
         89eg==
X-Gm-Message-State: AFuF++kYG/NMpv+S89H3wdblUUfMjgbXJ/TmJtMSjx9+X976ZiPnihR/
	sPWgcxpe7KzECuinhU7VNbCkEew7tc4py83k7x+XXBNRv9fKFnqqn/nOx7lKdYh38MkdIlviQ/K
	AxRemGliki7PgsfNeloh46slrNOi6BOs010rxsIWp8Oiwqa6dGN1lDPRX0w==
X-Gm-Gg: AYBFou39Wcx6TTN6VW6MJGU3tl9BHo9xnaPlv+LFVAzRWfp3sWLQ3di1CNhMVnRUl6v
	ApvAsBvFz21D8SBrGwAGvh9ADsReukgrmaa32uzxVR7J+8bKLNNEocc8jhsLs8jWEI8uCVCJrtf
	HYxTxMST+LHyVvzQ0dkRjPbb6WfuD61n3AoT0oPDDZUzUZKLYED6ZmG8ia5u+gdSDNnGtgbv9bD
	kyhuJQsmw5HOM2pHyFFd7zJHpRwAJZOTsFY/ixML7QCsxHppXui4RQI3ufV3e2VwFNmbSQsf5DJ
	FqikgmlfAbTrNldVvLKjYTG2lfFjklZkAdvgwTFWW5CZS9O/3QrnPGoMET8RLA9q20//MkIkDRi
	W3i14zQ3ifgIk
X-Received: by 2002:a05:600c:4691:b0:49e:799a:8951 with SMTP id
 5b1f17b1804b1-4a01aff4450mr9108905e9.11.1790757361656; Wed, 30 Sep 2026
 01:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260923170633.1313487-1-ecordonnier@snap.com> <1fe7b763a6e1731dc80fa311f9fe4463a21c35fa.camel@linuxfoundation.org>
In-Reply-To: <1fe7b763a6e1731dc80fa311f9fe4463a21c35fa.camel@linuxfoundation.org>
From: Etienne Cordonnier <ecordonnier@snap.com>
Date: Wed, 30 Sep 2026 10:35:48 +0200
X-Gm-Features: AclHuK9qpte6HD_pTMMKdL-oqxo08FgQYwxXmfQIwyySqTgV7Xh8tuWCXNyDO3s
Message-ID: <CAHUKmYa80Q=1ZVPV_Kgd6y16SQqGkP=JwBPq3juTj8-n8awZZA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] cache: Reuse os.path.exists() results
 during dependency validation
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000006bd95a065caf3013"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 30 Sep 2026 08:36:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20283

--0000000000006bd95a065caf3013
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard,
I have sent "cache: Cache missing files in the mtime cache" with your idea.
It indeed improves the times a bit further.

=C3=89tienne

On Tue, Sep 29, 2026 at 1:03=E2=80=AFPM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Wed, 2026-09-23 at 19:06 +0200, Etienne Cordonnier via
> lists.openembedded.org wrote:
> > From: Etienne Cordonnier <ecordonnier@snap.com>
> >
> > cacheValidUpdate() checks each recipe's file_checksums entries with
> > os.path.exists(). Many recipes reference the same optional class or
> > checksum candidate paths, so the same path is checked repeatedly within
> > one validation pass. In a warm parse of 5,112 recipes (poky, meta-yocto=
,
> > meta-oe, meta-python), the real cache data shows 585,348 such calls
> > against only 48,757 unique paths, with the hottest path checked 16,894
> > times: 536,591 calls are redundant. At 3.5us per os.path.exists() call =
on
> > a nonexistent path on this machine, that is about 1.9s of avoidable
> > syscall time per validation pass. Cache the result per Cache instance,
> > which is discarded and recreated at the start of each validation pass, =
so
> > a filesystem change between passes is still observed.
> >
> > AI-Generated: Uses Claude Code (Claude Opus 5.5)
> > Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
> > ---
> >  lib/bb/cache.py | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
>
> I'm wondering if the existing mtime cache could be combined with this
> so we only hit both once. That might improve the times a bit further
> since any hit would then need the mtime data later anyway. I'd worry
> about lifecycle of the data less too since we already clear the mtime
> cache at the right times (I hope!).
>
> Cheers,
>
> Richard
>

--0000000000006bd95a065caf3013
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Richard,<br>I have sent &quot;cache: Cache missing file=
s in the mtime cache&quot; with your idea. It indeed improves the times a b=
it further.<br><br>=C3=89tienne</div><br><div class=3D"gmail_quote gmail_qu=
ote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 29, 2026 a=
t 1:03=E2=80=AFPM Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linux=
foundation.org">richard.purdie@linuxfoundation.org</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">On Wed, 2026-09-23 at 19:=
06 +0200, Etienne Cordonnier via <a href=3D"http://lists.openembedded.org" =
rel=3D"noreferrer" target=3D"_blank">lists.openembedded.org</a> wrote:<br>
&gt; From: Etienne Cordonnier &lt;<a href=3D"mailto:ecordonnier@snap.com" t=
arget=3D"_blank">ecordonnier@snap.com</a>&gt;<br>
&gt; <br>
&gt; cacheValidUpdate() checks each recipe&#39;s file_checksums entries wit=
h<br>
&gt; os.path.exists(). Many recipes reference the same optional class or<br=
>
&gt; checksum candidate paths, so the same path is checked repeatedly withi=
n<br>
&gt; one validation pass. In a warm parse of 5,112 recipes (poky, meta-yoct=
o,<br>
&gt; meta-oe, meta-python), the real cache data shows 585,348 such calls<br=
>
&gt; against only 48,757 unique paths, with the hottest path checked 16,894=
<br>
&gt; times: 536,591 calls are redundant. At 3.5us per os.path.exists() call=
 on<br>
&gt; a nonexistent path on this machine, that is about 1.9s of avoidable<br=
>
&gt; syscall time per validation pass. Cache the result per Cache instance,=
<br>
&gt; which is discarded and recreated at the start of each validation pass,=
 so<br>
&gt; a filesystem change between passes is still observed.<br>
&gt; <br>
&gt; AI-Generated: Uses Claude Code (Claude Opus 5.5)<br>
&gt; Signed-off-by: Etienne Cordonnier &lt;<a href=3D"mailto:ecordonnier@sn=
ap.com" target=3D"_blank">ecordonnier@snap.com</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0lib/bb/cache.py | 10 +++++++++-<br>
&gt; =C2=A01 file changed, 9 insertions(+), 1 deletion(-)<br>
<br>
I&#39;m wondering if the existing mtime cache could be combined with this<b=
r>
so we only hit both once. That might improve the times a bit further<br>
since any hit would then need the mtime data later anyway. I&#39;d worry<br=
>
about lifecycle of the data less too since we already clear the mtime<br>
cache at the right times (I hope!).<br>
<br>
Cheers,<br>
<br>
Richard<br>
</blockquote></div>

--0000000000006bd95a065caf3013--

