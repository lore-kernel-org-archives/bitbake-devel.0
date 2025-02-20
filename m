Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A98C021B1
	for <webhook@archiver.kernel.org>; Thu, 20 Feb 2025 16:05:57 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.web11.38.1740067556521189198
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Feb 2025 08:05:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VUe8KfB/;
 spf=pass (domain: gmail.com, ip: 209.85.219.48, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6dd049b5428so11097526d6.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 20 Feb 2025 08:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740067555; x=1740672355; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SXxD0/PITOqhZq45KGfghy7PF6dvfxZHQcg0ACvXfJI=;
        b=VUe8KfB/Eb2bcYQARjylzrlH0zjXbBiYKZ1OfwP7gJepf4ZgzX3VLBwuwrGjyuU3fi
         /SWbKLzlcoLzX1L6m0aSeQHm7o7gdFF+5+KgOYJr78ykQBME8FAtgS+pv1sKFSBtVMv2
         QWCkkO9GjQvGuQflk+Wf4AqzEPKk8x7H+TuSDHFUXTexxJQLh7p6AI6A9TJO5RqlfP5j
         e9a24Vy1UxqyFcROQl+lmj7Bb7yM7SlDJfwNifRhm8i4bgkHMQ0rpn7GvPP8XXDRt1G1
         +9+tnVOBz2w+gwvcESba5MKhMmp3QfQ/gr5nAXnddwC3xXYXmc+zSSfzJkXZHv2RUft4
         s2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740067555; x=1740672355;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SXxD0/PITOqhZq45KGfghy7PF6dvfxZHQcg0ACvXfJI=;
        b=UZ4M/2AbAIhTNrd2a28eXUEJ58Xi1gTjT/8kKX10COL9uMbuZ0Hpv58yIw99W+Ruz6
         nIAQWcIt4bpLjWu1hGkx9IWHE1Zb7bQEXNX/cTG+aXJucpvpRdsBjZwLSmCSFSCc3M+2
         OGssQ05G7EkYeFKH2zc6Vz0M9FNc8Fm42dU6VJWhkI4LUSbvAcEc5hKsifOvWlrKW7W2
         Dkz8nxPOJpz3bEtRHFFqXaWoYktM91B9nO6k8kdej2l3BH739/1jXh6SvPCcbsM1YLBj
         dUK/9EO8zqoDEshUHi4AQ6TRu3PccoUr2plvvydOHVoaHDd13/RSWHuXKpjo9GgKFTEl
         jSXA==
X-Gm-Message-State: AOJu0YwL04W+vTA7p2T44aayLVs+b3gjmGgwyJw+o+FQaNIFA8exumI5
	mlciCDYgTCYYBarJwxgT08/E/2vaQpm5UYKptED5CHFS+FVlV8AZ9j7R5MVlLz7UDOUkUtrpPVr
	FYFpSozKGTpHR55qHjc0h40L+rapKNa/J
X-Gm-Gg: ASbGnctx6vExoFn+lUQlRgf0hFh/3bK4JXS7GJ+HnGI3zLMt3MvuMnrUxO0xf7/DciW
	X7T5zE02x032lYy8LMlnAXXIZyPvxMHVzdFdqTPbm/gYFsem47vxLtExlVJ+DOZ1xOgHVfmZ39U
	rzu0P7epbswPs9uBodPDNGvSKEVzsSeLc=
X-Google-Smtp-Source: AGHT+IHmd2djxpA7zbYD7zdsvEwtPwFQElBG8bJcAjIGir28TdI896FmEdSXBqTGmayTZmM2Xw6xsp9x/wEqA0oSnro=
X-Received: by 2002:a05:6214:501e:b0:6e6:5a42:8560 with SMTP id
 6a1803df08f44-6e697502434mr114780096d6.23.1740067555414; Thu, 20 Feb 2025
 08:05:55 -0800 (PST)
MIME-Version: 1.0
References: <20240502183501.1216856-1-JPEWhacker@gmail.com>
In-Reply-To: <20240502183501.1216856-1-JPEWhacker@gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 20 Feb 2025 17:05:44 +0100
X-Gm-Features: AWEUYZnXE5eCo0vgEf0fXJn-B6tjJZ2s0Yup8tiQneA9MqFFRKBNRTwD0Rrk7hY
Message-ID: <CANNYZj8aM+mydGDSpMhrvbt8XxKDLzMywVyfKOdxdxrAPgSs2w@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] cooker: Handle ImportError for websockets
To: JPEWhacker@gmail.com
Cc: bitbake-devel@lists.openembedded.org, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Feb 2025 16:05:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17260

On Thu, 2 May 2024 at 20:35, Joshua Watt via lists.openembedded.org
<JPEWhacker=gmail.com@lists.openembedded.org> wrote:
> -                    except ConnectionError as e:
> +                    except (ConnectionError, ImportError) as e:
>                          bb.warn("BB_HASHSERVE_UPSTREAM is not valid, unable to connect hash equivalence server at '%s': %s"
>                                   % (upstream, repr(e)))
> +                        upstream = None

I'm setting up a bitbake-setup configuration that uses
BB_HASHSERVE_UPSTREAM and the official yocto sstate cache on the cdn,
and I think we have a usability issue here.

Specifically, if the user does not have websockets python module
installed, then they will only get a warning:

WARNING: BB_HASHSERVE_UPSTREAM is not valid, unable to connect hash
equivalence server at 'wss://hashserv.yoctoproject.org/ws':
ModuleNotFoundError("No module named 'websockets'")

without a suggestion about how to resolve it. Worse yet, the build
will proceed, but fail to use any sstate, resulting in rebuilds from
source, and a bad first experience for yocto newcomers.

I would rather turn both of these into two separate hard fails
(bb.fatal), and be more specific about why bitbake can't proceed for
each of them.

Then there's the question of how to handle absent websockets:

- we can ask the user to install them on the system, which is not
always straightforward

- we can somehow detect before running bitbake for the first time that
buildtools-tarball is needed (not sure how to do that tbh)

- we can extend bitbake-setup configurations with 'install-buildtoos:
true' parameter, and then use it in all official configurations that
need functional websockets to access pre-built sstate to always
install buildtools, even on systems where it's not actually necessary.

None of these are great, but I'm leaning towards the last. Looking for
better ideas!

Alex

