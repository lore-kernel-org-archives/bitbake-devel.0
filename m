Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F1010A1E81
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 11:50:22 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.46304.1774525818363087595
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Mar 2026 04:50:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=cvVAltLc;
 spf=pass (domain: gmail.com, ip: 209.85.219.50, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-89a1347051aso13830236d6.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 26 Mar 2026 04:50:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774525817; cv=none;
        d=google.com; s=arc-20240605;
        b=fRzxOk4jNDUjtgK7XwpHuEyWgGC/o9h1/1RauqsjZ/umP5QOOzWpJCtC8kfm0/ivWy
         s6IuYBL3nfxDAbsWHULVKuNB2tcIq3HRx75sxS9qEkw/hvasScgJaSfy/QsynDOWq2vV
         TJ7+OFv8WJeFGPcR3CmzO469yj+MUG9e1b11JRlY/LDvvKSF9L7NMiCbZaA7mC9dzR7X
         8uI3P+rx5cnkEixqR2qePcSQOJlUnPxTqnd/oihjZlIF5HEUi/OhvCgEyDyou0T9L1Sk
         AYagk/SYXjDqYqMw/I/Nm2cNPAtX4MCjVh4dZpqxRyRc8tKA4zIRbEo4pagdp+A0qFJR
         JqJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1wMuBeujn0Jvp/COOJ9fbWFAS4bba5aqp9875+pt3/c=;
        fh=z79r7devTYIWKIIJnNEQrp8fu91t3iK8WPc0gYxDyHM=;
        b=acDEU/e7Lkgyv1Zpnv5Jt2Q4P+NQXC9XE+Lwnz9k0eLIB3ACvV8Rme1lVM6or4VY84
         Am9k+5ApRfMEXhLydBYdCUIgMxtJ5W3jv3Cgb9RH4jdwYt4tXSZICJTR51gOsALBDDUM
         QcLgqwHxC9NO3tx5nSha3y2ZCj+HcuLVgTpEHkSl7DklquZOgJCR54WksWtgnTGKw+4B
         EdVbIEdAHhVevq91p3dXXWWOtK5iQStBsIQIovJ+d2ReuFCHf77dX1imRM3YpXzNpDGR
         gqQBkFIdHo9bGGCGaugUABAha9gERZAnIh8613LunqLrKYf+sjZeGioquOuF/SBSv4sX
         e0Tw==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774525817; x=1775130617; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1wMuBeujn0Jvp/COOJ9fbWFAS4bba5aqp9875+pt3/c=;
        b=cvVAltLcJ7ChnS2iwPPtQ781KdCwto1hHXdOdE/8GJGS2yUwTSwIXO2SCy7W+Lc1RN
         FiVT0LNxTcHlVRJLGv031sSKh3IRUEvYfDSXH7Ye4rudBAlGCu8DX4SDBS0gKhn73blh
         RcPt3to0btDhmm0fqd3Si2cNGjiMZ9pzcColhH5uiQmBYTSXt02yoRc/ngCcFNnnHEDT
         f2r+9QA6RBujJEu/brzElznj9b8FMYH+Hj89XIpClPOFtHyc7g6UisfE7cLfJ1mGUekh
         x6o7f+WRFAN3gPmiznWAPjYzHvWpaEQadya8esyBec4IBAQIMfLdIXfPKFj8o4/BWlIJ
         LnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774525817; x=1775130617;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wMuBeujn0Jvp/COOJ9fbWFAS4bba5aqp9875+pt3/c=;
        b=R6kSieYS1nHR8NqwRv1Z+KDpCQr70hIPb+B1IrajftmqbWrgSqEgqHGkdtOs1sp6uc
         TZIboAlXUQGJoaRRngF8/PNUguxMpybO0AcOfU2D2y73EuFN11mtVUqjG6kcKXiChaWD
         UkiVuY7BgSNZmPveENJdU4OhFVEKPILe1/9iXRasrFE+u9FcDjjRGvtxUCKYKVP0fjUu
         z+eeJHMtIg3itGGgPPdUJGwhG1PKjDfP0tvfQ2YMHxUv+j13vUBE6T8FJIgEIqgm9y3v
         S6cNnlsSUfnWMAo5MrgXRqKLFltGZAoLU+ogB113QwgfXMVPPzeJ4YG21/1PCNFLlnuG
         ExqQ==
X-Gm-Message-State: AOJu0YyX0Pm/toAcRmQc1ufveZMmdsg1RTLHfQy+ZqR/3h+jIm1OfdHJ
	11BPTmoUDNjdAtz0QJTFIWVKqiJX44N/SmWfVvOERBxlMKwiNDki/apSnhK/bKviOFid5/L3KjA
	3oPxcNAi62fas7dmp4mnUJj12JafmEmg=
X-Gm-Gg: ATEYQzxB/VZVpztfmtHmtqbxYSxLztp67qHS30tAqHQRdJQJq+hOhjncY+7QlVFfw/w
	r9HAkBWCVM8E4P4f9l63ae9p8BPJMKOjE9yRf6TaxTu1aOTVNzmH/mV4ivOxItWyoXhaa/PUuIg
	1KMEMo2BqWbhPhIYuQrNeP94w7sYSOZQWhnYxjfO4Mm6Wgg+Zap9AgkOfuiI6s9p++idRuXcpyp
	a0Dngu8s0SnXylMufg3xtM1iKSKNRYFvsteI4zzVIAmzHheuNQfb1ICGfQJkCVX6A4gNSa9scWo
	3QxGc2QqJlUzu1tfap9gruyyp1BcuOT1UOCViqXAhQ==
X-Received: by 2002:a05:6214:2508:b0:89a:6142:377b with SMTP id
 6a1803df08f44-89cc4779065mr121687196d6.0.1774525817284; Thu, 26 Mar 2026
 04:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260325071342.47272-1-adrian.freihofer@siemens.com> <20260325071342.47272-2-adrian.freihofer@siemens.com>
In-Reply-To: <20260325071342.47272-2-adrian.freihofer@siemens.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 26 Mar 2026 12:50:06 +0100
X-Gm-Features: AQROBzDKbRrvBb6z6RLjFHcmLpA_uqlmjWr6T37Fr5w_ONLeFFgzDHai_1j3e8s
Message-ID: <CANNYZj_yBNCE8OZ_OioZFsiAacwgqYADUkjfxVVmhBDRWPLLtg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2 01/10] fetch2: add LocalModificationsError
 for uncommitted changes blocking update
To: adrian.freihofer@siemens.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Mar 2026 11:50:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19235

On Wed, 25 Mar 2026 at 08:14, Adrian Freihofer via
lists.openembedded.org
<adrian.freihofer=siemens.com@lists.openembedded.org> wrote:

>              output = runfetchcmd("%s status --untracked-files=no --porcelain" % (ud.basecmd), d, workdir=destdir)
>              if output:
> -                raise bb.fetch2.UnpackError("Repository at %s has uncommitted changes, unable to update:\n%s" % (destdir, output), ud.url)
> +                raise bb.fetch2.LocalModificationsError(destdir, ud.url, output)

A bit further there's this block that handles rebase conflicts:

            except bb.fetch2.FetchError as e:
                # If rebase failed, abort it
                try:
                    runfetchcmd("%s rebase --abort" % (ud.basecmd), d,
workdir=destdir)
                except Exception:
                    pass
                raise bb.fetch2.UnpackError("Failed to update checkout
in place: %s" % str(e), ud.url)

I think this too needs its own exception, bb.fetch2.RebaseError. So
that bitbake-setup can handle these two exceptions specifically, and
raise other UnpackErrors without assuming anything about them.

Alex

