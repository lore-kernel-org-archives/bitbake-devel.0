Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B43CD31A14
	for <webhook@archiver.kernel.org>; Wed, 14 Jan 2026 07:01:42 +0000 (UTC)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4988.1768374099193449241
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Jan 2026 23:01:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=L64/4heu;
 spf=pass (domain: gmail.com, ip: 209.85.222.171, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8b29ff9d18cso899358385a.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 13 Jan 2026 23:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768374098; x=1768978898; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FjXaCbzmZnVnScCQ9VI044OKDfwdDwrzv2AMFE4tmJ4=;
        b=L64/4heuRB9xpfj79FG+XgbsWKd18XIsUd77+vI4gsr5jzNWjv94VN451512hED6Or
         LrGjPbU5ACuJDtalLk64cKRhyTvCIWX//sFETrmsjxKDifKjl4gJQuxNUIbm1GfCKJFe
         ONVvf7TdlIa8haiYJy4T/o2jODvbCsH5hj7y3GvmPsjpN/DEs8x/aclWMWjkSAA4dF4V
         syeyw57I8cddUVscvOmGSzHsPPYxIQQJd5GDBIMumEw0Fa0xmGUpIZky1RZU8p87550q
         PeRjaH2gGSjAUxV5BWUEb8azbhfDRvRgOE2Mj9qB5Rhg/2c0EptAkab0XdItlkLOrqVQ
         E7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768374098; x=1768978898;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FjXaCbzmZnVnScCQ9VI044OKDfwdDwrzv2AMFE4tmJ4=;
        b=eUbRcb5RrEBFcgRh9vnwBP2MJ73bpHjZInI5Q1cfQ2glG8LJ0wLrPrAHemqPjiVGJL
         LKcBLLWLmiFbRsg2gofBecT/H7jKNey0u/mNJp793aNtaZOmn+4Fo3ZyPpLE4KaRk9Cm
         gqXKGpnwASMgDBN8dzHuIIK6rqZHpG24G/hxjdKHSKbyRrT0u9ynpTK8SZh7liMBak8e
         l4EpXC6P7V2bst325rdNPIYDJxpZ7+h9NkyMXzeHwRVypmuedTlXVg9ZK9dFljtTbdTJ
         n5vC8x7LRJ4iUCoyPzwP9PR/jaHggx3c/YCmDdTofPIASY3WkEU97vVp5OlC4ISq9q6W
         DpPg==
X-Forwarded-Encrypted: i=1; AJvYcCXUUe7OreA/kSH1o+oRabtwTIDyLiqd2g2ew1vTMI6Gh+CP9iQtULfX5HR3MgdusHYvE0JA2QrBwfmta0QL@lists.openembedded.org
X-Gm-Message-State: AOJu0YwW+sZMyVTYAvRerLr3j+Lzbk5GPpn6Qtvd/CGAP+2MaB5WOKbX
	HhkOkBb5mApUaX+v3XxMQR4srumD3Gcl+ybNFTOAxn3o56IUhOe5YGuovw8qLFA0POTm7j2MdOE
	ZFYnZeaXqxj7CiEd6A5DjMa6nNCBGw38=
X-Gm-Gg: AY/fxX7v8+XUSkb/JKr96PcOPcSukGSICn1iOgdqHRRGFWri2Et53TcW+2mdp8F6zN5
	bN9vvesyegYdm67ZcHBigKsrHlq/Xu8x4Xxhu1Xu6tudv4+YuF0MfS759EsaXgkqfZHZPDDa8ii
	OAbMhWd6pqU031FR2uCK1ipsPLeKqaw85EjXw8j4ja8pR44/tW3stbOjPvWnWyldAYsfK702yL1
	vFVV6qFOP6+9D1dU0aT9eoziUgLB4SyDBbxPOeik39LT/051A8D4m/lLxg317iC1qyvKSdP
X-Received: by 2002:a05:620a:bc7:b0:8b3:9e:3124 with SMTP id
 af79cd13be357-8c531808022mr125801585a.64.1768374097920; Tue, 13 Jan 2026
 23:01:37 -0800 (PST)
MIME-Version: 1.0
References: <CAP9ODKqqWj-_1V4P0o-DhDSXBXy_6aBuAC9r==zud3k-3RZ5dg@mail.gmail.com>
 <ea841ef89441f2d3efd4b81006b93f1695af1e2f.camel@linuxfoundation.org>
 <CANNYZj-vTVM3XMzo2yUWTV+DZPSy_=FMWq-QozcnPiz6SMbysQ@mail.gmail.com>
 <CAP9ODKotNQtqJu5uAiWmyvrAcD5c=0PhbcnhUVjOq=whbrTeWw@mail.gmail.com>
 <CANNYZj_nUe_eGcs3ckZNtubTBHBt6utgO055fDJ2k6rc8oX3gw@mail.gmail.com> <DM8PR11MB56556083B2D363FD68788438E18EA@DM8PR11MB5655.namprd11.prod.outlook.com>
In-Reply-To: <DM8PR11MB56556083B2D363FD68788438E18EA@DM8PR11MB5655.namprd11.prod.outlook.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 14 Jan 2026 08:01:28 +0100
X-Gm-Features: AZwV_Qj56jXedA4qz31OtHuKbrVAMcX-c8kDMJbL9O1S0mfdyejWBaGv9stvmmc
Message-ID: <CANNYZj8nFBDKUtHjXTsdxDJJ2kTOzTRSFhuwr1zt67OSedp2pQ@mail.gmail.com>
Subject: publishing bitbake-setup on pypi
To: "Woolley, Rob" <Rob.Woolley@windriver.com>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Cc: Tim Orling <tim.orling@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 14 Jan 2026 07:01:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18747

On Tue, 13 Jan 2026 at 18:14, Woolley, Rob <Rob.Woolley@windriver.com> wrote:
> I have published a small repo that shows how I packaged PyPI: https://github.com/robwoolley/bitbake-setup
>
> @Alexander Kanavin let me know how you would like to proceed.
>
> I am happy to work to maintain the PyPI workflow and set up tests to automate how it is tested and packaged.

Thanks! Let's continue on bitbake-devel.

I would suggest this:
- we should avoid separate repositories. All three files should find a
place inside bitbake repo itself.
- the steps in the readme (e.g. copying files around to created the
needed tree structure so that pypi packaging can happen) should be a
script: pypi-bitbake-setup.py
- there should be a test for making a pypi package that executes all
of the steps, and produces a .whl file, just short of actually
publishing it. You can extend lib/bb/tests/setup.py for example. Even
better if the test would install that package, and run 'bitbake-setup
list' from it, as a smoke test.

As for making sure pypi packaged bitbake-setup can find standard
configurations, I thought about this for a bit, and I think we should
not package them into pypi at all. Rather bitbake-setup should be
configured to use bitbake repo as a configuration registry. This will
ensure it will always have latest configurations, without having to
update the pip package, and will keep the code and packaging simpler.
I'll propose a patch for this that I would like you to test.

Cheers,
Alex

