Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C502CD3442
	for <webhook@archiver.kernel.org>; Thu,  7 May 2026 13:51:42 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12420.1778161900330557885
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 May 2026 06:51:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=VWdosW4w;
 spf=pass (domain: gmail.com, ip: 209.85.219.42, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8be236ce888so4924806d6.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 07 May 2026 06:51:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778161899; cv=none;
        d=google.com; s=arc-20240605;
        b=VhbAsbLKOzwAmyXN44JVYfb7nrLQUSrwPExqUFeB49lg8Dd3bJu3Mc7z7c3wttHCTw
         /ZZ1//tsaI1VGZhi7CR4/XO86dqB8EEy/rWsZ9nqY7uXi6pVtwxtWc9HsU2WEVgHVJJC
         gVa5+NMst1c7GJZDQ4N3ZC/x89lKDcx5QY8YUEe7MkT4e9Txvp5sdFxy9RHNzqJCWY/i
         bsMIdibro8gPli8RlNW7mz025dPEybJMy1B6JJWx1vlwNba8gAsxH0PZdgJHQCq40tsZ
         kgGB6e14TN7EsNH7IbvApvInSSnv/9Yd56m/9GGfuBLSn10UxNVqtIbHUQ0TjIhKtUjY
         1c1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+CP347dfiUMUCFfWnO+TGJ9xRxuSBN/N2f1GHGl9PkI=;
        fh=cMY4nU5MvHkPMAt46GPG6DoTBOQZBF1sBZGinoIRT00=;
        b=aeyTn6/Y3bjVCAnW0YaSt2JdvXqtsVNSjBnq2zoZW1g3iPVwSluipRGnjKQNrGojKL
         /aFYPA7K2HehB1OLgaktJNNzZgtm4UOUatqci/CopbjJy55i4uOQ1hYUUL4rELq+bUaY
         D7Via4jVksR/bIkPyotj5AMU0uD6wZDO6Gw7DoP/WzcyWQ4yvomTEqHbsAsf/4hKyUco
         E9nqiJtygxQkDHszqHRzQ232LC/Dmb96d1g7oOCCoLQ2TxYoTpn8eNdulV1mAf9STkZv
         8cL2UaVvC2QY0nwNdc3wtSXmuQM0RL/9G5AlP+oP/MPpwpagfVMks88j7LjWpT4FL1da
         vQDA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778161899; x=1778766699; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+CP347dfiUMUCFfWnO+TGJ9xRxuSBN/N2f1GHGl9PkI=;
        b=VWdosW4w1q/RofawTOkLqw3xIHU4lFSNYA7lhYodQeB+eU5fIJAPRh7YKvM1olZ9zd
         rkkAWw18ophhNtxBBkikFqfipjNMWgRjWunyzlykX+rnd1A6HRJL2oj4RlWkqzmHsyyO
         pAEjTENmlehWZNuiCwqDAmphu8Gp/+rSGGMD6GuKJ3MNS23G6W8wGBGFD1SWCqu9Ia/U
         b3CXCmdhacpavptlk+9H/ENwGfJOsbmYR+Ia7DOATveARv+9M3X+Fge6KWW5jB+CzIlP
         CUc04aseknoLbWDDJt3yojHKZikArtbzNBkE/Ae+5yptw4pRAP1KBZzgnw1Rt5H1oIpM
         hHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778161899; x=1778766699;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CP347dfiUMUCFfWnO+TGJ9xRxuSBN/N2f1GHGl9PkI=;
        b=eSFKgB3k5pB0PdPbVvZhr2E2/DvzO/78tKVvbq1Ny9dp5BFznzISUw7gkhAGxjsyhf
         qKDEtA3w1yiNLpg4A7j7xfjkml1U67zeUj6pTo1wi01zd/QpWlVzIr3GU7uF4EY33dUM
         ZGOJpzGgGSMSWg/Ma0wbV01QWdlMeYhnrMQ6soQGKKwTz0wVMWCJIzshYlutFFXPjU/8
         DWp+yxWIxN+u6lzgqgV5XJCsq0qfU136zHctn7KpKkag1IpikXvLO8DdwZxtP75OfGY+
         A9LRTWmSq4M/NwBk4TIWvUrHdprGKVEdJSjG1KNQqJPZg6109zrQsq/JFQDr8HbMMuhx
         18mQ==
X-Forwarded-Encrypted: i=1; AFNElJ/sJFF+pBKIRYO2d2bJAytF6TGHm6sz6/G4FQ5pDa4iVy4CH6ntAgzxD9M889QDwbs6+nmrbauzAPO9/AHe@lists.openembedded.org
X-Gm-Message-State: AOJu0YwL+6ksnwtgXqL/fxE57tzxuiovtIu3kvCCUidNAH6IBpxuD4B7
	hIWFxFtTun29dju0VGXqB3zJSR8/f9QcVyJFl+pRuwWyB1BQWF9SqS46Fu4FTmfq2iDXyqB2mUE
	4HpBkaI2qwbiZFmAWkLnPOpTd+cDfVAU=
X-Gm-Gg: AeBDietWRF8qzLMQSJqzLjLHx/d/RFUFVd04FspT7V7sp2d+vHKdle/L6ch7fEi06OU
	HD4TzxwYm69SqVvs2SsL5Pqj0cTZaL8Jx4eFaoouLriyxoV2NkLZu3Gzy9HEy9RNNYlTZwL64ec
	CLcRvlb6ODuhhf8Tr65lPB+faUoUi+ujmqP/+7KN896NN6CtBhBhX42/XAWNc5sRNjSgKXoztYr
	a4lBbqGx936PFUcUk02ojBc/rXOtd0Y+cf0BbWBbLU39vvtbgDLMEO48cHjx7WZ2Wyv/HYmT1Ke
	HSRisDszWjkFwayE19h96npY84LhHW8VrcYiCCFBWtXwINHPAJQ4
X-Received: by 2002:a05:6214:29eb:b0:8be:3da0:bba9 with SMTP id
 6a1803df08f44-8be3db001bdmr24417276d6.14.1778161899142; Thu, 07 May 2026
 06:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <CANNYZj-hrSdEoX5XRmM1MYhXMVkqpa0CBHHbMqVhjM034bKTDg@mail.gmail.com>
 <6100A74F-B06F-49D5-9895-DB7D5B563773@arm.com> <CANNYZj9YxLpwDe4pTiT5-WMYUG=6AdV1u=dQHCZt45Pk9QF=xQ@mail.gmail.com>
 <224b7cb95cda25816f49ce2b036a0c9cca437e1e.camel@linuxfoundation.org>
In-Reply-To: <224b7cb95cda25816f49ce2b036a0c9cca437e1e.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 7 May 2026 15:51:26 +0200
X-Gm-Features: AVHnY4IJMzV0_BucWHXHb7cTmkkm_vJZakW29BkigavH_k1-8wdPJU789NqsxP4
Message-ID: <CANNYZj_wSR8fYqcXs7v5KrSYNC6xmkPZrvsU_3Gy92g6-WFWrg@mail.gmail.com>
Subject: Re: [Openembedded-architecture] [bitbake-devel] proposal: build
 pipelines in bitbake-setup
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Ross Burton <Ross.Burton@arm.com>, 
	openembedded-architecture <openembedded-architecture@lists.openembedded.org>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	Yocto-mailing-list <yocto@lists.yoctoproject.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 May 2026 13:51:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19463

On Thu, 7 May 2026 at 15:20, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> The trouble is there are multiple things a user may want to do and
> which one is a hard choice to make. If you have some narrow layer with
> a specific image and application, that is easy. If you have a general
> layer like meta-virtualization, it is unclear which target(s) a given
> user may want. nodistro/poky face the same challenge, the thing the
> user might want "depends".

For such general layers two things come to mind:

1. An example/demo/starting point for one or a handful of most common
use cases. E.g. poky/nodistro would showcase two or three most common
core- images.

2. Running tests for locally made changes, before submitting a patch.
For oe-core/poky that's perhaps unrealistic, but I can imagine
something domain-specific like meta-virtualization could define steps
for this: $ bitbake-setup run test

Alex

