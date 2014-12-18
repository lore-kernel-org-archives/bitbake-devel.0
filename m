Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id F2B2072795
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Dec 2014 10:29:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	sBIASrt4013011; Thu, 18 Dec 2014 10:29:01 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id KiMrnsyRKPCJ; Thu, 18 Dec 2014 10:29:01 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	sBIASnHO012989
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 18 Dec 2014 10:29:00 GMT
Message-ID: <1418898565.5106.19.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Richard Tollerton <rich.tollerton@ni.com>
Date: Thu, 18 Dec 2014 10:29:25 +0000
In-Reply-To: <1418865078-10484-1-git-send-email-rich.tollerton@ni.com>
References: <1418865078-10484-1-git-send-email-rich.tollerton@ni.com>
X-Mailer: Evolution 3.12.7-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] data: Avoid attempting to assign readonly shell vars
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
X-List-Received-Date: Thu, 18 Dec 2014 10:29:39 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2014-12-17 at 19:11 -0600, Richard Tollerton wrote:
> Attempting to set a read-only shell variable kills the shell. This is
> required POSIX behavior, it can't be disabled, and it's implemented by
> both dash and bash (although it seems to have only started happening in
> bash 4.3 and later, and only when run as /bin/sh).
> 
> This breaks `bitbake -c devshell` if bash 4.3 is installed, because
> BASHOPTS (and a boatload of other shell variables) are readonly.
> 
> The fix is to attempt to modify the variable in a subshell before doing
> the assignment.

Isn't this going to involve fork() calls for every single shell
variable? There must be a better way to do this?

Cheers,

Richard



