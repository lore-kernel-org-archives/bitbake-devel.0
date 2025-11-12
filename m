Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8ACCCFA1A
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 06:39:23 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7488.1762929558172374793
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Nov 2025 22:39:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=KfsjXv6w;
 spf=pass (domain: gmail.com, ip: 209.85.219.48, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-880439c5704so3905776d6.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 22:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762929557; x=1763534357; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bjuRhUvdIOQQJMGXWAAdU615BjcbhSlISh4e+fxRFjA=;
        b=KfsjXv6wwy1kMbwWcP+y5wCpjHjTeBUpnGYk0jYA/fWrUnnb4+4TKFSKosPC/h+PCo
         4FR3CWNK2eZ9YXT0o92iv2tFE+nonXsMF0HN2KBrN0kelzJG8JcQNb58c0lzsgQ9vy9p
         gOt9sbOnRqp5G5ALIIymRLcB06v4Wm1uKloNWCA/S2ZK8azIDNw/95e/LMf2lhzWqwDr
         jG7YOSmb4LIXS7i+zVLlo02p52dS1Cl94jPkPSI8BZMgaCqWbjJZpSlyJSpxq2A1kNTu
         ebWXa/6gZ9fBo8fH4asVx7stmFRZl7PdF+CXcF6913xBrDjCPFULFBi0WJjEHnUTAWW3
         Hv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762929557; x=1763534357;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjuRhUvdIOQQJMGXWAAdU615BjcbhSlISh4e+fxRFjA=;
        b=qimkPxUii18Zm8YfC/tS5hs3iFFi5zSVuxfPR5ltiU5Aky0d4oH8cI6orFjJFSh4NX
         C/RbjVafFtM3GxLXZeci5zj9myaNqO9D/16fBrQLX2A/s9ZS0mPfaOm5Fdmraoe5IRen
         Y/JbxS5fN9OL8T9jRy44Icms0jPOWnMAfOzL8pUUsMyjGrjETl891lB38wE1lupr73Aq
         +/MQ5X7wOamelUKbUifAHTh3MqpWsFSvGNS1fB+rmiWDRwN9JWHZYvg5RuZiSYM0NoDi
         5P6uyA5m4qzuK4VWJ+GM0j9lmWV4l8qw8rVgW4/WqWxSrrJgo9cCk3C9mMyTaj57ZSpq
         l9rw==
X-Gm-Message-State: AOJu0YwOyo4NaPu5yLznRjbnkH/5tRT+b8hcqIHhLy3uzIcabPIp83Z5
	hA9jrzWncXIoT+nsdJaHlRSAxvtE2kEHllf1uuwUtsUhmopLo6cDhGHO1wJgHHt1lk0ytW24YRW
	utup7XzJtZE2D+VUwYK+u9dCUg448jLs=
X-Gm-Gg: ASbGncuKmJM+Ag1LZpLy2VV33FCAbrFeixm1NUI1wIdIQA2eJEglVEE7PYV3DhXO6tT
	BT/AM0fFMX1idJz7Oe54OgxGm0BQHzGAuNzhZ6/znoT7YRZSMW7D1GDjfQiTqL3NgtBRwkxhNpO
	D8SUhdOXKSOiN6Kph9peBqmCnS4xmeL2QBPrj3iMobDzcx4G4Y5naWXNWV017B7o1PWuVF+w9GO
	WOri6o28OfimX2m5bLqwd/z5yBnCMysdjUXH4alpH/WJiNSn86CIAFqx94q919z4MO/+Q==
X-Google-Smtp-Source: AGHT+IHHHFM96z19zcJ5BL/aWL9A2qgQT9PC9Qu33gh5SwvDAlw8o+1r4LcI3pTsXzEjPTr9B0T3ExxzlrDaMlVpzY8=
X-Received: by 2002:a05:6214:250b:b0:880:471f:2ecc with SMTP id
 6a1803df08f44-8827199943fmr27538816d6.29.1762929557103; Tue, 11 Nov 2025
 22:39:17 -0800 (PST)
MIME-Version: 1.0
References: <20251111172522.2838760-1-JPEWhacker@gmail.com>
In-Reply-To: <20251111172522.2838760-1-JPEWhacker@gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 12 Nov 2025 07:39:05 +0100
X-Gm-Features: AWmQ_bkVCT93ccX27rZBJPNP0G5oi-eMV1K_m82wp67EnWwAcCgxR69sif7isGo
Message-ID: <CANNYZj92WLXk2-9HE+oxe8MASLy5tDTz3pAJgrZdEh4FAZ0H9g@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] bitbake-setup: Prompt setup directory name
To: JPEWhacker@gmail.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 06:39:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18344

On Tue, 11 Nov 2025 at 18:25, Joshua Watt via lists.openembedded.org
<JPEWhacker=gmail.com@lists.openembedded.org> wrote:
> +            n = input(f"Enter setup directory name, or 'N' to quit ({setup_dir_name}): ")

Isn't the convention to put the default in [ ] in such interactive
prompts? Otherwise it is not clear that hitting enter will proceed
with the default.

I'd also not special-case N, one can hit ctrl-c to stop rather (and
that could be hinted).

Alex

