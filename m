Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 20C0877CA1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Apr 2017 11:34:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTP id v3BBXttg005160; 
	Tue, 11 Apr 2017 12:34:09 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id wlP8jh4An8tP; Tue, 11 Apr 2017 12:34:09 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v3BBVr13005066
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Tue, 11 Apr 2017 12:31:55 +0100
Message-ID: <1491910313.12091.13.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: David Reyna <david.reyna@windriver.com>,
	bitbake-devel@lists.openembedded.org
Date: Tue, 11 Apr 2017 12:31:53 +0100
In-Reply-To: <07c4805b646e9c2ff9d9f75febdabcf1c4c3a485.1491800468.git.David.Reyna@windriver.com>
References: <cover.1491800468.git.David.Reyna@windriver.com>
	<07c4805b646e9c2ff9d9f75febdabcf1c4c3a485.1491800468.git.David.Reyna@windriver.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Subject: Re: [PATCH 1/1] toaster: fix SDK artifact capture
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
X-List-Received-Date: Tue, 11 Apr 2017 11:34:09 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Sun, 2017-04-09 at 22:07 -0700, David Reyna wrote:
> From: David Reyna <David.Reyna@windriver.com>
> 
> Use the TaskArtifacts event to scan the SDK and ESDK manifests
> to cleanly collect the respective artifact files.
> 
> The previous method was broken when the SDK file deployment moved
> from the do_populate_sdk[_ext] tasks to their sstate tasks. That
> method is disabled (but not yet removed) in preparation for the
> rest of refactor work for the parent #10283 work.
> 
> [YOCTO #10850]
> 
> Signed-off-by: David Reyna <David.Reyna@windriver.com>
> ---
>  bitbake/lib/bb/ui/buildinfohelper.py | 30
> ++++++++++++++++++++++++++++++
>  bitbake/lib/bb/ui/toasterui.py       |  4 +---
>  meta/classes/toaster.bbclass         | 21 ++++++++++++++++-----
>  3 files changed, 47 insertions(+), 8 deletions(-)

This isn't really in the right format, the patches against
toaster.bbclass needs to be sent separately to OE-Core since its in a
separate repository.

I've sorted this out and merged it as we're close to release builds and
I appreciate this needed fixing, please just keep it in mind next time,
thanks!

Richard

