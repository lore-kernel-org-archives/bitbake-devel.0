Return-Path: <osama.abdelkader@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A7CD78797
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 16:05:20 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20062.1766160311525452335
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Dec 2025 08:05:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=NKGdQMaF;
 spf=pass (domain: gmail.com, ip: 209.85.208.44, mailfrom: osama.abdelkader@gmail.com)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64b9b0b4d5dso1421331a12.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 19 Dec 2025 08:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766160310; x=1766765110; darn=lists.openembedded.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H4EBgPMqbpREH3j+aEZwz/ahgP5Z6spWwHpbaNUUXp4=;
        b=NKGdQMaF8ur2H5YCzKZ8AimlEUujBLBfSAIr2KAOL6QlIXN/LZo1t3aNJ3ufws3V+0
         Ebay5hc6QJzuz9pjy9uTZCI/DddZsA7bI0mLib4nMzFTQy/nwj7RaVAP/oEwmFtRGzlZ
         QIXdTEzPWZyEl1oNEiRUaMs6ENz0ObNrJQiUMFCgPcO2J6rFfwbjXMj2VM/5U8pw07I+
         FS9yk3kLuHxvmZFpJpYN87uqRC1Z+QcR8P1ULUfPsmGsn+ynPRbhV5Zl/mMbgRsbSbN+
         2UaxVMsrxwBcCCBR8+21DkeSnEc+K6FvUFzx+x926RcT1j22uRxbjE7tIs8xV8B1N7GD
         CpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766160310; x=1766765110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H4EBgPMqbpREH3j+aEZwz/ahgP5Z6spWwHpbaNUUXp4=;
        b=WXaKr6cSBpzQXt8oHiZSOXMFc47Nl5xub75YKCZUTWLPEVQ0KIDxTNN0p9BPBYJ5u0
         8mH54EtFZ18g1oPV2bq1knb+Bcv9dVqjdw/6KM9D5g+Pn8HxSURW5JS6dTi4rTCJC+jk
         dqVwAeYjF8rSVpf8bpFH+QaJI6G1KBtd9u0Mcq0UVjrjRuVcz5hWtZr6jjJk1GhAW3tU
         yU1Z9rOKmf99lbxWvEbnp6apd8VLt+vfnBOSzsrDYa7OstVx4NtUaobnTYN0gmnkqCeH
         6PfJFD4dGqWu3mnzt+/2IfK1QP5z9Sv9Liy6jlUe5hJjwCMLyeA5BObQDEiZlg+QNyVB
         uDEg==
X-Gm-Message-State: AOJu0YzJzGMOOgvFx2Ko/45t9jnbyBhftl3lymJC3t/6FzUtKtRGJZA9
	OdfSlTvoYtDDRLAR+qv8uGhBJyNFVTPL79okQnHICYt8c3QcCHQX/IC+
X-Gm-Gg: AY/fxX7y/5cboW8DFpkkfryIZcie02k3jBKM30Z3Q+TT52r/JuLza98pnc10ZaCIC1E
	6PjO3ptCBMC+mBznxqE2NVbIBRP+a3BM0WHoAFE9n2KB08kLqmwV1bEJOIj4IzJipiV/EHJxwyv
	HRV9XnepkF56UqdrpjJpRYleBO/xUu/Zn5/ywboDxh7Zt6QqZFZFe1gcYYHl70qi6TkNKPh3s2F
	NDiFTc16HZEAFlXnUYOTw4QRVZU3QYc+ycT7nVj1dpC2v79FkQZZalogOBxr0/sXKGDVpQbBF/w
	z5YfFz3FeHpC8hrLLaJ6hGIw8kPW9B19gxFOP7/tNcnAqkoZxU7Po49JNffCsIBN2RpyomVt3vv
	+xoB/adnVf9je/Ie7jsBjc0CclPcEebVgG59xYwcP8zsGCGJUnEAX4jwhCnxPQ63m9fNfqPqtfy
	/IWkT85CaqoA==
X-Google-Smtp-Source: AGHT+IEUX92qUEIHpuXbCdvDio8kUEEcU80WzvseKwl6HB6HEhL6jJrW0YW/HYGU7ikiJ5j114tT1w==
X-Received: by 2002:a17:906:f5a3:b0:b73:1baa:6424 with SMTP id a640c23a62f3a-b8037185956mr343918066b.55.1766160309167;
        Fri, 19 Dec 2025 08:05:09 -0800 (PST)
Received: from osama ([2a02:908:1b4:dac0:27:4771:315a:aa0f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f37ee8sm254963366b.59.2025.12.19.08.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 08:05:08 -0800 (PST)
Date: Fri, 19 Dec 2025 17:05:06 +0100
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Paul Barker <paul@pbarker.dev>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 2/4] bitbake-layers: layerindex-fetch: Fix branch
 detection method
Message-ID: <aUV3si3v8V-021Wi@osama>
References: <20251212190806.32476-1-osama.abdelkader@gmail.com>
 <20251212190806.32476-3-osama.abdelkader@gmail.com>
 <016117db60e8c28186fd3ac5d078f9a0de727682.camel@pbarker.dev>
 <aUCM_Y388wesrBe-@osama>
 <c84892212ed26bf08b1e7447391188ea5793a8a3.camel@pbarker.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c84892212ed26bf08b1e7447391188ea5793a8a3.camel@pbarker.dev>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 19 Dec 2025 16:05:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18622

On Thu, Dec 18, 2025 at 07:39:28PM +0000, Paul Barker wrote:
> On Mon, 2025-12-15 at 23:34 +0100, Osama Abdelkader wrote:
> > On Mon, Dec 15, 2025 at 11:54:20AM +0000, Paul Barker wrote:
> > > On Fri, 2025-12-12 at 20:08 +0100, Osama Abdelkader wrote:
> > > > Replace fragile parsing of 'git branch' output with the more reliable
> > > > 'git rev-parse --abbrev-ref HEAD' command to get the current branch name.
> > > > This avoids parsing issues and is the recommended way to get the current branch name.
> > > 
> > > Do you have a source for this recommendation? I thought the preferred
> > > command was `git branch --show-current` as that just prints the branch
> > > name with no extra formatting.
> > 
> > Git commands are divided into two groups:
> > 
> > Porcelain - High level commands intended to be used at the command line
> > Plumbing - Low level commands intended for use in scripts
> > 
> > git rev-parse is a "plumbing" command, meaning its output format is guaranteed to be stable across different versions of Git.
> > It reliably outputs only the raw branch name to standard output.
> > 
> > git branch is a "porcelain" command, intended for human users. While git branch --show-current currently behaves helpfully,
> > the formatting of porcelain commands is theoretically subject to change in future Git releases, which could break your build
> > scripts unexpectedly.
> > 
> > https://git-scm.com/book/en/v2/Git-Internals-Plumbing-and-Porcelain
> > https://git-scm.com/docs/git-rev-parse
> 
> Hi Osama,
> 
> Thanks for the additional context! We discussed this on the patch review
> call today.
> 
> `git rev-parse --abbrev-ref` is definitely an improvement over calling
> `git branch`, but we have still seen some issues with this command in
> other contexts on the autobuilder. The best command to use seems to be
> `git name-rev --name-only` [1].
> 
> [1]: https://git.yoctoproject.org/yocto-autobuilder-helper/commit/?id=1e80c19f62169c536e44f99fdcdf9f1e84c65d99
> 
> Best regards,
> 
> -- 
> Paul Barker
> 

Hi Paul,

Thanks for the review, okay will change to that.

Best regards,
Osama

