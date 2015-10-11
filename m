Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id A9BA3760F4
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 11 Oct 2015 07:08:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t9B78B5O013095; Sun, 11 Oct 2015 08:08:11 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id fv3T_HWFAB5Y; Sun, 11 Oct 2015 08:08:11 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t9B77mE4013081
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 11 Oct 2015 08:08:05 +0100
Message-ID: <1444547267.14364.7.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Ed Bartosh <ed.bartosh@linux.intel.com>, "Smith, Elliot"
	<elliot.smith@intel.com>
Date: Sun, 11 Oct 2015 08:07:47 +0100
In-Reply-To: <e8ec343ddc6f66086080398f325e058d656b9516.1444213003.git.ed.bartosh@linux.intel.com>
References: <cover.1444213003.git.ed.bartosh@linux.intel.com>
	<e8ec343ddc6f66086080398f325e058d656b9516.1444213003.git.ed.bartosh@linux.intel.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/2] toaster: Manually retrieve log file location from filesystem
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
X-List-Received-Date: Sun, 11 Oct 2015 07:08:18 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2015-10-07 at 13:20 +0300, Ed Bartosh wrote:
> From: Elliot Smith <elliot.smith@intel.com>
> 
> The log file location reported by the BB_CONSOLELOG variable
> does not point to the log location for the current build at
> the time when the BuildStarted event is fired. It
> actually points to the location where the next build will
> log to. This means that the log file paths associated with
> a build in the cooker_log_path field are incorrect, with
> the result that the "Download build log" button doesn't work.
> 
> Instead, when a build starts, get the latest-dated log file
> and associate it with the build.
> 
> An issue explaining why this is a problem, plus steps to
> demonstrate it:
> https://bugzilla.yoctoproject.org/show_bug.cgi?id=8411

Rather than some of the proposed workarounds, I'd rather like to try and
fix this properly. I've put some quick analysis into the above bug and I
think it shouldn't be too difficult to fix. If anyone wants to test and
send a patch I'd be more than happy for that as I'm travelling at the
moment (doing this form the airport) but I'll try and take a look later
today if I get the change.

Cheers,

Richard


