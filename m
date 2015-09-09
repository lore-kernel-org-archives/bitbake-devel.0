Return-Path: <avery.brian@gmail.com>
Received: from mail-ig0-f174.google.com (mail-ig0-f174.google.com
	[209.85.213.174])
	by mail.openembedded.org (Postfix) with ESMTP id 07D6073D27
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Sep 2015 02:39:40 +0000 (UTC)
Received: by igcrk20 with SMTP id rk20so89878289igc.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 08 Sep 2015 19:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=guX6U9hOy4AXuwXzUmZrtsvIRN67CvY8OIDWpQvCcWs=;
	b=zpBoDyBcJuJZ3PvFbXKCKTo5gUmxU5rmtOPtJlCUvyWpIWpQt8NZhLgy5fRUGDcKDV
	IR5i40gb8f53gbOtCCLERT2z28f7yg/GWIBTg/ohz3N5pF6q1oUKWyH5KvNEVb4+4Y5z
	5b6kOMrdVB4Paw6ZQ48SycUnn21IfgoxhALbv/IG1YgGcVi2sGtGluqqcTFu5QgG8Brc
	xJLmUYPd+/O9GJRIC7n6+vyPB3JxmOeZr+OdUfZxRkYjKjfo55Nr5sOVWmD8ZKd2OSZU
	XP5Hd/YLmRLrOyr44PN/Ix7GjzFCaeKE5SCh2oN80GXBIqfUeXDlpUfdLmzKR+GTYF9s
	XATw==
MIME-Version: 1.0
X-Received: by 10.50.30.65 with SMTP id q1mr46548777igh.28.1441766380486; Tue,
	08 Sep 2015 19:39:40 -0700 (PDT)
Received: by 10.64.55.39 with HTTP; Tue, 8 Sep 2015 19:39:40 -0700 (PDT)
In-Reply-To: <ca14f0260d3fbf82b35c631d2e6da52fc62d3397.1441766166.git.avery.brian@gmail.com>
References: <cover.1441766166.git.avery.brian@gmail.com>
	<ca14f0260d3fbf82b35c631d2e6da52fc62d3397.1441766166.git.avery.brian@gmail.com>
Date: Tue, 8 Sep 2015 19:39:40 -0700
Message-ID: <CAKV_0ei7LpmKXxPm-aqLwfPWmY78HT1Y3myu4B_+bYZ6Z6VvCQ@mail.gmail.com>
From: Brian Avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] toaster: increase waiting time
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
X-List-Received-Date: Wed, 09 Sep 2015 02:39:41 -0000
Content-Type: text/plain; charset=UTF-8

submitted upstream.
-b

On Tue, Sep 8, 2015 at 7:39 PM, brian avery <avery.brian@gmail.com> wrote:
> From: Ed Bartosh <ed.bartosh@linux.intel.com>
>
> Increased waiting time for toasterUI from 10 to 25 seconds. Bitbake
> takes longer time to start, so toaster should wait longer.
>
> [YOCTO #8240]
>
> Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
> Signed-off-by: brian avery <avery.brian@gmail.com>
> ---
>  lib/toaster/bldcontrol/localhostbecontroller.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
> index 231a7d3..a9909b8 100644
> --- a/lib/toaster/bldcontrol/localhostbecontroller.py
> +++ b/lib/toaster/bldcontrol/localhostbecontroller.py
> @@ -140,7 +140,7 @@ class LocalhostBEController(BuildEnvironmentController):
>
>          retries = 0
>          started = False
> -        while not started and retries < 10:
> +        while not started and retries < 50:
>              started = _toaster_ui_started(toaster_ui_log_filepath, toaster_ui_log_filelength)
>              import time
>              logger.debug("localhostbecontroller: Waiting bitbake server to start")
> @@ -150,7 +150,7 @@ class LocalhostBEController(BuildEnvironmentController):
>          if not started:
>              toaster_ui_log = open(os.path.join(self.be.builddir, "toaster_ui.log"), "r").read()
>              toaster_server_log = open(os.path.join(self.be.builddir, "toaster_server.log"), "r").read()
> -            raise BuildSetupException("localhostbecontroller: Bitbake server did not start in 5 seconds, aborting (Error: '%s' '%s')" % (toaster_ui_log, toaster_server_log))
> +            raise BuildSetupException("localhostbecontroller: Bitbake server did not start in 25 seconds, aborting (Error: '%s' '%s')" % (toaster_ui_log, toaster_server_log))
>
>          logger.debug("localhostbecontroller: Started bitbake server")
>
> --
> 1.9.1
>

