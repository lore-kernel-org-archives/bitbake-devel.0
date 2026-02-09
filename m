Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9493DE7E0CD
	for <webhook@archiver.kernel.org>; Mon,  9 Feb 2026 16:57:10 +0000 (UTC)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.52113.1770656221880944032
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Feb 2026 08:57:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=I6OPkWOs;
 spf=pass (domain: gmail.com, ip: 209.85.160.179, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-501488a12cbso56350241cf.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 09 Feb 2026 08:57:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770656221; cv=none;
        d=google.com; s=arc-20240605;
        b=FoyndQFKMQJs4DtTHGkvv6tVFJxOJy5OgG/T4+nmyCF4w27JdLCJrdofBws7nulkvM
         s8BaV7e4FcPnvNHU90h2zH8zo04ePSTOPbQVZ0HO0Z62gHY5hj7lPSKNuMXG7R7t5Uo5
         3PMQJQAiLFEgdn6AD7PaN7nH58LGHHRt+4X37xS/vmLjGVDmAO9BrhStODjqE6Lp4a/Q
         uZQP1rgXv5vx/VsDYUdPOcPN96JMSNgbabj4CFW+s8iQLKZu0DuHAEWTlIXT9d/mh2FY
         qarYqx/Irr99C6OkXW2QnspaYVEenjzZGO5PRV109Lv5+XktMcwnR+JOqh3Wk8wIm20Z
         E5UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mrDue3eLzQJaeePVM6mIUkctnVrmCrJO/fL1KBvFYsI=;
        fh=ipjyoT70VIvOR0iB/vrqcblb8LhgBH+H6fBb7Y+6I3Y=;
        b=lJrVX5gJmlNXUe95OVslVWR7cRQw5KsqgqtLlSxHL2v/WNWqfVM9GoqWwnvjm2XcL9
         RvFnKXDAcgeDXQFvwuWFPAKkXYN/hRhFBbP7E5ZXUyACkDi3vqiqkXb4n/o52+10/i4K
         KIG4J82d0Xv4NN1h1ksl17WEs5Ube56n7yXx6WrIIHjwh5LnPaBazkryU2IHZL8mKd8e
         3MxroPC5NO0JpqosDmBfOksEK+JrEZ6wEataq8y822B5ZIw+DmH0XPIvKtlEAWL0lXe2
         ECIoTGWPH4lPry2z7wqu2rdfM7TC7MA6+9UxeqU13lkQfUfkGX8zlmNQDXNQfvSoGcSG
         YP7g==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770656221; x=1771261021; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mrDue3eLzQJaeePVM6mIUkctnVrmCrJO/fL1KBvFYsI=;
        b=I6OPkWOshg6v4ZjimA7tEJHmyf62gnRJGJR5CPZuzA/pHFv7wBO2hv/KO6BIb2e0Vr
         8/AtY2KFT+Sn2PyEvhln3OPaRqMyop00dduakBR0qM5IpoHyGr0kKdh9itJ/iz6Nwi+J
         8pb1eDO9EmeXm1pZwRZ0lXvt6Abbdrs2lgRKpUdRaGNHoLkv7Ron1q2edIzpHywlvrDt
         GUEMriUyOwUZEyAdPKBvW9fpmpgvzQpDyqRHHUWKXHP1IyF6CZFAf6oHXRUO4iDnnl2E
         EnEJarBxuBnrtGZGe73/u/bufm4Zqqhlf4D9DFKaHRTmrFUPLWypXYdQBgdGNUIG0RLs
         bC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770656221; x=1771261021;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrDue3eLzQJaeePVM6mIUkctnVrmCrJO/fL1KBvFYsI=;
        b=cqiWXEn/y+J8GsDWVnPJE6awjnHmRTt//Zxdu1FezsHOJAZBzVo0TD8MVu7kSdcSMB
         z2vb7UWiTpYMuw7FRhsuwOWKFNqp2Xc3p0x19y2GyUfjVJnLENh9I8Sx+FhApTOI2EHJ
         xB8lknXajVlddFWkHuclNIps6ywMJkPQeF4qin1kE3SUe7cMMx3qxjFM0l9IyelIC9ty
         rAiUTyBbLKces1HSIANDJUKv0czManobzmiaxxmB1W1xtWfChJ8xeP19ElYtmfmJ5tXQ
         3Yt6VZCMzQuKrazK2wqC92dPZUJhDMiGnNUtWgV3E3wGSJrPqb/M9GknctbcQmuCYwUa
         2jtw==
X-Gm-Message-State: AOJu0YzRPn6mMAeQIWXyqjeNf376yzjUO0oKXIEPgAOuPiFr0ZfT6J2J
	x8D3FUEAfFRNQElHzqp3lv7VIur6tD2xU4pfHbelSnL5OAGh0TKAXBatze/IMynbbRuuAGl4w64
	Rm9b2qFNIOnIXUmT/Ud1aUr4hrn113+s=
X-Gm-Gg: AZuq6aLw6mAC5nqEPMMtvcxi8W5yVM24vcbtVFgt6lAE0VuVjxsmTt7IOWSas70sS9X
	42iOdclREDBof34Poh84oVGddPYf+srdUzqwfEkamtB+mtJJscniTW8ppYgOAJDsOsFeWeY0Ovj
	bjVJ4788T5JqWzVlQQ2G9LMZAMJ/OwQakbGcm4N9xXXOEfw2Hj8buzs6ynz8BEvkUz3zE3l/+Dp
	vIP8JyPfeejsvpmFmnSKl9VbxJbIIIVnqeg0VkxHkcn5QLfchbWjvOgPyjPREvrJ/nDm5RszYmA
	iW/IrONi20WDmoFV27j+VQDWhEWKKf3uVOqWsych
X-Received: by 2002:a05:622a:1649:b0:501:492f:bddb with SMTP id
 d75a77b69052e-506398ab2fdmr150778871cf.28.1770656220885; Mon, 09 Feb 2026
 08:57:00 -0800 (PST)
MIME-Version: 1.0
References: <K7wT.1770654725256025131.AKh3@lists.openembedded.org>
In-Reply-To: <K7wT.1770654725256025131.AKh3@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 9 Feb 2026 17:56:48 +0100
X-Gm-Features: AZwV_Qiwr8d3ntj2b0PVmn2YMYp4Mng9uLBV5dy7vFD67-mam50lcpqBKx0o88E
Message-ID: <CANNYZj-pfZ79Uedy0-SNX5Go_gOWy0XpSQDgp7C1a8=kUAPdLw@mail.gmail.com>
Subject: Re: [bitbake-devel] [bitbake][lib/bb/fetch2/git.py] Re-introducing
 --prune option in fetch_cmd #bitbake
To: srbruno@gmail.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Feb 2026 16:57:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18993

On Mon, 9 Feb 2026 at 17:32, Bruno Ferreira via lists.openembedded.org
<srbruno=gmail.com@lists.openembedded.org> wrote:
> In my current project we have several repositories where developers use git branch references in the format:
>
>
> /remotes/origin/foo
> /remotes/origin/foo/bar
>
>
> And sometimes parent references, e.g: "/remotes/origin/foo" get deleted from the upstream repository leading to git fetch issues.
>
>
> error: cannot lock ref 'refs/heads/foo/bar': 'refs/heads/foo' exists; cannot create 'refs/heads/foo/bar'
>
>
> Typically, the way git handles these cases is by adding the --prune option to delete the stale references from the local references and fetching would work.
>
> While investigating what bitbake currently does during fetching for git repositories I've found the current fetch command in the past had the --prune option
> but it was removed due to breaking old releases.
>
> My first question is, is it ok to bring back the --prune option to fetch_cmd or this will still be an issue and it will brake old releases?
>
> Second question, if introducing --prune again is not an option, what would be the recommend approach to introduce this setting via a configuration option on git.py lib?

New fetcher configuration options aren't particularly welcome, as they
need documentation, tests, and create alternative code paths and
complexity.

Perhaps it would help if you show the sequence of steps that leads to
breakage, as it's hard to tell from just the description above what
the problem is exactly.

Alex

