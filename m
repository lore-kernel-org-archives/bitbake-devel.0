Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314D4ECE57E
	for <webhook@archiver.kernel.org>; Mon,  9 Sep 2024 09:34:03 +0000 (UTC)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
 by mx.groups.io with SMTP id smtpd.web11.48901.1725874441763269863
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Sep 2024 02:34:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lo3L/pY/;
 spf=pass (domain: gmail.com, ip: 209.85.167.42, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5356ab89665so4782593e87.1;
        Mon, 09 Sep 2024 02:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725874440; x=1726479240; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=06mxYym6dIk4iU5ManQo455VubPeRXlcj4aF70pxW+Q=;
        b=lo3L/pY/GlC00dJDPQRQrZmCZo2bd7NbqTNbK4jcxvnksRr/zZ+hVLCPRg+TwB3ujM
         MahWLSX43B5Ng+uPKvFKy56/1SHJJwK0MuYvPHE0kT7rsD9/aQmLegNwuUg1JXHNpPGg
         IdK31KsVAQchh/8PahJ7weW+bzOkAR9y7/rCAde2J9498CRTLKZfUDuuBSUwJ2x6FZtI
         Amq3CzIQJc62m1aHKkRzy7vK2OIh7NH3AiUxL5vuZYNg7o2vr6MgCvyfqG0i7opGfgRF
         w57kiXAp+a0FzA6cpp3lAvw5rSw7PevMTpsQNPeJNhN8ot0KY01quusPn5ouN58U6vAf
         JnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725874440; x=1726479240;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=06mxYym6dIk4iU5ManQo455VubPeRXlcj4aF70pxW+Q=;
        b=i+tDipx6jTBrcqydJVj017xDMRSE50DaoqEnb+x7M6KQu1rk4eRoszJ7fdVv1ILdmb
         NKvMJFbk/Zh3l/UWELhM/inbT6f1Z9rs6ImE/WlQT1OZFAJfnzW5fWlnSloEwkTFTPZu
         5pPNwui9hpi9qjeOYypjbRLVS+x86+g04FZGaIwLVwZxMIghp3SND3/WROFp2A+VJuEe
         bbK7INmaJw5ijCCJN3bUQx0Yn//ZjxxFXtp+sI2CeASi165A9OPfRPAYjEhuZNwy1GSD
         lMWIuHx3zra9bm3tU3XCh1hXDS8Zv2+OQvgssjYCPCjw+naFmrz8q8cwa7TsI9OqPkkS
         JOww==
X-Forwarded-Encrypted: i=1; AJvYcCV2xSLjKXcAgJUK2AlKcIXFCjPZizeiZAAZ73EbnEEUDUuDauh8RgcEQhh/Y2sfYEuADIyFe5B3zr1YnIgqBSTCZJgFEUcyOe8v@lists.openembedded.org
X-Gm-Message-State: AOJu0Yw2WzKkfkIskVg1vGUIIjxdtHMHuWbweRZpbvXspCz24KnH9gZa
	7UaTag2ZwwLkCWK+fSyWnqA+KIpu+aYvyXmFAawLxXNCEM2Gn+QDofPDhTYodvewTwVOR3K0oRx
	kmLn1xOpN8xpthJ4tSKxOpOC3tWw=
X-Google-Smtp-Source: AGHT+IHxAkHjHeRP6YFUt6P71rOVUbzIQyQw2OvCHrEQRn9FDY9YOlTzbGF1n7iQHR4PNDMN/NOvEdCjTEXyKpbwp8s=
X-Received: by 2002:a05:6512:b97:b0:535:d4e9:28bb with SMTP id
 2adb3069b0e04-536588068aemr5298320e87.46.1725874439490; Mon, 09 Sep 2024
 02:33:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240502105745.3073153-1-alex.kanavin@gmail.com> <8ddf5dac-2cb8-4c6a-b4e9-b8b281058cb1@ti.com>
In-Reply-To: <8ddf5dac-2cb8-4c6a-b4e9-b8b281058cb1@ti.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 9 Sep 2024 11:33:48 +0200
Message-ID: <CANNYZj8THxZ6y8sv3Y7A9br3zfh4GMpec4g4Y-+gMzGMJf5CAA@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC PATCH] bitbake-setup: add the proof of
 concept implementation
To: Ryan Eatmon <reatmon@ti.com>
Cc: bitbake-devel@lists.openembedded.org, yocto@lists.yoctoproject.org, 
	openembedded-architecture@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Sep 2024 09:34:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16547

On Thu, 5 Sept 2024 at 23:10, Ryan Eatmon <reatmon@ti.com> wrote:
> Hello.  I'm attempting to play around with this patch and test out
> bitbake-setup and how it works.  My testing it with trying to take one
> our existing setups and try to get it to work.  Here is some initial
> feedback written as I ran into issues.
>
> I'm running in an ubuntu-22.04 docker container based on crops.

Thanks for the feedback and the fix. The plan now is to focus on
getting bitbake fragments setup to the point where it can be merged,
then go back to bitbake setup, but I wanted to address some points
right now.

> 1) In order to use list it assumes you are fetching a git repo and that
> the git repo has a specific layout.  That seems a little problematic.
> What if the repo we want to point has all kinds of configs for different
> tools in it and we just want a sub directory under the git repo?  How do
> we specify that?

The config repo is minimal by design, and isn't meant to store
anything except a reasonable amount of top level configurations files
in a directory structure (e.g. you can list them and not be
overwhelmed by the amount). The idea is that users don't even need to
know where it is, and what it contains, and it never needs to be
cloned separately either (which it would be once you start putting
'other stuff' in it).

> 2) The uri for a sources entry in the json file automatically adds in
> protocol=git even though I specified protocol=https on the line.  We
> prefer to always use the https for git repos and not the git protocol.
> I modified the code to not do this so my testing could continue.

This is not the case. If the entry in the json starts with https://
then the tool will use protocol=https. Basically it needs to convert
URI that can be given to git on the command line into an SRC_URI type
string that can be given to bitbake's git fetcher.

> 3) If we specify a unique key for each of the sources, why do we need to
> then also specify a path to place the downloaded sources into?  Why not
> just use the same key value to reduce what all is needed to specify.  We
> can still support "path" for those that want it, but if it is left out I
> would default it to the unique key for the repo.

Here I had simply followed the layer configuration schema that makes
path mandatory. Requiring a parameter has its advantages, you don't
have to ensure that the default is documented, standardized and all
tools follow the standard. You also don't lock yourself into the
default value that must be followed until the end of time.

> 4) The init step cannot be run multiple times.  Initial errors are
> because the build-dir already exists, but overall it's a good idea to
> allow for rerunning the setup to allow for fixing issues without needed
> to nuke the entire build dir.  An example of why you might this is if
> you want to add a new layer to your config, or change a commit, or
> whatever...  Rerunning the init should be able to apply the incremental
> changes since the last run.
> In this case I was running into an error message from a file in oe-core,
> which I sent a patch for, and was trying to simply fix that file in the
> layers dir and rerun, but kept tripping over the fact that I cannot
> rerun init.

There are two different scenarios described here:

1. 'init' failing halfway through (because of a bug or a config typo)
and leaving the directory in an incomplete, inconsistent state. I
don't think the tool can reasonably resume or increment anything here,
the best it can do is say that the directory already exists, and can
be forcibly re-initialized with --force (which would erase the content
and try again). Another option is to try erasing everything on exit in
an all-catch exception handler.

2. 'init' completing successfully, and the build-dir is then fine, but
it needs to be brought in sync with changes to the config or layers it
specifies. This is what the 'status' and 'update' operations are for.

In both cases the hints and error messages can certainly be improved,
but I'm not sure there's anything that needs to change in the command
flow itself.

> 5) What is the purpose of creating the top level config git repo?

1. To preserve the history of changes to the top level configuration.
So that if you run into trouble you can see what changed. And maybe
roll back to the previous version etc.

2. To make it possible to publish the configuration for others to use.
You can do it with a 'git push' or we could also add a separate
'publish' sub-command.

> 6) The code loops through the layers looking for scripts/oe-setup-build.
>   What would happen if I shipped a rogue layer with that file in it and
> included it as the last layer in the sources?

I guess it would run that instead? If you include a rogue layer into
the config, there's lots of other rogue things it can do when bitbake
starts, but maybe you have a suggestion?

> 7) I'm getting an error when running the setup-build script:
>
>    File "/scratch/builds/bitbake-setup-test/layers/setup-build", line
> 107, in setup_build_env
>      subprocess.run(cmd, shell=True, executable=os.environ['SHELL'])
>    File "/usr/lib/python3.10/os.py", line 679, in __getitem__
>      raise KeyError(key) from None
> KeyError: 'SHELL'
>
>
> SHELL is set to /bin/sh so I'm at a loss to see why this would be
> failing.  But because of this I never get a build.sh script.

For this I would really appreciate if you can get to the bottom of.

Thanks,
Alex

