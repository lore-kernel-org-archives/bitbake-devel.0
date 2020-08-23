Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web11.177336.1598200979671160701
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 23 Aug 2020 09:43:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=fOof9n4a;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id x5so6191593wmi.2
        for <bitbake-devel@lists.openembedded.org>; Sun, 23 Aug 2020 09:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=urWsy8JtC0bh+0dVZVnoGpmZd0nRDm8WPDeR1by+4YY=;
        b=fOof9n4aRVkdJr36p7FKBmRjYdcBvLdj3aZJNd4li5go5W/OxbdMbkC67MQYwqkskm
         rhzDoVH8yM0KHF85LTwK1ZcyV+uTc6GgwJ4l4hYOJq/9rCqy4LKVeeBGPrZ19c5vDbv6
         zLdu6QZ4V5KqZcc2KIdxHhQmT407eUHy3cTKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=urWsy8JtC0bh+0dVZVnoGpmZd0nRDm8WPDeR1by+4YY=;
        b=TzCxwPSWSa/jKp3Klw+uYkUEnIUCUrHyaXSXbXkoT6iumeOgCqjJPkB8rH9oQMHjWN
         cLjdIlIX5pKxcYVvPQULN3Zwzu4V0NJWonw784EQ6IAY9trky64am2rD78N9UUdHETu2
         8jbFtDiGMyskg0D/HZQKF/N3vpoPv205ArKCXq7Dnf1xnyoRz3iqD45dEpKJxiocPUmR
         6veFg2d8GQmCf0zZVKhmNhQXrHOTXDR/WGQ/eELZM68uQZ4kqEnjkAO2K5gXH8WJbIfU
         uftM8ckv6PhZY0P7D9G4XRaAfFEaamafFWZfE3a6OfzsXK1D41x67vd7FAwa5ewV33sK
         nmvA==
X-Gm-Message-State: AOAM5324L19LM/cvVegW8/L41f4QBI0M27qYghARyQUKq1+z/Do3AeYb
	ut8JU33fxW4M2/3Y+uTZmb0njL8AS484Og8v
X-Google-Smtp-Source: ABdhPJxO8VOlvspA/l+h5wX1xdbgN2QEsCwPWjCIgPnEADZkduWbo4+OOPcIO3I6pv0Q/6eT2BT82g==
X-Received: by 2002:a7b:c308:: with SMTP id k8mr2018063wmj.90.1598200977680;
        Sun, 23 Aug 2020 09:42:57 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from d.d.0.9.8.0.3.8.5.d.6.d.5.a.5.4.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (d.d.0.9.8.0.3.8.5.d.6.d.5.a.5.4.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:45a5:d6d5:8308:90dd])
        by smtp.gmail.com with ESMTPSA id b202sm11518083wmd.29.2020.08.23.09.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 09:42:55 -0700 (PDT)
Message-ID: <47c38a8deca4a839e0f318792853513021c9c772.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Bitbake server startup issues - need a radical rethink?
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Cc: Steve Sakoman <sakoman@gmail.com>
Date: Sun, 23 Aug 2020 17:42:54 +0100
In-Reply-To: <162DE5E30E91963C.12673@lists.openembedded.org>
References: <162DE5E30E91963C.12673@lists.openembedded.org>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2020-08-23 at 13:36 +0100, Richard Purdie via lists.openembedded.org wrote:
> The bitbake server startup code is proving problematic. It nearly works
> but there are a few issues.
> 
> Basically it comes down to us trying to daemonise one python process
> from inside another one so they run independently. The python
> interpreter simply isn't up to it.
> 
> Our current approach uses os.fork() twice. We have to use os._exit() on
> the end codepaths rather than sys.exit() as that would raise SystemExit
> inside the original codebase inside a second process, meaning execution
> happens there twice which is really really bad.
> 
> If we use os._exit(), atexit and multiprocessing.Finalize() constructs
> don't work. This can leads to unexpected problems as we're effectively
> breaking an significant part of the python's behind the scenes
> machinery.
> 
> We could go back to the setup where we os.fork() twice then launch a
> multiprocessing.Process() but it feels like we're relying on a hack.
> 
> I'm also noting logging is working differently in tinfoil and knotty. I
> think this is due to the state of python's logging in the parent
> environment, pre-fork. I really don't like the fact we have an
> inconsistent base environment for the server.
> 
> This is a long way of saying, I think we need to radically change the
> way bitbake's server process is started by making it a new process
> execution. That will break the mechanism we determine when the UI is
> "ready" and give us a whole new world of races to potentially worry
> about but I think its the only way we're going to get out of this
> current 'mess'.
> 
> I'm particularly worried about what this means for the LTS release
> though as I'd effectively be writing these race issues off as unfixable
> there unless we take the new process setup code which would seem a
> little unwise.

I tried some experiments locally and we can relatively easily drop an
execlp() call into the server startup which would give us a fresh
python interpreter. This is probably a good thing and means most of the
rest of the startup code can be left alone from a race perspective as
we can pass the fds over the exec call.

The downside is we can't stuff the "configuration" down the execlp()
call. We have code to transfer the config from the UI to the server but
it has known bugs (exposed by mem res bitbake) so if we move to use
execlp(), the commandline will have glitches. We do need to fix these
anyway. If we do fix those, memory resident bitbake will look in better
shape.

Some observations:

a) We do a double parse of the configuration on startup as the initial
config doesn't match the final config, even today. We really want to
avoid that.

b) My execlp() experiment makes multiple parses even worse as the
configurations fail to match even more

c) There is something wrong with tinfoil's debug output, its being
duplicated onto the console at times.

d) There is something wrong with the server logging. When I removed the
multiprocessing.Process(), the debug output in bitbake-cookerdaemon.log 
disappeared. Not entirely sure why, it wasn't intended and shouldn't
have changed, not sure I dare look.

e) updateToServer() has a verbose parameter but the configuration
doesn't. That is interesting and probably broken.

f) updateToServer() doesn't cover nosetscene, setsceneonly,
skipsetscene, server_only, limited_deps, runall, runonly. There are
open bugs in bugzilla re: memres this would explain.

g) writeeventlog is badly handled, set at server startup and ignored

I think what we need to do is figure out the minimal set of change
needed to make this work, that would be the possible fix for dunfell,
then we need to pull this apart and try and make it less crazy.

Cheers,

Richard





