Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7E7CAC5A5
	for <webhook@archiver.kernel.org>; Wed, 24 Sep 2025 10:47:46 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.web10.9720.1758710862678787504
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 24 Sep 2025 03:47:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=FruFpvmH;
 spf=pass (domain: gmail.com, ip: 209.85.219.51, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-7900f7f4ba9so55405726d6.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 24 Sep 2025 03:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758710862; x=1759315662; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bAhFnpk+LYDcSSB9zMa5NWaYdCKzgd8NIabr7caYsiI=;
        b=FruFpvmH5LqWAo9Izc29FPLwRl6zhrUM1K1lQfzfGqYi8fY+egbOOz3bIcWtOu46iB
         pSo6nAs66KuPC9lH9Dat5X7k4C6M4pZF4OlN01ZNUKV7LhdIial9DxFDyifwQkP81cwF
         hwIE7Jfh5l4YjEJJQQ+tGfTeek2t7UdzvUgfEeyX9CnTPr9OJUnYXh0r2mWmJmDCFUfd
         wXaFzMJCRI0GpFGfSann5VINNWHQ0isxAm3Se9Ty0xeilrcoe77ehUAtVK+yQNGjM7fJ
         4HihvhTLUUAAj8jRkmLv/mEMfHy9liNO0+f4E5Kap0b8jCd/wwaxX9mX998VZhdViXDd
         mVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758710862; x=1759315662;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bAhFnpk+LYDcSSB9zMa5NWaYdCKzgd8NIabr7caYsiI=;
        b=QUj7c6Wt9yvLJp8/Vb8XbDa2uqdlJ2ok/4VeznwKNSNuQZb3KZE5zHw3Bvo+rCaAnt
         r7rphQ94mP/4u2o4Cy8zssA1yoaYnQ2noIF7NNdB1lfzRRR8fDe4w5gCzGkH32pjgxZJ
         cTp3n71E74G02276IxLuDvECdpC3LAZn77UP8xNQD+09b/byxEhn6EqD5eN3T35Nlami
         jAixYb4wEwx0x+4Js9rBw+vLiwQD7h6edNx5UjCqLg4W7GyAtXgTSQ6fIaQOsYsqvvxR
         Djbqx6Ts+cuUCFT5tF5Sd+tDn6QnFXPqoFnVlDaWrb9DBa6bN5OGsYOEw+itrTvx4LpJ
         mzqA==
X-Gm-Message-State: AOJu0Yy5Z1ONhFC1Gmjcp9eYYVKYb2FpjqrLaDKmwT2kyrg3uynDJR5X
	5xa9lMkh9l8aRxHkRg43AeBGO7v3MdE7j7ahGzgyRmawtlqa4dirnJRukAKQU9e0RXad8xR3gvI
	hB6zyD13++15Y8nUwgwJJU6CDpEVXtc1+FA==
X-Gm-Gg: ASbGnctKNCkmd01J/LIDk3TiypqFKNgMkrpW1tzdEU7vOIBVY4eSJw3fP0skip6GWFp
	kbZMqcBGy6zkXWOPxCGbMoOUnPVsiSPLBdX4OtMhCy3Sbst8mlb9AQDV5IzpzAd7A3he41xMfhs
	WTgkrcN4A/1oh3Fy/agG9iAZvnOitbGYBfNvChYQd2i3u3AcGpk+7C4q2jy7t/h0i/6lxB36NLn
	YepEN0fRw5uGEUPsx7kfdBMBormhwg1+Ye1bXy2WcJ2ulhzJ+GkYoj55XXwKBtILQr4tYgz2Xa4
	bMKYuSAFEXGZZ+kx+EA8GAio821CFA1d1cw+qfoW
X-Google-Smtp-Source: AGHT+IE/IdV6tSpI0fNJr1xuDoyflYZibhu2wBI956zIfFx94+1RAnWaKP4bnbaW6xlxOYqh5FdEl7N/3LBcfdNS78E=
X-Received: by 2002:a05:6214:f6c:b0:78e:ea84:768f with SMTP id
 6a1803df08f44-7e705d7bf47mr65438596d6.30.1758710861619; Wed, 24 Sep 2025
 03:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <18683160554EF259.24570@lists.openembedded.org> <CANPvuRk2n7t9YHThXATOT+zD9DYrzV36rU4r+Ku50Wy9y9Q=7g@mail.gmail.com>
In-Reply-To: <CANPvuRk2n7t9YHThXATOT+zD9DYrzV36rU4r+Ku50Wy9y9Q=7g@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 24 Sep 2025 12:47:30 +0200
X-Gm-Features: AS18NWC-0PBybFQdsUiCOnXRaIkx8S_HPddeWqb9-Sez6Ymm4Xwndp5XB1iqSj8
Message-ID: <CANNYZj9om4Ki1X9+91uDaf8WoR1z7USnbG++9qUmp-wUELai1Q@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC PATCH] cooker: add support for more than one
 server in BB_HASHSERVE_UPSTREAM
To: quaresma.jose@gmail.com
Cc: bitbake-devel@lists.openembedded.org, 
	Jose Quaresma <jose.quaresma@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 24 Sep 2025 10:47:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18085

On Wed, 24 Sept 2025 at 12:39, Jose Quaresma via
lists.openembedded.org
<quaresma.jose=gmail.com@lists.openembedded.org> wrote:
> With that we can have for example:
>
> BB_HASHSERVE_UPSTREAM = "wss://hashserv.yoctoproject.org/ws hashserv.yoctoproject.org:8686"

I'd like Joshua and Michael to comment on this ^^^
Specifically, are there performance implications in using one or the
other? Are both officially supported and maintained?

>> +                if hashserve_upstream_list:
>> +                    for hashserve_upstream in hashserve_upstream_list.split():
>> +                        try:
>> +                            with hashserv.create_client(hashserve_upstream) as client:
>> +                                client.ping()
>> +                                upstream = hashserve_upstream
>> +                                break
>> +                        except ImportError as e:
>> +                            bb.warn("Unable to connect to hash equivalence server at '%s' due to missing or incorrect python module:\n%s"
>> +                                    % (hashserve_upstream, repr(e)))
>> +                        except ConnectionError as e:
>> +                            bb.warn("Unable to connect to hash equivalence server at '%s':\n%s"
>> +                                    % (hashserve_upstream, repr(e)))
>> +
>> +                if hashserve_upstream_list and not upstream:
>> +                    bb.fatal("""Unable to use hash equivalence server:
>> +    You can also remove the BB_HASHSERVE_UPSTREAM setting, but this may result in significantly longer build times as bitbake will be unable to reuse prebuilt sstate artefacts.""")

This needs to be rebased on master-next, as it changes the error
message. Also you can use for...else to put the newly added bb.fatal
into the else block. The bb.fatal message should also be improved, and
say that none of the configured servers could be used due to warnings
above.

Alex

