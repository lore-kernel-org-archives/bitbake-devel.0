Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5012FC4828F
	for <webhook@archiver.kernel.org>; Fri,  9 Feb 2024 15:23:37 +0000 (UTC)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
 by mx.groups.io with SMTP id smtpd.web11.14452.1707492214247420424
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 09 Feb 2024 07:23:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=AP7yx4j2;
 spf=pass (domain: gmail.com, ip: 209.85.208.180, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d0d7985dfdso14810651fa.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 09 Feb 2024 07:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707492212; x=1708097012; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pPnsVtDDWUWauRVWnDJ/C6csz+Vzu0AKJYBlFQDK9EY=;
        b=AP7yx4j2097UG41JGn0+bRO7ZvLGYcvn8C4pxxeI3oCATSfNoR5oaUBM+82Tu8ts5/
         Ta3NnoAKwjl7OIs8KRcuXF0VuGRnfNEvzF6J405fUaCdJodhrgDfHlmjraxtju+XPpis
         83agu1ftWNCF21NvfWwbveMPeNk6nxLS9fhNXTBGq1PFr63GpXQ0DncEKzpY6naU8WSA
         Ni9Q7Nh84mV/kZQXoFMhBTTupi/XOMWHT0JcV2lM2nHc8s8qLYV9Edl1mlDZf+tiKB4z
         m2u/BChsdII9xKSOcvHDfakAQQ0iyw8Nio+tCVwRdcFk0X7zetjJNxZmRw1cVBFQocSI
         8mSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707492212; x=1708097012;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pPnsVtDDWUWauRVWnDJ/C6csz+Vzu0AKJYBlFQDK9EY=;
        b=kvkiRUr9kBlMVAy/Hq059ewDWBENJP51qeryQkJiN7HPg8e5RM48gknZNccS5q1N5g
         nymOzXQoPo0UnqMp2yZrigRENAd978T08nirRIlnu5H99wFoCGdlHSKscYQS/CXj82jE
         7YRzToe6SUWT44ar+hLkiQgnDVHkAHku0OVk9/Frulg4q77SEbogDTiZeQ10a2Na2d2C
         3qqcNVaEBHyWSAREVwgxI2hxp+iwbFUXjWUY7DlQBxZzWfI8/CVlPy4rfGIuaZm2mrvj
         VpDHqSdJeSHNNzH62wCsxnt9S8FhOYKhwTso5XWNn3WqzWUCvtoVc7zu0VQUF2QLoMcm
         wkaA==
X-Gm-Message-State: AOJu0YyH826NeKN477fsJJ137X/9/jahCNVFHyAIi5Do7Dsvsf14dOub
	ne8M9RkmSiz7s4xEDtsF1Op88zr1Ob1FzWVrZyC/9a39hHOP66QTDZ3YkyHPpAE9JSsu/YC0+fb
	lgzbFScnuktbiFdHuJspQKtPjik2R8UET+lo=
X-Google-Smtp-Source: AGHT+IGd26Bx8cQREnKQeBPCSn6ETLIxxX19N4QWeQNRLLoDUrKDPmodqexZ49xwvSh4RRJJi09USvswIfF6mj/kA84=
X-Received: by 2002:a2e:9945:0:b0:2d0:9ca5:16c2 with SMTP id
 r5-20020a2e9945000000b002d09ca516c2mr1506438ljj.53.1707492211990; Fri, 09 Feb
 2024 07:23:31 -0800 (PST)
MIME-Version: 1.0
References: <CANNYZj86b3GMtSVZMn8744HjMSMQVkzuXBTikLf4dFV0ULsvqg@mail.gmail.com>
 <0186f166a0ded0d97d5e19f64a3dd8e5ad44a92f.camel@linuxfoundation.org>
 <CANNYZj-cqQVJcs3AUvzE=Lw+mYMUWZO8JW1N-Ukz6BK3H2rchQ@mail.gmail.com> <CAMKF1soqnpKYkcGzkS1A2UGGiy7_Vbzym06rARRTqCnUc7gsCw@mail.gmail.com>
In-Reply-To: <CAMKF1soqnpKYkcGzkS1A2UGGiy7_Vbzym06rARRTqCnUc7gsCw@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 9 Feb 2024 16:23:20 +0100
Message-ID: <CANNYZj_r2S7b+3r4CEz8cGZSqT_wa785p1BtpZxb60CVvZJcAg@mail.gmail.com>
Subject: Re: [bitbake-devel] regression of 'world' performance?
To: Khem Raj <raj.khem@gmail.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 09 Feb 2024 15:23:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15850

On Fri, 12 Jan 2024 at 23:20, Khem Raj <raj.khem@gmail.com> wrote:
> > > You could pull the event log json file from the build and "replay" it
> > > with some new viewer tool to see if there is any specific delay
> > > involved between task executions. The events should be in there to
> > > allow that.
> >
> > The troubling part is, I've seen cooker at 100% cpu and not
> > progressing for minutes locally, on an unloaded machine. Then it
> > spawns some tasks, which quickly complete, then it does nothing again
> > for some time. So these might be several different sources of slowness
> > we're observing. The meta-oe build I've pointed to had just about 6000
> > tasks completed after some 6 hours, which is surely much slower than
> > the machine is capable of (and there were no competing builds in that
> > time).
>
> I have observed something similar and brought it up in last dev call as well
> one suggestion was to disable hash equivalence, which I did, it does not change
> a lot which could be attributed to hash equivalence or otherwise, I have also
> tried different python versions on the host but that did not change
> anything either.
> I am still looking for more ways to narrow it down.

I finally got to look at this, and yes I think there is a nasty
quadratic growth in bitbake. Details:

1. How to reproduce: set up a plain build with empty sstate and
default config, enabling meta-oe layers:

BBLAYERS ?= " \
  /srv/work/alex/poky/meta \
  /srv/work/alex/poky/meta-poky \
  /srv/work/alex/poky/meta-yocto-bsp \
  /srv/work/alex/meta-openembedded/meta-oe \
  /srv/work/alex/meta-openembedded/meta-python \
  /srv/work/alex/meta-openembedded/meta-networking \
  /srv/work/alex/meta-openembedded/meta-filesystems \
  /srv/work/alex/meta-openembedded/meta-gnome \
  /srv/work/alex/meta-openembedded/meta-xfce \
  /srv/work/alex/meta-openembedded/meta-multimedia \
  "

Then run 'bitbake world'. No tasks are going to start for minutes and
minutes and minutes: it will seemingly remain stuck at
NOTE: Executing Tasks

2. What is happening? After adding some debugging to
bitbake/lib/bb/runqueue.py, I found:

RunQueueExecute's execute() is being called over and over and over,
thousands of times. Each new call into it is slower than the next. No
tasks are actually run.

execute() contains this loop:

            for nexttask in self.sorted_setscene_tids:

self.sorted_setscene_tids contains about 28000 entries in each
execution of the loop.

Every time the loop is executed, it iterates over those 28000 entries,
stopping one item further along in that list, in this block of code:

                    if nexttask in self.sqdata.outrightfail:
                        logger.debug2('No package found, so skipping
setscene task %s', nexttask)
                        self.sq_task_failoutright(nexttask)
                        return True

Then the loop restarts from the beginning, etc. Until it reaches the
end of self.sorted_setscene_tids. In the process, items in the list
are checked 28000^2-ish times (1+2+...+28000), before anything even
starts.

3. What to do?

Of course I have no idea what I'm doing; this code is extremely
delicate :) Nevertheless, I replaced 'return True' in that block with
'continue', with massive improvement to when tasks actually start
running (after printing 'NOTE: Executing Tasks') and no obvious
immediate fails.

Before the change it was still stuck in that loop after 60 minutes
(!), and after the change it proceeded to the tasks after just two
minutes (!).

There are other 'return True's inside that loop that could also be
contributing to quadratic behaviour, I didn't check those.

Hopefully this helps.

Alex

