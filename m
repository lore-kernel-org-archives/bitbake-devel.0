Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B93C021AA
	for <webhook@archiver.kernel.org>; Fri, 21 Feb 2025 09:12:02 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.web10.19436.1740129116466569941
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Feb 2025 01:11:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=kjWZL2aG;
 spf=pass (domain: gmail.com, ip: 209.85.219.51, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6dcd4f1aaccso26428716d6.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 21 Feb 2025 01:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740129115; x=1740733915; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GnONWKxmpHe87S2s0PueGy57d1tBaG25UGCs8lWUQZ0=;
        b=kjWZL2aG1bke8Yyz/cOJBSu5GcR+vn6k73oeu/vn3aT0GqIU98PQI1kSzTbLLj2J9c
         3aCSciE5mRoDTwjHSsHKNk/MXqNGoM3fV3fe6/WzVWDzHy4m9JaYKs61ACyrUBTjcHj+
         0kCLU0Lnf6dzB+omf/9ftZYowypvCHnAa4dhqE+Ko/eTNvVHojojsDQoEfTP+Kh39zoY
         VKSfNaO0WLVHKCGeEzhJdc/DKRkPmo2QCMhPFtLdy2JF8shrkvnVTSC3M7rH8rMkNDow
         fm03in376Vkbd9iQcmzTV7QoEYmWv5OTVe1WotJa99G72z3Zym1oSiUa4qJdbP3nh62P
         iRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740129115; x=1740733915;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GnONWKxmpHe87S2s0PueGy57d1tBaG25UGCs8lWUQZ0=;
        b=mejmvpLGNxg0CMK/+M4pfnwp+WLkT3sppojgtrr7q3mi7Oq7InMUtAoSo0j6KYrLzU
         Pov24lU1ZJL25WsJMK6v9Dj2XUi0p00R22x3Zo537SL2TqRme99cGdN9+8VzMx4oDbI+
         fruIUl9J24QwrxtkXHH25IhTIYjizLzm0ph3rDjZj6Obzshaz/tM9jukf1vnLxuIEAD+
         Q8llgYgGuwGJvEfXYs5jaTHUtp/J+rHqfK+Z7r2Qpe94RPBprE3+MsHHUYDYH0Rr15IC
         jedBKFNOVY3t4frMPpdsVYMoR54Xs8/KJ3hsUeQ27J6Y6HMYVn95MhiMFYuVhxHkilAx
         EdwQ==
X-Gm-Message-State: AOJu0YzfQcAl70g7tCQl7ChVNMCgoGHkj2jn+NAz1QnrkN9qZuyUP+uc
	x7zIkIGmAGJIGgQ/wJcNtCJoIkDTPQK66pnNfwIWhHZvWLG9EG0IOrE9JETAWiw1HZcmUMfxpGI
	zuvx7HKEq9e5dqPF2Sd1h7VVQKMvIgA==
X-Gm-Gg: ASbGncvQ6MBycwacpK8rUjZEWqVwHziRntX5y2Bz7wuHOlb09wSeMlQVO3pST0DuwHk
	pRaxIsanjjQ76KHx0M1tJE6MZ0ZTzONaOPgSNg3gluOnKB50a/Niut6f4RydlyjdMOD/6w6JBUv
	Q3VPNWoi1RaffHgfxZTxc8GClmKdrnKGv95FUX6PfDPQ==
X-Google-Smtp-Source: AGHT+IHE4BW6l4qY1flzSvElut2dsb7trwdvl+chDIhiqrsa6SDdKav4ZXT1b/HWBKC3GIJUNiAlg8fsZ7742EtZRro=
X-Received: by 2002:a05:6214:2507:b0:6e4:442c:2888 with SMTP id
 6a1803df08f44-6e6ae9e0d10mr30615916d6.39.1740129115533; Fri, 21 Feb 2025
 01:11:55 -0800 (PST)
MIME-Version: 1.0
References: <20240502183501.1216856-1-JPEWhacker@gmail.com> <1825F6393BB749ED.25123@lists.openembedded.org>
In-Reply-To: <1825F6393BB749ED.25123@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 21 Feb 2025 10:11:44 +0100
X-Gm-Features: AWEUYZkLGfwd5BhcQj0BYQ3k6-JunIQ3doQZcQH6ve4BfczJzo0zseO4POtv_Vw
Message-ID: <CANNYZj8LynhGChryLLHYFSz3=G70nO1938FwbfHN58rucuQ2sw@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] cooker: Handle ImportError for websockets
To: bitbake-devel@lists.openembedded.org
Cc: JPEWhacker@gmail.com, Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Feb 2025 09:12:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17271

On Thu, 20 Feb 2025 at 17:05, Alexander Kanavin via
lists.openembedded.org <alex.kanavin=gmail.com@lists.openembedded.org>
wrote:

> - we can extend bitbake-setup configurations with 'install-buildtoos:
> true' parameter, and then use it in all official configurations that
> need functional websockets to access pre-built sstate to always
> install buildtools, even on systems where it's not actually necessary.
>
> None of these are great, but I'm leaning towards the last. Looking for
> better ideas!

Ok, I've slept on it, and concluded that bitbake-setup should simply
always install buildtools by default. It's a front line tool for new
users, and it can't afford to fail in mysterious ways. There will be a
setting to turn it off, for those who know what they're doing and know
they don't need buildtools.

Alex

