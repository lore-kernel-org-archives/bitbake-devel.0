Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23862CEBF61
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 12:25:53 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8184.1763382349292459861
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Nov 2025 04:25:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=NjGuKRN4;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 7DF744E4173B
	for <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 12:25:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4F9C8606B9;
	Mon, 17 Nov 2025 12:25:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AC0DB10371CE6;
	Mon, 17 Nov 2025 13:25:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763382346; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4VV0Wgh4Wjcb5zRrZWeBYIGhxseibtY3YKR+oloj8Eo=;
	b=NjGuKRN4dD+/fIyakfz+vbNxne7390s6fWQ6gubcIYiNB+s8PSq23dINYLSv8WJND2HVkE
	j25lKohlyHUyKuDFKwQznV+fp42XtaT/02sDLcbIQ6oPguUnnb70mPpXtXx1L080ePmqb/
	ct9dB4vKCfwkOv0/cLAAusGtNaJufZQToqfSiVBfxrN9/B7BoY10Ta2UwPgdztkKntVoda
	vKUyQTyl2l7NZrptJTP1riAEopdxctoYFRTHOTo+rUXoDpdGl0J/sD1DmoSjjodqC63uIS
	QrWwFINFqtEXEJl0lI99/Ist+l7JK+Dnx4sEXDsPg+0WfN4pvP6IIV+4nJYNKg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Nov 2025 13:25:45 +0100
Message-Id: <DEAYVE048P4S.9ABRW8U92DFF@bootlin.com>
Cc: <bitbake-devel@lists.openembedded.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <docs@lists.yoctoproject.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Alexander Kanavin" <alex.kanavin@gmail.com>
Subject: Re: [docs] [PATCH v2 1/2] bitbake-setup: update: add a
 --update-bb-conf option
References: <20251117-bitbake-setup-conf-updates-v2-0-209637e01fbe@bootlin.com> <20251117-bitbake-setup-conf-updates-v2-1-209637e01fbe@bootlin.com> <CANNYZj9SDzt_LoR2fjENeYrmBUjjquQ=kQvoawp0HXLxkKRgwQ@mail.gmail.com>
In-Reply-To: <CANNYZj9SDzt_LoR2fjENeYrmBUjjquQ=kQvoawp0HXLxkKRgwQ@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 12:25:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18426

Hi,

On Mon Nov 17, 2025 at 12:52 PM CET, Alexander Kanavin wrote:
> On Mon, 17 Nov 2025 at 09:21, Antonin Godard via
> lists.yoctoproject.org
> <antonin.godard=3Dbootlin.com@lists.yoctoproject.org> wrote:
>> -        bitbake_config_diff =3D get_diff(backup_bitbake_confdir, bitbak=
e_confdir)
>
> ... replaced by:
>
>> +        try:
>> +            conf_diff =3D bb.process.run(f'git diff --no-index "{backup=
_bitbake_confdir}" "{bitbake_confdir}"')[0]
>> +        except bb.process.ExecutionError as e:
>> +            if e.exitcode =3D=3D 1:
>> +                conf_diff =3D e.stdout
>> +            else:
>> +                raise e
>
> Why? I think the function helper should be reused to keep the main
> code more succinct.

Correct, while writing this I removed the previous statement, then did not
realize get_diff() could be used on two directories - will revert.

>> +    _extra_msg_info =3D " (--update-bb-conf=3Dyes)"
>
> I'd say it's better to print appropriate messages directly in the
> logic branches (even if they differ only slightly), rather than set
> and tweak a variable.
>
>> +    if update_bb_conf =3D=3D "no":
>> +        print('Ignoring upstream bitbake configuration changes (--updat=
e-bb-conf=3Dno)')
>> +        print(f'Leaving the upstream configuration in {upstream_bitbake=
_confdir}')
>> +        os.rename(bitbake_confdir, upstream_bitbake_confdir)
>> +        os.rename(backup_bitbake_confdir, bitbake_confdir)
>> +    elif conf_diff:
>
> The first check should be if bitbake configuration has changed at all,
> and the new config should be removed if so.
>
> See the proposal here:
> https://lists.yoctoproject.org/g/docs/message/8056
>
> So the overall logic should be:
>
> if os.path.exists(backup_bitbake_confdir):
>     ... (obtain the diff)
>     if not conf_diff:
>         print("New bitbake configuration from upstream is the same as the=
 old one, no need to update it.")
>         os.rmtree(new)
>         os.rename(backup, main)
>         return
>     else:
>        print('Upstream bitbake configuration changes were found:')
>        print(conf_diff)
>        if update_bb_conf =3D=3D 'prompt':
>           ... ask for yes or no
>
>     if update_bb_conf =3D=3D 'no':
>        ... (the block quoted above)
>        return
>
> ... (write readme and print instructions and notice where the old config =
is)

Much simpler indeed :)

>
>>  def build_update(top_dir, settings, args, d):
>> -    build_status(top_dir, settings, args, d, update=3DTrue)
>> +    build_status(top_dir, settings, args, d, update=3DTrue, update_bb_c=
onf=3Dargs.update_bb_conf)
>
> args are already passed in, so no need to pass args.update_bb_conf as
> a separate argument. build_status() can just obtain it from args.

Agreed, although the status command does not have the --update-bb-conf, but=
 I'll
catch that case.

Thanks!
Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


