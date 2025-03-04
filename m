Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517C5C021B8
	for <webhook@archiver.kernel.org>; Tue,  4 Mar 2025 16:21:26 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
 by mx.groups.io with SMTP id smtpd.web10.25849.1741105284590268466
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Mar 2025 08:21:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=R1bSzgpQ;
 spf=pass (domain: gmail.com, ip: 209.85.167.48, mailfrom: jpewhacker@gmail.com)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54963160818so3357623e87.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 04 Mar 2025 08:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741105282; x=1741710082; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8BaAwXj/jVEnB3yTRlGiV6ibwvhqJksK/Y4UfMrMBw=;
        b=R1bSzgpQtJSMH0lSm19sNDxPj2Zmgxni+Q5rsRtXpRR8teJPedTc3uFIq6J/2JBjc4
         DxAzbecATGjYL+Vsqt/j+ZXo13Osg2O5fpU8gnKF37ZfQo0Kp2XetHQAyPANzYocvl7K
         s11m73La+gDV/PefNOE5p+8VJqiKGBxdGgUiQ9xols1SQFgT4HSTJqGGJCDGjUGIRt0h
         H6ZgmLp7X2FyiILGIVXFLv49TRDWvxBrTTVu9qyxyQ6/9aFNOHTclmct7vd0f4ddP0jp
         qtHuJ+MliZ/oKOIq90JKLDOt4LSj1xRN23/6P1HMxr6+xrlSWy235f8DWYF4TRJWQhdt
         wxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741105282; x=1741710082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8BaAwXj/jVEnB3yTRlGiV6ibwvhqJksK/Y4UfMrMBw=;
        b=i7e5OFLtcJwtns6dJIeCAJqGlY71SANYExYytvyrfeTBtQ56vFDTC5tXx2vsm0zq7p
         x1E+eiJ96jlj6qWiWczV9sKpetOMQNFe5L0a3rpoSFEDEjf+J7QfoWWctHTfjyAx4nvK
         0Ak/82vzFzZW+lyDRm+Cs8fgTPEPvVQtZO1ase2rJOJFcJp8O25KmxNQhrav82gTnrJW
         nj1dfh6I3iNlHo1cL5CyrGqpHx5IP4WyEeKrfIdVStpY0jEVZvxeg55WGaFW4k2oxd07
         7GpV5v/XpcdyEpMJhmQKjyUzDvPduKIDLQeISbCXt27jtlVdpFaDU160AIyhMAg7bdNV
         VT7Q==
X-Gm-Message-State: AOJu0YwOa7VJ2WtBI8XBhG/ed+bP8UNKjxhn9nqLIO2+Rp4x0vGT2WYt
	fnV7DWkfcfZED+5h7Kr7g5J3tj3mcCNQfdRdmpCNhdCWlJkJZC980DIRnhP+zBeiffCp7T3s3Cb
	3E1FvO5JZWaSq00DZ6/FhdoYiNn0kEg==
X-Gm-Gg: ASbGncuqtAP24AimamZMFcMOcemS9nuJTJ5ZhiaylqDNV9n5djVBEAVvue5kxy8sp5L
	nqooaqGyK0wK4oXNHyievCQt/TSxPsXWWIah6n5ymIi0KGGf+5bZHxIIOkcKE/ZnEx+RTrfSP/m
	Pcvk0RSmESni1cFSsTaezENJ9Zysr6fJdjlrp6SvTo
X-Google-Smtp-Source: AGHT+IHZB/s7ZA3HCdaIckOWu77EQFhJgZpLhgB9BiUkiyPGnnMeaNG3inJOMEGslOzcZX16FedfVCrUayaFC76ECrI=
X-Received: by 2002:a05:6512:3f13:b0:549:7145:5d28 with SMTP id
 2adb3069b0e04-54971455f8amr2497160e87.25.1741105282189; Tue, 04 Mar 2025
 08:21:22 -0800 (PST)
MIME-Version: 1.0
References: <20250303130628.1656131-1-richard.purdie@linuxfoundation.org> <20250303130628.1656131-4-richard.purdie@linuxfoundation.org>
In-Reply-To: <20250303130628.1656131-4-richard.purdie@linuxfoundation.org>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Tue, 4 Mar 2025 09:21:10 -0700
X-Gm-Features: AQ5f1JpU5ZhtkkRKy6wKHf9M_4eS0t_DX_xBkB2OHE8gre3v9xTc43Nmk9syboA
Message-ID: <CAJdd5GZeS3Ge23gXQ6UwyO+1-NeyDjPYwFDSugZVOoa2dwT2Ww@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 4/4] event/utils: Avoid deadlock from
 lock_timeout() and recursive events
To: richard.purdie@linuxfoundation.org
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Mar 2025 16:21:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17382

On Mon, Mar 3, 2025 at 6:06=E2=80=AFAM Richard Purdie via
lists.openembedded.org
<richard.purdie=3Dlinuxfoundation.org@lists.openembedded.org> wrote:
>
> We've been seeing intermittent failures on Ubuntu 22.04 in oe-selftest wh=
ich
> were problematic to debug. The failure was inside lock_timeout and once t=
hat was
> identified and the backtrace obtained, the problem becomes clearer:
>
>   File "X/bitbake/lib/bb/server/process.py", line 466, in idle_thread_int=
ernal
>     retval =3D function(self, data, False)
>   File "X/bitbake/lib/bb/command.py", line 123, in runAsyncCommand
>     self.cooker.updateCache()
>   File "X/bitbake/lib/bb/cooker.py", line 1629, in updateCache
>     self.parser =3D CookerParser(self, mcfilelist, total_masked)
>   File "X/bitbake/lib/bb/cooker.py", line 2141, in __init__
>     self.bb_caches =3D bb.cache.MulticonfigCache(self.cfgbuilder, self.cf=
ghash, cooker.caches_array)
>   File "X/bitbake/lib/bb/cache.py", line 772, in __init__
>     loaded +=3D c.prepare_cache(progress)
>   File "X/bitbake/lib/bb/cache.py", line 435, in prepare_cache
>     loaded =3D self.load_cachefile(progress)
>   File "X/bitbake/lib/bb/cache.py", line 516, in load_cachefile
>     progress(cachefile.tell() + previous_progress)
>   File "X/bitbake/lib/bb/cache.py", line 751, in progress
>     bb.event.fire(bb.event.CacheLoadProgress(current_progress, cachesize)=
,
>   File "X/bitbake/lib/bb/event.py", line 234, in fire
>     fire_ui_handlers(event, d)
>   File "X/bitbake/lib/bb/event.py", line 210, in fire_ui_handlers
>     _ui_handlers[h].event.send(event)
>   File "X/bitbake/lib/bb/cooker.py", line 117, in send
>     str_event =3D codecs.encode(pickle.dumps(event), \'base64\').decode(\=
'utf-8\')
>   File "/usr/lib/python3.10/asyncio/sslproto.py", line 320, in __del__
>     _warn(f"unclosed transport {self!r}", ResourceWarning, source=3Dself)
>   File "/usr/lib/python3.10/warnings.py", line 109, in _showwarnmsg
>     sw(msg.message, msg.category, msg.filename, msg.lineno,
>   File "X/bitbake/lib/bb/main.py", line 113, in _showwarning
>     warnlog.warning(s)
>   File "/usr/lib/python3.10/logging/__init__.py", line 1489, in warning
>     self._log(WARNING, msg, args, **kwargs)
>   File "/usr/lib/python3.10/logging/__init__.py", line 1624, in _log
>     self.handle(record)
>   File "/usr/lib/python3.10/logging/__init__.py", line 1634, in handle
>     self.callHandlers(record)
>   File "/usr/lib/python3.10/logging/__init__.py", line 1696, in callHandl=
ers
>     hdlr.handle(record)
>   File "/usr/lib/python3.10/logging/__init__.py", line 968, in handle
>     self.emit(record)
>   File "X/bitbake/lib/bb/event.py", line 778, in emit
>     fire(record, None)
>   File "X/bitbake/lib/bb/event.py", line 234, in fire
>     fire_ui_handlers(event, d)
>   File "X/bitbake/lib/bb/event.py", line 197, in fire_ui_handlers
>     with bb.utils.lock_timeout(_thread_lock):
>   File "/usr/lib/python3.10/contextlib.py", line 135, in __enter__
>     return next(self.gen)
>   File "X/bitbake/lib/bb/utils.py", line 1888, in lock_timeout
>     bb.server.process.serverlog("Couldn\'t get the lock for 5 mins, timed=
 out, exiting. %s" % traceback.format_stack())
>
> or put in simpler terms, whilst sending an event(), an unrelated warning
> message happens to be triggered from asyncio:
>
> /usr/lib/python3.10/asyncio/sslproto.py:320: ResourceWarning: unclosed tr=
ansport <asyncio.sslproto._SSLProtocolTransport object at 0x7f0e797d3100>
>
> which triggers a second event() which can't be sent as we're already
> in the critcal section and already hold the lock.
>
> That warning is due to the version of asyncio used on Ubuntu 22.04 with
> python 3.10 and that comined with timing issues explains why we don't
> see it on other python versions or distros.
>
> We can't handle the second event as the lock is there to serialise the
> events. Instead, we queue the event and then process the queue later.
>
> Add a new version of lock_timeout which allows us to handle the situation
> more gracefully.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/event.py | 10 +++++++++-
>  lib/bb/utils.py | 15 +++++++++++++++
>  2 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/lib/bb/event.py b/lib/bb/event.py
> index e9834d01c7..da07a1dd64 100644
> --- a/lib/bb/event.py
> +++ b/lib/bb/event.py
> @@ -194,7 +194,12 @@ def fire_ui_handlers(event, d):
>          ui_queue.append(event)
>          return
>
> -    with bb.utils.lock_timeout(_thread_lock):
> +    with bb.utils.lock_timeout_nocheck(_thread_lock) as lock:
> +        if not lock:
> +            # If we can't get the lock, we may be recursively called, qu=
eue and return
> +            ui_queue.append(event)
> +            return
> +
>          errors =3D []
>          for h in _ui_handlers:
>              #print "Sending event %s" % event
> @@ -213,6 +218,9 @@ def fire_ui_handlers(event, d):
>          for h in errors:
>              del _ui_handlers[h]
>
> +    while ui_queue:
> +        fire_ui_handlers(ui_queue.pop(), d)
> +
>  def fire(event, d):
>      """Fire off an Event"""
>
> diff --git a/lib/bb/utils.py b/lib/bb/utils.py
> index 3a4b29181e..5486f9599d 100644
> --- a/lib/bb/utils.py
> +++ b/lib/bb/utils.py
> @@ -1879,6 +1879,9 @@ def path_is_descendant(descendant, ancestor):
>  # If we don't have a timeout of some kind and a process/thread exits bad=
ly (for example
>  # OOM killed) and held a lock, we'd just hang in the lock futex forever.=
 It is better
>  # we exit at some point than hang. 5 minutes with no progress means we'r=
e probably deadlocked.
> +# This function can still deadlock python since it can't signal the othe=
r threads to exit
> +# (signals are handled in the main thread) and even os._exit() will wait=
 on non-daemon threads
> +# to exit.
>  @contextmanager
>  def lock_timeout(lock):
>      try:
> @@ -1891,3 +1894,15 @@ def lock_timeout(lock):
>      finally:
>          lock.release()
>          signal.pthread_sigmask(signal.SIG_SETMASK, s)
> +
> +# A version of lock_timeout without the check that the lock was locked a=
nd a shorter timeout
> +@contextmanager
> +def lock_timeout_nocheck(lock):
> +    try:
> +        s =3D signal.pthread_sigmask(signal.SIG_BLOCK, signal.valid_sign=
als())
> +        l =3D lock.acquire(timeout=3D10)

If either of these lines raises an exception, the finally will fail.
You probably want something like:

s =3D signal.pthread_sigmask(...)
try:
   l =3D lock.acquire(...)
   try:
       ...

> +        yield l
> +    finally:
> +        if l:
> +            lock.release()
> +        signal.pthread_sigmask(signal.SIG_SETMASK, s)
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17372): https://lists.openembedded.org/g/bitbake-deve=
l/message/17372
> Mute This Topic: https://lists.openembedded.org/mt/111487229/3616693
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [JPEWha=
cker@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

