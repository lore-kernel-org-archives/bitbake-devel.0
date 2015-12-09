Return-Path: <avery.brian@gmail.com>
Received: from mail-ig0-f175.google.com (mail-ig0-f175.google.com
	[209.85.213.175])
	by mail.openembedded.org (Postfix) with ESMTP id EE03A60116
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Dec 2015 05:40:53 +0000 (UTC)
Received: by igcmv3 with SMTP id mv3so116998558igc.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 08 Dec 2015 21:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=4v/VuxS3T5RcbSm85UcE0mcjfS5ka+/ndr1EQnwM7iA=;
	b=wBxnMxjAd7t9QZ1AOfNv1RZsJ92W+vwg1cDVqdq3Ayr3RiEa++C3QhWqI9CrvwK687
	bOFYyBFq0FMk0Wreuv455fJxuyUHBPjpFLSkBgOmdRWiWAlk+wqV5dRo6Ol/rGg44Twl
	FZd1it9r0qBr0z4uG1WpuaRZUMWOJQqPNXVx7RaS1jAr5ODk8MXB/EXZMqUDLeekV9xI
	/97aDAd2Ql0XBrUkQL6KiyzBcWZdB5tiedJJp3TDcu8PjL6yFshJep10TSHaat4L3H42
	IqsBSD8WngTyneQ7mvB8DxteINsHgOTpZEMy15gSzLh6kNgVU+ePqEplxGwBrbSmqXwt
	NSkQ==
MIME-Version: 1.0
X-Received: by 10.50.73.9 with SMTP id h9mr7167616igv.41.1449639654130; Tue,
	08 Dec 2015 21:40:54 -0800 (PST)
Received: by 10.64.221.75 with HTTP; Tue, 8 Dec 2015 21:40:54 -0800 (PST)
In-Reply-To: <1447778876-12207-1-git-send-email-elliot.smith@intel.com>
References: <1447778876-12207-1-git-send-email-elliot.smith@intel.com>
Date: Tue, 8 Dec 2015 21:40:54 -0800
Message-ID: <CAKV_0ehpaqTs96_a9NkqzDjN9VycFRytF1m7aHqO0QWpTbuyzw@mail.gmail.com>
From: Brian Avery <avery.brian@gmail.com>
To: Elliot Smith <elliot.smith@intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] toaster: toasterui Add ParseStarted/ParseProgress events to mask
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
X-List-Received-Date: Wed, 09 Dec 2015 05:40:54 -0000
Content-Type: text/plain; charset=UTF-8

bump.
-b

On Tue, Nov 17, 2015 at 8:47 AM, Elliot Smith <elliot.smith@intel.com> wrote:
> From: brian avery <avery.brian@gmail.com>
>
> Toaster is not able to see ParseStarted and ParseProgress events
> for command-line builds. This means it's not possible for Toaster
> to detect failed builds, if the failure occurs at a point before
> the BuildStarted event, as the build won't show up at all.
>
> Add these events to the event mask, so that Toaster's toasterui
> can detect and respond to them.
>
> Signed-off-by: brian avery <avery.brian@gmail.com>
> Signed-off-by: Elliot Smith <elliot.smith@intel.com>
> ---
>  bitbake/lib/bb/ui/toasterui.py | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/bitbake/lib/bb/ui/toasterui.py b/bitbake/lib/bb/ui/toasterui.py
> index 3d26150..cdfe7ae 100644
> --- a/bitbake/lib/bb/ui/toasterui.py
> +++ b/bitbake/lib/bb/ui/toasterui.py
> @@ -92,6 +92,15 @@ def _close_build_log(build_log):
>          build_log.close()
>          logger.removeHandler(build_log)
>
> +_evt_list = [ "bb.runqueue.runQueueExitWait", "bb.event.LogExecTTY", "logging.LogRecord",
> +              "bb.build.TaskFailed", "bb.build.TaskBase", "bb.event.ParseStarted",
> +              "bb.event.ParseProgress", "bb.event.ParseCompleted", "bb.event.CacheLoadStarted",
> +              "bb.event.CacheLoadProgress", "bb.event.CacheLoadCompleted", "bb.command.CommandFailed",
> +              "bb.command.CommandExit", "bb.command.CommandCompleted",  "bb.cooker.CookerExit",
> +              "bb.event.MultipleProviders", "bb.event.NoProvider", "bb.runqueue.sceneQueueTaskStarted",
> +              "bb.runqueue.runQueueTaskStarted", "bb.runqueue.runQueueTaskFailed", "bb.runqueue.sceneQueueTaskFailed",
> +              "bb.event.BuildBase", "bb.build.TaskStarted", "bb.build.TaskSucceeded", "bb.build.TaskFailedSilent"]
> +
>  def main(server, eventHandler, params):
>      # set to a logging.FileHandler instance when a build starts;
>      # see _open_build_log()
> @@ -115,6 +124,9 @@ def main(server, eventHandler, params):
>      console.setFormatter(formatter)
>      logger.addHandler(console)
>      logger.setLevel(logging.INFO)
> +    llevel, debug_domains = bb.msg.constructLogOptions()
> +    server.runCommand(["setEventMask", server.getEventHandle(), llevel, debug_domains, _evt_list])
> +
>
>      # verify and warn
>      build_history_enabled = True
> @@ -182,8 +194,6 @@ def main(server, eventHandler, params):
>                  continue
>
>              if isinstance(event, bb.event.BuildStarted):
> -                # command-line builds don't fire a ParseStarted event,
> -                # so we have to start the log file for those on BuildStarted instead
>                  if not (build_log and build_log_file_path):
>                      build_log, build_log_file_path = _open_build_log(log_dir)
>
> --
> 1.9.3
>
> ---------------------------------------------------------------------
> Intel Corporation (UK) Limited
> Registered No. 1134945 (England)
> Registered Office: Pipers Way, Swindon SN3 1RJ
> VAT No: 860 2173 47
>
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
>

