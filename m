Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D810EB64D7
	for <webhook@archiver.kernel.org>; Fri, 16 Jun 2023 07:38:01 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web11.3357.1686901072267164242
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 16 Jun 2023 00:37:52 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@linuxfoundation.org header.s=google header.b=Qc063dVC;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3110a5f2832so1194223f8f.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 16 Jun 2023 00:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1686901071; x=1689493071;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ITHZwuccEIcRKPIF8XEy8d1xZWLHAVOjeScr+ZK4e0=;
        b=Qc063dVCB9XPgxDilGyyUARdUEoD7UvohpwMEgKE1MaF5if3ZnfqDaZYz/qX2BWppl
         89YfeFPrrtQ6Uf4k6+yR3cPyxK4HsM4eyOKvCICkt3Nr01ZdaT7XzoKJHHoTeTjr8B6E
         hP4iemxSp0hMkisZZbDoHWx+a8gMS/o/Y4IMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686901071; x=1689493071;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2ITHZwuccEIcRKPIF8XEy8d1xZWLHAVOjeScr+ZK4e0=;
        b=h9Ni7dlJyyH/XhwtMXMkduzlRyds9Z0ZqoyIsZp4XL8B6NCBWJ47+BhOq4J6vcRyl3
         Ed1+Y7J13j+Pc0sscm5B7QSXHWWjBE/0KUxmicFe5pfQfjp+Ih55UNht1Xr/ih8Bgpho
         K2YJUU3qA84P4b5sETu7Bg/TB5lWyzJifgZTP261oM8bupwVaSLDolEqJ74WRrZCL5Qa
         uqo88s5nKdkP+mi4F+1pWbhXhW1pa28BA90jBJT3fdDDf2mpieX7wsnhyNb/HaeMAvLg
         U8MzC6ukFfSB/JrKCeO6fOkplsNou6UhIe8PAmJKFSvU23P+nUtwguJW1/ZWhOKvuuVn
         B+OQ==
X-Gm-Message-State: AC+VfDzGUoobZ0TZXCosnVrhPgaTJ9bVYA/ben04e4OxBAos+u449qLr
	Y2RN2deqBGBohMZQhKwWd6VeYmtn2TL+Jmor5Oc=
X-Google-Smtp-Source: ACHHUZ6+tBLacB+wVdnRXsK0XmjsuziX5fbAVvK2MpO63lL6Qk1xpAOYiO3NiyNlkxcMOtQP7BWNZg==
X-Received: by 2002:adf:f503:0:b0:311:ab6:1a8e with SMTP id q3-20020adff503000000b003110ab61a8emr824705wro.9.1686901070759;
        Fri, 16 Jun 2023 00:37:50 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:b814:609:2b03:c353? ([2001:8b0:aba:5f3c:b814:609:2b03:c353])
        by smtp.gmail.com with ESMTPSA id m6-20020a5d6246000000b0030e52d4c1bcsm23080361wrv.71.2023.06.16.00.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 00:37:50 -0700 (PDT)
Message-ID: <243f996ab30e88244b73c0d6eb6c7d00e7766ac5.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Support packaging
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Wu Zhenyu <wuzhenyu@ustc.edu>, bitbake-devel@lists.openembedded.org
Date: Fri, 16 Jun 2023 08:37:49 +0100
In-Reply-To: <gu3erz2kuwv6e4nijjwavi2pci2ohlfcoaornwyicfsufgii7p@wsazr62z42tf>
References: 
	<gu3erz2kuwv6e4nijjwavi2pci2ohlfcoaornwyicfsufgii7p@wsazr62z42tf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 16 Jun 2023 07:38:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14837

On Fri, 2023-06-16 at 14:44 +0800, Wu Zhenyu wrote:
> use `python -m build` to package
> ---
>  .gitignore               | 130 ++++++++++++++++++++++++++++++++++++++-
>  lib/bb/server/process.py |   5 +-
>  pyproject.toml           | 109 ++++++++++++++++++++++++++++++++
>  3 files changed, 240 insertions(+), 4 deletions(-)
>  create mode 100644 pyproject.toml

I believe we said no to this in bugzilla recently.

The issue is that bitbake's version is tied to the release you're
building. If you start including this on pypi or with packaging it with
distros themselves, people will complain that the version doesn't match
the one needed for the release they're currently building. Changing
that requires API commitments we've not been able to make.

Yes, multiple versions on pypi and selecting the one you want in a
python venv would be nice and one way to avoid that but once in pypi,
the support issues arising from people using it in a way we've not
intended would likely outweigh that.

By not having a pyproject.toml file, we make it clear that we don't
support using bitbake in that way.

Cheers,

Richard



