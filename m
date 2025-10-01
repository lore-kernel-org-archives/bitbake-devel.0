Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F86DCCA470
	for <webhook@archiver.kernel.org>; Wed,  1 Oct 2025 17:08:37 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
 by mx.groups.io with SMTP id smtpd.web11.2525.1759338507590626160
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Oct 2025 10:08:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=LzpGRKr4;
 spf=pass (domain: gmail.com, ip: 209.85.219.41, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-791875a9071so1510146d6.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 01 Oct 2025 10:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759338506; x=1759943306; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=onx85GUADMDmz3a8xSvu14cjrltX+3lwsb3WEIIFTHA=;
        b=LzpGRKr4Yyplt38KpIGrS8w123qgxGOXo16l9On+2rCIVR5L6Fyla1FyrfQ3HYq9YW
         xTwQQkYlg3F/X2jUgcJPDZ0D45nmkS89h1hn5tz/Z2DNBcR8QkvNBj+yPeN9bar5C3Ap
         lbPrL46I2ykzxQqhZfBHaYcxXoZNNjDbqFlBh2eCSPhK6LG9ByotmXg3jCA2pAohRAl7
         aNe7bXTbE7HHwS1x8/VqGo85GkkB9zxXw9QIkqZ2qAqUefoEAy70phwIe9BvP1EZAZw+
         vjupn6Y0C7FOpR6K49rHZz3z59lcjG7ESRUYhNE03SP2/MTcHviLyypB/BhSTVG2niYn
         aYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759338506; x=1759943306;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=onx85GUADMDmz3a8xSvu14cjrltX+3lwsb3WEIIFTHA=;
        b=WfUKuoPDKg4zFqJMjz7fSmGSetT+z8OsuPQzXH2Hv7WCyoBzJewKv/ry1r4ZGzOPRl
         FsjSk5Eyh2QzCmGguVwZnTN+PmASOZiVr/jwz3+uFLiWaVr9v7nA3RvG3BrzJjipDvIJ
         a6/EIBgJYWKymKKUZ87qa9CM4rqQWxZhyw1eI0I+yMSUBgNUicfy4DzFPIrbX14sHGSi
         Y8+7l1zCgIGrrwlrPUOn9hE4FaRMXouX+/bV1Kz/mVph+LqdVVCFa6oLhu87+Fz0irI5
         9S5LPtqfncAW7pPh2cF5kBUx97hEo69hgrbXC+njHUDSuHxBv6olJoNtCvWkjAh2jV96
         usAA==
X-Gm-Message-State: AOJu0Yy7iyrixDpQkYYeZl2miogBQKALhC4jPe+NgIHeDp37GVQ6hH/Y
	vVzMwi4nHrgYiHT9XhoqEnlgWxFFqL95Uhu7tw8ZT1KAAhLoafSpp0BH3+3QylukMV7AGGdOFKc
	Sq8sHCwz13gUoRmRWF9s0p8wTgQKAP/0=
X-Gm-Gg: ASbGnctzvBpTFrGhXIVkbH0LmlA5RfT36qbIQ28DKLHvH6Cr3PBkCyaHk8lo96BYmnL
	ejJ4xVUKoHJ/jvXj9Lsoj314jOHhdXAJ9CczVa81FdQsV0oiRn3/t308LPy5Sqe4yPuUFcKd0bs
	Qv4uNBGnnDRD6G+3zI6rgWhl763j37zSC/+DUJUvTkrwHua9CkjEOkrqPhV6JXR+IScsBRj8VF6
	zc6PYlL8mEVZFDXLLwhcQ7Mtdbdsro0N7gIMD+fol5dF3vLsDgJTEvRsYNtNYBofXf7RpzZMpzR
	FCHFC6Tcm3mAX07xdVhM7WBBtOidwYPKrzCC+GfsuLDNvM/yl1vIWCdOcfz4AiGD
X-Google-Smtp-Source: AGHT+IGfBv+G3ryb1THl6i3G8In4yoYpFjFLbzZI3JBnfdGA7OsKYYw23lZXd45WZhj7foaCsgYj6lHk3cIEp8/tYoU=
X-Received: by 2002:a05:6214:27ee:b0:7fb:eaac:458 with SMTP id
 6a1803df08f44-873a67ad776mr59593046d6.49.1759338506523; Wed, 01 Oct 2025
 10:08:26 -0700 (PDT)
MIME-Version: 1.0
References: <20251001164409.805431-1-paulg@kernel.org>
In-Reply-To: <20251001164409.805431-1-paulg@kernel.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 1 Oct 2025 19:08:15 +0200
X-Gm-Features: AS18NWAINkzrf7M8Jwf60ulNLLr-IV1er1mGRhJzJvFL0hrzPkEhaxBDzehNGRQ
Message-ID: <CANNYZj9YBRSYyQJvp8w4ksZnKtjkG0h+2-hVB0cC5MhB1sGkBA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: clarify that default
 answer to prompts is no
To: paulg@kernel.org
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Oct 2025 17:08:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18113

Thanks, applied.

There was some discussion as to whether this should be Y/n (e.g. hit
Enter to proceed). I'd rather err on the cautious side here, as people
nowadays have muscle memory to agree and accept with anything and
everything, and proceed as quickly as possible, they would do it here
too, without reading what the tool is going to do, and only then
realize it's not what they wanted.

Alex

On Wed, 1 Oct 2025 at 18:44, Paul Gortmaker via lists.openembedded.org
<paulg=kernel.org@lists.openembedded.org> wrote:
>
> From: Paul Gortmaker <paulg@kernel.org>
>
> It is common practice to put the default choice in upper case for
> yes/no interactive prompts, so that when people just hit enter, they
> know what they are getting.  An example that linux users are probably
> familiar with is "sensors-detect" from the "lm-sensors" package.
>
> Unify all the prompts to be the same and indicate that the default
> answer from hitting enter is a no with an upper case N.  No functional
> changes.
>
> Signed-off-by: Paul Gortmaker <paulg@kernel.org>
> ---
>  bin/bitbake-setup | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> index 1fbb6549..0655ed6f 100755
> --- a/bin/bitbake-setup
> +++ b/bin/bitbake-setup
> @@ -403,7 +403,7 @@ def init_config(settings, args, d):
>
>      print("Initializing a build in\n    {}".format(builddir))
>      if not args.non_interactive:
> -        y_or_n = input('Continue? y/n: ')
> +        y_or_n = input('Continue? (y/N): ')
>          if y_or_n != 'y':
>              exit()
>          print()
> @@ -608,7 +608,7 @@ def write_settings(top_dir, force_replace, non_interactive=True):
>          print('A new settings file will be created in\n    {}\n'.format(settings_path))
>          print('A common site.conf file will be created, please edit or replace before running builds\n    {}\n'.format(siteconfpath))
>          if not non_interactive:
> -            y_or_n = input('Bitbake-setup will be configured with the above settings in {}, y/n: '.format(top_dir))
> +            y_or_n = input('Bitbake-setup will be configured with the above settings in {}, (y/N): '.format(top_dir))
>              if y_or_n != 'y':
>                  print("\nYou can run 'bitbake-setup install-settings' to edit them before setting up builds")
>                  exit()
> @@ -654,7 +654,7 @@ def write_global_settings(settings_path, force_replace, non_interactive=True):
>          print('Top directory prefix (where all top level directories are created) set to\n    {}\n'.format(settings['default']['top-dir-prefix']))
>          print('Top directory name (this is added to the top directory prefix to form a top directory where builds are set up) set to\n    {}\n'.format(settings['default']['top-dir-name']))
>          if not non_interactive:
> -            y_or_n = input('Write out the global settings as specified above (y/n)? ')
> +            y_or_n = input('Write out the global settings as specified above (y/N)? ')
>              if y_or_n != 'y':
>                  print("\nYou can run 'bitbake-setup install-global-settings' to edit them before setting up builds")
>                  exit()
> --
> 2.17.1
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18112): https://lists.openembedded.org/g/bitbake-devel/message/18112
> Mute This Topic: https://lists.openembedded.org/mt/115537146/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

