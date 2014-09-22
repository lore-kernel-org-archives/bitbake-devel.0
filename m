Return-Path: <ross.burton@intel.com>
Received: from mail-qc0-f176.google.com (mail-qc0-f176.google.com
	[209.85.216.176])
	by mail.openembedded.org (Postfix) with ESMTP id 40BDC60703
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Sep 2014 16:16:20 +0000 (UTC)
Received: by mail-qc0-f176.google.com with SMTP id o8so325557qcw.21
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Sep 2014 09:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=+5WjY6yqtkbh6XajHSiWedVpsD3Q7KTyzJp6tNQH8Xs=;
	b=K3JxkRwsKsrkFFLHvpAuXOZiDfo/p/cbi4YijBc9pQ05M5klz3Y4xhPaLxJjMUDoRh
	IsSiMi561mmNlYrUPKXfuYhbWUcBZNCe2QWePpHaEE72Xa6xvjko4chrd2DQrkc7ZgRE
	5UJd/o2PcQU2mN7dB5MzYOdBlZ2xVaA6j5Ocf6PQ8dlMqxrt+wlbqKDUCVq/whJ/XmQ/
	7fQdwBjbcyiJWhwCgtDf6WNmOzoTfQbf0s944t9DgWqjbKnS/CuSI4Z3Ymm2em2/CSC2
	m3EucCZOQgtuV6Au2ljNcbu720B1tkuYlg3Bujcux1iELqT5Ihp74PjcrYaCtgCZn1/M
	IhQA==
X-Gm-Message-State: ALoCoQn5sFl1xmajDMugqnGZbV2eQ48RN87aRfmPaeiARHMyIBsH3Wh4ZV32ABy5gJVkAzRuK6M2
X-Received: by 10.140.40.84 with SMTP id w78mr10496200qgw.87.1411402581800;
	Mon, 22 Sep 2014 09:16:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.34.180 with HTTP; Mon, 22 Sep 2014 09:16:01 -0700 (PDT)
In-Reply-To: <54203B56.5030607@sonatest.com>
References: <54203B56.5030607@sonatest.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Mon, 22 Sep 2014 17:16:01 +0100
Message-ID: <CAJTo0LYScX=1iJDcxy1ff_TBR6ueJOQ-7Twcbdy-kBQsCBfLvQ@mail.gmail.com>
To: Olivier Dugas <dugaso@sonatest.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: Bitbake do_unpack checksum?
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
X-List-Received-Date: Mon, 22 Sep 2014 16:16:23 -0000
Content-Type: text/plain; charset=UTF-8

On 22 September 2014 16:08, Olivier Dugas <dugaso@sonatest.com> wrote:
> Now, my question : Would it be hard to bitbake's contributors to add a
> checksum validation during the do_unpack step? Hard-drive errors like this
> can occur, and such above-mentionned pain would be so easily avoided by a
> quick checksum...

No, it wouldn't be hard.

https://bugzilla.yoctoproject.org/show_bug.cgi?id=5571

Ross

