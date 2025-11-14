Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A76CE8D7D
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 19:20:36 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6250.1763148036189521014
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Nov 2025 11:20:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=IDO2xYNv;
 spf=pass (domain: gmail.com, ip: 209.85.219.51, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-88056cab4eeso17330526d6.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 11:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763148035; x=1763752835; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/uxJuuc3qqK5+Tz+UlhWpx131NNSuFle0rpofmZcaZ0=;
        b=IDO2xYNv82dhYdqBVB4xC1nM5YIS08eDDGqEpfWs/yVetSlK60QTK1LcwVSwWRsrkx
         ABzA6P+wP/omAPWdBeWTLPs3tAisTSgTa5uNt1n/b1xwTH8dKjIMYl90pz9QfgjKdHYT
         KXgz0DAHcTJOaOugWLKOGmQzQudykcP0c9Pvc5AWzwkSamobUBo/yram0hr0pCF59SsC
         CvI2gqBY723+5KZlvJWIisYkDIUeBHB8r7nhGmmmZ/AnuO8rT9R7SN4sq5VxYyyso7X5
         JlDOCrpt1qIIr1n4boUoxHJS70ptG3K2qINK60zm4u44D69l08fyvIZhORqLp0EnwIsc
         p+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763148035; x=1763752835;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/uxJuuc3qqK5+Tz+UlhWpx131NNSuFle0rpofmZcaZ0=;
        b=kBm1+NXFoPfLHWzMeqLzp3D2XTatnVR02coPXaMq5h2gq/1tokeExvd2fyLUH2iIGC
         2rzZmpBzz/v1wT71Lm/SRs7hukFVx2b+F9/E46BMLHLHbp/nn3N/5/wF9x80O+oGvXbe
         vXx3t4F/NycfshZqaUw2crDV6wCgZH6Cfl7JJwZZ6Pn7ts9w56CscsO0hbq1D6Boujta
         JRQhiAy5I6f2ZR24r3Dk82pEKK1S+YixQf8qkw5J2MSQnoH0/nmpneaADmdL3ENnrILx
         BCAeeyBrAkEfARIFQClwXZCdG4M63LIGh9PdP/qFrpXa8DHO8MUHKtIVjXEA1fpi1CB7
         hw9Q==
X-Gm-Message-State: AOJu0YzBZzNfjszljiQ7kzaZrQ3eBF1NzwwyfP/s+E56yaD47GzA06x2
	wgbZoc/mSEnc/8teinLb/r1P0BGR6siLLbUX74dmz/ymZViRrfVhPV1GVpoYmRPl56FCPVeHx1W
	C+9rCQThuLSqt3xrNSZw4ujpzx2GRLFI=
X-Gm-Gg: ASbGnctx1VISMgMeojRNLWXnJWw2oO2tFbx9RrLzatFtNfqcg4MkxmuI+OnASyAopQ8
	wjjI3zKJUOsIEuWWr1I8vK4EXPcBA5tfiZBGngpJmj1mScsiwIEf9LZRxQr8szVidyNIPSH7Tdf
	7oW3AkdYr+H5bQk6sidZSUHv559P+fYDD4QxIhg5/Ppk6GAmH2NPqmRAL+nlrP2Cub8V/XJ7iwj
	C598FG7MJ/yU8BrgH9nQH5JShm0jmQeNFQSHv6a1KeORrD8w3Lfn47hqwuQc6rHDcyqv5DVW3pS
	2DXF
X-Google-Smtp-Source: AGHT+IHarOXrxJbXuJMvLRN+WZIxaUOBkUtRsaomlFhHvzvPJv2q6Cf6fgJhqVr6Lub/DoO6v4K2B23QQDpKx6u2j9g=
X-Received: by 2002:ad4:4eed:0:b0:806:c33d:be with SMTP id 6a1803df08f44-88292684b14mr59263706d6.32.1763148035077;
 Fri, 14 Nov 2025 11:20:35 -0800 (PST)
MIME-Version: 1.0
References: <20251114-bitbake-setup-conf-updates-v1-0-990583d8251b@bootlin.com>
 <20251114-bitbake-setup-conf-updates-v1-1-990583d8251b@bootlin.com>
In-Reply-To: <20251114-bitbake-setup-conf-updates-v1-1-990583d8251b@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 14 Nov 2025 20:20:22 +0100
X-Gm-Features: AWmQ_bnoIStWtm_kkPkKBSetm6XaiayHKKAvOmAzWadRJImpmt63cDiVdrIIiYc
Message-ID: <CANNYZj8GTMaqAhgbvJ213mEYtfnD-b9BgJtJV6bC163N2Copxw@mail.gmail.com>
Subject: Re: [docs] [PATCH 1/2] bitbake-setup: update: add a --update-bb-conf option
To: antonin.godard@bootlin.com
Cc: bitbake-devel@lists.openembedded.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, docs@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 19:20:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18412

On Fri, 14 Nov 2025 at 17:44, Antonin Godard via
lists.yoctoproject.org
<antonin.godard=bootlin.com@lists.yoctoproject.org> wrote:
> +    if update_bb_conf == "prompt":
> +        print(f'bitbake-setup can update the BitBake configuration in {setupdir}/conf')
> +        print('This means updating the local.conf, bblayers.conf, and other files in this directory.')
> +        print('A backup will be created for the existing files.')
> +        y_or_n = input('Proceed to update? (y/N): ')
> +        if y_or_n == 'y':
> +            update_bb_conf = 'yes'
> +
> +    if update_bb_conf == "yes":
> +        setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir)

I don't think this is the proper way to implement the feature. Even if
the user answers no, they should still get the new updated config that
they can inspect and integrate into their existing one, so rather than
ask the question here, it should be asked *inside*
setup_bitbake_build(), and only if that function determines that a
config already exists. Then, depending on the answer, it either
renames the old config, and writes a new one (current behavior), or
leaves the current one as it is, and writes the new config into a
newly made separate directory. Then there's existing code to compare
and diff the directories, so if they turn out identical, the redundant
copy is deleted.

Alex

