Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E74CD98E4
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 12:37:33 +0000 (UTC)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14557.1781699847525880420
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 17 Jun 2026 05:37:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=f6vn5ehN;
 spf=pass (domain: gmail.com, ip: 209.85.222.175, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-915b5ce94c7so645276085a.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 17 Jun 2026 05:37:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781699846; cv=none;
        d=google.com; s=arc-20240605;
        b=hMEir0CU9Rnpja0QQjyVfvMVVYO8Ut3lzfGZhT4U5sNbZ90PUfiw3tOXV1CLWVGqjg
         B60ezSVRWvIwWGnPi+gPEQNTz4A+xfBL8xSulzIY0ylBipDwf1JQm8irXC3VppN7WjIi
         vR5pdBQtrhJXGwQIt16dalWdsJQ2mUdX0P+Fw3oVqDwBCRyaQVblBAVyycq5dCNcnl3N
         ico9N5iyPzlkPcs79+Lf0Zpv+hy9UrRsMvmZ32nDZsc2Uf79Qjnjl2nrrYsnK8kD6WFo
         dKfaHDW5RHAoR+ANBXcJZywaiiM82LEaVwhLolwx5fBFW/uVSNmbfn11+GFlNprVCceH
         ZsPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WEJCgsnY7ffHPe82zsbKWJnYDqqkKvhErDHGU9HQ6fY=;
        fh=7T/KN/ISzt3kznHzCSymd8M1sGSvp1n5+QlH1Pua2Yg=;
        b=M3ySWpWL7QiQhu+Wm4tkChshbpfj4wPvbbbKBoOTxzFsrOdXS9GjbnXMRf2xXGGSrB
         6lLcBvdAjZJ90+QY3xhR6nNrtTv7FJmPrHxxNb5y2d4LOIQjNn6JZcJ1tizPsx0odKbm
         eOjMoNOSexY2OsBXWJBeb9/ezgbPbrfhH/jyu/NXjfgG86Zv9Xg01zIU5ExKz35MGQnN
         djjFhXzscYxEcSfWP+9ix9B7NcWM2WG2wolynxSce/l+rL5E+JpXuVSKIdP5HzCCd0HJ
         vw2AWV4TrKJ4uvIHn8CWdrPQtMvD67KyUu57xWogx9b0zOeLxVyao393ovRutUV7mKfU
         5Kyw==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781699846; x=1782304646; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WEJCgsnY7ffHPe82zsbKWJnYDqqkKvhErDHGU9HQ6fY=;
        b=f6vn5ehNH0TUYGxuX7RHXznmZKION9nH1vcx5sXEseclMIVYI+ooInPu6dM3E3Sx/9
         JZ/hAG3Jt8G5XqM3gjEYVD1GZqwNmg9voc1NNLh8kyXLy4rJS2FIQxt3d4Sm42YZgXen
         EGWWz5XCTG4jWJcR/IAHDKvNGS6LqXxI6JOBGbyFVlJggDKSoTzRckyU0RkFS6wq7JIC
         MXfCtnk9Pu0qmLDOr2cFE7770UIvigJalEVmhzh8GnscxqrhbjuxS31CjcSkF8Dx4UkM
         3NxXt+YOI/hxEKD450mQWOoeQpOiNDkBxu4WM0GM064TB3jnYUwCewyQfROi6ULvisld
         tVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781699846; x=1782304646;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEJCgsnY7ffHPe82zsbKWJnYDqqkKvhErDHGU9HQ6fY=;
        b=AMZL/h/WUIPgPiw7zTsh/pAR8yxzBjqyTA0Pm7KgTHgcY0R03GRcP4lFrm8lrZ5f8T
         bpFwiVW83Mc8qb2ibeGOad94k+ArA+SWsvGQ6MZxEvq19z7Za+Kif6Rsh7J/KbofgA6c
         MUQxVvp3cH+G7j8i956pzuOgD38LsPDYWIVC5wyJaLshkoT6iBm57YEdxGEiPKc5dPqn
         BbzHb7OcR+KbydtVIVOwS2cR2uo/6SimIcOHw1ylO+Cg8rcgHFJDzw+/fk4HZcenYWSS
         yVmMto0oGMlTnRg3WW/Y+vINx9SRFMghx0zBJndJUnLRgcXdycR14lwhWoebl/bktNbl
         wUvw==
X-Gm-Message-State: AOJu0Yyj48zxz7a38uZin4G7KOR0rfNBv+VKiJ3AuLTGI6uKVOvdHGC3
	LXWOozULIQPpL9JFqITA5YPL6kXUL52lt09sK9mD+oHX2o6YdsZvXhespa4G6QzDyMbSprNdbG+
	JBxnxP2uCWggKWQwX96qv4ZR/8fzgJV4=
X-Gm-Gg: Acq92OHOU2QrHuoNfEIQY9l5D/6rDp5J6Z2N4CqelONyCUKorlpXj1Dv8le+rnSfocT
	tPBiYiZRwrY7Lq3Oblp1Wx8vNw/xfKTqM0eARX4y86nkb4Yjd3OqmNnJaF+VwNjSiOKUUWkofn5
	6118Ai9DADWU9l36ExGT48leMSHBLIChVYyAVrVOHhcn5S0kefAbMSWdzBvUEgr9YDzO1gsDwJ9
	TaQz/IURKNDzkdmByKZxQnUYhdfk6HeVLHBjkVikMQ1IOQpTTb173ZM6XahyWmrYuqbgyG6qJ5c
	hWZsmHVeeJdqtvzp60/cbfczPt4p+Vg=
X-Received: by 2002:a05:620a:2941:b0:915:f27f:e70e with SMTP id
 af79cd13be357-91d8b7afd10mr648444085a.23.1781699846363; Wed, 17 Jun 2026
 05:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <AM7PR06MB640717D4774F7C9F5CC36DACBDE42@AM7PR06MB6407.eurprd06.prod.outlook.com>
In-Reply-To: <AM7PR06MB640717D4774F7C9F5CC36DACBDE42@AM7PR06MB6407.eurprd06.prod.outlook.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 17 Jun 2026 14:37:13 +0200
X-Gm-Features: AVVi8CeIPMtRuNwwxwqjalawWEuiyb8tXNNXLSPAKFOHynbOyEMf4ARGE9WIfHo
Message-ID: <CANNYZj_nQiHUjVvips9+kn7XV1JZquZDJs-5RCZ6RpDAHgCYRw@mail.gmail.com>
Subject: Re: [bitbake-devel] bitbake-setup: sync layers to branch HEAD
To: christian.schaefer@at.abb.com
Cc: "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 17 Jun 2026 12:37:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19726

On Wed, 17 Jun 2026 at 14:01, Christian Schaefer via
lists.openembedded.org
<christian.schaefer=at.abb.com@lists.openembedded.org> wrote:
> Over time, new commits are pushed to the upstream branch (wrynose). Is there a
> way to sync my local checkout to the updated upstream branch without running
> `git pull` manually for each layer? Originally, I assumed this would be done by
> running `bitbake-setup update`, but no changes are detected, as the *.conf.json
> file is still the same.

This should be happening in 'update', particularly this bit of code handles it:

           upstream_revision = fetcher.method.latest_revision(fetcher,
d, 'default')
            if upstream_revision != local_revision:
                changed = True
                logger.info('Layer repository {} checked out into {}
updated revision {} from {} to {}'.format(remote,
os.path.join(layerdir, repodir), rev, local_revision,
upstream_revision))

Can you check why it isn't triggering?

Alex

