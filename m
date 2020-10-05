Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.web10.36970.1601909004014938636
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 05 Oct 2020 07:43:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=T8OTEtTZ;
 spf=softfail (domain: sakoman.com, ip: 209.85.208.44, mailfrom: steve@sakoman.com)
Received: by mail-ed1-f44.google.com with SMTP id t21so6880029eds.6
        for <bitbake-devel@lists.openembedded.org>; Mon, 05 Oct 2020 07:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fzlJ1lEI4beXxIe1HcVOI390JQ9rHn3P5I9dPaFja6o=;
        b=T8OTEtTZ/ALUCbxWFv2ZkUiXOF2sxWnh2QPeR+Nct1QH3yOVzII6o8MQhnRerXXqm4
         eFcBOv9oE0WDkt+sO3c2UG+OevzZDbbYxUitsaHtIGdsMYAcURXHoYfF+/+4H7p7/ngh
         uhOCdlUVgWZ9/1HCo2ZMMrGxMMj7XFKpZNzRa1htrxcVdlDA4f3eaETz3q50CBxTyKeX
         0Md3dRZvwjfXTLHrlPfYbKBNCq7hXyWkq71oFxpsP3/WMSbOduMIVaEeGfRiwk3BHQmq
         i+rIyGh0r18ITtr8XXSCFJY9OD48gI2ySzE0LMAFdY8WQkTO1nrARjExBf11mrCnYWkj
         EIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fzlJ1lEI4beXxIe1HcVOI390JQ9rHn3P5I9dPaFja6o=;
        b=skuRfL2gLKmkec3xFI5GDp7gS8Bp8XDFsf+DewIcYTiqcU5RkvOictA/5AyuVRnGvL
         YC3KqjDJFohbbuZDfAiHCFo4YduqjQLgQmtfkW61DFpDRlNi5UrY7zj2TQL7fo0jgiFk
         qe1yKntT2wENHRqaheTL9ko47JT50wC0YP1gdDWPQ9eURTJmOjO6WOapU8hJmIZ0hICL
         aMOHfgYSwHRIsTRiq92HqBGSOLb6Kb4ulZllvErYgVLLIZPlMsFq3VUBCqCuKxVf2mvu
         6ALqNAwN0nIMILL+/NXgt02DaMW3dkKmfXKFijzG/9wJk65PD0u3mgfPyfCw1v1vXkhE
         lVHw==
X-Gm-Message-State: AOAM533ENk+each3YKZmTayMLq4Uu+2UZAvZTfc9s8QGiSHjHFlKXl/l
	DBefRK+iofFmHICVXbGrcQkKw3VioBcRwQwAdjSgDQ==
X-Google-Smtp-Source: ABdhPJxyZ/5vR1CJPWfrjtwzV0/FFFXBuw2hNGuuDVpq5CTipmyihLZbpCyBKPrDeK3qBm9eL5F5vGcHnrMVs4pfZoM=
X-Received: by 2002:a05:6402:2076:: with SMTP id bd22mr18202332edb.197.1601909002345;
 Mon, 05 Oct 2020 07:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <f2871b0f-a30e-aaa5-ddfa-3cdf5d67a6e1@whitetree.xyz>
In-Reply-To: <f2871b0f-a30e-aaa5-ddfa-3cdf5d67a6e1@whitetree.xyz>
From: "Steve Sakoman" <steve@sakoman.com>
Date: Mon, 5 Oct 2020 04:43:11 -1000
Message-ID: <CAOSpxdaf+bFtGXkeD0khMUjwa_3+2B+Z7aFz01g--ow6W3S6XA@mail.gmail.com>
Subject: Re: [bitbake-devel] Dunfell Patch Merging?
To: Charlie Davies <charles.davies@whitetree.xyz>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, Oct 5, 2020 at 4:22 AM Charlie Davies
<charles.davies@whitetree.xyz> wrote:
>
> Hi,
>
> A while ago I implemented the following patch set:
>
> bitbake: fetch/git: add support for SRC_URI containing spaces in url
>
> bitbake: tests/fetch: add unit tests for SRC_URI with spaces in url
>
> The patch set was accepted into master branch:
>
> 9ef2bc360d9cfc017a510f4d6ce811e6895672b4
>
> 005f2951e2118c79d99665ce66d5bc9220f4a0b1
>
> In my day to day work I use dunfell so was hoping that this patch set would be included in the dunfell branch. Will this happen?
>
> Out of interest what is the general merging strategy and release cycle?

The process is similar to oe-core for dunfell: submit your patches to
the appropriate mailing list tagged with [dunfell] for oe-core or
[1.46] for bitbake.

If you want patches to be considered for both, then tag with both
master and dunfell/1.46

If there are no objections after a couple of days I'll pull in the
patches and begin testing.

I try to do a release every couple of months-ish when things are feeling stable.

Steve
