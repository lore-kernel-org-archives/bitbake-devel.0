Return-Path: <jacob.kroon@gmail.com>
Received: from mail-it1-f195.google.com (mail-it1-f195.google.com
	[209.85.166.195])
	by mail.openembedded.org (Postfix) with ESMTP id 457527D717
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 May 2019 10:51:04 +0000 (UTC)
Received: by mail-it1-f195.google.com with SMTP id q19so9251544itk.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 01 May 2019 03:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=sEELVfqzWb0TQCtZeJL8ETvdBeTp4af4qLpdwA4SsrM=;
	b=TPOTjlNJJ6mUCxrYbnT+HpBS8mW4S25ZL+sC8Kj51w8aGoFU3YC47tPoqBxcYeOmi7
	0IuJUG2OPHNg2qRneadyNa2PYFYz7FQM4xZygoBFAc78I7SYvaMgQfxnhMd4aPl5peLU
	KOflY+3kS/1vN5vdhN6W3XoEVWFGDrN2UB8IyAB7wiGBQpJiIHhs/CpOkRR/iUJTAqi1
	Ouc2t0m+t1ee91aFHqKYhjpNafWTmrgKxEgPm3W7LzMK4qpD6fwm+6Cm+656PN1RcUuA
	hLAV/G1FXTc+csQuTNVAVPSZwvIkBekirSJWW5OkEg9LYfqL8fu38ApE+6xkLYubhCcb
	ih2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=sEELVfqzWb0TQCtZeJL8ETvdBeTp4af4qLpdwA4SsrM=;
	b=fGnTczoeKQeij+x/oltq6phHLLjy6uXAP2K4FIo2mprW1uXLTTOh/PCroCkWmBPjgW
	G2dcThctL98R01Sc+mDgLkEjW+/zKbrWQnVTYi2ZnM05Np4E+mrHqodaPp8byjAq0wzu
	G0NondCH6hhYscO4po42Ccaraa53nhH7nkZslhwqu+O7ZtfTnsRGWPp2/rvfyxbjHMXk
	CgDuCYSFElQ8TSuqzr115Z9YGaMPcs0IG/vmfjC3ZMAQJ8WngAhzzgQL2AmW85bw+R/e
	btTYaLcyupCkAUvP3XxqASSuUs3g3JPaNe+B7o7gU/eWINn6/eHWb5wPYUL3elRdVMNS
	gZmA==
X-Gm-Message-State: APjAAAV97Sry2/O7MsEgIGGYFLXWBsjdHnBeApObKrONIQALJ1oBlG96
	IUqG6WWrZUQBiIm6j8GPJaOtRwADdF1kKBtym6o=
X-Google-Smtp-Source: APXvYqyuVhgOkdFap95VGwZwOqE2cEpFV5+pbTCM3PBibEMA48Ji15RnVbHGRs1ETExm0n9d/Q63y6WNZ1evc2rJsrE=
X-Received: by 2002:a05:660c:2c5:: with SMTP id
	j5mr7850107itd.154.1556707865137; 
	Wed, 01 May 2019 03:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556186399.git.liezhi.yang@windriver.com>
	<d37712258af9b6fedb9e1586ace28908bec88391.1556186399.git.liezhi.yang@windriver.com>
	<9f8a038abf7b7eff75038ccef5f066bfd37e58f5.camel@linuxfoundation.org>
	<0c45f88f-6056-2fa6-1db1-f7ce413ba0f3@windriver.com>
In-Reply-To: <0c45f88f-6056-2fa6-1db1-f7ce413ba0f3@windriver.com>
From: Jacob Kroon <jacob.kroon@gmail.com>
Date: Wed, 1 May 2019 12:50:53 +0200
Message-ID: <CAPbeDCnOwvCVx-okYiXU0CXjWLxDGBX7xQc4ij+_iGgd2t-T-w@mail.gmail.com>
To: Robert Yang <liezhi.yang@windriver.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 2/2] bitbake: build.py: check dependendent task for addtask
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
X-List-Received-Date: Wed, 01 May 2019 10:51:04 -0000
Content-Type: text/plain; charset="UTF-8"

Hi,

On Fri, Apr 26, 2019 at 4:49 AM Robert Yang <liezhi.yang@windriver.com> wrote:
>
>
>
> On 4/25/19 6:50 PM, Richard Purdie wrote:
> > On Thu, 2019-04-25 at 18:01 +0800, Robert Yang wrote:
> >> The following command is incorrect, but was ignored silently, that may suprise
> >> users:
> >>
> >> addtask task after task_not_existed
> >>
> >> This patch can check and warn for it. It would be better to also check "before"
> >> tasks, but there is no easier way to do it.
> >>
> >> [YOCTO #13282]
> >>
> >> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> >> ---
> >>   bitbake/lib/bb/build.py | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
> >> index 7571421..861e9a9 100644
> >> --- a/bitbake/lib/bb/build.py
> >> +++ b/bitbake/lib/bb/build.py
> >> @@ -815,6 +815,9 @@ def add_tasks(tasklist, d):
> >>           task_deps['parents'][task] = []
> >>           if 'deps' in flags:
> >>               for dep in flags['deps']:
> >> +                # Check and warn for "addtask task after foo" while foo does not exist
> >> +                if not dep in tasklist:
> >> +                    bb.warn('%s: dependent task %s does not exist!' % (d.getVar('PN'), dep))
> >>                   dep = d.expand(dep)
> >>                   task_deps['parents'][task].append(dep)
> >
> > I can't help wonder if this change has races, depending on the order of
> > the addtask and deltask expressions. Do most layers parse cleanly with
> > this?
>
> The bb.build.add_tasks() is only called by ast.py's finalize(), I think that
> everything should be ready in finalize stage, and there should be no races.
> I tested this with meta-oe, python perl, selinux and others, didn't see
> any problems (unless I depended on an invalid task).
>
> >
> > At one point bitbake did support "floating" invalid tasks, I can't
> > remember if we changed that or not though.
>
> This warning is good for checking typos during development, I think that
> user can call "bb.build.addtask()" dynamically in a function to fix the warning
> for floating tasks?
>

I'm getting a lot of these warnings after removing tmp/ and rebuilding
my image from sstate cache.
FWIW I use rm_work.bbclass, and regularly use the
sstate-cache-management,sh script to prune old cache.

/Jacob

