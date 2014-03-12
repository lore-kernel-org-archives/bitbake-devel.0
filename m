Return-Path: <ross.burton@intel.com>
Received: from mail-qc0-f172.google.com (mail-qc0-f172.google.com
	[209.85.216.172])
	by mail.openembedded.org (Postfix) with ESMTP id 6E8246E757
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Mar 2014 16:06:42 +0000 (UTC)
Received: by mail-qc0-f172.google.com with SMTP id i8so11503704qcq.17
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Mar 2014 09:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=cZbHSwFA27SEi/BQ5JbgQbfM7lKNyHvTNdfjOqYsZAA=;
	b=Gfq/oqrST2zaOhGJ56jrFRe941YrTqhEp3uCsWpRKMiD//S3UQ6ZmcWG/DEpJbWR5h
	U24QSUFHAzdEzkTCUUAEKqmGW4vz8lVc3jtpo8hQrxYZ1+T0tKd7V2LQtYXKPYi9TWTo
	pvqOlIxbmGkAkoeHbbaWowlunsq8L79RpXEVbtcFLxPiKLDgi+x5jaogDfkN8mlLmKvC
	zns9UgC4pGqw/R2qbDBo9ym/YiudlUPhzQ2G4qaWN1hMykCZwmF7HJWaZ6ikyfhnEKiH
	tK+kWBUyRONkkx01kYe1QMOZgFw8CrD/MTyjEYGTdylzq82A/hkrn5PYqleBReKkZ27Y
	Z7mA==
X-Gm-Message-State: ALoCoQkaqKP7gDB5NwcOoJIvvlrvnJd/skzi3oUvlX169+g1VUEETtPdrPS9HkpqCLN79vgO9td2
X-Received: by 10.140.42.9 with SMTP id b9mr3312848qga.87.1394640403503; Wed,
	12 Mar 2014 09:06:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.48.79 with HTTP; Wed, 12 Mar 2014 09:06:23 -0700 (PDT)
In-Reply-To: <1394631711-1083-1-git-send-email-alexandru.damian@intel.com>
References: <1394631711-1083-1-git-send-email-alexandru.damian@intel.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Wed, 12 Mar 2014 16:06:23 +0000
Message-ID: <CAJTo0LY3oh5S2w1QxsGWBuYf1OUJbUBtakOWDGvRHVtafzYDvQ@mail.gmail.com>
To: Alex DAMIAN <alexandru.damian@intel.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 1/1] toaster: fix timezone detection
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
X-List-Received-Date: Wed, 12 Mar 2014 16:06:47 -0000
Content-Type: text/plain; charset=UTF-8

On 12 March 2014 13:41, Alex DAMIAN <alexandru.damian@intel.com> wrote:
> This patch replaces faulty timezone detection with a version
> that simply reads the TZ environment variable if it is set.

My Debian system doesn't have a TZ environment variable but does have
/etc/localtime which is the current timezone data. Yes, determining
the local timezone is a pain.  :)

Ross

