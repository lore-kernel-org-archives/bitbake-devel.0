Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id D0A0D72A78
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 19 Sep 2015 10:33:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t8JAXR5h008462; Sat, 19 Sep 2015 11:33:27 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id DhlYK_O99oLw; Sat, 19 Sep 2015 11:33:27 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t8JAXGGF008445
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sat, 19 Sep 2015 11:33:27 +0100
Message-ID: <1442658796.12435.119.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Smith, Elliot" <elliot.smith@intel.com>
Date: Sat, 19 Sep 2015 11:33:16 +0100
In-Reply-To: <CA+1hgUhMZAr9F0Kv-8v3d5g7XDeT16sTtxrjFuXr5jGAbK=EiQ@mail.gmail.com>
References: <1390b2ab0a882e6f11ef295ada26edcf226ba8dc.1441904599.git.avery.brian@gmail.com>
	<fa4a3965a75c8b3c659d7bdce1f5949a2f6f046b.1441904599.git.avery.brian@gmail.com>
	<1442437842.26666.179.camel@linuxfoundation.org>
	<CA+1hgUhMZAr9F0Kv-8v3d5g7XDeT16sTtxrjFuXr5jGAbK=EiQ@mail.gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 2/5] toaster: Add tests for /project/X/builds page
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
X-List-Received-Date: Sat, 19 Sep 2015 10:33:35 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2015-09-17 at 09:09 +0100, Smith, Elliot wrote:

> The branch is:
> elliot/toaster/hide_builds-8236
>
> I just rebased it on poky master.

I'm guessing the problematic patch was in master-next at the time so the
rebase didn't help, I still hit the merge issue.

Anyhow, it was a simple enough fix so I resolved and merged it, thanks.

Cheers,

Richard



