Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A15CCFA18
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 15:17:49 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19873.1762874260954906726
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Nov 2025 07:17:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=b8QPPn98;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42b3108f41fso1663574f8f.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 07:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762874259; x=1763479059; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NZeSacim/suGJxvAKopq+wxGScXs6Z1zH1duL91y6lE=;
        b=b8QPPn98cRoaQF3ojqeN5S2/3nyVJqVEA8AX7N6dEkz+RYqSRYKU0LrziKOSkUBjdM
         tk3y2FBChVJgYn+VKPt/YBh/XTnXCJD1GwSKGGirRbsCTxofZviyRTZKSAvAbNhCUSxx
         h2v4HBM74zgcGAthIRtstdSD7syCXkJNypeV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762874259; x=1763479059;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NZeSacim/suGJxvAKopq+wxGScXs6Z1zH1duL91y6lE=;
        b=CkrII31VWoUIXfIQvM7AcfATLUUw1iR0CQ05bNQ6Br0fhfsN+1IVMz1y8FwWsTDWdS
         YGSWvDDCy812WzXzWAPhSD/OhePWNXPVtkkAnYm0ytrpfGKTUclgM/wdkrH83CCve6sT
         dxWDFIsR36TzvzB0dk2ScJ1GV06/e/PeYhC8jIcD0gtBKrQOaemw4K7w3gbGGfDRJesI
         fEBPkF3Zb0dLE7oZtmLqWTgxF3b5Dg2ye9UKPu/0oq7QELz64EaLpssemzoVMOu3KgwI
         a7E+Ef2EF4YAiQykMFqQKCQxpmox8jiqSjGp8CkKpbhYxcamYUhgKBsbitTUcnp7nj1T
         HaDQ==
X-Gm-Message-State: AOJu0Yz/Eq5Itz/M17eIa0otaUgFgae7yJt4miBh96ef0+InQMAzAp3c
	xrGVIVIPO7nCsIVhCw6f/fu2fX+PG8j7Xl5N4RHa4arOzXpn6QUa2h53t6pFJUHDJ5ajBYKzWlB
	ZKtv2
X-Gm-Gg: ASbGncvIPl9WfW4wy2zWo/AIX/zo282B+lXfxL9ahviEaP/TKMppkPk8eH3stVtTLxu
	y3faahCGKqKuKhkB3JjZi1RcXZS9/TFL4gcDCapNsB2JUvhvXjIO26lcZPrTDw+oXnnEn0QbuAG
	zQr32eOxjU9cfp7Fd3k6HmE3qQPl5qskvO+Cy+jf3RegU/l3N9Zm6uz+CmwyKtR5MEC44HEQoWz
	1teCZ0PgzewjhVCfw3gIzF+qsk5UqmfhiD45sttfe/9x98W88MbTQb6FThYhmEsUeerrmGva8Vc
	uiWYeaLuHneEuVPJ9KIUpzs8ROghOenPMWul2/GofzbL4dEYpGU7fH2Y5aQ8SwqPLLRYDBIPGlq
	/4gnlpHe1qHQTLIuDBfTs2I/JdicL7bRASLxoZglFi0gpZA+Yd11SQxTxLsndpBrv3yyZdl53Yw
	MGjKDdZ/ZUHqM0WwulhnAGohucFNMsWKA7/SMP7BUK45aHPMRZjLE3EXOVXOfhGjWr
X-Google-Smtp-Source: AGHT+IE/DkkItiYQKXrVt/VRmywAC8UvTXRa+HZ7wFoaj4pWEM0by1sX6WaK4TYqhEHddRzsy5tVEQ==
X-Received: by 2002:a05:6000:64c:b0:427:2e8:fe3a with SMTP id ffacd0b85a97d-42b2dbe33b8mr10729248f8f.13.1762874258516;
        Tue, 11 Nov 2025 07:17:38 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:e5b4:de25:c1b8:e4ca? ([2001:8b0:aba:5f3c:e5b4:de25:c1b8:e4ca])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac677abeasm29185346f8f.33.2025.11.11.07.17.37
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 07:17:37 -0800 (PST)
Message-ID: <a94dfade878b881bbd8c0524a99675983b8b20da.camel@linuxfoundation.org>
Subject: My bitbake-setup testing notes so far
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 11 Nov 2025 15:17:37 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 15:17:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18324

I've noted down a summary of my recent bitbake-setup testing notes:


"bitbake-setup update" moves local.conf changes out the way. I think by
default there should be a warning about out of date conf files and a
y/n to move. There should be a command line option not to do this as it
really isn't what most users expect/want. I do understand why it is
doing it from an upgrade perspective.


As Joshua mentions, we should just error for non-global settings that
won't do anything.


When we set a top level dl-dir, it should filter down into DL_DIR in
the builds, we do want to share that.


There is a related issue with sstate-dir (and maybe hashequiv DB?) not
being shared between builds by default. We have an opportunity to fix
this right now.


The message:
'Bitbake-setup is using /XXX/bitbake-builds as top directory ("bitbake-setu=
p settings --help" shows how to change it)"'
is misleading. If you run that, if doesn't tell me. I need to run
bitbake-setup settings list and know which one to change.


I'm starting to wonder if there should a "--quickstart-help" which
lists a set of examplecommands to run like:

bitbake-setup settings set --global default top-dir-name poky
bitbake-setup settings set --global default dl-dir /media/build/sources/
bitbake-setup init poky-master poky distro/poky machine/qemux86-64 --setup-=
dir-name build

The reasoning being to give people an idea of needing to set some
global values for thing like dl-dir.


When I run init, the I should be able to edit the default build
directory name more easily. "poky-master-poky-distro_poky-
machine_qemux86-64" is a little nonsensical in that I can change DISTRO
and MACHINE in a build without changing the build directory. Could we
simplify the default? Should we give the user a hint about how to
change the MACHINE/DISTRO? I think we do want to be able to encourage
users to switch some settings in their builds.


For settings, is there anything other than the default section? Should
we perhaps default to default to simplify the commands?


We also don't have a good way of mimicking something more similar to
the older poky layout with bitbake-setup. The autobuilder is the
closest on that but with some horrible commands, I think we might want
to find a way to allow that more easily/obviously.



Any one of these issues in isolation isn't a blocker but together, they
all make the experience a bit jarring and not what people are used to
from us. We get one chance at users of the tool, I think this will
break it.

I do probably have more thoughts, I'll try and keep more notes as I go
and find things. I'm sorry not to have come to some of this earlier :/.

Cheers,

Richard




