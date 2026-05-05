Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89129CD3439
	for <webhook@archiver.kernel.org>; Tue,  5 May 2026 18:42:46 +0000 (UTC)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.954.1778006563460533223
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 May 2026 11:42:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=CGoDkV1O;
 spf=pass (domain: gmail.com, ip: 209.85.160.180, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50d6ab4476eso56006341cf.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 05 May 2026 11:42:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778006562; cv=none;
        d=google.com; s=arc-20240605;
        b=A9GCt/qNX97s1XBbwtH+zVGN/cMkuan8FFgYaVa00n3Y3U373k9NCgCmnUV372yWo7
         7ewjnxAWFH/ZiiIchqi4JYa6ihXRIvozedzetU756EzcmicyjwO0Ebpqs/Yq7JrNOOTY
         dre16eaf5Qa9V4F4sQnnJiXessAcjf8pgzEz6+OpmcTKef5Qxg7ZIPBt/FKCXY51nIjt
         jDqy9OQLx8LICPquB5RhMMug/LyluQUKwLxl3s3EuCG7A2gdMyGuwzhsZEk7lK4TAt26
         vjSxxKx/fsglNsVch+etAaE9HrCRIHN58AoLPw0R0jN9VggADPfhevqqvnAVRLV94ElJ
         Ldsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3rq3u6OmiejPmPOcR1S7QtfFh+XkfWCIhJO7bp+sQZY=;
        fh=6Y7Fblq6GiUwnun5lf2EZMV7UnFHSvG6NLim31xDnM0=;
        b=Vp3ZnYmfjh4pMaJxM8hDwTRcUaB1EO7l5ZpzK4NV3y/i2Zi+YPOcM+jyax7yQqK69I
         qAfD3XT5/oCBAnKEvq33QZHg1rCTUDW/VcNzrZJjzF4a6LD2MkzC9SJ1oWlTJjGOJlrX
         6UR6sOlxc/WtEP/JsOoeKVmImJpYi6qdWAKIopPGqOsMNEhD6+605sa7y0B0SosUwa9/
         0BHuMGwd/UQgUkvJ9rUr/xV/2LTB74Ubntj+z/NqynsOpuTJfNdrPQN0J47KHz32qX6H
         Rf7XZBso5PI2EnF1y0t9PHP4ajm+RgeCtACE55ydcXLFObW2J+680dx9xTGgb+9nySVJ
         cugw==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778006562; x=1778611362; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3rq3u6OmiejPmPOcR1S7QtfFh+XkfWCIhJO7bp+sQZY=;
        b=CGoDkV1OSwjqSZ8YNAtLC1k4rEacze66YXUxLyZ8lrnutT56vzGA+iDIMc79gPLPlo
         HT3rKwXetXl3/ZCUFcgpqfeA5VHmwtptW0Ufrvst0BaEKM2pWBdSEDuZ31Q0HfoRlnbd
         getVSMuY2NL48ZESHNUkxpIGC0+02I61+PMyuQq7/+fp8B8IyQU4o7FxAHRS0lvLh4iy
         2AyPyc1JOr41xuCG3Wvf43M6299Sx8c51WZaWAuV3UPEIMWgY81PIq+RfmCs8PMGWTfP
         urj+eBOcSpVShTQy2AIfQ0b5Pdi0y6xTI8xfCrxe1Gvl6nVDDhaVpy7jPJELmKqwyOoU
         otOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778006562; x=1778611362;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rq3u6OmiejPmPOcR1S7QtfFh+XkfWCIhJO7bp+sQZY=;
        b=rvjpGCH9CwZ9DMs+ATl5zwncnTvsw64eYH4R8WQtpvEyXffZY55hsHC67M0GpilCeo
         yXQ2i0i9EUs/aaHVqtxdSh7rPysJZ6aZyZfVUk3LsDbMPZwABcihNW58pzT6vBjYqH+I
         tVjC4ti9uT3D6YOeCAN/cNLqTClpfSv1sF51gQ/1rKlM7CMJawPHMVAuH8Ju/kJwmsRD
         RezNaH8IV+tVEnCjTU66msK3wYVp8IEBgjAmYsJWwxqNFi39lxKCQL1oYe1sGJ2jzswR
         K/vjlTnIL3nfbHFmnNQgmJahFGOIhJ/XuXEcaw8ZFGZvFE+z688HOF0J4FAO/WvzSVON
         rd2A==
X-Forwarded-Encrypted: i=1; AFNElJ/B9qS9ugjaKd/j9zViEv1St69YGpkP9xgD1HUBmTlqG981BviKTaDNgTYnc0DcST65J4mA5cw3snejVp3U@lists.openembedded.org
X-Gm-Message-State: AOJu0YyMNsZQ1UBDFChos+C6Zc7KjZqZTWp8eYoz7kU0Qnfa4S4nVlKV
	zaRaJFkypKuCCo0TG0g6g0xF9mCbFLYHui+joydNiPrcyjDhr1Vx27Nq7A2GisNxeBL24FLoH68
	k2qLqDmgFEmUBz1rMxq9R5SMG7hgWCMIx0fhc
X-Gm-Gg: AeBDiesQT5j9ybkt+Liq3F9VBfGD7/zMlT/YHJOSkX81rBTRrx2L/ifEGZvz6KD3c1f
	jTd5hHPnk70/kcJ2bSPo9LUhd5G/GvG5pwbfXJbJZgYv2d2mJU5t5czS3+XNDsW1+6sok/2Ttgg
	VYrMss7QUgwD7xZEWreHHVnIfEN4VZXEHiLUBnMJNxeN+XVM2htOrkauP2x51QPSfUtfZkPijwp
	P+0FNcYNVEUm+i3KQjp/a2D2q9e2s8rzdSlD7CnU8OFUnJYGhGDqc9XTk5/HNDAQBT3XMDm/hZQ
	Z8JeIIg9YODGJoYLcImOvH/zmDtjQFUk1kTZh6VCD4PYFF/uOqk6
X-Received: by 2002:a05:622a:6111:b0:50f:be8b:f803 with SMTP id
 d75a77b69052e-51461f73c89mr3589521cf.29.1778006562270; Tue, 05 May 2026
 11:42:42 -0700 (PDT)
MIME-Version: 1.0
References: <CANNYZj-hrSdEoX5XRmM1MYhXMVkqpa0CBHHbMqVhjM034bKTDg@mail.gmail.com>
 <66b3dbc7-e6f0-4013-8d2e-d646f0fd8c9b@baylibre.com>
In-Reply-To: <66b3dbc7-e6f0-4013-8d2e-d646f0fd8c9b@baylibre.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 5 May 2026 20:42:30 +0200
X-Gm-Features: AVHnY4JWu_pyaNEg1IPxR6nVaP2hNAMV3z9AiuvkxIjHp_m9FWQSxowWV8EchZQ
Message-ID: <CANNYZj9dsi3XDGVBtEM4Hp8eqZfLtf9Jwa-0m8T5J9rt7V7skw@mail.gmail.com>
Subject: Re: [Openembedded-architecture] proposal: build pipelines in bitbake-setup
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: openembedded-architecture <openembedded-architecture@lists.openembedded.org>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	Yocto-mailing-list <yocto@lists.yoctoproject.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 05 May 2026 18:42:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19439

On Tue, 5 May 2026 at 18:17, Trevor Gamblin <tgamblin@baylibre.com> wrote:
> > 2. Nomenclature:
> >
> > - "step" is a single command that is also given a short name and a
> > longer description. Steps are building blocks for pipelines and can't
> > be individually executed.
> Why not? Why not have the ability to run something like 'bitbake-setup
> run-step <step_name'? That would actually be an advantage this feature
> could provide over many other CI systems, as it's usually difficult or
> impossible to rerun individual steps (you have to re-run a whole job or
> pipeline). I can see this being very useful for example when you need to
> run 'bitbake -c testimage' in a loop many times to try and catch
> intermittent failures.

The reason I suggested that steps can't be run individually is that I
wanted to keep the UI simple, and couldn't think of use cases for
individual steps. One has to start somewhere, my starting point is
baffled yocto newcomers, and poorly written custom build scripts :)

Anyway! This was very useful to read, and I agree with what you say.
Here's how the UI could look like:

1. Interactively choose a pipeline and run it:
$ bitbake-setup build

2. Run a pipeline given on command line:
$ bitbake-setup build <pipeline-name>

3. List pipeline steps
$ bitbake-setup build --list-steps <pipeline-name>
(this can be used to avoid hardcoding step names and their sequence
into CI-specific definitions, e.g. CI would first list the steps, then
iterate over them, avoiding the 'giant single step' problem - this of
course requires support for creating steps 'on the fly', which I think
at least buildbot can do)

4. Run a single step:
$ bitbake-setup build <pipeline-name> <step-name>

5. Run a pipeline, starting at a particular step:
$ bitbake-setup build <pipeline-name> --start-at <step-name>

6. Run a pipeline, stopping after a particular step:
$ bitbake-setup build <pipeline-name> --stop-after <step-name>

Etc. How's this looking?

Alex

