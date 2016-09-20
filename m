Return-Path: <ulfalizer@gmail.com>
Received: from mail-vk0-f41.google.com (mail-vk0-f41.google.com
	[209.85.213.41])
	by mail.openembedded.org (Postfix) with ESMTP id 8047A60770
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 20 Sep 2016 16:20:05 +0000 (UTC)
Received: by mail-vk0-f41.google.com with SMTP id u196so34046086vkd.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 20 Sep 2016 09:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=vSED/oI6/svIR0o/+NOgVI92qRxdcbW8P2xuTRAAZOw=;
	b=VqDUTIVbckRBGr2dnqS4D+/J3n/xatDKmAlK0Mcf1xjikKAIvYmyIuEzHolIiscAf7
	Rlo9v2D9G4h+/vQVIPAIQ+DfZieAJLup6fk03XfuWJkTiu3s2y16VIiJ9FW2Y/uxXMzc
	aTfxzFj8Pkv3jQwsT2xRKtmfDZmMArvRSKWMxFatqKxbLb+m9EuYnusJhqEG8LfDvGcV
	2WUQaYf/YUYA0S2kYExf7j7hIP5TxQL8UZOdTsMeIZvnvuVDkpWqachkcT/v9pQScmR8
	fMJKjZwjgpjhgh0DWUeIfBQxZ3/vVM81+tKL5kkvlCsjlqu2mgmG2MD8rKglYjOhG0Q/
	a5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=vSED/oI6/svIR0o/+NOgVI92qRxdcbW8P2xuTRAAZOw=;
	b=FtuMSCBreCj2u8C10smIhHtyR/FBgcbcuVksx0xkG6I6nxvHgPRsdCCAdYQic22uBI
	FH5umTmnxSJNOdtSVXxLPAlijBU1MRZr7r8TdggdO+jgubGWQFLI10/3POPQPR+QD+HD
	eb+s7IaY3L6VWi/AZ+bm752i0mkK6jvnMTjqru/0xZ60lmCNBA0ed2KLAKpBRDjBS1uL
	ku28S3CZ2PaDDCFg3Kn/cIMeoMyYRsrcZMKrO2M9F36uBYZyy1BBKqgYgXN0hBm3s/pF
	w5WFuR1/HNhyva59K0GbyGF4C7OzrANU32ITCaK2kHRSsGFa/hxfF06hBQrv6TlVTX+J
	5RGA==
X-Gm-Message-State: AE9vXwPos5IDmdMi192trghdHJhYDQZkqt2VlBKqlvlt+M/0PLo16jZ+Sa/N+tamHU2GxL1TKhgoGJHM7oNF7w==
X-Received: by 10.31.200.70 with SMTP id y67mr4019327vkf.58.1474388399111;
	Tue, 20 Sep 2016 09:19:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.140.8 with HTTP; Tue, 20 Sep 2016 09:19:58 -0700 (PDT)
In-Reply-To: <1474358441-1948-1-git-send-email-ross.burton@intel.com>
References: <1474358441-1948-1-git-send-email-ross.burton@intel.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Tue, 20 Sep 2016 18:19:58 +0200
Message-ID: <CAFkk2KSR9SBtmPV-hOJETERC=gifVYVGKkyiFk4t-Ep5YyQGVg@mail.gmail.com>
To: Ross Burton <ross.burton@intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] uihelper: use elif instead of repeated if
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
X-List-Received-Date: Tue, 20 Sep 2016 16:20:08 -0000
Content-Type: text/plain; charset=UTF-8

On Tue, Sep 20, 2016 at 10:00 AM, Ross Burton <ross.burton@intel.com> wrote:
> Signed-off-by: Ross Burton <ross.burton@intel.com>
> ---
>  bitbake/lib/bb/ui/uihelper.py | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/bitbake/lib/bb/ui/uihelper.py b/bitbake/lib/bb/ui/uihelper.py
> index f64fa18..fda7cc2 100644
> --- a/bitbake/lib/bb/ui/uihelper.py
> +++ b/bitbake/lib/bb/ui/uihelper.py
> @@ -35,25 +35,25 @@ class BBUIHelper:
>              self.running_tasks[event.pid] = { 'title' : "%s %s" % (event._package, event._task), 'starttime' : time.time() }
>              self.running_pids.append(event.pid)
>              self.needUpdate = True
> -        if isinstance(event, bb.build.TaskSucceeded):
> +        elif isinstance(event, bb.build.TaskSucceeded):
>              del self.running_tasks[event.pid]
>              self.running_pids.remove(event.pid)
>              self.needUpdate = True
> -        if isinstance(event, bb.build.TaskFailedSilent):
> +        elif isinstance(event, bb.build.TaskFailedSilent):
>              del self.running_tasks[event.pid]
>              self.running_pids.remove(event.pid)
>              # Don't add to the failed tasks list since this is e.g. a setscene task failure
>              self.needUpdate = True
> -        if isinstance(event, bb.build.TaskFailed):
> +        elif isinstance(event, bb.build.TaskFailed):
>              del self.running_tasks[event.pid]
>              self.running_pids.remove(event.pid)
>              self.failed_tasks.append( { 'title' : "%s %s" % (event._package, event._task)})
>              self.needUpdate = True
> -        if isinstance(event, bb.runqueue.runQueueTaskStarted) or isinstance(event, bb.runqueue.sceneQueueTaskStarted):
> +        elif isinstance(event, bb.runqueue.runQueueTaskStarted) or isinstance(event, bb.runqueue.sceneQueueTaskStarted):

An obscure feature of isinstance() is that it can test multiple types
in a single call. This could be simplified to the following:

  elif isinstance(event, (bb.runqueue.runQueueTaskStarted,
bb.runqueue.sceneQueueTaskStarted)):

Cheers,
Ulf

>              self.tasknumber_current = event.stats.completed + event.stats.active + event.stats.failed + 1
>              self.tasknumber_total = event.stats.total
>              self.needUpdate = True
> -        if isinstance(event, bb.build.TaskProgress):
> +        elif isinstance(event, bb.build.TaskProgress):
>              if event.pid > 0:
>                  self.running_tasks[event.pid]['progress'] = event.progress
>                  self.running_tasks[event.pid]['rate'] = event.rate
> @@ -62,4 +62,3 @@ class BBUIHelper:
>      def getTasks(self):
>          self.needUpdate = False
>          return (self.running_tasks, self.failed_tasks)
> -
> --
> 2.8.1
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

