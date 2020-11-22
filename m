Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
 by mx.groups.io with SMTP id smtpd.web10.21538.1606064364089471033
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 22 Nov 2020 08:59:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=aIJ3b1pF;
 spf=pass (domain: gmail.com, ip: 209.85.210.196, mailfrom: schnitzeltony@gmail.com)
Received: by mail-pf1-f196.google.com with SMTP id x24so355745pfn.6
        for <bitbake-devel@lists.openembedded.org>; Sun, 22 Nov 2020 08:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UwyBF+0t2LAbAvdhTt1oi2UtG0pnYXaayF5w+TZnJYQ=;
        b=aIJ3b1pFc/3o5EMBNQ1FGKL1Zjedm375jbcw6kBokFRPaKDWvIxLrlbpYedw6n9Yup
         0BoccFBen33K9tN29of9h/B0tqUP/kLH/2+GuiqtVlluUlOZ7hfVnCdSCcg8owrASRNj
         xW42KZO7lB95pjY6XkzPaJSpCVeMF9xCfGf8X1lQvFOkV/vDfNvyNyhTupJXb7t5HSt5
         Q0qou2a0QwDLR3WLuf2BvWF/Fik0b9QgJ6nj6jXpqaS5A6B1MVzuO2LYt48tUZEJv4qn
         oPyMW6cdVVd2uxFyGYXtXMdclPwk8Q8QD9LOfbKZfUfGYw8lS9nl8n6LdOnArErJTGTS
         fXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UwyBF+0t2LAbAvdhTt1oi2UtG0pnYXaayF5w+TZnJYQ=;
        b=hakcb0D/lAvmi8HCV3oKzC+08XvWPl/09t8HM8uNpxyj45HFJHk/k45zm9Oiq/DAQe
         boNrr40XoAsv/IOZgxCZK0OT6vKturvX4qfSm80/O88O1i60XA6J/8kprDpNoFSoAj5h
         4t2J76B+AWBxloi0hj7fvDrflJ1jtGk43OoEHjWUDdw1X8pJH+7JuWR2/Hj8WSF2IjQJ
         w26aYE4RYI7EFj0olw583rsZ1v/SntFk8rRIMRcQWOM62PG0GvcLtMOxcHx/rHJPjuAA
         sEK99NYV2hNxomPMRjOmskgZNJmJy57uFxBFu3fzqM0VrNlzIUjyfrfkjKRR7+sZJSFc
         f9+Q==
X-Gm-Message-State: AOAM530CUGJq8HAhzFgv1+9DrSYW1ktdoYu9dzCJ9W6Z2IdR/xO1Om7h
	QLM/evoKu+TBKEBFoe4cW6FUNibiB//YU6UV26U=
X-Google-Smtp-Source: ABdhPJxKWI3qHSNJhxWK1Ndmy3Gnb/bgVQOor7hI8jjGburuYunvdCoOhxDmpJ21TLCIZ/qfyUXc4LmBXLkHFhV/Kmw=
X-Received: by 2002:a17:90a:6042:: with SMTP id h2mr21539184pjm.77.1606064363271;
 Sun, 22 Nov 2020 08:59:23 -0800 (PST)
MIME-Version: 1.0
References: <20201116022125.38677-1-hongxu.jia@windriver.com>
In-Reply-To: <20201116022125.38677-1-hongxu.jia@windriver.com>
From: =?UTF-8?B?QW5kcmVhcyBNw7xsbGVy?= <schnitzeltony@gmail.com>
Date: Sun, 22 Nov 2020 17:59:11 +0100
Message-ID: <CALbNGRRuzGOshQcO0c-gJZkc3Of2E7fhZfAsEFQh9tsqhumPWw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] Revert "bb.ui: delete __init__.py to make bb.ui a namespace package"
To: hongxu <hongxu.jia@windriver.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	Richard Purdie <richard.purdie@linuxfoundation.org>, chris.laplante@agilent.com
Content-Type: text/plain; charset="UTF-8"

On Mon, Nov 16, 2020 at 3:21 AM hongxu <hongxu.jia@windriver.com> wrote:
>
> The commit [991f92b4d bb.ui: delete __init__.py to make bb.ui a
> namespace package] caused `bitbake -h' failed
FWIW: I saw on bitbake without extra params

|   File "/home/superandy/data/oe-core/sources/bitbake/bin/bitbake",
line 24, in <module>
|     from bb.main import bitbake_main, BitBakeConfigParameters, BBMainException
|   File "/home/superandy/data/oe-core/sources/bitbake/lib/bb/main.py",
line 24, in <module>
|     from bb import cooker
|   File "/home/superandy/data/oe-core/sources/bitbake/lib/bb/cooker.py",
line 25, in <module>
|     import prserv.serv
|   File "/home/superandy/data/oe-core/sources/bitbake/lib/prserv/serv.py",
line 13, in <module>
|     import bb.server.xmlrpcclient
|   File "/home/superandy/data/oe-core/sources/bitbake/lib/bb/server/xmlrpcclient.py",
line 15, in <module>
|     from bb.ui import uievent
| ImportError: bad magic number in 'bb.ui': b'\x03\xf3\r\n'

This revert fixes it for me

Andreas
> ...
> $ bitbake -h
> Traceback (most recent call last):
>   File "/buildarea/raid5/hjia/community/poky/bitbake/bin/bitbake", line 35, in <module>
>     sys.exit(bitbake_main(BitBakeConfigParameters(sys.argv),
>   File "/buildarea/raid5/hjia/community/poky/bitbake/lib/bb/cookerdata.py", line 27, in __init__
>     self.options, targets = self.parseCommandLine(argv or sys.argv)
>   File "/buildarea/raid5/hjia/community/poky/bitbake/lib/bb/main.py", line 297, in parseCommandLine
>     options, targets = parser.parse_args(argv)
>   File "/usr/lib64/python3.6/optparse.py", line 1387, in parse_args
>     stop = self._process_args(largs, rargs, values)
>   File "/usr/lib64/python3.6/optparse.py", line 1431, in _process_args
>     self._process_short_opts(rargs, values)
>   File "/usr/lib64/python3.6/optparse.py", line 1536, in _process_short_opts
>     option.process(opt, value, values, self)
>   File "/usr/lib64/python3.6/optparse.py", line 785, in process
>     self.action, self.dest, opt, value, values, parser)
>   File "/usr/lib64/python3.6/optparse.py", line 807, in take_action
>     parser.print_help()
>   File "/usr/lib64/python3.6/optparse.py", line 1647, in print_help
>     file.write(self.format_help())
>   File "/usr/lib64/python3.6/optparse.py", line 1635, in format_help
>     result.append(self.format_option_help(formatter))
>   File "/usr/lib64/python3.6/optparse.py", line 1615, in format_option_help
>     result.append(OptionContainer.format_option_help(self, formatter))
>   File "/usr/lib64/python3.6/optparse.py", line 1061, in format_option_help
>     result.append(formatter.format_option(option))
>   File "/buildarea/raid5/hjia/community/poky/bitbake/lib/bb/main.py", line 54, in format_option
>     valid_uis = list_extension_modules(bb.ui, 'main')
>   File "/buildarea/raid5/hjia/community/poky/bitbake/lib/bb/main.py", line 72, in list_extension_modules
>     pkgdir = os.path.dirname(pkg.__file__)
> AttributeError: module 'bb.ui' has no attribute '__file__'
> ...
>
> This reverts commit 991f92b4d15b0571b6a540964e5216d1b9728539
>
> Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
> ---
>  lib/bb/ui/__init__.py | 7 +++++++
>  1 file changed, 7 insertions(+)
>  create mode 100644 lib/bb/ui/__init__.py
>
> diff --git a/lib/bb/ui/__init__.py b/lib/bb/ui/__init__.py
> new file mode 100644
> index 000000000..4b7ac36ca
> --- /dev/null
> +++ b/lib/bb/ui/__init__.py
> @@ -0,0 +1,7 @@
> +#
> +# BitBake UI Implementation
> +#
> +# Copyright (C) 2006-2007 Richard Purdie
> +#
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> --
> 2.21.0
>
>
> 
>
