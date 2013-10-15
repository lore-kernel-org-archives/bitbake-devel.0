Return-Path: <chmorgan@gmail.com>
Received: from mail-ie0-f181.google.com (mail-ie0-f181.google.com
	[209.85.223.181])
	by mail.openembedded.org (Postfix) with ESMTP id 1E6EF6CABC
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 Oct 2013 12:18:04 +0000 (UTC)
Received: by mail-ie0-f181.google.com with SMTP id ar20so5053176iec.40
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 Oct 2013 05:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type;
	bh=ev/jf5A/8RdS3ep310DO7CaERy9xmsflbRFQYxheUy4=;
	b=0t++Pw25OMOx0NiPUCq1rGT6a1I7gDLXgzNPtfwdd+1un0HOaoCYiyNjW32Yq6kbmF
	9YmZUTdlW7qug5T8bZ2kdYpjUCILmQgp8SVStQSVTUWGP5rM5bldhPr7oG26rs1mhB69
	XzVa1UGUA8//z/BAThaQqHUTUwlKcSOt79duWx2PLJHhSgjPHLWoqGr8v2pv0XdfqnHq
	+K4my0qh6ne0TO2AzJvFn+yijLEW/NLnfKCq+35fNt5qD3hUcupxWYO9d3Nhluq/B+FM
	5Zf/HuL0PaZEyU1LvBZdu0zBK1ICEsslDA3eMhJpx49QMGkGH5Kb079i2s+k7mSZ9ouH
	DDkQ==
X-Received: by 10.50.25.129 with SMTP id c1mr17014666igg.23.1381839485702;
	Tue, 15 Oct 2013 05:18:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.143.195 with HTTP; Tue, 15 Oct 2013 05:17:45 -0700 (PDT)
In-Reply-To: <CALmOhgmJVjqnhUvQn=5hk3ZaM6r42PYWa+A2Xve34v6fEdc94w@mail.gmail.com>
References: <CAAPegz09fP8ppysRS_opbSxv6nLknfd4NUnyVmgqzMNcu7+zmg@mail.gmail.com>
	<CALmOhgmJVjqnhUvQn=5hk3ZaM6r42PYWa+A2Xve34v6fEdc94w@mail.gmail.com>
From: Chris Morgan <chmorgan@gmail.com>
Date: Tue, 15 Oct 2013 08:17:45 -0400
Message-ID: <CAAPegz10UN90-vCTT9+OiiniJ6OXZ2ADw+NMd1HEFfCqnDLmuA@mail.gmail.com>
To: Trevor Woerner <trevor.woerner@linaro.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Bitbake for native x86 project?
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
X-List-Received-Date: Tue, 15 Oct 2013 12:18:05 -0000
Content-Type: text/plain; charset=ISO-8859-1

>Chris,
>
>Are all of your developers working on creating the target's kernel,
>rootfs, and/or bootloader? If most of the developers are only doing
>target, user-space, application development then all they need is an
>appropriate SDK (which only needs to be generated whenever any target
>packages change). This means a huge build only needs to be done once,
>and then everyone can use the results. In this scenario a
>network-shared sstate can still be employed for further build-time
>savings.

I suspect that we could get away with the appropriate sdk. I can see
how this would work for the cross-compilation process, with an arm
sdk, but if we had an x86-64 sdk for running things natively I'm not
sure the libraries would be in sync enough for the applications to run
on the developer's Linux machines. I'm thinking a mismatch in any
library would prevent the executables from being run without going
through the qemu approach.

I can certainly see that there is a path forward though and thank you
for brining up the sdk idea. I had read about that but haven't gotten
to trying it or trying to figure out where it best fits yet.

Chris

