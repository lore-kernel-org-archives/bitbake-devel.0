Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
 by mx.groups.io with SMTP id smtpd.web10.4036.1612955638360667525
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Feb 2021 03:13:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=K1s3El1C;
 spf=pass (domain: gmail.com, ip: 209.85.166.48, mailfrom: tomasz.dziendzielski@gmail.com)
Received: by mail-io1-f48.google.com with SMTP id p132so1426686iod.11
        for <bitbake-devel@lists.openembedded.org>; Wed, 10 Feb 2021 03:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=myoUmBlBkdJgsvgyXiBm0NVcsflz9/3HOd/OEXS+Tkg=;
        b=K1s3El1CV60tC8AVBbp7k6QtsRQ4palRGqwdbVkEv00UrJBQ8R6d28sODZXi/yKotS
         XDajT1t+R0jnr96NRuRd+1I1OTg4X+C3NJpvq9qaDvdmxyvRoqltX+px/KtqDr+OAVdl
         tDr7tmU8cbDC+pKJyo3M6AEl8OJqqGqn3grQ2BRUnApOp2z4AOCzaFwntW3XJWH4DOFl
         RKGYyn8w2T38J4DtF7nKzf8NsqE2aNj8gnSM+28x2y+LLysyx2dTBmIhnlvYQwiLH3ap
         zgUpwO9q5Lu+/zV44GH/XTSz4qvjjtdMkHq5vFlXVN3Qtvah9yw/GYx7r3mMf4peF64m
         pKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=myoUmBlBkdJgsvgyXiBm0NVcsflz9/3HOd/OEXS+Tkg=;
        b=jbXGOMfnf4yDbckpihMWetlsr00W6GuvrkBoEiClmcu+R0m9UitegQKwlRtAGclUsa
         6mHN8K3fV0KIDBxJU1kwhodpyaHbgPOhkpmpoFY81oD3LW2WX4y3lKBasJmnQQefL+hA
         LeoV/Qt/Tjh2Y64nfPtoN0nmt8E8IRxRL4yhjKLVcLfc/vwus3+LF6RqD3pxg1ls6y21
         E3dDOZL7L3h2fQY3PbyrkgWpA5Coz/Bi7+JRpo8zfUrI1tU2yQSBSMnhDZJgK3Z/X8k9
         mbU2wR3jZl6LrFJTydFIv+d/gEX5Vdb7+toK87pJjj3T/+vCLk7G0vQcRGScTVvURCdz
         U8VQ==
X-Gm-Message-State: AOAM531GjMQ0Dj9CYYbzK9FMN8Ods5VwOULphkg0/x5Ek0Lh6jbhN9gL
	nwSHD0nmK6EfYBocLgFYWGo31PNE22ezgYDRozM=
X-Google-Smtp-Source: ABdhPJzYUJkfKAIwmgU7Lc0NkTI4MzaltPqaV8aTvqJw8PrKygH0zYhfb238COYzfOlr3hXoNuzlHLkyrT3wsRAUJ80=
X-Received: by 2002:a05:6602:cc:: with SMTP id z12mr470352ioe.190.1612955637692;
 Wed, 10 Feb 2021 03:13:57 -0800 (PST)
MIME-Version: 1.0
References: <20210207114659.148514-1-tomasz.dziendzielski@gmail.com>
 <9a9ad16dbe9d6540fb375d8419fbb569334c1757.camel@linuxfoundation.org> <16621F570CFF73B9.16853@lists.openembedded.org>
In-Reply-To: <16621F570CFF73B9.16853@lists.openembedded.org>
From: "Tomasz Dziendzielski" <tomasz.dziendzielski@gmail.com>
Date: Wed, 10 Feb 2021 12:15:23 +0100
Message-ID: <CAJkqNs1JZWCvBmKfA9bqZRcz7WPtOYPEjXEBMYpfwdFhx8HNDg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v4] event: Prevent bitbake from executing event handler for wrong multiconfig target
To: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000d2bbb605baf97f67"

--000000000000d2bbb605baf97f67
Content-Type: text/plain; charset="UTF-8"

>>I did also wonder if we should be changing each of the event register
>>callers, or doing something inside the event register function instead?
Thanks again for your suggestion, it was the right way to go that solved
the inconsistency with bb_diskmonitor event handler (and any other that
would be registered manually, without addhandler statement). I prepared the
change and it does not trigger any errors. I tested it with:
$ bitbake-selftest
$ oe-selftest -r multiconfig,
$ oe-selftest -r buildoptions.DiskMonTest.test_stoptask_behavior
$ yocto-check-layer-wrapper ../meta-mingw
$ bitbake core-image-sato:do_testsdkext core-image-minimal:do_testsdkext
core-image-sato:do_testsdkext (only for qemux86-64, one of the machines
that was failing)
which are the tests that failed with previous patches and now all tests
passed.

Please check the next patch:
https://lists.openembedded.org/g/bitbake-devel/message/12020

Best regards,
Tomasz Dziendzielski

--000000000000d2bbb605baf97f67
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><span class=3D"gmail-im">&gt;&gt;I did al=
so wonder if we should be changing each of the event register<br><div>
&gt;&gt;callers, or doing something inside the event register function inst=
ead?<br></div><div>Thanks again for your suggestion, it was the right way t=
o go that solved the inconsistency with bb_diskmonitor event handler (and a=
ny other that would be registered manually, without addhandler statement). =
I prepared the change and it does not trigger any errors. I tested it with:=
<br>$ bitbake-selftest<br>$ oe-selftest -r multiconfig,<br>$ oe-selftest -r=
 buildoptions.DiskMonTest.test_stoptask_behavior<br>$ yocto-check-layer-wra=
pper ../meta-mingw<br></div><div>$ bitbake core-image-sato:do_testsdkext co=
re-image-minimal:do_testsdkext core-image-sato:do_testsdkext (only for qemu=
x86-64, one of the machines that was failing)</div><div>which are the tests=
 that failed with previous patches and now all tests passed.</div><div><br>=
</div><div>Please check the next patch:<br><a href=3D"https://lists.openemb=
edded.org/g/bitbake-devel/message/12020">https://lists.openembedded.org/g/b=
itbake-devel/message/12020</a></div><div><br></div><div>Best regards,</div>=
<div>Tomasz Dziendzielski<br></div></span></div></div>

--000000000000d2bbb605baf97f67--
