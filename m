Return-Path: <avery.brian@gmail.com>
Received: from mail-io0-f170.google.com (mail-io0-f170.google.com
	[209.85.223.170])
	by mail.openembedded.org (Postfix) with ESMTP id 7236965CBC
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Sep 2015 05:28:51 +0000 (UTC)
Received: by iofh134 with SMTP id h134so199570005iof.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Sep 2015 22:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=ycd/5hQBpIqVQJSuwJwwrE6hxRAKnpI/kSFvpFUoztA=;
	b=DMeEQNeI7uSD1vOH2VqNpPLNv2IA7T1419JkH4tfj7bwpzIL2mqr8JKG/4uz63lN5q
	PXTrZqKZNsJG5+H4Ubo41TmBcGeJ6SuZ1Nfq9U7Gr8KEfi7gxTRbKc81GkBV+CxtYbL8
	n5oPkl7XZV5M0ITrf6TMoHHDA5nPj2ItynmvzvdThj1VACW+YCl5sX7sbwDJFuHUlwBu
	RZTLI//TLTq8ODsQLjigGwyK+Q0Z5z7VFDwkhV/fkWwazCyjPNMb6GsIEEZnGdMWGcYV
	j4cDq/Ttw/edf1pxjb5ARguwMXAnU3TuEhcRA6ipiMLvKjZHxtvS0pdlp1SeBi8mRH++
	sUkw==
MIME-Version: 1.0
X-Received: by 10.107.40.12 with SMTP id o12mr23646383ioo.84.1443504531816;
	Mon, 28 Sep 2015 22:28:51 -0700 (PDT)
Received: by 10.64.155.36 with HTTP; Mon, 28 Sep 2015 22:28:51 -0700 (PDT)
In-Reply-To: <cover.1443090607.git.elliot.smith@intel.com>
References: <cover.1443090607.git.elliot.smith@intel.com>
Date: Mon, 28 Sep 2015 22:28:51 -0700
Message-ID: <CAKV_0eikpDSxt+w-cPz5C=O7gtA1qaECfej76hzpkD4jcwjmFQ@mail.gmail.com>
From: Brian Avery <avery.brian@gmail.com>
To: Elliot Smith <elliot.smith@intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/2] small improvements to startup, upgrade to latest Django 1.6
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
X-List-Received-Date: Tue, 29 Sep 2015 05:28:54 -0000
Content-Type: text/plain; charset=UTF-8

this patch contains a typo. I'll resubmit.
-b

On Thu, Sep 24, 2015 at 3:31 AM, Elliot Smith <elliot.smith@intel.com> wrote:
> This eliminates the question about making a superuser on startup in managed mode.
> It also uses the value of WEB_PORT if defined in analysis mode.
> It upgrades requirements.txt to the latest Django 1.6 (which I've been running for a while).
>
> The following changes since commit 9f66aa1a11b5b45280aa41bf4517ec56ee5f2ab2:
>
>   bitbake: toaster: start script warning text formatting small improvement (2015-09-23 22:44:56 +0100)
>
> are available in the git repository at:
>
>   git://git.yoctoproject.org/poky-contrib elliot/submit/bavery/toaster/small-script-improvement
>   http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=elliot/submit/bavery/toaster/small-script-improvement
>
> brian avery (2):
>   toaster: small improvements to the startup script
>   toaster: change requirements.txt to get the latest 1.6 django version
>
>  bin/toaster              | 12 ++++++------
>  toaster-requirements.txt |  2 +-
>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> --
> 1.9.3
>
> ---------------------------------------------------------------------
> Intel Corporation (UK) Limited
> Registered No. 1134945 (England)
> Registered Office: Pipers Way, Swindon SN3 1RJ
> VAT No: 860 2173 47
>
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
>

