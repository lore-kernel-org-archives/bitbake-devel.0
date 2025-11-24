Return-Path: <osama.abdelkader@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3DDCFD349
	for <webhook@archiver.kernel.org>; Mon, 24 Nov 2025 18:42:39 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24228.1764009752781505695
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Nov 2025 10:42:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=EeUyWLwO;
 spf=pass (domain: gmail.com, ip: 209.85.128.48, mailfrom: osama.abdelkader@gmail.com)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4775ae5684fso22314805e9.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 24 Nov 2025 10:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764009751; x=1764614551; darn=lists.openembedded.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RexbbP48O2v9cPwJCIy4Kj20+fnQIgi6CKQIvVtS59E=;
        b=EeUyWLwOLjVaqo5mZMiogmiWWp9+KuTzfyC69ep53e4ZC2tohHu4TJc9Gaa5rs8KrF
         8qIa+LtkqfskCJVszHCWcSnSRpuWbOloFHKd2cbqApsXhH3jgcdeF3Avxyla/oGC6DUC
         qqbr8Fc77BjPK8vbrXJ1B4ZvxVMHTCVDtvZRD6p8WOSJ/2IXkBQ5RGi2f1A7aEu8BjzT
         CSE2d5jMTUaNipc47FQMzPStNko3Shqi5uTyqhPAXUmNBlFwO34MFt0SQhdum1t19isP
         yCJ0WsHgcXIQqFzuKVbFqBwW7kzZN/I72X7722a8JNmwtM4WXzHa8RgyaCd+U6DH0QkE
         PJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764009751; x=1764614551;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RexbbP48O2v9cPwJCIy4Kj20+fnQIgi6CKQIvVtS59E=;
        b=YJ+1hNGxC7+wWvu9PAk3WODAsuuMpXXHm3SzN/r9xjeokrXmWpOfYcLY7/OlVwoHL4
         /F7n15LK7XtCo9R2ua/TBVG9kQWnjpxUW1HRaRa6lHAB+zDLa+PGw1z5NJWFxIxaEZIm
         CteU83wgYb7Q13StUfmr+pBaJaxSMyuzLtGnNYE752qaFYDAOZG54bvTTS7QtTl5tMVY
         Am1IQ+ziyGQhO/Vypufckuty69ar1fc49n31dCWQQQyK7G9RQATc8wEuiAaU1kK7ksb7
         0C8U/uqlTSgz4LHmT4UXZkh3Vn9kEwsUfGhP95KkEGfKoMIHfPV40XkviV8FBcbjMw6G
         T0Mg==
X-Forwarded-Encrypted: i=1; AJvYcCW/HxyE6p5K682dn1XCEFTSdhHZ6cjxDoLmDl4tKbBUt1pJAZVbmF0f96mtQ2EqqoDeghAtRbRcwg/orHRJ@lists.openembedded.org
X-Gm-Message-State: AOJu0YzNE4GpSbNY2cAql00BPML55+Zall/wGgHzb2TIRIFJYaefP6vi
	Dj1E4HGM+YCVXfEjNNvBhECjov23w/jo6IIccwc4jTKc5ZoXXFQq05Lr
X-Gm-Gg: ASbGncvRQtsyelZpFc8+ypOJ186m2AXRXo38+Ksq3xH2TmPvPiwNKUXgbTDzrLL2f/d
	iLl28iqTvOMonqFf6LcMWpdaVdJKuX0DhImeaBQhygQQBGaA7/bI89NW9KWOrw/8iRhgJcOipMl
	b75iatz/Baj9tXkJsgd74RTpzmzZIUrt7ZMrIRIQDwD6IHZP38aikJrGUrLg1tTMKzQMKwiXmvx
	AUs0Pa8Dmkh1BpBrw+e3s2rs046XYsb2+GOyMzDZV2HwLiJxPiz83NV3iHnIsKOM6TMmF5CSbTN
	MgwrSykqmMWiKDVVhIo1JofzspvH0Dn+rQDC1eXzkn7eUqedzScws1NFBC7xXM/6ebO6atqd/Ub
	WZZn+N0pTIXqlYXkzdVXOsuZILgNbQWPFQ00BtbXp6UpMQDtPLA7mPM3witlXXYorFlxbuQSs39
	+KMGh38UjUAxwx
X-Google-Smtp-Source: AGHT+IGA8XkkNksn9QgHMWHDKR7kugq5WGufIarxJc4d9CNy4fvBigYN9bml4yEnuFRbd8uuiH2yKQ==
X-Received: by 2002:a05:600c:8b16:b0:475:dd8d:2f52 with SMTP id 5b1f17b1804b1-477c115dc85mr106681015e9.32.1764009750920;
        Mon, 24 Nov 2025 10:42:30 -0800 (PST)
Received: from osama ([156.223.112.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf355933sm215768795e9.2.2025.11.24.10.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 10:42:30 -0800 (PST)
Date: Mon, 24 Nov 2025 20:42:27 +0200
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: yocto@lists.yoctoproject.org, bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [RFC] Proposal: New tool to display recipe
 dependency trees
Message-ID: <aSSnE0X9kycDc60G@osama>
References: <aSSUtHYFQlychNQk@osama>
 <CANNYZj85vK7o4KVDUtJ_DkW73bxs7UMA-bM6K2VRada-yCFpfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANNYZj85vK7o4KVDUtJ_DkW73bxs7UMA-bM6K2VRada-yCFpfA@mail.gmail.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 24 Nov 2025 18:42:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18483

On Mon, Nov 24, 2025 at 07:04:12PM +0100, Alexander Kanavin wrote:
> On Mon, 24 Nov 2025 at 18:24, Osama Abdelkader via
> lists.openembedded.org
> <osama.abdelkader=gmail.com@lists.openembedded.org> wrote:
> > Should the tool:
> >
> > cover only DEPENDS (build-time)?
> > include RDEPENDS with pkgdata?
> > resolve virtual/ providers?
> >
> > Any prior work I may have missed?
> >
> > If the idea is acceptable, I will prepare a proper implementation and send a patchset to the appropriate mailing list.
> > Thank you for your feedback!
>

Hello Alex,
 
> Hello Osama,
> 
> DEPENDS is a somewhat unfortunate variable name that we're stuck with.
> 
> It does not actually specify a recipe dependency, it specifies
> something more specific:
> 
> - run A.do_populate_sysroot before B.do_prepare_recipe_sysroot (a task
> dependency)
> - within B.do_prepare_recipe_sysroot task, take the output that
> A.do_populate_sysroot produced and place that into B's sysroot (a hint
> for sysroot creation)

Yes, I know that.
> 
> So I feel that any tool that aims to make things easier should
> continue to present particular tasks; there's really no such thing as
> 'recipe-level dependency'.
> 
> In addition to that RDEPENDS is not specifying recipes. It is
> specifying packages that the recipes produce (which sometimes match
> the recipe names, but are otherwise distinct). You really should not
> mix them together.
> 
> I guess the question we need to ask is why 'bitbake -g' output is
> difficult to understand or unhelpful in resolving questions people
> have about dependencies. How can we make that better?

Exactly. 
For me, the output dot file usually is so large and not "human-friendly" to trace.
> 
> Alex

My motivation actually was so simple, to know why a certain package is needed in an image.
The simple way now AFAIK is to exclude it, then bitbake prints backtrace e.g.

dnf
 ├── libdnf
 │    ├── libsolv
 │    └── json-c
 └── sqlite3

dnf -> libdnf -> libsolv

libsolv is needed for dnf. so would be good to have a query command or simple tool to show that?
something like apt-rdepends output.

BR,
Osama

