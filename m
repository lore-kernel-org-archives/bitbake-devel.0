Return-Path: <enrico.scholz@sigma-chemnitz.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9602DCCF9F8
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 11:02:35 +0000 (UTC)
Received: from smtpout.cvg.de (smtpout.cvg.de [87.128.211.67])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11024.1762945344528744130
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Nov 2025 03:02:27 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@sigma-chemnitz.de header.s=v2022040800 header.b=bM3gn+mY;
 spf=pass (domain: sigma-chemnitz.de, ip: 87.128.211.67, mailfrom: enrico.scholz@sigma-chemnitz.de)
Received: from mail-mta-3.intern.sigma-chemnitz.de (mail-mta-3.intern.sigma-chemnitz.de [192.168.12.71])
	by mail-out-3.intern.sigma-chemnitz.de (8.18.1/8.18.1) with ESMTPS id 5ACB2LBk1557238
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
	for <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 12:02:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigma-chemnitz.de;
	s=v2022040800; t=1762945342;
	bh=mCtFQ7gY9glvlFOJi84dRb+IA0m/HWrV4QIyWDw+yqs=; l=366;
	h=From:To:Subject:Date;
	b=bM3gn+mYUUwfDlO4AW+AiIFM4jOUC/cDyqlmodzE4exbgW91nT8na29HNT94cCmgn
	 pWEW7xj8vhyYGsSR8YU9SrYOBvpVYY08QD6J/UCaqphF99vX0zdLpPoSEAaLebrB7X
	 LGyGodfhxLCapDnDyfscdqD/X4BCOiyoyZPTKi4NdJCHrn0VfLkTBGYcAlnrJuIPsv
	 miHOGAjbh24SHOV15LcSG3O4XYMKknE14mpgdnYCwDGZOqUzO9SA3GV2i0EqXc3KTk
	 3231bbE/Od218MF7BsiET7dKpo7dY9FSx+ZwEt50Br5dueZ1OxQCesnL86teARnrem
	 SLRi2e7AgMqTA==
Received: from reddoxx.intern.sigma-chemnitz.de (reddoxx.sigma.local [192.168.16.32])
	by mail-mta-3.intern.sigma-chemnitz.de (8.18.1/8.18.1) with ESMTP id 5ACB2JQn4018410
	for <bitbake-devel@lists.openembedded.org> from enrico.scholz@sigma-chemnitz.de; Wed, 12 Nov 2025 12:02:20 +0100
Received: from mail-msa-2.intern.sigma-chemnitz.de ([192.168.12.72])
	by reddoxx.intern.sigma-chemnitz.de with ESMTP
	id ENG2QP4KT1; Wed, 12 Nov 2025 12:02:18 +0100
Received: from ensc-pc.intern.sigma-chemnitz.de (ensc-pc.intern.sigma-chemnitz.de [192.168.3.24])
	by mail-msa-2.intern.sigma-chemnitz.de (8.18.1/8.18.1) with ESMTPS id 5ACB2H9V440277
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org> from ensc@sigma-chemnitz.de; Wed, 12 Nov 2025 12:02:19 +0100
Received: from ensc by ensc-pc.intern.sigma-chemnitz.de with local (Exim 4.98.2)
	(envelope-from <ensc@sigma-chemnitz.de>)
	id 1vJ8cD-0000000GRIf-2INj
	for bitbake-devel@lists.openembedded.org;
	Wed, 12 Nov 2025 12:02:17 +0100
From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To: bitbake-devel@lists.openembedded.org
Subject: Broken 'knotty' UI on Fedora 43
Date: Wed, 12 Nov 2025 12:02:17 +0100
Message-ID: <lyldkbcy4m.fsf@ensc-pc.intern.sigma-chemnitz.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
X-REDDOXX-Id: 6914693af95b4083a919bb21
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 11:02:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18349

Hi,

when running recent bitbake master (2c6c40bda) under Fedora 43, the
knotty UI is broken.  While building, it eats previous lines when a new
task is started so that every output (Build Configuration, warnings) is
removed at the end.

Downgrading 3.14.0-1.fc43 to 3.13.9-1.fc42 restores the old behavior.
Seen with 'screen' and 'xterm' $TERM.


Enrico


