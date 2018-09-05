Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
	by mail.openembedded.org (Postfix) with ESMTP id 8A01074E47
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  5 Sep 2018 00:14:46 +0000 (UTC)
Received: by mail-wm0-f44.google.com with SMTP id f21-v6so6114655wmc.5
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 04 Sep 2018 17:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=SJPnA3FIWOz+Fx6VpqGEHp8nqz20UTCA0t3n+DFOSgc=;
	b=g5PhTx9qXHv0fJnZ0ALT7Nz+Cv1tYQE05XwFkzvHi3QmsbY41MXrySZbVn9eQlZIDP
	8fJnoVsYQPhsPAqSjE6R6+iG7TSUFgA8L/9TbHT1IZati6d5ZIlB1rPmNf24VacmwG3T
	KHTmv2f0tJvFEarlb+KZhUo4vdHQp9qo5vcwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=SJPnA3FIWOz+Fx6VpqGEHp8nqz20UTCA0t3n+DFOSgc=;
	b=ievYEF9967k0HgtAcAwWzohD7St0a5aHZhBfWmYMDRGEnAE4gHVsWPoIQA/GsKB5gi
	U7oFOWfj3zSreGBLPt/DBoZltzyfFfyXN45R3NNFlSSoUpyUVuY99K2t3BopOfr3ronh
	trdHKVjJcEADt+w6WBqvFIrHnXk1kO5o+3CZBSjLK7D2mQRYs2OPbB5pNb0kC7CHrCml
	UOH9gphMVYFuNQ2up9rGLEIxeLYLTmyzGw8hg+fL85BwqQXrqhUsDBO5UX6kY3c4/ICa
	9GkRGhLXlybOmO+9GB1d3TBYy56OTzOyL7lODD8LE2PA+BDLkdsH4ibR0V9hA+eDuckf
	ummw==
X-Gm-Message-State: APzg51CfeK+O5lkx1JjduQTuP3QV7VnA3NEwcx4kUvI3wEkQrnnGok5B
	/Qk4d7ctTqKBWGUuOjwiVhrTGA==
X-Google-Smtp-Source: ANB0VdYZ2UVkA1WypfQrTfbE/ZMmXQseEEfXI8vHcp/4oFhFXWgvduvKlLwNy4QCA2IgsMhx4dDkCQ==
X-Received: by 2002:a1c:7301:: with SMTP id d1-v6mr9092582wmb.34.1536106487143;
	Tue, 04 Sep 2018 17:14:47 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	a9-v6sm430312wmf.28.2018.09.04.17.14.45
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 04 Sep 2018 17:14:46 -0700 (PDT)
Message-ID: <6b0aad97f792be57f477f2d38ab8f10c9ee16dbc.camel@linuxfoundation.org>
From: richard.purdie@linuxfoundation.org
To: Jan Kiszka <jan.kiszka@siemens.com>, bitbake-devel@lists.openembedded.org
Date: Wed, 05 Sep 2018 01:14:44 +0100
In-Reply-To: <66fb849c-41d7-650a-046c-bc09e76fd594@siemens.com>
References: <192b8cc1-4ea9-1cd7-5a3f-f4c150868a0e@siemens.com>
	<2ba43936a9d6d2a1baac49c419cdc5c86cbbdbf1.camel@linuxfoundation.org>
	<f22cc8eccc5b47a29c87de3b6ad9193d22f486b6.camel@linuxfoundation.org>
	<66fb849c-41d7-650a-046c-bc09e76fd594@siemens.com>
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Subject: Re: [PATCH] process: Flush server stdout/stderr before reporting failure
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
X-List-Received-Date: Wed, 05 Sep 2018 00:14:47 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2018-09-04 at 15:09 +0200, Jan Kiszka wrote:
> Looks similar on first glance, but it only partly helps with
> exceptions. 
> We get from
> 
> $ bitbake | cat
> ERROR: Unable to start bitbake server
> 
> to
> 
> $ bitbake | cat
> ERROR: Unable to start bitbake server
> ERROR: Server log for this session (/work/build/bitbake-
> cookerdaemon.log):
> --- Starting bitbake server pid 149 at 2018-09-04 13:02:15.144583 ---
> 
> while it should have
> 
> $ bitbake
> ERROR: Unable to start bitbake server
> ERROR: Last 10 lines of server log for this session 
> (/work/build/bitbake-cookerdaemon.log):
> Traceback (most recent call last):
>    File "/work/isar/bitbake/lib/bb/daemonize.py", line 77, in
> createDaemon
>      function()
>    File "/work/isar/bitbake/lib/bb/server/process.py", line 433, in 
> _startServer
>      self.cooker = bb.cooker.BBCooker(self.configuration,
> self.featureset)
>    File "/work/isar/bitbake/lib/bb/cooker.py", line 178, in __init__
>      self.configwatcher = pyinotify.WatchManager()
>    File "/work/isar/bitbake/lib/pyinotify.py", line 1764, in __init__
>      raise OSError(err % self._inotify_wrapper.str_errno())
> OSError: Cannot initialize new instance of inotify, Errno=Too many
> open 
> files (EMFILE)

The more I looked into this the more problems I found. I've put this in
for some testing which should address the issues:

http://git.yoctoproject.org/cgit.cgi/poky/commit/?h=master-next&id=dae574dd680f4f9db0b1447266742fa127963842

Cheers,

Richard

