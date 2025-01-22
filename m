Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4506C02181
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 09:43:39 +0000 (UTC)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
 by mx.groups.io with SMTP id smtpd.web11.39520.1737539013494966701
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Jan 2025 01:43:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=PLVfmvY1;
 spf=pass (domain: gmail.com, ip: 209.85.160.169, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4678cce3d60so14238081cf.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 22 Jan 2025 01:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737539012; x=1738143812; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MMVIXZSF9G8Wu6ZprjjIjaBiY6usX+l/Ky1/lJ0CxCE=;
        b=PLVfmvY1+rFMRLgNE0BpvfQiY3vGyc5X4/HkfWhFWgp+WHrPyZ5JnM1RWyeMi3Q8uM
         2+gz/4z0s/EaJU25q484dkUB/Ruay02rTJqNQRHhYbGb/nCwpam9aP8OgFj0mS5fA9PO
         BMYvIGSGHw9AT1e0ELBpLS3AB7fqArc9uvm4f00mh5OnYv77q6sVx4YS2DYid9h04Cqj
         jCWFZfm1VtzUoaH3KVMT2rRax2USnXq+qVC/SSgkVWeMy8sjwJiOahlpb/FbrViFlC3G
         DhJNJJ0p87CgKGPGSiyG8jSuVKBupJNiX9hjPmGrtjsH6FocIddHvPoArFHeCtW3gQE+
         5cvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737539012; x=1738143812;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MMVIXZSF9G8Wu6ZprjjIjaBiY6usX+l/Ky1/lJ0CxCE=;
        b=bIs9laeRpHtGyvj8FMiEwMkCcZagA/CUYqL42vLDh3Y4W0TS3vCv1gKxxnryiXyNIw
         ZdwuP6cMv+yFClkyNjqnUh/bQjKO9fR5MhtYYvRuLnrFCHQnM1HRgZhTnDVEwHSpVREz
         k1gbhx3McU/v9kOzGhl3+w/zAp72ukfae0Ckug/4TNvKUErHzk7eJ72dav4uho1vFWMa
         6Erp04K0EKUqbyjZo6aApSKAvqh8S3g+6wMVgS46nyt2Y6n8Il178tCXeSyZi8Rw0oCE
         7E3m9sp2k5e8/gjsd8l53TktBYM/7SU7feS2uYe5H2leo7mxffZle6/adbUMVUZJr0Tr
         ApOQ==
X-Gm-Message-State: AOJu0Yz35a6PxnUNLk3atqaobVjbDP72/2onMTLIOXwZMDMiT9krmZyR
	VGDSl5ZG6/ij7G9mLCxsDFDyzgi4SWnl5GLUhagbSTDsTVf8FP6FW/0Qscktf9AlZT9wNuCJ1aE
	ZvYH9qXb+5s1hB1mfTlarOy/Dosfimw==
X-Gm-Gg: ASbGncuFuuOPLxUnVxXaZXNYFSj0C/WyBawdBSAQUy6ivf5wA4MwF2wVqIYtHcqRlUg
	6aUVlSvv82q6BWt7o3Dg231HR4y+ShEc/yl0exul6E2c4a6uKVkAys32w7PZpNrT52A0Chhnfmp
	tOCwFLWYp+qA==
X-Google-Smtp-Source: AGHT+IHgthKWOvG0DKPXeiGRVX7L6ig295GpZYwrkMSBCToEtnwNnCqBbg7XyAZmoWpWBXMJ+fz2S5kAjrgjwAhz/Aw=
X-Received: by 2002:ac8:59c1:0:b0:467:50d0:8869 with SMTP id
 d75a77b69052e-46e12a58407mr287845761cf.18.1737539012379; Wed, 22 Jan 2025
 01:43:32 -0800 (PST)
MIME-Version: 1.0
References: <181B8041053EB73B.1562@lists.openembedded.org>
In-Reply-To: <181B8041053EB73B.1562@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 22 Jan 2025 10:43:21 +0100
X-Gm-Features: AbW1kvadeKNd-eBSmsihZT55ByDSJ89p2Vil9wLAMZoqL_ZLqBt8BvuQFtwAOkg
Message-ID: <CANNYZj_7L03Tp9c=Ps1KAmvWW4=5_9LEVOCyh88FfUbs8GxfKA@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC PATCH 1/2] bitbake-setup: add the proof of
 concept implementation
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Jan 2025 09:43:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17056

On Fri, 17 Jan 2025 at 15:11, Alexander Kanavin via
lists.openembedded.org <alex.kanavin=gmail.com@lists.openembedded.org>
wrote:
> Default parameter values are in /home/alex/.bitbake-setup/config - adjust as needed.
>
> Fetching configuration repository git://github.com/kanavin/bitbake-setup-configurations.git;protocol=https;branch=main;rev=main into /home/alex/.bitbake-setup/configurations

After some consideration I've concluded that placing the bitbake-setup
tool configuration and caches into hardcoded ~/.bitbake-setup/ is not
the best idea. Rather, the tool should write and read everything using
a 'top level' directory, which can be set via command line switch,
environment variable, or a default of ~/bitbake-builds/, in that
priority order.

There should also be an additional operation called
'write-tool-config' or similar, which would do nothing except write
out the standard tool config to the top level directory. That way it
can be inspected and modified (for example to point to a different
build config repo or dl_dir) prior to any actual build init or to
listing available configurations (which would do fetches using that
config etc.). One can still start directly with 'init' or 'list' but
then a default config will be written out to the top level directory
without asking.

Automated bootstrapping from nothing is tricky to get right :)

Alex

