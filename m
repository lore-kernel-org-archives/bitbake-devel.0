Return-Path: <alex.kanavin@gmail.com>
Received: from mail-oi0-f50.google.com (mail-oi0-f50.google.com
	[209.85.218.50])
	by mail.openembedded.org (Postfix) with ESMTP id 15A8C79011
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Aug 2018 11:07:03 +0000 (UTC)
Received: by mail-oi0-f50.google.com with SMTP id n21-v6so32832933oig.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Aug 2018 04:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=nUAma9G2ag0LEYbVGg3uEdbUv0wdSPAfqBeEU8G82Ro=;
	b=CTd8FGDg0ta6B9q1yGLzwy7SJdjSdvkrmC4HBwKVH5dr4OfU4L2V34O+ATh5r90gv8
	r8wvG+3WrrKFzX/F5L4CzgiEEH9y3CM52Odf04Na14IgTe9ToDkSRWwketHQlessvOmH
	BVEqDLW8rW7ii2cwkEtzEvUeM2eqjWDtkLTT/ktOeNwyzSmHVdg9XGcAwaI1XKUWHli8
	j/wy4O6sBlxjeMjsMBlnoGDxIP4ljG5rH1ZVlGv4YsiYlFHuPQ4MPpoAPIs6mFgYU0lP
	5iE2jWfhfbuDUxQ8HzxcYNpYgtZ3UKACouLKjD0Q7/igG4l+xomVu2pbf2hUn9lXZ6f5
	3BtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=nUAma9G2ag0LEYbVGg3uEdbUv0wdSPAfqBeEU8G82Ro=;
	b=myQIK8/SeoXjZqQTE55Y92/5MpLXbrjK3FWGC07VqPMvUs2gUBA6IwfsyWIIfUEJ1K
	tsGoAQTOKRZwF+l4pMno2gN44t2UuSfYHQeST/2udi+zbalsb5YjNxO9wqeNQF7N7YxD
	gRR3PHDNU61AuB7B6bHCwgFvlJlC5mFcHdD91D3qn+1qfwjlxEnT46wkD6F33GGwFYIR
	IuL17xeicX5UYP3nmVrBUBRVuVRyl3SnVrfVqFdm9umpiD7/FGOLoQ8bIujF/NfwuYSU
	6telU/OobEmS55Ug/9GRwMNy8AtFSbLcEfrpMnCQIr+Mv9ta27p8rm+IKetGuujbu4E5
	MFzg==
X-Gm-Message-State: AOUpUlENYDjtZiGbzZ0GGDc81z2pNvvcYaNodzWZKYw2waWz7920phd8
	rc506ndvYsi/v027BSVU12kgB32rkmVtQmkks+7ReTHHe/Q=
X-Google-Smtp-Source: AA+uWPyJwAye6rOJ8s5ta9rOP8DJL830QkbMSZ6jBT/mZsuzN4RlnouS2sMZh8trBE/153ax/zHRQUa7DCTHX7IYpPE=
X-Received: by 2002:aca:e80c:: with SMTP id
	f12-v6mr23624042oih.38.1534244825114; 
	Tue, 14 Aug 2018 04:07:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:90c5:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 04:07:04
	-0700 (PDT)
In-Reply-To: <75dc7178b6204b0d898f136ab9cceeb4@XBOX02.axis.com>
References: <20180813210445.32496-1-schnitzeltony@gmail.com>
	<20180813210445.32496-3-schnitzeltony@gmail.com>
	<CANNYZj-3OQ7gPEop3OcDL5bnv3x9Q=DmEFCYi4-K7B3Xqp5v0Q@mail.gmail.com>
	<20180814011119.GA1391@jama> <20180814063203.GJ8291@hiutale>
	<CANNYZj-b4D5FOc-S2_EbLYvpzdM4u4H8DeJP3JUbmeJJAsAcWA@mail.gmail.com>
	<98d2737cbf96633abe4ff3bdacd40582f6e83262.camel@linuxfoundation.org>
	<8ac13026f3f66ce8a652d760162bb4cf74e13ebd.camel@linuxfoundation.org>
	<75dc7178b6204b0d898f136ab9cceeb4@XBOX02.axis.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 14 Aug 2018 13:07:04 +0200
Message-ID: <CANNYZj-5Kjipbu42-ErPAnEXVzD03CutpCh7hTY9OQDZTVR+hg@mail.gmail.com>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 2/2] runqueue: Introduce load balanced task spawning
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
X-List-Received-Date: Tue, 14 Aug 2018 11:07:04 -0000
Content-Type: text/plain; charset="UTF-8"

2018-08-14 12:28 GMT+02:00 Peter Kjellerstedt <peter.kjellerstedt@axis.com>:
> Even though make is the prevalent tool used to build code, we have
> to consider others such as cmake and meson... Any idea if their
> parallelism can be controlled in some similar way?

These tools (and qmake etc.) only configure the builds, with makefiles
as output. They delegate the actual build job execution to make and/or
ninja.

Alex

