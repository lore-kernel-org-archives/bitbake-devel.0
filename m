Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E238C433EF
	for <webhook@archiver.kernel.org>; Mon,  7 Feb 2022 10:06:58 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web10.20461.1644228416632528833
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Feb 2022 02:06:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ZBD5gkkj;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id k18so23710075wrg.11
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Feb 2022 02:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=l2oEEj7m9/UKqtlMnzLyz9vo/GoSAcnBCbIrx5gcGno=;
        b=ZBD5gkkjfZQnJ0C5haSY0UjPRqBzIpBJOBH2yJrb313WpdZE0yz+r2QNe49APrhx7n
         odsitNrNxdRzVdnKHm31QrNbVDLJB4zPr6cvGC5mfVyTQs8ct6nvwdL2qHrFbrJW4Ves
         uArXL7ruCwNLQTa+iX4vbRtw9AKAcRD0RDvgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=l2oEEj7m9/UKqtlMnzLyz9vo/GoSAcnBCbIrx5gcGno=;
        b=3zaipV/NVMOZwsiF9ww3tEqTuG5yuW08MNxuxcABy9pN4W4A+5IaTCRk4Zr5KNiaZY
         VbBLCpAHfvzC5tdecnIn3ZnfO8FTtjnO5SJu1GdGF+TzkAxfpVL3O8FUBM1h21J6mqyW
         qRv3+GHMfib1SB+7fwKVjzxEw5MZppkHRAL8bZJKRvKYhO7lIM7r9ojTDhwsrsmyj8m6
         2Yo7nOFDzONl4m4eeZX6Awg8ALtGuChGxW7evnzb3ECd8TbQc1a98mmX998vzgtxyOOK
         RzKUi7hAaDjQWuRcyjIq0tFattVtSdPn4jYCLtJKJvQtTUWGGtUtQtUeRJYwiCuRz/JZ
         yxrw==
X-Gm-Message-State: AOAM530FRNysY34trcDpVDE9tBd0EDNjJALw7WBJOo0HoGe+kD576VFe
	aSyEmyfiGah5u7S2RoEdBMF2sR1ac2sM4A==
X-Google-Smtp-Source: 
 ABdhPJwlxTe8ihtzxYRAGasriXpqn87WT4t/T/eks0vvvKdDO3NniU8+8eV+JwGAAroKeS9koE2S7g==
X-Received: by 2002:a5d:5112:: with SMTP id s18mr2828369wrt.296.1644228415220;
        Mon, 07 Feb 2022 02:06:55 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:6244:607e:d5da:d0fc?
 ([2001:8b0:aba:5f3c:6244:607e:d5da:d0fc])
        by smtp.gmail.com with ESMTPSA id
 u19sm8920544wmm.0.2022.02.07.02.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 02:06:54 -0800 (PST)
Message-ID: 
 <e8d78db446c3c0649d0003afdcc7c2f897c6e744.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v3] checksum: Support uri formatted file
 list
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paulo Neves <ptsneves@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Mon, 07 Feb 2022 10:06:53 +0000
In-Reply-To: <20220206134507.123558-1-ptsneves@gmail.com>
References: <20220206134507.123558-1-ptsneves@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Feb 2022 10:06:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13315

On Sun, 2022-02-06 at 14:45 +0100, Paulo Neves wrote:
> Before this commit, if the file list for checksumming had
> files names with spaces there would be a crash. This happened
> due to filelist.split breaking on the file names instead of
> on k:v boundaries. Now we validate this case and emit a fatal
> error if such case is found. This needs to be fatal as the split
> will generate broken k:v from then on.
> 
> Instead of putting literal spaces in the file list the user
> should urlencode the file names and if they contain coded spaces
> they will be decoded. This is consistent with the current
> practice where file names are urlencoded. A reproducer of the
> issue this commit fixes, was to pass a do_compile[file-checksums]
> list with files containing spaces in their names, urlencoded or
> literal.
> 
> Change-Id: I6ac4f1cffbb86e913883491d46e8cc69a028e992
> Signed-off-by: Paulo Neves <ptsneves@gmail.com>
> ---
>  bitbake/lib/bb/checksum.py                   |  9 +++++++--
>  bitbake/lib/bb/fetch2/__init__.py            |  6 +++---
>  meta/classes/base.bbclass                    |  4 +++-
>  meta/lib/oeqa/selftest/cases/lic_checksum.py | 18 ++++++++++++++++++
>  4 files changed, 31 insertions(+), 6 deletions(-)
> 

Since this touches both bitbake and OE-Core I had to split the patch into two to
be able to test it. I did that and found that one of the other selftests fails
when it is applied:

oe-selftest -r layerappend.LayerAppendTests.test_layer_appends

e.g.:

https://autobuilder.yoctoproject.org/typhoon/#/builders/79/builds/3128/steps/14/logs/stdio

but it does this consistently and reproducibly. We'll need to get to the bottom
of that potential regression...

Cheers,

Richard




