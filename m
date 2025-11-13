Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A71DCD5BC6
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 11:16:17 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21536.1763032570420524141
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Nov 2025 03:16:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=NNpV9fw9;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-429c8632fcbso488241f8f.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 13 Nov 2025 03:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1763032568; x=1763637368; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nWIYRRf/WNuOXe4ZjVVM6r6wAAlou41VQ+w/9R8/0Ag=;
        b=NNpV9fw9PEWSP2dzmlhVuuyJ4U3jvWJxN4oLU5mtM2XY4rSWqaKZtOq1s7tjc30MZB
         fXArZMgBxhpMzCQ/z2bk3DGFj8lSm/7gsOXqWmkQfrNK6+MoNdQJGuaUDKdHYEpcF5NB
         4KYuNEy3tES8uKpCOZuRoaZ565Kar/WzWtAZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763032568; x=1763637368;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nWIYRRf/WNuOXe4ZjVVM6r6wAAlou41VQ+w/9R8/0Ag=;
        b=X3tdowkHCbLptVdsajRc40Yjpqi7/PiLFHXPzagn068ouSJZRHgGmHxyRxwSI/lCq+
         YKNZFO9ihzIC8ExEbizosqVXw9O8eB361MRjpPwJcdRFriSAAY24S0h1k4RKAtx872qY
         5zgnjwDSp2eIjY3gPOa0jBCAJ8wDpmuwNIUa7s4hNJG+wyiHXlaUHac0nETnUS5bys5m
         elcET+hkJlzUZXyEJG3t0oua2lXab3oC4LOcBHKZuiyRafxbUTr8mSIQMVJwutrT31KF
         R2RyuHlXuKm2SexNxZAJCkmn7c/LGK5/5IMgzVqicDNxMfC1jwbAwQMY2o/wjBkb9Cg4
         xa0Q==
X-Gm-Message-State: AOJu0YyoRhdR/57nw5SeQnqnoh+tTj/pQmcqOdT+FmoR4Lkphs64YKt2
	fOcjNG2BfGKztQou6pXvHyJcP6+A1+2Z3eLejuUHGCq3gTXnC4stA6F6rYCWNZyCHglEFX0HZlN
	E/ji6
X-Gm-Gg: ASbGncv++Akaa0wLpueFRFEWNbObhOaNaVYZVv0vvZjJA8rblyQt4PsLcc9EgLHXofw
	wAswTUSfCsuDqjFFiapWST5jyEHQ0P6nhss0XXZFg82NeauDWadcoWbJEwcni7op63Tqv/RrdN+
	RY9XqvIWt5NNkHPqKjPSGD5pWhI0qduLUvRK6V3yHnYVO5kfyVZb4iStAWMbNK0ZmIvFxC4jAGL
	zS4iSaQz7B+EMucTn0YnDXqgLwDc6Wo+ms6RQmSuqwXuSxyRouxbW0t+z7vVla53RK8GkDEE79V
	GPlzyEtQL3V2GyOIv0CR2TtTzjn327LxWESP6N7LOaJP7q99LCxH21eqb0pSDxVtKISuA4slZAJ
	M0DMEIVT+YTxJyoSNDW588oE8NJT6CC2aePYXJHqPrj1xn0wFXBdtfh9xnoH/Hs4A4w5L2cSzvh
	DQHRs6OPI+VuByiAWe54OrwR6AuNZES9q/mt3JvfpNjTUry9i3gnQGl466VqEAwKWZj1Bt0vA/g
	xw=
X-Google-Smtp-Source: AGHT+IEccYdpdDpobpXS39J0stN0aea/xIjA3Kx/zJMKuWn9dFVagv3KgtE23n5Wz0wXmGiZtwKcSA==
X-Received: by 2002:a05:6000:1888:b0:426:d5a0:bac8 with SMTP id ffacd0b85a97d-42b4bdcc608mr5916709f8f.56.1763032568058;
        Thu, 13 Nov 2025 03:16:08 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:4ffe:a0c9:fea0:699b? ([2001:8b0:aba:5f3c:4ffe:a0c9:fea0:699b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f2a7ddsm3462422f8f.47.2025.11.13.03.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 03:16:07 -0800 (PST)
Message-ID: <2acc6d2e53840e35ca2d99839e89d94e136dd304.camel@linuxfoundation.org>
Subject: bitbake-setup steps for release
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Cc: Paul Barker <paul@pbarker.dev>, Alexander Kanavin
 <alex.kanavin@gmail.com>,  Ross Burton <ross.burton@arm.com>, reatmon
 <reatmon@ti.com>, Robert Yang <liezhi.yang@windriver.com>, 
 "antonin.godard" <antonin.godard@bootlin.com>, Mathieu Dubois-Briand
 <mathieu.dubois-briand@bootlin.com>, Joshua Watt <JPEWhacker@gmail.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>
Date: Thu, 13 Nov 2025 11:16:06 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Nov 2025 11:16:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18369

Hi All,

Huge thanks to everyone who has sent patches. Having multiple people
looking at this and sending them has allowed "parallel processing" that
is really moving us closer to release.

The review call agreed with the patches on master-next and that those
should merge. Not all are perfect and there will be some further tweaks
needed but they do move things closer to where we need to be.

There are some things we all thought still needed fixing before
release:

a) The update command needs to prompt y/n on overwriting bblayers.conf
or local.conf and give the users a choice. We need a way for users to
update the repos with one command, we can improve the conf file
upgrading later.

b) There should be a --no-conf-updates (better naming?) to the update
command

c) The default build path should not include the machine name. Ryan
mentioned his previous patches which have the concept of a format
string, or we have a include y/n piece in the json config. Otherwise
you can end up with multiple elements like poky_poky.

d) We need to tell the user how to change the machine/distro layer as
nobody knows about the bitbake-config-build command. Mention "bitbake-
config-build enable-fragment machine/XXX" in output when running the
tool.

e) Add a comment into toolcfg.conf to point at the command to change

f) Catch conf file configuration of MACHINE/DISTRO conflicting with a
fragment?

I'll let anyone add anything I've missed.

Thanks all, it was a really useful call and gives us an idea of what we
need to do to be able to release.

Cheers,

Richard


