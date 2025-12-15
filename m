Return-Path: <osama.abdelkader@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D853AD5B873
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 22:35:20 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7661.1765838111763519469
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Dec 2025 14:35:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=FCbtvFiY;
 spf=pass (domain: gmail.com, ip: 209.85.208.48, mailfrom: osama.abdelkader@gmail.com)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6418b55f86dso5508436a12.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 15 Dec 2025 14:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765838110; x=1766442910; darn=lists.openembedded.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XMgqUjv6rRceBl0J33Z+ggrs0OUuBj2MvvqXhFcauh4=;
        b=FCbtvFiYbkVR35HePF4D+QfhHJb1WNOSwsmcbYi/Yp5hctJHZwKQ8gAQuJelde/oHn
         fRsPx4YNRHeT0MtgMgV8MQB1ndXYciwFd5F1DUoeAVtStxVhLVopyit0hg5MqECErXDt
         oOXDrZgm2vAs++/oE7ZfP9znaNMxp0WSmMWZmTt+QAfmPdSL3yeqi8lXAy+VRI+EKnRs
         0HyNgG5IA/Too0EM/efBpgDXKizW+3JNXL7STehEtMtFStCwJK89PHn6XH4Do+KIYCsz
         NqVxgYuODaqyfQaGiwAYBJ912BXbKLQQKYHEG5hqe2cb0MDpRQAsw6GNIPGqcQqeAUAs
         pliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765838110; x=1766442910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XMgqUjv6rRceBl0J33Z+ggrs0OUuBj2MvvqXhFcauh4=;
        b=dqKnldvDhkRbhPLBIL4s8OVOKq+sK4kAxTrzVpUkasSE2dl3GSMrAIXP/BK4ThEVKg
         Ht80o6kExO1MynYzR95/Q1uyeyCFDuxMEmVRN/HjEKQh67XFcxMbLZygckubrFIYBUTa
         XZiKgtCBn7AXP3MOe5Uh7cILGX6ZP8TwxLL3Q/H1uN6WNExNHzqbx6zvsEn+cJk2i54e
         /nccG0Ow3YD9f1RZWy4NWxaLDs8ZoV4Z8cSjmbXFzUq/mjhSJ4JcVNuLwDDprIbOR+HP
         7Bz45qj/zXNJdVKk3kEbhHVEcPHX9i9hn347ecxLACEJNCnGW+y1B9KkNm14AO+awOWb
         cjrA==
X-Gm-Message-State: AOJu0YxwrCNUfolNOturlzIAIZP4pMwOTur934JoBr6Bbo8aHqnGiMGB
	slc1jmqzeZ/PU+uWNmZ9RZSCDzP9+dUdTtuxpa7ywam+x6o2C+bb5gPM
X-Gm-Gg: AY/fxX73nK8G9Xow0XwCDg1W+8Acd8syUAaKxa4TxD/b+m7L1/nn9AY9HYX7jd7/ch6
	4hfIwvvZVlLrE1GTLfJ0DmUUJQGsbHCCbh8Bew4oOeXX0FRYzGuRqTJGNHnJBQ/ZNcMgjL4VFSg
	obb18ntb7+4loCiTWRmzDuLO3Rkp52ogL1D9KnEaoemnH29mlOFAi3oAWNHJWlqWzrmtwghZEMO
	dgE4+/Hy7aW9uzY9iBwA0+gt+8UvqZQhKPaXDspZ3hGarLpSbOiU3FllgtrNl1hF31RGZWfmnKv
	VYf2u6EUMq4NHMoU82pjujyEPpn5UvD9ZRrc4crq1pEtNfUz6oldIMUELjgNZYhsHI8HWcUn4rm
	39H/Pnb1UvtehXYJ59JaeaIg6Vy77lQ4pHo2e6r60NtbO3ujZgnIGUImuXF5KXxtLM/sWIGksKj
	aSe+qnCMWK133TldXtHTsxNa7xbcbqnrmnPLvYkcYqIPg4reEXM6/p4JpN3QQBLMPYZIUnesP32
	A==
X-Google-Smtp-Source: AGHT+IHramlYw4YTDGZLFbbdqzVaPVclOeBPdRzrA5Dw7ZLFuBEt0wDC6hDKxLbpd29YfeDYE2dkaA==
X-Received: by 2002:a05:6402:2351:b0:641:15d:6b97 with SMTP id 4fb4d7f45d1cf-6499b168a64mr10796070a12.2.1765838109760;
        Mon, 15 Dec 2025 14:35:09 -0800 (PST)
Received: from osama (ipservice-092-208-105-057.092.208.pools.vodafone-ip.de. [92.208.105.57])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-649820f77e3sm14506391a12.18.2025.12.15.14.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 14:35:09 -0800 (PST)
Date: Mon, 15 Dec 2025 23:34:37 +0100
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Paul Barker <paul@pbarker.dev>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 2/4] bitbake-layers: layerindex-fetch: Fix branch
 detection method
Message-ID: <aUCM_Y388wesrBe-@osama>
References: <20251212190806.32476-1-osama.abdelkader@gmail.com>
 <20251212190806.32476-3-osama.abdelkader@gmail.com>
 <016117db60e8c28186fd3ac5d078f9a0de727682.camel@pbarker.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <016117db60e8c28186fd3ac5d078f9a0de727682.camel@pbarker.dev>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Dec 2025 22:35:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18599

On Mon, Dec 15, 2025 at 11:54:20AM +0000, Paul Barker wrote:
> On Fri, 2025-12-12 at 20:08 +0100, Osama Abdelkader wrote:
> > Replace fragile parsing of 'git branch' output with the more reliable
> > 'git rev-parse --abbrev-ref HEAD' command to get the current branch name.
> > This avoids parsing issues and is the recommended way to get the current branch name.
> 
> Do you have a source for this recommendation? I thought the preferred
> command was `git branch --show-current` as that just prints the branch
> name with no extra formatting.

Git commands are divided into two groups:

Porcelain - High level commands intended to be used at the command line
Plumbing - Low level commands intended for use in scripts

git rev-parse is a "plumbing" command, meaning its output format is guaranteed to be stable across different versions of Git.
It reliably outputs only the raw branch name to standard output.

git branch is a "porcelain" command, intended for human users. While git branch --show-current currently behaves helpfully,
the formatting of porcelain commands is theoretically subject to change in future Git releases, which could break your build
scripts unexpectedly.

https://git-scm.com/book/en/v2/Git-Internals-Plumbing-and-Porcelain
https://git-scm.com/docs/git-rev-parse

> 
> Best regards,
> 
> -- 
> Paul Barker
> 

Best regards,
Osama


