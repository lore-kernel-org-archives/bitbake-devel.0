Return-Path: <schnitzeltony@gmail.com>
Received: from mail-il1-f194.google.com (mail-il1-f194.google.com
	[209.85.166.194])
	by mail.openembedded.org (Postfix) with ESMTP id C13F560C79
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 22 Feb 2020 11:57:58 +0000 (UTC)
Received: by mail-il1-f194.google.com with SMTP id x2so3896310ila.9
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 22 Feb 2020 03:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=hf4SbNbm//i7kkDSOI9Br3LIzmW6xn3c+fVKmaj7y0o=;
	b=sOrh/YritsVBQuB2Mh0jiCvt6ZPENUvV5pASubO2Vh1UgGhcb3C61ts8BXR1DdQyYf
	Bg3J1M7lh0wiF3fmZHA2QJjGZIqEOecidXKehlXv5+xdTMr4AN93wbHxZuvzLuGpP9NV
	pdtLl5VTzW5WJr9Dz+ktjH8FkG9w1ccRVYjIAriZnCKxe8Tqsy2XjjymQCnE/P0+iqlD
	E4p5E91qWudsIkY+jM2q3n3iemvpVlawKGM1fc1OrZorWUGntM2CrA0TlHWn95aoMaBY
	5snOZTM3UWs2o3Cjor78mNUpAy6nXNfM3xprsaztxaxQpvzQm6GZye/5B56t0Su0np2X
	6zkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=hf4SbNbm//i7kkDSOI9Br3LIzmW6xn3c+fVKmaj7y0o=;
	b=BOOVdfe6j7s+yFSTGyj26aInzNMqjQQV6OA6bMOhYOJJ/dnqsSssZ2RwsO+qiJd0tw
	14kwDac2nUGGIPhKUdZ8Zea53fCDzaDNkC0CgqWUcMHFO9MqwR9xGV4JpP0rZTTzef8k
	W7/gDJcxRjtm5Xvxx+KLzYrBiO4fWn2lbO+/CEDV4KmBgNwAobkzXSODE8WnBfMfWo/W
	uKULgbY9DMy5zTjR99fEm6tz1RMx0FlxKSDM2b0eo/eR/kkBVtWJ21XPX2jhSh4lzvET
	X20gUK68k8crMAAXoPtj+YJAxLN0CsJTkPB9pjpVfUP5G59dR3WlzJwmTyF8fKcwvk24
	2YTA==
X-Gm-Message-State: APjAAAXSOzoKa4ueKcdrH+IeeB3wCFwS9w07fA913Sm2kxiKpZVyaC6b
	7Jhr6dX0klNKRYi3RgRwBS3I6wtKlQL04I7xZxhNHwkY
X-Google-Smtp-Source: APXvYqxEeVfWOJWgUDIIDrC7dfwDZypTdV9mF5iZYlwu8VsEhpZ4civURYd40aM6ibQ2V4R5w1CsiJiknIiCveNmqM4=
X-Received: by 2002:a92:405a:: with SMTP id n87mr43628669ila.299.1582372679639;
	Sat, 22 Feb 2020 03:57:59 -0800 (PST)
MIME-Version: 1.0
References: <20200221205213.16130-1-bunk@stusta.de>
In-Reply-To: <20200221205213.16130-1-bunk@stusta.de>
From: =?UTF-8?Q?Andreas_M=C3=BCller?= <schnitzeltony@gmail.com>
Date: Sat, 22 Feb 2020 12:57:47 +0100
Message-ID: <CALbNGRT8Zctc43d9xJ-1A2aANjONos0-EF-rzyUgzibs47kk_A@mail.gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] Lower priority of debug messages that should not be shown on the console
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sat, 22 Feb 2020 11:57:58 -0000
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 21, 2020 at 10:00 PM Adrian Bunk <bunk@stusta.de> wrote:
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> ---
>  bitbake/lib/bb/runqueue.py | 8 ++++----
>  bitbake/lib/bb/siggen.py   | 6 +++---
>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> index 71108eeed7..f6bd8db8ce 100644
> --- a/bitbake/lib/bb/runqueue.py
> +++ b/bitbake/lib/bb/runqueue.py
> @@ -2054,7 +2054,7 @@ class RunQueueExecute:
>          self.update_holdofftasks()
>
>          if not self.sq_live and not self.sqdone and not self.sq_deferred and not self.updated_taskhash_queue and not self.holdoff_tasks:
> -            logger.info("Setscene tasks completed")
> +            logger.debug(1, "Setscene tasks completed")
^ Could you please leave this one - I consider it helpful
>
>              err = self.summarise_scenequeue_errors()
>              if err:
> @@ -2259,7 +2259,7 @@ class RunQueueExecute:
>              self.updated_taskhash_queue.remove((tid, unihash))
>
>              if unihash != self.rqdata.runtaskentries[tid].unihash:
> -                logger.info("Task %s unihash changed to %s" % (tid, unihash))
> +                logger.debug(1, "Task %s unihash changed to %s" % (tid, unihash))
>                  self.rqdata.runtaskentries[tid].unihash = unihash
>                  bb.parse.siggen.set_unihash(tid, unihash)
>                  toprocess.add(tid)
> @@ -2304,7 +2304,7 @@ class RunQueueExecute:
>                  elif tid in self.scenequeue_covered or tid in self.sq_live:
>                      # Already ran this setscene task or it running. Report the new taskhash
>                      bb.parse.siggen.report_unihash_equiv(tid, newhash, origuni, newuni, self.rqdata.dataCaches)
> -                    logger.info("Already covered setscene for %s so ignoring rehash (remap)" % (tid))
> +                    logger.debug(1, "Already covered setscene for %s so ignoring rehash (remap)" % (tid))
>                      remapped = True
>
>                  if not remapped:
> @@ -2405,7 +2405,7 @@ class RunQueueExecute:
>
>          for (tid, harddepfail, origvalid) in update_tasks:
>              if tid in self.sqdata.valid and not origvalid:
> -                logger.info("Setscene task %s became valid" % tid)
> +                logger.debug(1, "Setscene task %s became valid" % tid)
>              if harddepfail:
>                  self.sq_task_failoutright(tid)
>
> diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
> index c2d0c736cf..d5c5c5c0af 100644
> --- a/bitbake/lib/bb/siggen.py
> +++ b/bitbake/lib/bb/siggen.py
> @@ -606,7 +606,7 @@ class SignatureGeneratorUniHashMixIn(object):
>                  method = method + self.extramethod[tid]
>
>              data = self.client().report_unihash_equiv(taskhash, method, wanted_unihash, extra_data)
> -            bb.note('Reported task %s as unihash %s to %s (%s)' % (tid, wanted_unihash, self.server, str(data)))
> +            bb.debug(1, 'Reported task %s as unihash %s to %s (%s)' % (tid, wanted_unihash, self.server, str(data)))
>
>              if data is None:
>                  bb.warn("Server unable to handle unihash report")
> @@ -615,9 +615,9 @@ class SignatureGeneratorUniHashMixIn(object):
>              finalunihash = data['unihash']
>
>              if finalunihash == current_unihash:
> -                bb.note('Task %s unihash %s unchanged by server' % (tid, finalunihash))
> +                bb.debug(1, 'Task %s unihash %s unchanged by server' % (tid, finalunihash))
>              elif finalunihash == wanted_unihash:
> -                bb.note('Task %s unihash changed %s -> %s as wanted' % (tid, current_unihash, finalunihash))
> +                bb.debug(1, 'Task %s unihash changed %s -> %s as wanted' % (tid, current_unihash, finalunihash))
>                  self.set_unihash(tid, finalunihash)
>                  return True
>              else:
> --
> 2.17.1
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

