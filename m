Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265D5C7EE23
	for <webhook@archiver.kernel.org>; Tue, 23 May 2023 21:04:43 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web11.14582.1684875876472898078
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 23 May 2023 14:04:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=leweJa9y;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201, mailfrom: alexandre.belloni@bootlin.com)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 52D121BF203;
	Tue, 23 May 2023 21:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1684875874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lLp0mPf9qIFEhzxqy5LH5ezmQS5xYoAIaEENUW5w2q4=;
	b=leweJa9yoIENZm3ZG9u50G3p5I+dXx09ZVdq8M7EaNT6zAcAeTqJFKsclRtigGqPTTzJGL
	EzwZFAVs8t0RizkW+/o0jr/hwppm3IwdH/A0GIdJp9zx8eNbKVIRYkA0AX8GfET7/u3DL1
	0T5OEYiezxEAduUXDuo0rdFNEAeiG/+WU+xPW0+310amfMQ6JBnLTn6tBwI84XT+/EMY6F
	8ySgtV/3znS5KDIweZF5vygIyyXCqqU+d7lSZwCQcSXtHSMvWFonWANzQhswtNqYoIrKCD
	XA9yW8bCy+qVMzys8VL3AcPyHXwagw7AV1YPUWDTmz+cJzdWzXNVBAy83usccw==
Date: Tue, 23 May 2023 23:04:33 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Arno Baumfalk <a.baumfalk@astro-kom.de>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] fetch2/npm: evaluate PATH before
 patching HOME
Message-ID: <202305232104338816c33b@mail.local>
References: <94c18370-5149-8d5a-32ad-8c72a76e38e0@astro-kom.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94c18370-5149-8d5a-32ad-8c72a76e38e0@astro-kom.de>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 23 May 2023 21:04:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14800

Hello,

On 16/05/2023 18:07:08+0200, Arno Baumfalk wrote:
> From acafbccb32510bca036894287afbe83765bc2d30 Mon Sep 17 00:00:00 2001
> From: Arno Baumfalk <a.baumfalk@astro-kom.de>
> Date: Tue, 16 May 2023 17:18:26 +0200
> Subject: [PATCH] fetch2/npm: evaluate PATH before patching HOME
> 
> When the user configures the TMPDIR variable in a way that it contains $HOME
> (in local.conf), the DataSmart (d) object's PATH variable will also contain
> $HOME.
> 
> As the NpmEnvironment patches HOME with a temporary directory, further
> evaluation of PATH will become invalid an the build breaks with an error
> (npm not found).
> 
> As countermeasure PATH is evaluated *before* patching HOME.
> 
> Signed-off-by: Arno Baumfalk <a.baumfalk@astro-kom.de>
> ---
> �bitbake/lib/bb/fetch2/npm.py | 1 +
> �1 file changed, 1 insertion(+)
> 
> diff --git a/bitbake/lib/bb/fetch2/npm.py b/bitbake/lib/bb/fetch2/npm.py
> index 8a179a339a..e6d0598f5d 100644
> --- a/bitbake/lib/bb/fetch2/npm.py
> +++ b/bitbake/lib/bb/fetch2/npm.py
> @@ -103,6 +103,7 @@ class NpmEnvironment(object):
> �������� """Run npm command in a controlled environment"""
> �������� with tempfile.TemporaryDirectory() as tmpdir:
> ������������ d = bb.data.createCopy(self.d)
> +����������� d.setVar("PATH", d.getVar("PATH"))� # PATH might contain $HOME
> - evaluate it before patching

It seems your mailer is mangling your patch and it does not apply.

> ������������ d.setVar("HOME", tmpdir)
> 
> ������������ if not workdir:
> -- 
> 2.26.2
> -- 
> 
> Mit freundlichen Gr��en
> 
> *ASTRO Strobel **
> *Kommunikationssysteme GmbH
> 
> Dr. Arno Baumfalk
> Entwicklung
> 
> 	
> 
> 
> Telefon: 	+49�(0) 2204 405 228
> Fax: 	+49�(0) 2204 405 220
> eMail 	a.baumfalk@astro-kom.de <3D"mailto:a.ba=>
> Internet: 	www.astro-kom.de <3D"http://www.=>
> 
> 
> Folgen Sie uns<https://www.facebook.com/astrostrobel/>
> 
> ASTRO Strobel Kommunikationssysteme GmbH
> Olefant 1-3 � 51427 Bergisch Gladbach
> Gesch�ftsf�hrer: Herbert Strobel
> Registergericht K�ln HRB 46271
> Steuer-Nr. 204/5710/0569 � USt.ID-Nr. DE 121980384
> 
> Die Informationen in dieser eMail zusammen mit allen Anlagen sind streng
> vertraulich. Sie sind ausschlie�lich f�r den Gebrauch des rechtm��igen
> Empf�ngers bestimmt. Jegliche Weitergabe ohne unsere ausdr�ckliche
> Genehmigung ist verboten und kann strafrechtlich verfolgt werden. Sollten
> Sie nicht der vorgesehene Empf�nger dieser E-Mail sein, informieren Sie�uns
> bitte unter 02204/405-0 oder leiten Sie die Mail an uns zur�ck
> _a.baumfalk@astro-kom.de_. L�schen Sie bitte die E-Mail von Ihrem System.
> Die ASTRO Strobel Kommunikationssysteme GmbH tr�gt weder die Verantwortung
> f�r die richtige und vollst�ndige �bertragung dieser E-Mail noch f�r die
> Verz�gerungen in der �bertragung.
> 
> The information and attachments in this e-mail are strictly confidential.
> They are for the exclusive use of the legitimate recipient. Any transfer
> without our express approval is prohibited and can be prosecuted. If you are
> not the destined recipient of this e-mail, please inform us by phone number
> +49 2204 405 0 or send the e-mail back to a.baumfalk@astro-kom.de. Please
> delete this e-mail from your system. The ASTRO Strobel Kommunikationssysteme
> GmbH is neither responsible for the complete transmission of this e-mail nor
> for transmission delays.

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14790): https://lists.openembedded.org/g/bitbake-devel/message/14790
> Mute This Topic: https://lists.openembedded.org/mt/98929768/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

