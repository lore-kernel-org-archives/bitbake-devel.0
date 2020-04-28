Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
 by mx.groups.io with SMTP id smtpd.web11.529.1588111443413650874
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 28 Apr 2020 15:04:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=VvuBxwQS;
 spf=pass (domain: gmail.com, ip: 209.85.128.68, mailfrom: andrey.z@gmail.com)
Received: by mail-wm1-f68.google.com with SMTP id v4so3394906wme.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 28 Apr 2020 15:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=lP+rMvp8ND6ou21rJ3FXY8giW0EoVrbzGU5HHhqGvdk=;
        b=VvuBxwQSMWIp0yHiWR9lILCOvI+Kj4fCeo6txQygCJYlxditzeoXqvIMaYHGs5iDQm
         lsH+7VXB5aukpgoeOCEJs7FqKQxGND5i2tqutUiVQq6J9uOM5L0RH7j/zWITP/kWE388
         SEpOiwNdpMIVTkO9I8eqYA/6YETDrAhCyJ+AM8YN4mo65SgIbFOTaCh62ANQGPt8pAnw
         C119RXLqFd01rcE13NwPf4NUpOxY5+aT02fMhtr1S7aUSm68MlRmaHsYe6lS9kGFJoGm
         NHu4IAjgZvPT5MoRE2Ufsen4oPGznFp61hfg1mTUeqltRaDgMVr/1GHqXgzpd4E2Ov3z
         iDYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=lP+rMvp8ND6ou21rJ3FXY8giW0EoVrbzGU5HHhqGvdk=;
        b=WIkHIjECQSZE3qioifGIzG56o6xyvYkzVGgnNu9O4uWWK7JIYiM2wrAiHrUkjtlVFx
         ciPih4Tow8g0VyitTUu1muV8pNrYD+In82mkKAZCzroI6ykV6whOZ0FSCM0cTi9bBnar
         yvaFpBvU4Y/DSpSozK/mtcPChkmeqanFol99Ordt0mQW7T07hMqclMtlIRvGVWqNiBiN
         zY9P47JgKgRkZaaiKIIdmWPSBfRfKi2FpBsYyZQmVpauKgQDE/3W2EQGl/rGncXOignl
         HhDCmbmfUSMJLf9ct4K0mWcS2yKV9HJm2J10uxo9nBarvezKOl3Uf17EY0r6riRKSBzO
         0ltA==
X-Gm-Message-State: AGi0PuYO20MOSRbNXEviOATj3SaXg2wcYv+EvD55y1AbiyWMiKW3hZo4
	H1uhWEBKzAO6o0k0ey5WHSKNJ3UIwXqS2EBe2Oqixhto
X-Google-Smtp-Source: APiQypJjNCvIbuq6EE/qzkSAdoZLDVzSJ775e7A1j37eECBOrDs16R0usHuyyB/mUPO2EF5OvitYjp/In8JW7KojxRI=
X-Received: by 2002:a1c:59c3:: with SMTP id n186mr6577087wmb.24.1588111441735;
 Tue, 28 Apr 2020 15:04:01 -0700 (PDT)
MIME-Version: 1.0
From: "Andrey Zhizhikin" <andrey.z@gmail.com>
Date: Wed, 29 Apr 2020 00:03:52 +0200
Message-ID: <CAHtQpK54tCZf3PHY657cjARhj_j2X6SM834yybiCyk2EPO2Srg@mail.gmail.com>
Subject: ui/teamcity plugin is broken on master
To: bitbake-devel@lists.openembedded.org
Cc: chris.laplante@agilent.com
Content-Type: text/plain; charset="UTF-8"

Hello all,

I've tried to use the teamcity UI plugin, but it fails to start with
following error messages:
------------------------------
Traceback (most recent call last):
  File "/development/yocto-master/yocto-build-appliance/bitbake/bin/bitbake",
line 36, in <module>
    cookerdata.CookerConfiguration()))
  File "/development/yocto-master/yocto-build-appliance/bitbake/lib/bb/main.py",
line 385, in bitbake_main
    configParams)
  File "/development/yocto-master/yocto-build-appliance/bitbake/lib/bb/ui/teamcity.py",
line 170, in main
    bb.msg.addDefaultlogFilter(console, bb.msg.BBLogFilterStdOut, forcelevel)
AttributeError: module 'bb.msg' has no attribute 'BBLogFilterStdOut'
------------------------------

It looks like those filters (BBLogFilterStdOut and BBLogFilterStdErr)
were dropped with the commit 143685de1b9b0386a4dc8d404bdf342b45b7c030
in upstream, so the plugin should have a great deal of rework now...

I was able to bring it back to life by removing following lines from
[bitbake/lib/bb/ui/teamcity.py]:
-    bb.msg.addDefaultlogFilter(console, bb.msg.BBLogFilterStdOut, forcelevel)
-    bb.msg.addDefaultlogFilter(errconsole, bb.msg.BBLogFilterStdErr)

But that modification is considered a hack and I would not even dare
to send a patch for this.

I was wondering if anyone already had the same issue and is there a
plan to update the teamcity UI plugin to use new log filter mechanisms
(like knotty currently does)?

-- 
Regards,
Andrey.
