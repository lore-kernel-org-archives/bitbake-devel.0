Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0180ACE8D6B
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 11:52:53 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7480.1763380370924353128
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Nov 2025 03:52:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=U7tftK6e;
 spf=pass (domain: gmail.com, ip: 209.85.219.53, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-880439c5704so38062596d6.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 03:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763380370; x=1763985170; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0OKncnFIm3zgJ+IeY2cJjF9l0J+9dbsiQbuxG2esbdM=;
        b=U7tftK6egV0FsFkdBoexP9HUwVmg2qaC2b9SlFWY4BfoMXSkzT5T2/LxRhfzRFpdWw
         z9y/wJP6S9UCsdLUPzSiH16vM7ypD2XvwfeSc8+0ALsAGjln2ZS9Vxs5qqzxKgPjpP9C
         ssFFffcCAq2fwfxUrEI44YRUQlNXXz7mFJnnaTWI1ytXo3/qkFPGExtN42YjddTih5EV
         XP2yYDGaX569mk6m0caohmwQTGduVMe2D4Z9jKyuF891t5T2sM6mLQ+MhWdNtgCUPgZo
         am2Lx2lwf0eLR9UxOrMv0FwlUG5EFT75zKwcnHJlJO3bVHdTZ6d/c100tdQOxLktx3pr
         gKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763380370; x=1763985170;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OKncnFIm3zgJ+IeY2cJjF9l0J+9dbsiQbuxG2esbdM=;
        b=uMLKxyMvGwxvImt3T6BUkVMQrT3sPUt1STPKTGcmhzlSRk1eraqJijQJwV3Q3wZmSg
         f8AQsxKbGnlk8w4awwrYw06EK9p21c2HH+F9XN3IgSRzjNpkliTQkdrmVvu+602CEWzF
         5pzbp600dHWaOxnHXM+Nfc/d4wXVEwrDPKbdhEOwSP6dvbpglCK9XhSUSde9MHWkxoh5
         d01ZXVGwOKRk6NnhjF4vxeK580LKTOQYcfLD2vTb+CAl7AQkJpLiMDOim5AfuAsYWHtx
         8NdHerLNOtso3LwIAFAjhr9/rpRBfU2fmXv/ij63Ky8dattmwYR+I+HF/bW3Zi58zStf
         2IQw==
X-Gm-Message-State: AOJu0YzEAD1HiwB8fs4j7D1KE2Po08241YfmQ1RzFe+8VvEEk2KZrFHT
	T3brs3R8SzQfHlx6AtL85cezdRtvQMvlPfkMnUnyxXeCunzcJFybli0eeVMavLYNha9sJtKC38Z
	fKcLCXDaOmnxgcn83LcbALsLfBCnKHwI=
X-Gm-Gg: ASbGncsVyoLeW6elX8d2x3qaaruFqvBrV7aQ9YqVAer8GZhwoJhPa+YKmKEl/nY0XHP
	9uLXaEekzIj+pJwUXhUhwVUWYqvd0Vm7z1/GO47qwa3lA/mz/2sUFPR4UYwEHVns5JlJFuoxAum
	fCk0MWgnZVsT8KVFr7Oo0Vwy8LDxP+sJ6L6NnCzXmNXlCN4wd7imWtVwUNWaqh6omhIYyNpmPH2
	rlNfuBCkcwL1Wp9qkMLIzMVWRex+xwfYlx5+ofP5CGy0nraVFPiwClECV5t1SGB+dyqB7Bxot7G
	WP4Hd3LR0X0PJz3LGvgrq/u4TDOUYdLejZkELm3f
X-Google-Smtp-Source: AGHT+IHkCZrF7HZXdBmA8gLirEFzytKQ9zOAPtSYVWIJLB7hNUwyuEiDGjODqK8frZOrQM5vGb9asovWwy/eHYNpFtA=
X-Received: by 2002:a05:6214:410f:b0:87c:28cc:9e69 with SMTP id
 6a1803df08f44-882926af38dmr162119946d6.55.1763380369835; Mon, 17 Nov 2025
 03:52:49 -0800 (PST)
MIME-Version: 1.0
References: <20251117-bitbake-setup-conf-updates-v2-0-209637e01fbe@bootlin.com>
 <20251117-bitbake-setup-conf-updates-v2-1-209637e01fbe@bootlin.com>
In-Reply-To: <20251117-bitbake-setup-conf-updates-v2-1-209637e01fbe@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 17 Nov 2025 12:52:38 +0100
X-Gm-Features: AWmQ_bkAo5OszNiz7q_LSiw0MXSiIu1eHUXu53NzJBCJikbfi9EZda3qPl2BKpI
Message-ID: <CANNYZj9SDzt_LoR2fjENeYrmBUjjquQ=kQvoawp0HXLxkKRgwQ@mail.gmail.com>
Subject: Re: [docs] [PATCH v2 1/2] bitbake-setup: update: add a
 --update-bb-conf option
To: antonin.godard@bootlin.com
Cc: bitbake-devel@lists.openembedded.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, docs@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 11:52:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18423

On Mon, 17 Nov 2025 at 09:21, Antonin Godard via
lists.yoctoproject.org
<antonin.godard=bootlin.com@lists.yoctoproject.org> wrote:
> -        bitbake_config_diff = get_diff(backup_bitbake_confdir, bitbake_confdir)

... replaced by:

> +        try:
> +            conf_diff = bb.process.run(f'git diff --no-index "{backup_bitbake_confdir}" "{bitbake_confdir}"')[0]
> +        except bb.process.ExecutionError as e:
> +            if e.exitcode == 1:
> +                conf_diff = e.stdout
> +            else:
> +                raise e

Why? I think the function helper should be reused to keep the main
code more succinct.

> +    _extra_msg_info = " (--update-bb-conf=yes)"

I'd say it's better to print appropriate messages directly in the
logic branches (even if they differ only slightly), rather than set
and tweak a variable.

> +    if update_bb_conf == "no":
> +        print('Ignoring upstream bitbake configuration changes (--update-bb-conf=no)')
> +        print(f'Leaving the upstream configuration in {upstream_bitbake_confdir}')
> +        os.rename(bitbake_confdir, upstream_bitbake_confdir)
> +        os.rename(backup_bitbake_confdir, bitbake_confdir)
> +    elif conf_diff:

The first check should be if bitbake configuration has changed at all,
and the new config should be removed if so.

See the proposal here:
https://lists.yoctoproject.org/g/docs/message/8056

So the overall logic should be:

if os.path.exists(backup_bitbake_confdir):
    ... (obtain the diff)
    if not conf_diff:
        print("New bitbake configuration from upstream is the same as
the old one, no need to update it.")
        os.rmtree(new)
        os.rename(backup, main)
        return
    else:
       print('Upstream bitbake configuration changes were found:')
       print(conf_diff)
       if update_bb_conf == 'prompt':
          ... ask for yes or no

    if update_bb_conf == 'no':
       ... (the block quoted above)
       return

... (write readme and print instructions and notice where the old config is)


>  def build_update(top_dir, settings, args, d):
> -    build_status(top_dir, settings, args, d, update=True)
> +    build_status(top_dir, settings, args, d, update=True, update_bb_conf=args.update_bb_conf)

args are already passed in, so no need to pass args.update_bb_conf as
a separate argument. build_status() can just obtain it from args.

Alex

