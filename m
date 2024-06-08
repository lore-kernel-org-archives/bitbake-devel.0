Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AC4C25B76
	for <webhook@archiver.kernel.org>; Sat,  8 Jun 2024 10:25:27 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web11.3985.1717842326439728644
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 08 Jun 2024 03:25:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=YH5tr4W5;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: alexandre.belloni@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0CC3240002;
	Sat,  8 Jun 2024 10:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717842325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=392NA/be6O90neCFlwaV4Lu018pzHjF0RyzGsYHV0mQ=;
	b=YH5tr4W5sDz58pKWNOJjoWuhQtD+sVxlFXIjH3TN63VX+HwVi34nKXsrb/FEvLrPqCPjQy
	UUPbNbFxnWx7gBF5YcTJNvCRVoLSaCD2tsH1V9SSFRxGWrSCo12vDQpOaSt77xEf+XC+GN
	kZ3buZZsl4C+/CcNHdC8jjHUhJ+dr28vaAM5LTVMeaaJdMgPTLWCi+zSZrajGThFc0RPrg
	vcqWf6l5gYiFDfxBjy2K/dqKcv9fE9j97D5rqTNhw7zfFCw8MhQVJJ8ytzmUDr1RjM4pYX
	iotSrH105IgohH5vwF4E+BOIWR5O0M6hGmqmqv09Edcw3HBHl/MWknd3TzScxw==
Date: Sat, 8 Jun 2024 12:25:24 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH 1/2] siggen: Drop copy_unihashes function
Message-ID: <2024060810252435af9fa7@mail.local>
References: <20240604142803.3658144-1-richard.purdie@linuxfoundation.org>
 <202406081016282d36c3ad@mail.local>
 <28eec7ae10919151679dbaefb9db807c92b1f1cf.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28eec7ae10919151679dbaefb9db807c92b1f1cf.camel@linuxfoundation.org>
X-GND-Sasl: alexandre.belloni@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 08 Jun 2024 10:25:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16333

On 08/06/2024 11:18:48+0100, Richard Purdie wrote:
> On Sat, 2024-06-08 at 12:16 +0200, Alexandre Belloni wrote:
> > Hello Richard,
> > 
> > 
> > On 04/06/2024 15:28:02+0100, Richard Purdie wrote:
> > > The code in OE-Core using this has been replaced with something
> > > more fit
> > > for purpose. Drop these function calls as they were never a great
> > > idea in the
> > > first place and cause IO slowdown for runqueue needing to sync the
> > > cache.
> > > 
> > > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > > ---
> > > �lib/bb/siggen.py | 6 ------
> > > �1 file changed, 6 deletions(-)
> > > 
> > > diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
> > > index 92066da00c..89b70fb6a4 100644
> > > --- a/lib/bb/siggen.py
> > > +++ b/lib/bb/siggen.py
> > > @@ -201,9 +201,6 @@ class SignatureGenerator(object):
> > > ���� def save_unitaskhashes(self):
> > > �������� return
> > > �
> > > -��� def copy_unitaskhashes(self, targetdir):
> > > -������� return
> > > -
> > > ���� def set_setscene_tasks(self, setscene_tasks):
> > > �������� return
> > > �
> > > @@ -418,9 +415,6 @@ class
> > > SignatureGeneratorBasic(SignatureGenerator):
> > > ���� def save_unitaskhashes(self):
> > > �������� self.unihash_cache.save(self.unitaskhashes)
> > > �
> > > -��� def copy_unitaskhashes(self, targetdir):
> > > -������� self.unihash_cache.copyfile(targetdir)
> > > -
> > 
> > It breaks sstatetests.SStateBundles.test_minimal_bundle which uses
> > copy_unitaskhashes
> 
> 
> Is that patch only in your -next branch? I didn't see this issue in my
> own testing which makes me wonder...

You are right, git blame told me it was applied a month ag and I didn't
check further. I'll drop the patch.



-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

