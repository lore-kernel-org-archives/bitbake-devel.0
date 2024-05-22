Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B959C25B7A
	for <webhook@archiver.kernel.org>; Wed, 22 May 2024 13:07:03 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web11.9508.1716383213591160846
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 May 2024 06:06:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=hNWFXiIq;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41dc9c83e57so4625775e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 22 May 2024 06:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716383212; x=1716988012; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt:date:to
         :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Pz2nI2X1Wz0vi0DeQ8OZ7G18ss3OzXCNWzDDhQZ4MQ4=;
        b=hNWFXiIq0o5MDe2wPVk2yZrOltIkHsn+TXAJsCYI4OkMGm0sykQyZL6MK5vHCsiGoP
         /BjsQXVH+wY/zqen19XJRjVQlbHEA5i4K3+B4Z+JL0FXICxyhVsk0UUSEik0OGsHhCHp
         z14mqV/hhpE1qTZKQq549lFTmDqxt7Ly+4A1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716383212; x=1716988012;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt:date:to
         :from:subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pz2nI2X1Wz0vi0DeQ8OZ7G18ss3OzXCNWzDDhQZ4MQ4=;
        b=SkStOUrAHH1thEw12F1WHKugAATy+DEZA0RC7J33E2/678etiXilOYcCLvukAhIRJU
         2xaPE7e/fhSZ59Zfi12o41iTuWjYNvl8DyOh/pjX33eTCm9C+kYkgfF9QqyC0yVBuMG9
         /xUbjPmAUM8PcuI7WKlVBXqaBTG22x8WY46yBJA9eZlwdxhGa1cLVQlPhXX/15aZAwoY
         6BZa+rEbEHvWy5HYeT9cj3PZcNIg4kSuBUOJoPm5NXZ1BW6lArGEUa7pIGAk7sMamRzp
         QKCZHVthCT+K/6ANgwuUeYuw1doVssxfb4GNBY/NriSn/JtorD0BjpxzWsiEvD2/NZ0j
         hnYg==
X-Gm-Message-State: AOJu0YwCHJYQ1hc1nafA3bGfp+EwpnSUncxgSBpwzJgkjMqvh5pD45fc
	Culn1+tQafNqQS71soeEZbIOlfFxsy3q4pk6DPvLfjhLLwgzMOLtCdwiwVNeGuq/PjO+lZbv5zp
	R0L4=
X-Google-Smtp-Source: AGHT+IFb6i9y/Iemx6uiLelJM/pANRq5W1aS4kjLVF/WQ6Io2otfEzAmlgMhN7meeSs8FHl48E0o5w==
X-Received: by 2002:adf:e983:0:b0:354:df9a:f99a with SMTP id ffacd0b85a97d-354df9afa80mr1418724f8f.11.1716383211676;
        Wed, 22 May 2024 06:06:51 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:ef1c:155d:9d8e:11ce? ([2001:8b0:aba:5f3c:ef1c:155d:9d8e:11ce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-354bf20a20esm10576724f8f.39.2024.05.22.06.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 06:06:51 -0700 (PDT)
Message-ID: <0acc887d10a8eefc5fb9a7ef8c6bf4f00c36e03d.camel@linuxfoundation.org>
Subject: hashserv performance issues
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>, Joshua Watt
	 <JPEWhacker@gmail.com>, Michael Halstead <mhalstead@linuxfoundation.org>
Date: Wed, 22 May 2024 14:06:50 +0100
Autocrypt: addr=richard.purdie@linuxfoundation.org; prefer-encrypt=mutual; keydata=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
 YNvg==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 May 2024 13:07:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16237

I noticed that qemux86-world-alt builds are slow. At times it seems to
sit doing nothing and I've been wondering why. Today I think I tracked
down the area of the problem. Taking this one for example:

https://valkyrie.yoctoproject.org/#/builders/17/builds/10/steps/11/logs/std=
io

We see sections like:

NOTE: recipe lib32-ncurses-6.5-r0: task do_install: Succeeded
NOTE: Task virtual:multilib:lib32:/home/pokybuild/yocto-worker/qemux86-worl=
d-alt/build/meta/recipes-core/util-linux/util-linux-libuuid_2.39.3.bb:do_po=
pulate_sysroot unihash changed to 425a027df360cff6d5f90787acb5f35012def9e31=
092b703e5ee8cfddd017217
NOTE: Task virtual:multilib:lib32:/home/pokybuild/yocto-worker/qemux86-worl=
d-alt/build/meta/recipes-extended/cracklib/cracklib_2.9.11.bb:do_populate_s=
ysroot unihash changed to 16d675f49fadb32389099ef4c4ecd2e6ce299ae775e329dae=
d38cc3b67fc963f
NOTE: Task virtual:multilib:lib32:/home/pokybuild/yocto-worker/qemux86-worl=
d-alt/build/meta/recipes-support/bash-completion/bash-completion_2.13.0.bb:=
do_populate_sysroot unihash changed to d2551c1c6abb19087cefa06275d0610f5eb1=
3b83aa2dd09e8c1f1a2cc9d95483
Bitbake still alive (no events for 600s). Active tasks:
Bitbake still alive (no events for 1200s). Active tasks:
NOTE: Setscene tasks completed
NOTE: Running task 2801 of 37383 (/home/pokybuild/yocto-worker/qemux86-worl=
d-alt/build/meta/recipes-core/ncurses/ncurses_6.5.bb:do_populate_sysroot)
NOTE: Pressure status changed to CPU: False, IO: True, Mem: None (CPU: 1317=
.8/20000.0, IO: 23192.6/20000.0, Mem: 0.0/None) - using 1/16 bitbake thread=
s
NOTE: Pressure status changed to CPU: False, IO: False, Mem: None (CPU: 105=
4.9/20000.0, IO: 18565.4/20000.0, Mem: 0.0/None) - using 1/16 bitbake threa=
ds
NOTE: Running task 2802 of 37383 (virtual:multilib:lib32:/home/pokybuild/yo=
cto-worker/qemux86-world-alt/build/meta/recipes-core/ncurses/ncurses_6.5.bb=
:do_populate_sysroot)
NOTE: Running task 2803 of 37383 (/home/pokybuild/yocto-worker/qemux86-worl=
d-alt/build/meta/recipes-support/sqlite/sqlite3_3.45.3.bb:do_install)
NOTE: Running task 2804 of 37383 (virtual:multilib:lib32:/home/pokybuild/yo=
cto-worker/qemux86-world-alt/build/meta/recipes-support/sqlite/sqlite3_3.45=
.3.bb:do_install)
NOTE: Running task 2805 of 37383 (/home/pokybuild/yocto-worker/qemux86-worl=
d-alt/build/meta/recipes-extended/pam/libpam_1.6.1.bb:do_prepare_recipe_sys=
root)
NOTE: Running task 2806 of 37383 (virtual:multilib:lib32:/home/pokybuild/yo=
cto-worker/qemux86-world-alt/build/meta/recipes-extended/pam/libpam_1.6.1.b=
b:do_prepare_recipe_sysroot)
NOTE: Running task 2807 of 37383 (/home/pokybuild/yocto-worker/qemux86-worl=
d-alt/build/meta/recipes-support/libpcre/libpcre2_10.43.bb:do_install)
NOTE: Running task 2808 of 37383 (virtual:multilib:lib32:/home/pokybuild/yo=
cto-worker/qemux86-world-alt/build/meta/recipes-support/libpcre/libpcre2_10=
.43.bb:do_install)
NOTE: Running task 2809 of 37383 (/home/pokybuild/yocto-worker/qemux86-worl=
d-alt/build/meta/recipes-support/libcap-ng/libcap-ng_0.8.4.bb:do_compile)
NOTE: Running task 2810 of 37383 (virtual:multilib:lib32:/home/pokybuild/yo=
cto-worker/qemux86-world-alt/build/meta/recipes-support/libcap-ng/libcap-ng=
_0.8.4.bb:do_compile)
NOTE: Running task 2811 of 37383 (/home/pokybuild/yocto-worker/qemux86-worl=
d-alt/build/meta/recipes-support/attr/attr_2.5.2.bb:do_prepare_recipe_sysro=
ot)
NOTE: Running task 2812 of 37383 (virtual:multilib:lib32:/home/pokybuild/yo=
cto-worker/qemux86-world-alt/build/meta/recipes-support/attr/attr_2.5.2.bb:=
do_prepare_recipe_sysroot)
NOTE: Running task 2813 of 37383 (/home/pokybuild/yocto-worker/qemux86-worl=
d-alt/build/meta/recipes-devtools/gcc/gcc-runtime_14.1.bb:do_package)
NOTE: Running task 2814 of 37383 (/home/pokybuild/yocto-worker/qemux86-worl=
d-alt/build/meta/recipes-graphics/xorg-util/util-macros_1.20.1.bb:do_prepar=
e_recipe_sysroot)
NOTE: recipe ncurses-6.5-r0: task do_populate_sysroot: Started
NOTE: recipe sqlite3-3_3.45.3-r0: task do_install: Started

i.e. it is "rehashing" (a unihash changes) and then it stalls for
1200s. In this case there are no active tasks running. This isn't
isolated, another example:

NOTE: Task virtual:multilib:lib32:/home/pokybuild/yocto-worker/qemux86-worl=
d-alt/build/meta/recipes-support/sqlite/sqlite3_3.45.3.bb:do_populate_sysro=
ot unihash changed to ea94eb54580e74d73415cb75391bf7adc26c10b216c9730d3c5b2=
4d2cd164d8d
Bitbake still alive (no events for 600s). Active tasks:
/home/pokybuild/yocto-worker/qemux86-world-alt/build/meta/recipes-core/ncur=
ses/ncurses_6.5.bb:do_populate_sysroot
virtual:multilib:lib32:/home/pokybuild/yocto-worker/qemux86-world-alt/build=
/meta/recipes-core/ncurses/ncurses_6.5.bb:do_populate_sysroot
/home/pokybuild/yocto-worker/qemux86-world-alt/build/meta/recipes-devtools/=
gcc/gcc-runtime_14.1.bb:do_package
/home/pokybuild/yocto-worker/qemux86-world-alt/build/meta/recipes-extended/=
pam/libpam_1.6.1.bb:do_configure
/home/pokybuild/yocto-worker/qemux86-world-alt/build/meta/recipes-support/l=
ibpcre/libpcre2_10.43.bb:do_populate_sysroot
virtual:multilib:lib32:/home/pokybuild/yocto-worker/qemux86-world-alt/build=
/meta/recipes-extended/pam/libpam_1.6.1.bb:do_configure
virtual:multilib:lib32:/home/pokybuild/yocto-worker/qemux86-world-alt/build=
/meta/recipes-support/libpcre/libpcre2_10.43.bb:do_populate_sysroot
/home/pokybuild/yocto-worker/qemux86-world-alt/build/meta/recipes-support/l=
ibcap-ng/libcap-ng_0.8.4.bb:do_populate_sysroot
virtual:multilib:lib32:/home/pokybuild/yocto-worker/qemux86-world-alt/build=
/meta/recipes-support/libcap-ng/libcap-ng_0.8.4.bb:do_populate_sysroot
/home/pokybuild/yocto-worker/qemux86-world-alt/build/meta/recipes-graphics/=
xorg-proto/xorgproto_2024.1.bb:do_populate_sysroot
/home/pokybuild/yocto-worker/qemux86-world-alt/build/meta/recipes-graphics/=
xorg-util/util-macros_1.20.1.bb:do_populate_sysroot
/home/pokybuild/yocto-worker/qemux86-world-alt/build/meta/recipes-support/a=
ttr/attr_2.5.2.bb:do_compile
virtual:multilib:lib32:/home/pokybuild/yocto-worker/qemux86-world-alt/build=
/meta/recipes-support/attr/attr_2.5.2.bb:do_compile
virtual:multilib:lib32:/home/pokybuild/yocto-worker/qemux86-world-alt/build=
/meta/recipes-devtools/gcc/gcc-runtime_14.1.bb:do_package
Bitbake still alive (no events for 1200s). Active tasks:
/home/pokybuild/yocto-worker/qemux86-world-alt/build/meta/recipes-core/ncur=
ses/ncurses_6.5.bb:do_populate_sysroot
virtual:multilib:lib32:/home/pokybuild/yocto-worker/qemux86-world-alt/build=
/meta/recipes-core/ncurses/ncurses_6.5.bb:do_populate_sysroot
/home/pokybuild/yocto-worker/qemux86-world-alt/build/meta/recipes-devtools/=
gcc/gcc-runtime_14.1.bb:do_package
/home/pokybuild/yocto-worker/qemux86-world-alt/build/meta/recipes-extended/=
pam/libpam_1.6.1.bb:do_configure
/home/pokybuild/yocto-worker/qemux86-world-alt/build/meta/recipes-support/l=
ibpcre/libpcre2_10.43.bb:do_populate_sysroot
virtual:multilib:lib32:/home/pokybuild/yocto-worker/qemux86-world-alt/build=
/meta/recipes-extended/pam/libpam_1.6.1.bb:do_configure
virtual:multilib:lib32:/home/pokybuild/yocto-worker/qemux86-world-alt/build=
/meta/recipes-support/libpcre/libpcre2_10.43.bb:do_populate_sysroot
/home/pokybuild/yocto-worker/qemux86-world-alt/build/meta/recipes-support/l=
ibcap-ng/libcap-ng_0.8.4.bb:do_populate_sysroot
virtual:multilib:lib32:/home/pokybuild/yocto-worker/qemux86-world-alt/build=
/meta/recipes-support/libcap-ng/libcap-ng_0.8.4.bb:do_populate_sysroot
/home/pokybuild/yocto-worker/qemux86-world-alt/build/meta/recipes-graphics/=
xorg-proto/xorgproto_2024.1.bb:do_populate_sysroot
/home/pokybuild/yocto-worker/qemux86-world-alt/build/meta/recipes-graphics/=
xorg-util/util-macros_1.20.1.bb:do_populate_sysroot
/home/pokybuild/yocto-worker/qemux86-world-alt/build/meta/recipes-support/a=
ttr/attr_2.5.2.bb:do_compile
virtual:multilib:lib32:/home/pokybuild/yocto-worker/qemux86-world-alt/build=
/meta/recipes-support/attr/attr_2.5.2.bb:do_compile
virtual:multilib:lib32:/home/pokybuild/yocto-worker/qemux86-world-alt/build=
/meta/recipes-devtools/gcc/gcc-runtime_14.1.bb:do_package

in this case, again there is a rehash and this time there are active
tasks running but it stalls for over 1200s.

I was able to login and connect gdb to get a python backtrace, the
useful piece of which was:

Traceback (most recent call first):
  File "/usr/lib/python3.10/selectors.py", line 469, in select
    fd_event_list =3D self._selector.poll(timeout, max_ev)
  File "/usr/lib/python3.10/asyncio/base_events.py", line 1871, in _run_onc=
e
    event_list =3D self._selector.select(timeout)
  File "/usr/lib/python3.10/asyncio/base_events.py", line 603, in run_forev=
er
    self._run_once()
  File "/usr/lib/python3.10/asyncio/base_events.py", line 636, in run_until=
_complete
    self.run_forever()
  File "/home/pokybuild/yocto-worker/qemux86-world-alt/build/bitbake/lib/bb=
/asyncrpc/client.py", line 225, in wrapper
    return self.loop.run_until_complete(downcall(*args, **kwargs))
  File "/home/pokybuild/yocto-worker/qemux86-world-alt/build/bitbake/lib/bb=
/siggen.py", line 732, in get_unihashes
    query_result[tid] =3D client.get_unihash(*args)
  File "/home/pokybuild/yocto-worker/qemux86-world-alt/build/bitbake/lib/bb=
/siggen.py", line 707, in get_unihash
    return self.get_unihashes([tid])[tid]
  File "/home/pokybuild/yocto-worker/qemux86-world-alt/build/bitbake/lib/bb=
/runqueue.py", line 2570, in process_possible_migrations
    newuni =3D bb.parse.siggen.get_unihash(tid)
  File "/home/pokybuild/yocto-worker/qemux86-world-alt/build/bitbake/lib/bb=
/runqueue.py", line 2173, in execute
    self.process_possible_migrations()
  File "/home/pokybuild/yocto-worker/qemux86-world-alt/build/bitbake/lib/bb=
/runqueue.py", line 1603, in _execute_runqueue
    retval =3D self.rqexe.execute()
  File "/home/pokybuild/yocto-worker/qemux86-world-alt/build/bitbake/lib/bb=
/runqueue.py", line 1637, in execute_runqueue
    return self._execute_runqueue()
  File "/home/pokybuild/yocto-worker/qemux86-world-alt/build/bitbake/lib/bb=
/cooker.py", line 1488, in buildTargetsIdle
    retval =3D rq.execute_runqueue()
  File "/home/pokybuild/yocto-worker/qemux86-world-alt/build/bitbake/lib/bb=
/server/process.py", line 435, in idle_thread_internal
    retval =3D function(self, data, False)
  File "/home/pokybuild/yocto-worker/qemux86-world-alt/build/bitbake/lib/bb=
/server/process.py", line 418, in idle_thread
    self.idle_thread_internal()
  File "/usr/lib/python3.10/threading.py", line 953, in run
    self._target(*self._args, **self._kwargs)
  File "/usr/lib/python3.10/threading.py", line 1016, in _bootstrap_inner
    self.run()
  File "/usr/lib/python3.10/threading.py", line 973, in _bootstrap
    self._bootstrap_inner()

i.e. it is looping in process_possible_migrations() in runqueue.py and
stalling on the get_unihash() calls.

I put a patch on master-next which batches those up into a block
get_unihashes() call but when trying to test that, I noticed this:

https://valkyrie.yoctoproject.org/#/builders/17/builds/13

Initialising tasks...Bitbake still alive (no events for 600s). Active tasks=
:
Bitbake still alive (no events for 1200s). Active tasks:

i.e. we have the same issue at runqueue init time, it shouldn't take
over 1200s there.

This suggests that there could be something wrong with the hash server
making it very slow, or the geo round trip time to the server is poor,
or something else is going wrong with the hash server performance.

I thought I'd share the findings so far in case someone can make sense
of what is going on.

Cheers,

Richard




