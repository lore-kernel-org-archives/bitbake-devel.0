Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by mail.openembedded.org (Postfix) with ESMTP id 8EDBF7EED2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Jul 2019 16:21:29 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id p13so6938646wru.10
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Jul 2019 09:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=HEI0UjdkB354xbAsZzTZidl7daIkcWj2fCktg8ToSSw=;
	b=L2b0nLWW8Ju8NEj1dp0Day7lra6PUePZpGpM6VE2Eu4E6VKgt/IAqVPNSGKwo58dRq
	xZnKFZ1yuJs0DcFin+yM/Nfehcmk236A7w4duiWQO6wj1V5ukKSPHGa2crY5MVE90C/W
	Ovs/iLje7khhdfQhv06Xl6UuOh5c94VABBHQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=HEI0UjdkB354xbAsZzTZidl7daIkcWj2fCktg8ToSSw=;
	b=hO3hvw6C6uRz0FXaGEh2mnvzkMvh0obBBPev3Cpa/2EjIxpx6F2KvQZpw6Tkv23MJT
	PznomaxNCnLEBywlS7+DwhdPH87H5llZ+WYHrfjITqn5Eqw15L3tWfG8mnmVOi+wL1RR
	Mzizmf4Ajuhzp3GPe+GFckCnOpA6yTrGWaPLF7eHmzC342WOfXlFmsZIrHIi0+cYwv7i
	Udp6c7rS5ztdU19iKxP4WnoeXk8WWzFr21sJ6HffK6BIBOz4FrcWLdakbdSRSAp8HUzK
	+kfxSV0CllxuAKM+aoaz6Qd4d55fPYwsgWF2Z822lupreOQwSQsumQWyANnyAEnmEFyZ
	FjZA==
X-Gm-Message-State: APjAAAW6v5VWb/cCsh+tNDYD7lDyqXc9LYD8c7O//v8Bs7MQm9oTyhbN
	Rwqw4gYa2VsD0dJaA2X66wUS/VjXCwA=
X-Google-Smtp-Source: APXvYqyluvr/5xoe2RsHaq7vhZc/JhxefQgvUHNCrAHQKXf9PmSvvwCe1MewiPfxtpHs5wA2lrdccQ==
X-Received: by 2002:a5d:6a84:: with SMTP id s4mr5996086wru.125.1562862090058; 
	Thu, 11 Jul 2019 09:21:30 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id a2sm6114151wmj.9.2019.07.11.09.21.28
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 11 Jul 2019 09:21:29 -0700 (PDT)
Message-ID: <e09869e803d875b3dfc9ba329dc261550bb25143.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Jul 2019 17:21:28 +0100
In-Reply-To: <8ace64fd460c657fee23dd39887825e418314c5e.camel@linuxfoundation.org>
References: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
	<8ace64fd460c657fee23dd39887825e418314c5e.camel@linuxfoundation.org>
User-Agent: Evolution 3.32.2-1 
MIME-Version: 1.0
Subject: Re: [PATCH 00/26] runqueue changes
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
X-List-Received-Date: Thu, 11 Jul 2019 16:21:30 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2019-07-11 at 01:05 +0100, Richard Purdie wrote:
> These changes set up the foundations so that we can work on two other
> significant problems:
> 
> a) reuse of sstate artefacts between multiconfig build tasks

I have spent a long time thinking about this so now the codebase was
ready it turned out not to be too hard to make it work. Patches aren't
tested apart from with the unittest but I've posted them and we can
take them from here.

> b) adapting the task queue 'on the fly' if the output of a task
> matches a previous output and hence we have sstate hash equivalency
> 
> Solving these would be great for OE!
> 
> I will follow up with more details on the future plans for the above
> and this code soon.

Adapting to new hashes "on the fly" is definitely going to be the
harder challenge.

This will involve the following steps:

a) Knowing there are new unitask hashes available and propagating that
information

b) Figuring out which tasks should now have their sstate retested

c) Test for sstate existence (if it doesn't exist, no point in going
further)

d) Ensure any normal tasks covered by the sstate task are not running,
wait if any are

e) Remove all those normal tasks from access by the normal task running
code

f) Enable those tasks in the scenequeue code

We have no existing code which moves things "backward" in the state
engine from normal task to scenequeue so this will be new ground, but
should be feasible.

I'm going to wait for the current patches to settle before I look into
this any further though.

Cheers,

Richard


