Return-Path: <ross.burton@intel.com>
Received: from mail-it0-f54.google.com (mail-it0-f54.google.com
	[209.85.214.54])
	by mail.openembedded.org (Postfix) with ESMTP id 1F502755A1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 May 2018 12:28:53 +0000 (UTC)
Received: by mail-it0-f54.google.com with SMTP id z6-v6so1823480iti.4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 May 2018 05:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=c0K+nBmBNTaS8nzE1r+dkmI28qgbazu+SQJovdFUxco=;
	b=qRKvDy60fIvti6endxog1cjF/bQr/2EgsXDp3B3TjaJC3qA8YQ4gIwHC2U14k+m6K7
	8G3V82m+sflQ3aQVEkk/hmf9ZcLWPVnjbxzJI0QNeSfs9NPLrfFSciMPn8HU6lTMmU33
	vPazAI41ngH5nMNT08WYQvCQj3Hv9Eg+UqJYsX932DiIK7l4DNp5al5Zj1SlAYQx+eyt
	pT6ODmWPcqlochS/X7d1AOx+MbitGhlEs6RxzZasVX4sIxQ3EXuCi/wl5KivVsPYCJpf
	h1FVLftgxMBxdJiARLZgcF3bzZMZZjp4JFxao8Ol40DIbqbd6LWoqphDnXkRGt1Da8cH
	9jaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=c0K+nBmBNTaS8nzE1r+dkmI28qgbazu+SQJovdFUxco=;
	b=JeEgpNDmHe1huokfVCRLjubOEyZylRw4EFhNxbPcg12rrpDiMNf00hvOZyIVQ3skyu
	jo5LSNpSy+NIN0h4eRE9fWxM/8uRYbGjzh/7xEDBudKzM/majHBeXpxH4a9y8+hq6uN2
	4z36PC5DVn+bVBp99JpnDwhpjjuYbkTe9x3FKSKnG209cxPowyw4bMmZtpJOVjcllZ0Q
	AWmrOuD9l9iivgTKHtlIlGsk5zJJY0gfF+LEUcp6NLoNCWsPWa/dwcQIGYkT/PKf++fQ
	Kh/o/LS4LCLZLyYXSu0zsHTm9LTr2roC1qGszproBujNxdj2lJh1fUIb4EbE8d0N4ziK
	k43w==
X-Gm-Message-State: ALKqPwf5jWsPGOPi6PmUm1IGn61WwoeWBwsKGEOrRvT9QOyUwmzd8v7E
	qSHEE9lAVS0pZLzvb6eEnZH9SFR19N0zfzc3FdqefA==
X-Google-Smtp-Source: AB8JxZrYx5ApeQQWiYKtvyAm24CH2IAu2yAStwBDCj1GTcS8hzKK4fohzb9jb7M32ZJupMEXZl234qeqt9bI8RJmTHA=
X-Received: by 2002:a24:a00a:: with SMTP id
	o10-v6mr3048441ite.34.1526041734645; 
	Fri, 11 May 2018 05:28:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.239.11 with HTTP; Fri, 11 May 2018 05:28:34 -0700 (PDT)
In-Reply-To: <20180510023357.96409-1-matt.hoosier@gmail.com>
References: <20180510023357.96409-1-matt.hoosier@gmail.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Fri, 11 May 2018 13:28:34 +0100
Message-ID: <CAJTo0LYFNknuqk_xyecvEgDFweFr5vXFwu3N5bNkLZDdcq=4Nw@mail.gmail.com>
To: Matt Hoosier <matt.hoosier@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch/gitsm: avoid live submodule fetching during unpack()
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
X-List-Received-Date: Fri, 11 May 2018 12:28:54 -0000
Content-Type: text/plain; charset="UTF-8"

This breaks bitbake-selftest:

$ bitbake-selftest  bb.tests.fetch.GitShallowTest
........................E

ERROR: test_shallow_submodules (bb.tests.fetch.GitShallowTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/home/ross/Yocto/poky/bitbake/lib/bb/tests/fetch.py", line
1353, in test_shallow_submodules
    fetcher, ud = self.fetch_shallow(uri)
  File "/home/ross/Yocto/poky/bitbake/lib/bb/tests/fetch.py", line
1198, in fetch_shallow
    fetcher, ud = self.fetch_and_unpack(uri)
  File "/home/ross/Yocto/poky/bitbake/lib/bb/tests/fetch.py", line
1179, in fetch_and_unpack
    fetcher.unpack(self.d.getVar('WORKDIR'))
  File "/home/ross/Yocto/poky/bitbake/lib/bb/fetch2/__init__.py", line
1762, in unpack
    ud.method.unpack(ud, root, self.d)
  File "/home/ross/Yocto/poky/bitbake/lib/bb/fetch2/gitsm.py", line
141, in unpack
    runfetchcmd("cp -pr %s %s" % (os.path.join(ud.clonedir,
'modules'), repo_conf), d)
  File "/home/ross/Yocto/poky/bitbake/lib/bb/fetch2/__init__.py", line
885, in runfetchcmd
    raise FetchError(error_message)
bb.fetch2.FetchError: Fetcher failure: Fetch command export
PSEUDO_DISABLED=1; cp -pr
/tmp/tmpxi2ydemw/download/git2/tmp.tmpxi2ydemw.gitsource/modules
/tmp/tmpxi2ydemw/git/.git failed with exit code 1, output:
cp: cannot stat
'/tmp/tmpxi2ydemw/download/git2/tmp.tmpxi2ydemw.gitsource/modules': No
such file or directory

Ross

On 10 May 2018 at 03:33, Matt Hoosier <matt.hoosier@gmail.com> wrote:
> Although the submodules' histories have been fetched during the
> do_fetch() phase, the mechanics used to clone the workdir copy
> of the repo haven't been transferring the actual .git/modules
> directory from the repo fetched into downloads/ during the
> fetch task.
>
> Fix that, and for good measure also explicitly tell Git to avoid
> hitting the network during do_unpack() of the submodules.
>
> [YOCTO #12739]
>
> Signed-off-by: Matt Hoosier <matt.hoosier@gmail.com>
> ---
>  lib/bb/fetch2/gitsm.py | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
> index 0aff1008..1f3fc443 100644
> --- a/lib/bb/fetch2/gitsm.py
> +++ b/lib/bb/fetch2/gitsm.py
> @@ -132,4 +132,14 @@ class GitSM(Git):
>
>          if self.uses_submodules(ud, d, ud.destdir):
>              runfetchcmd(ud.basecmd + " checkout " + ud.revisions[ud.names[0]], d, workdir=ud.destdir)
> -            runfetchcmd(ud.basecmd + " submodule update --init --recursive", d, workdir=ud.destdir)
> +
> +            # Copy over the submodules' fetched histories too.
> +            if ud.bareclone:
> +                repo_conf = ud.destdir
> +            else:
> +                repo_conf = os.path.join(ud.destdir, '.git')
> +            runfetchcmd("cp -pr %s %s" % (os.path.join(ud.clonedir, 'modules'), repo_conf), d)
> +
> +            # Careful not to hit the network during unpacking; all history should already
> +            # be fetched.
> +            runfetchcmd(ud.basecmd + " submodule update --init --recursive --no-fetch", d, workdir=ud.destdir)
> --
> 2.13.6
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

