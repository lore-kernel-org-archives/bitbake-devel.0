Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7143FCCD184
	for <webhook@archiver.kernel.org>; Thu,  9 Oct 2025 16:29:08 +0000 (UTC)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
 by mx.groups.io with SMTP id smtpd.web11.4907.1760027341810748653
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Oct 2025 09:29:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=aQF/6wJ2;
 spf=pass (domain: gmail.com, ip: 209.85.219.43, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-81fdd5d7b59so13924126d6.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 09 Oct 2025 09:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760027341; x=1760632141; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oRmWK5PMqsXrh4zqB29a/bv7lvZad1AivZY4iEldQTg=;
        b=aQF/6wJ2tStdWxNCm7nqOzSG/0jLS8mReqMn3Q5tOtPNqgojAJwcPEqPor/BGS6IFs
         c6rcUYrylSy7sZBVADYlDVgwxGNe3QL9PqSteogZguokEEH4oy255xXpwZlwyodQqrNi
         s3XFPgXq16PzZZ3ZzlJkx2IXj0D4+4cDomAJRJ65ALAB7TML5P+XFmbBw4uFfic+eiqI
         qJKSURqLqux5dmQ39oQBGA7/tVq0Ws9GTuVTehnbsWtGxOsbNwaSQ5WdlvngmhFtYycq
         ccLJGDqzmngn04FhrXZiFt6fxXWVouq/xundaPafUGYAjHmqVItBuc0Rem4YMsFHGMhc
         eGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760027341; x=1760632141;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oRmWK5PMqsXrh4zqB29a/bv7lvZad1AivZY4iEldQTg=;
        b=wIVea9vL3Emee2QQ3bIvjEzHSCXSDpnjAuadLryF4irb0ukTeZTtpuO65SkpwSk6Yk
         6AtGez4yvcphwo4z8H66CnGC3Y0M+tSHrICMcALBAQ/QyWwcvmZGKq7g1s9aUVuxGJw8
         A2kKsEiqzXT84pMMZyzCl2N7/fJO69wRuTAt6VOfdanDIGbtyaCZR8m7QS4YEjQYbP+G
         YxIDhNf3poGsoumHJHyKlcWvQTZt//l0mZxiCdXaSljNjpzZZqHxiIijSWYgAtKkcpSJ
         RtAmCIY3wJSUrP//CYASxsuBSgvNyStTfLhnHNvvOMM3e82kbDw4m/AuWo7orMA4+7x4
         7Xvw==
X-Gm-Message-State: AOJu0YzX6zKf/9fGXXFR70+fMubSvQHiQx/9x3MoMdR+7i9Yun7neL1B
	TEz6XCsrzKDvcXyE0iQgY4WiH68jXcsCBNG76OUKgVkWZcpXVYigAq1u0tYmSO+MrhWNli8KbaS
	kNDzclu1Zf4lOXmmWGjOx56aF9krpmPY=
X-Gm-Gg: ASbGnctuVoi57ujXNTMSlmp8RfYL0wLjxKAScfzA8IKFuLWqak7XEaSO6U+83E74UUX
	W03CMWafpC2SYNW7tBZMwXCAJWtMax0dJLJ2nGEXHFghoUykZ6v9Fly62/na1s70Q+Yo1XWUfeo
	KTNxzYgG4PZQOiLtFMAg6Y6vjkR+e0yq/F+puGowpcEC4r750IIV3xrVKUfnqclj44gCEAIcoTD
	wyo1gKx/iCyJg8Thjxg8m81lmGx/odTsr6x2J1U2c28im5Y+j9wj3e9XgoP4HLaseuPs0DjJHmp
	xVRmXbwJtGuvuU1fgn1t11zk1ETmwnIaYOHSU+wzMgCRSffMspPbp3pq9YzDqd5ATvw4GlROA/4
	=
X-Google-Smtp-Source: AGHT+IHSwNQjrnuv5wPVAAUlQ4WY+9qlXqGqb2vPVeCvjdNFOnFU9yiFTCQ1IBBuUAOejAYb2eJI2cwBIZrgkzd1Jvk=
X-Received: by 2002:a05:6214:2264:b0:80b:11b7:210b with SMTP id
 6a1803df08f44-87b2ef1d927mr81685686d6.43.1760027340807; Thu, 09 Oct 2025
 09:29:00 -0700 (PDT)
MIME-Version: 1.0
References: <20251009160717.2527351-1-yoann.congal@smile.fr>
In-Reply-To: <20251009160717.2527351-1-yoann.congal@smile.fr>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 9 Oct 2025 18:28:48 +0200
X-Gm-Features: AS18NWCjUHGS5yK9L-NwCrU9YFGKSGS5qURV6MzLLgw3eeFF5t7H04ch4Htvb5Y
Message-ID: <CANNYZj-NPGrWypiuh8hU-BB+fM5pVsTh=4ZPOJt6seu-AKN=Cg@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC PATCH] ast: Better variable history for
 builtin fragments
To: yoann.congal@smile.fr
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Oct 2025 16:29:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18152

On Thu, 9 Oct 2025 at 18:07, Yoann Congal via lists.openembedded.org
<yoann.congal=smile.fr@lists.openembedded.org> wrote:
> But, (and this is why this patch is a RFC), on a complex case : adding
> a fragment, another, then the first one again, history looks like this:
>    $ bitbake-getvar MACHINE
>   NOTE: Starting bitbake server...
>   #
>   # $MACHINE [4 operations]
>   #   set .../auto.conf:4     # <<<<=== This line number is wrong
>   #     "qemux86-64 (OE_FRAGMENTS contains "machine/qemux86-64")"
>   #   set .../auto.conf:3
>   #     "test (OE_FRAGMENTS contains "machine/test")"
>   #   set .../auto.conf:4
>   #     "qemux86-64 (OE_FRAGMENTS contains "machine/qemux86-64")"
>   # pre-expansion value:
>   #   "qemux86-64"
>   MACHINE="qemux86-64"
> I don't know how to match OE_FRAGMENTS history with MACHINE history in
> this case. When MACHINE is set to "qemux86-64", how does the code can
> know whether it is the first instance or the second? (My patch take the
> last one)

I don't think this is something we should worry about. The tool for
managing fragments is fixed to not allow this anymore:
https://git.openembedded.org/openembedded-core/commit/?h=master&id=aea2d69d0533bf005cd58eb91fd9b3a3ae194610
and if users end up setting the same built-in fragments multiple times
some other way, that's a misconfiguration on their part.

Alex

