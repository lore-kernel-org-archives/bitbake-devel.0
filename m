Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B5CC64E78
	for <webhook@archiver.kernel.org>; Mon,  4 Apr 2022 18:46:47 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web11.9847.1648889069192473884
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 02 Apr 2022 01:44:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DeAxrqCO;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id b19so7218887wrh.11
        for <bitbake-devel@lists.openembedded.org>;
 Sat, 02 Apr 2022 01:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=2G8NGHeu9bQ/VgkDklVLUSCJzytpGB1bNF3iqgYeSKQ=;
        b=DeAxrqCO9dDkU5SO4BDcyTPUAXIFKX8wv9sXsltdkhhasCDGklD73EYS6WyXPXczTp
         hSP6pT846h2uBkTEOPoAxRfqXL3Og0fHbboOvkM1FiVqVgYuwmwrm8LJZLAOkDFiNRzL
         gD+2b9jLVcbDv2n0FtmxEOLmSGR6RZXdMm26s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=2G8NGHeu9bQ/VgkDklVLUSCJzytpGB1bNF3iqgYeSKQ=;
        b=w8b/Wpt8O4jPY+fyhGB8zJkz1d/etqDtTfmhJwZXzue++KwhSZ5e6+mw7hSJ30gF8n
         TmHHGK7ovOWrTGhxjFCek1Vet4hyKLx8FYoXhNPiZTFvKrTOIq6JIswIRv8CmBjRtIYy
         e6aMhJRiryvHfiVJyuxNAy3FezEfTBTgwWVrfih4nusJ6cLHcpMF+nmCrgRU4oax9zfF
         BfZfTOhVRaU79Y/WTqzj6wGGiHMDL9cD4F4n+7L5jQsm54Cau9TU/y0ycXpjYWligguA
         NJCHQm4lT4TngBAtw90aobyF4C0F6zmR8OKTzAqwdgijiYuNLHG3cMYt9S6UnCrHGMnF
         cB2w==
X-Gm-Message-State: AOAM531KBtDE9Z1w0HK3UgvJldwXnwPNC+kOsPmMCHjBSk2vTfd2fa01
	D1LWFvkIDOl7pJFXTZway1KD5gr919Pz1iG7
X-Google-Smtp-Source: 
 ABdhPJyONNlhw+FTiIIUT113GlzRD71Rqp8bi3Z3iFLKPZbYNAHrluAmeEvzsrfuWjkCr2e7Kl05qQ==
X-Received: by 2002:adf:910d:0:b0:1e3:9484:1601 with SMTP id
 j13-20020adf910d000000b001e394841601mr9846121wrj.419.1648889067263;
        Sat, 02 Apr 2022 01:44:27 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:c5e1:7b92:5e42:dfdc?
 ([2001:8b0:aba:5f3c:c5e1:7b92:5e42:dfdc])
        by smtp.gmail.com with ESMTPSA id
 p23-20020a1c5457000000b0038c98c12ea9sm3872497wmi.1.2022.04.02.01.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 01:44:26 -0700 (PDT)
Message-ID: 
 <c776f10054370657c09189ec43090250c9fe8887.camel@linuxfoundation.org>
Subject: gc warnings lock bitbake server
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>, Joshua Watt
	 <JPEWhacker@gmail.com>
Date: Sat, 02 Apr 2022 09:44:23 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 04 Apr 2022 18:46:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13568

I noticed yet another hung oe-selftest on the autobuilder with memres bitbake
enabled. I was able to log into the system and backtrace the hung bitbake
process (gdb -p <pid>, then py-bt). The result was the trace below. Basically it
shows python doing garbage collection within our locked critical section in the
event handler.

The cause of the issue is a warning message being thrown up by gc for an
unclosed asyncio event loop. I have patches in progress to try and fix that
event loop issue but this does show that warnings triggered by gc are painful
for us and we need to address that.

Ahhrg :)

Cheers,

Richard

Traceback (most recent call first):
  File "/usr/lib/python3.9/multiprocessing/synchronize.py", line 95, in __enter__
    return self._semlock.__enter__()
  File "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/server/process.py", line 742, in _send
    with self.wlock:
  File "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/server/process.py", line 761, in send
    self._send(obj)
  File "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/event.py", line 199, in fire_ui_handlers
    _ui_handlers[h].event.send(event)
  File "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/event.py", line 226, in fire
    fire_ui_handlers(event, d)
  File "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/event.py", line 758, in emit
    fire(record, None)
  File "/usr/lib/python3.9/logging/__init__.py", line 948, in handle
    self.emit(record)
  File "/usr/lib/python3.9/logging/__init__.py", line 1657, in callHandlers
    hdlr.handle(record)
  File "/usr/lib/python3.9/logging/__init__.py", line 1595, in handle
    self.callHandlers(record)
  File "/usr/lib/python3.9/logging/__init__.py", line 1841, in _log
    
  File "/usr/lib/python3.9/logging/__init__.py", line 1454, in warning
    self._log(WARNING, msg, args, **kwargs)
  File "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/main.py", line 112, in _showwarning
    warnlog.warning(s)
  File "/usr/lib/python3.9/warnings.py", line 365, in _showwarnmsg
    # "file" is actually in a zipfile or something.
  <built-in method warn of module object at remote 0x7f79d2762090>
  File "/usr/lib/python3.Traceback (most recent call first):
  File "/usr/lib/python3.9/multiprocessing/synchronize.py", line 95, in
__enter__
    return self._semlock.__enter__()
  File "/home/pokybuild/yocto-worker/oe-selftest-
debian/build/bitbake/lib/bb/server/process.py", line 742, in _send
    with self.wlock:
  File "/home/pokybuild/yocto-worker/oe-selftest-
debian/build/bitbake/lib/bb/server/process.py", line 761, in send
    self._send(obj)
  File "/home/pokybuild/yocto-worker/oe-selftest-
debian/build/bitbake/lib/bb/event.py", line 199, in fire_ui_handlers
    _ui_handlers[h].event.send(event)
  File "/home/pokybuild/yocto-worker/oe-selftest-
debian/build/bitbake/lib/bb/event.py", line 226, in fire
    fire_ui_handlers(event, d)
  File "/home/pokybuild/yocto-worker/oe-selftest-
debian/build/bitbake/lib/bb/event.py", line 758, in emit
    fire(record, None)
  File "/usr/lib/python3.9/logging/__init__.py", line 948, in handle
    self.emit(record)
  File "/usr/lib/python3.9/logging/__init__.py", line 1657, in callHandlers
    hdlr.handle(record)
  File "/usr/lib/python3.9/logging/__init__.py", line 1595, in handle
    self.callHandlers(record)
  File "/usr/lib/python3.9/logging/__init__.py", line 1841, in _log
    
  File "/usr/lib/python3.9/logging/__init__.py", line 1454, in warning
    self._log(WARNING, msg, args, **kwargs)
  File "/home/pokybuild/yocto-worker/oe-selftest-
debian/build/bitbake/lib/bb/main.py", line 112, in _showwarning
    warnlog.warning(s)
  File "/usr/lib/python3.9/warnings.py", line 365, in _showwarnmsg
    # "file" is actually in a zipfile or something.
  <built-in method warn of module object at remote 0x7f79d2762090>
  File "/usr/lib/python3.9/asyncio/base_events.py", line 681, in __del__
    _warn(f"unclosed event loop {self!r}", ResourceWarning, source=self)
  Garbage-collecting
  File "/usr/lib/python3.9/multiprocessing/connection.py", line 205, in
send_bytes
    self._send_bytes(m[offset:offset + size])
  File "/home/pokybuild/yocto-worker/oe-selftest-
debian/build/bitbake/lib/bb/server/process.py", line 743, in _send
    self.writer.send_bytes(obj)
  File "/home/pokybuild/yocto-worker/oe-selftest-
debian/build/bitbake/lib/bb/server/process.py", line 761, in send
    self._send(obj)
  File "/home/pokybuild/yocto-worker/oe-selftest-
debian/build/bitbake/lib/bb/event.py", line 199, in fire_ui_handlers
    _ui_handlers[h].event.send(event)
  File "/home/pokybuild/yocto-worker/oe-selftest-
debian/build/bitbake/lib/bb/event.py", line 226, in fire
    fire_ui_handlers(event, d)
  File "/home/pokybuild/yocto-worker/oe-selftest-
debian/build/bitbake/lib/bb/cache.py", line 1017, in progress
  File "/home/pokybuild/yocto-worker/oe-selftest-
debian/build/bitbake/lib/bb/cache.py", line 478, in load_cachefile
    progress(cachefile.tell() + previous_progress)
  File "/home/pokybuild/yocto-worker/oe-selftest-
debian/build/bitbake/lib/bb/cache.py", line 398, in prepare_cache
    loaded = self.load_cachefile(progress)
  File "/home/pokybuild/yocto-worker/oe-selftest-
debian/build/bitbake/lib/bb/cache.py", line 780, in __init__
    loaded += c.prepare_cache(progress)
  File "/home/pokybuild/yocto-worker/oe-selftest-
debian/build/bitbake/lib/bb/cooker.py", line 2186, in __init__
    self.bb_caches = bb.cache.MulticonfigCache(self.cfgbuilder, self.cfghash,
cooker.caches_array)
  File "/home/pokybuild/yocto-worker/oe-selftest-
debian/build/bitbake/lib/bb/cooker.py", line 1691, in updateCache
    self.parser = CookerParser(self, mcfilelist, total_masked)
  File "/home/pokybuild/yocto-worker/oe-selftest-
debian/build/bitbake/lib/bb/command.py", line 123, in runAsyncCommand
    self.cooker.updateCache()
  File "/home/pokybuild/yocto-worker/oe-selftest-
debian/build/bitbake/lib/bb/cooker.py", line 562, in runCommands
    return self.command.runAsyncCommand()
  File "/home/pokybuild/yocto-worker/oe-selftest-
debian/build/bitbake/lib/bb/server/process.py", line 342, in idle_commands
    retval = function(self, data, False)
  File "/home/pokybuild/yocto-worker/oe-selftest-
debian/build/bitbake/lib/bb/server/process.py", line 501, in main
    if lines:
  File "/home/pokybuild/yocto-worker/oe-selftest-
debian/build/bitbake/lib/bb/server/process.py", line 110, in run
    ret = self.main()
  File "/home/pokybuild/yocto-worker/oe-selftest-
debian/build/bitbake/lib/bb/server/process.py", line 814, in execServer
  File "/home/pokybuild/yocto-worker/oe-selftest-
debian/build/bitbake/bin/bitbake-server", line 52, in <module>
    bb.server.process.execServer(lockfd, readypipeinfd, lockname, sockname, timeout, xmlrpcinterface)9/asyncio/base_events.py", line 681, in __del__
    _warn(f"unclosed event loop {self!r}", ResourceWarning, source=self)
  Garbage-collecting
  File "/usr/lib/python3.9/multiprocessing/connection.py", line 205, in send_bytes
    self._send_bytes(m[offset:offset + size])
  File "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/server/process.py", line 743, in _send
    self.writer.send_bytes(obj)
  File "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/server/process.py", line 761, in send
    self._send(obj)
  File "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/event.py", line 199, in fire_ui_handlers
    _ui_handlers[h].event.send(event)
  File "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/event.py", line 226, in fire
    fire_ui_handlers(event, d)
  File "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/cache.py", line 1017, in progress
  File "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/cache.py", line 478, in load_cachefile
    progress(cachefile.tell() + previous_progress)
  File "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/cache.py", line 398, in prepare_cache
    loaded = self.load_cachefile(progress)
  File "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/cache.py", line 780, in __init__
    loaded += c.prepare_cache(progress)
  File "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/cooker.py", line 2186, in __init__
    self.bb_caches = bb.cache.MulticonfigCache(self.cfgbuilder, self.cfghash, cooker.caches_array)
  File "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/cooker.py", line 1691, in updateCache
    self.parser = CookerParser(self, mcfilelist, total_masked)
  File "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/command.py", line 123, in runAsyncCommand
    self.cooker.updateCache()
  File "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/cooker.py", line 562, in runCommands
    return self.command.runAsyncCommand()
  File "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/server/process.py", line 342, in idle_commands
    retval = function(self, data, False)
  File "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/server/process.py", line 501, in main
    if lines:
  File "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/server/process.py", line 110, in run
    ret = self.main()
  File "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/server/process.py", line 814, in execServer
  File "/home/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/bin/bitbake-server", line 52, in <module>
    bb.server.process.execServer(lockfd, readypipeinfd, lockname, sockname, timeout, xmlrpcinterface)


