Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9728110A3D8A
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 12:25:45 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.46950.1774527945013367863
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Mar 2026 05:25:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=P4D4xHCu;
 spf=pass (domain: gmail.com, ip: 209.85.219.49, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-899d6b7b073so11317476d6.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 26 Mar 2026 05:25:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774527944; cv=none;
        d=google.com; s=arc-20240605;
        b=KTbT2ZB19b4HW60DOC7NLukoAQ5QbGPW2U9hXixhP5L4vB8a42Z+XmDzTh/jE3O4fq
         bUd5XeTK4FdWfR9T3vS04A7aORTnvhv2vQ6Mav/9+XL0Y44sFNHJILhke88E9TFfermx
         kZGW4Ik9vRtV7zfqygRz5LzIdBS2VFcCbWE9a4u3imA5W+aT8Qyh+IUtYx6LuwQEhWqi
         +s8rtM+oKhRmevmMgbK2nvyBMrF6HYzKXmjqngFTKXq99MQybwZRVsUzdavdQDnAKgPj
         EHl/KlhrtW1hwm00KZZ3SttKKGCasP1eDCwJwdsAhjCRrUEUPtnqakIASmWRPynRx0Pd
         TnQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vvi6KZex1yeXQQ0EGZgXrZ4ZSM0hhDGfXW1n0MwVDxM=;
        fh=z79r7devTYIWKIIJnNEQrp8fu91t3iK8WPc0gYxDyHM=;
        b=Ggss39vy7K2iTHE2JdDsJ7xs/gzc8//pGS69UQT5HU4W6HF7kChyvSFEiv0i7QPY0u
         tQPceN9xXYKy7RUcsQj+v7+cu4a04dihClI3kHtyAJpmGhn+XG9CUsfo8w5t+LSOLc+1
         da3w2CTVJV+e3V2jM2l/bTUqYuNScbNMv2TPFLFyPpoHk6PoMRSiLnRkCvvt3u2fN4Lt
         Xe0DbgalX9p9nTRfLRFo5HWSxPIu8ms+KdP0zSpXBpJye8TGI1cgPwhAR/hS1Yu+DZhJ
         MXWmOWtPtZh6YsfTpq10ARBplGlR1r65fQ5IgjndK4W11ES8oRRuTfuJ/gKQgpw60zJQ
         Fn5w==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774527944; x=1775132744; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vvi6KZex1yeXQQ0EGZgXrZ4ZSM0hhDGfXW1n0MwVDxM=;
        b=P4D4xHCu6nwcbtBuT/NdlCj/8Jy0g1BC84WsP/nwfHHr6R4NgYiooq9FPUlgR/ykZr
         hR58K1i1LRXpCZugqhsKJ1fZ8c0HQKNs46p3Ldn3bmbTPLfCrV/Iao3ndkcHL0WWCIwF
         hK+o8s6FuXyVS6CTNMfdgZv9gDHtTgxwbjms8UXcSLIhGBwC5eR8oA61jpz70NtO7P38
         rj8eftIePJC1UZuDe6JNnuCKVpObvW1ehbaztnRzmr7WjkyTdJ4kbwPPaxNKRJo2/J4k
         1WP1DvU2Va/JOtuPVFKfM47WZn4M4G2gNCqbjRZTt8RGlBj5AnngNz7zlA7x6LqCJV1b
         L5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774527944; x=1775132744;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvi6KZex1yeXQQ0EGZgXrZ4ZSM0hhDGfXW1n0MwVDxM=;
        b=JgrNqKtix/BZ5ffRyWP9wI5f8u9IbQ19o080J+CnpytISVrCwDFMIRYfAGBXvxC3XG
         GbPnyJdU78yejpMPlObdZu/HdejTAO4xT0yvQLxii+1y99BFHuxrtXL3/cd5OZjqF0vz
         XUgru5HqHjdX46LYtsDOF5dca1fKviEkntfIDYx2N/J26VD3+1Cto6PNyCrgQxOzWFMe
         8XJKD+JK1AJ1yqfZ4o4Saqy/s9y2PmkK0bgV+piXnvsIEJXuah3+RmgEJopaY6imbWU6
         LB/IQ4tPbeZVu9LPJdb8ss+wx6pogIzd9LddemHw8xwOW8KNQF9HO/hbazxewB6CZNSw
         9GwQ==
X-Gm-Message-State: AOJu0YxlA5pjKgVsVwc9MXmFGRQ//IYx9Gu9ahz8eVmgt9Z7/KkffwdE
	eofMj/Wmyly2qEnAGJmdVDQzYpGMbPsVw81MLlIP+LdsH6GliSfEQeF37IUnbW8MVxiLZDGcX7c
	3dxO2U0GPK23mJVGOCGjyeWkosSag/K/rnlIP
X-Gm-Gg: ATEYQzzke9c41+gWjTJ1Q+LsSL3CpSbRCF9pfG30zMuOaODkM4uooxNOdHTPcthPqXl
	Rr2nl/V+0d0lr5/7SosK56mm6cOZpKMMlf7huFlxhVqgf4nkMyWg87FO/AjZiTW6LM/Cz8n0iFK
	jKp8FdszPUiWFXVCxf1rKVnb+dunCjg9F5KE73mcpIoN9b1aXgsfvhhrGNYdaZhpoReSxJOLTc0
	Kz+wqb8JLQFQrTP0lm2Oxs5sldIKS8OP73gN1TLgYycmdyFEbn58zwaRygQ0b/1wuSPMsxr/CYD
	0th1FZ4sIeUa5I4RCRz1L4/RP67PC86fcqPYedXZthjy+aC207T+
X-Received: by 2002:a05:6214:5684:b0:89c:47a0:390c with SMTP id
 6a1803df08f44-89cc4a94a06mr108168166d6.37.1774527943981; Thu, 26 Mar 2026
 05:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260325071342.47272-1-adrian.freihofer@siemens.com> <20260325071342.47272-10-adrian.freihofer@siemens.com>
In-Reply-To: <20260325071342.47272-10-adrian.freihofer@siemens.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 26 Mar 2026 13:25:33 +0100
X-Gm-Features: AQROBzCbxkWRbtCErjLQ66qN9Ut0yQh-rjLSZ20RrfDd4jRMqnE5cYLYf6bPxqM
Message-ID: <CANNYZj_+ssp4DQSchFm6smpo_fgv21hF=7xDZEjCsaJSJAC4XQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2 09/10] bitbake-setup: add
 --rebase-conflicts-strategy to the update command
To: adrian.freihofer@siemens.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Mar 2026 12:25:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19236

On Wed, 25 Mar 2026 at 08:14, Adrian Freihofer via
lists.openembedded.org
<adrian.freihofer=siemens.com@lists.openembedded.org> wrote:
> -            do_fetch(fetcher, layerdir)
> +            repodir_path = os.path.join(layerdir, repodir)
> +            try:
> +                do_fetch(fetcher, layerdir)
> +            except bb.fetch2.LocalModificationsError as e:
> +                if rebase_conflicts_strategy != 'backup':
> +                    e.msg += ("\nUse 'bitbake-setup update --rebase-conflicts-strategy=backup'"
> +                              " to automatically back up the directory and re-clone from upstream,"
> +                              " or use 'bitbake-setup init -L %s /path/to/local/checkout'"
> +                              " to work with a local checkout instead." % r_name)
> +                    raise
> +                backup_path = add_unique_timestamp_to_path(repodir_path + '-backup')
> +                logger.warning(
> +                    "Source '{}' at {} has local modifications that prevent an in-place update.\n"
> +                    "Renaming it to {} to preserve your work, then re-cloning from upstream."
> +                    .format(r_name, repodir_path, backup_path))
> +                os.rename(repodir_path, backup_path)
> +                fetcher.unpack(layerdir)
> +            except bb.fetch2.UnpackError as e:
> +                if rebase_conflicts_strategy != 'backup':
> +                    raise
> +                backup_path = add_unique_timestamp_to_path(repodir_path + '-backup')
> +                logger.warning(
> +                    "Source '{}' at {} could not be updated in place (rebase conflict).\n"
> +                    "Renaming it to {} to preserve your work, then re-cloning from upstream."
> +                    .format(r_name, repodir_path, backup_path))
> +                os.rename(repodir_path, backup_path)
> +                fetcher.unpack(layerdir)

This has a few issues:

- e.msg += "..." could be replaced with more pythonic e.add_note()

- a similar note could be added in the second block when update fails
due to rebase conflicts

- the code assumes bb.fetch2.UnpackError is a rebase conflict, which
may not always be true. This is addressed in my comment to 01/10 (add
RebaseError exception), and then that exception should be used here

- significant duplication of code between two except blocks. I'd say
they should be folded into one block:
    except bb.fetch2.LocalModificationsError, bb.fetch2.RebaseError as e:

and then needed differences (e.g. in message strings) can be done with
isinstance(e, ...) conditions.

The rest of the patchset lgtm!

Alex

