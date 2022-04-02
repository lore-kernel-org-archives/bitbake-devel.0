Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73232C64E96
	for <webhook@archiver.kernel.org>; Mon,  4 Apr 2022 18:46:48 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web12.12015.1648907607364410918
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 02 Apr 2022 06:53:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=NW0ymEc5;
 spf=pass (domain: gmail.com, ip: 209.85.221.43,
 mailfrom: jpewhacker@gmail.com)
Received: by mail-wr1-f43.google.com with SMTP id h4so7865897wrc.13
        for <bitbake-devel@lists.openembedded.org>;
 Sat, 02 Apr 2022 06:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0CsMhXeAEBdwvb7WWxWjnu/xpBmNJJu8vwN70oYs04s=;
        b=NW0ymEc5wqdal8snyFZEyev53wH17i+dVHwjWBrkC2og7jNm3BiCOsnaza4N7fxkYz
         oTTzxAVBCbzCbnLoGVDj6TCYzCnhBZhVYjNE4xtyaZpsj3lwlfKtCNgEq9Fu/VxBdyjn
         M2Sa7j8Vf463kDhCCaJgaWwxovz9FRkZNAx+1083rfKuUwCvqOXNkg+eTYXd8z8tsivE
         oCGH1K2YSapKYfWgQI3psqwfogpu+e0DFB7Ik0AKUmSg+mf6OLLv6hZdCm72AEyFqw7k
         yu3aHW4h5bP4JydVhQRTGVspErgwhS9voyAd9v2sH6JBY69DpUP6I4vwuI5ZacWRksU8
         t1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0CsMhXeAEBdwvb7WWxWjnu/xpBmNJJu8vwN70oYs04s=;
        b=VoebjCCHTHOIKSgVPkOluLUBwMEdJ5QiAAJ8xdpkvlRKYdnDlm6RYQlHGkY+5G2ftV
         qMmFzJUaTryInJ1fnx6qUOQphcFK5i6VY/Q1k4d+SbXd6WO2nSI9vQwoiTRd+F0+/48c
         Z9wSHpwO53BrWy2vv2ZRuRasfxP76ephxpFe7q0ksH5YyDdj3y34Zx2GOOp1P84XnDN9
         o4hCKg8IgcO4k5b+jFHgBU5p1tC49s20ETjM2RyxcBk8kHbpqZuqrOO/ih4y3j1hO7J+
         Fjxwf1NqUWWsAYzCnXOYkWMmRwy9+cGlKLbZQf1uAq/cDXWHZQSd9DC82L3W23cAr5Yr
         LeLw==
X-Gm-Message-State: AOAM532G84rktyv2xctAJfBtysEyZi7dW+/qRNlM8ZJVuoR4pzPJYUK1
	n4nI/HFfTqEIaXb70mPU9WwpZk2PkIrC8GnZ7PE=
X-Google-Smtp-Source: 
 ABdhPJw8suqCM/Ms6/cVf9MLbDGQQbsDzhc+pyAlBCAsWBzDZWngz7mCaZ/aKQlt3zrshO80hssdcB3Kt/01dcmv30s=
X-Received: by 2002:a5d:410c:0:b0:206:b5c:65c7 with SMTP id
 l12-20020a5d410c000000b002060b5c65c7mr667014wrp.94.1648907605756; Sat, 02 Apr
 2022 06:53:25 -0700 (PDT)
MIME-Version: 1.0
References: 
 <c776f10054370657c09189ec43090250c9fe8887.camel@linuxfoundation.org>
In-Reply-To: 
 <c776f10054370657c09189ec43090250c9fe8887.camel@linuxfoundation.org>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Sat, 2 Apr 2022 08:53:14 -0500
Message-ID: 
 <CAJdd5GYENUxOvMPRh8bx_2VJSVFuQrJFuXQPdoShDDuTGx1R2g@mail.gmail.com>
Subject: Re: gc warnings lock bitbake server
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="0000000000001bce3305dbac3879"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 04 Apr 2022 18:46:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13569

--0000000000001bce3305dbac3879
Content-Type: text/plain; charset="UTF-8"

On Sat, Apr 2, 2022, 3:44 AM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> I noticed yet another hung oe-selftest on the autobuilder with memres
> bitbake
> enabled. I was able to log into the system and backtrace the hung bitbake
> process (gdb -p <pid>, then py-bt). The result was the trace below.
> Basically it
> shows python doing garbage collection within our locked critical section
> in the
> event handler.
>
> The cause of the issue is a warning message being thrown up by gc for an
> unclosed asyncio event loop. I have patches in progress to try and fix that
> event loop issue but this does show that warnings triggered by gc are
> painful
> for us and we need to address that.
>

Nice find. So IIRC, there are two issues: The first is that asyncio is
creating a lot of warnings, and the second is that warnings from the
garbage collector can deadlock bitbake?



> Ahhrg :)
>
> Cheers,
>
> Richard
>
> Traceback (most recent call first):
>   File "/usr/lib/python3.9/multiprocessing/synchronize.py", line 95, in
> __enter__
>     return self._semlock.__enter__()
>   File
> "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/server/process.py",
> line 742, in _send
>     with self.wlock:
>   File
> "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/server/process.py",
> line 761, in send
>     self._send(obj)
>   File
> "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/event.py",
> line 199, in fire_ui_handlers
>     _ui_handlers[h].event.send(event)
>   File
> "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/event.py",
> line 226, in fire
>     fire_ui_handlers(event, d)
>   File
> "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/event.py",
> line 758, in emit
>     fire(record, None)
>   File "/usr/lib/python3.9/logging/__init__.py", line 948, in handle
>     self.emit(record)
>   File "/usr/lib/python3.9/logging/__init__.py", line 1657, in callHandlers
>     hdlr.handle(record)
>   File "/usr/lib/python3.9/logging/__init__.py", line 1595, in handle
>     self.callHandlers(record)
>   File "/usr/lib/python3.9/logging/__init__.py", line 1841, in _log
>
>   File "/usr/lib/python3.9/logging/__init__.py", line 1454, in warning
>     self._log(WARNING, msg, args, **kwargs)
>   File
> "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/main.py",
> line 112, in _showwarning
>     warnlog.warning(s)
>   File "/usr/lib/python3.9/warnings.py", line 365, in _showwarnmsg
>     # "file" is actually in a zipfile or something.
>   <built-in method warn of module object at remote 0x7f79d2762090>
>   File "/usr/lib/python3.Traceback (most recent call first):
>   File "/usr/lib/python3.9/multiprocessing/synchronize.py", line 95, in
> __enter__
>     return self._semlock.__enter__()
>   File "/home/pokybuild/yocto-worker/oe-selftest-
> debian/build/bitbake/lib/bb/server/process.py", line 742, in _send
>     with self.wlock:
>   File "/home/pokybuild/yocto-worker/oe-selftest-
> debian/build/bitbake/lib/bb/server/process.py", line 761, in send
>     self._send(obj)
>   File "/home/pokybuild/yocto-worker/oe-selftest-
> debian/build/bitbake/lib/bb/event.py", line 199, in fire_ui_handlers
>     _ui_handlers[h].event.send(event)
>   File "/home/pokybuild/yocto-worker/oe-selftest-
> debian/build/bitbake/lib/bb/event.py", line 226, in fire
>     fire_ui_handlers(event, d)
>   File "/home/pokybuild/yocto-worker/oe-selftest-
> debian/build/bitbake/lib/bb/event.py", line 758, in emit
>     fire(record, None)
>   File "/usr/lib/python3.9/logging/__init__.py", line 948, in handle
>     self.emit(record)
>   File "/usr/lib/python3.9/logging/__init__.py", line 1657, in callHandlers
>     hdlr.handle(record)
>   File "/usr/lib/python3.9/logging/__init__.py", line 1595, in handle
>     self.callHandlers(record)
>   File "/usr/lib/python3.9/logging/__init__.py", line 1841, in _log
>
>   File "/usr/lib/python3.9/logging/__init__.py", line 1454, in warning
>     self._log(WARNING, msg, args, **kwargs)
>   File "/home/pokybuild/yocto-worker/oe-selftest-
> debian/build/bitbake/lib/bb/main.py", line 112, in _showwarning
>     warnlog.warning(s)
>   File "/usr/lib/python3.9/warnings.py", line 365, in _showwarnmsg
>     # "file" is actually in a zipfile or something.
>   <built-in method warn of module object at remote 0x7f79d2762090>
>   File "/usr/lib/python3.9/asyncio/base_events.py", line 681, in __del__
>     _warn(f"unclosed event loop {self!r}", ResourceWarning, source=self)
>   Garbage-collecting
>   File "/usr/lib/python3.9/multiprocessing/connection.py", line 205, in
> send_bytes
>     self._send_bytes(m[offset:offset + size])
>   File "/home/pokybuild/yocto-worker/oe-selftest-
> debian/build/bitbake/lib/bb/server/process.py", line 743, in _send
>     self.writer.send_bytes(obj)
>   File "/home/pokybuild/yocto-worker/oe-selftest-
> debian/build/bitbake/lib/bb/server/process.py", line 761, in send
>     self._send(obj)
>   File "/home/pokybuild/yocto-worker/oe-selftest-
> debian/build/bitbake/lib/bb/event.py", line 199, in fire_ui_handlers
>     _ui_handlers[h].event.send(event)
>   File "/home/pokybuild/yocto-worker/oe-selftest-
> debian/build/bitbake/lib/bb/event.py", line 226, in fire
>     fire_ui_handlers(event, d)
>   File "/home/pokybuild/yocto-worker/oe-selftest-
> debian/build/bitbake/lib/bb/cache.py", line 1017, in progress
>   File "/home/pokybuild/yocto-worker/oe-selftest-
> debian/build/bitbake/lib/bb/cache.py", line 478, in load_cachefile
>     progress(cachefile.tell() + previous_progress)
>   File "/home/pokybuild/yocto-worker/oe-selftest-
> debian/build/bitbake/lib/bb/cache.py", line 398, in prepare_cache
>     loaded = self.load_cachefile(progress)
>   File "/home/pokybuild/yocto-worker/oe-selftest-
> debian/build/bitbake/lib/bb/cache.py", line 780, in __init__
>     loaded += c.prepare_cache(progress)
>   File "/home/pokybuild/yocto-worker/oe-selftest-
> debian/build/bitbake/lib/bb/cooker.py", line 2186, in __init__
>     self.bb_caches = bb.cache.MulticonfigCache(self.cfgbuilder,
> self.cfghash,
> cooker.caches_array)
>   File "/home/pokybuild/yocto-worker/oe-selftest-
> debian/build/bitbake/lib/bb/cooker.py", line 1691, in updateCache
>     self.parser = CookerParser(self, mcfilelist, total_masked)
>   File "/home/pokybuild/yocto-worker/oe-selftest-
> debian/build/bitbake/lib/bb/command.py", line 123, in runAsyncCommand
>     self.cooker.updateCache()
>   File "/home/pokybuild/yocto-worker/oe-selftest-
> debian/build/bitbake/lib/bb/cooker.py", line 562, in runCommands
>     return self.command.runAsyncCommand()
>   File "/home/pokybuild/yocto-worker/oe-selftest-
> debian/build/bitbake/lib/bb/server/process.py", line 342, in idle_commands
>     retval = function(self, data, False)
>   File "/home/pokybuild/yocto-worker/oe-selftest-
> debian/build/bitbake/lib/bb/server/process.py", line 501, in main
>     if lines:
>   File "/home/pokybuild/yocto-worker/oe-selftest-
> debian/build/bitbake/lib/bb/server/process.py", line 110, in run
>     ret = self.main()
>   File "/home/pokybuild/yocto-worker/oe-selftest-
> debian/build/bitbake/lib/bb/server/process.py", line 814, in execServer
>   File "/home/pokybuild/yocto-worker/oe-selftest-
> debian/build/bitbake/bin/bitbake-server", line 52, in <module>
>     bb.server.process.execServer(lockfd, readypipeinfd, lockname,
> sockname, timeout, xmlrpcinterface)9/asyncio/base_events.py", line 681, in
> __del__
>     _warn(f"unclosed event loop {self!r}", ResourceWarning, source=self)
>   Garbage-collecting
>   File "/usr/lib/python3.9/multiprocessing/connection.py", line 205, in
> send_bytes
>     self._send_bytes(m[offset:offset + size])
>   File
> "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/server/process.py",
> line 743, in _send
>     self.writer.send_bytes(obj)
>   File
> "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/server/process.py",
> line 761, in send
>     self._send(obj)
>   File
> "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/event.py",
> line 199, in fire_ui_handlers
>     _ui_handlers[h].event.send(event)
>   File
> "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/event.py",
> line 226, in fire
>     fire_ui_handlers(event, d)
>   File
> "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/cache.py",
> line 1017, in progress
>   File
> "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/cache.py",
> line 478, in load_cachefile
>     progress(cachefile.tell() + previous_progress)
>   File
> "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/cache.py",
> line 398, in prepare_cache
>     loaded = self.load_cachefile(progress)
>   File
> "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/cache.py",
> line 780, in __init__
>     loaded += c.prepare_cache(progress)
>   File
> "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/cooker.py",
> line 2186, in __init__
>     self.bb_caches = bb.cache.MulticonfigCache(self.cfgbuilder,
> self.cfghash, cooker.caches_array)
>   File
> "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/cooker.py",
> line 1691, in updateCache
>     self.parser = CookerParser(self, mcfilelist, total_masked)
>   File
> "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/command.py",
> line 123, in runAsyncCommand
>     self.cooker.updateCache()
>   File
> "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/cooker.py",
> line 562, in runCommands
>     return self.command.runAsyncCommand()
>   File
> "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/server/process.py",
> line 342, in idle_commands
>     retval = function(self, data, False)
>   File
> "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/server/process.py",
> line 501, in main
>     if lines:
>   File
> "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/server/process.py",
> line 110, in run
>     ret = self.main()
>   File
> "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/server/process.py",
> line 814, in execServer
>   File
> "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/bin/bitbake-server",
> line 52, in <module>
>     bb.server.process.execServer(lockfd, readypipeinfd, lockname,
> sockname, timeout, xmlrpcinterface)
>
>

--0000000000001bce3305dbac3879
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Sat, Apr 2, 2022, 3:44 AM Richard Purdie &lt;<a hre=
f=3D"mailto:richard.purdie@linuxfoundation.org">richard.purdie@linuxfoundat=
ion.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">I noticed ye=
t another hung oe-selftest on the autobuilder with memres bitbake<br>
enabled. I was able to log into the system and backtrace the hung bitbake<b=
r>
process (gdb -p &lt;pid&gt;, then py-bt). The result was the trace below. B=
asically it<br>
shows python doing garbage collection within our locked critical section in=
 the<br>
event handler.<br>
<br>
The cause of the issue is a warning message being thrown up by gc for an<br=
>
unclosed asyncio event loop. I have patches in progress to try and fix that=
<br>
event loop issue but this does show that warnings triggered by gc are painf=
ul<br>
for us and we need to address that.<br></blockquote></div></div><div dir=3D=
"auto"><br></div><div dir=3D"auto">Nice find. So IIRC, there are two issues=
: The first is that asyncio is creating a lot of warnings, and the second i=
s that warnings from the garbage collector can deadlock bitbake?</div><div =
dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><div c=
lass=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Ahhrg :)<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
Traceback (most recent call first):<br>
=C2=A0 File &quot;/usr/lib/python3.9/multiprocessing/synchronize.py&quot;, =
line 95, in __enter__<br>
=C2=A0 =C2=A0 return self._semlock.__enter__()<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-debian/build/bit=
bake/lib/bb/server/process.py&quot;, line 742, in _send<br>
=C2=A0 =C2=A0 with self.wlock:<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-debian/build/bit=
bake/lib/bb/server/process.py&quot;, line 761, in send<br>
=C2=A0 =C2=A0 self._send(obj)<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-debian/build/bit=
bake/lib/bb/event.py&quot;, line 199, in fire_ui_handlers<br>
=C2=A0 =C2=A0 _ui_handlers[h].event.send(event)<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-debian/build/bit=
bake/lib/bb/event.py&quot;, line 226, in fire<br>
=C2=A0 =C2=A0 fire_ui_handlers(event, d)<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-debian/build/bit=
bake/lib/bb/event.py&quot;, line 758, in emit<br>
=C2=A0 =C2=A0 fire(record, None)<br>
=C2=A0 File &quot;/usr/lib/python3.9/logging/__init__.py&quot;, line 948, i=
n handle<br>
=C2=A0 =C2=A0 self.emit(record)<br>
=C2=A0 File &quot;/usr/lib/python3.9/logging/__init__.py&quot;, line 1657, =
in callHandlers<br>
=C2=A0 =C2=A0 hdlr.handle(record)<br>
=C2=A0 File &quot;/usr/lib/python3.9/logging/__init__.py&quot;, line 1595, =
in handle<br>
=C2=A0 =C2=A0 self.callHandlers(record)<br>
=C2=A0 File &quot;/usr/lib/python3.9/logging/__init__.py&quot;, line 1841, =
in _log<br>
<br>
=C2=A0 File &quot;/usr/lib/python3.9/logging/__init__.py&quot;, line 1454, =
in warning<br>
=C2=A0 =C2=A0 self._log(WARNING, msg, args, **kwargs)<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-debian/build/bit=
bake/lib/bb/main.py&quot;, line 112, in _showwarning<br>
=C2=A0 =C2=A0 warnlog.warning(s)<br>
=C2=A0 File &quot;/usr/lib/python3.9/warnings.py&quot;, line 365, in _showw=
arnmsg<br>
=C2=A0 =C2=A0 # &quot;file&quot; is actually in a zipfile or something.<br>
=C2=A0 &lt;built-in method warn of module object at remote 0x7f79d2762090&g=
t;<br>
=C2=A0 File &quot;/usr/lib/python3.Traceback (most recent call first):<br>
=C2=A0 File &quot;/usr/lib/python3.9/multiprocessing/synchronize.py&quot;, =
line 95, in<br>
__enter__<br>
=C2=A0 =C2=A0 return self._semlock.__enter__()<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-<br>
debian/build/bitbake/lib/bb/server/process.py&quot;, line 742, in _send<br>
=C2=A0 =C2=A0 with self.wlock:<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-<br>
debian/build/bitbake/lib/bb/server/process.py&quot;, line 761, in send<br>
=C2=A0 =C2=A0 self._send(obj)<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-<br>
debian/build/bitbake/lib/bb/event.py&quot;, line 199, in fire_ui_handlers<b=
r>
=C2=A0 =C2=A0 _ui_handlers[h].event.send(event)<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-<br>
debian/build/bitbake/lib/bb/event.py&quot;, line 226, in fire<br>
=C2=A0 =C2=A0 fire_ui_handlers(event, d)<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-<br>
debian/build/bitbake/lib/bb/event.py&quot;, line 758, in emit<br>
=C2=A0 =C2=A0 fire(record, None)<br>
=C2=A0 File &quot;/usr/lib/python3.9/logging/__init__.py&quot;, line 948, i=
n handle<br>
=C2=A0 =C2=A0 self.emit(record)<br>
=C2=A0 File &quot;/usr/lib/python3.9/logging/__init__.py&quot;, line 1657, =
in callHandlers<br>
=C2=A0 =C2=A0 hdlr.handle(record)<br>
=C2=A0 File &quot;/usr/lib/python3.9/logging/__init__.py&quot;, line 1595, =
in handle<br>
=C2=A0 =C2=A0 self.callHandlers(record)<br>
=C2=A0 File &quot;/usr/lib/python3.9/logging/__init__.py&quot;, line 1841, =
in _log<br>
<br>
=C2=A0 File &quot;/usr/lib/python3.9/logging/__init__.py&quot;, line 1454, =
in warning<br>
=C2=A0 =C2=A0 self._log(WARNING, msg, args, **kwargs)<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-<br>
debian/build/bitbake/lib/bb/main.py&quot;, line 112, in _showwarning<br>
=C2=A0 =C2=A0 warnlog.warning(s)<br>
=C2=A0 File &quot;/usr/lib/python3.9/warnings.py&quot;, line 365, in _showw=
arnmsg<br>
=C2=A0 =C2=A0 # &quot;file&quot; is actually in a zipfile or something.<br>
=C2=A0 &lt;built-in method warn of module object at remote 0x7f79d2762090&g=
t;<br>
=C2=A0 File &quot;/usr/lib/python3.9/asyncio/base_events.py&quot;, line 681=
, in __del__<br>
=C2=A0 =C2=A0 _warn(f&quot;unclosed event loop {self!r}&quot;, ResourceWarn=
ing, source=3Dself)<br>
=C2=A0 Garbage-collecting<br>
=C2=A0 File &quot;/usr/lib/python3.9/multiprocessing/connection.py&quot;, l=
ine 205, in<br>
send_bytes<br>
=C2=A0 =C2=A0 self._send_bytes(m[offset:offset + size])<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-<br>
debian/build/bitbake/lib/bb/server/process.py&quot;, line 743, in _send<br>
=C2=A0 =C2=A0 self.writer.send_bytes(obj)<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-<br>
debian/build/bitbake/lib/bb/server/process.py&quot;, line 761, in send<br>
=C2=A0 =C2=A0 self._send(obj)<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-<br>
debian/build/bitbake/lib/bb/event.py&quot;, line 199, in fire_ui_handlers<b=
r>
=C2=A0 =C2=A0 _ui_handlers[h].event.send(event)<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-<br>
debian/build/bitbake/lib/bb/event.py&quot;, line 226, in fire<br>
=C2=A0 =C2=A0 fire_ui_handlers(event, d)<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-<br>
debian/build/bitbake/lib/bb/cache.py&quot;, line 1017, in progress<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-<br>
debian/build/bitbake/lib/bb/cache.py&quot;, line 478, in load_cachefile<br>
=C2=A0 =C2=A0 progress(cachefile.tell() + previous_progress)<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-<br>
debian/build/bitbake/lib/bb/cache.py&quot;, line 398, in prepare_cache<br>
=C2=A0 =C2=A0 loaded =3D self.load_cachefile(progress)<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-<br>
debian/build/bitbake/lib/bb/cache.py&quot;, line 780, in __init__<br>
=C2=A0 =C2=A0 loaded +=3D c.prepare_cache(progress)<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-<br>
debian/build/bitbake/lib/bb/cooker.py&quot;, line 2186, in __init__<br>
=C2=A0 =C2=A0 self.bb_caches =3D bb.cache.MulticonfigCache(self.cfgbuilder,=
 self.cfghash,<br>
cooker.caches_array)<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-<br>
debian/build/bitbake/lib/bb/cooker.py&quot;, line 1691, in updateCache<br>
=C2=A0 =C2=A0 self.parser =3D CookerParser(self, mcfilelist, total_masked)<=
br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-<br>
debian/build/bitbake/lib/bb/command.py&quot;, line 123, in runAsyncCommand<=
br>
=C2=A0 =C2=A0 self.cooker.updateCache()<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-<br>
debian/build/bitbake/lib/bb/cooker.py&quot;, line 562, in runCommands<br>
=C2=A0 =C2=A0 return self.command.runAsyncCommand()<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-<br>
debian/build/bitbake/lib/bb/server/process.py&quot;, line 342, in idle_comm=
ands<br>
=C2=A0 =C2=A0 retval =3D function(self, data, False)<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-<br>
debian/build/bitbake/lib/bb/server/process.py&quot;, line 501, in main<br>
=C2=A0 =C2=A0 if lines:<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-<br>
debian/build/bitbake/lib/bb/server/process.py&quot;, line 110, in run<br>
=C2=A0 =C2=A0 ret =3D self.main()<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-<br>
debian/build/bitbake/lib/bb/server/process.py&quot;, line 814, in execServe=
r<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-<br>
debian/build/bitbake/bin/bitbake-server&quot;, line 52, in &lt;module&gt;<b=
r>
=C2=A0 =C2=A0 bb.server.process.execServer(lockfd, readypipeinfd, lockname,=
 sockname, timeout, xmlrpcinterface)9/asyncio/base_events.py&quot;, line 68=
1, in __del__<br>
=C2=A0 =C2=A0 _warn(f&quot;unclosed event loop {self!r}&quot;, ResourceWarn=
ing, source=3Dself)<br>
=C2=A0 Garbage-collecting<br>
=C2=A0 File &quot;/usr/lib/python3.9/multiprocessing/connection.py&quot;, l=
ine 205, in send_bytes<br>
=C2=A0 =C2=A0 self._send_bytes(m[offset:offset + size])<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-debian/build/bit=
bake/lib/bb/server/process.py&quot;, line 743, in _send<br>
=C2=A0 =C2=A0 self.writer.send_bytes(obj)<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-debian/build/bit=
bake/lib/bb/server/process.py&quot;, line 761, in send<br>
=C2=A0 =C2=A0 self._send(obj)<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-debian/build/bit=
bake/lib/bb/event.py&quot;, line 199, in fire_ui_handlers<br>
=C2=A0 =C2=A0 _ui_handlers[h].event.send(event)<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-debian/build/bit=
bake/lib/bb/event.py&quot;, line 226, in fire<br>
=C2=A0 =C2=A0 fire_ui_handlers(event, d)<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-debian/build/bit=
bake/lib/bb/cache.py&quot;, line 1017, in progress<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-debian/build/bit=
bake/lib/bb/cache.py&quot;, line 478, in load_cachefile<br>
=C2=A0 =C2=A0 progress(cachefile.tell() + previous_progress)<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-debian/build/bit=
bake/lib/bb/cache.py&quot;, line 398, in prepare_cache<br>
=C2=A0 =C2=A0 loaded =3D self.load_cachefile(progress)<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-debian/build/bit=
bake/lib/bb/cache.py&quot;, line 780, in __init__<br>
=C2=A0 =C2=A0 loaded +=3D c.prepare_cache(progress)<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-debian/build/bit=
bake/lib/bb/cooker.py&quot;, line 2186, in __init__<br>
=C2=A0 =C2=A0 self.bb_caches =3D bb.cache.MulticonfigCache(self.cfgbuilder,=
 self.cfghash, cooker.caches_array)<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-debian/build/bit=
bake/lib/bb/cooker.py&quot;, line 1691, in updateCache<br>
=C2=A0 =C2=A0 self.parser =3D CookerParser(self, mcfilelist, total_masked)<=
br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-debian/build/bit=
bake/lib/bb/command.py&quot;, line 123, in runAsyncCommand<br>
=C2=A0 =C2=A0 self.cooker.updateCache()<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-debian/build/bit=
bake/lib/bb/cooker.py&quot;, line 562, in runCommands<br>
=C2=A0 =C2=A0 return self.command.runAsyncCommand()<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-debian/build/bit=
bake/lib/bb/server/process.py&quot;, line 342, in idle_commands<br>
=C2=A0 =C2=A0 retval =3D function(self, data, False)<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-debian/build/bit=
bake/lib/bb/server/process.py&quot;, line 501, in main<br>
=C2=A0 =C2=A0 if lines:<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-debian/build/bit=
bake/lib/bb/server/process.py&quot;, line 110, in run<br>
=C2=A0 =C2=A0 ret =3D self.main()<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-debian/build/bit=
bake/lib/bb/server/process.py&quot;, line 814, in execServer<br>
=C2=A0 File &quot;/home/pokybuild/yocto-worker/oe-selftest-debian/build/bit=
bake/bin/bitbake-server&quot;, line 52, in &lt;module&gt;<br>
=C2=A0 =C2=A0 bb.server.process.execServer(lockfd, readypipeinfd, lockname,=
 sockname, timeout, xmlrpcinterface)<br>
<br>
</blockquote></div></div></div>

--0000000000001bce3305dbac3879--

