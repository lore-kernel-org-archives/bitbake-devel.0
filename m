Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47D5E81BC4
	for <webhook@archiver.kernel.org>; Mon,  9 Feb 2026 13:55:19 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.47828.1770645318140255613
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Feb 2026 05:55:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=YhXMdpFK;
 spf=pass (domain: gmail.com, ip: 209.85.219.51, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-89577f866d6so23393486d6.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 09 Feb 2026 05:55:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770645317; cv=none;
        d=google.com; s=arc-20240605;
        b=iMG2h/rF3095nfcp44pRJWRpffoAYvNZAVSjzliVlxrCrpj9qZaoEeB1jEKicpKHLm
         wI32wR/mGd6kx0xDM/I2BjkkLzuinvbc/JbOIKZL6mtJmLLnwontVw52kkOBIF6BYlBF
         /gYSyM5ZixIlqAlreJypRuOde2vMrXxEoB2pR/Ysp/1jmBNVdGwcUCrHUOL0AuJUVx9a
         gogLnrJr0fU6QcReJ6NdfiOt2skYDpCRkrEu7o7XU8mikC+gojN80pFU3ub8S4pUAK2T
         KNHqVBNYAZpthkDjw5pXGnXNA6wvmMBTBoNe+U5wCJbn7LfabUHdy44qSll5kDr9PV+2
         NXsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ndUmfuEnCOd6Gk8ycTGw3YudUn2HInpAxy2YPDQeStk=;
        fh=FAZ8HVKp2YeBhxeSNYq5FZYVen6kECoTholcQbNtmuE=;
        b=bbRw5uZ0oKX985bAP+5Gp+KgV/kfiv4xe3cpuGusziel3OEV8YSGOqvzo/HTliTmZj
         JS55xZwxJB95ITfY3242ewojBff4fxR+/sO0aVWREetWPUYI1EEwc9Pd/0uCIVoRVYaW
         eAhvapHuEpAxMyZx0gupo879HQcQGdyfZyEykkBuKfIA9LKCP2nFT2SGgAZ+NhhVt2hX
         cGzsMhnEt06yWge6+2E5FTO5fLjBEmkXwlsmVOXyPC8i02cna2ZPbWuaVtjYAFUIxIW8
         PgmNN1LX3+KBpCzbbT5XfKRtYgo3NCswd9zizDToRZfb8GvKxMBsxMOK6rSgd3lOh+vc
         oq/w==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770645317; x=1771250117; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ndUmfuEnCOd6Gk8ycTGw3YudUn2HInpAxy2YPDQeStk=;
        b=YhXMdpFKzrIv6pI88hY/ZsPUnPk9OF7HvrVuJj47m3fltZ4sOwzMWf32grT+59aaC9
         xfCtxYbkbHDdTYR0b4YRrq/ZoLNXFlMJ/YAJNh4CyRF0D9gu4XpL9ZUU0wYHF5kGnCzs
         /Qzc4hUnFLynPSxWwriEG11iXk9ya3V6u7vszhDMSRUfjuTTMBLxFBUW6Fux7DWZ+nq7
         NrZj5Km2CjzoGKWyW0xpU9WWWNyArA8QeevNHtQ2XvUm7BTtiERK3lgK3+k1NLuQrKSh
         L6F1H5gC5by9CcLuSLgV1iF4sP/HrgHrbjYQhhWF2EtxrsJbSFDLCuzLc75wEP4nJDvv
         knZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770645317; x=1771250117;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndUmfuEnCOd6Gk8ycTGw3YudUn2HInpAxy2YPDQeStk=;
        b=bv11w762J19bzhvS9QsFJGJolD/bgquxRDXLx6QNzNZ3ASHHadOZlzmb4TlCgYHFPa
         edSI5NhPKpc1FjxiJuv3NU5D+aXnHYyVTtj0K2o39tL/bAQwdzqLSuC8bcttMCRHfsgu
         j9ArYSmto30XWeLscuj4pS6jMoKFflfUnT8tdQRi0ShqOTUjIc5uFwWd1ZvOOn3JGCMn
         ZKymrOH2pYrJ1DCRdUTx+HXIBLs+TnbeovDKEkzPmQol4faL1pT6BV+wYnf4QGeqczJO
         E36tGupj2yT5FIeb+vObstd2GxlSmWqfK+sc41ClG3MY8e6DVWRoPNaPcHusi6fF6lqm
         QcAg==
X-Gm-Message-State: AOJu0YylTSLswFbJfsR2n2MJU5X6lsTORAZsVb63byKSLDYiRW7jOPfQ
	FOvJ+0E3P7vwhK3WEKBQxGQgxEBS8D6H+yLSt6F4801f/S0Qf5XVav0Dtmt16qrtccKdkYZJHiV
	C48/WcxCOLJ7uf664rggVipsAI/T1Kqfp4ECu
X-Gm-Gg: AZuq6aIctOrHBiCU8XiBFTQtHALtC6VThpsRbuEZDo3YMnQ402pAziR6SM3MUmP+6Qb
	+V+AeNBbNs3RoxSaZmO/xmN1+CNELQ9y5soQn+FQnQb2NW/1YhLahVqHCPLcnz2c1ByuG1xUaJw
	SRJCeqaUXW8gTwlGSObBLo3dJGXgHkL5PxIhJipG6fum064VbLHkBfcPATlQRPl5GNBbdSjbmBe
	vFnSDXE8/iujUzYUPxYFuSbL4TGnlcspNro02zHC5gVr0fWzqwLR4LWyVulL/jwGNIv5F5gkw1n
	lFYKf82OMMWz0SRetBLjYoHLF9ppbHegLSOuUoOt
X-Received: by 2002:a05:6214:2389:b0:894:7005:ed8f with SMTP id
 6a1803df08f44-8953013d921mr214518946d6.35.1770645316900; Mon, 09 Feb 2026
 05:55:16 -0800 (PST)
MIME-Version: 1.0
References: <20260129120421.4413-1-alex.kanavin@gmail.com> <20260129120421.4413-2-alex.kanavin@gmail.com>
 <DGAGEOPPKN0O.1PO5OD6RTZXLX@bootlin.com>
In-Reply-To: <DGAGEOPPKN0O.1PO5OD6RTZXLX@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 9 Feb 2026 14:55:05 +0100
X-Gm-Features: AZwV_QhPZ0443NiH8IHg4NJnWOpTFFo3ACX3fwWQ5gaXAyYt2j-Y--u_93e38kk
Message-ID: <CANNYZj-EPfHrGL25=MMYGhB401mnj3LVmeQ1Dm884JCDhH2fCQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v3 2/2] bitbake-setup: share sstate by
 default between builds
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>, Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Feb 2026 13:55:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18990

On Mon, 9 Feb 2026 at 14:09, Mathieu Dubois-Briand
<mathieu.dubois-briand@bootlin.com> wrote:
> I noted some performance regression on the autobuilder with this patch.
> I did not had time to fully investigate the underlying reasons so far,
> but I'm fairly convinced they were introduced by this change.
>
> This is visible at least on selftest builds, rising from 1-3 hours to
> something like 5-8 hours.
>
> A build with my branch on the commit just before: https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/3158
> A build with my branch on this commit: https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/3161
>
> Some tests appear to be way longer to run, typically:
>
> 2026-02-05 11:26:19,583 - oe-selftest - INFO - buildoptions.ArchiverTest.test_arch_work_dir_and_export_source (subunit.RemotedTestCase)
> 2026-02-05 11:26:19,583 - oe-selftest - INFO -  ... ok
> 2026-02-05 11:26:19,583 - oe-selftest - INFO - 11: 1/34 11/664 (36.33s) (0 failed) (buildoptions.ArchiverTest.test_arch_work_dir_and_export_source)
>
> 2026-02-05 15:48:59,247 - oe-selftest - INFO - buildoptions.ArchiverTest.test_arch_work_dir_and_export_source (subunit.RemotedTestCase)
> 2026-02-05 15:48:59,247 - oe-selftest - INFO -  ... ok
> 2026-02-05 15:48:59,247 - oe-selftest - INFO - 11: 1/34 59/664 (1568.37s) (0 failed) (buildoptions.ArchiverTest.test_arch_work_dir_and_export_source)
>
> Maybe the configuration is clashing with the configuration we have on
> the autobuilder, or maybe this is just something else in my branch.

Thanks Mathieu, we're aware of this, and the patch is used as a
'canary' to find where SSTATE_DIR isn't set entirely correctly.
Particularly, config.json is using ?=, and I believe it should be a
hard assignment with =

https://git.yoctoproject.org/yocto-autobuilder-helper/tree/config.json#n38

Alex

