Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
	[209.85.221.49])
	by mail.openembedded.org (Postfix) with ESMTP id 7756A7F03E
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Jul 2019 00:05:47 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id f9so4197973wre.12
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 17:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=bnCaS2oiiOoW5rbTTayStpkhhZkEU1c6LRteA54K6G8=;
	b=TY8XC03Vom3XzmxbJukMbuMg5drAJTnFIGXeZ9pX2jeDEJ20DCKCTFNaNWVeqsHPTe
	Yow1MCFfxGqjfTjgsZ8vkRowp7ZevjfBBatMCCgz4Prmz2xcowDrRI6RIcovsYmBCMja
	0GKSz+YwpVe+p8rdsqbS4dFxfouajMx7Tp8VY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=bnCaS2oiiOoW5rbTTayStpkhhZkEU1c6LRteA54K6G8=;
	b=U4eEPRc1gHIRxa2LnLCrNyq7ZqXEeRd2krJK1NiBvzgVQfge+MfCmdYcue8Wva5lGG
	HGCRYTKUg+4O8xXjDseCWP04AjcdVIAOfTkW8ETv02U4ntxSyNxXGyu7N75JMzeFidm3
	FiyGMKcMOJuJ06qItnDGNmnY8sn9/y2lCsaPJ75NFvCi1QiRRRXOnnBwioaePwOq+hZd
	QTFy3iJj7HuZviOD4yqkjSiwEZN4yC8Q47ua6tK9bSyojNgmhpCrZSR2kqXyoo1RXOkG
	nQmuK5RJVyUSMxgTosGey3mK9x5+ShVO7fOyHRfsqkFsrgR1ZT3jNAuYpBXCENGFw3ZN
	W76A==
X-Gm-Message-State: APjAAAUwi9QItDtWvY5JiqMn91RExXijDqkgHa/yrOn3k1IN9q+/Tuuu
	pXF+sZpzvkbQG82vvdDnVUlw2p5u+tQ=
X-Google-Smtp-Source: APXvYqyMIgrme2ZIsqlusHV4f7Aq5kd/HvCtjwvkleW9DGobzKffEkleG9V2057U8vVpHozcEmiMTQ==
X-Received: by 2002:adf:f601:: with SMTP id t1mr250394wrp.337.1562803547833;
	Wed, 10 Jul 2019 17:05:47 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	f17sm3453742wmf.27.2019.07.10.17.05.46
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 10 Jul 2019 17:05:47 -0700 (PDT)
Message-ID: <8ace64fd460c657fee23dd39887825e418314c5e.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Jul 2019 01:05:46 +0100
In-Reply-To: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
References: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
User-Agent: Evolution 3.32.2-1 
MIME-Version: 1.0
Subject: [PATCH 00/26] runqueue changes
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 11 Jul 2019 00:05:47 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This patchset reworks runqueue so that instead of having two distinct
phases, specifically "setscene", followed by "normal tasks" we have one
single phase.

In this single phase, both sets of tasks can run in parallel using the
same workers. Thankfully the code already used common classes and
functions so making this transition was relatively straight forward.

Initially all tasks are in the scenequeue, as it works through them,
they are marked as "buildable" which means normal tasks can execute.

The big change here are in the code which incrementally marks tasks as
available rather than being able to process tasks "en mass".

The most common failures from these changes are potentially:

a) tasks not migrating from the scenequeue
b) tasks not becomming buildable

I've made some tests on the autobuilder and believe I've tested many of
the common usecases. There is debug code to abort the builds with the
above errors when something unexpected happens.

I've also written an initial set of runqueue unittests. To do that I
had to create a dummy set of metadata so we had some dependency trees
to test with.

This patchset did remove an API we no longer need/use after RSS was
introduced and gets rid of what seems like a pointless form of event.

These changes set up the foundations so that we can work on two other
significant problems:

a) reuse of sstate artefacts between multiconfig build tasks
b) adapting the task queue 'on the fly' if the output of a task matches
   a previous output and hence we have sstate hash equivalency

Solving these would be great for OE!

I will follow up with more details on the future plans for the above
and this code soon.

Cheers,

Richard




