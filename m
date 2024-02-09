Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE37C4828F
	for <webhook@archiver.kernel.org>; Fri,  9 Feb 2024 16:17:07 +0000 (UTC)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
 by mx.groups.io with SMTP id smtpd.web11.15850.1707495426407866526
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 09 Feb 2024 08:17:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=UOvO65y3;
 spf=pass (domain: gmail.com, ip: 209.85.208.172, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cf4fafa386so16828011fa.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 09 Feb 2024 08:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707495424; x=1708100224; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IAN+/Xya4CShZfdo/eCC+mkgx6c4M5JEV37gGfN5qyA=;
        b=UOvO65y3aw3zKQs2QW8lmVFuJRcFV3JMh1QmCymqteWchns3EbKvmBnnR6eBjXQBy3
         Qu5kW/A0XdvTRkgiPlxNGqaP8Z0RO9U2oZ5CgTlH3n890zfhZnx8/vU2WH8HojhEGbd/
         YzK7UZcq8q5V7YqlfWGRCzeNxlO4Nbv/pJjQ/8128/F2Vg7UzmHdbB0dzzGCLkdBlNwM
         vo2NyTlxbO+OKYh5M70yCKci0bvo1e5OlCGjvei+neY2nbrEVdVe48xxnwlHC+MFzCg6
         J1ZPUmPJid59yAdMKd92JEF5Tv+dfcZtVlySsN8VjyvAK3kN3IpyKWvqXhBK+ywQ7Fdv
         Z4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707495424; x=1708100224;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IAN+/Xya4CShZfdo/eCC+mkgx6c4M5JEV37gGfN5qyA=;
        b=e8ZXwS9WICXTE2Kxakjo7qhKJhlg5/PaKnIxz+xxkYowIhrqRjPVOAGBRwRcqQmr3b
         dpbB2yvTbvarbNM7FKzSsX+/IHKuhc39MzW7FLUYHE1e4WpfNr4ge+8a+11WRGq/N3ze
         ftUGYOPpG7nnL9mcf2Y9DqtB73b8ssmcAAX6L4v8zXcEKbyihhLEvpnUSxvqnKw57Yye
         DhWT0l1pd4zmyFKSl4UKeR4D4o2rSTYPhQaVbzHow3TUWlptaAw+oRwuaeuoWPhNRAJ7
         M31K1sqIfZYfD40kwksi6ENnCsPDlHel/D/Pdr5LzQWi+Fo0VbermwJbsrjs385AXJZ8
         WpAA==
X-Forwarded-Encrypted: i=1; AJvYcCXuZlxJTmpuYQV6L4Yr4wzbPSOqV353jrQKhs606n/rw9Qg2UYaVdckfS6B71MzvzCxxC2lFGIUvb1Bn5K3wYMcF630feSJsOfXnjfoP6MmT1Z8Y7s=
X-Gm-Message-State: AOJu0YwFFBguw8qE+BL4/PpmdViMShDePRADRYcUM58ja+95TP9+ao55
	oqAM6zDNrmtDRpTxYfi24SW+Vw6TMgmTUv3LGaMhIQZTYrkRh9Rn9q63cjGdVXfb5FYzoLMMy8V
	1sKZ/IZV61h4xxDfMoXaIguhmIQk=
X-Google-Smtp-Source: AGHT+IHLlZ4uID2p9ea6dMfyUw8eFeVGy0BAE/HS8vElnANF6Un/ZMVf8HQG56QDESuK38ujQkj7tRf3/wfkRt5X4hU=
X-Received: by 2002:a2e:8296:0:b0:2d0:b3c3:d8d8 with SMTP id
 y22-20020a2e8296000000b002d0b3c3d8d8mr1674399ljg.43.1707495424329; Fri, 09
 Feb 2024 08:17:04 -0800 (PST)
MIME-Version: 1.0
References: <CANNYZj86b3GMtSVZMn8744HjMSMQVkzuXBTikLf4dFV0ULsvqg@mail.gmail.com>
 <0186f166a0ded0d97d5e19f64a3dd8e5ad44a92f.camel@linuxfoundation.org>
 <CANNYZj-cqQVJcs3AUvzE=Lw+mYMUWZO8JW1N-Ukz6BK3H2rchQ@mail.gmail.com>
 <CAMKF1soqnpKYkcGzkS1A2UGGiy7_Vbzym06rARRTqCnUc7gsCw@mail.gmail.com>
 <CANNYZj_r2S7b+3r4CEz8cGZSqT_wa785p1BtpZxb60CVvZJcAg@mail.gmail.com>
 <947006112712dcca07c607eb6b49b7e4e475c3d9.camel@linuxfoundation.org>
 <CANNYZj-V_bH-uVUBXmER30GxMLrfKN6g=pY-VSsgEfT6Fm7e_g@mail.gmail.com> <829c8fff2e6735297f036fdb878f4d244cf08f91.camel@linuxfoundation.org>
In-Reply-To: <829c8fff2e6735297f036fdb878f4d244cf08f91.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 9 Feb 2024 17:16:53 +0100
Message-ID: <CANNYZj-3QDJMcqaVTSj+XRZo140O-hg5K9kM8e0mtF7yp=P9Tg@mail.gmail.com>
Subject: Re: [bitbake-devel] regression of 'world' performance?
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Khem Raj <raj.khem@gmail.com>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 09 Feb 2024 16:17:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15858

On Fri, 9 Feb 2024 at 17:06, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> Iterating 28k entries isn't an issue for python. Yes, it will be "slow"
> when you put logging around it but I doubt it is the real problem.
>
> What is more likely is one of the calls like:
>
> self.check_dependencies(xxx)
>
> getting called once per entry and that call being slow.
>
> Can you try the profile -P data please. If it doesn't make sense, share
> it somewhere and I'll take a look.

I get:

Parsing of 2966 .bb files complete (0 cached, 2966 parsed). 4758
targets, 129 skipped, 0 masked, 0 errors.
ERROR: Command execution failed: Traceback (most recent call last):
  File "/srv/work/alex/poky/bitbake/lib/bb/cooker.py", line 2284, in parse_next
    parsed, mc, result = next(self.results)
                         ^^^^^^^^^^^^^^^^^^
StopIteration

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/srv/work/alex/poky/bitbake/lib/bb/command.py", line 122, in
runAsyncCommand
    self.cooker.updateCache()
  File "/srv/work/alex/poky/bitbake/lib/bb/cooker.py", line 1635, in updateCache
    if not self.parser.parse_next():
           ^^^^^^^^^^^^^^^^^^^^^^^^
  File "/srv/work/alex/poky/bitbake/lib/bb/cooker.py", line 2293, in parse_next
    self.shutdown()
  File "/srv/work/alex/poky/bitbake/lib/bb/cooker.py", line 2244, in shutdown
    bb.utils.process_profilelog(profiles, pout = pout)
  File "/srv/work/alex/poky/bitbake/lib/bb/utils.py", line 1159, in
process_profilelog
    p = pstats.Stats(*fn, stream=pout)
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/pstats.py", line 116, in __init__
    self.add(*args)
  File "/usr/lib/python3.11/pstats.py", line 174, in add
    item = Stats(item)
           ^^^^^^^^^^^
  File "/usr/lib/python3.11/pstats.py", line 115, in __init__
    self.init(arg)
  File "/usr/lib/python3.11/pstats.py", line 129, in init
    self.load_stats(arg)
  File "/usr/lib/python3.11/pstats.py", line 143, in load_stats
    self.stats = marshal.load(f)
                 ^^^^^^^^^^^^^^^
EOFError: EOF read where object expected


Alex

