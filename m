Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6323CF483E1
	for <webhook@archiver.kernel.org>; Mon, 23 Mar 2026 18:22:17 +0000 (UTC)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2066.1774290129238053678
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 23 Mar 2026 11:22:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=fdy9Btde;
 spf=pass (domain: gmail.com, ip: 209.85.160.173, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50b2b2aa276so36050091cf.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 23 Mar 2026 11:22:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774290128; cv=none;
        d=google.com; s=arc-20240605;
        b=CWimcLvreKx7+ZL8wP/gzZf/nnIjIw4fCxvEdO76SNI5jt+84MJCDmAWy3NRPIRV+o
         B4IfzaS89PAeic/VRL/3zx52BEZB6iakirZC5SPDuHl77XGrm4puHCmAQh/+qt6HNXqL
         hZRXbjcE/9eqggJEYCJUMqFqJ6dTyx9mw6IR58v0x6i8dE6udZ+HAJW8BCHSnTMBL+Yi
         8KVvLRus1el+PkDx+QFolUKP7k7NchUNsZ9plluXx1QmFNnXshQSehDpDCMWxk1j2GxD
         eONa76PeoBRxbCWLSnJ534P1sM4SrzJKKFqs41lph1WEQdDkUVtfbmRZRK0BEUBWKgDI
         c0vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=I0M8vVWGhafb25pkl7UhssG5qkfvvJRVM4oCqmHEOHM=;
        fh=z79r7devTYIWKIIJnNEQrp8fu91t3iK8WPc0gYxDyHM=;
        b=NBTGtA5lKsgKPHXQQasCfeOAhAPneDlKuS8IIDUaEoC7bc10FfI7njO4PZfRpsDFNl
         9hA/kl2RnzcuDGhmNufiBYS7noxW89xfKJYXSnvMIbGX2kRpByBflaedcrjzoPKb4Csx
         tbh958+4sCX0SN+pvXJVs19WYY8FIFaigJIbSfBaPC0nDoIo/6gqML5KAC5taDuMHhFU
         pbEUSRMBTPcyKKPDf24F0IyKv13407sMJJNaafQiX+EIXLM1rSGS47SMs45W+JDY9e3w
         JltX7e5U4ygQJ7+MZFuZAWvHKKBGyPYTL2DVPRu09thS+e3QPwf7j17C5PfPvTQp6G4y
         9Prg==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774290128; x=1774894928; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I0M8vVWGhafb25pkl7UhssG5qkfvvJRVM4oCqmHEOHM=;
        b=fdy9BtdexZ3hS7WWnVmnZAKFukfpyboNgv+1H5yozpQSOoNcJNYJmd3MznHnQThVxP
         hvUKVYS9AxZMuiAmUhPV9y54b4Qct+HI+ger7mR8vom8nYPqV6rZ6hX329pGMiztNWHe
         qaa8SwQwpM/abm2koFzWn/U5BBfMxJXWMmXZZi1tkuqhhjzbdTu7/D2nHHjH4M+nTlfi
         t1b3XHby6cFFE0p0hWqaNsJk+TijQYt61msyjAusuJ1I+BTAuToeoUDCQcMFsCs4vbUG
         /lknjpGqkICgPIcyS/y+6k5NRDdju0FAzOcZcTBPQSmkZzmMYZ+GgTZ3gGFp6XtCzn3c
         y/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774290128; x=1774894928;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0M8vVWGhafb25pkl7UhssG5qkfvvJRVM4oCqmHEOHM=;
        b=S8NOglhR+ZlWUIFC2PAyndrSMMCKXbnon68FRMYiNAqws6XL40jmd2ahxIX2tIyFrx
         p0yFnWhdxTbCMrPQs8WH3hzH+0u4QWqrSikZmis3MDrjXEjd3+TGZtal+PS3YKoAP9sY
         4L4JPDAufiTMMvbzBWVQ/DZlXJl66SREfwb1yx6EsHfur6dIcCHk4n8RIaeoSU/dwCQj
         ODh6mmcujlJRft7BpMEL1kyHv+ls8MmOO8PU3+YLJujGBvHADLBmpzEmWbcF3Z7bJu69
         vWlTNkitadU/syQ04ebUqtER/JF4gV86G6JD5ekd1wAm+p57rh3TjA9z7gVYysoA7g/T
         PBhg==
X-Gm-Message-State: AOJu0YxrWrEeP26nbQp8lEWng9RDXmhj/Opj/mnr7UWKrsiku7qggjed
	HUQovU+rebBtTAYqjPbb1CnUQ0EiivSKFd93J+3VC5zSfeeSim+EKP8IRlXkWSOI420KjS4JylW
	d7hcKD9LecKdwVLyJ5ctZQmjd0kt7sbM=
X-Gm-Gg: ATEYQzw4yudD+3zBcRhGwwKQOP597gY2nuvE+nDJrevTKRJl8GE/dMRO538nexy7M5e
	2DyXpI/7l6a/i+GvO8mYVh2t4AZJtWfKkJZ9R0l03/510IhUqnCv9CL016bN+EPNcZ92goJSoWT
	Ld9fQ0DP2ykIH3zei4HRXiNprZ+oFKK8p2MeNQAkZ/CJvaIk2aB6T805ggXRgbhiNeW2l1ns5PT
	YgfOPkctKUNC9ST4DNSkQmoQLMsNbxrcoSXQbihWRHTHaFCL05AWmvTEVxa/MnysRtFJ0KLzzie
	X9YJtqPgOaSYyRn2V6SkSUy97z4DvwO7DlXjPQx+ln92/2M7X1Mn
X-Received: by 2002:a05:622a:1922:b0:50b:317c:33aa with SMTP id
 d75a77b69052e-50b374c77f1mr205011081cf.34.1774290128197; Mon, 23 Mar 2026
 11:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260322193440.870120-1-adrian.freihofer@siemens.com> <20260322193440.870120-9-adrian.freihofer@siemens.com>
In-Reply-To: <20260322193440.870120-9-adrian.freihofer@siemens.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 23 Mar 2026 19:21:57 +0100
X-Gm-Features: AQROBzBkJcnrSGZR4KNJMvyeSKuyoyyC-yVkPdZo0gidRHH69gPWqjyDccrVOPU
Message-ID: <CANNYZj9=cDxqcT9JZ961eeDBkoW5Xo10BzbBiRFsbLBLXZx-HA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 8/9] bitbake-setup: add --rebase-strategy
 to the update command
To: adrian.freihofer@siemens.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 23 Mar 2026 18:22:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19210

On Sun, 22 Mar 2026 at 20:35, Adrian Freihofer via
lists.openembedded.org
<adrian.freihofer=siemens.com@lists.openembedded.org> wrote:
> +    parser_update.add_argument('--rebase-strategy', choices=['stop', 'backup'], default='stop',
> +                        help="What to do when a layer repository has local modifications that prevent "
> +                             "an in-place update: 'stop' (default) aborts with an error message; "
> +                             "'backup' renames the directory to a timestamped backup and re-clones from upstream.")

This option should probably be called 'rebase-conflicts-strategy' as
it deals specifically with the situations when there are conflicts?
And the choices should be 'abort' and 'backup', as 'stop' can be
interpreted as "stop mid-rebase with conflict markers left in the code
for the user to resolve".
It wasn't immediately obvious to me, but fetcher explicitly aborts a
failed rebase and rolls back the code to where it was.

Alex

