Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781B1D46605
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 17:32:17 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.171.1768498336627098453
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Jan 2026 09:32:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Mr6+iE7F;
 spf=pass (domain: gmail.com, ip: 209.85.219.47, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-88fe44cce7eso12871926d6.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 09:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768498336; x=1769103136; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WWES23676Rn0ZPzv8ZN6pgy5V76xXEpp039ND5w2pRA=;
        b=Mr6+iE7FQYwS1aJyy5ZbqqPL6EnbCiZfkgQ7Q/eQV17LLx39ovR67NhzFYm13qexsO
         6cl+rZVVjh7z3I4YU5LDkoCkKKHcIXRC7Wn949mimZ98nypphTpHPztCy8rybqmpPWY7
         Qh34YZ/1YX3aMI9gza0p45YDd3vPNtJZuWaSa70LlwudMRjr889Xevx9XgE5zvRIF+9x
         yww7n4dGAYHV/qN/1SvLAKf4AZZinNka04tIXVLxG34pHaEHcA3O1nq8pRNi5P0eZz7Z
         6Ut3HgImMCDnMScagxCTlMnHYbKAfx5NZOxGOOn3lsFrO2GVLtuHjjXXXXS18X3LrFE+
         qeIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768498336; x=1769103136;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWES23676Rn0ZPzv8ZN6pgy5V76xXEpp039ND5w2pRA=;
        b=TT96vBfOqrYnkd4zOeILs/Ie/Ofa1/K9c/ay7H5Yd5aPJohcCRVKBMK5Bieswe3CNs
         P8uYoAmfW1q4iF5T3vLpNhFftSqaK4RDz3/yWJBmG4GOO3E3OFWAdX9sj0DXJs45mvd2
         xfh9R6KebJx5CTEUL141CNkOAiLEkG8wgDjHzwdImxJbt8cnW5EnlL3E1kec6S+w0VG9
         evzY1eC2P8Fg3P/hUD0NJ1RNziHyo4IavXddDsbuVvM6uPA0dq/+XXsWNRhHb43zsaN2
         OKtTN83ne8gcbPTsWJ+Jl+iPp34/0ispndJXLS2vKleLZ82L2Yqy+045ljUkuGnPhdgD
         2XOA==
X-Gm-Message-State: AOJu0YxlSQIPQuJR9J9IFIPH7E6gU8Oi/sGkW5TXpgy04JSLryX3BAgJ
	23yxV6inLO0zd2SsDZ1Et3gznDns0vou1DNMSZCNg8BXe106l45fxZeHm2BHIcatUDgOXafuYls
	2NjFWQaG4texI4IB+Zh20XCWVQwppCoA=
X-Gm-Gg: AY/fxX7zl6/4U7l2228wgV94AJzj4vk32ix8hh/iKbWBZNVK/gMfuOq3WoBmZwd/6x5
	f9ZDTWUNTSsDH8Nq9S+aDqZ0C//t2XCyB55lsHYEO0XU2RXbkMAdJOe6t9JZPBQbBnLimd6ZaSj
	Dngpm1tWSlWwyW/aQwP4CjCL9hMPwhgrwJWJyXOfGxZ1QTpMdqSHYZMF+7WmUvPwB5qCn5NBusu
	+jUZLk6ZL57VoxYXQqRuICk9gcinXqoYUI0IRt8NRA44MToz+UyanFH6e8yrgGWwZktjhWv
X-Received: by 2002:a05:6214:5283:b0:88a:2b3c:463c with SMTP id
 6a1803df08f44-8942dd70194mr2677186d6.37.1768498335480; Thu, 15 Jan 2026
 09:32:15 -0800 (PST)
MIME-Version: 1.0
References: <20260115132223.2034792-1-daiane.angolini@foundries.io>
 <CANNYZj-5nZLvez9VVz1UxYotBu3xZxY19hagxJ9srrgrBjDzng@mail.gmail.com> <CA+HEL7_1fF5tNAvzTfSgHLtpR2z7B4udYQdF_pkjBv6csj0cww@mail.gmail.com>
In-Reply-To: <CA+HEL7_1fF5tNAvzTfSgHLtpR2z7B4udYQdF_pkjBv6csj0cww@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 15 Jan 2026 18:32:04 +0100
X-Gm-Features: AZwV_QhFX2bswKpoEtuwwOcsrhzXNy2MsbA12Dt8kLJiYBRu6BKIzFapaj46AgM
Message-ID: <CANNYZj-axXJ-OeLr9_Mu3RC7z0YZXLzX9Jk3nEmJ2gmM7jBw7w@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: verify if a configuration
 file is html
To: Daiane Angolini <daiane.angolini@foundries.io>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 17:32:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18788

On Thu, 15 Jan 2026 at 15:49, Daiane Angolini
<daiane.angolini@foundries.io> wrote:
> > if f contains valid json, then f.read() is followed by json.loads(f).
> > Will the second call still obtain the needed json data from f, once
> > it's already been read previously?
>
> I've decided to go with the flow, let it fail and only raise the exception.

That does not confirm that the code works when it is reading valid json.

Indeed, getting valid json over http works without the patch, and with
the patch it breaks like this:
===========
$  /srv/work/alex/bitbake/bin//bitbake-setup init
https://raw.githubusercontent.com/kanavin/bitbake/refs/heads/akanavin/bitbake-setup/default-registry/configurations/poky-master.conf.json
NOTE: Reading configuration from network URI
    https://raw.githubusercontent.com/kanavin/bitbake/refs/heads/akanavin/bitbake-setup/default-registry/configurations/poky-master.conf.json
Traceback (most recent call last):
  File "/srv/work/alex/bitbake/bin//bitbake-setup", line 1140, in <module>
...
TypeError: the JSON object must be str, bytes or bytearray, not HTTPResponse
===========

Even though the logic will be rewritten, please try to test all scenarios.

> Do you think it worth trying to guess the raw/plain URI and use the
> guessing instead? I know how to guess for git.openembedded and
> github.com, but I cannot imagine how to guess for every single
> possibility in the world (that's why I haven't tried to guess)

I wonder if it should even try to guess whether it's html. Just say
that the data at that URI cannot be decoded as it is not valid json,
and suggest that it might be a html page that shows the data, not the
raw data itself, and ask the user to find the raw data link on the
page. There can be all kinds of bogus data coming from the network,
and this would cover all possibilities.

Cheers,
Alex

