Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7951C3271E
	for <webhook@archiver.kernel.org>; Mon,  8 Jul 2024 08:36:36 +0000 (UTC)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
 by mx.groups.io with SMTP id smtpd.web11.75227.1720427790215260621
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Jul 2024 01:36:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=m5/C/CD3;
 spf=pass (domain: gmail.com, ip: 209.85.167.50, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52e9f788e7bso3834754e87.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 08 Jul 2024 01:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720427788; x=1721032588; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hGQAScslfTkVJXKLKc3v4diRRKplonwa3YxN3d87mrs=;
        b=m5/C/CD3vJa98a5PeSIz2ZULVr9v4x4viWk5GyQI7xbSpaf+pVJSZj9uLEIfnVzAAA
         o9qnb9HkH4TCZP8aR5VH2SM7Mb4ANIcbbt+62PK3GFkE5lq2P95mo0zh6lsVR4BWnVNt
         1qBnsXXn6wvaCfnAvCooSTfu1qoikM8jBx5lctd8Jhace1Cuv/8QIHJo2+ca1PWGsCmk
         WmuGdbjGWnK8OqQ9uzBcG33yhBlo+lCGKLB/wftc6GRxXXTix7D2qxTTXUPz/G1G0Sx4
         SAq94OHKalH8qJzNeFvURZzAfw97VQ2QQbkV4BB901bA9YB+9NJcUq+L0I2IVSTQanWL
         uRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720427788; x=1721032588;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hGQAScslfTkVJXKLKc3v4diRRKplonwa3YxN3d87mrs=;
        b=HR9upWx9J2wLq8YPUEqkToWXFkfyLLiEOXc5cMkKzect0orj03DclpXtWTxMFwfSp8
         yWh5SMOYX/WJvo6f+1jZHN9I2PAvwndCXBPq71RFeyx0Q+REuJ55EwiWwDa3wYwu0O5y
         BC0EdwKPFyIFD+mDr7KeFq80tCOfCw1rzlV+keQmYfclSDqAzLPaS1TixNzydL5RdgqL
         ZIAd92aTa0FiFZ6tWCKv09wHzadjt1JgVKb5s2m995GRcT2tnKTAlwzrqzhc0MVWDUSL
         GVkwXxWR2TpuxjDRbONQ1dsB7z3jzXfclekjFeAUjvAgVYSfwNmo965WkJ2rExyTqmct
         oXHg==
X-Gm-Message-State: AOJu0Yw4AzS+BWX42xacaKhsq3mC4blw1z5SKbkzDFw55PxjsTF5NRhm
	mSukeGU4BCKE5W26OBjTayYs1QAlE4tfiMyKaNV3NN3QQOfg54X/roSIqZkNUyl5daOWazlU3yP
	qdWGyVavnXNf7nsYFHCKian3tcNwoNw==
X-Google-Smtp-Source: AGHT+IFRDEP7iVDLk/09iHBdl3rL16Sqo2ANMiWxbn4dGuW01tMuS729cPQ9g8Wtdv2GCvZk8D/CKUZTGkYQQJFHLPI=
X-Received: by 2002:ac2:5f5c:0:b0:52e:9a4f:204c with SMTP id
 2adb3069b0e04-52ea0613335mr7630746e87.10.1720427788080; Mon, 08 Jul 2024
 01:36:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240708081034.1474312-1-changqing.li@windriver.com>
In-Reply-To: <20240708081034.1474312-1-changqing.li@windriver.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 8 Jul 2024 10:36:16 +0200
Message-ID: <CANNYZj9+c=BQ_zH5vXM35s2Sw=KTRiieprn4TNcWvOXY4xXV4Q@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-worker: skipping disable network
 when unprivileged userns is restricted
To: changqing.li@windriver.com
Cc: bitbake-devel@lists.openembedded.org, qi.chen@windriver.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Jul 2024 08:36:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16398

Should we rather direct users to disable the apparmor restriction? I
don't think an important QA constraint in the bitbake build process
should be automatically disabled this way.

Wasn't there also an upstream discussion/ticket with ubuntu? I'd
rather have this resolved upstream. Disabling the network check
instead isn't going to help that.

Alex

On Mon, 8 Jul 2024 at 10:10, Changqing Li via lists.openembedded.org
<changqing.li=windriver.com@lists.openembedded.org> wrote:
>
> From: Chen Qi <Qi.Chen@windriver.com>
>
> From ubuntu24.04, apparmor is enabled by default, and unprivileged
> userns is restricted, which causes following error when bitbake-worker
> try to disable network:
> Traceback (most recent call last):
>   File "/poky/bitbake/bin/bitbake-worker", line 278, in child
>     bb.utils.disable_network(uid, gid)
>   File "/poky/bitbake/lib/bb/utils.py", line 1696, in disable_network
>     with open("/proc/self/uid_map", "w") as f:
> PermissionError: [Errno 1] Operation not permitted
>
> Like what we have done for non local uid, skip disable network in above
> condition to avoid have to disable profile unprivileged_userns for the
> host or have to config a profile per project
>
> [1] https://lists.yoctoproject.org/g/yocto/topic/workaround_for_uid_map_error/106192359
>
> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> Signed-off-by: Changqing Li <changqing.li@windriver.com>
> ---
>  bitbake/bin/bitbake-worker | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
> index e8073f2ac3..0a042fdc7c 100755
> --- a/bitbake/bin/bitbake-worker
> +++ b/bitbake/bin/bitbake-worker
> @@ -272,12 +272,21 @@ def fork_off_task(cfg, data, databuilder, workerdata, extraconfigdata, runtask):
>
>                  bb.utils.set_process_name("%s:%s" % (the_data.getVar("PN"), taskname.replace("do_", "")))
>
> +                def skip_disable_network(taskname, uid):
> +                    if not bb.utils.is_local_uid(uid):
> +                        logger.debug("Skipping disable network for %s since %s is not a local uid." % (taskname, uid))
> +                        return True
> +                    if os.path.exists("/proc/sys/kernel/apparmor_restrict_unprivileged_userns"):
> +                        with open("/proc/sys/kernel/apparmor_restrict_unprivileged_userns") as f:
> +                            if f.readline().strip() == "1":
> +                                logger.debug("Skipping disable network since sys.kernel.apparmor_restrict_unprivileged_userns is 1")
> +                                return True
> +                    return False
> +
>                  if not bb.utils.to_boolean(the_data.getVarFlag(taskname, 'network')):
> -                    if bb.utils.is_local_uid(uid):
> +                    if not skip_disable_network(taskname, uid):
>                          logger.debug("Attempting to disable network for %s" % taskname)
>                          bb.utils.disable_network(uid, gid)
> -                    else:
> -                        logger.debug("Skipping disable network for %s since %s is not a local uid." % (taskname, uid))
>
>                  # exported_vars() returns a generator which *cannot* be passed to os.environ.update()
>                  # successfully. We also need to unset anything from the environment which shouldn't be there
> --
> 2.25.1
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16397): https://lists.openembedded.org/g/bitbake-devel/message/16397
> Mute This Topic: https://lists.openembedded.org/mt/107099079/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

