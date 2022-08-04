Return-Path: <luca.ceresoli@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EC9C19F2D
	for <webhook@archiver.kernel.org>; Thu,  4 Aug 2022 09:26:54 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web08.2826.1659605211838541342
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Aug 2022 02:26:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=j/p8lbok;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194,
 mailfrom: luca.ceresoli@bootlin.com)
Received: from booty (unknown [77.244.183.192])
	(Authenticated sender: luca.ceresoli@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 04BC240005;
	Thu,  4 Aug 2022 09:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1659605210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ajBatn2f24HFVHRqnBmXPK16xhEM5SEvi9U0hBakoLU=;
	b=j/p8lbokYDNBtcqiZ9QTddSjWQ+VPmoibQmUn6RoQnYB+CC1HE+vJCuqRmlZt6EaLSeCn4
	SV7ePRyzBt+NkrJccPJW+KD5gajyQCiYA7V8hEhSTDx5t/Rn1+ANqCikJFBPuVK/eEBRS7
	/ExE+U7QB2va5+nY38Q7CSIvuXzFLecHCm9BCpQQDi26R/NhioMOWPO/WpKbSt4d/GyVhD
	ecUTb3qfaREugn1aXlWWAu191Aj5HqWgcFL+LlPW5rROp8u+YF/HZDUX5X5qaJ+M5G9vNI
	o+FgAz39qfoRqi5K5DeVVsTGZZM7HdfRwI56nsp2Afas66bnpyBAb/cTjr/jwQ==
Date: Thu, 4 Aug 2022 11:26:48 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: "Joshua Watt" <JPEWhacker@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, rasmus.villemoes@prevas.dk
Subject: Re: [bitbake-devel][PATCH] siggen: Fix insufficent entropy in
 sigtask file names
Message-ID: <20220804112648.71c80544@booty>
In-Reply-To: <20220803140441.1196056-1-JPEWhacker@gmail.com>
References: <20220803140441.1196056-1-JPEWhacker@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 04 Aug 2022 09:26:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13869

Hi Joshua,

On Wed,  3 Aug 2022 09:04:41 -0500
"Joshua Watt" <JPEWhacker@gmail.com> wrote:

> Signature generation uses mkstemp() to get a file descriptor to a unique
> file and then write the signature into it. However, the unique file name
> generation in glibc is based on the system timestamp, which means that
> with highly parallel builds it is more likely than one might expect
> expected that a conflict will occur between two different builder nodes.

s/expect expected/expect/

Taken in my testing branch with the above fix.

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

